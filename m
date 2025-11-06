Return-Path: <linux-kernel+bounces-887947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6407CC396C0
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B702318C1832
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437462E091C;
	Thu,  6 Nov 2025 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnjn+WBu"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06784299A94
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 07:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762414738; cv=none; b=WbwpZ1y/Qkgq4I7ek6S4T65hD4fHhMnuptkxSVPiw/Up7Mzfr1itdZ+0pjXR6PjwqiVzMSEIo9umhhCLb3gr11PmXLLcHg89jZFstDgeyI/jE4Q9pbbYGDq8CAC7mvBcy1hTkMQI9GBUyIeTR/0oajxrVfT2oFI3I3VMdGLX4jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762414738; c=relaxed/simple;
	bh=9WY8TkOVRVvU0etW8GXaJ6y6IJMbzV/8HNDNoXC63/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPtcr8+4X6sDZ8gABvBx60ThqN7JEvcisunRQGI6pVAhoHqPPgFRjLz5X0u41Uz1QyIEKT5t476l8tk99IZdNaYNnFu7uMn/Il8LEoW11HhZSf1JaaCW/xJtE0f5GDvJTtItW7Ts2R0h0TN4v7Vh0dgAWvAFOwEAwmR6ZxL4smA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnjn+WBu; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b67684e2904so392233a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 23:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762414736; x=1763019536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EwyKXogPaS7V5uYOqhOp9kneyXDbmoOn+o0TDUIGVY=;
        b=hnjn+WBucjvaOJBk3nctSLxYcsQ4rRHHuJexM4YtGgQAmF3EKLNwy6s6PqUwAT+Xxv
         Oo3YR1Fbbx99WgE7HrQ2S+9rBL7iymuuQNuMemXGm4RmAzZOq6ov/4I7Yt9tIFWhwNOb
         FBae9k0PuC/yAnoKnw9UiVwkgHMQJsmTxB7u9cr85J8DxOq8TniSz+iG/GLa11+TzUG7
         ToodWfkTXI8F5xKYOF29ERQIeZrphXV/UVousdb38r0DfKSIHKOQmc5DjgEkGEt1bRyF
         lLWBbMZYLu+cp9o4p4SH2WppqbGJPIv5IGpXfBmMoXicA663jlAMuu0+ZvdX1TAw+U92
         Wrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762414736; x=1763019536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6EwyKXogPaS7V5uYOqhOp9kneyXDbmoOn+o0TDUIGVY=;
        b=SR6pONUrqxfNOxQPaV0BA1pWmtbmQ0dyRnLpv+rDB22HAbtZiDNS1TkDG5mnFBnPgH
         FT+gcJ2tUevVR7+dUhR7VRpZOaJMUJrhUoFAlunnAyXTdAio81AjivpiZTgjRGlayB5r
         c/5w6GTv+JNx6JL0Qle+H+CBQGxFTCXUzwt4dFPXHOFVyVffR5DQJXdDznXB5Igy2YzJ
         /10ULekNGwJS+n4zaHQcoaNrkk6h4SOhfax55BDtnD+Xkdlq0eBIyvAQTFOtcoxoYmUD
         qo0Lu4l23piZc8eq7bAuV5UXQW5qzlVOV64goUn2kscimex2Lo0s6tev7zbsu0ACPd0u
         gDwg==
X-Gm-Message-State: AOJu0YzbZNiMgxQ/NZq1pIABs21LA+rYqUhcS5+hCNjvxPmo5vY5hz6K
	ABRsr7/i8+NfD2mpTaFvM7UER5EVi0oFLpe3iKb+JWBcyh7r9h/Ms3Bt
X-Gm-Gg: ASbGncvAn+CRs6sLuv8N2oXrSEG16ECWXYi8nwmHlA7ZfBRK6CeE7sHvqXcCDYt3iEt
	KpDVsSldbInIdhyNFVAab91V3siPf9tjYJ5exIYDN6n+ufIv7d8tswGCqCcaABH1SmVx03Xlm0y
	+Lvgcs7mlsGARv6F6CC8r1pqGOZD7R6sNG2Exc+Dj6m36TNRwyspEfPzCkSYH95B5vctdhmEziJ
	FdBfHneQfuS+mmP9SZpHfYGRRq0Yir3F0OiRPM6z4yJBJMPrUSY/ljIRcg2bkPsgfGYVcTLs3sa
	DLQ2Qg+4HSv3pxljElDUZrBJVAwh3jSKsW13HzUJccBoQ32m22ExC8lFn9l/41hdjkR1I2rpDT0
	qDPmnOE83U2gZzXz4E4w1iotRPFtywJRAWv439tXwI6jH2bsTqM/bph7BeO4YZv9bZnWP/y3YJ9
	Y0VN9ICqWop0w=
X-Google-Smtp-Source: AGHT+IGcetcHDEJ2pWdGp2wrehN+ji6EM3hz8DX0d/sJvq5qjS4UHY5JTdyluUbtQuWersYXiD1kdw==
X-Received: by 2002:a17:903:2a8f:b0:295:62d:503c with SMTP id d9443c01a7336-2962ad193f6mr95598365ad.16.1762414736274;
        Wed, 05 Nov 2025 23:38:56 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cce763sm17981055ad.103.2025.11.05.23.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 23:38:55 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id DF1F0420A6B3; Thu, 06 Nov 2025 14:38:52 +0700 (WIB)
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
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 1/2] Documentation: genpt: Don't use code block marker before iommu_amdv1.c include listing
Date: Thu,  6 Nov 2025 14:38:44 +0700
Message-ID: <20251106073845.36445-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106073845.36445-1-bagasdotme@gmail.com>
References: <20251106073845.36445-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; i=bagasdotme@gmail.com; h=from:subject; bh=9WY8TkOVRVvU0etW8GXaJ6y6IJMbzV/8HNDNoXC63/M=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJk8/i9Tl93VuN2yjltXa/2B/umzNayvaO7tDs2cw/vnY MOf+f6pHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZgIeyEjwwqBny6GKi7OLBqh V5S0c69YW8UdbAyt063teJb7RO+jGyPD4g/ef74fvxpyufhan2n4Q/PaUwsLs7Ts9dyavtctf9z PCwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Stephen Rothwell reports htmldocs warning when merging iommu tree:

Documentation/driver-api/generic_pt.rst:32: WARNING: Literal block expected; none found. [docutils]

This is because of duplicate double colon code block markers: one after
generic_pt/fmt/iommu_amdv1.c and the one in its preceding paragraph. The
resulting htmldocs, however, only marks the include listing (after the
former) up as it should be.

Drop the latter to fix the warning.

Fixes: ab0b572847ac ("genpt: Add Documentation/ files")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20251106143925.578e411b@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/driver-api/generic_pt.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/generic_pt.rst b/Documentation/driver-api/generic_pt.rst
index 210d1229aa1c1f..7a9ca9f2878d4f 100644
--- a/Documentation/driver-api/generic_pt.rst
+++ b/Documentation/driver-api/generic_pt.rst
@@ -27,7 +27,7 @@ compiled into a per-format IOMMU operations kernel module.
 For this to work the .c file for each compilation unit will include both the
 format headers and the generic code for the implementation. For instance in an
 implementation compilation unit the headers would normally be included as
-follows::
+follows:
 
 generic_pt/fmt/iommu_amdv1.c::
 
-- 
An old man doll... just what I always wanted! - Clara


