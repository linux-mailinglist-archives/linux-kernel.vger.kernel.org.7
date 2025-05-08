Return-Path: <linux-kernel+bounces-639291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7812AAF59C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 10:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F11047A703F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 08:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1656C233721;
	Thu,  8 May 2025 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Ewp6mIq2"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95532235C17
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692604; cv=none; b=q+TypEltmiRhp0fHQ3fwl0bWwDb/uVKnfXDCSY9GTxyKtUhdw3CZW2vNPMYNeJMvK4UN1m4AUokfb1xBWIdpHBm3YAIFXlR3C2usn57cwbsFwYBCNxjXuL6JZlQ1wwpB4DJ5gsENXEY9jY5FB4TsX7e1cvpbRBhKxGoaSZFwBYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692604; c=relaxed/simple;
	bh=euZ0Zj5ymVvdjh/3qOybPwtuZ+o3GzvdIi2/M+/nE94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFVDQzge2dMJ4kvrBLvpNaGWdR7pgNOyXY0WVd6CDwrdgkoRc5FCoQR6WeQc6CwuwXkdccx939Ex1sPdIdg0Ols9RPknbMSBnCla/crvHCCTsuyBvHmdEfKnMLl2KjBoiahh4dn7Coz7FTKoiPnvYWuZ66zb15Xtt1hS9846BLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Ewp6mIq2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so4469515e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 May 2025 01:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1746692601; x=1747297401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vh7Nh/LNhUg5Xl+qiW1/QFk8dwafIYEiWF4enwv0UK4=;
        b=Ewp6mIq2i/Q7EGITDRKE/mFxgnjZwnAXvGayCTL+yxOpGTzCcbQm8omRNXLCdwH0zB
         h8aNMzsjOVpj6xAqPGo5WPh3E5bTOJEqyN+CWFQk/llV3o/JSMGbJzhDIhqfIh6eSewm
         orTGR+GPAxgpzV7arn5HuHx8JiBAqHV793BbT6tVgSGblwQ4yxKq5ZDXZ0Ql2EHzJ/c4
         RWp/EzDkkn5tPgTpCRkNaDYQ28FGT+t9UHlLf8FoyEjy8+6PoD9dfovXZ6shUeVKO+bx
         /cZKYXiLjeLWrx14sciqVQ2+AzZ3TSadmPnX8LTWkmnqFrdC6YcBdwQc0XQgen7mxk8g
         A9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746692601; x=1747297401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vh7Nh/LNhUg5Xl+qiW1/QFk8dwafIYEiWF4enwv0UK4=;
        b=a0gKatnmtLn6jUfTB4499nMqQSrtlnv1wB8gleXMoOjDK8QOoF0y8dC8XwlqlO82rf
         jXVlFr+7If/8/06IJffBhWCzhXn1B2MMO/UUS3GeWjbl1kimP94EZArDEFNBbOIweJdM
         TXRpMvp+Ukz523OMJMorq8Gohn6IWtYg02nRIcyjDCR41v7HYvtNbPNXmVVRg3H3cx7Y
         sl3k7827jyUId0sIsaG/0bfFL07dr/ua1o5wROKwJBkeU+DVLVHYQLWjCTkD25nJ5mXj
         cky8VJkCJvXHTytxLHBJBs8+sysWG2lt1zLdw9Gj5CW0Bk/YnkeN7Uhishg4e9L/O4Zb
         P3PA==
X-Forwarded-Encrypted: i=1; AJvYcCVORcBfMdFdlofjSJfRcFnzzq10jMVuplbVWDH32WNWuoJaCmsAGSyC0V5dvw4jhcF23iYL9GC12jWVRDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2KKCioqNsCLOoKd9fAnAU8tUOfYkHsCA/GJG5LhUu37Zy25WN
	Bo5r5YngC0DqG7CqeGZOEC78fE9zGNqIuDN8Axvg1ILlBkJlY1JN1J+nKbTO9aM=
X-Gm-Gg: ASbGncuU2SleLDbYcEDw8lIPHPR8NJpU2J3LE1snptN5mjjtJgAUcYPSxJ9ka3LoQl5
	ubThKttRJUitS+K3wHREK2DUmU5knLAlBBN9knlMzpFDJ51Z950BRtHhbFrThz/ivA9XBbxq5j9
	xX+ZCl4Gn1JreI+bOtria7XSH0nlbUekwqBP9tzcNUAbv3u2DzEBXnAaAPx+HOxiCCYLsaA5D1n
	dVDDkn0ier9v/TxYwhbEboIOXsgL4k+H4Q20SCHm732RmIE7/A+Zl5qRmkguE2P5QiTH+WgpWrg
	DSgMcxIQpT9Hg0H3Jv5wSLuw6+ONOQMYQoLZUH4KiprxAchVfVx+l5qORkaxTg==
X-Google-Smtp-Source: AGHT+IEaepCUF0s1jaV8f2x9+3A/ICFXfGBKrXbBRgf8EnrZFcBImB0rnl0HY1gtvoGRDu1Jbp/ttg==
X-Received: by 2002:a05:600c:4e16:b0:43b:c5a3:2e1a with SMTP id 5b1f17b1804b1-441d44bb815mr54224835e9.2.1746692600740;
        Thu, 08 May 2025 01:23:20 -0700 (PDT)
Received: from alex-rivos.lan ([2001:861:3382:ef90:e3eb:2939:f761:f7f1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd32f331sm28697035e9.13.2025.05.08.01.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 01:23:20 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v2 1/3] riscv: Fix typo EXRACT -> EXTRACT
Date: Thu,  8 May 2025 10:22:13 +0200
Message-Id: <20250508082215.88658-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250508082215.88658-1-alexghiti@rivosinc.com>
References: <20250508082215.88658-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Simply fix a typo.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/insn.h | 2 +-
 arch/riscv/kernel/vector.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index 09fde95a5e8f..2a589a58b291 100644
--- a/arch/riscv/include/asm/insn.h
+++ b/arch/riscv/include/asm/insn.h
@@ -352,7 +352,7 @@ static __always_inline bool riscv_insn_is_c_jalr(u32 code)
 	({typeof(x) x_ = (x); RV_X(x_, RVFDQ_FL_FS_WIDTH_OFF, \
 				   RVFDQ_FL_FS_WIDTH_MASK); })
 
-#define RVV_EXRACT_VL_VS_WIDTH(x) RVFDQ_EXTRACT_FL_FS_WIDTH(x)
+#define RVV_EXTRACT_VL_VS_WIDTH(x) RVFDQ_EXTRACT_FL_FS_WIDTH(x)
 
 /*
  * Get the immediate from a J-type instruction.
diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 184f780c932d..901e67adf576 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -93,7 +93,7 @@ bool insn_is_vector(u32 insn_buf)
 		return true;
 	case RVV_OPCODE_VL:
 	case RVV_OPCODE_VS:
-		width = RVV_EXRACT_VL_VS_WIDTH(insn_buf);
+		width = RVV_EXTRACT_VL_VS_WIDTH(insn_buf);
 		if (width == RVV_VL_VS_WIDTH_8 || width == RVV_VL_VS_WIDTH_16 ||
 		    width == RVV_VL_VS_WIDTH_32 || width == RVV_VL_VS_WIDTH_64)
 			return true;
-- 
2.39.2


