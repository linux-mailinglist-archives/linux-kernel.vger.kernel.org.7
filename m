Return-Path: <linux-kernel+bounces-812719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9992B53BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7709EB6064A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A059C25EFBF;
	Thu, 11 Sep 2025 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tteshu4q"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DCE2DC79E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757616378; cv=none; b=XAoumfJ+HdEEMt4ikOEMnhOQuo7pEfVyEzIgcaaPjt8ImUrnoE7GBGTyZzwIb5JUj6bmDydanKOoX98FrqgxdXAB2t8qJwtFklYTWYwqucridVxgSs/idlE93+I4upWxrvWQbXtvAWmQm96Dqu+aZBKFQUqYyoSsH1xFtpxM/Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757616378; c=relaxed/simple;
	bh=lWN68uun6xuXeo157g9OXPRAmAt3+0h3gT2xvoHGcV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHPq4tRwK6Qhh5+k3XtbwhDFsP4qpLoFx8kwOVWGOiX5odgkZGPh0+AEsXZnUv8BO8tT/5XxE4gSnSkgm+9NEctCLD5brExeFvhSeG7u/xWEuqCRik856+CC3Kyke/FEqzKXpoCMthXoyCUxX9BjLYM1L3Z+no6MpmzriqZB8b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tteshu4q; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so957451b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757616376; x=1758221176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlAH/xgNhtYxUmFSrUeEXv9Zp05waRSL1IRqf/r2VPc=;
        b=Tteshu4q+MQSkSmlJZVzu5kC+FR+hCYo/wos78IaQzBWFjnnYWjHCYTN7T4QCJn5dM
         yR1LH+VuJFnMLcZzJU/jGXNwz8EH+XTL/89VCS0luAP3W5SYvARRcpErD5ftQH9PFWoa
         UyYaZIJlQ+b6VAvFPHbpsti1i9L00z+VFBKUrBxVY3AE9jGmv/LwvsoiMHP5Ln4vb8OT
         zVaPirKg8wc3v+2v8CckvmmmEQ+fnfI+C87UJfMA7hLmw0noFNT6jAl4aNo6k0/YpW3y
         pHyl/CzG11FJf9+5QWPOV8T0vRb3ifXttrI8446mbmJY2fZlK/leWRb60UGhOH94eVtz
         sD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757616376; x=1758221176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlAH/xgNhtYxUmFSrUeEXv9Zp05waRSL1IRqf/r2VPc=;
        b=vFTBe8gLA1wrRAtKdJbZZVQ++XBfXVNKv1SxS4dPAxvue571yhXw715aUNeMtLCvzH
         Bj6tzyLsPQwOLenUNSNgu93L8NHzJftyEW/rVuLt8iTVx8OhzEauS31vjSIgEylpsBDk
         iBl3yINVTFmdJVhiNFpOVAGS/Ss+cF56pgmGyHiy6mGLJidYcK+1BhkwkyCGzIGDVyuT
         VTydav03nayzx3gMJfJFGOlXH+JDuOQcaMKdGQvsO8C6rmGpXMjncLbkFfueNcHHtLvq
         wRex10V9kdy3fOAfb14b4kj+mwmRzjj9Xw4BLLUXEUS/k/DfiL4o3G8FYT1RWxP/2rx2
         kLmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFbbDIO/270Z/BqORmc1mgXC3eyWXTpxSmrDhuCz2uiRMSjAAsSbREnrHpz8TrRLCjQS8AN5NoZEZ1s7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi8P6hwjZWhun8wym2tc/jjB9Ev7umTLcXnVRbmPJKRTihvy30
	wjtabll2UhdmC+n7lIY2BSVcspmXhCepxsnPxTUj+HPHiE81n13M+3A/
X-Gm-Gg: ASbGncsEk8QzhfPrSorwInyi5tZVf5Ishr26TtBpZF+ePWu2l79QWiePN7EaQDYL83A
	bjtdwCiInUs7btaQX2V3wo46DtkB1795r+gPDcFu3GtDlufYuSHqXGR2emxr7Q/u89nOJv3BRJv
	9oFfrJOgDVVAxTtl58Z6r/A9G7HJl/UcLgw9NWHGa47/e6kxYVWvNFGvJFOCJx25qnmI01Ve9Pv
	lbkqAsaVaJ1VYLt8Rh7+yCOzG8oodKJtgYK+aX6ElPrt7uK35gJPCyTP0uQzxWQM9rzewHg6ero
	6UtmiHAFySLRKt/8xyUnq8RpkYAppZPmi6beUEE5PsyFoPXzODzM8nzIobDZPHk1vVB4xZeYTxl
	j3M9/JyhdZTbXhE2G2eNJnaW1KTgsP5sRSfLeL6lsvnPXp6boSJF6vKgkWJh1RELFa06KV7gKOM
	hx/gB/EyS5lkU=
X-Google-Smtp-Source: AGHT+IFWKQQ/DKkLEW8usdep20KmNQ9LFmSRyYY7L7+2Ba5k7KI4Z+F3I8SVvoorqXgeVdlQ3gDHqA==
X-Received: by 2002:aa7:88ca:0:b0:775:fadc:25f1 with SMTP id d2e1a72fcca58-7761209131amr452191b3a.12.1757616375382;
        Thu, 11 Sep 2025 11:46:15 -0700 (PDT)
Received: from localhost.localdomain (static.148.173.216.95.clients.your-server.de. [95.216.173.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b34790sm2762616b3a.81.2025.09.11.11.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 11:46:15 -0700 (PDT)
From: Han Gao <rabenda.cn@gmail.com>
To: devicetree@vger.kernel.org,
	Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Han Gao <rabenda.cn@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Han Gao <gaohan@iscas.ac.cn>
Subject: [PATCH 3/3] riscv: dts: thead: add zfh for th1520
Date: Fri, 12 Sep 2025 02:45:28 +0800
Message-ID: <20250911184528.1512543-4-rabenda.cn@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911184528.1512543-1-rabenda.cn@gmail.com>
References: <20250911184528.1512543-1-rabenda.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

th1520 support Zfh ISA extension [1].

Link: https://occ-oss-prod.oss-cn-hangzhou.aliyuncs.com/resource//1737721869472/%E7%8E%84%E9%93%81C910%E4%B8%8EC920R1S6%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C%28xrvm%29_20250124.pdf [1]

Signed-off-by: Han Gao <rabenda.cn@gmail.com>
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 7f07688aa964..2075bb969c2f 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -26,7 +26,7 @@ c910_0: cpu@0 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "ziccrse", "zicntr", "zicsr",
-					       "zifencei", "zihpm",
+					       "zifencei", "zihpm", "zfh",
 					       "xtheadvector";
 			thead,vlenb = <16>;
 			reg = <0>;
@@ -53,7 +53,7 @@ c910_1: cpu@1 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "ziccrse", "zicntr", "zicsr",
-					       "zifencei", "zihpm",
+					       "zifencei", "zihpm", "zfh",
 					       "xtheadvector";
 			thead,vlenb = <16>;
 			reg = <1>;
@@ -80,7 +80,7 @@ c910_2: cpu@2 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "ziccrse", "zicntr", "zicsr",
-					       "zifencei", "zihpm",
+					       "zifencei", "zihpm", "zfh",
 					       "xtheadvector";
 			thead,vlenb = <16>;
 			reg = <2>;
@@ -107,7 +107,7 @@ c910_3: cpu@3 {
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
 					       "ziccrse", "zicntr", "zicsr",
-					       "zifencei", "zihpm",
+					       "zifencei", "zihpm", "zfh",
 					       "xtheadvector";
 			thead,vlenb = <16>;
 			reg = <3>;
-- 
2.47.3


