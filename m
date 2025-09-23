Return-Path: <linux-kernel+bounces-829485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA04B972DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7682F17F8B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BF430102A;
	Tue, 23 Sep 2025 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FEu2gaTL"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751D7301003
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758651394; cv=none; b=hECrNs7KLtPXGfIrfD2yr56xJU/2S7KpmESuWZcnWllWTvGyH4FjBThfjIgrhlBv5whBKRMxfNRGD16RZqT4eh5k49HMz6pSmH4td74frThlucBjnZMUTEi56DdkUTR2yTD+hgx03Hco+hM3AkzgKEgOMbNyj2r+DAA5yYVqK90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758651394; c=relaxed/simple;
	bh=JNwNjSurgcpPlXOhcGNj9bbi92aJUz2tEOoSfRoAXIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 Cc:Content-Type; b=PKiUwm8kGOYmcjlQPYfxn0WPcyK2SxBz5y426TerboG0At5E/Dg6U5nCwipQgzWVpubeEA/7SyNgOZJ8GD92QWZFjNvJIsezc1ik3ygtGqkLkzMgWfsPBot9xh1AcmJd9UF6k8MTAgolrPnqRuLWU2t7BRUt1Vj2WcjiK/erlRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FEu2gaTL; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso5128399b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758651392; x=1759256192; darn=vger.kernel.org;
        h=cc:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oa8Q2aTGVBenif3e/7v5uvSd5JKEyYerltvnq4kJmxY=;
        b=FEu2gaTLj/XL/aXE0Ds0V+gpMRnHXv0ICApijJCtilvm7k8JkYcFAYCu7ruiltWcSa
         c60dfHP7faBpxvvnF3Tzq0qfAZ8ZksSDZeG72SUpr+YEgOsuw9oI2iuHOStVbb0VYu9+
         yau9eJYLHUJ88PWu+7qgcug8ZqarVVpGu0YluXw4/iLdyLvZP39AFXA/Z7MhFgv56fie
         /7stIOSB4CjqBvyjAYL1RyBkK1gtcEKsvc2Q7jOHqTzHqhkDR5zLAFGpQoRaahx4WWmQ
         AHWXffwds2f2WhYk48yi+Iylq//J9eVVgLVv36pyk+GopxX0BDQWX6FQg0fqsHKS/5wq
         25NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758651392; x=1759256192;
        h=cc:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oa8Q2aTGVBenif3e/7v5uvSd5JKEyYerltvnq4kJmxY=;
        b=QA4e+KIsqape6Oqmhd3F3MdXeCrD1OQd4wT6TuJQa4CRTMGIHwlFk8rgrrzhY4xYq7
         nkbBf+YlQxarFFF1ijVL6GNottaS+0EnjJXd2TEjbZr75xetXtzQrjINlFgXmFkI6Rhv
         xyeDn9c/laQiOPPEZkWbgqxg2hnINNDrxR258hkYqRH9rg/AnpcgxjOarPE9K1gb5f2y
         0C2HRCuLZVF45NWgh+AbQJmKWLnTPLwPHVujRPTHdOonQtAoWKiwpHnEyia50Yve3Z+B
         J5zMrvTIu409oN2xH3P056w+cDGVYsxmKNLCcPWt7O5eGfFvBFsUReOhQ2tOnnzVktBK
         fqyw==
X-Forwarded-Encrypted: i=1; AJvYcCWYkHQLb0CA+IY9SnM1TWgiKtFGPz/Wts3/OsiDVK3InjCfdP4j6mxXw0Z5gYvuhHVz8EffKOXedFn8jW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4AqqNbf/2AnYM6MuXFn9cvZWBWckIlgNllhrtke7CNtCwb+47
	KrNgC/qvwY7cdyxnWyT6C26yX6tGl+Tiu7GcuGKivz5VuZWnzok2FBI2nuRSm+Yty+IRNhtTVCf
	NZUBdDzwQMiI1pgN2sA==
X-Google-Smtp-Source: AGHT+IErfx0Qc5k//IYvQhPfuUS7anf6kAjYPgNngerp5s5EW1cwtMxL8NXeCo7ZQVEnKyfdEz8rmWci++Aib+A=
X-Received: from pjiz15.prod.google.com ([2002:a17:90a:608f:b0:330:b9e9:7acc])
 (user=rdbabiera job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:72a7:b0:250:1407:50a4 with SMTP id adf61e73a8af0-2cfed265260mr5469277637.43.1758651391735;
 Tue, 23 Sep 2025 11:16:31 -0700 (PDT)
Date: Tue, 23 Sep 2025 18:16:07 +0000
In-Reply-To: <20250923181606.1583584-4-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923181606.1583584-4-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=0B74D21BCA57BD40083A73A0DB00FC8CD80B20A1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3036; i=rdbabiera@google.com;
 h=from:subject; bh=JNwNjSurgcpPlXOhcGNj9bbi92aJUz2tEOoSfRoAXIU=;
 b=owGbwMvMwCV2m+FPzw1uhYWMp9WSGDIuPX6ere7rPlsxXbBGX6dkTUtC2v3/2dwrdvS/Vdzpd
 vBe/6fZHaUsDGJcDLJiiizcJZekT4XvdeCwKl4AM4eVCWQIAxenAEzk0geGv9Ivb0a3HrN0XPrg
 2YNO9/liaRdfrpbjj4nPVix0WuPqIsDI8EVM7rG1rrn/74bJ83uWyM557WH0wCIoctHBPzx5EQc NuQE=
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923181606.1583584-5-rdbabiera@google.com>
Subject: [PATCH v2 1/2] usb: typec: class: add typec_get_data_role symbol
From: RD Babiera <rdbabiera@google.com>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	badhri@google.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	RD Babiera <rdbabiera@google.com>
Content-Type: text/plain; charset="UTF-8"

Alt Mode drivers are responsible for sending Enter Mode through the TCPM,
but only a DFP is allowed to send Enter Mode. typec_get_data_role gets
the port's data role, which can then be used in altmode drivers via
typec_altmode_get_data_role to know if Enter Mode should be sent.

Signed-off-by: RD Babiera <rdbabiera@google.com>
---
Changes from v1:
* changed typec_altmode_get_data_role documentation format
---
 drivers/usb/typec/class.c         | 13 +++++++++++++
 include/linux/usb/typec.h         |  1 +
 include/linux/usb/typec_altmode.h | 13 +++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 67a533e35150..9b2647cb199b 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2120,6 +2120,19 @@ void typec_set_data_role(struct typec_port *port, enum typec_data_role role)
 }
 EXPORT_SYMBOL_GPL(typec_set_data_role);
 
+/**
+ * typec_get_data_role - Get port data role
+ * @port: The USB Type-C Port to query
+ *
+ * This routine is used by the altmode drivers to determine if the port is the
+ * DFP before issuing Enter Mode
+ */
+enum typec_data_role typec_get_data_role(struct typec_port *port)
+{
+	return port->data_role;
+}
+EXPORT_SYMBOL_GPL(typec_get_data_role);
+
 /**
  * typec_set_pwr_role - Report power role change
  * @port: The USB Type-C Port where the role was changed
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 252af3f77039..309251572e2e 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -337,6 +337,7 @@ struct typec_plug *typec_register_plug(struct typec_cable *cable,
 void typec_unregister_plug(struct typec_plug *plug);
 
 void typec_set_data_role(struct typec_port *port, enum typec_data_role role);
+enum typec_data_role typec_get_data_role(struct typec_port *port);
 void typec_set_pwr_role(struct typec_port *port, enum typec_role role);
 void typec_set_vconn_role(struct typec_port *port, enum typec_role role);
 void typec_set_pwr_opmode(struct typec_port *port, enum typec_pwr_opmode mode);
diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index b3c0866ea70f..f7db3bd4c90e 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -172,6 +172,19 @@ typec_altmode_get_svdm_version(struct typec_altmode *altmode)
 	return typec_get_negotiated_svdm_version(typec_altmode2port(altmode));
 }
 
+/**
+ * typec_altmode_get_data_role - Get port data role
+ * @altmode: Handle to the alternate mode
+ *
+ * Alt Mode drivers should only issue Enter Mode through the port if they are
+ * the DFP.
+ */
+static inline enum typec_data_role
+typec_altmode_get_data_role(struct typec_altmode *altmode)
+{
+	return typec_get_data_role(typec_altmode2port(altmode));
+}
+
 /**
  * struct typec_altmode_driver - USB Type-C alternate mode device driver
  * @id_table: Null terminated array of SVIDs
-- 
2.51.0.534.gc79095c0ca-goog


