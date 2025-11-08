Return-Path: <linux-kernel+bounces-891683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F085DC433F3
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 20:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88F73B3C4E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 19:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEA0285CA2;
	Sat,  8 Nov 2025 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USl2IoFd"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4900296BC9
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762630960; cv=none; b=vF8CBbZkPIoCi6Qrb6CtUpCPGxYNtUvjWrZ0WhtE11rQ7IYnkgWmwksA+lGQfkK+slXkN0nr0qJCMW5zetxp+nDml1jVaWu8JriyIATzvVtTo2yVDKyW5NUdcFDYn73F7swfG4VESMaNhxwBr/3KgpMpSqwjSyOP3p/sWEObrzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762630960; c=relaxed/simple;
	bh=SszDBRaNUcfYH1qxIpllXW9iu+7P8g2nMtcZjbjjKzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4e3PoVZFqIKwDDczGvQWIWeNbZxIrxL+t0wZVspXwm1Ryp5jqCY3X5BhEpZ5Amf3DqLWYU049UtV9BKz359VX6ALh4YRICxOeewbEjcz4gcdeHuKlF8/VLr//61JJntlUGJGte5lq/SZIER5225riA/md59GypX2wsLVACbwr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USl2IoFd; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37775ed97daso14758701fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 11:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762630954; x=1763235754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltV9lBgfXlitcw6NuoPhmSgpPYayy6Pa4t7Popjv7fk=;
        b=USl2IoFdPVfsQ/HvaHZgx6lHDr51d7Fwg4MF4AoLu/h0hxxKnp4Fo/+D7dGS3zyQ5v
         yh1Mm7Tnj63hTlntmvErcrLaFHmU82JkMbipB8OP27gwq7EuV8qJcJkBDKJAkzYMlulP
         9+/vpBVsRGu31cTIaWrmvw6TOfOOdbbSrJsNxzuBf+MFxmUeF/gmhQMqIBfqVRPwevFD
         O5nzmtg0OT/WyeWDIGESBAVIN3eJaanYInn5Vm5fsEcAeZXDL+tQBhiZ6YEUZsB3uZu0
         FvbA5ySGIdKpmpoIPbPnIF4Zp6kcj2VlbNblnGM9XtPrSVrIKc2no1mcrfkcPLGLxqDn
         3oeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762630954; x=1763235754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ltV9lBgfXlitcw6NuoPhmSgpPYayy6Pa4t7Popjv7fk=;
        b=Z18pY+fZbPnRNV5CCPppx5tY5O9yT2EJdozO7RKKpJApw0QoXv6BfgKJEAtWJSdRld
         LrVOYBdOsSr8mNrZCq5sew0YRoql/9b2dJeS9aSIy1pIXrt7F2IBZu1RWVSiE828Coir
         LkS7bTzw6fgzviZWG3kAwqnHA16UTcxC68lNTA/WZjYHJvSd65VkvG5xl8g7A8BCf1E4
         2kCaKWiOxq6PHkuzj1q8FZTXR/MnhOQIeSpyFmpOUD94yHR8YQvtGlpG6/T8EUN5WurJ
         HkZdRHo+fHuLUb/q9FE9Lb4wAm0eHQ7hSLKsV2MQW3XOeVF4ScOokHzniecS5scvO9JM
         RttA==
X-Forwarded-Encrypted: i=1; AJvYcCXFqXgBMDEM2TxSNCv0+adozQttIb+g7o6qVe5vSKTwHhI1UqhW/0Ty6DLdi7OT0LdsvBpQ3AG2gi18gtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmIlNbXcBLM3874DinrghjWFFhOVoxfVtOviJEFbg8kdXa5p5G
	v5AgR3uZE3Q1Ev0w478rovDchbDCfkXq7OFLALtohR+cYzuyQXTxlUjO
X-Gm-Gg: ASbGnctL7nwBOXsGiB27xfbcLbKBIlvubD6HohbziFfg2iHhfX7oOBkFumh9iYf0Lyc
	UOJ8UrpKDIpjT6ogAel9UFgE83sVNVOc2dMker3vn5qYk6JTZYnIQH+/rFxb+vaBoz9z2QB7sin
	L1XcgvQu8bMVEt7gaqEE0ATHdJLzsMDkYFk37sZf68TbPF5vyvsESZ1OfCZYMs2nK1jOxO4CRcJ
	YnHPWYs2vfo/shsDchlyZDYPv3jaEVSoNhsgqu1/hVQ7ix/knlohLQ7ZWlNDyn0KNtyHUDlbX3Y
	ZoVAJHgcNCKpFgWmfWisEERXtccOXcSxfNeLeYaSHRY9JyAtSDBmw4UOOJMIBxCVjrBP7iP0nOP
	0cK3CdHhzBnjSuOWMck1jKh+j3hgsWEZKntMMtShdzk25yZI+VOuFrETGYyDB3mSGtXw=
X-Google-Smtp-Source: AGHT+IEnp2oCa8v72xcKOc9ex+oyKcuP8x4+4rtHE2r1uNJigvtF1xOkKOxOtbzS+RRziZBzol+Trg==
X-Received: by 2002:a2e:9cc5:0:b0:377:c556:68b7 with SMTP id 38308e7fff4ca-37a7b282782mr7624071fa.17.1762630954001;
        Sat, 08 Nov 2025 11:42:34 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-37a5f0edac3sm22115421fa.38.2025.11.08.11.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:42:32 -0800 (PST)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Joel Granados <joel.granados@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v4 5/9] riscv: csr: define vtype registers elements
Date: Sat,  8 Nov 2025 22:41:44 +0300
Message-ID: <20251108194207.1257866-6-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251108194207.1257866-1-geomatsi@gmail.com>
References: <20251108194207.1257866-1-geomatsi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define masks and shifts for vtype csr according to the RVV spec 1.0.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 arch/riscv/include/asm/csr.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 4a37a98398ad..4f55dcf86627 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -444,6 +444,17 @@
 #define CSR_VTYPE		0xc21
 #define CSR_VLENB		0xc22
 
+#define VTYPE_VLMUL		_AC(7, UL)
+#define VTYPE_VLMUL_FRAC	_AC(4, UL)
+#define VTYPE_VSEW_SHIFT	3
+#define VTYPE_VSEW		(_AC(7, UL) << VTYPE_VSEW_SHIFT)
+#define VTYPE_VTA_SHIFT		6
+#define VTYPE_VTA		(_AC(1, UL) << VTYPE_VTA_SHIFT)
+#define VTYPE_VMA_SHIFT		7
+#define VTYPE_VMA		(_AC(1, UL) << VTYPE_VMA_SHIFT)
+#define VTYPE_VILL_SHIFT	(__riscv_xlen - 1)
+#define VTYPE_VILL		(_AC(1, UL) << VTYPE_VILL_SHIFT)
+
 /* Scalar Crypto Extension - Entropy */
 #define CSR_SEED		0x015
 #define SEED_OPST_MASK		_AC(0xC0000000, UL)
-- 
2.51.0


