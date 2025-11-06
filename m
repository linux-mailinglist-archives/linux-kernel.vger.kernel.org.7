Return-Path: <linux-kernel+bounces-887591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36735C38AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28A93B6ABC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617351E32D6;
	Thu,  6 Nov 2025 01:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWhPg+TT"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218D15464F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762391439; cv=none; b=WHJRocdhNjrTOqPC/s8NOdKvaGXIdJoqdUzNsuKoBjhBMOJ1kez++xC73kK/OxAUpu8Do/GYVLEw9jLrtnToDe9OpNU2mehg1sQiwWCBmCWE0pRtcNbcP0Q35/P3hjGAgCG54T1XT1Hl+96ORXhv030LjbwhF9yb1Tloh0Y3Gds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762391439; c=relaxed/simple;
	bh=5zrFGqaY2s63rjFRtLY50UAaAhJky1Nl9P7e0n0a7DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQeuHh6cESznZ7rGE1VJtlbFH2zZvrUQFCY/Czt6mGoDUdlFHVwjJOyMo6ZuoXTXo3x8HlDa4bg3teR6gId3a0zn7dqcHRCKYVgZbYNyzQgnMqtAikd+H1AxGuaKC9J0T+NIcnhMW3V04maXclV3MHLWNw8lttA+ksEEHH4V2XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWhPg+TT; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b1f2fbaed7so43354985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762391437; x=1762996237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pyhS6jZpYBILAbqR+rnW9JcsPWV01j5CzZ2xzVsZ5pE=;
        b=YWhPg+TTjdfxi56VkC1Wqnd4D2fpNtZ+URfjuF5bODqae2ooofzbRaioJ5CNPm/hqc
         koi0WguUoXCZuX14+Ofq5qUv1aNewFgMnyuF0SK/1RJ/8VPRFqFCVAG/PczqqLW0nxo5
         8F0HiCOUIzpSCQ3Jg6RlITC/EPXOXWKig6fei5ER/HO5G2UF8ucQVFg3/0Jr3nw/+Apu
         RZ0pTFSglDCiRQ1aSypRvezY2WVFerPEDmV4EEtInxgnHdkvk+v7+QURQyn/ECFdAwhT
         FMyQIauY6Z475AjW/o8C18Zv920D2p93HVbH17Yyhb1HK6XVvtEex46N/hH1koIriBqa
         oHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762391437; x=1762996237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pyhS6jZpYBILAbqR+rnW9JcsPWV01j5CzZ2xzVsZ5pE=;
        b=DukCVBfMJXhNAME2btOuGR/6SWtzLLZOMZQ9Zua/IWD0DS37rS/DxEZSK8eKAHg4Yn
         1wTxEXqCk3T7Dt8GIW4Mrh63Sft1w1TdHAyH+d1Dx62YlgPvk8h58QJNQZNMcTl3EWqI
         vTHD+In66k/RBjv0sRRgCEv4FuSvzGhQPOXVvw8P7pfS9P6qj6VYUrcMz8hRruDJLep8
         o1CdsQX2hXvCZWZllHB2BmGAL6s3P7xhXhiaO1SsNqFOF+KagPRBn9EueWeVUvbh3XgM
         8gQKGb+vIhFcLGHm25Lybiogv+63lcZEfy5FLY7aYLNvb7FKerXydj306Y3QDKoyPCW/
         uSuA==
X-Forwarded-Encrypted: i=1; AJvYcCXkuR7RW8kS/LgJ0djI1i73eMym9CegYggWMxTYc372P/QaIA1w4t0T5lAhm6tL1zNAPn7zR8YKKjD791s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsvfZ4csRzeW3MfitcB5hvPaZEYZbl0Y6fUH1FziFHOdHBgFlx
	zgUt2gYhDTWSlYvXfbIWIactxCiHwgDgC+khpyW1Axef4Lkaj7i6ZeqG2KsTN4tqP6fPJfurUNX
	qfKPzpScbR8ovyG5CVk67yUqYZxnggUU=
X-Gm-Gg: ASbGncu2cLWC9d5DhHrHZYXvKSW5veQCBWBrCIQ/DhIfPpjoMLljXXC4oUNCLeinyW1
	fo3z2l9g1pKFilU65XK2pWPK0gmkT6JeELR4tP5PzfvKnLEjkj1B5D0rQzYD6XU8Ow5IP8D09fX
	3QkJh4equ5K+WgAb8TEaEYI90ty6bh7fPvInbcZXYzd6EBCMIV93rYUfW1riluwtjIIuV5Iwoti
	iay5p36LTuhSGn4rQ7CYx8EIXqFzANfdPduLhGAyV/YecXKzMyeEYca+D8=
X-Google-Smtp-Source: AGHT+IGUC6+9UkrRywwWWGU2MV3s+qVzGfbXA45ue4Tsj/rDblSjV6K9yCuZbFoS90JE8TEkBbHhcXBLEr05S4MkH4s=
X-Received: by 2002:a05:620a:d8b:b0:873:9fcc:3fb5 with SMTP id
 af79cd13be357-8b22081b49dmr710776085a.1.1762391436933; Wed, 05 Nov 2025
 17:10:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030181153.1208-1-jajones@nvidia.com>
In-Reply-To: <20251030181153.1208-1-jajones@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 6 Nov 2025 11:10:25 +1000
X-Gm-Features: AWmQ_bmCTQVuWSlyEeES5u_487iyQN-Bb540-HKjfSbJe_ACE1aHE1Bnc6YfQP8
Message-ID: <CAPM=9tzMUi_9BRL8onjvXoj8Cb0eQFpFwmKHveGTCRU1Nc7O3Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/nouveau: Advertise correct modifiers on GB20x
To: James Jones <jajones@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Faith Ekstrand <faith.ekstrand@collabora.com>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

I've pushed both of these to drm-misc-fixes.

Thanks,
Dave.

On Fri, 31 Oct 2025 at 04:07, James Jones <jajones@nvidia.com> wrote:
>
> This series adds new format modifiers for 8 and 16-bit formats on GB20x
> GPUs, preventing them from mistakenly sharing block-linear surfaces
> using these formats with prior GPUs that use a different layout.
>
> There are a few ways the parameteric format modifier definition
> could have been altered to handle the new layouts:
>
> -The GOB Height and Page Kind field has a reserved value that could
>  have been used. However, the GOB height and page kind enums did
>  not change relative to prior chips, so this is sort of a lie.
>  However, this is the least-invasive change.
>
> -An entirely new field could have been added. This seems
>  inappropriate given the presence of an existing appropriate field.
>  The advantage here is it avoids splitting the sector layout field
>  across two bitfields.
>
> The chosen approach is the logically consistent one, but has the
> downside of being the most complex, and that it causes the
> DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D() macro to evaluate its 's'
> parameter twice. However, utilizing simple helper functions in
> client code when accessing the parameteric format modifier fields
> easily addresses the complexity, and I have audited the relevant code
> and do not believe the double evaluation should cause any problems in
> practice.
>
> Tested on GB20x and TU10x cards using the following:
>
> -kmscube w/NVK+Zink built with these patches applied:
>
>    https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/36336
>
>  with various manually specified formats
>  and both manually specified and automatically
>  selected modifiers.
>
> -drmfmtmods, a tiny test program that lists modifiers:
>
>    https://github.com/cubanismo/drmfmtmods
>
> Changes in v2:
>
> -Added "Fixes: 6cc6e08d4542" line since this can be considered a bug
>  fix for the initial blackwell KMS support in nouveau.
>
> -Dropped the second patch from the v1 series as it has been merged.
>
> Changes since the RFC version here:
>
>   https://lore.kernel.org/nouveau/20250703223658.1457-1-jajones@nvidia.com/
>
> -Dropped the helper macros & static inlines in
>  drm_fourcc.h as requested by Faith Ekstrand,
>  who noted these aren't helpful for UMD code,
>  which is all written in rust now. I may re-
>  introduce some of these in a subsequent series,
>  but we both agreed we do not want to delay
>  progress on the modifiers themselves while we
>  debate the details of those cometic details.
>
> -Reserved an extra bit for future sector
>  layouts.
>
> -Fixed handling of linear modifiers on GB20x
>  and NV5x/G8x/G9x/GT2xx chips.
>
> James Jones (2):
>   drm: define NVIDIA DRM format modifiers for GB20x
>   drm/nouveau: Advertise correct modifiers on GB20x
>
>  drivers/gpu/drm/nouveau/dispnv50/disp.c     |  4 ++-
>  drivers/gpu/drm/nouveau/dispnv50/disp.h     |  1 +
>  drivers/gpu/drm/nouveau/dispnv50/wndw.c     | 24 +++++++++++++--
>  drivers/gpu/drm/nouveau/dispnv50/wndwca7e.c | 33 +++++++++++++++++++++
>  include/uapi/drm/drm_fourcc.h               | 25 ++++++++++------
>  5 files changed, 75 insertions(+), 12 deletions(-)
>
> --
> 2.50.1
>

