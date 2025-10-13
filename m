Return-Path: <linux-kernel+bounces-850920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34425BD4E40
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A413B95ED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C72E313542;
	Mon, 13 Oct 2025 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="WUoKgkRq"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E40931353A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369747; cv=none; b=a86NDvNTAoKHUfXVhN2aZYu2OBGx60+wczmTXx5Ty8GvmRc61WQrE84jtdcKPnKMwVMAFoGI+gHyINoNp6XmTvpl1RGhZ6nkJ9V1dGfIXFgqGHVOnNIZza++jnCJfMMs/OMPu/c5bniIrXvb5WxooPcx64DZtn7vVyZbn1Htr4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369747; c=relaxed/simple;
	bh=WJWs+NFUcGbJALoN3wXML39lAbVPkKGzBxDYg5OA8Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9ck1xp2l72RQUNQSRfurqdigFtHuXFHv0KPkTe0RP1SeiXJtr99EId4Z3X0VPs+DnATe6xLMpNRrLtaizVFXBGAxydL7hwys8hXjSoE8HL4g/8O14/zigh4xKA1SfmdJ5cXarvzyhzt5VnBMduk1ygP7ckrC4k5fsiTkoaGxZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=WUoKgkRq; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-42f9c2d4a93so11807275ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760369743; x=1760974543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbPxvqkXmDdFxjU8mZBTBK/T+YiYjBFrlI/xnqdkqi8=;
        b=WUoKgkRqAJkfF1tMhRYKer0fra8bVJZ9xJqk9hGZ9WmsqgNg4iaaWd3nKWvbQJpBGz
         ASggX2PyiyVoKaUZFbuSwooJ3AIFyo0DNAWqKcsTxhfx8pEUBLR2iEsGyyk9QD3p0SFU
         cjZ+tHmoiYYLEYkscN3YGOuDI7gaw2Rc6H8ARkuUadXxus3UShc/TzN+KrkXfs3eYLD8
         mF6HlkyHvQVwo1wIwxXDZ2jEjaw8Rnm5HKmIYQF6Unq73NOxZsKg286AsHseVCqfGQLw
         Hq60x0xfIi569ooypm27zNiLmLGs6eT5e2vP7fCdck4CWuRxe44s+Huqr5BBkZbh/yRA
         cTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369743; x=1760974543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbPxvqkXmDdFxjU8mZBTBK/T+YiYjBFrlI/xnqdkqi8=;
        b=t99aF8ddlXPV0J+K40A0B93QVbpBzkG5sIFW+o6ylCY4sj43xeWBtV6yaEInLtOqGN
         r1fyHTZJ1xKuS8SdRCYzV8PLPFlwgtaLV4JjnNKMKLeqse/MLkoBgxN0SbT8t/UEp6re
         g6095walXZjvGzOa1QwgaRKGjY11tQwGvUlKm1ZnbXQDxohfuS8UdgjViTkIE+vpZdv0
         dDIbX4tCVL3SF+jGQpC6gf139ngDIOUVQD+l2PzvfcR0ia4T6ug5vIsGU08hn90hI4ai
         uR9pErJP1T70RHAou6fD0upMV6g5CouyeoEfEb2OqG+xO0nvsB92yfctbaZO/lnVn6k/
         8dGA==
X-Forwarded-Encrypted: i=1; AJvYcCUbFNixUqFPcquutUfCibanFgjGQTTjzI2mldUSZL5/deks08tiirO52i/YjzNP9we8WBTRwZRIFqF31ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOWpG89vkVyIFG++0yTa+pNru/FxEL/XF3S05XhT0Fal9j/Maj
	M9NCYRxVMkEj9IKNomL9tCMYugFD40YtXxjqVTLt9G4q1FS/3lduwZF95FpxnGnW0HQ=
X-Gm-Gg: ASbGncvG8YfBov2wJiuDymbXmCCpgcMmhehSNj1XceUAFCc6wv/i1CKdQmkblzIvKk7
	/cCJyOEpQZu7AhGekqRmaI8oO4Pug1WAOV/nD6GA3hM3OlVk/UzzWiqzuPzUxDzMYMWf63OZraB
	ZUPjKAy53qp0rLyvxFTZt9qls5+RjDbjLH6PwD6ztVdd19IDheu3QsF3vZUdu5lrQRS3xsb2MjG
	hUQj5HQjQ9pw2GBvTH65GUcWa9ThUaNkOCQnaePAyGiJWkAeUBePNW1ojPuqmaiOzU9go0ni2DK
	Ou+rO9PDgZwXpnwKxhq4ll4KBrshP4q7nxW04VOPYtgS391hXugEtWXCQcjR5S3Bor4wVd99U1Y
	lZtTx8ErzKmGzgW7gtAn4OYEjMSAP9B/zYYPJjtt1I32ePRYb97dbM1/LEsnHmIKBpaasC4/YJp
	aBd2g585nd
X-Google-Smtp-Source: AGHT+IE+RgkOmKUAmZ+h2lR6Ri91hcZZDy7nYDDMDTZK5PVvcsi3GRbcTYzKlh5jsPOXdbbG42NjVw==
X-Received: by 2002:a05:6e02:4918:b0:430:9bc3:e1d3 with SMTP id e9e14a558f8ab-4309bc3e4b3mr13658895ab.12.1760369743033;
        Mon, 13 Oct 2025 08:35:43 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6c49b522sm3910266173.1.2025.10.13.08.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 08:35:42 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	christian.bruel@foss.st.com,
	shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com,
	namcao@linutronix.de,
	thippeswamy.havalige@amd.com,
	inochiama@gmail.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] riscv: dts: spacemit: add a PCIe regulator
Date: Mon, 13 Oct 2025 10:35:23 -0500
Message-ID: <20251013153526.2276556-7-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251013153526.2276556-1-elder@riscstar.com>
References: <20251013153526.2276556-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a 3.3v fixed voltage regulator to be used by PCIe on the
Banana Pi BPI-F3.  On this platform, this regulator is always on.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - New patch, for a newly-added regulator

 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 2aaaff77831e1..046ad441b7b4e 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -30,6 +30,14 @@ led1 {
 			default-state = "on";
 		};
 	};
+
+	pcie_vcc_3v3: pcie-vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "PCIE_VCC3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 };
 
 &emmc {
-- 
2.48.1


