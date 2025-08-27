Return-Path: <linux-kernel+bounces-788166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4A8B38097
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF391BA59C7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3545632144A;
	Wed, 27 Aug 2025 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMOKcIoj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941D828C847
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292913; cv=none; b=s2Xi+AK/VSuXkNXhqladmNiasFlxlR/CcO47En1ukICzxlaCqTRzZp9KTwrQ7AOjrdY/xlajOA/YXeIa8VPS7s2iFNLj9NxQyu4vVYPDwVkvkXgSQU0QK6WBox/C/DJQsxb/jZ5DKbfVEkFjcg3tkoErgEvU97UVPY+asbqeQNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292913; c=relaxed/simple;
	bh=3PjxlAWf7veWGNv8WxmuluBCo2cmlQimJC4dQF/7vCU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=p/Vk8dyQHBapCthqxJOSbbgL8/uHRFU0Wb4Wx5dJeJsTJVsgRS0KmB+PdGTeKJ25pu4SZ04Dw+MKM5v0NAVw0KVx5k7KAW6MbiFgYiFVdJeamFAW+eYAUVVTXKUhfHsNuKM5RVbSNPQ52IlmFpED7IWwaXmjbjGq0JyND28w+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hMOKcIoj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756292910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3PjxlAWf7veWGNv8WxmuluBCo2cmlQimJC4dQF/7vCU=;
	b=hMOKcIojpMtY6qdr3F+RLu97ElOIpF3xX4RjfiwLk1kSOyhRB2zyP6e12RgK1fitsbdnbQ
	R5uOj+QkoX+NqzagYMZzngnu8micYiyTvj7+1ykN3ZbdAX2Wc23AYZLemXm0oqUAHaAoen
	LNeSMyOkKQtqUifu6EtknHGrwD1QOOY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-0WB_z29hPsm9r_1MsdnIRA-1; Wed, 27 Aug 2025 07:08:29 -0400
X-MC-Unique: 0WB_z29hPsm9r_1MsdnIRA-1
X-Mimecast-MFC-AGG-ID: 0WB_z29hPsm9r_1MsdnIRA_1756292908
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b7265febdso2096275e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756292908; x=1756897708;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3PjxlAWf7veWGNv8WxmuluBCo2cmlQimJC4dQF/7vCU=;
        b=ilIB29IsjCUSRExKSjaR293Uw8RuXF6h0jH4dcmdVHiLVYEMeQyGAntFSIspAGtvWA
         PQ+azAfUO0+1bDghpEQK1FkWfuT06XRkrrC92FWSh9hc/IDLBFhDbcJ/FTwwsaW24XLd
         GtmfVHQpT5h317Qm7ZZ3CM2S4FsNlOmeBGIj7jvCSVbj/Ot4T7Iemi+IY8IIK1r3f+Rp
         UqWI6ZPO79pQ8gPfspMxN/3D39fq7KlHzCJnsadujsGdnOkmOMGH8dBs7qwHbk14ezri
         Dc9hAmQS4c0IplGJufTzao1B/QJtShnNeSH8PWaVrtIPWFrRq9/5FPWwnB9X2TLrYog8
         xVkw==
X-Forwarded-Encrypted: i=1; AJvYcCWm9kOpBuqQfNioGTcPN2lz72YxijxorB1pzIXhwxFejkmQJAKxBJWx2E1VjHRofdmjzFZO/Yeq5jIqcwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YynyxOs15MMyv3DuxNEsHWWyh8qtrnbxj/t0mg08SrpDbJMdL4C
	aWfSJzf/DetVwJOLQKDXndI+DmscFjZu/fqHz6GHtT9c9145lH7Hu2KKu5yHQMYgbbxl4FvcAj7
	kRR5oSK5dsXONRmmf/bu4fldfPYWM0TCJs9JnDKGhU3AyodhD8aL+EGDKEXcPsql39g==
X-Gm-Gg: ASbGncuR5whUnGpK/XuD5VxSDtUHor1cc10WiIGAMfiJsWHebtlj+Vkb7stP78w/K7C
	L55KsfJs3SYR3OHZAqxT0aH4GA2Zk2aBNFOFS48vQ/vwz7WgvMbVTpqFjoFcwv3CdTEpV7aX0d5
	QVPES3lWIPPG7T/pq4f3bHvBjnbp2sk8cmAF0sEm74BEtbJR+7aPyPc4/mO6hCgPujvcWxXPb7T
	FUndiWJQYz1VoBww7umjPErRnLVz3V4yYLjZxfmajZrV5NY44r/CtVpTrQaegUczY3WdlHPf4la
	dtoAoze2KboH2sBh4PPCdbWqz5Bu4CZkPutHxLm85h+dew==
X-Received: by 2002:a5d:5f46:0:b0:3c5:c344:ffb8 with SMTP id ffacd0b85a97d-3cbb15ca309mr4023100f8f.12.1756292907964;
        Wed, 27 Aug 2025 04:08:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnbaAqjIreMNe/bzEU3jkon+3zC2R03YKoR/bFzRlaIY/38ozGFFh2vpp9cdD5NjXCSRmsZQ==
X-Received: by 2002:a5d:5f46:0:b0:3c5:c344:ffb8 with SMTP id ffacd0b85a97d-3cbb15ca309mr4023053f8f.12.1756292907494;
        Wed, 27 Aug 2025 04:08:27 -0700 (PDT)
Received: from localhost ([2001:9e8:898f:9300:ff23:be77:f1bc:ffc8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70ef566dcsm19986409f8f.24.2025.08.27.04.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 04:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Aug 2025 13:08:25 +0200
Message-Id: <DCD5VIFRKFB9.1KHIZI3ASID2I@redhat.com>
From: "Sebastian Wick" <sebastian.wick@redhat.com>
To: "Daniel Stone" <daniel@fooishbar.org>, "Maxime Ripard"
 <mripard@kernel.org>
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
Subject: Re: [PATCH v2 0/2] Add "pixel_encoding" to switch between RGB & YUV
 color modes
X-Mailer: aerc 0.20.1
References: <TY4PR01MB14432B688209B2AA416A95228983EA@TY4PR01MB14432.jpnprd01.prod.outlook.com> <aK1hPoCmLziaPPOd@xpredator> <TY4PR01MB1443219A9870877AF120FE63B9839A@TY4PR01MB14432.jpnprd01.prod.outlook.com> <20250827-imperial-mongrel-of-dignity-712fab@houat> <CAPj87rPhK+E2FP62fnNxFySDOkqqKxo_oa94i7DR3_6a1j1o1A@mail.gmail.com>
In-Reply-To: <CAPj87rPhK+E2FP62fnNxFySDOkqqKxo_oa94i7DR3_6a1j1o1A@mail.gmail.com>

On Wed Aug 27, 2025 at 12:39 PM CEST, Daniel Stone wrote:
> Hey,
>
> On Wed, 27 Aug 2025 at 10:41, Maxime Ripard <mripard@kernel.org> wrote:
>> On Wed, Aug 27, 2025 at 12:26:56AM +0800, Shengyu Qu wrote:
>> > 1.Can you send patch with only i915/amdgpu first? It's a long-needed f=
eature
>> > to deal with some monitors/TVs with broken EDID.
>>
>> If it's to workaround broken monitors, then it's really not something we
>> should be doing using a property.
>>
>> Most likely, those monitors don't support YUV* output and will just need
>> to be forced to RGB, so it's not something that the user (or the
>> compositor, really) has to care about.
>>
>> And it would be broken with every driver, not just i915 and amdgpu.
>>
>> We already have some quirks infrastructure in place, the only thing we
>> need to do is create an EDID_QUIRK_NO_$FORMAT, clear
>> drm_display_info->color_formats based on it, and you're done. No uapi to
>> agree upon, support, test, and it works with every driver.
>
> There are other reasons to have uAPI though ...
>
> One is because you really care about the colour properties, and you'd
> rather have better fidelity than anything else, even if it means some
> modes are unusable.
>
> Another is for situations which static quirks can't handle. If you
> want to keep headroom on the link (either to free up bandwidth for
> other uses), or you accidentally bought a super-long cable so have a
> flaky link, you might well want to force it to use lower fidelity so
> you can negotiate a lower link rate.
>
> I'm all for just dtrt automatically, but there are definitely reasons
> to expose it to userspace regardless.

Yes!

Broadcast RGB is a property that only works as a workaround for broken
monitors. If user space sets it to a value other than auto, even after
first checking the EDID if the sink supports it, we don't know if the
kernel just changes the values, or also sends the InfoFrame (or the DP
equivalent).

So even if the new property was just for broken sinks, we already have a
similar case, and it makes sense: If the EDID fails to read properly, or
the display has no EDID, the kernel can't really identify the thing, so
you need something in user space anyway.

Even for quirks where you can identify something, user space is a better
fit because we can update things faster. This is one of the goals of
libdisplay-info anyway.

Either way, like Daniel said, this *is* useful for other reasons. We
want to be able to switch between quality and bandwidth.

> Cheers,
> Daniel


