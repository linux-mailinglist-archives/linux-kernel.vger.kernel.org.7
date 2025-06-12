Return-Path: <linux-kernel+bounces-683952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E03AD7411
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 16:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C16947AA30A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 14:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3854248F5F;
	Thu, 12 Jun 2025 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O52qP6DE"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9252417F0
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738968; cv=none; b=kBdXBmqQacqVeYwSQTta37PV2/aG37S1lIi0nfNRMmltFddeDnfQRb0IFX/kLaAW1tqaFebbwlmUxR5JfLTYz7YLlqMzi4hPYOH94y2sDuVfnWVPcmFHKlyg1LxO7xwPW3nzbs7a0hB3HnoDSLHdUWpj/h7l1Q0ZsTN3SLWW4OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738968; c=relaxed/simple;
	bh=e7mQm6vylBR2bfztnRuyfarlV7hi9abXFDp0hheyUCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWOo4Bd/oqcnS/D6JA6pkAJmIcCgyfCGRR3/E/24WbPVCv1JpFICpq9D0mCWXyaa69R1KiXwQPl6Fn2MR22M2mcLjHHruLeZ7Uzf1U7WCyu8msU1qbAz7n+HaDziFX4EHYhUq79NmORLfmQNSPzpl03ysunsNULUSUoxu6xB1+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O52qP6DE; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749738951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Dx8aeEOgTzQw2K+RDp/d5UZ3Ss5Ti7d4DLVlPWSC39o=;
	b=O52qP6DEGc2tyZWZq9YK7cKtLONNqeL8DmRQeYMDqAF0QftZJ9TzgRtrC72SqkWHO9cuNL
	LUGmxdpSIq9Eplg9mj8YaEc4lI0o8FeAwf+f/nxim07CU35YpbcINTR911o4IaoSgVv5Gx
	fiqB9x7pAfGnYO0W2IFFdC1/1oAMqT0=
From: Yajun Deng <yajun.deng@linux.dev>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH RESEND net-next v2] net: phy: Add c45_phy_ids sysfs directory entry
Date: Thu, 12 Jun 2025 14:35:32 +0000
Message-ID: <20250612143532.4689-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The phy_id field only shows the PHY ID of the C22 device, and the C45
device did not store its PHY ID in this field.

Add a new phy_mmd_group, and export the mmd<n>_device_id for the C45
device. These files are invisible to the C22 device.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v2: Only one value for per file and invisible to the C22 device.
v1: https://lore.kernel.org/all/20250523132606.2814-1-yajun.deng@linux.dev/
---
 .../ABI/testing/sysfs-class-net-phydev        | 10 +++
 drivers/net/phy/phy_device.c                  | 62 ++++++++++++++++++-
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-net-phydev b/Documentation/ABI/testing/sysfs-class-net-phydev
index ac722dd5e694..31615c59bff9 100644
--- a/Documentation/ABI/testing/sysfs-class-net-phydev
+++ b/Documentation/ABI/testing/sysfs-class-net-phydev
@@ -26,6 +26,16 @@ Description:
 		This ID is used to match the device with the appropriate
 		driver.
 
+What:		/sys/class/mdio_bus/<bus>/<device>/c45_phy_ids/mmd<n>_device_id
+Date:		June 2025
+KernelVersion:	6.17
+Contact:	netdev@vger.kernel.org
+Description:
+		This attribute contains the 32-bit PHY Identifier as reported
+		by the device during bus enumeration, encoded in hexadecimal.
+		These C45 IDs are used to match the device with the appropriate
+		driver. These files are invisible to the C22 device.
+
 What:		/sys/class/mdio_bus/<bus>/<device>/phy_interface
 Date:		February 2014
 KernelVersion:	3.15
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 73f9cb2e2844..5e5bac8d8651 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -645,11 +645,69 @@ static struct attribute *phy_dev_attrs[] = {
 	&dev_attr_phy_dev_flags.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(phy_dev);
+
+static const struct attribute_group phy_dev_group = {
+	.attrs = phy_dev_attrs,
+};
+
+#define MMD_INDICES \
+	_(1) _(2) _(3) _(4) _(5) _(6) _(7) _(8) \
+	_(9) _(10) _(11) _(12) _(13) _(14) _(15) _(16) \
+	_(17) _(18) _(19) _(20) _(21) _(22) _(23) _(24) \
+	_(25) _(26) _(27) _(28) _(29) _(30) _(31)
+
+#define MMD_DEVICE_ID_ATTR(n) \
+static ssize_t mmd##n##_device_id_show(struct device *dev, \
+				struct device_attribute *attr, char *buf) \
+{ \
+	struct phy_device *phydev = to_phy_device(dev); \
+	return sysfs_emit(buf, "0x%.8lx\n", \
+			 (unsigned long)phydev->c45_ids.device_ids[n]); \
+} \
+static DEVICE_ATTR_RO(mmd##n##_device_id)
+
+#define _(x) MMD_DEVICE_ID_ATTR(x);
+MMD_INDICES
+#undef _
+
+static struct attribute *phy_mmd_attrs[] = {
+	#define _(x) &dev_attr_mmd##x##_device_id.attr,
+	MMD_INDICES
+	#undef _
+	NULL
+};
+
+static umode_t phy_mmd_is_visible(struct kobject *kobj,
+				  struct attribute *attr, int index)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct phy_device *phydev = to_phy_device(dev);
+	const int i = index + 1;
+
+	if (!phydev->is_c45)
+		return 0;
+	if (i >= ARRAY_SIZE(phydev->c45_ids.device_ids) ||
+	    phydev->c45_ids.device_ids[i] == 0xffffffff)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group phy_mmd_group = {
+	.name = "c45_phy_ids",
+	.attrs = phy_mmd_attrs,
+	.is_visible = phy_mmd_is_visible,
+};
+
+static const struct attribute_group *phy_device_groups[] = {
+	&phy_dev_group,
+	&phy_mmd_group,
+	NULL,
+};
 
 static const struct device_type mdio_bus_phy_type = {
 	.name = "PHY",
-	.groups = phy_dev_groups,
+	.groups = phy_device_groups,
 	.release = phy_device_release,
 	.pm = pm_ptr(&mdio_bus_phy_pm_ops),
 };
-- 
2.25.1


