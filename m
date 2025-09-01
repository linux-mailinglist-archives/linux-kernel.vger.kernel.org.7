Return-Path: <linux-kernel+bounces-795358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782C3B3F08B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 23:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459DA16DD06
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 21:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7560B27B4E4;
	Mon,  1 Sep 2025 21:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8druNtk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DF5221577
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756762363; cv=none; b=CxHjW6ilUjI1Iy+iz7GBBMqGTnLXvv8ddLHd4to976HuWWQhuKphFRnwpjXyumjisbpLLLZf34u+wh/JvOZZ6gvptb8oN0WLt5N76Uf/u4EfAYeVS7wncq9fawsQh7etzNF/EGA0EJTli3iXdQkZUZqhIafRQlIfEOcKvSng4Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756762363; c=relaxed/simple;
	bh=3swOk4OyatWaOATPp01ulPoGz+0e4u+jNu0dl8fcEFQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=uqEw6Tpy5uI1DGNhkwldIymxoh1pvhP3PvSRC3FVxuzgSGkHTK5U63sFB4WImfO0n1SnzRiFmZvoWnFRQfovd4X+VsfmB6iZa0xD4kQtMpCxP543bY2dEAPoUMTWme4d/0lDWg4/P/0s4iXnlAfyAjv50GH4b4QILglls46j7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8druNtk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756762360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3swOk4OyatWaOATPp01ulPoGz+0e4u+jNu0dl8fcEFQ=;
	b=M8druNtkSM8/POYROfvIT+3p+uNHhSajgovH+7cwAlZ6R2v14f4go0gMdY+v+Vrh4Yi4IU
	A3Ir6blAXJ5yvUc/ZLHUFlsR/cB2nzceGUoLehsbI0KOPMzdnOTtpP3WbgG5zOhUiHavJq
	ywcGVRkGJoQbLkmXqVME7O2oMbZGKTI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-sLJsal-FP9SaKir35djzAw-1; Mon, 01 Sep 2025 17:32:39 -0400
X-MC-Unique: sLJsal-FP9SaKir35djzAw-1
X-Mimecast-MFC-AGG-ID: sLJsal-FP9SaKir35djzAw_1756762358
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b883aa405so14893355e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 14:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756762358; x=1757367158;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3swOk4OyatWaOATPp01ulPoGz+0e4u+jNu0dl8fcEFQ=;
        b=smuSKqgWQPJa25gDxAnZkews+A/S22bxh2YxZOdklq++Wqj5XVx73RgQsEISlnbGJc
         HqudXaEYqLsTVBat/J7CZSGpifHfzfT55BimM0fhY0R2Ty0s094x3PbojKabyvktEPSu
         dutxb992Pl1pJyvOlUe98L9HgNFXCgb5Bf9QNdVoymLp/oj4wvybpBcr65/oRIADpeob
         mo6OFS6csEWIEr1xs9dFyy7Fv2vCqq7/FLjUHLlduOf89HGA/3fO34q2zayjOTDf/iD5
         acNMl52PhH8aFZDT2k6DW5roCOvH3qlbfC3cB98sp51s2BMYwCAIweGzIEVsM/4KoL8T
         Fu7g==
X-Forwarded-Encrypted: i=1; AJvYcCXBAndqvP2VfKJMI2PSuBXkfgTBpaeLF+QxYFFd1snbDScIfecf/z5f8aJKtZGjptnACWG6yxK0u7izMvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd9kCz63CPUR98dcO96dGRx1yA9kWDeTkawqPLfUQVacuXLJbx
	cana5EP/KqHthvlUStFaoNyyBwgxJMA+62cHIJrzFOsxdtyl2RMxY/28QMF0EHk3s5qwhTw4ckg
	zHSGY5EDmI+ai6KkxmAHGupKF60zeYW7bSfgOiTco00Dq6AHVo9kEXsCA9PKKrnSuoQ==
X-Gm-Gg: ASbGnctyA6CVGEzdzJER0PTiVA9Rjo8XeHQ8ptga5A7BfGRQi9XHPIjNeiR+lV17V+b
	g4OLAmYnwWG+cjm/tPqmCfQ42k5j0yBpxRFhKSJxFEtZbXEt9WZJe36LghiAKFaR/5TidsX0qfE
	88LhXA9MtPVvtMPKS/vxJw0CMW13Ww8ECoe7zhhHqeTrjJ62C8ft0vlgorLOtAxkCN/mM7KSiDF
	opTinMvdZp4tjkm2W9pTi0l0hqMt1zg2Pc6SqckqxF+F0S43zcS85ncIQbNEfHr6BxYkOiiKtsX
	ahSwEscVJPbFciQjhOF/yNnpHzRWsf3X1OTJaxLcKxyGAUYV
X-Received: by 2002:a05:600c:4fcd:b0:459:e025:8c40 with SMTP id 5b1f17b1804b1-45b85533712mr83405285e9.10.1756762358409;
        Mon, 01 Sep 2025 14:32:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAstBMuiwfLE/uHKbIRqh9Y2XLhzDYwDj5rG0gLssaFpudxwux5Z4jYtSxqSlORgb3kp/vVg==
X-Received: by 2002:a05:600c:4fcd:b0:459:e025:8c40 with SMTP id 5b1f17b1804b1-45b85533712mr83404845e9.10.1756762357904;
        Mon, 01 Sep 2025 14:32:37 -0700 (PDT)
Received: from localhost ([2001:9e8:8986:4700:668d:1f88:b725:6051])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d729a96912sm4912911f8f.8.2025.09.01.14.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 14:32:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Sep 2025 23:32:35 +0200
Message-Id: <DCHSA4THF61K.1EPEN0GWLP4Q9@redhat.com>
Subject: Re: [PATCH v2 0/2] Add "pixel_encoding" to switch between RGB & YUV
 color modes
From: "Sebastian Wick" <sebastian.wick@redhat.com>
To: "Sebastian Wick" <sebastian.wick@redhat.com>, "Daniel Stone"
 <daniel@fooishbar.org>, "Maxime Ripard" <mripard@kernel.org>
Cc: "Shengyu Qu" <wiagn233@outlook.com>, "Marius Vlad"
 <marius.vlad@collabora.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <siqueira@igalia.com>,
 <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
 <contact@rafaelrc.com>, <lijo.lazar@amd.com>, <jesse.zhang@amd.com>,
 <tim.huang@amd.com>, <dark_sylinc@yahoo.com.ar>,
 <mario.limonciello@amd.com>, <alex.hung@amd.com>,
 <aurabindo.pillai@amd.com>, <sunil.khatri@amd.com>,
 <chiahsuan.chung@amd.com>, <mwen@igalia.com>, <Roman.Li@amd.com>,
 <Wayne.Lin@amd.com>, <dominik.kaszewski@amd.com>, <alvin.lee2@amd.com>,
 <Aric.Cyr@amd.com>, <Austin.Zheng@amd.com>, <Sung.Lee@amd.com>,
 <PeiChen.Huang@amd.com>, <dillon.varone@amd.com>, <Richard.Chiang@amd.com>,
 <ryanseto@amd.com>, <linux@treblig.org>, <haoping.liu@amd.com>,
 <Relja.Vojvodic@amd.com>, <Yihan.Zhu@amd.com>, <Samson.Tam@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <wayland-devel@lists.freedesktop.org>
X-Mailer: aerc 0.20.1
References: <TY4PR01MB14432B688209B2AA416A95228983EA@TY4PR01MB14432.jpnprd01.prod.outlook.com> <aK1hPoCmLziaPPOd@xpredator> <TY4PR01MB1443219A9870877AF120FE63B9839A@TY4PR01MB14432.jpnprd01.prod.outlook.com> <20250827-imperial-mongrel-of-dignity-712fab@houat> <CAPj87rPhK+E2FP62fnNxFySDOkqqKxo_oa94i7DR3_6a1j1o1A@mail.gmail.com> <DCD5VIFRKFB9.1KHIZI3ASID2I@redhat.com>
In-Reply-To: <DCD5VIFRKFB9.1KHIZI3ASID2I@redhat.com>

On Wed Aug 27, 2025 at 1:08 PM CEST, Sebastian Wick wrote:
> On Wed Aug 27, 2025 at 12:39 PM CEST, Daniel Stone wrote:
>> Hey,
>>
>> On Wed, 27 Aug 2025 at 10:41, Maxime Ripard <mripard@kernel.org> wrote:
>>> On Wed, Aug 27, 2025 at 12:26:56AM +0800, Shengyu Qu wrote:
>>> > 1.Can you send patch with only i915/amdgpu first? It's a long-needed =
feature
>>> > to deal with some monitors/TVs with broken EDID.
>>>
>>> If it's to workaround broken monitors, then it's really not something w=
e
>>> should be doing using a property.
>>>
>>> Most likely, those monitors don't support YUV* output and will just nee=
d
>>> to be forced to RGB, so it's not something that the user (or the
>>> compositor, really) has to care about.
>>>
>>> And it would be broken with every driver, not just i915 and amdgpu.
>>>
>>> We already have some quirks infrastructure in place, the only thing we
>>> need to do is create an EDID_QUIRK_NO_$FORMAT, clear
>>> drm_display_info->color_formats based on it, and you're done. No uapi t=
o
>>> agree upon, support, test, and it works with every driver.
>>
>> There are other reasons to have uAPI though ...
>>
>> One is because you really care about the colour properties, and you'd
>> rather have better fidelity than anything else, even if it means some
>> modes are unusable.
>>
>> Another is for situations which static quirks can't handle. If you
>> want to keep headroom on the link (either to free up bandwidth for
>> other uses), or you accidentally bought a super-long cable so have a
>> flaky link, you might well want to force it to use lower fidelity so
>> you can negotiate a lower link rate.
>>
>> I'm all for just dtrt automatically, but there are definitely reasons
>> to expose it to userspace regardless.
>
> Yes!
>
> Broadcast RGB is a property that only works as a workaround for broken
> monitors. If user space sets it to a value other than auto, even after
> first checking the EDID if the sink supports it, we don't know if the
> kernel just changes the values, or also sends the InfoFrame (or the DP
> equivalent).
>
> So even if the new property was just for broken sinks, we already have a
> similar case, and it makes sense: If the EDID fails to read properly, or
> the display has no EDID, the kernel can't really identify the thing, so
> you need something in user space anyway.
>
> Even for quirks where you can identify something, user space is a better
> fit because we can update things faster. This is one of the goals of
> libdisplay-info anyway.
>
> Either way, like Daniel said, this *is* useful for other reasons. We
> want to be able to switch between quality and bandwidth.

Daniel suggested in the other thread that the last part of the transform
should be done via a connector property. I'll take that at face value
beause I really don't really know what hardware does. What's important
then is however to make it absolutely clear what the transform looks
like exactly to user space, to make it possible to program the CRTC
color pipeline to produce the correct values.

>
>> Cheers,
>> Daniel


