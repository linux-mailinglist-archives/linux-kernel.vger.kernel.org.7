Return-Path: <linux-kernel+bounces-632700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C47B6AA9AE9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 19:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30723170538
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D2B26FA47;
	Mon,  5 May 2025 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pCIUomfj"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C0C26C397
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466931; cv=none; b=Uj6oX7B2DTD2RnA0ENIGjKt8rJrWJcsaXuT8jYSkcNdHAD9RvuwtaIMAWPvpq5x8/2tLkCEAtmaxptDJyt+AJMuzdnOqtbVXNNXuI6hqZCowtD1rEx7tgZqzZ+omnvpb9Peu0t29diDW586yerpEJ+JTHpxoJVgZLJHs2EUcdvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466931; c=relaxed/simple;
	bh=wzhUOn6SQXmsn4tPkIwKptxiv30cDD2SlgD0U7jzTY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CFXBlFdjGzVsOtuR56G7z0mTynAuSBP4VmWtSpOL6rsvuU7vSdmpf8ByXnx2RuUXxu0VRfRUSReT7gHdAXMzR8by7+5GmsSKiFHNdiX1BFQF8oCRVUKSHsHpp5Fa12pEWZCa4G5QV4j9Nl7wPSeNYTmnWiyuItfLtTUcLKErln8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pCIUomfj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf680d351so29348765e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 May 2025 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746466928; x=1747071728; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OXzvNAVi4jxM1YBH1FVi5GE9G6myG9TL0qRERDXaLKg=;
        b=pCIUomfjXQJ3NMw0nSlMq/A5wcAEYQEYM+gUkZIBzg5Z4G+rYpSHci0gcojGI82pYj
         UfmqM3EVBKO7sxPV9s3xHAbF9wpfP5LbRvT6aVyVFp9uyamrEBSZFBpYnGOGTHuHFKPX
         GT2vqA5QbBOQgIbM9tk7PxeAK/cyrYblmt8/hjTIzaApcE/UQHEqzuVNhkaSW/vWjG/n
         GQvl7xkEF3cILgkCdWeUMJOKV0RExYHXKI2xL3B24MgWRYSZ5u0KXSEOkIc8JyYf+vmZ
         35ezp+gbjQgABp5nD4o+cesyP3s/5E63KNU/5ZLyZA73EmksTd7d76s0QXkrWBkHWKz+
         FB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746466928; x=1747071728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXzvNAVi4jxM1YBH1FVi5GE9G6myG9TL0qRERDXaLKg=;
        b=Jtj2bKRdTM85bnTnIORg3ifN5zV8P945wMQISIO1ZUHaQSmkCVaML8INApX5l9L7xB
         Ay2KRAka7gZwkJWBvqnYKl9ySyDNPoKIyGYWc1TqVdZBB6OY9GlqtK1Lc7tTHhdvj6JN
         KbItkHwwopPRYfu6nY8/V74qpGx8gdTlltZzucR6HgYAcI1cgdt3P3EeO2TpeT4BicUs
         T+hEkVvp191QfaXceFrNYkIftTp5jbDKJ+hWPX6I5QHbwOZ4D9zn3BGKGOsEGlqBaTbS
         IKNgtZst/rM7i6e4gJhA9FQH0p9mPs/q38TnNglpNa+UaC3s2FzVw0d+/wiIRd1EvtZl
         uLHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9F3D6ku+PgBzOy+a2yyJkMLfqExgeSLSkOFSg1Iclyry8Kv8tOeNeRfr0fhfscMVi+TZ7viINmXXt5NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3jnsojaVwlsLWN1cCnn8EMs966QnL2aTbgCut3+to89ax9Hwn
	qgnbV9Uw46ojE5tMogrwwWGJ77xSqAauayMLC5l+MJZkIyRL/p/iQphrH1Fmr8Q=
X-Gm-Gg: ASbGnct6k14PjNIOyEWiTuMMVna9//hXgmy61P157H+Laqt5FW9kr2pm5rtHJmQ6gDm
	dkBzw5Q4EsWwp8MRvK7+wNDU0x3YapiQJ3x7EuzvEt0U6Eknw0gVt/lP/Es0gX56nbzmFjAr7nW
	GeSIxfM5JbxnK8YpkdZ6kfxUazl6YalqbGX3tfhn95tVqjqi35FYBkcKdNKZnf4ZRG5ITVv0IMQ
	Hp+dJoOcf211bfno2XK2WMCglip6i4pz4HAtk3QXB/3V/yCVzjW6jbVFN5sU82CE6YaX8dLa6o/
	63YT84fQ1h2gVE0xhYwwLHEoANXFIRWW6J/+gM1UOeUc4i8l8UZJTA==
X-Google-Smtp-Source: AGHT+IHRnKbSits2P5iIFtqo/QiTaFPHb+gCCGIM4Jgg/30tALFDtg8UB0E5dn937De30sAXjVmM6w==
X-Received: by 2002:a05:600c:3b8e:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-441cff9b96amr2901515e9.3.1746466927739;
        Mon, 05 May 2025 10:42:07 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:dc81:e7a:3a49:7a3b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a099b0efbfsm11345829f8f.69.2025.05.05.10.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 10:42:07 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 05 May 2025 19:41:49 +0200
Subject: [PATCH 3/4] PCI: endpoint: pci-epf-vntb: allow arbitrary BAR
 configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pci-vntb-bar-mapping-v1-3-0e0d12b2fa71@baylibre.com>
References: <20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com>
In-Reply-To: <20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7388; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=wzhUOn6SQXmsn4tPkIwKptxiv30cDD2SlgD0U7jzTY8=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoGPhqNCKhu/Hyj44zyRvOXFRfw7gyFWaWCovPY
 FpAZdpup8aJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaBj4agAKCRDm/A8cN/La
 hQiMD/4jhj2xCwfqkgohC1TmN6kYITF6+zutI0KnDjKhg+PQNBhRdwrx+9LZIs4QgJTynHORe2w
 gVGoWbJavN80rNz6oCTFAWMcYRpFxzRe+Q/SxH2U/BE7T5T6GaVefRfckLmuZES2uPG2QLGmba8
 L8Asp4UtHAXt6Y5+BQNOL+d7WC2YkfQrdwCUv6ZrYsI9SLbH6DbZDe5OkBhktwfv+pmNBy9VEZK
 EIQl7g4iLfhx97o8XwvJcovhbM3VQwWA/7o0oJFZcN41i1DDqMilZHWdcd9b2CqnlVLleYjXqyY
 4ydj3WfFo/bL/qN7H6nNJJ/Wx4JiCWlbtv508/E1JxlPulLCpfam6dTkCgpUjM63Gwa+bF7EqH0
 8GnCI8TYHc8J8WteK0VkdN1ltFtwHveOy8KWMvkGEZYPKwshJnpQNDBt/wt9Bk/NS+14fvTzlb7
 J9tgoKGURN/5Wh5S3aDFOtqqjeWWFZJID2pofsoP6zpcHRPSWPvK4gjz3+MERK6ArIM04YzkWjk
 4CveVX2bTuhckYj6Sr/oPMeuL5d6opbEnY4U3spvmtUZJYaUzmAJ5g9DyTAUVpGLKyIyCLkaYaK
 7+imtxU6HMIo6miIX65e53Rh9LdqO+fGrDWTWeqOC10uQtLbq7udTN7n3JnUvTfGGCBRjwwQr1Y
 00jmfR5YYfOQxJw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The BAR configuration used by the PCI vNTB endpoint function is rather
fixed and does not allow to account for platform quirks. It simply
allocate BAR in order.

This is a problem on the Renesas platforms which have a 256B fixed BAR_4
which end-up being the MW1 BAR. While this BAR is not ideal for a MW, it
is adequate for the doorbells.

Add more configfs attributes to allow arbitrary BAR configuration to be
provided through the driver configfs. If not configuration is provided,
the driver should retain the old behaviour and allocate BARs in order.
This should keep existing userspace scripts working.

In the Renesas case mentioned above, the change allows to use BAR_2 as for
the MW1 region and BAR_4 for the doorbells.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 127 ++++++++++++++++++++++++--
 1 file changed, 120 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index f9f4a8bb65f364962dbf1e9011ab0e4479c61034..3cdccfe870e0cf738c93ca7c525fa2daa7c87fcb 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -74,6 +74,7 @@ enum epf_ntb_bar {
 	BAR_MW2,
 	BAR_MW3,
 	BAR_MW4,
+	VNTB_BAR_NUM,
 };
 
 /*
@@ -133,7 +134,7 @@ struct epf_ntb {
 	bool linkup;
 	u32 spad_size;
 
-	enum pci_barno epf_ntb_bar[6];
+	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
 
 	struct epf_ntb_ctrl *reg;
 
@@ -655,6 +656,59 @@ static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
 	pci_epc_put(ntb->epf->epc);
 }
 
+
+/**
+ * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
+ *
+ * Returns: 0 if unused, 1 if used.
+ */
+static int epf_ntb_is_bar_used(struct epf_ntb *ntb,
+			   enum pci_barno barno)
+{
+	int i;
+
+	for (i = 0; i < VNTB_BAR_NUM; i++) {
+		if (ntb->epf_ntb_bar[i] == barno)
+			return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * epf_ntb_set_bar() - Assign BAR number when no configuration is provided
+ * @ntb: NTB device that facilitates communication between HOST and VHOST
+ *
+ * When the BAR configuration was not provided through the userspace
+ * configuration, automatically assign BAR as it has been historically
+ * done by this endpoint function.
+ *
+ * Returns: the BAR number found, if any. -1 otherwise
+ */
+static int epf_ntb_set_bar(struct epf_ntb *ntb,
+			   const struct pci_epc_features *epc_features,
+			   enum epf_ntb_bar bar,
+			   enum pci_barno barno)
+{
+	while (ntb->epf_ntb_bar[bar] < 0) {
+		barno = pci_epc_get_next_free_bar(epc_features, barno);
+		if (barno < 0)
+			break; /* No more BAR available */
+
+		/*
+		 * Verify if the BAR found is not already assigned
+		 * through the provided configuration
+		 */
+		if (!epf_ntb_is_bar_used(ntb, barno))
+			ntb->epf_ntb_bar[bar] = barno;
+
+		barno += 1;
+	}
+
+	return barno;
+}
+
 /**
  * epf_ntb_init_epc_bar() - Identify BARs to be used for each of the NTB
  * constructs (scratchpad region, doorbell, memorywindow)
@@ -677,23 +731,21 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
 
 	/* These are required BARs which are mandatory for NTB functionality */
-	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++, barno++) {
-		barno = pci_epc_get_next_free_bar(epc_features, barno);
+	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++) {
+		barno = epf_ntb_set_bar(ntb, epc_features, bar, barno);
 		if (barno < 0) {
 			dev_err(dev, "Fail to get NTB function BAR\n");
 			return -EINVAL;
 		}
-		ntb->epf_ntb_bar[bar] = barno;
 	}
 
 	/* These are optional BARs which don't impact NTB functionality */
-	for (bar = BAR_MW1, i = 1; i < num_mws; bar++, barno++, i++) {
-		barno = pci_epc_get_next_free_bar(epc_features, barno);
+	for (bar = BAR_MW1, i = 1; i < num_mws; bar++, i++) {
+		barno = epf_ntb_set_bar(ntb, epc_features, bar, barno);
 		if (barno < 0) {
 			ntb->num_mws = i;
 			dev_dbg(dev, "BAR not available for > MW%d\n", i + 1);
 		}
-		ntb->epf_ntb_bar[bar] = barno;
 	}
 
 	return 0;
@@ -861,6 +913,37 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 	return len;							\
 }
 
+#define EPF_NTB_BAR_R(_name, _id)					\
+	static ssize_t epf_ntb_##_name##_show(struct config_item *item,	\
+					      char *page)		\
+	{								\
+		struct config_group *group = to_config_group(item);	\
+		struct epf_ntb *ntb = to_epf_ntb(group);		\
+									\
+		return sprintf(page, "%d\n", ntb->epf_ntb_bar[_id]);	\
+	}
+
+#define EPF_NTB_BAR_W(_name, _id)					\
+	static ssize_t epf_ntb_##_name##_store(struct config_item *item, \
+					       const char *page, size_t len) \
+	{								\
+	struct config_group *group = to_config_group(item);		\
+	struct epf_ntb *ntb = to_epf_ntb(group);			\
+	int val;							\
+	int ret;							\
+									\
+	ret = kstrtoint(page, 0, &val);					\
+	if (ret)							\
+		return ret;						\
+									\
+	if (val < NO_BAR || val > BAR_5)				\
+		return -EINVAL;						\
+									\
+	ntb->epf_ntb_bar[_id] = val;					\
+									\
+	return len;							\
+	}
+
 static ssize_t epf_ntb_num_mws_store(struct config_item *item,
 				     const char *page, size_t len)
 {
@@ -900,6 +983,18 @@ EPF_NTB_MW_R(mw3)
 EPF_NTB_MW_W(mw3)
 EPF_NTB_MW_R(mw4)
 EPF_NTB_MW_W(mw4)
+EPF_NTB_BAR_R(ctrl_bar, BAR_CONFIG)
+EPF_NTB_BAR_W(ctrl_bar, BAR_CONFIG)
+EPF_NTB_BAR_R(db_bar, BAR_DB)
+EPF_NTB_BAR_W(db_bar, BAR_DB)
+EPF_NTB_BAR_R(mw1_bar, BAR_MW1)
+EPF_NTB_BAR_W(mw1_bar, BAR_MW1)
+EPF_NTB_BAR_R(mw2_bar, BAR_MW1)
+EPF_NTB_BAR_W(mw2_bar, BAR_MW1)
+EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
+EPF_NTB_BAR_W(mw3_bar, BAR_MW3)
+EPF_NTB_BAR_R(mw4_bar, BAR_MW4)
+EPF_NTB_BAR_W(mw4_bar, BAR_MW4)
 
 CONFIGFS_ATTR(epf_ntb_, spad_count);
 CONFIGFS_ATTR(epf_ntb_, db_count);
@@ -911,6 +1006,12 @@ CONFIGFS_ATTR(epf_ntb_, mw4);
 CONFIGFS_ATTR(epf_ntb_, vbus_number);
 CONFIGFS_ATTR(epf_ntb_, vntb_pid);
 CONFIGFS_ATTR(epf_ntb_, vntb_vid);
+CONFIGFS_ATTR(epf_ntb_, ctrl_bar);
+CONFIGFS_ATTR(epf_ntb_, db_bar);
+CONFIGFS_ATTR(epf_ntb_, mw1_bar);
+CONFIGFS_ATTR(epf_ntb_, mw2_bar);
+CONFIGFS_ATTR(epf_ntb_, mw3_bar);
+CONFIGFS_ATTR(epf_ntb_, mw4_bar);
 
 static struct configfs_attribute *epf_ntb_attrs[] = {
 	&epf_ntb_attr_spad_count,
@@ -923,6 +1024,12 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
 	&epf_ntb_attr_vbus_number,
 	&epf_ntb_attr_vntb_pid,
 	&epf_ntb_attr_vntb_vid,
+	&epf_ntb_attr_ctrl_bar,
+	&epf_ntb_attr_db_bar,
+	&epf_ntb_attr_mw1_bar,
+	&epf_ntb_attr_mw2_bar,
+	&epf_ntb_attr_mw3_bar,
+	&epf_ntb_attr_mw4_bar,
 	NULL,
 };
 
@@ -1380,6 +1487,7 @@ static int epf_ntb_probe(struct pci_epf *epf,
 {
 	struct epf_ntb *ntb;
 	struct device *dev;
+	int i;
 
 	dev = &epf->dev;
 
@@ -1390,6 +1498,11 @@ static int epf_ntb_probe(struct pci_epf *epf,
 	epf->header = &epf_ntb_header;
 	ntb->epf = epf;
 	ntb->vbus_number = 0xff;
+
+	/* Initially, no bar is assigned */
+	for (i = 0; i < VNTB_BAR_NUM; i++)
+		ntb->epf_ntb_bar[i] = NO_BAR;
+
 	epf_set_drvdata(epf, ntb);
 
 	dev_info(dev, "pci-ep epf driver loaded\n");

-- 
2.47.2


