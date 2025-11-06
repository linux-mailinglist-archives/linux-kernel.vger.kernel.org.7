Return-Path: <linux-kernel+bounces-887946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 205E9C396BD
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE2284E5346
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ABD2DF717;
	Thu,  6 Nov 2025 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHOgH7zG"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066A6298CAF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 07:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762414738; cv=none; b=FoPNm1c7zyNL11nrCG4Bcz100aUiZjO+uJSZQf5cNCagKv33uqLiwoEhgKAdtrJ91N5UAy7Xbvyh5R4AqejGFQQa3+kI73yy5C3kJHmQTs7wXIeN/H+/zuOBKBx5jry7HIyyIrU7/mCP2rMlirks/15KZIKNSNlzpipgoa8USyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762414738; c=relaxed/simple;
	bh=fHpHqdj6evMaMAwbOPs89dx0SybJWtU+E52RFwbkzc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MDbHvuZ8W35i6XBvhVjr8MN1h4Yuo2ozGSIt9UwM6yLI/gqePmbwJ6UCDZ8wDs9cirCaBGHGHoLewbf/3VaMzmdx+BqB6SZpJxkbf6rM8MVhF5Pyis8M1BM6b1kD2MWdrb5xAQDH+da1DuNHtdHFVpgislqn+c2RO46movjXWCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHOgH7zG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29633fdb2bcso6488405ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 23:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762414736; x=1763019536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W74SW9CUtH8YSGxvzwDmnorAFynOYsju91d1AAA1bkk=;
        b=SHOgH7zGORtPieXbge6fT2x9yo/yJNVJLRJAXUWpp0OvoN63IqsX/zK4oLYoQNOWZI
         JCu+xwrKE0koUTb5vnLqYFGLhk4vAOnLusOwP2Qxv1a6Px6KqJWtS955MQYFnNkLnlbp
         Cm9IwyU4pTYAHgLKwVkJBmsPkg8z3bw0uEqlIzePyPh22qaHFnrGpiwsB9HVW1o+HR/f
         JUFNcfoMWslB07Myk3Zzi0kVuBi61mtsH92XRa1K2ommh7SBWTi+4v1Em4TrOryFfYeo
         QTN+sV+cYVxQBa4ftJz7lVDyCDfoecRMwMoECQCo/6oCUoxZdP89KW4lj+gEg6HWpicU
         SNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762414736; x=1763019536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W74SW9CUtH8YSGxvzwDmnorAFynOYsju91d1AAA1bkk=;
        b=r3o4mVNxMg/m1fx+FtncRylvXqgbyafGQT9QpiIpR5QvpFGV9ECiDOCszuEp9OzQZ5
         Bt6c8ikqdNhnoUfuWcnIevD/NfuZox2ZbN/kYRWIQNA+YTY1qa5flRHykeHVHCv2aIsY
         35NjR4yMDWyFcKpd4q68Vajo8/jZevBHk8lYBxhJMRBZK/0JWjnh2VcBSf11HD99Lz7X
         uYfLfGlmrXc0lF/iz6vIU2RaBUm8R2du6+IIpBZqW1on7Hm3ENulDMZY8y+UfXC7shZr
         4meKVoOAj/n0+qya/xyvbrkFHWwFHh4w+gULcwKbuFmx9ie8QQ0x4tquQH+y8ke0Jb15
         SuTA==
X-Gm-Message-State: AOJu0YyzTLuFy4U5XUae+FuyFA+1KnswBrJ3hKnHeEyREO2wA5Vg08cb
	BDkzvxy6C9udzkAciwhPSbkaa24k6893u8IS2tfdS38czOTJt4leC70D
X-Gm-Gg: ASbGncsQ9/kd4tsgg8C77OWIqyrnKLSr5oLcsg/8Jt1zjIv6ZDDZdtb83zyPpb33nj4
	Kzo34NYmBLBYiRPzkMNBFXNG36/Ki3erkJs6HQIzbQnumZqzjQDInXi5lagzgxxs5gpg4/ahwIg
	ztKAnhTV+61gDZc/n/yWP8EgdvDdaziblt1sWaZ9ELJ31H0d3WudLiQrNXzZEonKvBvnVd9e1xI
	acV4GUiicRd54SEUidMfI7SFjGJsOmZ80oanPxfwAUs6fMhfhenUYAMT9KdswPccLaXoAd/DW8i
	h3xg1khY2v2K1kN3rJCR+cHG0/poLywnqj4Dt2q09iR2Eb2LHsRVohoDJ9zfdWKsuyXxqROXcSF
	J9uGomxP+m2XVOReHxbCVfJfArmJ2DjGcUiDL2sOXSW2q8yeAfinPjzPcyZjUwEMgbjtkUSAylF
	697ohD+I2PtRY=
X-Google-Smtp-Source: AGHT+IH5By0meVnQ9qhOd0v1dNWouNpBeUnyg8cUDtnc/vnhavHu9EHhWNQzZaDdLMGKI0UHiqsGCA==
X-Received: by 2002:a17:902:e801:b0:295:2c8e:8e50 with SMTP id d9443c01a7336-2962ad88b6dmr93261795ad.31.1762414735847;
        Wed, 05 Nov 2025 23:38:55 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ca1eb7sm18451465ad.89.2025.11.05.23.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 23:38:55 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id A3801420A685; Thu, 06 Nov 2025 14:38:52 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH 0/2] genpt documentation fixes
Date: Thu,  6 Nov 2025 14:38:43 +0700
Message-ID: <20251106073845.36445-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=746; i=bagasdotme@gmail.com; h=from:subject; bh=fHpHqdj6evMaMAwbOPs89dx0SybJWtU+E52RFwbkzc8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJk8/o+fmyZ3n3i9oCBhSdKKY9OONbWdFd38cSPf8ewvV X7JCduOdpSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAizXsZGc6KqrfvqfxneLHS h1PwzMVJTDdqr3x2jHx979X7y1p/Nukz/OHQnqrrrBAvvqldJ7MxP3qWXrHerku+jWuXTYwItOk OZAQA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here are fixes for two htmldocs warnings in generic radix page table
documentation. The first one is reported in linux-next [1], and the
second one is also found when making htmldocs locally to reproduce the
former.

Enjoy!

[1]: https://lore.kernel.org/linux-next/20251106143925.578e411b@canb.auug.org.au/

Bagas Sanjaya (2):
  Documentation: genpt: Don't use code block marker before iommu_amdv1.c
    include listing
  iommupt: Describe @bitnr parameter

 Documentation/driver-api/generic_pt.rst | 2 +-
 drivers/iommu/generic_pt/pt_common.h    | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)


base-commit: 75d9ef7cf1e694e5c0fb387be99f04acc7f864a4
-- 
An old man doll... just what I always wanted! - Clara


