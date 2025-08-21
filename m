Return-Path: <linux-kernel+bounces-780651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E831DB30788
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08FF91D0398F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C26350D41;
	Thu, 21 Aug 2025 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X0xi3LVB"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21788350D6A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808735; cv=none; b=tBmg4MvfnTvZVfhbwVqZjfJyS48ZqkL7e9A2giSy7AiqHiCbr343T8YXMfdObqFvkJCRhe3tzJvF+XxT60SNqsLk95dLu24WZgK5hQZf7Sv+B4Z8ABReyMyHjUNvPyyU4d/JA53Jd/QQg8mGEUdtPpm3eSKb5Np4C067+PbXNVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808735; c=relaxed/simple;
	bh=URrbS0mhCGPrb5iOL+dksuK5Bk0MWghCBTahPe7XJNA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 Cc:Content-Type; b=q95dGWRpJltHnhHpPijbafN6kuWGfTWE4JH3RPdmVCZTz6LH7s4TfgcThi/s+DArx826Y6RVPCwZWprUAADR3LvzZfVBDykKdv9dTRS9hpDeUGT5IMLPYQx5xNCf8hupKjWz5n+f5Ih3lIbGqV/8fDCrk+Nn3k4T51LOnjtDxP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X0xi3LVB; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e54a1646aso1553871b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755808732; x=1756413532; darn=vger.kernel.org;
        h=cc:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QkUxKIa0vYfWkKpwLeZFYuxXCexRByDF76bQBSx3GGE=;
        b=X0xi3LVBHgCi7d4AJM/hBV3NJPx1oH55SVDGnKn8Vn3DUWC9SR5MFLkZvh0/JSqmLq
         Q0rzIHAl12yiVxoYwuJQYraTMnWFn53IwBKKHc29ScDfmE241NrhjlpDlruuVf+tkUFd
         e8Ft12jWAhQewEn13YMBMDCKQslx++Xbw2n+rndMRc3GSYbcDkof9pIDlX3Vb2wzT7fu
         S8MR0QvbZ0mZJ34pvCxRJFoHPcEls0MHUEC5PFCUlJFRnwCi0UZ3UbZgHbMjZdzKfB+E
         bru6QLvnyJwUAbzS1uibNi0sGzF5oqgJtfZ2AnDdbIZFe0I3RA8XuDXn5FMyFm0424T2
         loUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755808732; x=1756413532;
        h=cc:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QkUxKIa0vYfWkKpwLeZFYuxXCexRByDF76bQBSx3GGE=;
        b=HEFjJh4zRG7zPyDMRwhAVUEjwu0Ds/PO+cx7yx0coeXcmzX0F0knJueU9ra/ka/Uh9
         dneF3J2uZ3T/5DC4eggPl1qAqkIR4uiTGIXAJsTDc7d25h0apMWxtXNSZ4jv8xKik/bJ
         uEdG00nmse1e6W27Ph7yoObRmKKOCXiFMxKOcvZnw3mHS966QnKPa/G0x4M9/M6XChr4
         W1qYXfr+ZrvaL1Swvpam2ATyeO0qcdoG7nqvFcHvE4JVFrW14d6q2AHNZx7QPkqRWCY3
         ExwiI+hkXA2kQoQNiSwm3CKuM+sjyqTP3LVbrP1YCzNv4vTL0pPeC7T1ZttJxsCp/LPU
         1hBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnISXFuUSZBbA49l0/mIBkebnX55DQF2SHpFKaQIKESHgFf97S1XDtqxVubS5xdrVIyLvo7b1P+cruqZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze6wsUWtkh03F5869qJNaTKSv2nu+PjpBwxKn06cQQ5nVy8MTR
	l06MG152H1Or9a4BbDLMcuLL1W5wZwn/gfYj2jqiZS5drcQooGfvCp6j9M3WRY6qsCKKapyFY9S
	CPeIhWyKjLagfmokLGg==
X-Google-Smtp-Source: AGHT+IEFPL74X2S98UlLs2tN59YE701VAz/WyC8UrI2eug85TWop1h1/vHTNi9LvBIRVU5UKSUHKq3Gv6dWNzVc=
X-Received: from pfbkx15.prod.google.com ([2002:a05:6a00:6f0f:b0:767:efa:8329])
 (user=rdbabiera job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2da2:b0:76e:885a:c32e with SMTP id d2e1a72fcca58-7702fc663a5mr762489b3a.28.1755808732286;
 Thu, 21 Aug 2025 13:38:52 -0700 (PDT)
Date: Thu, 21 Aug 2025 20:38:34 +0000
In-Reply-To: <20250821203838.1721581-4-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821203838.1721581-4-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2947; i=rdbabiera@google.com;
 h=from:subject; bh=URrbS0mhCGPrb5iOL+dksuK5Bk0MWghCBTahPe7XJNA=;
 b=owGbwMvMwCVW0bfok0KS4TbG02pJDBnLm8/PUdvG+vjgm6ZD39nCtK40PD1621vk/7c8acuj3
 u8XHu8L7yhlYRDjYpAVU2TR9c8zuHEldcsczhpjmDmsTCBDGLg4BWAi3/MY/idrlbJMcJrv+uTK
 79zZ71+em+fzr3uV6oOeUpMrelq7PX8y/A9am7jxxI1J7RXt8TYr3bbpJ7obnFUW1n5xNUdHcs/ RhcwA
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821203838.1721581-5-rdbabiera@google.com>
Subject: [PATCH v1 1/2] usb: typec: class: add typec_get_data_role symbol
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
 drivers/usb/typec/class.c         | 13 +++++++++++++
 include/linux/usb/typec.h         |  1 +
 include/linux/usb/typec_altmode.h | 12 ++++++++++++
 3 files changed, 26 insertions(+)

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
index b3c0866ea70f..559cd6865ba1 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -172,6 +172,18 @@ typec_altmode_get_svdm_version(struct typec_altmode *altmode)
 	return typec_get_negotiated_svdm_version(typec_altmode2port(altmode));
 }
 
+/**
+ * typec_altmode_get_data_role - Get port data role. Alt Mode drivers should only
+ * issue Enter Mode through the port if they are the DFP.
+ *
+ * @altmode Handle to the alternate mode
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
2.51.0.261.g7ce5a0a67e-goog


