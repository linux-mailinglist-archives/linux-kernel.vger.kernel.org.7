Return-Path: <linux-kernel+bounces-782297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E90BAB31E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61973188BFF1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED1E20298C;
	Fri, 22 Aug 2025 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="Yenpndzr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b+xxT02e"
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D893621254A;
	Fri, 22 Aug 2025 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876360; cv=none; b=ORw8A9qcD3hlmmBcBiShLW9SHpOQHDWmuYya3aZ4p0DktcV7tGY14Hoj/9mTeGC0lfJFMWIceaac7FIqlaBL4RDcd1+gdZxLvUH3Xm9XfwE4cuFL7/G7zxp97sGOWJQl177Mz+0VxtZfBVeNSG7eswr6dXPuamNC8Uz7XGQOcl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876360; c=relaxed/simple;
	bh=NL/W/utMPWninrmvm8DXq5yrvSIcf7Ed6Tynv2e9lSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPiR4m3oUysKm6hxgkohvZMDBXYO9xRCJ5Z/44yVJbRNsZ8H4vMzv05n34U3gdLJYiPYURepaU6oYdUWGiMJLVIS0DV07E/IP0G6XEbitkuoERhzuB6by2jQig0v3YmicPQGMiEsnM9t1kAGW8Jz6uuNYDN6zocFFGO/DC8uQtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=Yenpndzr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b+xxT02e; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 992977A0177;
	Fri, 22 Aug 2025 11:25:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 22 Aug 2025 11:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1755876357; x=
	1755962757; bh=grzAHivETRpGMXXqdSnkF8kQyC1Zp+WK/i2ZJytw0LA=; b=Y
	enpndzr0mNKQO05+ooPoIjk/lHvtoKcv3Dh2jB2CCyA1tqQe/olaKqKrXz7hBf22
	rkafT+zA8f/5Kb/8aNFuAFwaiGic/sKj8u4GMes/jwpgoB28Wbdm/s2i6p9MKKtS
	iqTBTpo8SzMab0Xx/zpBlFzayLg9cD9JKqC3MU/8n6HNzomenODVqbbuDYPJoQyl
	pUn7rRWGlLig6qzjA8PnQWFoEg/8gF1gsHTAU6q5KlqtvVcnjtszTwgEswTujAAO
	DnMS7iQtFA0NG/T+6CK2G/nSwyeB38cK2fX1ekqE3C/KWgul3b6+avGSYcDmHA8j
	hXebzr1aSeWX6x9U3YJ3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755876357; x=1755962757; bh=g
	rzAHivETRpGMXXqdSnkF8kQyC1Zp+WK/i2ZJytw0LA=; b=b+xxT02eixBh840iY
	bGHzS5S0qfzkxxOTDMZ+vcpJsx0VwuiNiZet8rzaoSW88O1rdEvcqIUotDWa66Ue
	Ij60I6wmVueKoRD8JOqn8poIRX90dvI2BE2IG7MAgScJecUrylpsD6F48FaFBZ0W
	ZuMBrUYRbE1sw3A0xr3ytx6cLGyTU0roKyZXygF6C5i672rLObiQYvPYgXpRPgFo
	KmVMjrecqxmDVqhQML5MTgC03gek1DuSyZ2pUY7MbJ77GHfQ3POuJOmAvOsWMwuX
	vByN4rvEA7T0h4CddqvyysY9gWYpwTmic7TGyTLEmngKUdjZ+TusJizQ8OZswn6r
	16A7A==
X-ME-Sender: <xms:BYyoaOwSy9e2dcGMdgruvYrgeDKISEBr4uYVB36DBgE56UxnEYGOWg>
    <xme:BYyoaBqND3w31F5VNzS8JlKVQ0cM_HE45Mle6pesMpVO6eDdXpTudS-639hjDW4Kh
    NF8MHtpufbEjGK-k5o>
X-ME-Received: <xmr:BYyoaF50Kmp4U_cRHa54B6L7G191ROfhNDFJQwcOqSjaM1DLTygoF-QZfwrR3_cvqIKO9D5PjZFZDykyrMoPytE2i34>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieegudduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:BYyoaAfciw4atyzbEzj7EEjMpRyFjDtXi6wcVwWuQgcPj7Lgenifqw>
    <xmx:BYyoaC5nXlANgtfZpQHJcdrf4nCkuWb-VUA51b3gZSLiYg-waDnABA>
    <xmx:BYyoaPsWAlNYeZzQT5L5w5SZWpFwjI8_JNjEwNt_6CJQcVzPFQS_Mg>
    <xmx:BYyoaKiqOmQhYsG2Epaixf4WTbzz1hdrrJUrVXPbB-tVfsrWSexK0w>
    <xmx:BYyoaJKCJAm1xhDhI7oNa49hutdOEXXtODr4IJg6vT0EXYGwQ6xNQA1J>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 11:25:56 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org,
	kean0048@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] platform/x86: think-lmi: Certificate support for ThinkCenter
Date: Fri, 22 Aug 2025 11:25:42 -0400
Message-ID: <20250822152549.4077684-2-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822152549.4077684-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20250822152549.4077684-1-mpearson-lenovo@squebb.ca>
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
 drivers/platform/x86/lenovo/think-lmi.c | 51 ++++++++++++++++++++++---
 drivers/platform/x86/lenovo/think-lmi.h |  1 +
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
index 88bae5b33c57..f7843f3a3325 100644
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
 	LENOVO_SET_BIOS_CERT_GUID
 };
 
+static struct tlmi_cert_guids thinkcenter_cert_guid = {
+	NULL,
+	LENOVO_TC_SET_BIOS_SETTING_CERT_GUID,
+	LENOVO_TC_SAVE_BIOS_SETTING_CERT_GUID,
+	LENOVO_TC_CERT_TO_PASSWORD_GUID,
+	LENOVO_TC_CLEAR_BIOS_CERT_GUID,
+	LENOVO_TC_UPDATE_BIOS_CERT_GUID,
+	LENOVO_TC_SET_BIOS_CERT_GUID
+};
+
 static struct tlmi_cert_guids *cert_guid = &thinkpad_cert_guid;
 
 static const struct tlmi_err_codes tlmi_errs[] = {
@@ -871,8 +888,16 @@ static ssize_t certificate_store(struct kobject *kobj,
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
@@ -1608,6 +1633,16 @@ static int tlmi_analyze(struct wmi_device *wdev)
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
@@ -1753,10 +1788,14 @@ static int tlmi_analyze(struct wmi_device *wdev)
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


