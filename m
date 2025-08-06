Return-Path: <linux-kernel+bounces-757938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2983B1C88C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5443BA71A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5587C28D85D;
	Wed,  6 Aug 2025 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="R9CC+6TS"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B783D218AAB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493611; cv=none; b=CS6WNqoByxntNODwJu3kj4zOUg6lb2nMbPofVmPyc0+2Fd0jmmzIGm9T9SMq1sX7Yd38/gBAMLv+2+YnCMrcce8Qc2xGNx18mVrXyT+DfeQ+zFu2Ce+LxAuF7wRTgE0KGXB9Xk+Nl2fxx7tEcH6Fxhm+g1bmptRaBsdoLJCrPFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493611; c=relaxed/simple;
	bh=XeQ4LyBFuYf/lAfwUZjLXpPrasqdVwQUMQNjXbI29Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lb1bJiQsMj8m4rzQW02rl1vrwk46QcawyFx7AvbgvL1k6puONxEZ455vqgTGTqNnpsQ49zCxkMIro/nVNr0OUCGrdwTidBa8QxfCzUGV0MhJd8uQeVrVbPnTAL+wLsqPiWBLadYA+AHjARFCjBkT1e1lITxkOiTT13uqdKZ4u8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=R9CC+6TS; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-88dab9ca6e3so1505211241.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 08:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1754493608; x=1755098408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=805K6fvtdokSqfEHjnN7vRqDDCTH7wpXcqcu6F316LE=;
        b=R9CC+6TSBmseLHQJ/C3w5MJSPT8nDX/blXoTmZAF11N1cLTKcg5Gk7cFR5kZzsIeiM
         Ej3+3iX9Anb1e/MATo3kKg9opj1t4Gvjp60CICmiiDruQFeEOE9XeacdnK2DWvTqBFrm
         JMc9/Tu9DQ8KzMD3uP2LSBhPtmmfVknbPWb31DggfHt14ON6/I31NKO+eaus8pUR9z3p
         Mvy/RKuPWf2vGR2u9kSykm6IGu4XE40aopIGhh2YOQKkg0pBgiQbzOl7SS+aTTQbFCHE
         QF39hxk9CuPg4PEj4MCEpHfGb6huM5ZZmJzlGOyYbCPLx90wMGpFRuhoJC5KjKk4HL9e
         35IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754493608; x=1755098408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=805K6fvtdokSqfEHjnN7vRqDDCTH7wpXcqcu6F316LE=;
        b=Mjyti7Z/IUIK19rUjnbM+sr5eLD1COpPVeDVHTe6Q4dqmXbCMVwDSHamWzEJ7poMcG
         ehOS5B7t13IfwHCbHzFiGtkdIK+0L6381VGa1oKeXi9lAnt3i+xnxkkjwWV/Z1H7Mfj7
         /s7yAK1VhyAmL1ughHJy+/wZeoHWKZ9DMmp8LGRDLSdnl40SaL2TEsW2B1jA8nDwajnA
         UhNN8yvEaYs+aCeSrq8F5J85VEEJbgLvWYrV0bM5ne2lD4kbBv1p9+3jFJ6tb3J8ZaqA
         0lqFVipWRJ9wvn+l6qoZrqxjl6fooXsZmZJ6i40fF+1ryS6iA7xHnvWBbqaH+ecU49UA
         2WqQ==
X-Gm-Message-State: AOJu0YyfLhzDaihKa0z43qzMP9YBdoCnKQFE16clTBirigs7osbs/YRM
	Ijw2+sB2PIg5e5bNKmTo+/9Xi56AudfLSd/2tIpN1wTuZLERUeVWnjZAWOt2faEMXM3GAdMsTt0
	j5D7+pcuwx75/jkS8aGK6jDGYGwFsN3gi2R0CduggoA==
X-Gm-Gg: ASbGncvvvPZ2pzE4CBRvZ+qNppzpttcmC2a6Ra/fvR6tntbFe22yEAmgIdzCIvVbsHk
	iepySopDfzuvpYdU/8lknn4prDTlEJbdiOstXw4N+h3OVLfHRDuoKtux8E8zMAl+okvy8j3MBOY
	afC65r3Km4jqydB1WswRFO2A2Psp+Pc9LutV2IsUbdjvSOx031RoTHcEZpT2x96+CEn7RhmTuDN
	4g8
X-Google-Smtp-Source: AGHT+IEwtib/MiSSe6PyJvzqzeOSOjkXKPFo4O7cvuV5C+3dwyYliOiUE4LGgYQXOufi1bsGFYsJcYEM5+C9sofisDk=
X-Received: by 2002:a05:6102:dc7:b0:4de:d08f:6727 with SMTP id
 ada2fe7eead31-503731b8172mr1694875137.13.1754493608384; Wed, 06 Aug 2025
 08:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731173534.3494324-1-adrian.larumbe@collabora.com>
In-Reply-To: <20250731173534.3494324-1-adrian.larumbe@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 6 Aug 2025 16:19:56 +0100
X-Gm-Features: Ac12FXyX3LGMeD1c7gpkSiDZahsXCZ1jgp3yTJhhAYZ-wv0f2moDW31lBHHWdaw
Message-ID: <CAPj87rPrGX2c3RQKJ6NxGYWbzbNp-9zCC=twCN4OLcD4aXcuHg@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Print RSS for tiler heap BO's in debugfs
 GEMS file
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com, 
	Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adri=C3=A1n,

On Thu, 31 Jul 2025 at 18:36, Adri=C3=A1n Larumbe
<adrian.larumbe@collabora.com> wrote:
> @@ -432,7 +432,8 @@ static void panfrost_gem_debugfs_bo_print(struct panf=
rost_gem_object *bo,
>         if (!refcount)
>                 return;
>
> -       resident_size =3D bo->base.pages ? bo->base.base.size : 0;
> +       resident_size =3D bo->base.pages ?
> +               (bo->is_heap ? bo->heap_rss_size : bo->base.base.size) : =
0;

Just use panfrost_gem_rss() here, though you'll need to make it non-static.

With that:
Reviewed-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel

