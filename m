Return-Path: <linux-kernel+bounces-871507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A43E5C0D84C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D3A3B2A3C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EF62FABE3;
	Mon, 27 Oct 2025 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGqhksdw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EDD34CDD
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567658; cv=none; b=XpQBYPDX8cfaAJSF0cxAp8oCZpQJf73V4wdY50C2zc7N7mXPGxWMWq5TJ73K9gDQ8YlDB4QRpeUW31JyJO5iOzXu7js2aSWaxHY7HBIPXRkBG+TpFAAyr0P77t6wll1HdOBgJ21KUqO5HNepTW0vwuJ81FAh2AzmQNTFkuioBtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567658; c=relaxed/simple;
	bh=8+SPhn7qqMJrmXX2oM/ERKmut/L/wxL9NKjHEeV08B8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pqPwVpJuFzwUsLs6JRhArR5kNBwngSGAI/E7Nz58x2GYhRlAdTDFppDwrDgpWmsgG1zXlbvXZ2OVV/cM0EjC7Em4jhcS0+dDcS0a3aJ1P5b9uTcQ0zk6fJirC36nRuKkD/DmoDuObYT+lTSooJu5vn5+xmKNj2m1Y0ubFOY2vCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGqhksdw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761567653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m8yw+KdoDk1+GlObHpWFGVZEPL4sfsRTgvMthBW335I=;
	b=YGqhksdwhiC4wvKzqTmK6M+zDtaj7MULdjCeB42++BYypeNNdmucbWYFe7MfZdaohvtrha
	4tE8x4tC6GndYc87FpClFprDT8k5C21jR2cbuYhCNkmm37sOnbDDrcF6r/rBnijmvaXz9s
	WGtGzEuJ7w+uQ1z15SDBi8j0lBQmR+M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-28da1pSANem8n77FDZpiKQ-1; Mon, 27 Oct 2025 08:20:52 -0400
X-MC-Unique: 28da1pSANem8n77FDZpiKQ-1
X-Mimecast-MFC-AGG-ID: 28da1pSANem8n77FDZpiKQ_1761567651
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471168953bdso43157095e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761567651; x=1762172451;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m8yw+KdoDk1+GlObHpWFGVZEPL4sfsRTgvMthBW335I=;
        b=DaXtSF1itrDvucBuRj77j42glUMxO3oJDOlpfPHYbh+fBCSAgQqL6M6JQoFkTIiy0P
         iZoHjeMOy7gRxY+f/K6fDzsi3kpadap6BATxtnZQm/qH1GPIMzaSgsioo8Gi5/UQMuwv
         ixxs/qq4hJXcRxbOuNKYQDFdulETsr6qSMZW4/opMGziGuRWT6YfhvRS/DQM1MEsx/om
         ly2fAPeLhQUBkbyzCLTjxabeScgEVaPaWZHvksaPiNBlkwhKwSpKMwyDVl2AB7s25JXd
         0qomSprd0HDsRWf7jqc13x0kxtUgNmZ0nhVFdn4hlwotCZwZuqwWQ0QhGckhSpsZO8YV
         AHAw==
X-Forwarded-Encrypted: i=1; AJvYcCUwSjWc/GezWkFOMKIgm/4Jh+CiIbVUH6979B0pUWWZUg7o51rYmWB11mF/qegVrCdNTSEcPBFkRq7eNr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7cRYJGHczLoIdTrBP+ZqklfNJeHUF9PqTCyy9Qj+dNFz8Z7NS
	/krfgdUwyUz/az4cc5hytcOrtYp7XxQDRwyq3j1jggu5CZp2Gi7bW/uRksNojPViutO9QQ9OHfq
	bzilHIzDIi1ZitPhInziioWFJ6KCs040TWBEQ5Q0gAdfpJ4tcJq7SZ9NSwyJ32qDlgdfr3pEWIu
	QA
X-Gm-Gg: ASbGncsxS2iQZK6sa9R1YQssqAqi1tvG8DhLFUdwSh0gSZkXaixOkYDBnr99t4n1i7D
	GejOwGjufp4Mpqkh4w8xPO6QIOO7pQei1eayqzjskmfQ9E8wqjdiXGPdvTGvVmPk+ziPKX3Nf+m
	WgKnvzppU+1VkdjdLdsxZ3vAgTLc8KBWcMtxOks2y6LdexYL9ikO2mL4cGs1nDRHZWMFoXWaX9Q
	2RJj88+hWZAgm91uHnWzFvxaJqdCfWC2uT3c+Nl4eSDp7/0Xe6cwYhWd70mA0/86JVv74Bj+7tf
	h+0OOw2FqUT20mbPHiWfI8352FAych61w/epGFYfShkclPAkXYbp25xmaEESk0/JVCQN8dSz0Ku
	Wbw0GWmV1cpz3BP5u79t/Hj8y
X-Received: by 2002:a05:600c:3b84:b0:477:c68:b4da with SMTP id 5b1f17b1804b1-4770c68b594mr44482245e9.20.1761567650865;
        Mon, 27 Oct 2025 05:20:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUHD5VEEMHXlx8Mtjq4Vh0L1doDEtzRU6V1VECOo/Fbuys+lVjtxXIKlXHDWL4p5T28mhLPg==
X-Received: by 2002:a05:600c:3b84:b0:477:c68:b4da with SMTP id 5b1f17b1804b1-4770c68b594mr44481995e9.20.1761567650452;
        Mon, 27 Oct 2025 05:20:50 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd02cd6dsm137827585e9.2.2025.10.27.05.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:20:50 -0700 (PDT)
Message-ID: <d23d133b52ef574d669f1656789b78d07c91c9f5.camel@redhat.com>
Subject: Re: [Question] Detecting Sleep-in-Atomic Context in PREEMPT_RT via
 RV (Runtime Verification) monitor rtapp:sleep
From: Gabriele Monaco <gmonaco@redhat.com>
To: Yunseong Kim <ysk@kzalloc.com>, Nam Cao <nam.cao@linaro.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tomas Glozar	
 <tglozar@redhat.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, Byungchul Park	
 <byungchul@sk.com>, syzkaller@googlegroups.com,
 linux-rt-devel@lists.linux.dev,  LKML <linux-kernel@vger.kernel.org>
Date: Mon, 27 Oct 2025 13:20:48 +0100
In-Reply-To: <32839fb6-dbcb-4c5c-9e3f-d46f27ae9a73@kzalloc.com>
References: <32839fb6-dbcb-4c5c-9e3f-d46f27ae9a73@kzalloc.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-27 at 15:54 +0900, Yunseong Kim wrote:
> Hi Nam,
>=20
> I've been very interested in RV (Runtime Verification) to proactively det=
ect
> "sleep in atomic" scenarios on PREEMPT_RT kernels. Specifically, I'm look=
ing
> for ways to find cases where sleeping spinlocks or memory allocations are=
 used
> within preemption-disabled or irq-disabled contexts. While searching for
> solutions, I discovered the RV subsystem.
>=20

Hi Yunseong,

I'm sure Nam can be more specific on this, but let me add my 2 cents here.

The sleep monitor doesn't really do what you want, its violations are real =
time
tasks (typically userspace tasks with RR/FIFO policies) sleeping in a way t=
hat
might incur latencies. For instance using non PI locks or imprecise sleep.

What you need here is to validate kernel code, RV was actually designed for
that, but there's currently no monitor that does what you want.

The closest thing I can think of is monitors like scpd and snep in the sche=
d
collection [1]. Those however won't catch what you need because they focus =
on
the preemption tracepoints and schedule, which works fine also in your scen=
ario.

We could add similar monitors to catch what you want though:

                     |
                     |
                     v
                   +-----------------+
                   |   cant_sleep    | <+
                   +-----------------+  |
                     |                  |
                     | preempt_enable   | preempt_disable
                     v                  |
    kmalloc                             |
    lock_acquire                        |
  +---------------      can_sleep       |
  |                                     |
  +-------------->                     -+

which would become slightly more complicated if considering irq enable/disa=
ble
too. This is a deterministic automaton representation (see [1] for examples=
),
you could use an LTL like sleep as well, I assume (needs a per-CPU monitor =
which
is not merged yet for LTL).

This is simplified but you can of course put conditions on what kind of
allocations and locks you're interested in.

Now this specific case would require lockdep for the definition of lock_acq=
uire
tracepoints. So I'm not sure how useful this monitor would be since lockdep=
 is
going to complain too. You could use contention tracepoints to catch exactl=
y
when sleep is going to occur and not /potential/ failures.

I only gave a quick thought on this, there may be better models/event fitti=
ng
your usecase, but I hope you get the idea.

[1] - https://docs.kernel.org/trace/rv/monitor_sched.html#monitor-scpd

> Here are my questions:
>=20
> 1. Does the rtapp:sleep monitor proactively detect scenarios that
> =C2=A0=C2=A0 could lead to sleeping in atomic context, perhaps before
> =C2=A0=C2=A0 CONFIG_DEBUG_ATOMIC_SLEEP (enabled) would trigger at the act=
ual point of
> =C2=A0=C2=A0 sleeping?

I guess I answered this already, but TL;DR no, you'd need a dedicated monit=
or.

> 2. Is there a way to enable this monitor (e.g., rtapp:sleep)
> =C2=A0=C2=A0 immediately as soon as the RV subsystem is loaded during boo=
t time?
> =C2=A0=C2=A0 (How to make this "default turn on"?)

Currently not, but you could probably use any sort of startup script to tur=
n it
on soon enough.

> 3. When a "violation detected" message occurs at runtime, is it
> =C2=A0=C2=A0 possible to get a call stack of the location that triggered =
the
> =C2=A0=C2=A0 violation? The panic reactor provides a full stack, but I'm
> =C2=A0=C2=A0 wondering if this is also possible with the printk reactor.

You can use ftrace and rely on error tracepoints instead of reactors. Each =
RV
violation triggers a tracepoint (e.g. error_sleep) and you can print a call
stack there. E.g.:

  echo stacktrace > /sys/kernel/tracing/events/rv/error_sleep/trigger

Here I use sleep as an example, but all monitors have their own error event=
s
(e.g. error_wwnr, error_snep, etc.).

Does this all look useful in your scenario?

Gabriele

>=20
> Here is some background on why I'm so interested in this topic:
>=20
> Recently, I was fuzzing the PREEMPT_RT kernel with syzkaller but ran into
> issues where fuzzing wouldn't proceed smoothly. It turned out to be a pro=
blem
> in the kcov USB API. This issue was fixed after I reported it, together
> with Sebastian=E2=80=99s patch.
>=20
> [PATCH] kcov, usb: Don't disable interrupts in kcov_remote_start_usb_soft=
irq()
> =C2=A0- https://lore.kernel.org/all/20250811082745.ycJqBXMs@linutronix.de=
/
>=20
> After this fix, syzkaller fuzzing ran well and was able to detect several
> runtime "sleep in atomic context" bugs:
>=20
> [PATCH] USB: gadget: dummy-hcd: Fix locking bug in RT-enabled kernels
> =C2=A0-
> https://lore.kernel.org/all/bb192ae2-4eee-48ee-981f-3efdbbd0d8f0@rowland.=
harvard.edu/
>=20
> [BUG] usbip: vhci: Sleeping function called from invalid context in
> vhci_urb_enqueue on PREEMPT_RT
> =C2=A0-
> https://lore.kernel.org/all/c6c17f0d-b71d-4a44-bcef-2b65e4d634f7@kzalloc.=
com/
>=20
> This led me to research ways to find these issues proactively at a
> static analysis level, and I created some regex and coccinelle scripts
> to detect them.
>=20
> [BUG] gfs2: sleeping lock in gfs2_quota_init() with preempt disabled
> on PREEMPT_RT
> =C2=A0- https://lore.kernel.org/all/20250812103808.3mIVpgs9@linutronix.de=
/t/#u
>=20
> [PATCH] md/raid5-ppl: Fix invalid context sleep in
> ppl_io_unit_finished() on PREEMPT_RT
> =C2=A0-
> https://lore.kernel.org/all/f2dbf110-e2a7-4101-b24c-0444f708fd4e@kernel.o=
rg/t/#u
>=20
> Tomas, the author of the rtlockscope project, also gave me some deep
> insights into this static analysis approach.
>=20
> Re: [WIP] coccinelle: rt: Add coccicheck on sleep in atomic context on
> PREEMPT_RT
> =C2=A0-
> https://lore.kernel.org/all/CAP4=3DnvTOE9W+6UtVZ5-5gAoYeEQE8g4cgG602FJDPe=
sNko-Bgw@mail.gmail.com/
>=20
>=20
> Thank you!
>=20
> Best regards,
> Yunseong Kim


