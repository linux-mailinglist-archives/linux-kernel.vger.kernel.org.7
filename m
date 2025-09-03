Return-Path: <linux-kernel+bounces-799181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D95CB42815
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBACC1BA3809
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DAD3218D6;
	Wed,  3 Sep 2025 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="lCJnXfS7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yv4dS1gN"
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB0D1F8BD6;
	Wed,  3 Sep 2025 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921111; cv=none; b=JeHUNWLycWfLHs7A35+9GvWa/KMElWCbM1XrZ0tNVxoi488K55tvLPKPECX0TC2JIikvMad5pIXY4yi0m7WBJOUP2iiZdDIigDYcAKPfCAU5NM9IchvXYZNz/HyMM1k95fgOoNF3e04E9i/ebvB8dl4SakGUztZcDdBQG0EC9eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921111; c=relaxed/simple;
	bh=EDRGbFQEdUCC+T1QqudPKMaG2O2dufiA02tTCWsPiHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQ9pTWCh24a/xeHM9czmqYX6WGGlZM7MvxquGnnvg5J/KrEbA/Dtrz5+gxpIOXvoEbQgY/io7nati7BbU3PLPC0R8LfL2FBexNYT1+Gd6Ik3B2o1CdKryc1bQCeGV429F74QXSdxV+E3UAJIQJzzpTVYAHg4w30R22JJ3ciyZkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=lCJnXfS7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yv4dS1gN; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B1CB87A0579;
	Wed,  3 Sep 2025 13:38:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 03 Sep 2025 13:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756921108;
	 x=1757007508; bh=MWaDOy5EsxzPjJKPR/HPfHeBKItwKUOjCav2nL8txcc=; b=
	lCJnXfS759ez162nC6+OIg37D5u15ZK6JgX0dJI8uJtuwSevxZn48QyWqT3PyIC/
	J+zQ67/j03JrHMHlvQpkq8V29gtk7JbCw/N/WhJwEnwCDz/CkAlJzKMNQKqVa7OS
	8fiog64J+PkaEffysqVwWkhnLYPVaWjch5qzqREFYQBCDH/dolXox5Q7jUYIJvJZ
	XOWu7+cTY6XCq/1Hx5HaURyulPOgCt1OWEGoOHPwlr7B74MsNafmcGTx/Mw93QKH
	1PGzDtdLohbje4Xu58bNMru10LlebpoTBzqwqcOnMYsN1QWmhFKEbs72DWmhuzKs
	uD2jmjRBlvRX3xyTqXIEEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756921108; x=
	1757007508; bh=MWaDOy5EsxzPjJKPR/HPfHeBKItwKUOjCav2nL8txcc=; b=Y
	v4dS1gNVgfNRIIU4kXzpah4TjEPSSeCxO06pJyVds1g0Y4jEp425CoJuR1bCCDrw
	5WprwxiymG3F05fTIri5O79DXm5BiuHpVYMGzbiUmho1IZ0FE2H+NUbJotDkYsr4
	9MTjEeE/PXHEuQr8weQGlXheDiabv6MVW9/D6qzFFKFkeh9ISHpQB/ZQQsv3ZOr8
	E/26JntSghCq7mXrITF9XBxbPFb9aAox4JujbWhvxDZjJfRMtyHP8fY3Y6XGsa+n
	9plBiVwa8XL1oqwSyXwQprLMfJqUkC37cFGAjQhZcnd1Kuwc9z38tAvF2Jhst0QL
	TKY4yYPHkq86FnZlG+hqQ==
X-ME-Sender: <xms:FH24aLT0TNUotRDvJ_8WdOs6W1y4vZf7LIbXVSslEYKIRKSrBntoqg>
    <xme:FH24aEJflrEN9d3YYUkRJrJLgZx-_dc-R85xBVLCfZ-Te8O15oA91i8xMtPbQh8d7
    6yFFsfzJ_48CCdV2O0>
X-ME-Received: <xmr:FH24aGbfQcJDU_rh6O1n6npWdrMZoz9uAeIw_GemAPWywQTrIEN_H40BGG24OwS4fA3Lh57w9VUvIXuQNJetxGS8vX00GQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforghrkhcurfgvrghrshhonhcu
    oehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtth
    gvrhhnpeffffefudeuueduueduhfefkeeiueeihfdukeeuffekfffhheeigfehveekhefh
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmph
    gvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmphgvrghrshhonhdqlhgvnhhovh
    hosehsqhhuvggssgdrtggrpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnheslhhi
    nhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhrghnshhgsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkvggrnhdttdegkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehplhgrthhfohhrmhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:FH24aG-eDTaRsAPt83ByY5Um4p5zGGIPQESXiCaYR4vLq36onfdJxA>
    <xmx:FH24aHadJx_MvjE9yn7Yw3L5YiQlE-l0qdVWs9PE1YjIelnWxoqXTw>
    <xmx:FH24aKPj0p9UybOUmNvCpn2a-8D-VffSFLW0U54_auLMO0B-Q_B3eg>
    <xmx:FH24aDC-4AuaWFEX7jFfAopIANqZ-1hx3LTB9zafmpGg8u2VChyrNQ>
    <xmx:FH24aNoFCXWh6kKdyFRm31bz1TWPZSvgYE_LvlQXQIZX4gzzL_Oo8MD5>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 13:38:27 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org,
	kean0048@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] platform/x86: think-lmi: Add certificate GUID structure
Date: Wed,  3 Sep 2025 13:38:12 -0400
Message-ID: <20250903173824.1472244-2-mpearson-lenovo@squebb.ca>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a certificate GUID structure to make it easier to add different
options for other platforms that need different GUIDs.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v2:
 - split patch up into series
Changes in v3:
 - add field details to thinkpad_cert_guid declare.
 - add missing comma
 - Move null thumbprint GUID check to later in series
Changes in v4:
 - Moved cert_guid into tlmi_priv
 - applied const where needed

 drivers/platform/x86/lenovo/think-lmi.c | 29 +++++++++++++++++--------
 drivers/platform/x86/lenovo/think-lmi.h | 13 +++++++++++
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
index 0992b41b6221..de287987f20c 100644
--- a/drivers/platform/x86/lenovo/think-lmi.c
+++ b/drivers/platform/x86/lenovo/think-lmi.c
@@ -177,6 +177,16 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
 #define TLMI_CERT_SVC BIT(7) /* Admin Certificate Based */
 #define TLMI_CERT_SMC BIT(8) /* System Certificate Based */
 
+static const struct tlmi_cert_guids thinkpad_cert_guid = {
+	.thumbprint = LENOVO_CERT_THUMBPRINT_GUID,
+	.set_bios_setting = LENOVO_SET_BIOS_SETTING_CERT_GUID,
+	.save_bios_setting = LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
+	.cert_to_password = LENOVO_CERT_TO_PASSWORD_GUID,
+	.clear_bios_cert = LENOVO_CLEAR_BIOS_CERT_GUID,
+	.update_bios_cert = LENOVO_UPDATE_BIOS_CERT_GUID,
+	.set_bios_cert = LENOVO_SET_BIOS_CERT_GUID,
+};
+
 static const struct tlmi_err_codes tlmi_errs[] = {
 	{"Success", 0},
 	{"Not Supported", -EOPNOTSUPP},
@@ -668,7 +678,7 @@ static ssize_t cert_thumbprint(char *buf, const char *arg, int count)
 	const union acpi_object *obj;
 	acpi_status status;
 
-	status = wmi_evaluate_method(LENOVO_CERT_THUMBPRINT_GUID, 0, 0, &input, &output);
+	status = wmi_evaluate_method(tlmi_priv.cert_guid->thumbprint, 0, 0, &input, &output);
 	if (ACPI_FAILURE(status)) {
 		kfree(output.pointer);
 		return -EIO;
@@ -751,7 +761,7 @@ static ssize_t cert_to_password_store(struct kobject *kobj,
 		kfree_sensitive(passwd);
 		return -ENOMEM;
 	}
-	ret = tlmi_simple_call(LENOVO_CERT_TO_PASSWORD_GUID, auth_str);
+	ret = tlmi_simple_call(tlmi_priv.cert_guid->cert_to_password, auth_str);
 	kfree(auth_str);
 	kfree_sensitive(passwd);
 
@@ -774,7 +784,7 @@ static ssize_t certificate_store(struct kobject *kobj,
 	char *auth_str, *new_cert;
 	const char *serial;
 	char *signature;
-	char *guid;
+	const char *guid;
 	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -797,7 +807,7 @@ static ssize_t certificate_store(struct kobject *kobj,
 		if (!auth_str)
 			return -ENOMEM;
 
-		ret = tlmi_simple_call(LENOVO_CLEAR_BIOS_CERT_GUID, auth_str);
+		ret = tlmi_simple_call(tlmi_priv.cert_guid->clear_bios_cert, auth_str);
 		kfree(auth_str);
 
 		return ret ?: count;
@@ -834,7 +844,7 @@ static ssize_t certificate_store(struct kobject *kobj,
 			kfree(new_cert);
 			return -EACCES;
 		}
-		guid = LENOVO_UPDATE_BIOS_CERT_GUID;
+		guid = tlmi_priv.cert_guid->update_bios_cert;
 		/* Format: 'Certificate,Signature' */
 		auth_str = cert_command(setting, new_cert, signature);
 	} else {
@@ -845,7 +855,7 @@ static ssize_t certificate_store(struct kobject *kobj,
 			kfree(new_cert);
 			return -EACCES;
 		}
-		guid = LENOVO_SET_BIOS_CERT_GUID;
+		guid = tlmi_priv.cert_guid->set_bios_cert;
 		/* Format: 'Certificate, password' */
 		auth_str = cert_command(setting, new_cert, setting->password);
 	}
@@ -1071,13 +1081,13 @@ static ssize_t current_value_store(struct kobject *kobj,
 			goto out;
 		}
 
-		ret = tlmi_simple_call(LENOVO_SET_BIOS_SETTING_CERT_GUID, set_str);
+		ret = tlmi_simple_call(tlmi_priv.cert_guid->set_bios_setting, set_str);
 		if (ret)
 			goto out;
 		if (tlmi_priv.save_mode == TLMI_SAVE_BULK)
 			tlmi_priv.save_required = true;
 		else
-			ret = tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
+			ret = tlmi_simple_call(tlmi_priv.cert_guid->save_bios_setting,
 					       tlmi_priv.pwd_admin->save_signature);
 	} else if (tlmi_priv.opcode_support) {
 		/*
@@ -1282,7 +1292,7 @@ static ssize_t save_settings_store(struct kobject *kobj, struct kobj_attribute *
 				ret = -EINVAL;
 				goto out;
 			}
-			ret = tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
+			ret = tlmi_simple_call(tlmi_priv.cert_guid->save_bios_setting,
 					       tlmi_priv.pwd_admin->save_signature);
 			if (ret)
 				goto out;
@@ -1728,6 +1738,7 @@ static int tlmi_analyze(struct wmi_device *wdev)
 	}
 
 	if (tlmi_priv.certificate_support) {
+		tlmi_priv.cert_guid = &thinkpad_cert_guid;
 		tlmi_priv.pwd_admin->cert_installed =
 			tlmi_priv.pwdcfg.core.password_state & TLMI_CERT_SVC;
 		tlmi_priv.pwd_system->cert_installed =
diff --git a/drivers/platform/x86/lenovo/think-lmi.h b/drivers/platform/x86/lenovo/think-lmi.h
index 9b014644d316..59aa03c3f846 100644
--- a/drivers/platform/x86/lenovo/think-lmi.h
+++ b/drivers/platform/x86/lenovo/think-lmi.h
@@ -41,6 +41,17 @@ enum save_mode {
 	TLMI_SAVE_SAVE,
 };
 
+/* GUIDs can differ between platforms */
+struct tlmi_cert_guids {
+	const char *thumbprint;
+	const char *set_bios_setting;
+	const char *save_bios_setting;
+	const char *cert_to_password;
+	const char *clear_bios_cert;
+	const char *update_bios_cert;
+	const char *set_bios_cert;
+};
+
 /* password configuration details */
 #define TLMI_PWDCFG_MODE_LEGACY    0
 #define TLMI_PWDCFG_MODE_PASSWORD  1
@@ -121,6 +132,8 @@ struct think_lmi {
 	struct tlmi_pwd_setting *pwd_system;
 	struct tlmi_pwd_setting *pwd_hdd;
 	struct tlmi_pwd_setting *pwd_nvme;
+
+	const struct tlmi_cert_guids *cert_guid;
 };
 
 #endif /* !_THINK_LMI_H_ */
-- 
2.43.0


