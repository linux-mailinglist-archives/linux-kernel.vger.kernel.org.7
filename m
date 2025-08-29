Return-Path: <linux-kernel+bounces-792473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A49AB3C45F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9218F5A336E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF5F2765E3;
	Fri, 29 Aug 2025 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oiej0Fcj"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE23D275AEB;
	Fri, 29 Aug 2025 21:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756504235; cv=none; b=CXUZ+Ir801moNQS9hl/MGBUWIq/zzjdKsv+OScwAWDR79t9ahbKQiadIGmxEVXCFS6DH+f5Cv8VzbB56KAWrZ17l6YJFywb56XQTwv/2px2iXaelCIYxE3VE5U9Stvh6muennXX30LgZhrExlUwsRXSf4LxJY1H5J6k+PkFaCpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756504235; c=relaxed/simple;
	bh=oPNcCKmYSFesMMVug0H5hxc9ayrY0QdtNp19H5l1bxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cuYnWqoDKLcuDmHp2+cbanbjS7cSbKD5fX4o4HIV+AYUg22mE9xBTeS45fmdidBkLC+Aczl0uur1TZJsXJhazNGNdciov4UEkxj+l8mzv4Un20fB7pSqR/DRBMrc9CVeFbV4SOipySSYjq9lTOh6VJLBKjFDAD/NeceTXodrobQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oiej0Fcj; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d603a9cfaso19670747b3.1;
        Fri, 29 Aug 2025 14:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756504233; x=1757109033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9q+jxiJZlQB5ZBqFSf18qlf9A4B0dAOQ/wntSaPJcjE=;
        b=Oiej0Fcj6nY2LCyNZSV0f9RP9QvL5yYs9gwaVxaRi3u+qzCbXODqXstlhVDRSK08m1
         sDTwNegyC+qOnHOPtOgEeqvByKO4KxAki+uolhY3vJ2wQQQMMbnV06qZbThUv7l8hKC+
         FCNj6eDKg3YGYSqtzhxJLGrWYVHfppV/ioRkXKVoFY9e5N6eZJ0o0enazGDTlF7p4SUq
         64tXs5huefhDXu35V1VRxOuWGVMOIBUCBIAhrwA9SO4qMg23g/kAVkfFqyPsRehrlcHY
         daJe1poci1wyJo3I1tnOgrBwv/Ao+rBXfdWqz98A8khkrRmC+3o8jCKBM2106wRiR8bE
         j6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756504233; x=1757109033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9q+jxiJZlQB5ZBqFSf18qlf9A4B0dAOQ/wntSaPJcjE=;
        b=lT8uAL9Srb06p9uW03BQfd2JOrjQIQNU1epbBY/6a3iz8LXquf+lLx7ncK5c6ieMZf
         5CM6tNFKXi9OjSMMJsvQ0gH2jDSiwUqc3tjHMbu/synWdKg5Imuhm1T3+DX2B2P9nWti
         wFLr7V9cWGjoqlgaDS9WaS9H7IEE0y25j2UKoneNJ9e0rpR+0vid9yabfzUbe2dS+uva
         ckWrCoxPUEwr385iKNLLzmg6RHyZtHQ8dhP8Pmr4ufCfPANGhe7WNSR/GBN+bXZS8mqr
         qXrE4FHsgOsddeIkffFjT5dbIzxJsgRqomkXdoD5l6Xjl1BtBY0TO0Wb6VKHy/Akmaou
         x7iA==
X-Forwarded-Encrypted: i=1; AJvYcCWG8HUpLO6Jzg2bph+LvQeVjdSfIL3lBYtVtq7pJT0azDPXnunduaUXaZMH9DZdMclnMi9nJs/qiMvXj8JI@vger.kernel.org, AJvYcCXsre96sDnSmCDzYjymrL4tG07z0LLkt5ep23J/ATS1KSELuMVk9mAVtVeU7D4xvsaI1rh9sWHmK211@vger.kernel.org
X-Gm-Message-State: AOJu0YwL4C+Cl7hC2bySyJ/TK8oMgUBmcj5I8u4k7PFeYyJQaJwCZXmB
	U4MVl7XIhvzBEEFYZDUcBh2oDLIvydnIKwFLM69nadk71vCIEtGmnEDvivQLY9GxsPrvQed/Yf3
	nl9p5hLv6l+e3WGuv8Ao8n2LNe51dDf2qzCtl1DCfhg==
X-Gm-Gg: ASbGncuNL39k40Av5/jVze1GIbiEJDRenqF8d9/JvuI24NrZiCCYCY6HWX8dDhcbJk8
	erpUMGzaTnv/oKQ7FlvFzDfOmVE1YCjzOalxtfFKJLrnyEdNPPN0HhRvpf+Hwp7GCmfQDP5tyvg
	X5UyhbK3Dk1zRTzj3miRJF8+XqrkHrbVrfM0T3wdqfVPSP/DUhZ2Brw7aBGneaoeyeo0olMcNup
	DuMWIibJaT9EpQvEfoo+kVRxlGh5UraOcDg+KX1
X-Google-Smtp-Source: AGHT+IGjg9C8+gDlUZd5wXGQOESzGBuvn3UbTua0+WEP1zD2LAYBsQPLu/csxwx8MuvlkFvU99dMLaFufFMuXcizmVs=
X-Received: by 2002:a05:690c:7088:b0:71f:f3bc:3b9 with SMTP id
 00721157ae682-722764aca8cmr1699697b3.29.1756504232569; Fri, 29 Aug 2025
 14:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828201806.3541261-1-olvaffe@gmail.com> <ac4838eb-7613-4642-a007-577a9f665984@arm.com>
In-Reply-To: <ac4838eb-7613-4642-a007-577a9f665984@arm.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 29 Aug 2025 14:50:21 -0700
X-Gm-Features: Ac12FXxWORzRnCGgs-ncJDRqcsocabemqRb0a-BtSr2XrSnm8PhUgTVO3SI4oew
Message-ID: <CAPaKu7SYptoVNfUgT8ok1mwRk9BZpU7z_XG=vE2_nkJ5hAj_8Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/panthor: add custom ASN hash support
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 6:41=E2=80=AFAM Steven Price <steven.price@arm.com>=
 wrote:
>
> On 28/08/2025 21:18, Chia-I Wu wrote:
> > Some socs such as mt8196 require custom ASN hash.
>
> I don't know the full details of this, but I'm puzzled by the "require"
> here.
>
> AIUI the "custom ASN hash support" (or L2C_SLICE_HASH as it was renamed)
> affects the efficiency of the L2 caches in the GPU. It basically
> determines how addresses are striped over the individual caches.
>
> So (unless there is a specific errata) not setting a custom hash will
> work just fine, but the performance might be slightly reduced.
All memory access results in faults unless custom ASN hash is enabled on mt=
8196.

It sounds like this is a soc-specific quirk.  I will check with the
vendor, and likely turn this into a quirk.

>
> kbase provides both a DT option and a module parameter which can be used
> to override the defaults (although the parameter descriptions say "for
> testing" which I think is somewhat telling).
>
> How we should describe this somewhat depends on whether this is a
> specific workaround for a SoC - in which case Boris's suggestion of
> using a different compatible string and panthor_soc_data seems like a
> good choice. Or if this is exposed as a general "tuning" parameter, in
> which case this might be appropriate.
>
> I believe the tuning is related to more than just a SoC (the external
> memory system has an impact). So I guess a DT level knob makes most
> sense here.
>
> Steve
>
> > Chia-I Wu (2):
> >   dt-bindings: gpu: mali-valhall-csf: add asn-hash
> >   drm/panthor: add asn-hash support
> >
> >  .../bindings/gpu/arm,mali-valhall-csf.yaml    |  8 ++++++
> >  drivers/gpu/drm/panthor/panthor_device.c      | 28 +++++++++++++++++++
> >  drivers/gpu/drm/panthor/panthor_device.h      |  6 ++++
> >  drivers/gpu/drm/panthor/panthor_gpu.c         | 17 +++++++++++
> >  drivers/gpu/drm/panthor/panthor_regs.h        |  4 +++
> >  5 files changed, 63 insertions(+)
> >
>

