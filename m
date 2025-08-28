Return-Path: <linux-kernel+bounces-790684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC66B3ABBD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3A31BA84FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE84A2BF01E;
	Thu, 28 Aug 2025 20:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="YXDx/Lpt"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8278286D49
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413443; cv=none; b=bNKH/mwHXLwYeOICUCwDDujYAMtLMctt7iZpVDMhZXtIerNys5tkgaob6/wFqTsxHMA4DAv1aQMQ74Bby8fSYkdmt1wkvDI+DcDOlLmwCq7q+aaS6+go/M4Uur40i73cBB/LpIE6orf8QIA7MBXzgO+YMRzPN7GZdZiN438CnGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413443; c=relaxed/simple;
	bh=4A+hHQVDvywK8T/Ae9Z8hdT8p+fMiZHJ8U+tYoMJ1ew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PzatPmPTSJAPp37yI/7Kb5LEyTU03agannwimM6o82PSKCgzTUjeZUvdj8QbjWGF8iXkmUFXEhLrgSciC0AtxCddz7MuVH24sneSKIxoH46JtcwIBiMzQMA+9VTsqQRw63+3mwXCttuPNSuV87NcxpKJxGOegHC8DZGuu5C+AvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=YXDx/Lpt; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e8704da966so97925385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1756413439; x=1757018239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KVnydNepin/bD+gaNKF2yJ3IfALHgiOLd/oO8fikfzw=;
        b=YXDx/Lpt/EW3KmdAPCVDBz7hp27A+icvolI6ULCfVIIi2PeAQVmHCBFTJEwgSNnxAo
         Etl9tsdrLQUXxvR+w+vuidgE+N4XBLiLOMYiQckXYrzEfBddI05X0L61yS5M3vpDbr5i
         xbrk6GeRHwpCFxExZI6cvWbUoijjsiPjFKCGeGnzVmU6jUAqQvwIgAsTO7bgG2ZmDsAh
         ov5+K9ELqpTlg26xLH+9PfkR1lCfVpbZN7JYiuB09b8z2DN1ZC6RAgKwlSBIXyS0UJkd
         rG3npumqnLYcm2noV5VHQh2PTzedweXhdEs65tcXcpQKdhGJDa6vBW98eH21dhFGju+Z
         gPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756413439; x=1757018239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVnydNepin/bD+gaNKF2yJ3IfALHgiOLd/oO8fikfzw=;
        b=cy946ST06vKTj9vQ3+78BVeOPCrQu/zH2RIV6kfsvXwpiY8JCCAzBD/moCyU2C1ZCj
         rUgRq4k7UFoyWNEra7ueTuNzaxilTH1KgI/Aw+33PjVn3BYjxzV1WTL8uHbpdUQx5oNU
         B4Kq+NlPZAE1EMHlewDJX/FggTr++RSvvoWBUTbwfzIW3xnyBRoac53rZH7Ar5EPkXeO
         hXHGplFKRlxQ5+x2oKTZuEsX3QhS7bl4c1IFoFl+CYissPis7UPPO1ZCN3uABSFTLGxP
         Ld9/7R9WPco705YgZ7QvmEfTNG0nV5D+QmSncY/mEgdS/RufUGwiW7HZoT9rD2cjgSHS
         HXbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvgzsu+/hTfyivsFIl/yoTFSCyhjoX/am/06qDvkC/yHmmDIGDsohkB9QV+IeYCG1cI1td03BrC4VvRZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvU+YLLszMpQ5wg1coC+7qx1oyuCgVx3COQ2nxtSgAE/YyJdoK
	O5t4jdZ/vRSvTK6m3E16f4XnSwQcg4y6rWxCNabNpGI7uUQL6fdlsmJV5ZznD9ML+flIKnywhiv
	McTO3
X-Gm-Gg: ASbGnctQFcUFNJmuh9INMxXZ1py2TyBrnzNubg+N+j8U1Bmz5bjF9GDsn1xmJGO2Y2I
	5qK4lG3VVQ6tBe82FDI8axCx2+qxU1qLkTGRV37LGX8j0G1CcmDR+kzGzUhZ0nmk+5VSN3/OI9n
	tMuDUfMu+fUNYmV9y0sbdt0qCP921wXMFB58WaAKm+YuuSDwPRajlZ37CUvkhLUf5Q3XOo6eGQZ
	u1ii7E/aCUOW7unuRNb9YCehDnw3VWnpu5ET+HaEH7MyLtIYhd3gyTx0A4iXErv51ZRAdIBb3wu
	SqnBixSanXVcBb0wPR4upRF8HlzKNBipd6Htq6/HUUOee1/P91PDbXRNaH8M80kgXer4bAYEOxJ
	AtWagLbTGWHfnY2NAMX8ImWMEMYvIys9/libk/PbxEqQBPrH5
X-Google-Smtp-Source: AGHT+IFWPGVp0EFtnuGP7IuzsNN7VqWYceEJm3OSNcdsLTKS89hG84EHpmzJ4FBRIi0atJXeDsDiIw==
X-Received: by 2002:a05:620a:1915:b0:7e8:6e2e:84b4 with SMTP id af79cd13be357-7ea11049992mr2638016385a.45.1756413439578;
        Thu, 28 Aug 2025 13:37:19 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc153de18asm45879585a.54.2025.08.28.13.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 13:37:19 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH 0/3] ntfs3: Add support for FS_IOC_{GET,SET}FSLABEL ioctl
Date: Thu, 28 Aug 2025 16:37:13 -0400
Message-Id: <20250828203716.468564-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Given the FS_IOC_{GET,SET}FSLABEL ioctls are now the de-facto standard
for reading and writing the FS label, implement these ioctls for the
ntfs3 driver.

Use the common FSLABEL_MAX constant instead of a magic number.

Thanks,
Ethan Ferguson

Ethan Ferguson (3):
  ntfs3: transition magic number to shared constant
  ntfs3: add FS_IOC_GETFSLABEL ioctl
  ntfs3: add FS_IOC_SETFSLABEL ioctl

 fs/ntfs3/file.c    | 28 ++++++++++++++++++++++++++++
 fs/ntfs3/ntfs_fs.h |  2 +-
 2 files changed, 29 insertions(+), 1 deletion(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.34.1


