Return-Path: <linux-kernel+bounces-785242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA26EB34803
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D1917B835
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CB3302741;
	Mon, 25 Aug 2025 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="J9ukY072";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZTe+hN8Q"
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06CE2FF16B;
	Mon, 25 Aug 2025 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756140998; cv=none; b=h/BjpCpsN7Y1qTNJQ1X2TCvSe+Q+uOMn9FWaC2JdpoSlKPDpJspdbr2mGp+uj/NSdnPlPN4aCd+SpQYnVFKs9qHbiEYuGevLsBOqUuO+t4Tx85/y+G1f/Cg84OkWSyn/re7PCydfXCj+6j4IjNUBiYBREvmtKDGGT4eJQRzsde4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756140998; c=relaxed/simple;
	bh=0CKQ+HiIpcOjfGTKn9xemIjeWRCF7OV3Phw3v3rUDtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxy165W5AbwoqopR/PgRl+N9ebQFoiH+lC7fAfq9Z5HpaxD8IYcV4l13Syf+gWvpxo0fu30CxZFv421yoDde1GqbwJfJUNskDlYYJjZucd21m+8v2tYjm757+9MIwO/4/ua0FeQLmOSaO5M8magN+Xmz5Hah9n9kTlqJjx2iuwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=J9ukY072; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZTe+hN8Q; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A470C1D00130;
	Mon, 25 Aug 2025 12:56:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 25 Aug 2025 12:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756140995;
	 x=1756227395; bh=Z7BYEGbcNllw0Okwu42rG92hr8/EoIoLIMPmKkFKybo=; b=
	J9ukY072EfFoN/JgtgD7BHPFPnvEuIFS7nhzr90VyscXk/xAY/Syyc6JVH0KYyz0
	K0MzLltlGEKm23m7XTN2PM7VeTAsvCH/HA/e2tSpQfYJQydw70NE6vEfEM4BQ9+Y
	Fgoo0Dr7VlZvEaoOjEUNtK7TqIHM8phdKEAto5+8iSwM+ehjD8/BWqEVdriS+cPP
	s4WAxHo6cFrerKYjerfQcK5x4uA86R9Y+VLibgBdft3q5x0X13s2yyLG7Xd6bfly
	y46IOANdcbdK7ISGKIUPWm7jYflTkyeXTVC0WyiYgPwJ867Z0qS4mzj+koU3L1iz
	zHs2fXpIlpz217j8MRwznQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756140995; x=
	1756227395; bh=Z7BYEGbcNllw0Okwu42rG92hr8/EoIoLIMPmKkFKybo=; b=Z
	Te+hN8QcKacDpwBlEj9tATXNbkmWR9VpKYEp61/fgrV+JeJlxxL4s0UyTx5Q6JKF
	R+shEuWcjCpQg2W1XKZ6wqyCKNOhkoAljCIbKBeZn1n0/p7u2ANS+7UDgjNxqf21
	fsd+VKE8Gd3TLUfJbbGk5Q40U71CXLdX7yoJZDjD45KdtcXTMOszGbXnU1O1tAOJ
	ryoTECqRHAGtQFlUe9yYzypgM0JtMpVXENSdWqFQYTJm2UnzKdS/NmFV5egwm5TC
	N2F1fIrihDUeExgYANovQYqbR9rEd8T6xQ7xmv7MAFbBdgbQybW9o6hC06EjeVU+
	sAleG8h7yyabSmyQzhgfw==
X-ME-Sender: <xms:wpWsaDwDAW_FudPxu2RautRiM2obz4dKM0_vm4o5Y0Wx02IKPHeZPA>
    <xme:wpWsaCq_rj2Ku-_Oj3YvllMN_O5YTAtK2bxVSA3sjdLENjaDLb8VRrPW0r42x00di
    7Tt5qx1ksPKfkO7Fy0>
X-ME-Received: <xmr:wpWsaC4lreiCH5ciRSD6adcrpDLqdtw58TIiPQd30EKz2dO4ulOK-_F78fXdXApBdPabZVGRdh41g_A1twFvtGQXdV_ztg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforghrkhcurfgvrghrshho
    nhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtffrrg
    htthgvrhhnpeffffefudeuueduueduhfefkeeiueeihfdukeeuffekfffhheeigfehveek
    hefhhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhnsggprhgtphhtthho
    peeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmphgvrghrshhonhdqlhgvnh
    hovhhosehsqhhuvggssgdrtggrpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnhes
    lhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhrghnshhgsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehkvggrnhdttdegkeesghhmrghilhdrtghomhdprhgtphht
    thhopehplhgrthhfohhrmhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:wpWsaJcEzLa_tyiUqZW2uxar21Ka54edMDf3GnvIkHaK4AHtda8Rwg>
    <xmx:wpWsaH4M4dzTuaY3buzyC5YsF6GUix-IbBi7-oGkOllnoEmQGC_cfw>
    <xmx:wpWsaAta6EzuZAzR4nGtPLfVH2UT9GSMq2dzvQqGsbAMaqriHGUfjg>
    <xmx:wpWsaHiYRV5zGRPin8UFURBJq0OQUY_FkwbMAdiX38o3mKQ5OrNMSg>
    <xmx:w5WsaHcKrCfbV1wuYpLW_4FsM63-OaUDViAN7umfD8jMMLMBTcvcOmUk>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 12:56:34 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org,
	kean0048@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] platform/x86: think-lmi: Add certificate GUID structure
Date: Mon, 25 Aug 2025 12:03:36 -0400
Message-ID: <20250825160351.971852-2-mpearson-lenovo@squebb.ca>
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

 drivers/platform/x86/lenovo/think-lmi.c | 38 +++++++++++++++++++------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
index 0992b41b6221..a22d25f6d3c6 100644
--- a/drivers/platform/x86/lenovo/think-lmi.c
+++ b/drivers/platform/x86/lenovo/think-lmi.c
@@ -177,6 +177,28 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
 #define TLMI_CERT_SVC BIT(7) /* Admin Certificate Based */
 #define TLMI_CERT_SMC BIT(8) /* System Certificate Based */
 
+struct tlmi_cert_guids {
+	char *thumbprint;
+	char *set_bios_setting;
+	char *save_bios_setting;
+	char *cert_to_password;
+	char *clear_bios_cert;
+	char *update_bios_cert;
+	char *set_bios_cert;
+};
+
+static struct tlmi_cert_guids thinkpad_cert_guid = {
+	.thumbprint = LENOVO_CERT_THUMBPRINT_GUID,
+	.set_bios_setting = LENOVO_SET_BIOS_SETTING_CERT_GUID,
+	.save_bios_setting = LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
+	.cert_to_password = LENOVO_CERT_TO_PASSWORD_GUID,
+	.clear_bios_cert = LENOVO_CLEAR_BIOS_CERT_GUID,
+	.update_bios_cert = LENOVO_UPDATE_BIOS_CERT_GUID,
+	.set_bios_cert = LENOVO_SET_BIOS_CERT_GUID,
+};
+
+static struct tlmi_cert_guids *cert_guid = &thinkpad_cert_guid;
+
 static const struct tlmi_err_codes tlmi_errs[] = {
 	{"Success", 0},
 	{"Not Supported", -EOPNOTSUPP},
@@ -668,7 +690,7 @@ static ssize_t cert_thumbprint(char *buf, const char *arg, int count)
 	const union acpi_object *obj;
 	acpi_status status;
 
-	status = wmi_evaluate_method(LENOVO_CERT_THUMBPRINT_GUID, 0, 0, &input, &output);
+	status = wmi_evaluate_method(cert_guid->thumbprint, 0, 0, &input, &output);
 	if (ACPI_FAILURE(status)) {
 		kfree(output.pointer);
 		return -EIO;
@@ -751,7 +773,7 @@ static ssize_t cert_to_password_store(struct kobject *kobj,
 		kfree_sensitive(passwd);
 		return -ENOMEM;
 	}
-	ret = tlmi_simple_call(LENOVO_CERT_TO_PASSWORD_GUID, auth_str);
+	ret = tlmi_simple_call(cert_guid->cert_to_password, auth_str);
 	kfree(auth_str);
 	kfree_sensitive(passwd);
 
@@ -797,7 +819,7 @@ static ssize_t certificate_store(struct kobject *kobj,
 		if (!auth_str)
 			return -ENOMEM;
 
-		ret = tlmi_simple_call(LENOVO_CLEAR_BIOS_CERT_GUID, auth_str);
+		ret = tlmi_simple_call(cert_guid->clear_bios_cert, auth_str);
 		kfree(auth_str);
 
 		return ret ?: count;
@@ -834,7 +856,7 @@ static ssize_t certificate_store(struct kobject *kobj,
 			kfree(new_cert);
 			return -EACCES;
 		}
-		guid = LENOVO_UPDATE_BIOS_CERT_GUID;
+		guid = cert_guid->update_bios_cert;
 		/* Format: 'Certificate,Signature' */
 		auth_str = cert_command(setting, new_cert, signature);
 	} else {
@@ -845,7 +867,7 @@ static ssize_t certificate_store(struct kobject *kobj,
 			kfree(new_cert);
 			return -EACCES;
 		}
-		guid = LENOVO_SET_BIOS_CERT_GUID;
+		guid = cert_guid->set_bios_cert;
 		/* Format: 'Certificate, password' */
 		auth_str = cert_command(setting, new_cert, setting->password);
 	}
@@ -1071,13 +1093,13 @@ static ssize_t current_value_store(struct kobject *kobj,
 			goto out;
 		}
 
-		ret = tlmi_simple_call(LENOVO_SET_BIOS_SETTING_CERT_GUID, set_str);
+		ret = tlmi_simple_call(cert_guid->set_bios_setting, set_str);
 		if (ret)
 			goto out;
 		if (tlmi_priv.save_mode == TLMI_SAVE_BULK)
 			tlmi_priv.save_required = true;
 		else
-			ret = tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
+			ret = tlmi_simple_call(cert_guid->save_bios_setting,
 					       tlmi_priv.pwd_admin->save_signature);
 	} else if (tlmi_priv.opcode_support) {
 		/*
@@ -1282,7 +1304,7 @@ static ssize_t save_settings_store(struct kobject *kobj, struct kobj_attribute *
 				ret = -EINVAL;
 				goto out;
 			}
-			ret = tlmi_simple_call(LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
+			ret = tlmi_simple_call(cert_guid->save_bios_setting,
 					       tlmi_priv.pwd_admin->save_signature);
 			if (ret)
 				goto out;
-- 
2.43.0


