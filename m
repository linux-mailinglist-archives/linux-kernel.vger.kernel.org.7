Return-Path: <linux-kernel+bounces-846120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4407FBC7177
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 03:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 821304F2ECC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 01:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E04158DA3;
	Thu,  9 Oct 2025 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JV94uVsx"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA96156661
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759972222; cv=none; b=I56n2uNz5GakS0zATvWqpIo73rKo7Csz/YOdvUMgpdQL62UkADHgmwgX/KJ2YrjYeiu0XZIEWRrf3tk69DriTjO91cyZfEY+8tvuF4f6b99mf5wblVGQjPGEeDx3DRwOz11VcjQwe6Ca3Hc0z1GW/kv9EXGrVeAJhOI/ByH5aB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759972222; c=relaxed/simple;
	bh=Z2GunxP9dzRpizbeVrYcXFYzJMj3akQ7EknkTLYOr1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+HHDuPpIRpqFSjD8NpIkFep6OE6182HxkhzLuwN2kVvywsOqhOr3By3MIqbYg0/7K/Y5AVyog2QKBSJfXg5z1gTWXmX1cVwffd0s/ubC/BNvADbdkZCljjHKAPekuSKkPSMKU/BM96RrvrmmMcy/eOwq5mWlwdsE8cMTaFxAjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JV94uVsx; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso711268a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759972218; x=1760577018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHNwCzkNohYs+pMN4B89ykQsTowN8bxnB/b42VHF3Kk=;
        b=JV94uVsx6mmgT2gsalarFprfFhXaEjTkOzcB5ms1KuAjK+GjRa9Fv2ISh6cEQWFMPf
         kg9NbVJwNPehpOUWsAnyyNlQBB/imXYiaJ+e9ejoO5Wu+Xh4sVJ/R+fcrZPZP4n5oHEF
         WcXAOJpHpLl1GAf97U82+43r4Z8LBtc4OivHvnb5s6DZn3K3lR6O2X7FbJ51sPdWjStQ
         R639MyemS+L8JHKeILx9c9yTdrtkABn3AdGfHpoe/r9uLSPrd32cRh4iTaqsGgAvncN3
         3/no0JTIWj20qlrWz+LdSLBFQY0OiBCuEixf4/mdqIF8Vt7npwDXA46Dzyl5l7mtHSDb
         B3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759972218; x=1760577018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHNwCzkNohYs+pMN4B89ykQsTowN8bxnB/b42VHF3Kk=;
        b=QpineprSayaOnrPxKgCmAPZ7MfvJw8W/xx7IZsveKyToEs/xNebF6JefEFv7VIWYpu
         0YhY3AmN+ZQQfP96Qv3kbLJI3bBLYuXKy+zasM7wvZguQO7F1zTiGM+b3lOZG65cfOrg
         ev2ojmiExdLm13qMwhdmNx+9mDeVHVgapRbx6ZomSq5cy8ZqbWy6nL9f/n7zp2gYsgtJ
         XI5da0TxkM1sFh4bb2lRfp3UhbDQ5n6JwsYWb5RJ6iqrYFBn9hv4G4AsMrG8mkmXNasZ
         sB6fN8awEjka0tbSwOldR/vNHhdkt5mcOaynGH11teTGSGX7JQBOJTEOjFokxJv4fTSL
         g1ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWc8S7FWUoCtKGEWeGgpGtPeiyPYgtFfl9EXbZNu3usbXY9rWLm7F0oTLXYxdY4z4Konhit2zOUkxW/hI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBwJpedVCJVyFQhLXrJs4Ofv8HmF0Rxzebsu9ExNFo2wnK9JGo
	7TjMU9xe9u9INUWal/0gi8PYwfIYrkiNbkL6KKJi3QlmP/c5QwubVqsR
X-Gm-Gg: ASbGncsUyC09ipqqfnp3SbHqX0xlw6Gg5jV3WcmZO4EixCt00jXFLxEV5sYYRhMUL2x
	YIGYQ1pqZpEut71A9dIdjiPqe0w81xBMYGeSg7SxNaCKrSjCkK1HwsOsiYy0eEzKbralg3G89RV
	b4PVjiNdnvK3baii1fFTHEnqb47O5eAiDdugKoqzpvXyjHpNd+thmKQXhZ9eE9yaM3ZSklz6Zkm
	Kn7/yciar/5pKZbXkNGBC2jZt1mIfG1+0yBFa44anqGLnzpI//uo2vHdCGOmUcfG0MYY/hWKHjc
	ieyBMuiK5Ud1LUZwAklsFDVOzevtmOjjGEcOUV3HhAdfckyPkbfhlD3uBevIbknfMTpLSQO0cxh
	70ZuSIn6WvMMcNLYq+6doeaZT2exTBqxIqr2yXp8lBhA=
X-Google-Smtp-Source: AGHT+IFUVSoo1eoMPJWEELwFIyb0TmQNTBhyRzWwaIZEnkB7f2xM/gEhdtxapqA11Ju2Mj6UA4MtcA==
X-Received: by 2002:a05:6402:510f:b0:62f:5992:a64a with SMTP id 4fb4d7f45d1cf-639d5b7f489mr5361550a12.13.1759972218246;
        Wed, 08 Oct 2025 18:10:18 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-639f30ad247sm1240289a12.7.2025.10.08.18.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 18:10:17 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: jia.yao@intel.com
Cc: alex.zuo@intel.com,
	chris.p.wilson@linux.intel.com,
	intel-gfx@lists.freedesktop.org,
	piliu@redhat.com,
	linux-kernel@vger.kernel.org,
	shuicheng.lin@intel.com
Subject: Re: [PATCH v2] drm/i915: Setting/clearing the memory access bit when en/disabling i915
Date: Thu,  9 Oct 2025 04:10:00 +0300
Message-ID: <20251009011010.37763-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007202514.1661491-1-jia.yao@intel.com>
References: <20251007202514.1661491-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[It seems this letter got lost, so I'm sending it again, this time using git-send-email.
Please, CC lkml additionally next time, hopefully it will work better than intel-gfx@freedesktop ]

On Tue, Oct 7, 2025 at 11:25 PM Jia Yao <jia.yao@intel.com> wrote:
> Make i915's PCI device management more robust by always setting/clearing

Thank you! I tested this patch, and it indeed fixes the problem. You may add:

Tested-By: Askar Safin <safinaskar@gmail.com>

Please, CC me with further patches, I will test them.

Also, I will repeat that the bug doesn't happen if we have
CONFIG_INTEL_IOMMU_DEFAULT_ON=y.
So, probably we just need to patch all distro's configs to include
CONFIG_INTEL_IOMMU_DEFAULT_ON=y
(Ubuntu already does that.)
On the other hand, if there is some deeper issue to fix, then, of
course, I'm glad it is being fixed!

Also, please, add some "Fixes" tag and CC stable to make sure this fix
will be backported to stable kernels.

For example:

  Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
  Cc: <stable@vger.kernel.org>

Here I chose the initial git commit, because i915 always was in git history.

-- 
Askar Safin

