Return-Path: <linux-kernel+bounces-740734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEAAB0D85F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0647188CAD6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2622E62C7;
	Tue, 22 Jul 2025 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3/XWkBS"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8987E2E4271
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184243; cv=none; b=QI5WwnobNHYyexVMMRE3k167ArZHe2sec8Z0AOuPhpXmgfTihNdAidAl1uJFXw89gvdTF2kvkoqUB3Vp1tZle6vMfIgv1RnpZM53JT+OYAZK9EhAhe8e6HUFaJRthEefDFGwyCeN5BO0XQQBt2QeRxRy0AnCY5QESiIQBVwUe1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184243; c=relaxed/simple;
	bh=eIln3H1fR8O5GuRX5Xgt7i2HOWUQKRdimj/37H571oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B54DHeX0KDGaCD+hOHtdlqTuR195V9Mz2blD6pNI3VFCGNV6q0E6i1qkN7DYnq3zKweFKdx2iG8gznmKCuuRXpp6Qke8qUXhsIe03KTIFKZioSfnlbYuazNQr6J5rPcakXNMAEPrN/oIKlakPbmiWcmIsddcACQUHpGhx07Ipuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3/XWkBS; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ab6416496dso64131341cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753184241; x=1753789041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSyw4DxGPnmZinUmkvsk/OLZlS14XfRnDBMx6RyXJYE=;
        b=F3/XWkBSuF+Wzz457P2gKIpNSQ66nqNN3haNjFvPy6UKxTq0hNROAF1bDxCL8BlZub
         gG3Fo7crFPgyil6jcbKfX+9s8vU9q+3oGVg4B3+CdA4m9dVWgD6qNMdyAl9nRwRHyCP2
         RyZLwHWx1+5TxHVDr7edv4Z9sG32pIgz9dCjl5ha+mGzSZ5LKQEdh47Cw/YvF+e73KnG
         7gAAp8FiJWoDWSaQQ3FWMT3SpX+V3ovKuxbQYZPFdXtjMa5gmaUVDie3LXalumEjAi6g
         H2+xMB4mwnYeiGt9CzaVFxqckqPSaFLS7Q8VOB685RXISEv68DKfjhepxNxoTfc82eZ6
         cs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184241; x=1753789041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSyw4DxGPnmZinUmkvsk/OLZlS14XfRnDBMx6RyXJYE=;
        b=FO35W+4wVdZA8i0qDS7U8Jk3SjOvRHBHH/yzgjDJkfuujOgQTvH9mIr6BHaU0z8hSl
         OjbqLRn35keZcVs2KvYNCVIDT25tEI9VHoCpCDZpq1ApZIpOUf/Ja33BTUEBUUolygyt
         ix3iZeofgtT2DbnHlGFwqYvzg0mM3zoo37OaiXZFKCr9QqzXQOTabumZ7n8USkNFFvbq
         kwQpGryI+2XHRIEmPky1RLi+RukmQakep8jQzoBkNPXSDkCUvb2RGA2nuKxLw3HzSvvZ
         0lwFjb2KC3P4GH3nKANQEKofpIPvF3Gay47emfU1USC8Ar1vLLUz/YQyvEyJkN4dM1nU
         IV6w==
X-Forwarded-Encrypted: i=1; AJvYcCV2+jkGHtCNyiDiKhaB2jVqlLd947UwmlwY6aFxoSZf6p2agOVZFNpQCPLkJwMyaMTZmmwJSD0fvIQwfAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7J1I6v9u9RZ/4OfritAeMZY+V3DhM+z0t6TA9rS/7wFkUfoT
	Yyfpc8n14710H6WxEULrbGD1g8k/PH2L769Vl4UrzYnt7vUvXWxsKxJVvxbIYiK1cyw=
X-Gm-Gg: ASbGncv1I/ZwepMFfda2VQLlPKiCol+JboOTfcOEm4ooWFRPLB8G55BSwZjpOkmmu6A
	NbalY9GjJzVhCPsbdkxJuQB1TeqivA7SKmadxgGFBVEl0kNr3SKu/5r9ppmlNAToH4cbin6WfQ1
	Bm6ccv8t+U89NXNAUHRWblYd6gsaFB0gUifGwBMtEnM6HVEwtwffq2IDd0DescHvKULWlYV9njA
	W0ewFdGAsrdM/2hVI0KdC/m07M4AoIaZ/drBZoM0EWojNB3bOzDPvhgMAVE/OLhgK5DW3MpCFAX
	XJupQRv5erHUlxkbcDhW30kGBGy2AXHn5YD950wwlGYBzkfPEeC2DIC3On7w0qYot7VQD6hiHTa
	nhVVcbAQVyQVMnzAC/YsGub3L/psrWlk5ZQ==
X-Google-Smtp-Source: AGHT+IFcIJFZREFmK4NF1nfKQkIQ7kOKpqrmJu8ISeiJMHzI/8+ABSohjov2uokg/0MjYhNmXs22dA==
X-Received: by 2002:ac8:57c5:0:b0:4ab:7262:893a with SMTP id d75a77b69052e-4ab90a35c7cmr307026951cf.18.1753184241299;
        Tue, 22 Jul 2025 04:37:21 -0700 (PDT)
Received: from Gentoo.localdomain ([191.96.227.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b25a18sm52457651cf.59.2025.07.22.04.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:37:20 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 11/11] Shebang line was missing,fixed
Date: Tue, 22 Jul 2025 16:47:07 +0530
Message-ID: <5577a83999a2ed7aa638757b71f4edfd6e0b983b.1753182971.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1753182971.git.unixbhaskar@gmail.com>
References: <cover.1753182971.git.unixbhaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added the shebang line at the top of file.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 .../selftests/drivers/net/mlxsw/spectrum-2/mirror_gre_scale.sh   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/mirror_gre_scale.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/mirror_gre_scale.sh
index f7c168decd1e..abe3835ded4d 100644
--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/mirror_gre_scale.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/mirror_gre_scale.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 source ../mirror_gre_scale.sh

--
2.49.1


