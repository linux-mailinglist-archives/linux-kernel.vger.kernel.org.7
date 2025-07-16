Return-Path: <linux-kernel+bounces-733267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC25B07265
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6763916A6FE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E3254F81;
	Wed, 16 Jul 2025 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6qUjVCW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64379239086
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660032; cv=none; b=B4eVQLsDS6OwT3pfsy/rWXRdTXCCm+KecZfZd5gWx8aYih48TJ4d3tQvTJ68YWDk29Asi66QuiKkt69gH6+Gi1SPbu3rdh0WiKkQNQb/kIcQY4tjlOQAH/NR9ESAFjU3grC9reoqum7y2u+EufMUSZIUcMgm4OU5/Mu6Wq5XmRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660032; c=relaxed/simple;
	bh=GHlX23A7Hvn+p5ZNPSjNs+wmfu94EHZOaRggXGBJYNU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r7x/URMx/jUX2jm3JQ4hp4BN/gnDsTrmuIwWasM90jih20hNZm+9MKzhG4btssNohk162hzTVAAQUDGIhbjmfhiN4kdCg8qvkHGKIunZ41tIbsrSXaVbyq2k4+oW3Wa+lBEA85DFc4B2RuqmaI9zhZBOl1VwJgafgGUxloKEoGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D6qUjVCW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752660029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c0eHc6+5H9SgZz4Xcjm6r2qNKf2VLwrklymOhya5fbw=;
	b=D6qUjVCWSM0XVI+D6HHqzbtE/WUrKSSrdGx0xzQjK3pp83oZU45N9tIon7BGKBNnBHx1jk
	jBMujGufD0Eu2I4ZU6eVJ8LUiq6jaK+jRUFJ0L/79ttVPpAZ/rbmSfMzQc3mzsLdTHR/UI
	1fl+uxDEu/NDazeOeKUI6Z5JSKWSDXc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-VlcgV_mfPkO01k23_4LzkQ-1; Wed, 16 Jul 2025 06:00:28 -0400
X-MC-Unique: VlcgV_mfPkO01k23_4LzkQ-1
X-Mimecast-MFC-AGG-ID: VlcgV_mfPkO01k23_4LzkQ_1752660027
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso4961055e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752660027; x=1753264827;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0eHc6+5H9SgZz4Xcjm6r2qNKf2VLwrklymOhya5fbw=;
        b=oFBZf2jm4rfqkif+ZAO48NhccdaL9XU94wYkNLj34awM9RtXmr/ISTyEMcKG2Kyjug
         C+zlo8mgyPRIoGJRqKqow2gnBqjh5Kd6f+P6klo6iooorLGJ/kTeqRJboAy+6ViLsUcf
         N10FU78q7spFKTQ2c7tn7LXNtQ4cC4SyXXWso4uCwTzGnhB7akMWhGjI/xbIjhaF7E1k
         aw++1P5xTbyZOhSyazG/NTE2iuHykvIpDLN0TO4x+z3Qubp+78VS+sZQwOJqeNhtJMOr
         rwsiKgN2vAI7mtBvv1e6BuKRlN9GLqCOxUm+1IIY2VpxXspfennqnKy/FRxMyE3c8ma+
         OIgw==
X-Gm-Message-State: AOJu0Yyt8o0LgVs26uVOej8oP9aAfQMAvhFirbjQhEAO5LUY1vWiLklo
	VpY68z/Z9eS+zpOkVyIKVSYEIc2JXv+6ULNFSXkkVZk6mdJBY/yqkjP83Wh75o74TjN1xFgmZ1+
	9Al+26cReKMG8G7emthbXWvH9I0n3cmFqQafOvFFfPA1gjgiKRUX26fgFhjhkVOOe8g==
X-Gm-Gg: ASbGncuXyMraiVlLdTl2QTqq810MMEFNO+N9NlL1ldWq8rZsbaPBI6EDPNZHoYCMnjo
	AjmQvuToohnj9vTAF8EggNZQs7xWlvhhWEDa5HYEJU8J8AymcSdefPnSNuea9i/Bl1zGBz0LDrH
	m87v8vCN+t0Zf9c8AsrWy8fkIp6nQR7P8+zX+zGsIWXWpjybP5iz89t2v78pYN7M/Bf6eFGtLaz
	IRWsC05y0Z1P8kG8HjPYOS4xTDRZxWTBc+fhVkQkKBFLfIjGnZseUQDONJ97BbHzjyzMYegiobm
	qpqerscW5zP/ODxqwvDnfb+gXnhbSnz8YmMzv+xMtFTkWdU342n/fG4B8EiyAm/1BQ==
X-Received: by 2002:a05:600c:2ad3:b0:456:15be:d113 with SMTP id 5b1f17b1804b1-45625e12572mr49088475e9.1.1752660026631;
        Wed, 16 Jul 2025 03:00:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIZgKfShCpN0AhUR7T0WU+hhCNt02vphv8/fP10yQjGMUW3uuMd1ZkzEMXXpDi1pz7gSrpXg==
X-Received: by 2002:a05:600c:2ad3:b0:456:15be:d113 with SMTP id 5b1f17b1804b1-45625e12572mr49088185e9.1.1752660026195;
        Wed, 16 Jul 2025 03:00:26 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc21e7sm17399303f8f.36.2025.07.16.03.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 03:00:25 -0700 (PDT)
Message-ID: <ecc8217af9ad8142abb73d6ef2fe9bdac9df6c95.camel@redhat.com>
Subject: Re: [PATCH v3 17/17] rv: Add opid per-cpu monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Tomas Glozar
	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark Williams
	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 12:00:24 +0200
In-Reply-To: <20250716093825.rWXnBtv5@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-18-gmonaco@redhat.com>
	 <20250716093825.rWXnBtv5@linutronix.de>
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



On Wed, 2025-07-16 at 11:38 +0200, Nam Cao wrote:
> On Tue, Jul 15, 2025 at 09:14:34AM +0200, Gabriele Monaco wrote:
> > diff --git a/kernel/trace/rv/monitors/nrp/Kconfig
> > b/kernel/trace/rv/monitors/nrp/Kconfig
> > index f37ff70e8d204..a175c430d351f 100644
> > --- a/kernel/trace/rv/monitors/nrp/Kconfig
> > +++ b/kernel/trace/rv/monitors/nrp/Kconfig
> > @@ -3,7 +3,7 @@
> > =C2=A0config RV_MON_NRP
> > =C2=A0	depends on RV
> > =C2=A0	depends on RV_MON_SCHED
> > -	default y if !ARCH_ARM64
> > +	default y if !ARM64
>=20
> I think this is not supposed to be in this patch? It has nothing to
> do with
> the opid monitor.

Damn, fixed up the wrong patch, will move it to the other one..

>=20
> > =C2=A0	select DA_MON_EVENTS_ID
> > =C2=A0	bool "nrp monitor"
> > =C2=A0	help
> > diff --git a/kernel/trace/rv/monitors/opid/Kconfig
> > b/kernel/trace/rv/monitors/opid/Kconfig
> > new file mode 100644
> > index 0000000000000..23b43d2704153
> > --- /dev/null
> > +++ b/kernel/trace/rv/monitors/opid/Kconfig
> > @@ -0,0 +1,17 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +config RV_MON_OPID
> > +	depends on RV
> > +	depends on TRACE_IRQFLAGS
> > +	depends on TRACE_PREEMPT_TOGGLE
> > +	depends on RV_MON_SCHED
> > +	default y if PREEMPT_RT
> > +	select DA_MON_EVENTS_IMPLICIT
>=20
> Shouldn't we add "depends on PREEMPT_RT"? I tried this monitor on
> non-RT x86 kernel, and got some errors. That could confuse people.

Mmh, my rationale was that it reports errors on non PREEMPT_RT, but it
does build. If someone wants to try it out there, they are free to do
it. We are just not supporting it officially.
The monitor might start working in the future also on non RT kernels,
or at least if someone wants to try whether it's the case, they can do
it easily.

Same idea for the ARM64 thing above.

But I should definitely mention this explicitly in the Kconfig entry
not to confuse people..

>=20
> And the monitor reports some errors on riscv64 with PREEMPT_RT=3Dy:
>=20
> root@riscv:~/rv-tests# uname -a
> Linux riscv 6.16.0-rc6-00054-g7590637d9ca2 #87 SMP PREEMPT_RT Wed Jul
> 16 11:26:00 CEST 2025 riscv64 GNU/Linux
> root@riscv:~/rv-tests# stress-ng --cpu-sched -1
> stress-ng: info:=C2=A0 [452] defaulting to a 1 day run per stressor
> stress-ng: info:=C2=A0 [452] dispatching hogs: 4 cpu-sched
> [=C2=A0 614.390462] rv: monitor opid does not allow event irq_entry on
> state in_irq
>=20

Mmh riscv.. I haven't tested it there, guess I need to start keeping a
VM somewhere.

Thanks,
Gabriele


