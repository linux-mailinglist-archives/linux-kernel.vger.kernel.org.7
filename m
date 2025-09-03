Return-Path: <linux-kernel+bounces-799183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0606B42819
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4E1581BB9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EB8324B09;
	Wed,  3 Sep 2025 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="yMI8zHJh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="THoCJYib"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052942D3ECA;
	Wed,  3 Sep 2025 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921113; cv=none; b=GKqUFaFwyJciqUFw0otY28BOWli40SVBKiWs9HxWq5cV/6AotnsugQZuaYdMxsU2irwCEoLp7aYKbNfdIDSqxIs2aZ2IbzBlOKk53bYBK8uBjEf1fCiWEpCuengIXjBFeDbBayBCBtmOvDgszg6HHmGKjxXRpKpRH2bz/HZK98A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921113; c=relaxed/simple;
	bh=ItYGcVqP6A+V+mcjkV8fZFfy5Z68J8sXqML1UZMt3XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F++9krzyZ74I0RsHkSOFZ6nIrw1cUlMYQilGs50Wnw5QEB15PArUUr552iBOMXUlB5pqGoH2yQrhRfm0Lbs6/cHWtJID5H1nlLteJlr/J2lqAHE1USCtyNZqkxJlIuSjnUdxq33VParJyUtast6Oo4DKHMmA0sma8fHm6u49Fbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=yMI8zHJh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=THoCJYib; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id EAC5D1D00443;
	Wed,  3 Sep 2025 13:38:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 03 Sep 2025 13:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756921109; x=
	1757007509; bh=DYnOaiAueoSQYCxZ7k7x4ZOs2okglK8ZwDzjOK2+1KQ=; b=y
	MI8zHJhL1TSpRYdxh4roANDGmiggsB27SOmLphvP8bkQOt2BnpBTPHpeytghDFDE
	EbzIzkefbeY9bvF7lWWozWaQNwaPz6bsI83F2osEbeSLJW7RDAqRPnC1J5bPSUQo
	YgDqenqqzaG7vvvhRa7h7Jm5vMQ0+eUspMQMsH3VBVVzv9cKKwsovywmY17ALKcD
	8G4cMlUB5BjDNHHOmDrmcGLX6zzQbPksYFifvT/lBrSLJcilwhSNJTgv2wWiS4bf
	VD4jK7CGwKYKTpngTZw1Nn2bsqHQCQBCTxHGbAHz7pYeAsYuvqaoF+BsjK2NacRT
	APa8aA4ATehAFs+AnNyiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756921109; x=1757007509; bh=D
	YnOaiAueoSQYCxZ7k7x4ZOs2okglK8ZwDzjOK2+1KQ=; b=THoCJYibrYIfSW9z9
	txc0msb6Y64SSwO5zqzlXcG0MykBYHMM8XvFR/IysM7Grtryt07nbN0DtVzlKb64
	bQQqQvLAGRsclK+Y6MJlwFgyp2jcbZ8vf3bZmD29jH47jB67j9V66h6l78S6SXdL
	bGn4rUlWk3k07l1x1pLZsrq6CF3uA4KcFut1Y11ZTvgUIfePp7ACe1P+/4g2D8PC
	eov/88Mrix5w95mSc5jWocycqYTzVqvV0LNmnskLsdJkm9jvr7cq+9jbyaFIJSRk
	3Lvu6OAEBWKyYasnD61P7ts6yBa0YWEcYSNoZSS8EUAJTEv1Zkg7DIUvaT71k6B0
	QkcTg==
X-ME-Sender: <xms:FX24aBO1v_zN7KevQZgcTvd_oTIelYNFQOJCmC8pNgRGWKpIXZ8aIg>
    <xme:FX24aLWh208WJp92lb7X3Wl6tBhaMXyiOEAwAyX3qp5yuZ7WllLe9w3-982PIZSh3
    -ibmMA27vhetzVowVI>
X-ME-Received: <xmr:FX24aF18dlvOklDm2ut7Pm2J2fupYQBHZRFIq-t1iCHFscIbkHvTbio6nHYQFCIlT7XRq8qzOXP4DH82COzy83gqJMSDXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephffvvefuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhhkucfrvggrrhhsohhnuceo
    mhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvg
    hrnhepfedtvdejfeelffevhffgjeejheduteetieeguefgkefhhfegjeduueethefgvdff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvg
    grrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhpvggrrhhsohhnqdhlvghnohhvoh
    esshhquhgvsggsrdgtrgdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhn
    uhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhgrnhhsgheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgvrghntddtgeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:FX24aJpdLpwFNY6ohIG4uq7GU8dzYjqkJtH0tH6Yoc08diDdo8TpXA>
    <xmx:FX24aMWkfYwxpyL4Bh3w1EJdPZaQlNOqCBQUSBFMOrKH_oIf82G0NA>
    <xmx:FX24aEb62LZ_A13tFWkiaPpzwyWQ22V9_P82-xX5HCb1Go3sD_R5gQ>
    <xmx:FX24aJfTEooNIyq0rsH2_JOa-16XOPQv0fedbxABVZyGoM3vDzBCAg>
    <xmx:FX24aJLTWGGFjSBmE-RlW-6UqDivG_DRA5nOCZ4fWvfc5Cej9mAXhW6X>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 13:38:28 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org,
	kean0048@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] platform/x86: think-lmi: Certificate support for ThinkCenter
Date: Wed,  3 Sep 2025 13:38:13 -0400
Message-ID: <20250903173824.1472244-3-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903173824.1472244-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20250903173824.1472244-1-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ThinkCenter platforms use a different set of GUIDs along with some
differences in implementation details for their support of
certificate based authentication.

Update the think-lmi driver to work correctly on these platforms.

Tested on M75q Gen 5.

Signed-off-by: Kean Ren <kean0048@gmail.com>
Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v2:
 - split patch up into series
Changes in v3:
 - Move check for no thumbprint GUID to this patch
 - Add structure fields and missing comma
Changes in v4:
 - Moved cert_guid into tlmi_priv
 - applied const where needed

 drivers/platform/x86/lenovo/think-lmi.c | 56 +++++++++++++++++++++----
 drivers/platform/x86/lenovo/think-lmi.h |  1 +
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
index de287987f20c..f2bef523d6ce 100644
--- a/drivers/platform/x86/lenovo/think-lmi.c
+++ b/drivers/platform/x86/lenovo/think-lmi.c
@@ -119,6 +119,7 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
  * You must reboot the computer before the changes will take effect.
  */
 #define LENOVO_SET_BIOS_CERT_GUID    "26861C9F-47E9-44C4-BD8B-DFE7FA2610FE"
+#define LENOVO_TC_SET_BIOS_CERT_GUID "955aaf7d-8bc4-4f04-90aa-97469512f167"
 
 /*
  * Name: UpdateBiosCert
@@ -128,6 +129,7 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
  * You must reboot the computer before the changes will take effect.
  */
 #define LENOVO_UPDATE_BIOS_CERT_GUID "9AA3180A-9750-41F7-B9F7-D5D3B1BAC3CE"
+#define LENOVO_TC_UPDATE_BIOS_CERT_GUID "5f5bbbb2-c72f-4fb8-8129-228eef4fdbed"
 
 /*
  * Name: ClearBiosCert
@@ -137,6 +139,8 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
  * You must reboot the computer before the changes will take effect.
  */
 #define LENOVO_CLEAR_BIOS_CERT_GUID  "B2BC39A7-78DD-4D71-B059-A510DEC44890"
+#define LENOVO_TC_CLEAR_BIOS_CERT_GUID  "97849cb6-cb44-42d1-a750-26a596a9eec4"
+
 /*
  * Name: CertToPassword
  * Description: Switch from certificate to password authentication.
@@ -145,6 +149,7 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
  * You must reboot the computer before the changes will take effect.
  */
 #define LENOVO_CERT_TO_PASSWORD_GUID "0DE8590D-5510-4044-9621-77C227F5A70D"
+#define LENOVO_TC_CERT_TO_PASSWORD_GUID "ef65480d-38c9-420d-b700-ab3d6c8ebaca"
 
 /*
  * Name: SetBiosSettingCert
@@ -153,6 +158,7 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
  * Format: "Item,Value,Signature"
  */
 #define LENOVO_SET_BIOS_SETTING_CERT_GUID  "34A008CC-D205-4B62-9E67-31DFA8B90003"
+#define LENOVO_TC_SET_BIOS_SETTING_CERT_GUID  "19ecba3b-b318-4192-a89b-43d94bc60cea"
 
 /*
  * Name: SaveBiosSettingCert
@@ -161,6 +167,7 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
  * Format: "Signature"
  */
 #define LENOVO_SAVE_BIOS_SETTING_CERT_GUID "C050FB9D-DF5F-4606-B066-9EFC401B2551"
+#define LENOVO_TC_SAVE_BIOS_SETTING_CERT_GUID "0afaf46f-7cca-450a-b455-a826a0bf1af5"
 
 /*
  * Name: CertThumbprint
@@ -187,6 +194,16 @@ static const struct tlmi_cert_guids thinkpad_cert_guid = {
 	.set_bios_cert = LENOVO_SET_BIOS_CERT_GUID,
 };
 
+static const struct tlmi_cert_guids thinkcenter_cert_guid = {
+	.thumbprint = NULL,
+	.set_bios_setting = LENOVO_TC_SET_BIOS_SETTING_CERT_GUID,
+	.save_bios_setting = LENOVO_TC_SAVE_BIOS_SETTING_CERT_GUID,
+	.cert_to_password = LENOVO_TC_CERT_TO_PASSWORD_GUID,
+	.clear_bios_cert = LENOVO_TC_CLEAR_BIOS_CERT_GUID,
+	.update_bios_cert = LENOVO_TC_UPDATE_BIOS_CERT_GUID,
+	.set_bios_cert = LENOVO_TC_SET_BIOS_CERT_GUID,
+};
+
 static const struct tlmi_err_codes tlmi_errs[] = {
 	{"Success", 0},
 	{"Not Supported", -EOPNOTSUPP},
@@ -678,6 +695,9 @@ static ssize_t cert_thumbprint(char *buf, const char *arg, int count)
 	const union acpi_object *obj;
 	acpi_status status;
 
+	if (!tlmi_priv.cert_guid->thumbprint)
+		return -EOPNOTSUPP;
+
 	status = wmi_evaluate_method(tlmi_priv.cert_guid->thumbprint, 0, 0, &input, &output);
 	if (ACPI_FAILURE(status)) {
 		kfree(output.pointer);
@@ -856,8 +876,16 @@ static ssize_t certificate_store(struct kobject *kobj,
 			return -EACCES;
 		}
 		guid = tlmi_priv.cert_guid->set_bios_cert;
-		/* Format: 'Certificate, password' */
-		auth_str = cert_command(setting, new_cert, setting->password);
+		if (tlmi_priv.thinkcenter_mode) {
+			/* Format: 'Certificate, password, encoding, kbdlang' */
+			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s,%s", new_cert,
+					     setting->password,
+					     encoding_options[setting->encoding],
+					     setting->kbdlang);
+		} else {
+			/* Format: 'Certificate, password' */
+			auth_str = cert_command(setting, new_cert, setting->password);
+		}
 	}
 	kfree(new_cert);
 	if (!auth_str)
@@ -1593,6 +1621,15 @@ static int tlmi_analyze(struct wmi_device *wdev)
 		wmi_has_guid(LENOVO_SAVE_BIOS_SETTING_CERT_GUID))
 		tlmi_priv.certificate_support = true;
 
+	/* ThinkCenter uses different GUIDs for certificate support */
+	if (wmi_has_guid(LENOVO_TC_SET_BIOS_CERT_GUID) &&
+	    wmi_has_guid(LENOVO_TC_SET_BIOS_SETTING_CERT_GUID) &&
+	    wmi_has_guid(LENOVO_TC_SAVE_BIOS_SETTING_CERT_GUID)) {
+		tlmi_priv.certificate_support = true;
+		tlmi_priv.thinkcenter_mode = true;
+		pr_info("ThinkCenter modified support being used\n");
+	}
+
 	/*
 	 * Try to find the number of valid settings of this machine
 	 * and use it to create sysfs attributes.
@@ -1738,11 +1775,16 @@ static int tlmi_analyze(struct wmi_device *wdev)
 	}
 
 	if (tlmi_priv.certificate_support) {
-		tlmi_priv.cert_guid = &thinkpad_cert_guid;
-		tlmi_priv.pwd_admin->cert_installed =
-			tlmi_priv.pwdcfg.core.password_state & TLMI_CERT_SVC;
-		tlmi_priv.pwd_system->cert_installed =
-			tlmi_priv.pwdcfg.core.password_state & TLMI_CERT_SMC;
+		if (tlmi_priv.thinkcenter_mode) {
+			tlmi_priv.cert_guid = &thinkcenter_cert_guid;
+			tlmi_priv.pwd_admin->cert_installed = tlmi_priv.pwdcfg.core.password_mode;
+		} else {
+			tlmi_priv.cert_guid = &thinkpad_cert_guid;
+			tlmi_priv.pwd_admin->cert_installed =
+				tlmi_priv.pwdcfg.core.password_state & TLMI_CERT_SVC;
+			tlmi_priv.pwd_system->cert_installed =
+				tlmi_priv.pwdcfg.core.password_state & TLMI_CERT_SMC;
+		}
 	}
 	return 0;
 
diff --git a/drivers/platform/x86/lenovo/think-lmi.h b/drivers/platform/x86/lenovo/think-lmi.h
index 59aa03c3f846..017644323d46 100644
--- a/drivers/platform/x86/lenovo/think-lmi.h
+++ b/drivers/platform/x86/lenovo/think-lmi.h
@@ -120,6 +120,7 @@ struct think_lmi {
 	enum save_mode save_mode;
 	bool save_required;
 	bool reboot_required;
+	bool thinkcenter_mode;
 
 	struct tlmi_attr_setting *setting[TLMI_SETTINGS_COUNT];
 	struct device *class_dev;
-- 
2.43.0


