Return-Path: <linux-kernel+bounces-762421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F52B20651
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA713A2BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E123278E42;
	Mon, 11 Aug 2025 10:47:52 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C77275B0F;
	Mon, 11 Aug 2025 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909272; cv=none; b=gg41tLsr3a+pAP/J/WR2RwwHpma6GL0hdgUKjziqlbx68B6Mo5qJIJw9Tv5J2KSEBKOsOV2DogHAulfD/fYQ+tbXBf1UekmHfxDKJCEF1DCFqS6nsWVcB2n6U5IzrICMshEuOPd51LXzYo8uP3+yatHfo+a8IPwwGRA9k1w9Zc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909272; c=relaxed/simple;
	bh=dOtIrM7ox54QEPluIC3wPqAqHmEZO4j++AB9W23pwn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpRB/Mv2Y1NyUtv7W6WZIi6wEHUjRPb21xJ2i2NMNA58wsqr7tk56gJPJub2VWmnuSXE+yjsrzQpC+ij0LYEw5FYmS1B4WRnKe4sBcdi0wK3dsfwNELwsbSYUcNXf9M7haZl4/zYNhizlnFopKzX6j2OpzdFTtqMv/hKtZeRPKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: zesmtpsz6t1754909184tb7a6923a
X-QQ-Originating-IP: XLhtpmiRHHGE1caGTDkiY7P4lEdyhA7haS8VXs9ijkI=
Received: from buildhost ( [183.17.229.251])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Aug 2025 18:46:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8630391488439946661
EX-QQ-RecipientCnt: 14
From: Nick Li <nick.li@foursemi.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	nick.li@foursemi.com
Cc: xiaoming.yang@foursemi.com,
	danyang.zheng@foursemi.com,
	like.xy@foxmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/5] MAINTAINERS: Add entry for FourSemi audio amplifiers
Date: Mon, 11 Aug 2025 18:46:10 +0800
Message-ID: <B9209BC5189B8946+20250811104610.8993-6-nick.li@foursemi.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811104610.8993-1-nick.li@foursemi.com>
References: <20250811104610.8993-1-nick.li@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OOmx3dwou5J60j6QIZJo/L42DRqyDo1ENETcHURaD0rOG5rhQ8HAWD6v
	Pf55bUMimRjHBg1X5sjxv9Tf4lkvCobFFffG3vOxBkNhRirI+Wt0ht3ySp/QMZeAE9wel8t
	XEHdiYAdPnqcqpsXtgPjP0ydh5MpStoUUvVms07kHLgwgCr0Wdv8PmMijX0j7UN/RYUruiZ
	rkzgRs7s70POReTgHxalAa/F+kqVdjK4xWRZgNdAPz8hXb4VA3QyNeN80gumyB958R2RyQV
	CXElQRi4YGzqGOyALr7lHLT+e6aEgay4+lnhdetjb5lLx7XH7h6KXhD3beLDmDXr4alic8h
	Hq0qgBhPSyzXf/37fFVkDE04Zku/yfIZbUS2irh83NNlXxbttz3fRl9oQaVdrxZysrLkybr
	ahvZhT3LqeL/VB7a4AC4noJg34Klf1yI16NuMLnXqSwvy7DlI1LNB/SbhgQ10rqZKfp+taL
	WhuRY/i7k9CnKaJL02d7i9Huc4RNZLRq0YaU+Dv03OLz98W8Be1+dGjA6ycPq7I5EiOpr0B
	/TSt1NkElfzXQCaZbu+1U9q62kN3idNdFJBHZrAvahM0WWANAIAcUcIyWFYTR30gcU9j6cv
	n6HkZ5AvOb31gm5B4RDN4N5YNM7AIt9FO7SyvTAwgC1R7B/TX7Sn4hfbLUNcVyMC1d1BI8c
	kHRL3P07GYRZpkYC5+5oDdoFSLfJPcjJJOKDXR5h78n2v1UANNvgHss35URv9aHfWQmk5hc
	DDBN31f6ZrUcfAHPfqACwgqVIjvaqBn6A8VlHtUk6r8AIt9D2JETyTU8ZYMJtNpUOqIMBby
	U7BrZukm9iD3mn8gMk999KcoVoS09mc6cqj4rzclLFyvzwZo7ftmNfY1vmO2gME6I2Ellqf
	Tg3OfXXNmEX9DvEb1HOAxCSyDaLTgla7CYCE7BcRBia2XEHCsZE37sClVRWf5xB73zD2lMw
	j91ysPiYx2K9yvyPv/JnPYVfnWUqZy1c6/dZcA3GWgLwrxUYhRiE8Yq7aojw2Z+T6tgOmlz
	8LePj6vPCc/Bn/U/Xjo89DmXYyzmaP8RsviLjgaPF8ICflVpYtGphlz0S4wjGeUneTEcV/+
	9shMYonPOgb
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Add entry for FourSemi maintainer and related files

Signed-off-by: Nick Li <nick.li@foursemi.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477c..dd38bd429 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9573,6 +9573,14 @@ F:	lib/tests/memcpy_kunit.c
 K:	\bunsafe_memcpy\b
 K:	\b__NO_FORTIFY\b
 
+FOURSEMI AUDIO AMPLIFIER DRIVER
+M:	Nick Li <nick.li@foursemi.com>
+L:	linux-sound@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/foursemi,fs2105s.yaml
+F:	sound/soc/codecs/fs-amp-lib.*
+F:	sound/soc/codecs/fs210x.*
+
 FPGA DFL DRIVERS
 M:	Xu Yilun <yilun.xu@intel.com>
 R:	Tom Rix <trix@redhat.com>
-- 
2.50.1


