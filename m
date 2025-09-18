Return-Path: <linux-kernel+bounces-823598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B7FB86F24
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF57E582D40
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71322D594D;
	Thu, 18 Sep 2025 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EANGncbb"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B089731B11B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228328; cv=none; b=Jyggb0A5KIn6P2OZO4HT5HV9hkOaF19+RAhVzogAqu3cKdSUQQ1QavUOGP/u4+P/DUx5hcvEtTL2Ppq810IYn3SY9GYqJEl6UoYYx4wLLDzefFC23z2bP9hbQkQlgS73nDJA5obK4zjZTx0xosrj04+XN4CaYacThuOkY+tN7lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228328; c=relaxed/simple;
	bh=OIWkLQqjcrQgM7X+/q/co7L4hQvwxfqmya0GWab3+Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibMMcvEKEPtFz5y6cR8d7pdFPaxeE6anSmp3DTAd526eUWNhVgsAT8FdpuL+YtfbZc2L0YSsiGGs5BfLGE+vxE774f5n47y5r5sUnJLZFXyj8acCuWMJ4JFi7PAPvUYzFET6OQmkLMZykel/cT2XOVndAD2JsSnVIqLg3Jdj4yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EANGncbb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77d64726e47so986941b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758228326; x=1758833126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFIFdbIH/bKvV1avROWPNI4zxhkvHd6hfIAukKkVczI=;
        b=EANGncbbnyd+K6T7Yv8+ZSzJRD+HLFYFTqXd1Avo0CZSLQ7S9uVl55dFMEWr5W3XOD
         v2lUZw8635vdJpG3fS4wn1txc8QnHn1ySfjBGJ8dkpSlimEQVhQJpnVEWxaF/sbc10h2
         mOEfvl08qDDlgMi0KR5uF/ct2P4bXEO8WEUHF/JTT1yw4qA4zucIhdJ9LLMT3RNvRpvp
         um8I4PrMsbieR/aB8kp1Pd4fSG43RcfADBxXSHtxq51Z0ie0S6wER4wowY310seC6rVo
         sxSjLB7fLMaiIt84OTnSY98hvfBuKFc2A/NaBT1EfvOk+JwxGzjU+lvclX27xhF48BMG
         Kcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758228326; x=1758833126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFIFdbIH/bKvV1avROWPNI4zxhkvHd6hfIAukKkVczI=;
        b=rTFnVlRyJcw9socz9eXzFzS/836T6yplqjYcntRWxAE0GiVohXpLZ7ejcbDrAGz7yY
         tmFzR4oLrqGjPVpwBtUqyylyggwIN2hSWjfx/2kcB3phMJ0wfGeBalmFFyheY6+FckVA
         9bzJXThOPwx9CqKgswPwEn8caOpl69/P1rsUmcWhDks1jR79YIfFCyShX0Qq/oXaqnid
         0iH1Bj1UtVoqpl/cl0JoTSfWBPKCZij2qNS/zEEIJ9ttFV8epv1kJ5KumHAsoxdlOiaM
         EyBPYTV4ilE2sxOxTQtCLMxDtqOzDJbojgMMVtpHDg64VydwcAu+SxPYyKNuSsV/uQjw
         iD5Q==
X-Forwarded-Encrypted: i=1; AJvYcCURQK6BzVGeJ1tE5v82O7rBvgDWBXpg/e1FYBBEg2JP1lNp3gA+jOLCyb1z5GtXxcnBCYGM6dDOCVdjatc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8fXHlO8QML1EIE5fVUvRAIeuMdA+bFVF+zDMSGQ1hzjx7qIRd
	XcWmWiOVjPlYCQfrxAABF8dUkCr5SLtyRs8MQQMmjjtzlbyfEBLT6pVY
X-Gm-Gg: ASbGnctxjAO+1WpzvCBFgghyToSOMNDteVxFXqdbIvY9TECzAd4t7T2QHI2yyQJPRwZ
	9J3jVhDInQN7xv41KONLcAmWLsqsIn3E8UWIu+12+q4BCseKEw5eyArUDv1+NzO8gswV6DMP9YB
	i77r15mtbaw85piM0P7L/FRn5NympgZRktVd5PXvOiWZnROvIuKVkW9QIZGeO5ztokQz3C6kdGI
	cozelLtANGw1x33BZy1HuRAVw2/JvoZKcajJIfAaEE5NZQgty6wgRVsZF9LWPJSZ/FgF3MuFYMD
	iBq7dqSiNraBSjvJgnJHe7SKwLMafSkHdPM9snm1cISyM6DF+A6DI3qg2Joa4n6a26Q1nf4O8fh
	Kh48DNbvvkq0ilvOQnXWpctbr5nL6M5J8wu/m2tKUN4bm8+GgPZo=
X-Google-Smtp-Source: AGHT+IHMX2wzLIuP1H1OYeeMGVJI0rgVYaYF6wG5yHwKshxuo1aOWGmuNzZXnQ/jUOJ9+eorBuztOg==
X-Received: by 2002:a05:6a20:7344:b0:243:c274:1a7f with SMTP id adf61e73a8af0-2927277718amr1294133637.46.1758228325445;
        Thu, 18 Sep 2025 13:45:25 -0700 (PDT)
Received: from localhost.localdomain ([119.8.44.69])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff35aff2sm3178181a12.1.2025.09.18.13.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 13:45:25 -0700 (PDT)
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
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] riscv: dts: thead: add zfh for th1520
Date: Fri, 19 Sep 2025 04:44:49 +0800
Message-ID: <38abc793c2fcb9dd26c89bab10dd4450d91ced4c.1758228055.git.rabenda.cn@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1758228055.git.rabenda.cn@gmail.com>
References: <cover.1758228055.git.rabenda.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

th1520 support Zfh ISA extension.
It supports the same RISC-V extensions as SG2042.

commit cb074bed1186 ("riscv: dts: sophgo: add zfh for sg2042")

Signed-off-by: Han Gao <rabenda.cn@gmail.com>
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


