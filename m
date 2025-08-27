Return-Path: <linux-kernel+bounces-788127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E216BB38005
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6EEC2073BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4908A30FC1E;
	Wed, 27 Aug 2025 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="KG+Lu1yk"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5186329A33E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291181; cv=none; b=Tau6Ffy6NLaG6Sg31Cwbs8Jm0I9q0XrQWLg1h84IRJOxrO+CZzWrTRD6muwdXUgHOzFsv78rhlW3e5hMQO4rKbnuriYGkqb+YMbsBiMNYO/dORd9VjKqkvKrPVpkeF1Vk/Q9LHzbl8e3BVLwSyV+ScxLuxiIs8QSS7hpk+EcMn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291181; c=relaxed/simple;
	bh=KdUUYdYYMaA5K4ETaZuOUOJJM1a2acdPrTwBBDRRG4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIXRcbxbUp4vNlxsSFx9Oi/4vuawIWxZGSCGCsNVIGusUg5A7a91326/6m73YQzoGVgENy6MlJOfwWIPh9hTJ7kt78QjZr0casjW+qwvLEzGDNx0I5V9fF3enJPRGejiYy+9ITEJ9EPNXMRu2nWsmJ5r4k9R69WmZ6vtQoLcW9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=KG+Lu1yk; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e8704e9687so643970085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1756291178; x=1756895978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KdUUYdYYMaA5K4ETaZuOUOJJM1a2acdPrTwBBDRRG4w=;
        b=KG+Lu1ykijy5RwZMUk9rw9NcobVApc2xFG7rCzrP0QLh+2S3GDKIyzPpVF2goTEZMh
         BLMZYspxRPua7pNbxydenZSBzzYSxVOVkmjhO9ffBh/3CewLoj7v8C8xQpRpEKpk+KmN
         WwCWjSP85GsAUoYRtzgwrMOw7pT71vasZd2X7TsAKzVc/CsS4Har4AM7C9xrqhJiJbie
         V7d1tCcJwxh5tLg4zNz+51tdX3Re8lS2yyoAb+N4363kPhQiJ7OYkEXjUiyLXuQ/z102
         FGTD+M35z8gGTo1YGKWJaIkYc4MzExX3jT8/yLGy3PwVAiTmwnRCj+PPwA/ioRAb6iYO
         CmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756291178; x=1756895978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KdUUYdYYMaA5K4ETaZuOUOJJM1a2acdPrTwBBDRRG4w=;
        b=iyP9+5BjtYqiQC84qlMyF0rsOMXmRqbJU4ZjlKq3eh9BAMyocE+EvpeEJzaksifrSG
         lXexingVM7XwuZb3Qdc2ZYCgH3qhn5hkUK4/Ir+lhQOZ4YdER+/K9v2luhc9PQm5/4Cd
         gLlmvWQm10xji5jXA0d5l5ZNskLsYrtlezRB114mxayDZd3cZrPc4+B3oC4vu1jW7K56
         qmidefrdqKy+IkRlkg850hpGroZaLFvNX6q54MDlrFgKjGLyLMoAHqqI2mCqvFWDx4fT
         ZRFLSi4jPfBMrEmeVZlncDZhZOdTl4NuxSgWlrGBjJJ1rb3YxdMIiQwkoWVna0pFi8M1
         gm2w==
X-Forwarded-Encrypted: i=1; AJvYcCUqZEV8OFdSV4uSgLKjAJXZI0xxhjz6M0szJaNUk4Gj+QeY8HSKlb/DiRZsRzIp7RHYDXxgzzSI9kt11eI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz91CmpULSlL+AUE9iiJCuZUhgpnMOdoAf+AQ6PEGwOTLy1kktK
	Nt3JiVotC+3HLbqzxOymXCglrrNZVLadTOG7RO90Wa3GcKyunRaxsOcf63MxxpFMvfGJI50573q
	vM2NrUmSwzRX4I1jdt5S+6YBEmoAYoUaZA5MFzYN5lQ==
X-Gm-Gg: ASbGncuGMuBiI+u39Fjqagkse4kcFVv30on3aM+vDrJJbLZwzPOZP90GUSwD7Ke4C3X
	m9W7WnMAEKWARqZnGhTv8ucpiWvvqfBn4v9hI31vp67ymc+NEI5g4GqxlVF7mBYLbCNCkmfcePc
	2uototwJJq50tIOW9uzX7rMuLeVFto0kv2Fd5+zw1Lm5yu5znfadYKK3MuvhwbjvHDZskJJrc/9
	CU9nuGNwBon24YTG4SYo1Us1Hg=
X-Google-Smtp-Source: AGHT+IGICLeibcQmnZWYFS/brOl+88R3Na1uvRw0VQWTlZaKJUHWBkBh81Tx23IIhL3FKds+ZF25D4ZEHOiVNLlKiOo=
X-Received: by 2002:a05:620a:ac15:b0:7e9:f1c3:6851 with SMTP id
 af79cd13be357-7ea1108f69amr2193999385a.71.1756291177899; Wed, 27 Aug 2025
 03:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TY4PR01MB14432B688209B2AA416A95228983EA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <aK1hPoCmLziaPPOd@xpredator> <TY4PR01MB1443219A9870877AF120FE63B9839A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <20250827-imperial-mongrel-of-dignity-712fab@houat>
In-Reply-To: <20250827-imperial-mongrel-of-dignity-712fab@houat>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 27 Aug 2025 11:39:25 +0100
X-Gm-Features: Ac12FXwa0ndxe4WhxS64VBVPx8pzaNWj2GmesKshpkeIDruMRsTSCWY0sc4CrIA
Message-ID: <CAPj87rPhK+E2FP62fnNxFySDOkqqKxo_oa94i7DR3_6a1j1o1A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add "pixel_encoding" to switch between RGB & YUV
 color modes
To: Maxime Ripard <mripard@kernel.org>
Cc: Shengyu Qu <wiagn233@outlook.com>, Marius Vlad <marius.vlad@collabora.com>, 
	alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
	simona@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com, 
	siqueira@igalia.com, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	contact@rafaelrc.com, lijo.lazar@amd.com, jesse.zhang@amd.com, 
	tim.huang@amd.com, dark_sylinc@yahoo.com.ar, mario.limonciello@amd.com, 
	alex.hung@amd.com, aurabindo.pillai@amd.com, sunil.khatri@amd.com, 
	chiahsuan.chung@amd.com, mwen@igalia.com, Roman.Li@amd.com, Wayne.Lin@amd.com, 
	dominik.kaszewski@amd.com, alvin.lee2@amd.com, Aric.Cyr@amd.com, 
	Austin.Zheng@amd.com, Sung.Lee@amd.com, PeiChen.Huang@amd.com, 
	dillon.varone@amd.com, Richard.Chiang@amd.com, ryanseto@amd.com, 
	linux@treblig.org, haoping.liu@amd.com, Relja.Vojvodic@amd.com, 
	Yihan.Zhu@amd.com, Samson.Tam@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	wayland-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

Hey,

On Wed, 27 Aug 2025 at 10:41, Maxime Ripard <mripard@kernel.org> wrote:
> On Wed, Aug 27, 2025 at 12:26:56AM +0800, Shengyu Qu wrote:
> > 1.Can you send patch with only i915/amdgpu first? It's a long-needed feature
> > to deal with some monitors/TVs with broken EDID.
>
> If it's to workaround broken monitors, then it's really not something we
> should be doing using a property.
>
> Most likely, those monitors don't support YUV* output and will just need
> to be forced to RGB, so it's not something that the user (or the
> compositor, really) has to care about.
>
> And it would be broken with every driver, not just i915 and amdgpu.
>
> We already have some quirks infrastructure in place, the only thing we
> need to do is create an EDID_QUIRK_NO_$FORMAT, clear
> drm_display_info->color_formats based on it, and you're done. No uapi to
> agree upon, support, test, and it works with every driver.

There are other reasons to have uAPI though ...

One is because you really care about the colour properties, and you'd
rather have better fidelity than anything else, even if it means some
modes are unusable.

Another is for situations which static quirks can't handle. If you
want to keep headroom on the link (either to free up bandwidth for
other uses), or you accidentally bought a super-long cable so have a
flaky link, you might well want to force it to use lower fidelity so
you can negotiate a lower link rate.

I'm all for just dtrt automatically, but there are definitely reasons
to expose it to userspace regardless.

Cheers,
Daniel

