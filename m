Return-Path: <linux-kernel+bounces-812718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94368B53BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110B217F8BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3880125B1FC;
	Thu, 11 Sep 2025 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVUr9HPn"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B48154BE2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757616370; cv=none; b=FtwzVEhfrtVrD3xBIQrWwJvjpbnGQo6z+ZfE+09Mc3nJXNJ1pI1Sb/NxHuf8rJCEkXWwGr/NN4Dws3rQP7BaRsuffzK522RdTTU4WRZYWG2BvHHFC4keHtm4UsfvK/RV/O8byy2uc1xvBoA54Uzy9SJV5AN0VlJGHKFfVmfNW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757616370; c=relaxed/simple;
	bh=F4qCo4MUS7J/EXXFY8/P4Blf39l8hgT0Sqf8jLdkBX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4RdquwxSiEp3P8v/1McNIliFDmIinh1WJn+TeG5q4QN+IUUp4wBsl77LaOLnSZVzNu5fv0kgMdCZH3tMN0DCrn0Wee9S7fIgz1W0TaCxYlJCrWX5XtkN5mZZLO5h3PNLK9krAuAmNnKLpJSdRKCIDkKoBV2Q9FKQdSIkkRxcXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVUr9HPn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7725147ec88so670921b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757616368; x=1758221168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhIVMGmaQb5kHljyJByX74pnoIVwtpe3D/VkqUSXrh4=;
        b=cVUr9HPnZsoA1oREq77EZnaflnrmom/y2TKKaMmq5hEhXuYq71aSOkp713xP5Cxzer
         X1NKVvEZLLK+cx2FPr/jhFJD4/XLPA3e+BLnOdkz4WNI00X3iJ8hTvD77S72ryaMhFzf
         V6EDBHy33n854K+Bhdi8nN5qrN/KYRCAkysQ3Fl1wP4cSQ52NDkq/9xh+3YDDYmfNc/Q
         bVMPu64xdnQGwE+6Qp7c9KtWHJcnFjKzAObaHYuipVVtjhTyUiWUoaylAKhvPJfCqCSS
         8hJ2RM8nLu2gVieMon1x9n/Yc0aW8XxQvQsgmZDXDEjNMzdM0f31JzvYq7erNq54pALI
         TICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757616368; x=1758221168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhIVMGmaQb5kHljyJByX74pnoIVwtpe3D/VkqUSXrh4=;
        b=wpySga97BGaz7zm52qzESe97f80KY1711mCAvmkda0kjuExukYFFMlgvS5CV+5RbwH
         nb9ZF44WvTMD8HRKf/a7s19JYRAvKVKHLowcNYx1nzmRETnShiTQnhnpaT7wNXSFhkGg
         i9h71osUCzjCpANSXY7QTJ7Ikve2aRNzWaSUbUZ4fq+YY/SkzFlKG6jTsKz3tJJD4Sqn
         hrHGtElkY6XGlH+rYdFIVMglUkcvFoCvMvIP2+GHhvtXW7/Zgr/lj1vh64zAAolWBpJp
         xdjvLKFmoCQnS6tZlNB7516w9WDqlcz1bi7rD3/WBK4att4s3HPh2p9KC/3OBVncCn0J
         7nxg==
X-Forwarded-Encrypted: i=1; AJvYcCWaKaPbOnQODruKIkF0RqXGITVLmJuxJMwGokWr46ZDIwy6dx11aQiyTNgEFelDI0y5PUNa26qyMNI1iGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiHfy+kPG5zOyyZ2iMh1gYS8EEcw6nn0vkg9d5F8MKfbaFtxJn
	8iBLP0+gWETaNOC7bQtPca51SgmfILVmRuxfUj1O5qhS7/yOlzIjvWgw
X-Gm-Gg: ASbGnctssjApFl513QDDrua+pgJWN5cs7HVRX41S83WqxiC73rK10ZpjHSQXo8PodzW
	OqCA/bTh6J+bGs6YQg4Y//IKfFXyqQpH83OAzYyEVhE/5LowaNk7M5XrlDdCg38Q400OEN7sEXd
	LhKnbd+qvor0VFOWe06I43/tXEeW8TvoMh0fHsPbvTAE7b+qZhKABQZXFKjxw2NI7AjMYLdzKL0
	w9qQIaIjOzn2Vria0IsNEqJXsTlvJaXLG/dFq9JupG+mXAO491KfEF2EjoW6L14GcHlXq3+ru7r
	fh0X0R+ce6eXSxP0JPRTxtWX+K25x8rruJ8iFeOggvPRoGp09A2JU4PSUBw05Kg3wPabTaLa1Vv
	0eGfu3B5ubam5WwQMqgkebatA4hW7f3sKyhIaOxkVSlTOsUceQbng2DKl01dqBjyAU14w0nwfcb
	IRi5iXWZnDowg=
X-Google-Smtp-Source: AGHT+IEWVt/7gbdNel0eKUlbw06kyfO3o98uOlJcnfbdgYss2Gsvlp8j+D58SPIYP2pLknnU33ifPw==
X-Received: by 2002:a05:6a00:b89:b0:770:4753:b984 with SMTP id d2e1a72fcca58-776125cd045mr354124b3a.16.1757616368063;
        Thu, 11 Sep 2025 11:46:08 -0700 (PDT)
Received: from localhost.localdomain (static.148.173.216.95.clients.your-server.de. [95.216.173.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b34790sm2762616b3a.81.2025.09.11.11.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 11:46:07 -0700 (PDT)
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
Subject: [PATCH 2/3] riscv: dts: thead: add ziccrse for th1520
Date: Fri, 12 Sep 2025 02:45:27 +0800
Message-ID: <20250911184528.1512543-3-rabenda.cn@gmail.com>
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

th1520 support Ziccrse ISA extension [1].

Link: https://lore.kernel.org/all/20241103145153.105097-12-alexghiti@rivosinc.com/ [1]

Signed-off-by: Han Gao <rabenda.cn@gmail.com>
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 59d1927764a6..7f07688aa964 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -24,8 +24,10 @@ c910_0: cpu@0 {
 			device_type = "cpu";
 			riscv,isa = "rv64imafdc";
 			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
-					       "zifencei", "zihpm", "xtheadvector";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "ziccrse", "zicntr", "zicsr",
+					       "zifencei", "zihpm",
+					       "xtheadvector";
 			thead,vlenb = <16>;
 			reg = <0>;
 			i-cache-block-size = <64>;
@@ -49,8 +51,10 @@ c910_1: cpu@1 {
 			device_type = "cpu";
 			riscv,isa = "rv64imafdc";
 			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
-					       "zifencei", "zihpm", "xtheadvector";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "ziccrse", "zicntr", "zicsr",
+					       "zifencei", "zihpm",
+					       "xtheadvector";
 			thead,vlenb = <16>;
 			reg = <1>;
 			i-cache-block-size = <64>;
@@ -74,8 +78,10 @@ c910_2: cpu@2 {
 			device_type = "cpu";
 			riscv,isa = "rv64imafdc";
 			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
-					       "zifencei", "zihpm", "xtheadvector";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "ziccrse", "zicntr", "zicsr",
+					       "zifencei", "zihpm",
+					       "xtheadvector";
 			thead,vlenb = <16>;
 			reg = <2>;
 			i-cache-block-size = <64>;
@@ -99,8 +105,10 @@ c910_3: cpu@3 {
 			device_type = "cpu";
 			riscv,isa = "rv64imafdc";
 			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
-					       "zifencei", "zihpm", "xtheadvector";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "ziccrse", "zicntr", "zicsr",
+					       "zifencei", "zihpm",
+					       "xtheadvector";
 			thead,vlenb = <16>;
 			reg = <3>;
 			i-cache-block-size = <64>;
-- 
2.47.3


