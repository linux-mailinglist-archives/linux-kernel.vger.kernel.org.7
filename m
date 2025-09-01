Return-Path: <linux-kernel+bounces-794839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48093B3E7EA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0741A85C95
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88467342CA2;
	Mon,  1 Sep 2025 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxOG0CvA"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388EE2EF653
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738339; cv=none; b=mfMUSqa95h5HseTIu5KrN0MWkwihuv4Tg1lsKJ6HDKhGX2OlbhDM2s8E7aMcUZeXWgeRdAvTdoMRACddvw86ehKbURsAKJFbtRoLL8wCrAThGXVr0EWMiUt8YZPEuQYyhWODGZBLOTvX1+nLfOH7RdzL7K25eFXY5RJlufgatZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738339; c=relaxed/simple;
	bh=oYrCpOg+PZ7ppTarioyoDFTz33sLAeeLvzvmzstCgdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDOf5vEJkP8a1bABG4cB9fPBu2ZEgopWtJvJZBqJhAT76ngYijWeTJ0UsvAUN3sr56lhm/f3EkprpLR1cFke7dmgqUx8mAdqp878K5PRoRk0rBNmglJE65n7EVD894O839W7xKDM6OdBrgRKybMGovKNhKM4HZe+fU03MtKu7w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxOG0CvA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b87a13242so15964885e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 07:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756738336; x=1757343136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7w1Tbo1J3hCx1txGwhp2+EuzkbUEfr2XiGFdNUS8Gbg=;
        b=FxOG0CvAFfWNidDTXT7ELMY1NuqJPJi8m3fAGOZAt8tKMCCcpcOePiOX3s13Mtt+nc
         MP7sdOq7y/J7U3NVCf7afjL7ndUzSoKWCcZHyPXAWAP+gPbR3q7yE74NK/03lGnqMCcu
         Y8w0f5dD80fFbi9pCyMpXm+WyaZuXtfab75zsWqMTmoypCalFBa9za110sAkQaZGO/Bf
         64pNejCsIrqeLAaBY1OA3rWYeTmbpnM1kuX+jwSjICu0cXlpFhcI2MTW3v/dupjqjxFE
         HIFQ27Bs8ZifpteO5UgUwestZLXc7DPYN9TejmaqrVGTkHEirG77hkZnW5EupeeNHuqe
         ZJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756738336; x=1757343136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7w1Tbo1J3hCx1txGwhp2+EuzkbUEfr2XiGFdNUS8Gbg=;
        b=adOHhelJ2zvtPaHNENw7iqiUVPmIGhpao2T5GfEJcj6Uddk8HzsnVaeWe4Q9jYxfMl
         KJyd2rj0kPSofXY9sOLDogm1mTIBFxvCUG/beztLVxbVR+pIC/Nq2r6kPEOKllEf4gjD
         2U7iwujbsbUbVquy23OQAwBf7rmN4MYUYKMzShI0pJtZUjSuM83O/iQ7D4xa2wNqabCG
         28lMSmF2yMM5y9sxfb5d2ELSGOQj132S2/UxRREXUnfn2TWYDkXyO4vXwYZ7HOCRWMPj
         7Jw2m+PoGq4NEL3pKmpHuUYtFFIJhGpvAIoLSjw3YuZWuxKYV+z8ZpGs+IjVfbbDa7UG
         5yOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3aIDnQ/zcdTu6bhhKwk3BgNE5PkMWwfkssyd4f9ZM9PpKDvc7/k1VNvC99AEelRnk7cXmBRd4qRXBGpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPM5EgkIClaov9cqZto+V7twz+xGjbNX53v/Ll19P2+EhRvTC7
	tKo43OotAXfO/PwUL1I/R9RMoJMAjuIfrmkG3/ZVdCBLkVNqJdCndFtF
X-Gm-Gg: ASbGncub5MtfjMg55jXehrqFzhRE/6opyg6Lt39Qus5ry2QHZREi82LmAe/zWUHMeI+
	+oD/34foytXoXl/SgTbizwRSwynPNz78+mUVOKuaKg6yav4G8uxaNQFg9tRxKUDGLpMEYY3LGWj
	fGEhib7tvoUtIk8Ou88soB9jHI2vLOBrFyws+053mTLcD7qgsYCQlp8pEn6IkmSq4F9TTktvQW3
	kO78U31R3KOkWhF3DdJtFPlSEg4lOmbfiX97RZPzs5/R9ZB/HFxFIlHkPV9o3gNXHAh5B8ZqaFc
	2ErM0xfti/56X0e+3qgzhOGchhiO8xHFa7NK8CcZuqafHOnQs6AppwlvpmyPXC6l9FpC5rYG2Vf
	ELVWRHASSiuHaQlwjDYlK9Wt9QHks
X-Google-Smtp-Source: AGHT+IG+SvqNSIccCz0rsXPSX3cW6clNxgls15pKY4xfgXvdWIzmy6IrSvkz4NehpGFyAP+osZ/C2g==
X-Received: by 2002:a05:6000:2409:b0:3d6:89f0:f348 with SMTP id ffacd0b85a97d-3d689f0f684mr2925978f8f.15.1756738336309;
        Mon, 01 Sep 2025 07:52:16 -0700 (PDT)
Received: from fedora ([94.73.32.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b69b7529asm146874265e9.0.2025.09.01.07.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 07:52:15 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	melissa.srw@gmail.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	thomas.petazzoni@bootlin.com,
	tzimmermann@suse.de
Subject: [PATCH 0/2] drm/vkms: Fix plane blending z-order
Date: Mon,  1 Sep 2025 16:52:05 +0200
Message-ID: <20250901145206.51213-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250801-vkms-fix-zpos-v1-0-d83ba1e6291d@bootlin.com>
References: <20250801-vkms-fix-zpos-v1-0-d83ba1e6291d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Louis,

I already made some comments about zpos here:
https://lore.kernel.org/dri-devel/aJDDr_9soeNRAmm0@fedora/
But let's start the conversation here as well!

> As reported by Marius [1], the current blending algorithm for vkms planes 
> is not future-proof. Currently the z-ordering is only garanteed by the 
> creation order. As the future ConfigFS interface will allows to create 
> planes, this order may vary.
>
> To avoid this, add the zpos property and blend the planes according to 
> this zpos order.
>
> [1]:https://lore.kernel.org/all/aHpGGxZyimpJ8Ehz@xpredator/

In case you want to have a look, 3 years ago I sent a patch adding the
property and blending following the zpos order, but it wasn't merged:
https://github.com/JoseExposito/linux/commit/befc79a1341b27eb328b582c3841097d17ccce71
The way "vkms_state->active_planes" is set is a bit simpler, but it might
not be valid anymore due to code changes.

About this series, I didn't have a chance to run IGT test to validate it,
but in general your code looks good.

My only question is, how do we avoid breaking changes in the configfs side?

For the mutable/immutable configuration it'd be easy: We set it to
immutable by default, i.e, when the user creates a new plane via configfs:

  $ sudo mkdir /sys/kernel/config/vkms/<device name>/planes/<plane name>

We set "planes/<plane name>/zpos_mutability" to immutable.

However, we don't know the plane type (required to set the zpos value) when
the user creates a new plane on configfs.
Therefore, we can not set the correct value in "planes/<plane name>/zpos".
Have you already figured out a solution for this?

Jose

PS - In case you missed it, I created:
https://github.com/JoseExposito/vkmsctl
I'll add zpos there once we support it in configfs :)

