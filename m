Return-Path: <linux-kernel+bounces-870025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 14178C099C2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B08EA34E8E3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37186328619;
	Sat, 25 Oct 2025 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pv40gj7U"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E94326D77
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409761; cv=none; b=IdNruqRUepwVieVCGDYaqGzQXy2VxkdEP5hJRcK/3d4jYQ131VMCusLLmoRALHX+CIvwzDvm56B0O1mmKAPVd35fNl7hF2MqmEGJR+ZqBCQAIFQhQI3XWY98jT/dZ+MzD8owsl9d1O/0Atx80PnfBiMp7GgPZeNxZ00pfs3E8TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409761; c=relaxed/simple;
	bh=6VtH0YRJIJT6wM7OnyxPz0sTaONVtRxS45ztLq91gUI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Evy9HRu3GFk1NMZ0fwG9COv5f7XQ3ClOALC/gXh7RmD2yd7Z2oRPZmYSnfi25kjYytJTPUWEmk6lzDgY8HLr3Z7Azofr4rWpsRyisYqvj04Z3iEmO/k/Z3c1i+inD83+TzPRQb0Ic2TzmtKwrrQHo/NCnFV1l4L24h/6MzvkEu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pv40gj7U; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ecee585f23so903501cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761409759; x=1762014559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rg54zbsiDVSwYkKftv5+NDhQ1U50ovc7eDauHPziXJ4=;
        b=Pv40gj7UnkIqzAZrfy8BLHFb/OrnxCgnnZPlALPg5bMl6J1tK8XzFnZGgbXk8xJ5kd
         b1tV6vgmA8JTyYHOqlp8e3RhCAxKrOkjczzTnq8WTrPB2QunsvL29I8Kaw8P8AyQrwc8
         rkkVY3VLNTgn1rILtKmcHHrk+HRz9RppP8MT9AGnIP1pK66QVicfX+W1gnQf6JeGzve6
         3KVv767PNmYmOyxFEmheRpZ2d9Ca0u/655/xwilCKK8UvFCO5mCxbo2ne8SBCsyiYvRh
         6D9HSiDVRyZaeC6DHRp5IAB/LSqVDOlr02JnbnV/dK00ICpbcBzWki/cwju9mNRmHBxD
         p4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761409759; x=1762014559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rg54zbsiDVSwYkKftv5+NDhQ1U50ovc7eDauHPziXJ4=;
        b=ayCfovW2RNGam6KUyGYNfAGWYmyitnSFe2NK0/ZKoXT1pJi98qaQ0BlSJzr0TcDdHE
         LZLEQkrZxsDe90QLDK7yTru+ShD2W1H4ZrxAjdyIHWO5nCuWFDowwdd9dGdS9wr7DiQO
         l3wX2NwXHlen262sxeCY+O/Ou0urcrqgpMYgEHWnZnKjwX4wzOGPqiAhoJgbeMuMtxQI
         oqlBcpB7DuLF68ILYbZs4EgdqfjjDBuSTMMlstq/6MT07DzA6B/CKzTrNMy3F4/t/9K0
         BrgkA7xHLdtQHv0+PkazINEuHxV90JuUzsfsNBsCKJ42uAaJjsxFHx9TOXlZ3JdEp3iJ
         PHfA==
X-Forwarded-Encrypted: i=1; AJvYcCW9INTQVB2lFW1HgSi66ZrMsjRd2Xxw/PenOdv/+IGzlasFuEvS/wmOo0mSaw2z5gzKrMRCg3lfrDUOkfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzC5Ji1znWCG4k6pZ5BqVq4xrJ3sV089EUae0+9Vyl+BKIp/BL
	edpiuUwL2SG9M7OeZbaf9ykbibyUvsFlLJB9B8AJs53i4domttfC+KcZ
X-Gm-Gg: ASbGnctVQuBeE8VSuyOt3iybQ1wDeXEB8tX66T46hMvsVp3Zo02w6eJw+exBDWJlzOi
	vMHKplEKr/vkR2gJSnR/JCckpbSjlcMbfzhWY9KKgqYGFcnLwB4t+AxPFY7RjCJnJk5Rs9jTKSR
	UTrk+Us1gZmQJ1ANRC9ZqlFQwseI5IVgCbi7MJzXuYzkYEmCEebc2EOQhIymlFuUaLcQqmCTwY+
	5Lpg6xGmaOO9C9seovWxmw1sxHjFTwPGkbOIWnvYlBiT4DojRMTy9ivD1DJ9sR6oKof9eq19mdB
	Za1b7JrlZW1CVa4szPKFV0+yVnZr/RcO/ymTWhv62fC+RgABCxviIG9a2EduuAV+ZJoa6wY3eHm
	WTdbd4A+3dRapdGADt2Rxut9+7nGEhyzlTFJ9sjFnuSdZNR5m2T/OCdQe+51HbiKCEzl0lqFS+x
	Qe45TCajE=
X-Google-Smtp-Source: AGHT+IGLUImymLRUarqsG2KCT+ABE5J6HOGR+UWY59nzAscKl2lLvmhKB1esOHduNRD5/GEXTnJpNw==
X-Received: by 2002:ac8:5a08:0:b0:4d2:b9e3:c400 with SMTP id d75a77b69052e-4e89d292b40mr409532031cf.26.1761409758552;
        Sat, 25 Oct 2025 09:29:18 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ecef8c5850sm66241cf.15.2025.10.25.09.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:29:18 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/21] bits: Add BITS() macro
Date: Sat, 25 Oct 2025 12:28:43 -0400
Message-ID: <20251025162858.305236-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025162858.305236-1-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BITS(low, high) macro is preferable over a similar GENMASK(high, low)
because (low, high) parameters order is more natural. The (high, low)
order is confusing and has a record of misuse.

To enforce unintuitive parameters order, GENMASK() is enforced with
compile time checks. In addition, fixed-width versions of GENMASK() had
been developed. They make sense in describing hardware registers.

In generic code, using standard ordering (low to high) is more preferable,
and fixed-width features are not that useful.

In non-driver code, BITS() must be taken over GENMASK(). In drivers code,
BITS() is preferable over GENMASK().

The following pattern of using GENMASK() is highly unfavorable:

  /* Status register (SR) */
  #define I2C_SR_OP               GENMASK(1, 0)   /* Operation */
  #define I2C_SR_STATUS           GENMASK(3, 2)   /* controller status */
  #define I2C_SR_CAUSE            GENMASK(6, 4)   /* Abort cause */
  #define I2C_SR_TYPE             GENMASK(8, 7)   /* Receive type */
  #define I2C_SR_LENGTH           GENMASK(19, 9)  /* Transfer length */

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-=whoOUsqPKb7OQwhQf9H_3=5sXGPJrDbfQfwLB3Bi13tcQ@mail.gmail.com/
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 include/linux/bits.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index a40cc861b3a7..c7c587e90e2d 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -57,6 +57,9 @@
 #define GENMASK_U64(h, l)	GENMASK_TYPE(u64, h, l)
 #define GENMASK_U128(h, l)	GENMASK_TYPE(u128, h, l)
 
+#define BITS(l, h)		GENMASK(h, l)
+#define BITS_ULL(l, h)		GENMASK_ULL(h, l)
+
 /*
  * Fixed-type variants of BIT(), with additional checks like GENMASK_TYPE(). The
  * following examples generate compiler warnings due to -Wshift-count-overflow:
-- 
2.43.0


