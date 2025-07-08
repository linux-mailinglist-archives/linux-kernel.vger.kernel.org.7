Return-Path: <linux-kernel+bounces-721495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1CCAFC9EE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26344A81B9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E512BEC3E;
	Tue,  8 Jul 2025 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UR5iCVuq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD462882A2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751975844; cv=none; b=Z7WyAtnIkbv3q8pvrWQMB61pPGzvXTSC5tANtg1xEbTRDuYClVYNUICxysvHGR/1JkZzR7tjW4pEknZkk4QdwV8fqgKGyN/BvK/SJSznTFezVWvAqYJzhIZkghlfNkc1CNCtPxNwVliCUPgj8u6TYpkogvDFHfABFbiiU+1s0h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751975844; c=relaxed/simple;
	bh=TEHRtld4Bg238zzuQf4UOHuFAEYFthjxJQB/qIWOQb4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m8uMFxejv8JbiLxZlsAPKtYseqnSmFQO8cGsl7WGSrjhnAPanxLer0ZU8ycc13nOESNoef0IrFUZgj4v+m7dFTG4VKD52h7RwDNEmSzktjeAiZCfXp8mF1FFqmvcLVi/JlU2tUPUyGW+3tGAiL6sA/L1+LEjN3Jq+XWvhxB48f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UR5iCVuq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751975841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TEHRtld4Bg238zzuQf4UOHuFAEYFthjxJQB/qIWOQb4=;
	b=UR5iCVuqC8n7fva4Q7zPf2f2ytcvfpKDhjtQFX2uy9UOc9LWtlkdlbDcFu0PCxucyV2sGD
	PwpGwEbqCrqyBA0zHQx8TBMQ2blt1j4Gnj3pMxB7HuboYRPGez4vdyxXEpylQS5F2iSFqB
	Iyllupsm8VIBEdfk0bitumQiaIZttSA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-pU-n4ZOUMXew1el1cOtrhQ-1; Tue, 08 Jul 2025 07:57:20 -0400
X-MC-Unique: pU-n4ZOUMXew1el1cOtrhQ-1
X-Mimecast-MFC-AGG-ID: pU-n4ZOUMXew1el1cOtrhQ_1751975839
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b4a0013c0dso980399f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 04:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751975839; x=1752580639;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TEHRtld4Bg238zzuQf4UOHuFAEYFthjxJQB/qIWOQb4=;
        b=B28oJsjNpM2Svdj/yGXI9Cd/xO+DrgNca+LHg8K1Qmj5K3gBwh1Vgm20bg2Bh2WAEP
         f5u5tE3HucmhCzBb952oMBzCKqdRO+oBPOTr+eBGR0TaGyMv/Je6mXfD8OhC28bp8DlJ
         CRvuquFzcpQ107dGoeTXHaqtM0COgj6oKb5+xKHyK7zTsN82puxuSQoPd9KOsix7xZiq
         mVGhliK2W96yC89Go/dfvSmau2zDSkF16PEmejRwH2M4jftHfZPtcek1mr0StftxeKFD
         CQ3VcwUb1Ok+kd3Wyffan8Tn0ZdLVY6XrjcBgFTmEhixtm1ugJ+1luPU8wE+8mb9Gc+A
         Zf9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDKTfW/fvr3SBemvog4PoFJfLB+eRwn41zexhtDnbome14nRI15EC/lJclGMNut3tmy3cynMZwjd2n4f4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1DA2N8lXD252US3khZuP5Ix4tnpLX/+2ZHuyPoxYe3kCvMu6w
	K7UF9WDDFDjGDq2oG9RegOf7P6t2im38g69OMPH9ECSl3phf+bWx39QAdoNBuP/6c7RR46UcGec
	VtOY4kVRtrVRB6JKXtl5yBbuHwmC1PInHMbAqWyEZrsuSLixW//XLn3uim+oAuce29OIDUw97py
	nn
X-Gm-Gg: ASbGnctA9X4YcJn0LPOueUalzZ8Qqb76vG6Aw5sFi6vzuq9HtFTjOLYai0nOWJriNkR
	V4inL4UZAqEFwZ/ANPPO+CUfM6wBLesKEfWVaqwJ3DoMEgUe37zUX5lZyjEvhpupy1rZoC5jaN9
	cdnA8lp5eXCXXK5DCBMUDH+VEtx2j8+E3Is/5dstt3bnebMrejfhmNn2QdqwWEYzhsKPvjfEj4x
	XmmXD+NTw4F4o1zQ5nFNaYSpaE2kHcLvZYKnhKsaNEAAstHxcuZFQKFXIHIf/+ZR52u6ZLoQO+/
	rti1An+mrWvmb0GJ8+9KuiYmWXTt6R3491VKWMajBg6jqy40
X-Received: by 2002:a05:6000:1448:b0:3b3:a6c2:989 with SMTP id ffacd0b85a97d-3b4964c0b49mr12317311f8f.18.1751975838570;
        Tue, 08 Jul 2025 04:57:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeV+wFJfih7QmPEI1qBN+NBuVr8+EOK+jd+4ay3Umcy9zqCyOhcpQ/07x3fscV34Qu9G4b9w==
X-Received: by 2002:a05:6000:1448:b0:3b3:a6c2:989 with SMTP id ffacd0b85a97d-3b4964c0b49mr12317294f8f.18.1751975838102;
        Tue, 08 Jul 2025 04:57:18 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3d8107sm20458785e9.34.2025.07.08.04.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 04:57:17 -0700 (PDT)
Message-ID: <cd8e42bdf86c3d4f2da8b7636d3b35cfead2c3c3.camel@redhat.com>
Subject: Re: [PATCH v10 17/19] rv: Add rtapp_sleep monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de
Date: Tue, 08 Jul 2025 13:57:16 +0200
In-Reply-To: <20250708075013.hMCRH87n@linutronix.de>
References: 
	<d3cf55d3bf42a0f70a58c394b5cf6d603ca8a9f7.1749547399.git.namcao@linutronix.de>
	 <20250630203401.1a11e58f@gandalf.local.home>
	 <20250701051757.mBjQVdoo@linutronix.de>
	 <20250701110218.5e742850@batman.local.home>
	 <20250701110551.5c2dc2ee@batman.local.home>
	 <20250701151114.OJQTlRCY@linutronix.de>
	 <20250701111704.00456667@batman.local.home>
	 <20250701210338.BooVbo54@linutronix.de>
	 <20250701171715.5a1a99a0@batman.local.home>
	 <309ecabeacc72f13de7b190f37423f1aeafe991d.camel@redhat.com>
	 <20250708075013.hMCRH87n@linutronix.de>
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



On Tue, 2025-07-08 at 09:50 +0200, Nam Cao wrote:
> On Wed, Jul 02, 2025 at 08:29:28AM +0200, Gabriele Monaco wrote:
> > That's a good point, at the moment the DA monitors have a comment
> > in
> > the /completely/ generated files (the automata header), the others
> > where just a skeleton is prepared have some hints that we removed
> > while
> > filling the monitor.
> >=20
> > I'd say for now it's good to just add a comment in the LTL header
> > (like
> > Dot2k:fill_model_h_header), then we can adapt all generated files
> > (whether fully or not) to have also the actual command that
> > generated
> > them starting from the model file.
> > Or did you have something different in mind, Nam?
>=20
> Yes, I think the same.
>=20
> An easy way to do it is just dump out sys.argv. But one thing I'm
> unsure
> about: I prefer to execute the command from tools/verification, and
> the
> command I use would not work for people running from root directory.
> I
> would like the printed command to always appear as if it is executed
> from
> root directory. However, I see no elegant way to do it - will need to
> think
> some more.
>=20

Mmh, that's something I didn't think about, but perhaps we shouldn't be
too picky and think users would just copy-paste the command provided
and expect it to work.

By the way, the sys.argv could be a great start, but depending on the
workflow, one may not even keep the model in the location where it
would be committed during generation (I usually don't, mostly out of
laziness).

Anyway, although I'd prefer running the command from the repo root,
just for sake of compactness we could include the command as run from
tools/verification, but I'm fine either ways. I think by adding proper
documentation, the reader can easily figure that out.
We could edit sys.argv before printing to make sure the model is where
we expect it to be, and perhaps strip/add some arguments (e.g. if we
want the -a or not), just to keep it always consistent and predictable.

As long as the command written to the files is consistent and clear to
understand, I wouldn't mind too much.

Thanks,
Gabriele


