Return-Path: <linux-kernel+bounces-827975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2955AB93916
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D8A16C7E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1310A1F4191;
	Mon, 22 Sep 2025 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH6EpV6B"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4772DEA68
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583551; cv=none; b=LZ6z6Oo0gfL5blzW9kYrLYkqn9XJ7VJJCMMoFpwgZjmYdwvDHGAJUvrPb26qDBzDneFV9Mmnq4n3i2nktXppLFtidpEoeuQvBZzTCCb2bKIJ1UxBsFwBxBOlgTsjpWvFmcDm9G8w/yvt5+BKlSbHmWQkWtwv9ebIVBuLVhibqas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583551; c=relaxed/simple;
	bh=JLZ6zJ1daf0+CDFQwAvOjSOsjU7qluGVOxSDdjbTdGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=skM5r2ETUdlS/mA6KoM8Hbu5fdhuUrqypy8AzBTyrAONBOxDh6aRjbk3Ju9FUvz8PT9FIr/gtZzJ2lW8DrHIkfmZ6UIIoj9D0IznC0VJH5z8c3fDNp0ksHf82TaFYUv5Ql2YKq3JmZ4sqNJ8enDm3IZbk18rRX4ASlOH4lNkOvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XH6EpV6B; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-78defc1a2afso62233386d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758583548; x=1759188348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F8P93O7mFuM2RNG5Gl6sjJK4baF70StwSvvALSzglIM=;
        b=XH6EpV6BHReVvprvhMpDJIvi4VCnqHWcSO41mk/v9YeSE131IcMOJ6aiE6zO7f4vPv
         f+5ZdQrtuKrJV9tVVMnkHpG/t/UKqABY6567YqPBh1vj/EifwJnuMWxqYURHxz2V4o7h
         iQKVcwlSMNsthevnbAw3mYa82yBzMPj7QqtFiEQlboFImQIWtn6+Zs/De2bPjjHwHE8O
         JVDE3X1VYlDEOeAhEJ0SQUXQWR5YvjHfDpBr8UxpD5lDp9bk7e/ISOFK3D2QfuM1HhEM
         n37htnbwdhkyi+B+1mI5s3K4C0MvSjTNU+HcRNOQvSy1hTiK20kIrocacoypio4UCRHi
         tH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758583548; x=1759188348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8P93O7mFuM2RNG5Gl6sjJK4baF70StwSvvALSzglIM=;
        b=Teh3pj1Bs72I8Phz4iNaSHFBSznlA4yCxljbjKHTKhhr3QH4p7++1i7mDEYbacIl/x
         4ldEae+yO4pNecRMjaAzaVSEuYu9pcd2lM47LDwj67MxKSICTZortiSfwuVuJeDQGOKb
         FSBmQFRGC7Nf69VUjwZ5lAvmZC6o7nwl9j/zPXlqGGwfm/I+sTLlbHHZYElF7wlATpyk
         Xdb+gHl97qhwbefccoQQIFLIskwoHXtdR0Nid48e7w7igWsyXpAfXhytOWIPcSDoTijG
         tsgdtWqW03EdjveVC332BjEytdmOtLbLHkD+P3M6SJcPugULqnFVksPY8aIHn/sgl6mc
         qgmA==
X-Forwarded-Encrypted: i=1; AJvYcCXMBAjhGeRUoWGc2TaMRueKyYRqZwESMoatf52IpNreuZLr7/IcDBu7uhHKo/RkpelUTWSH3AgsNOJAigg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9lZoDw15qHmTbM2yW+XPDqrh6+oPaLNWIkc6+M8w4k0guoCTu
	gSQuaoZOh/JMkexmWLN2ddPl483bi7LG78cvAvVQxbW8ChKVGkpuV4fF
X-Gm-Gg: ASbGncs62U+j1B7zyCmjho71KmDTExEyq9Gq4hY5lPHQwSHeSMh8dtdgs7n8Z+60mj7
	LGmcWmvocx/Rs+BswHPDUeY8lgnrBxMnesH8pg0dL4/xBle0uee4zBLAtlEaCfZ6DBqO8t1GmEb
	/20lqn5OzsOj7wxPSWUpDt0PYGawO4Pn4d+aZpHzkP2bo4TG1qOliice5LoAW6ysGE8qdOnsW4U
	WHoU3F3NLty4icP24J8v5x2AOjIsqOU72ZmKYCwq690fuiFdEaIai2367S0ityTEj7WVepaYvq8
	oaEL2MO9SXXSoSWnNhwyspdeb76931BXEaUq83cXw+E4oU2tW5j8ZbnmJAVCv5nQMNVpPBlsF9z
	YYNW2soDHBPu/TTpBYmipVWdDZ4E2UMO/3rsmD8Lf
X-Google-Smtp-Source: AGHT+IFbSBgrLxfeIQurMy9quETHgDR5erLT96k/GtUBVfyP12lxyT/MwQ6vyqqabYOGY6hcIz9rTg==
X-Received: by 2002:ad4:5ce1:0:b0:777:2f9d:71ca with SMTP id 6a1803df08f44-7e719766627mr7924456d6.56.1758583547736;
        Mon, 22 Sep 2025 16:25:47 -0700 (PDT)
Received: from rogerio-laptop.home ([184.148.194.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793548c63desm79417226d6.57.2025.09.22.16.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:25:47 -0700 (PDT)
From: Rogerio Pimentel <rpimentel.silva@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: xiaofeng.wei@nxp.com,
	kernel@pengutronix.de,
	festevam@gmail.com,
	alexander.stein@ew.tq-group.com,
	dario.binacchi@amarulasolutions.com,
	marex@denx.de,
	Markus.Niebel@tq-group.com,
	y.moog@phytec.de,
	joao.goncalves@toradex.com,
	frieder.schrempf@kontron.de,
	josua@solid-run.com,
	francesco.dolcini@toradex.com,
	primoz.fiser@norik.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rogerio Pimentel <rpimentel.silva@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: fsl: Add i.MX8MP FRDM board
Date: Mon, 22 Sep 2025 19:25:22 -0400
Message-Id: <20250922232523.844633-1-rpimentel.silva@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree compatible string for the i.MX8MP FRDM board.

Signed-off-by: Rogerio Pimentel <rpimentel.silva@gmail.com>
---

No changes in v3

No changes in v2


 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 00cdf490b062..8bddf1f8a78d 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1099,6 +1099,7 @@ properties:
               - emcraft,imx8mp-navqp      # i.MX8MP Emcraft Systems NavQ+ Kit
               - fsl,imx8mp-evk            # i.MX8MP EVK Board
               - fsl,imx8mp-evk-revb4      # i.MX8MP EVK Rev B4 Board
+              - fsl,imx8mp-frdm           # i.MX8MP Freedom Board
               - gateworks,imx8mp-gw71xx-2x # i.MX8MP Gateworks Board
               - gateworks,imx8mp-gw72xx-2x # i.MX8MP Gateworks Board
               - gateworks,imx8mp-gw73xx-2x # i.MX8MP Gateworks Board
-- 
2.25.1


