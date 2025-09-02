Return-Path: <linux-kernel+bounces-797313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F4210B40EB5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EEA55E0BCA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECEB35AAB2;
	Tue,  2 Sep 2025 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ht41DGqA"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D353570AF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845900; cv=none; b=T3r//p5jYaiqPSFEEZx2GXvhpZ/B5C/RM5pS3goM8VIZwgAK/4MPN827jydDUyrxTPYJq5aJM3yot+ZUKMVxkTp4C+Q9Hvn38twjdJdewgwl0gtuMH5A/Kcgpmv4VhcWYqoP/V1EiUErcoFgno+fjEHkw0n9C0NZ2P9npavjZRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845900; c=relaxed/simple;
	bh=+ulTgVMuc8q58rccheVSt5e6g1eN8x/meYpqfjuKxlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ucPr3tSY5l//wNiQCyOjFhZo6+cCo2L4NXIDLzL+Ejg24t6+sWlt2QszIgX+tQLnQuFFOwP6GIZGBvF6Vs5qTGQkpJNGloA2IjZciM0+cyMHjSI/lZPaWLi0cvTMpYy0kvqZal4V9oUy12ZIpJmxcT6pBKJTUy7IPE00eRqV8d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ht41DGqA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756845897;
	bh=+ulTgVMuc8q58rccheVSt5e6g1eN8x/meYpqfjuKxlg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ht41DGqAtDj/YP4N6+QjAve+5zbn/kG4bhe9Dfp3jhC+yXCTsJfMGvyfsNSRjTtrn
	 svQXxA5Zz3T+SqyqxZ7O0EHgnUL5FqVcO5j3PbWbsiU8fb439EpJ8GWO8mWc3oitMr
	 pG0BILiwWMNVQ+6TBqrNjH9hGNzgPyW8p9Wn1Qam0+oS8S3gVePDHNtjszLpOnNBht
	 0XUlZ9pxE3UrjXDrl8vxwKIEfAt3FyIi2jn6wf1yt2XHgDIVKt4jm8HnqTN+bOKKc6
	 3d62tIhWf7p15sAgYcR5rmL2CxSlPZgD+U85+2wyt38JmfKurb56Qv8LD6pQL/sYLL
	 vCP9wRp6d6T5A==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 5ADC817E0456;
	Tue,  2 Sep 2025 22:44:57 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 23:44:41 +0300
Subject: [PATCH v4 06/11] phy: rockchip: samsung-hdptx: Cleanup
 *_cmn_init_seq lists
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-phy-hdptx-frl-v4-6-7d69176373ce@collabora.com>
References: <20250902-phy-hdptx-frl-v4-0-7d69176373ce@collabora.com>
In-Reply-To: <20250902-phy-hdptx-frl-v4-0-7d69176373ce@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

Drop redundant reg_sequence entries from rk_hdptx_common_cmn_init_seq[],
i.e. those that are either duplicated or overridden in
rk_hdptx_tmds_cmn_init_seq[].

Additionally, a few items do not really belong to the former, hence move
them to the latter.  That's mostly a preparatory step for adding FRL
support.

No functional changes intended at this point.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 574e468e5070d225aa5ce4d648aad2bcae851b4b..8e38adcb8f13325b87e27d6d809cfa1bfd91521c 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -465,13 +465,11 @@ static const struct reg_sequence rk_hdptx_common_cmn_init_seq[] = {
 	REG_SEQ0(CMN_REG(000e), 0x0f),
 	REG_SEQ0(CMN_REG(000f), 0x0f),
 	REG_SEQ0(CMN_REG(0010), 0x04),
-	REG_SEQ0(CMN_REG(0011), 0x00),
 	REG_SEQ0(CMN_REG(0012), 0x26),
 	REG_SEQ0(CMN_REG(0013), 0x22),
 	REG_SEQ0(CMN_REG(0014), 0x24),
 	REG_SEQ0(CMN_REG(0015), 0x77),
 	REG_SEQ0(CMN_REG(0016), 0x08),
-	REG_SEQ0(CMN_REG(0017), 0x00),
 	REG_SEQ0(CMN_REG(0018), 0x04),
 	REG_SEQ0(CMN_REG(0019), 0x48),
 	REG_SEQ0(CMN_REG(001a), 0x01),
@@ -479,13 +477,7 @@ static const struct reg_sequence rk_hdptx_common_cmn_init_seq[] = {
 	REG_SEQ0(CMN_REG(001c), 0x01),
 	REG_SEQ0(CMN_REG(001d), 0x64),
 	REG_SEQ0(CMN_REG(001f), 0x00),
-	REG_SEQ0(CMN_REG(0026), 0x53),
 	REG_SEQ0(CMN_REG(0029), 0x01),
-	REG_SEQ0(CMN_REG(0030), 0x00),
-	REG_SEQ0(CMN_REG(0031), 0x20),
-	REG_SEQ0(CMN_REG(0032), 0x30),
-	REG_SEQ0(CMN_REG(0033), 0x0b),
-	REG_SEQ0(CMN_REG(0034), 0x23),
 	REG_SEQ0(CMN_REG(0035), 0x00),
 	REG_SEQ0(CMN_REG(0038), 0x00),
 	REG_SEQ0(CMN_REG(0039), 0x00),
@@ -496,7 +488,6 @@ static const struct reg_sequence rk_hdptx_common_cmn_init_seq[] = {
 	REG_SEQ0(CMN_REG(003f), 0x83),
 	REG_SEQ0(CMN_REG(0040), 0x06),
 	REG_SEQ0(CMN_REG(0041), 0x20),
-	REG_SEQ0(CMN_REG(0042), 0xb8),
 	REG_SEQ0(CMN_REG(0043), 0x00),
 	REG_SEQ0(CMN_REG(0044), 0x46),
 	REG_SEQ0(CMN_REG(0045), 0x24),
@@ -506,14 +497,9 @@ static const struct reg_sequence rk_hdptx_common_cmn_init_seq[] = {
 	REG_SEQ0(CMN_REG(004b), 0x00),
 	REG_SEQ0(CMN_REG(004c), 0x01),
 	REG_SEQ0(CMN_REG(004d), 0x64),
-	REG_SEQ0(CMN_REG(004e), 0x14),
 	REG_SEQ0(CMN_REG(004f), 0x00),
 	REG_SEQ0(CMN_REG(0050), 0x00),
-	REG_SEQ0(CMN_REG(005d), 0x0c),
 	REG_SEQ0(CMN_REG(005f), 0x01),
-	REG_SEQ0(CMN_REG(006b), 0x04),
-	REG_SEQ0(CMN_REG(0073), 0x30),
-	REG_SEQ0(CMN_REG(0074), 0x00),
 	REG_SEQ0(CMN_REG(0075), 0x20),
 	REG_SEQ0(CMN_REG(0076), 0x30),
 	REG_SEQ0(CMN_REG(0077), 0x08),
@@ -525,13 +511,10 @@ static const struct reg_sequence rk_hdptx_common_cmn_init_seq[] = {
 	REG_SEQ0(CMN_REG(007e), 0x00),
 	REG_SEQ0(CMN_REG(007f), 0x00),
 	REG_SEQ0(CMN_REG(0080), 0x00),
-	REG_SEQ0(CMN_REG(0081), 0x09),
 	REG_SEQ0(CMN_REG(0082), 0x04),
 	REG_SEQ0(CMN_REG(0083), 0x24),
 	REG_SEQ0(CMN_REG(0084), 0x20),
 	REG_SEQ0(CMN_REG(0085), 0x03),
-	REG_SEQ0(CMN_REG(0086), 0x01),
-	REG_SEQ0(CMN_REG(0087), 0x0c),
 	REG_SEQ0(CMN_REG(008a), 0x55),
 	REG_SEQ0(CMN_REG(008b), 0x25),
 	REG_SEQ0(CMN_REG(008c), 0x2c),
@@ -543,7 +526,6 @@ static const struct reg_sequence rk_hdptx_common_cmn_init_seq[] = {
 	REG_SEQ0(CMN_REG(0092), 0x00),
 	REG_SEQ0(CMN_REG(0093), 0x00),
 	REG_SEQ0(CMN_REG(009a), 0x11),
-	REG_SEQ0(CMN_REG(009b), 0x10),
 };
 
 static const struct reg_sequence rk_hdptx_tmds_cmn_init_seq[] = {
@@ -577,9 +559,13 @@ static const struct reg_sequence rk_hdptx_tmds_cmn_init_seq[] = {
 	REG_SEQ0(CMN_REG(0048), 0x11),
 	REG_SEQ0(CMN_REG(004e), 0x34),
 	REG_SEQ0(CMN_REG(005c), 0x25),
+	REG_SEQ0(CMN_REG(005d), 0x0c),
 	REG_SEQ0(CMN_REG(005e), 0x4f),
+	REG_SEQ0(CMN_REG(006b), 0x04),
+	REG_SEQ0(CMN_REG(0073), 0x30),
 	REG_SEQ0(CMN_REG(0074), 0x04),
 	REG_SEQ0(CMN_REG(0081), 0x01),
+	REG_SEQ0(CMN_REG(0086), 0x01),
 	REG_SEQ0(CMN_REG(0087), 0x04),
 	REG_SEQ0(CMN_REG(0089), 0x00),
 	REG_SEQ0(CMN_REG(0095), 0x00),

-- 
2.51.0


