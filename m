Return-Path: <linux-kernel+bounces-757424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3602B1C1F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01B8F7A2923
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6437121859A;
	Wed,  6 Aug 2025 08:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYgh6fsI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F451C84C0
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754468156; cv=none; b=FzvrGy6aOUOWSd2ZssHfXmve05OZLlFYZuWoqcZlzQj2IgwWDs4E31azHEkuKKC7MO/qLlSdeQMNXdd9FXEvFbz97U0CdS2hksQUODSuhqgLalYKDE/PtMwHpolcGKKTs5KD4jJxUlqRc+tKDFBb5p0bkWCvOggE49ND+ej05HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754468156; c=relaxed/simple;
	bh=vz+O67ZmYFtvXdJYmoPG7qzJo6UZM5Sp0FTBRdANHYQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GJy1f/SoK0kgcoaUx0mMqpF+E93DtPxYQWqTyXk1fltkzRC4HWpA25/IjOFGBTTERXooi+kIY5hl5QchufSZhxPVKUuTkzgSv/naF252ejjjdrcjEe1dICyJP21rjg0m+sHNDPBvQlVs8aI1vkXGlTBp0N55AvhQwmk+/fwSzI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYgh6fsI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754468153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lhM9xOQimaRmPvynN2QJcit/7aVh+anT1n0vb1zuRIk=;
	b=CYgh6fsIoEDOzUO5yOC2i57szCa9q3bPENdK8dAyEIZZFQ6IXec0LfjkSkOsmomPYjOP3s
	4Z/qewBgfgtHg/HGKhFYQ6rg/4bZC07HB4dRxwEKKCekL8SDam4HZ+wKQQdCSuaQRTIjbw
	6bueAfb85I1GjyDVtit2X4WE4l9C9y8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-ns2WhFUCOTq2P32MaIcbtg-1; Wed, 06 Aug 2025 04:15:52 -0400
X-MC-Unique: ns2WhFUCOTq2P32MaIcbtg-1
X-Mimecast-MFC-AGG-ID: ns2WhFUCOTq2P32MaIcbtg_1754468151
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-458f710f364so20016265e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 01:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754468151; x=1755072951;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhM9xOQimaRmPvynN2QJcit/7aVh+anT1n0vb1zuRIk=;
        b=T+WYULP6IwYCmQU3igmBzchcOM5JfLUZo7/JpXWvIo71poCEV0DmZfk9tng1Xiw8nT
         9O3mmL3OIinUyWLsV2dsx1s58Gl9ircwwXm2Z9g1RC4/8esBzzdCNRBNRh8Jy8Aff3N5
         EdPTa6ebDvHXaKkWzu0/sTP60R08UHAgHZyfUd/XkhCu9FQHiLQY5UzTn6VPrXwIN245
         POI1TyVE6LCs4sI5lSzBETv4cZ557HTkXNLb0ZU5DzJa/EjMFcL9H+7SkvIvlUTp22oY
         GW/apvljJdFuvNGTHTytPv2Klrib4Ugk7abDbVqu+DQLbDT1/pQDk+ITYLknhp7WpDl6
         tn8g==
X-Forwarded-Encrypted: i=1; AJvYcCVlIfSC75LVtbxTOYuRJIShmbj1i2rHhigWXwHUEWdFBBEG3gjqGiMq/ql15yJR+tQ8KC2OPZ9DMK/O+SI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaxsx/HDNxmE2bTzopnD1LWo3BeefcgzVLOMvlPE8AbjoLk/Q4
	JjAuSmB8/op24oonCBA941t/WifXjhMY4Vvlb1Iu0hsGVqFRrwlOzLmFsq3j3ZoScqHymT2cjlA
	mae3OoSatJIKc+rVzVd3EMkwZLGbEY/Gq7ACBujkh9bwIXJyRI9FR7OvSFU2rY2ZQrXuBfH8yrr
	+Y
X-Gm-Gg: ASbGnctC+txUAx4iglyGjROdHnky70yDPzfiKNC0imfGhmNp15YiFCd4yYJZSyBLZ3k
	B6yl3kQUTXt/xzUphRmxBDH7Ufr0TVscikzWBvLH4T7EvZwL5X0I9u6iB7nzZa2JvWLbLvX7364
	NdfsdNVS+6i1XoOdUzVsAV47qU4wKmFBySpsal7G1VljdzDkH9M64cL9UFYx6SvqP6sojri6eQl
	6uo+kfioKzxFkJGWp8k085ui0AQ1SShKXKwOvfYMRXiQv/amGiAUcxKBYtSu0JiyAwZwxMGA0d7
	3CHrHU2iUqTtOaQAyKvERPUDbnjr6Ge/GSVLCCMv+0x5RBVEtnH2IBbD5ZM/LwoaWA==
X-Received: by 2002:a05:600c:450e:b0:456:1006:5418 with SMTP id 5b1f17b1804b1-459e7089870mr17345975e9.13.1754468151230;
        Wed, 06 Aug 2025 01:15:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJwdNcjJoVypBzS/E0W0QaV4Mh53JQzXCjPyCpue0GuL82XdUNCr1X0+QGiaVe3Jo1xns1xQ==
X-Received: by 2002:a05:600c:450e:b0:456:1006:5418 with SMTP id 5b1f17b1804b1-459e7089870mr17345535e9.13.1754468150751;
        Wed, 06 Aug 2025 01:15:50 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e79ef4c8sm18937515e9.6.2025.08.06.01.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 01:15:50 -0700 (PDT)
Message-ID: <1ddbe4c89a12c6282fa6db19c4649b90ab2fcf9d.camel@redhat.com>
Subject: Re: [PATCH 5/5] rv: Add rts monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 06 Aug 2025 10:15:48 +0200
In-Reply-To: <20250805154515.CchJtec3@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
	 <20834b8fcd4dfe75642cec2097e29f4c636a33fb.1753879295.git.namcao@linutronix.de>
	 <b3499e8d79c2215b4fb765c0ceb5294f322efa3a.camel@redhat.com>
	 <20250805122215.hXbwUchz@linutronix.de>
	 <20250805154515.CchJtec3@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-05 at 17:45 +0200, Nam Cao wrote:
> On Tue, Aug 05, 2025 at 02:22:17PM +0200, Nam Cao wrote:
> > On Tue, Aug 05, 2025 at 10:40:30AM +0200, Gabriele Monaco wrote:
> > > Hello Nam,
> > >=20
> > > I just built and booted up the monitor in a VM (virtme-ng), the
> > > configuration has preemptirq tracepoints and all monitors so far
> > > (as we
> > > have seen earlier, it doesn't build if rtapp monitors are not
> > > there
> > > because of the circular dependency in the tracepoints).
> > >=20
> > > All I did was to enable the monitor and printk reactor, but I get
> > > a
> > > whole lot of errors (as in, I need to quit the VM for it to
> > > stop):
> > >=20
> > > [ 1537.699834] rv: rts: 7: violation detected
> > > [ 1537.699930] rv: rts: 3: violation detected
> > > [ 1537.701827] rv: rts: 6: violation detected
> > > [ 1537.704894] rv: rts: 0: violation detected
> > > [ 1537.704925] rv: rts: 0: violation detected
> > > [ 1537.704988] rv: rts: 3: violation detected
> > > [ 1537.705019] rv: rts: 3: violation detected
> > > [ 1537.705998] rv: rts: 0: violation detected
> > > [ 1537.706024] rv: rts: 0: violation detected
> > > [ 1537.709875] rv: rts: 6: violation detected
> > > [ 1537.709921] rv: rts: 6: violation detected
> > > [ 1537.711241] rv: rts: 6: violation detected
> > >=20
> > > Curiously enough, I only see those CPUs (0, 3, 6 and 7).
> > > Other runs have different CPUs but always a small subset (e.g.
> > > 10-15,
> > > 6-7=C2=A0only 2).
> > > It doesn't always occur but enabling/disabling the monitor might
> > > help
> > > triggering it.
> > >=20
> > > Any idea what is happening?
>=20
> There are two issues:
>=20
> =C2=A0 - When the monitor is disabled then enabled, the number of queued
> task does not reset. The monitor may mistakenly thinks there are
> queued RT tasks, but there aren't.
>=20
> =C2=A0 - The enqueue tracepoint is registered before the dequeue
> tracepoint.
> =C2=A0=C2=A0=C2=A0 Therefore there may be a enqueue followed by a dequeue=
, but the
> monitor missed the latter.
>=20
> The first issue can be fixed by reseting the queued task number at
> enabling.

Mmh good catch, indeed you have a counter separated from the LTL thing
here.

>=20
> For the second issue, LTL monitors need something similar to
> da_monitor_enabled_##name(void). But a quick workaround is reordering
> the tracepoint registerations.

I didn't make it on time before your V2, I assume you solved already so
you might ignore this.

You kinda have something like the da_monitor_enabled: the
rv_ltl_all_atoms_known

I wonder if you could define LTL_RT_TASK_ENQUEUED only when you
actually know it (or are reasonably sure based on your internal
counter). Or at least not set all atoms until the monitor is fully set
up.

Anyway reordering the tracepoints registration is likely necessary
whatever you do, but I'm afraid a problem like this can occur pretty
often with this type of monitors.

Thanks,
Gabriele

>=20
> So with the below diff, I no longer see the issue.
>=20
> Thanks again for noticing this!
>=20
> Nam
>=20
> diff --git a/kernel/trace/rv/monitors/rts/rts.c
> b/kernel/trace/rv/monitors/rts/rts.c
> index 473004b673c5..3ddbf09db0dd 100644
> --- a/kernel/trace/rv/monitors/rts/rts.c
> +++ b/kernel/trace/rv/monitors/rts/rts.c
> @@ -81,14 +81,21 @@ static void handle_sched_switch(void *data, bool
> preempt, struct task_struct *pr
> =C2=A0
> =C2=A0static int enable_rts(void)
> =C2=A0{
> +	unsigned int cpu;
> =C2=A0	int retval;
> =C2=A0
> =C2=A0	retval =3D ltl_monitor_init();
> =C2=A0	if (retval)
> =C2=A0		return retval;
> =C2=A0
> -	rv_attach_trace_probe("rts", enqueue_task_rt_tp,
> handle_enqueue_task_rt);
> +	for_each_possible_cpu(cpu) {
> +		unsigned int *queued =3D per_cpu_ptr(&nr_queued, cpu);
> +
> +		*queued =3D 0;
> +	}
> +
> =C2=A0	rv_attach_trace_probe("rts", dequeue_task_rt_tp,
> handle_dequeue_task_rt);
> +	rv_attach_trace_probe("rts", enqueue_task_rt_tp,
> handle_enqueue_task_rt);
> =C2=A0	rv_attach_trace_probe("rts", sched_switch,
> handle_sched_switch);
> =C2=A0
> =C2=A0	return 0;


