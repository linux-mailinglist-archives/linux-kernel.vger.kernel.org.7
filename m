Return-Path: <linux-kernel+bounces-785244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B66AB34807
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432E3179DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB86A1DBB2E;
	Mon, 25 Aug 2025 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="Uh/f4kvu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UMpZhBNH"
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC783019A8;
	Mon, 25 Aug 2025 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141002; cv=none; b=VrmunxjWq3RBarmaUgPPMyig0NFnofKKOtBYyUtSYxC/52lBOUfYxqt+gZN4Jiks0rB6YnSzkAg4ja+lSMJShCXT4fYWZmLuZZMNZAQEn4pRTpV1RkVTcpNIsZ5iE4cColDYwT9UqZ0ergVHThApIi2RJ2olBq8QZx9lJPMTQ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141002; c=relaxed/simple;
	bh=csONKK/FQ22B8822SB+J7b+lWr/PyJFXU3UP3/vt/EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l69ajIpaegUWi3OWCaCoPA8h9k8vrOWbAfRlFkAmHpm9RsfzIA+3L3V2LVeTUUOzrfoaXdfoktoV7nw73oUMYPUC4tnJYX16CfudwiaSRI++JV2pGXOEGBvdIiHWR2eI8ZjzPiWcceaShlL78+AgwUmEzJv4c7Ap4jvJ6ujmEzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=Uh/f4kvu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UMpZhBNH; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 08A3D1D00101;
	Mon, 25 Aug 2025 12:56:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 25 Aug 2025 12:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1756140996; x=
	1756227396; bh=+ING7G4074N6TjwHWPLjuucwVTnXBXlDdaH9Evb8ofA=; b=U
	h/f4kvuS/MdFIo+h9qtwMAeaIPo8wWF8UCp4LUQK56aFtGQZvUnhogFI9xAmBZOO
	8HLLJauPxz7SxVV7GP+UbcYFuM1LVyKbtOF9EwcVu/utK09p/FynaCQ0ttNAmxuO
	D/UukZ6FgPaBFjbVvoi57TZcxMEVBroGmPkRW6486DDRkvr5x2z2G5kX8Ao6Su5T
	xaMq3UeqdAXCU33O+iEwWyJk+RUoL0XSgFHkpYmoMnwMNUI/okVDeRt6KbqHT1+3
	mtL4i/VKLo6Bnrv3/zefNl8AIY+/0gtsgCiJMG4XK3gZOSpJfYwOgJz67DYDqJDs
	UeDqsHGuPwv8E4JHDexUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1756140996; x=1756227396; bh=+
	ING7G4074N6TjwHWPLjuucwVTnXBXlDdaH9Evb8ofA=; b=UMpZhBNHUmZ+WQPJ0
	G56Zi8JfgV3b3iXBZAY39nyjynk8MFVNv9pXlgXGmt0NeyMAppHayqra/SPj5Z2b
	yr1C5sP9iYZnak+StqlFYL9wAGylR3Bem0x0LqqDTWi2Y/pR3y+wNF9vGMgMfqa6
	9lo7+fnnqSwSTOwsEDgWYytmniwPqeAyrPIS5jehW2S8Ui8BAVQO/GQCwUEk2Dad
	YAOteMKijBmxdebXxa2iMT2ScdckYCT4CM+hj99NdH3cGdYrQwgraVxVIF0LtDoL
	jFRvutWXzYsONJBKZMilY/dW/nsz3Bf2LaBYltxxDhYs5KkvbawCXYq9hY+Yp3Qj
	jF1MQ==
X-ME-Sender: <xms:xJWsaFTV2xlRArvXb2lBGIFrbE3cUkxOA17A70GefDtaZdnKzGHLaA>
    <xme:xJWsaGLDuxObZe-cIfpbwPLq3D9hRs3LQFhcI0B-KQgkGqG6UOGnaze1wWtIrGQYb
    ZOlZFanwecmZjgTO1k>
X-ME-Received: <xmr:xJWsaAZBojFMryJzX98MQI0NVARjgp2lbbm7H_0LQjq8JEgGMl1nMZgV_gpT6mZunWnk3yJHtguTWFMXY3_jcpjqUNWHnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhhkucfrvggrrhhsohhn
    uceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrth
    htvghrnhepfedtvdejfeelffevhffgjeejheduteetieeguefgkefhhfegjeduueethefg
    vdffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    hpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhpvggrrhhsohhnqdhlvghnoh
    hvohesshhquhgvsggsrdgtrgdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehl
    ihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephhgrnhhsgheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhgvrghntddtgeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:xJWsaI_vTPmJHTZzgn2Hztta2Yu-BP-j5nPoYIqb-7i84lsfbkKfOQ>
    <xmx:xJWsaBbof63CmXx-SnfwHz7VLvI6f-k_ecy5nVbpSI8b6uX7FIHj1Q>
    <xmx:xJWsaMNp9hnVNPETAELW4uQXAxCOXvxm3hYXvHoxT2pJp8ws3uOcdg>
    <xmx:xJWsaNCZAV3jGee8Xl8C6TXg-bIk4d8h21beof8j_3e6m6Z35Ndw4w>
    <xmx:xJWsaHp052bSPUVKRefo-AIVBxzxAvgjJEJL3t9rmGdLNmjzBZRalBnt>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 12:56:35 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org,
	kean0048@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] platform/x86: think-lmi: Certificate support for ThinkCenter
Date: Mon, 25 Aug 2025 12:03:37 -0400
Message-ID: <20250825160351.971852-3-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825160351.971852-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20250825160351.971852-1-mpearson-lenovo@squebb.ca>
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

 drivers/platform/x86/lenovo/think-lmi.c | 54 ++++++++++++++++++++++---
 drivers/platform/x86/lenovo/think-lmi.h |  1 +
 2 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
index a22d25f6d3c6..3a1cec4625e5 100644
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
@@ -197,6 +204,16 @@ static struct tlmi_cert_guids thinkpad_cert_guid = {
 	.set_bios_cert = LENOVO_SET_BIOS_CERT_GUID,
 };
 
+static struct tlmi_cert_guids thinkcenter_cert_guid = {
+	.thumbprint = NULL,
+	.set_bios_setting = LENOVO_TC_SET_BIOS_SETTING_CERT_GUID,
+	.save_bios_setting = LENOVO_TC_SAVE_BIOS_SETTING_CERT_GUID,
+	.cert_to_password = LENOVO_TC_CERT_TO_PASSWORD_GUID,
+	.clear_bios_cert = LENOVO_TC_CLEAR_BIOS_CERT_GUID,
+	.update_bios_cert = LENOVO_TC_UPDATE_BIOS_CERT_GUID,
+	.set_bios_cert = LENOVO_TC_SET_BIOS_CERT_GUID,
+};
+
 static struct tlmi_cert_guids *cert_guid = &thinkpad_cert_guid;
 
 static const struct tlmi_err_codes tlmi_errs[] = {
@@ -690,6 +707,9 @@ static ssize_t cert_thumbprint(char *buf, const char *arg, int count)
 	const union acpi_object *obj;
 	acpi_status status;
 
+	if (!cert_guid->thumbprint)
+		return -EOPNOTSUPP;
+
 	status = wmi_evaluate_method(cert_guid->thumbprint, 0, 0, &input, &output);
 	if (ACPI_FAILURE(status)) {
 		kfree(output.pointer);
@@ -868,8 +888,16 @@ static ssize_t certificate_store(struct kobject *kobj,
 			return -EACCES;
 		}
 		guid = cert_guid->set_bios_cert;
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
@@ -1605,6 +1633,16 @@ static int tlmi_analyze(struct wmi_device *wdev)
 		wmi_has_guid(LENOVO_SAVE_BIOS_SETTING_CERT_GUID))
 		tlmi_priv.certificate_support = true;
 
+	/* ThinkCenter uses different GUIDs for certificate support */
+	if (wmi_has_guid(LENOVO_TC_SET_BIOS_CERT_GUID) &&
+	    wmi_has_guid(LENOVO_TC_SET_BIOS_SETTING_CERT_GUID) &&
+	    wmi_has_guid(LENOVO_TC_SAVE_BIOS_SETTING_CERT_GUID)) {
+		tlmi_priv.certificate_support = true;
+		tlmi_priv.thinkcenter_mode = true;
+		cert_guid = &thinkcenter_cert_guid;
+		pr_info("ThinkCenter modified support being used\n");
+	}
+
 	/*
 	 * Try to find the number of valid settings of this machine
 	 * and use it to create sysfs attributes.
@@ -1750,10 +1788,14 @@ static int tlmi_analyze(struct wmi_device *wdev)
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


