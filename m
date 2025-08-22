Return-Path: <linux-kernel+bounces-782296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 073BAB31E62
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0AF5B655D6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0BD23D7D7;
	Fri, 22 Aug 2025 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="F/U8ol7e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jhagOTyE"
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7646D21ABA8;
	Fri, 22 Aug 2025 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876359; cv=none; b=REsMkFFgkoYMhh1m9QTUYhA3dLxmbelXbB5hPO99WYMdY1wMVUQHG6Y7i8rPgHVb464FNiVEtJRnLNT+AItEzzhjanT386yfzURgGNnGbBCX5asI/Q2s3VA81OkvtEfkpv4mtsFoXREbLqvbWIt713KbUYilBkOlwdyq48jFBNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876359; c=relaxed/simple;
	bh=j44W+aIoXAAx3RS/tFCac2WzsjbpWnN05kP062k2ltU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ffsbOiGOQPNIkxBupSGptTp2fkDFg71NnaLgPZnjOc8R04eN5CAiAldHlHZDnE70ikqC5AufEtPECRpzLdCFejRB+QiYIXsMYCubld7jH29wdTiIh+NJp+zqaxNaZBMgmuujsAKQY4QIjBEIF8cROObbjXoFPH6Egs8V4DVDBVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=F/U8ol7e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jhagOTyE; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 77AED1D000BE;
	Fri, 22 Aug 2025 11:25:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 22 Aug 2025 11:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1755876356;
	 x=1755962756; bh=ZR5uE8tX9eu0gc/UQqkv4MWrUQKLpU2DobAQM4kJuX8=; b=
	F/U8ol7eGWuR312MiviED0DN+5DQaq+xVP4UB0Ll0bNHzesQzAOFbIHDWOTF/H3X
	VkIrC4snHi5uyYkSaJ7YdYL1iIAd5xUZB1QX4Zg1gNH7aHilJjNqBkVNZ/uFBTOu
	rjB/AqcZykPam6Eh/euLvVClNQjZ1B0UkpEc9Lls3/PBrh9lIdmbtiqtNUO2HazN
	+DdCkPrVceh85HMHHrx48rQvNrghLZLS0+VQUjclvF6QjgcfsU7TGqz4z7jWHToW
	Mhjab/LUiv7SpdrsxaAiq3NG0WFBbUaLsSPqCr+tqRmixaZbiyaeGtHAICFrDjXE
	Eduf9TU7OVdhmogN/I5jxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755876356; x=
	1755962756; bh=ZR5uE8tX9eu0gc/UQqkv4MWrUQKLpU2DobAQM4kJuX8=; b=j
	hagOTyEShJsCNXjN8vLtmrH5wLKMIO8zWq6WKAARHjbhTmZVZSHpL2jd1TdrCttQ
	/B+KQJtxsJV/yuw9xT1f/DW53d0nxloxY3cpVo8DM51vuN5L4NN6xSDYEP5QQeRD
	sEnXPCm6OQqmUXbs3mhnPuJzeOitc6pEFUbESPe3UFqtP4uMUyYNJV8OtyGmfUB6
	ERL09oevcCb8tYVAB3XKqhI9clUdUAKi+Zy0gJZArKIELBUmn+9WlXpcP/RH7M9C
	sC1Ab/bqbxD4z1wclIbalQ0lWr2gvXhN5WMw7lQqgGghCKyKYys7N+nFLCLWSYRV
	kNsP+/Pg4a59RrCjLlyVg==
X-ME-Sender: <xms:BIyoaBPcF7tPqrUZnPl3MCQYyUIXy029KY9m2yBNdVRquR5nCQ1aRw>
    <xme:BIyoaLU8boJW1Hwor_80-gBPcpcSf8WrFLn2WofDfry643EALmEmBfdenSZ1AVWES
    alrX4xaSP_kebjAmMU>
X-ME-Received: <xmr:BIyoaF17JH-QO9SgJkKmvgQ-QeS4OX9AALwov5qbfpdKAC5l0KRY9Ts-7xZsbTgGnG5kUXH4qbmgzJktXM5jpf_3qqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieegudduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:BIyoaJrwXTRtnO5ne2pXSrKbAvErL-q7FaeWTTqcfiH90jgS-OTpCw>
    <xmx:BIyoaMU70ZoCqgixlUeRhy6GvJyzDnKEJBLTq2ueNm1vcM55mVyf2A>
    <xmx:BIyoaEZFGh53dZ2FxjvSqOxJFpBkRfPEd3lVnN6OTq9okZJGqoWuxg>
    <xmx:BIyoaJfCQU539x99yFhHozisgSOstptKQ4uBtE2ZY9omSmGVaaoT9w>
    <xmx:BIyoaImJ4ewh34lX3fLu6U0jpRuVpKHxmiDMRZZIBeH2yf57TwcUbRhM>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 11:25:55 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org,
	kean0048@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] platform/x86: think-lmi: Add certificate GUID structure
Date: Fri, 22 Aug 2025 11:25:41 -0400
Message-ID: <20250822152549.4077684-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
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
 drivers/platform/x86/lenovo/think-lmi.c | 41 ++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
index 0992b41b6221..88bae5b33c57 100644
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
+	LENOVO_CERT_THUMBPRINT_GUID,
+	LENOVO_SET_BIOS_SETTING_CERT_GUID,
+	LENOVO_SAVE_BIOS_SETTING_CERT_GUID,
+	LENOVO_CERT_TO_PASSWORD_GUID,
+	LENOVO_CLEAR_BIOS_CERT_GUID,
+	LENOVO_UPDATE_BIOS_CERT_GUID,
+	LENOVO_SET_BIOS_CERT_GUID
+};
+
+static struct tlmi_cert_guids *cert_guid = &thinkpad_cert_guid;
+
 static const struct tlmi_err_codes tlmi_errs[] = {
 	{"Success", 0},
 	{"Not Supported", -EOPNOTSUPP},
@@ -668,7 +690,10 @@ static ssize_t cert_thumbprint(char *buf, const char *arg, int count)
 	const union acpi_object *obj;
 	acpi_status status;
 
-	status = wmi_evaluate_method(LENOVO_CERT_THUMBPRINT_GUID, 0, 0, &input, &output);
+	if (!cert_guid->thumbprint)
+		return -EOPNOTSUPP;
+
+	status = wmi_evaluate_method(cert_guid->thumbprint, 0, 0, &input, &output);
 	if (ACPI_FAILURE(status)) {
 		kfree(output.pointer);
 		return -EIO;
@@ -751,7 +776,7 @@ static ssize_t cert_to_password_store(struct kobject *kobj,
 		kfree_sensitive(passwd);
 		return -ENOMEM;
 	}
-	ret = tlmi_simple_call(LENOVO_CERT_TO_PASSWORD_GUID, auth_str);
+	ret = tlmi_simple_call(cert_guid->cert_to_password, auth_str);
 	kfree(auth_str);
 	kfree_sensitive(passwd);
 
@@ -797,7 +822,7 @@ static ssize_t certificate_store(struct kobject *kobj,
 		if (!auth_str)
 			return -ENOMEM;
 
-		ret = tlmi_simple_call(LENOVO_CLEAR_BIOS_CERT_GUID, auth_str);
+		ret = tlmi_simple_call(cert_guid->clear_bios_cert, auth_str);
 		kfree(auth_str);
 
 		return ret ?: count;
@@ -834,7 +859,7 @@ static ssize_t certificate_store(struct kobject *kobj,
 			kfree(new_cert);
 			return -EACCES;
 		}
-		guid = LENOVO_UPDATE_BIOS_CERT_GUID;
+		guid = cert_guid->update_bios_cert;
 		/* Format: 'Certificate,Signature' */
 		auth_str = cert_command(setting, new_cert, signature);
 	} else {
@@ -845,7 +870,7 @@ static ssize_t certificate_store(struct kobject *kobj,
 			kfree(new_cert);
 			return -EACCES;
 		}
-		guid = LENOVO_SET_BIOS_CERT_GUID;
+		guid = cert_guid->set_bios_cert;
 		/* Format: 'Certificate, password' */
 		auth_str = cert_command(setting, new_cert, setting->password);
 	}
@@ -1071,13 +1096,13 @@ static ssize_t current_value_store(struct kobject *kobj,
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
@@ -1282,7 +1307,7 @@ static ssize_t save_settings_store(struct kobject *kobj, struct kobj_attribute *
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


