Return-Path: <linux-kernel+bounces-739569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6600BB0C802
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998763B24FD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8982DECAF;
	Mon, 21 Jul 2025 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ka3q2wTU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51172DECCD
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112952; cv=none; b=DshgqHokK0I98Y/9Bje4GSaCXlT4R0GN2yGeCTvYIXKs002nDO65tcJueiYZhH1kUeRQJvU7W2A5UbBtXwJFh9MKdFWwwtIgr6GQTUTOhvBjBITOSsDBbg0V/fqtSG5mhHBdxjNzTHLeXDXAIPZSadrYhhj2Ps/rEOJi8CqcBWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112952; c=relaxed/simple;
	bh=POrcf+RPRXp8K+I6Vss6WEdWtp5M6eqlG7yTLHztb0g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W1/uL/25SkKxqni1llC0xRTsk5N8mHELIqMX8x8G2SlAF3USRf7gPHTJ9mHtxZX0f/NMfFUc3nbdPY0fDmpEDWDSNGN3t3efSqNzIkaW6S8DfFdXJuSujezw0thKydHs6uurFgxsWbw3gzd/h4dAafqwbe0E2oK0I6gEuHnqPTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ka3q2wTU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753112948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=POrcf+RPRXp8K+I6Vss6WEdWtp5M6eqlG7yTLHztb0g=;
	b=Ka3q2wTUhSIruk8mtgUcUv0mQDC9zDBZOPbJ77hXrdb54v1J9Ds2IJP6c0cRxXsnBWqN4c
	mlOiUbAF6Sn5/nbVqfdYeyQMNf95j28elUGnE8is7NqP1hxu9rEhBQ/8unte90r15PqLv7
	AKfY/2knrSZ+mfDfwOKgtV+gV/pgb58=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-LMiMpdXEMBqEhc3pT-EIBw-1; Mon, 21 Jul 2025 11:49:06 -0400
X-MC-Unique: LMiMpdXEMBqEhc3pT-EIBw-1
X-Mimecast-MFC-AGG-ID: LMiMpdXEMBqEhc3pT-EIBw_1753112946
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-455eda09c57so31800255e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753112945; x=1753717745;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POrcf+RPRXp8K+I6Vss6WEdWtp5M6eqlG7yTLHztb0g=;
        b=KMYP1ewGpPCV82/XrsnZJC/BmXs5Vw3YBxb4d7pg/ZYzx0ce3o/TU4P6Iy7H59L+VJ
         YY8y+6sPJDdCPjNnlGpV8HHuRqoX1K1BnwurDBUGg6x4L3WBzejLqAW8heqlkyciRMI9
         ixrBkQzdyfk5P7+Xtx2h4Q1Itc3oEzEdTi+7XKPUQ+9mUcD+3NcOvrTWsMDM0V+YRGM9
         6i/OXmdjwhGL43MCC7FGc01gq5EIzK8C7YmGCiezAXX2ef1RxWHPvfgxkGVwmlMRqYJT
         /JSbT9TcqMhe4EvgspkQrS9vNwH1I8PxlRkwpyyOPBrrGEM3uMAFv10D6FF4n9u8rHwJ
         e5aA==
X-Forwarded-Encrypted: i=1; AJvYcCXA95zKSgEQvXmKscB1ltMKrtu/ghGct9g1KpYzQ6JRd0OZPWwLkEqxfwmLHEgVPObw0x9m7sLamBaxvsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE8YsNrEJxgbLAg4YXCwbU4hOGPbZry/N96T85UsFeM7Vu2e3c
	mcWsoZcoVW4jE5V4z7W7HUufbQDWPJXI/MOU9wtHzwXJA/ysBnFnfTRtL5DOsYN6RPB9A2FSgzs
	8aY6BbRgjdGJvKWqV9K/dFPiEf7Co7DvxoWJoO6mlx9cihpGW1/dezzP5OJHcp3u5ow==
X-Gm-Gg: ASbGncsQf/Knrf7OCYyiLgjR8RoPkKsry84JuA329onOHJfKdiZTY36kd3IBcEkvCjQ
	Fv+b+q/xGg/LfbNxm8U2kSm22VSoPZ6EtJsD0Geyqtd3yc/etQ96Oux3ZxD64ON2mkDQ/a5JNd3
	J3A6WsY+OmDcZh7HsiGCaTp+2WsDPeVLvpVH7lSNZb+urADw3wBsl3H+U61KnlDuCf6G+SpLae9
	RB2qGVnOTbMNTa09QDyp2UFKa0nQ7JbfLmNCQ4nLARvk+0FtVf22SfuZxGaegV9Ojy+UbnVpUHQ
	cgzMVdgAUrpVIPy1pMikvzWU7p/QxmU1SFIAOVSJDl6tZBo+4sTcY+xJXyfWZ4T8Vw==
X-Received: by 2002:a05:600c:3f09:b0:456:2d06:618a with SMTP id 5b1f17b1804b1-4562e38aab0mr179789935e9.18.1753112945466;
        Mon, 21 Jul 2025 08:49:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIFWo3B2GOS//BnnNmJIYALEj7XiYgiNuybauiYRbDvMNgRDKwifmEKsxQzLiJICQqZvTHsQ==
X-Received: by 2002:a05:600c:3f09:b0:456:2d06:618a with SMTP id 5b1f17b1804b1-4562e38aab0mr179789745e9.18.1753112945009;
        Mon, 21 Jul 2025 08:49:05 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d581sm10692443f8f.64.2025.07.21.08.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 08:49:04 -0700 (PDT)
Message-ID: <eabfae8b0f29c88437cc51af21797e869d99aef6.camel@redhat.com>
Subject: Re: [PATCH 4/6] rv: Remove rv_reactor's reference counter
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2025 17:49:02 +0200
In-Reply-To: <20250721140425.OeD16I4D@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
	 <4ebe4d49e07890eadae41da233e111f8723fba12.1753091084.git.namcao@linutronix.de>
	 <2de814842fbbeee888e076db2f80bf2028fdbb0d.camel@redhat.com>
	 <20250721140425.OeD16I4D@linutronix.de>
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



On Mon, 2025-07-21 at 16:04 +0200, Nam Cao wrote:
> On Mon, Jul 21, 2025 at 03:20:44PM +0200, Gabriele Monaco wrote:
> > Mmh, I'm not understanding how, let's assume I create a custom
> > reactor
> > as a kernel module and I want to use it on existing models (built
> > in or
> > modules themselves), I'd do.
> >=20
> > =C2=A0insmod myreactor
> > =C2=A0echo myreactor > mymodel/reactors
> > =C2=A0rmmod myreactor
> > =C2=A0## I want this one to fail because the reactor is in use
> >=20
> > =C2=A0echo nop > mymodel/reactors
> > =C2=A0rmmod myreactor
> > =C2=A0# now it can succeed
> >=20
> > How is MODULE_SOFTDEP helping in this scenario?
> > Am I missing something here?
>=20
> You are right, MODULE_SOFTDEP does not help this use case.
>=20
> I did a quick search, it seems try_module_get() and module_put() are
> what we need for this. Let me amend the commit message.
>=20

I wasn't aware of it, then sure we should be using that.

> But my essential point in this patch is that, the current ref count
> implementation does not work. Furthermore, we should use the
> centralized kernel module's facilities, not implementing our own
> custom logic.
>=20

Yeah I get your point. If I understand you correctly, what's broken is
that we just return EBUSY and ignore that on __exit instead of doing
something about it (set nop to all monitors using this reactor).

I wonder if we shouldn't also fix this (using the module refcount).
But that can be done in the future, I'm not even sure reactors as
modules currently work.

Also, I'd need to verify this but depending on the order of exit
functions, we might be seeing the same problems with built-in reactors
when active on shutdown. I'm going to play a bit with this and see if
this workaround of not deleting the reactor was introduced for that (I
doubt though).

Thanks,
Gabriele


