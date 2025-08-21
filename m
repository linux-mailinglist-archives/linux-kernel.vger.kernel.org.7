Return-Path: <linux-kernel+bounces-779085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C15B2EEEA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B04C16D264
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24742773D9;
	Thu, 21 Aug 2025 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wqy4GVAa"
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4BF26057A;
	Thu, 21 Aug 2025 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759415; cv=none; b=QuCGJJ6qAOet/qXN/7Hq/byNC7ppfn2YVmhubMBL2hl9nGlFacC/YA74lOyxnsHib9KqifQamSCBh9FShfi5jn0+muE/RpEYOS4pAdpLh00wQrD4xpE46s8HeqXrrQdqoLnzAS2BL4eAQqPP7dy4lDBUCZWTHF0WUjYPfJ40iWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759415; c=relaxed/simple;
	bh=yriCzDDKyFGt9c528IFCPyARw1Ym/Hbi1qZhEG/5WoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=poquA3Z7fM2Roi6CMtaT4GE2I88a9WGJ+Adsbgy9XEOjeEOZP6m+08IKF/ZVNQ1ynEIclKQhs1IOKAI5Dbx/ffLpNxfxcIizcHl6ITV+sXZaoaa1yx/gWJGTT9Z7l2VI618iTEOyDvg9NnDBV3b1kXkBxdIVPku7BrvKyGWhTRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wqy4GVAa; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e9513a4b346so131211276.1;
        Wed, 20 Aug 2025 23:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755759412; x=1756364212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aKHOiWb7o8BvmErlEWd0dXKBNCfXdwaBV3shB3h+FUs=;
        b=Wqy4GVAaLw2qfAAUYhs3TbaGGJuMvXRjf4ktZg+kXIF3+SDXrp7k9sqUUDGNvO4iOf
         eO35kPXQAYSJUB48KrnEsV3AgpnbxVRxXuFGxFN2F/XBd7e065KDSjdynbPiQyz8CNlC
         qpjF8+Q+QY+qqUENRc3SOLQV2YE7J1thuvnawSPSQ2/F+heojeKC6HKIejOv+K7UQtGG
         ohErlZ8E1WY6fDi9uR/zSWcfN4LHGkm8LsSfAJB3APAXIkkq/j/5TXK/1wWI3ViuBs1C
         nfG1veQF7n4oJLLANwcEN3GCuZ1RRGSDqyfaEOOpT5oOJEJtMtv4mWkfVpm99Gruow6U
         sFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755759412; x=1756364212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aKHOiWb7o8BvmErlEWd0dXKBNCfXdwaBV3shB3h+FUs=;
        b=sis5rbg9mz4ysOQfImkbsXCsNKDACky55pFKa0vej7fU028CI6/o6JPSxTDSyoSxP0
         LRt8Me+bnxxOuNVQggfF0Aatyw4IgqTOTYCA04aJv12RZE5o89GWYaIdvOLIoE7bkPBZ
         SuF5F2NeYk2HqdzVjwowX32PkGN0bM+hD3Ht40j6ycFajwbwWfuxn87AkSksF85mh/YK
         5I3YuYG+EwUelByMsHMwtiwTBtTO+ewHeNUg6wAY8lqAKER17IvN0bw11PDVYKKCtVDQ
         RlBA7YcguQmUQbsFGwz3bYJUDspJqrk3z6KSwYdTOsJ3aeq/B++3G7r+SLV2QT9tjhx9
         67JA==
X-Forwarded-Encrypted: i=1; AJvYcCVNZD7HaLKbDiyO2bD48VcW/MewIbeHgOB+Cp4m2A5efgSPEvVvjF7Pb/iRcMRLj6cHHkkRNb4+oxw=@vger.kernel.org, AJvYcCWCJAdS77WstJYVnMGI32XV+EvI+6q72c8pUsfnBzQ9B9Eu9WZgb7/AZUvhV6OwJgwOiQL4gxWnp0dDR5gV@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ymXyTUqo909dZO6l18EWQ3lrPTZUtRpaGdJTiARdRrdKoKZ1
	h9UOzHkke+hzeAF3xnHHoGLuSGucky9hXBv1YeqiQw67C/WsFhvh3Z9d
X-Gm-Gg: ASbGncuW8yC66IHY9Z9NFZrKCh5CL25ID7xR5MG9j6YAa440mNurhe6qj2RdjYWPO0x
	8p1ve3whONPEKXS65qM8pbwKkuR1k0xfMwMt9ZgRc4HsW3zfUX3anoWnYU++evL8/oPgoOrabAM
	ZKrVfmdkxLdosuZedPL8AmlwRfnp5OY9KLwoWWA5DjzT4IbfWz6QFLpoh53hF1xCO7IWKPQ+ASX
	P9bERmEFqipz3GsnjuPdnR2iq6wlB3+8dNtqJEWZLmQ4M3EvsIKsS69gKYJ+88+vtXV2vs7RgPw
	EVgJkuYpMLrLC3496Rz1nrlmtQ5ONwg+tID8zVMy8jjFXtDm+iuiRjxIa8vLOV16HV8HtDHhZTc
	s8zdZTk4=
X-Google-Smtp-Source: AGHT+IEuHRYgzLilI6oD5FG2vP/U+EC22Irt2Vxzquhgep/QVBSDud+lY+laBIJ9l1l+uS3s1pmk0A==
X-Received: by 2002:a05:6902:6c07:b0:e90:2d78:a27a with SMTP id 3f1490d57ef6-e950dbf882fmr1113745276.19.1755759412475;
        Wed, 20 Aug 2025 23:56:52 -0700 (PDT)
Received: from fedora.attlocal.net ([2600:1700:3680:fd50::44])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94ddd0e15esm2826347276.33.2025.08.20.23.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 23:56:52 -0700 (PDT)
From: Abhishek Jadhav <abhijadhav.dev@gmail.com>
To: skhan@linuxfoundation.com
Cc: Abhishek Jadhav <abhijadhav.dev@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix awkward phrasing in reporting-issues docs
Date: Wed, 20 Aug 2025 23:56:32 -0700
Message-ID: <20250821065635.336305-1-abhijadhav.dev@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Abhishek Jadhav <abhijadhav.dev@gmail.com>
---
 Documentation/admin-guide/reporting-issues.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 9a847506f6ec..8de0acb37d94 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -471,8 +471,8 @@ before proceeding.
 
 Note, you might not be aware that your system is using one of these solutions:
 they often get set up silently when you install Nvidia's proprietary graphics
-driver, VirtualBox, or other software that requires a some support from a
-module not part of the Linux kernel. That why your might need to uninstall the
+driver, VirtualBox, or other software that requires some support from a
+module not part of the Linux kernel. That's why you might need to uninstall the
 packages with such software to get rid of any 3rd party kernel module.
 
 
-- 
2.50.1


