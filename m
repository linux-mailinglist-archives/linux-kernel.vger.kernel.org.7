Return-Path: <linux-kernel+bounces-753497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE4FB183BA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90991C83737
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3812A4A1D;
	Fri,  1 Aug 2025 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="ZOiTnNNQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FAlGCjY2"
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E2A24A06D;
	Fri,  1 Aug 2025 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058418; cv=none; b=PdlWgxJMaE56D6V0Ceprri1j+xJNA/VOJkzFIMDo3oEyhv+Cmj+UgwNjv8iLy6JuEgmMHQ78NaYkkH+LyercHYZcZpBdvt3/2bupHATFJA4enBSxOiwLoLMc+DiLSLQkzyPgZznD0ppGW/wkn2A2gGBbwTCzB/OxJe61yCaMj4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058418; c=relaxed/simple;
	bh=DIocBW8J/uihn7w+BY5Wubi8M4mVZ2pdF7qls88kIgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3I1b5d9TnCNOiC3aUtB6j3tycatf3TNd6n5cG9AwELbnS9O3kPzilc7E7ZO2tx1tKUnE4nTJ2Pr8czCAZU2IClJjS+zD5th9BV0nteYY+pJVzlZfhxVL/Hj8pKwFBdojuOVqBBUU4pZgs6EaAZeKAXgd3e3XcdF4xmwW+1iDuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=ZOiTnNNQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FAlGCjY2; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D689514004A7;
	Fri,  1 Aug 2025 10:26:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 01 Aug 2025 10:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1754058413; x=
	1754144813; bh=R6ICrf9reG6bP3hDhWBQpp+gqiYLloADWJKlviszYyM=; b=Z
	OiTnNNQCXcuBdzdg0udnHV5noX/BB2FjFyOQZEywVsqTeYywIsI5o8OnQFuJSvlp
	lKCrqqRtuyS51QvGB+T1yUfao+afEDvmCYSTst+K4GH+ISFRfrbn08H/4Q3g40A+
	TPBvUCGEMNAJXN8viBCkDuGUg0a/GD5fpjqrxzm7/NbxlzfoBT/jsHmGd9L9JsgP
	z6ocvQwh0qz/jw3pQl3o0d++D6xl+3tZxmBhCVRBHfvLyYx9SAYvWtWtBD565Fmr
	CFGcGlLFTgg+EmcTpW3V1oxfqm8mkr8xz0oT7E+8B9igN06AMF2DrBjSA8mPgmGT
	qgIurYtKCk7C6g1cGuRiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754058413; x=1754144813; bh=R
	6ICrf9reG6bP3hDhWBQpp+gqiYLloADWJKlviszYyM=; b=FAlGCjY2j7JJL8qb+
	aPUyj++bdnU/KzYb0JwOgqAxt08BgIQzWWB5ZChPAZpKOLOiFEiwyofuuIdACxQd
	mLaH339Ei4E/LsFrxRutnsu7WNK/J17bG7ilO/2GFIBWbbh3eUUDzOP8Q+Sn1Ptw
	SndgnDgj8UGPwgBHn7NvLfz2EuYQ6z+tWlKg/N1mwSt2ZZ0764eXEGklbPdHdJ/P
	YZqHnBtzTA0V2thCKx4AShEryFRgUqdLJjHocOAT/7DQo0YzVP5v9DbHgS3OTcGU
	kU/zOXlKB+2Dycvv5xbemtzUDljvZNW6bBAWxGn9rFGo+31vw/GhzZU/h8SR6n15
	i2yBA==
X-ME-Sender: <xms:rc6MaIgGmqE7dHejrQNnjqFJuWAjd__FFZ6u544k7AAjEqQQ3aEeTA>
    <xme:rc6MaIZu2zM0V1b0tyWvyJCsutaANv_uNZc5ZniI1f3asaX7EeS8NanEmFdrZpA_i
    S96eM1VLOP_S7BhGZA>
X-ME-Received: <xmr:rc6MaFp3EFAGvgE9knZSRk_OBg_3iA692KZTB_D1h9f0WqwRyLMldrKsoRjQbGwIAnkaS3QjAkG9NzbYiJb56MJXQw5URp-UkpItkYKG6n5PZEyQVYNf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhhkucfrvggrrhhsohhn
    uceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrth
    htvghrnhepfedtvdejfeelffevhffgjeejheduteetieeguefgkefhhfegjeduueethefg
    vdffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    hpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhpvggrrhhsohhnqdhlvghnoh
    hvohesshhquhgvsggsrdgtrgdprhgtphhtthhopehhrghnshhgsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvghlrd
    gtohhmpdhrtghpthhtohepkhgvrghntddtgeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:rc6MaFOJeeBYvuNjxP09dSTSrSZVd3mi043vWE-M4U8J7I4fvA-cEA>
    <xmx:rc6MaIp4U-bLx4hE1UOed_bnB6Vzsthn33P1yXZJp91EN4jiDbiv7Q>
    <xmx:rc6MaCcjwyIt-QA7cFRJMtNXifM_gS7oDjf2tO_CoYKv86qzl8EOpw>
    <xmx:rc6MaGRh7Koz7Py2lXSZSgyAs_8f1otC0vN4EOy6KT4iD4XpZL1wJg>
    <xmx:rc6MaBPVOiFqDEFZKA4jd-FJBYTROM38Al2qlAL2gbUK6-7jooYjn8uR>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 10:26:52 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	kean0048@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: think-lmi: Certificate support for ThinkCenter
Date: Fri,  1 Aug 2025 10:26:38 -0400
Message-ID: <20250801142648.3752293-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
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

Tested on M75q Gen 5

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Co-developed by: Kean Ren <kean0048@gmail.com>
---
 drivers/platform/x86/lenovo/think-lmi.c | 85 +++++++++++++++++++++----
 drivers/platform/x86/lenovo/think-lmi.h |  1 +
 2 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
index 0992b41b6221..08eac6c18688 100644
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
@@ -170,6 +177,14 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
  */
 #define LENOVO_CERT_THUMBPRINT_GUID "C59119ED-1C0D-4806-A8E9-59AA318176C4"
 
+char *cert_thumbprint_guid = LENOVO_CERT_THUMBPRINT_GUID;
+char *set_bios_setting_cert_guid = LENOVO_SET_BIOS_SETTING_CERT_GUID;
+char *save_bios_setting_cert_guid = LENOVO_SAVE_BIOS_SETTING_CERT_GUID;
+char *cert_to_password_guid = LENOVO_CERT_TO_PASSWORD_GUID;
+char *clear_bios_cert_guid = LENOVO_CLEAR_BIOS_CERT_GUID;
+char *update_bios_cert_guid = LENOVO_UPDATE_BIOS_CERT_GUID;
+char *set_bios_cert_guid = LENOVO_SET_BIOS_CERT_GUID;
+
 #define TLMI_POP_PWD  BIT(0) /* Supervisor */
 #define TLMI_PAP_PWD  BIT(1) /* Power-on */
 #define TLMI_HDD_PWD  BIT(2) /* HDD/NVME */
@@ -179,9 +194,20 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
 
 static const struct tlmi_err_codes tlmi_errs[] = {
 	{"Success", 0},
+	{"Set Certificate operation was successful.", 0},
 	{"Not Supported", -EOPNOTSUPP},
 	{"Invalid Parameter", -EINVAL},
 	{"Access Denied", -EACCES},
+	{"Set Certificate operation failed with status:Invalid Parameter.", -EINVAL},
+	{"Set Certificate operation failed with status:Invalid certificate type.", -EINVAL},
+	{"Set Certificate operation failed with status:Invalid password format.", -EINVAL},
+	{"Set Certificate operation failed with status:Password retry count exceeded.", -EACCES},
+	{"Set Certificate operation failed with status:Password Invalid.", -EACCES},
+	{"Set Certificate operation failed with status:Operation aborted.", -EBUSY},
+	{"Set Certificate operation failed with status:No free slots to write.", -ENOSPC},
+	{"Set Certificate operation failed with status:Certificate not found.", -EEXIST},
+	{"Set Certificate operation failed with status:Internal error.", -EFAULT},
+	{"Set Certificate operation failed with status:Certificate too large.", -EFBIG},
 	{"System Busy", -EBUSY},
 };
 
@@ -668,7 +694,10 @@ static ssize_t cert_thumbprint(char *buf, const char *arg, int count)
 	const union acpi_object *obj;
 	acpi_status status;
 
-	status = wmi_evaluate_method(LENOVO_CERT_THUMBPRINT_GUID, 0, 0, &input, &output);
+	if (!cert_thumbprint_guid)
+		return -EOPNOTSUPP;
+
+	status = wmi_evaluate_method(cert_thumbprint_guid, 0, 0, &input, &output);
 	if (ACPI_FAILURE(status)) {
 		kfree(output.pointer);
 		return -EIO;
@@ -751,7 +780,7 @@ static ssize_t cert_to_password_store(struct kobject *kobj,
 		kfree_sensitive(passwd);
 		return -ENOMEM;
 	}
-	ret = tlmi_simple_call(LENOVO_CERT_TO_PASSWORD_GUID, auth_str);
+	ret = tlmi_simple_call(cert_to_password_guid, auth_str);
 	kfree(auth_str);
 	kfree_sensitive(passwd);
 
@@ -797,7 +826,7 @@ static ssize_t certificate_store(struct kobject *kobj,
 		if (!auth_str)
 			return -ENOMEM;
 
-		ret = tlmi_simple_call(LENOVO_CLEAR_BIOS_CERT_GUID, auth_str);
+		ret = tlmi_simple_call(clear_bios_cert_guid, auth_str);
 		kfree(auth_str);
 
 		return ret ?: count;
@@ -834,7 +863,7 @@ static ssize_t certificate_store(struct kobject *kobj,
 			kfree(new_cert);
 			return -EACCES;
 		}
-		guid = LENOVO_UPDATE_BIOS_CERT_GUID;
+		guid = update_bios_cert_guid;
 		/* Format: 'Certificate,Signature' */
 		auth_str = cert_command(setting, new_cert, signature);
 	} else {
@@ -845,9 +874,17 @@ static ssize_t certificate_store(struct kobject *kobj,
 			kfree(new_cert);
 			return -EACCES;
 		}
-		guid = LENOVO_SET_BIOS_CERT_GUID;
-		/* Format: 'Certificate, password' */
-		auth_str = cert_command(setting, new_cert, setting->password);
+		guid = set_bios_cert_guid;
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
@@ -1071,13 +1108,13 @@ static ssize_t current_value_store(struct kobject *kobj,
 			goto out;
 		}
 
-		ret = tlmi_simple_call(LENOVO_SET_BIOS_SETTING_CERT_GUID, set_str);
+		ret = tlmi_simple_call(set_bios_setting_cert_guid, set_str);
 		if (ret)
 			goto out;
 		if (tlmi_priv.save_mode == TLMI_SAVE_BULK)
 			tlmi_priv.save_required = true;
 		else
-			ret = tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
+			ret = tlmi_simple_call(save_bios_setting_cert_guid,
 					       tlmi_priv.pwd_admin->save_signature);
 	} else if (tlmi_priv.opcode_support) {
 		/*
@@ -1282,7 +1319,7 @@ static ssize_t save_settings_store(struct kobject *kobj, struct kobj_attribute *
 				ret = -EINVAL;
 				goto out;
 			}
-			ret = tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
+			ret = tlmi_simple_call(save_bios_setting_cert_guid,
 					       tlmi_priv.pwd_admin->save_signature);
 			if (ret)
 				goto out;
@@ -1583,6 +1620,22 @@ static int tlmi_analyze(struct wmi_device *wdev)
 		wmi_has_guid(LENOVO_SAVE_BIOS_SETTING_CERT_GUID))
 		tlmi_priv.certificate_support = true;
 
+	/* ThinkCenter uses different GUIDs for certificate support */
+	if (wmi_has_guid(LENOVO_TC_SET_BIOS_CERT_GUID) &&
+	    wmi_has_guid(LENOVO_TC_SET_BIOS_SETTING_CERT_GUID) &&
+	    wmi_has_guid(LENOVO_TC_SAVE_BIOS_SETTING_CERT_GUID)) {
+		tlmi_priv.certificate_support = true;
+		tlmi_priv.thinkcenter_mode = true;
+		cert_thumbprint_guid = 0; /* Not supported */
+		set_bios_setting_cert_guid = LENOVO_TC_SET_BIOS_SETTING_CERT_GUID;
+		save_bios_setting_cert_guid = LENOVO_TC_SAVE_BIOS_SETTING_CERT_GUID;
+		cert_to_password_guid = LENOVO_TC_CERT_TO_PASSWORD_GUID;
+		clear_bios_cert_guid = LENOVO_TC_CLEAR_BIOS_CERT_GUID;
+		update_bios_cert_guid = LENOVO_TC_UPDATE_BIOS_CERT_GUID;
+		set_bios_cert_guid = LENOVO_TC_SET_BIOS_CERT_GUID;
+		pr_info("ThinkCenter modified support being used\n");
+	}
+
 	/*
 	 * Try to find the number of valid settings of this machine
 	 * and use it to create sysfs attributes.
@@ -1728,10 +1781,14 @@ static int tlmi_analyze(struct wmi_device *wdev)
 	}
 
 	if (tlmi_priv.certificate_support) {
-		tlmi_priv.pwd_admin->cert_installed =
-			tlmi_priv.pwdcfg.core.password_state & TLMI_CERT_SVC;
-		tlmi_priv.pwd_system->cert_installed =
-			tlmi_priv.pwdcfg.core.password_state & TLMI_CERT_SMC;
+		if (tlmi_priv.thinkcenter_mode) {
+			tlmi_priv.pwd_admin->cert_installed = tlmi_priv.pwdcfg.core.password_mode;
+		} else {
+			tlmi_priv.pwd_admin->cert_installed =
+				tlmi_priv.pwdcfg.core.password_state & TLMI_CERT_SVC;
+			tlmi_priv.pwd_system->cert_installed =
+				tlmi_priv.pwdcfg.core.password_state & TLMI_CERT_SMC;
+		}
 	}
 	return 0;
 
diff --git a/drivers/platform/x86/lenovo/think-lmi.h b/drivers/platform/x86/lenovo/think-lmi.h
index 9b014644d316..c805ee312539 100644
--- a/drivers/platform/x86/lenovo/think-lmi.h
+++ b/drivers/platform/x86/lenovo/think-lmi.h
@@ -109,6 +109,7 @@ struct think_lmi {
 	enum save_mode save_mode;
 	bool save_required;
 	bool reboot_required;
+	bool thinkcenter_mode;
 
 	struct tlmi_attr_setting *setting[TLMI_SETTINGS_COUNT];
 	struct device *class_dev;
-- 
2.43.0


