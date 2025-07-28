Return-Path: <linux-kernel+bounces-747759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BD7B137C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7141217AA65
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C58255F22;
	Mon, 28 Jul 2025 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ixS/Y5wy"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8389A25394B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695700; cv=none; b=HDihTWoinMeDO5n1D/1x4NPlHG6L/EjFHIV93SXf5NC3fhWbGXbQwoP+iZaHFYwDMgK1vCZQLb+Xov8x2BDkqhdmqxOKahxAUYR6yNoE1ZJd2VF8W3PUUC89rSk7Uinvjt4V3tFa6hPJKdUr/pZ1uY8wpDec6ATzuDYYZ3AU+Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695700; c=relaxed/simple;
	bh=0eAyHeozc3XeOuREzv1zqLFg//fvGMiewtoyEMnV6T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlnAo+5f08pyVRdVYX0uce8nC7B+WLCEpL1OqwbIjoGVcgx1915iiQpwpY5b7MbCqdQRlZLcH2JctsODst/XrULSejtHY49kFesiHuZnkUMq8BuseaVQfLkcl5Mc5hqg9frWnT4/fHLQGvW0J/Q18qtZVaawA8b4gvAwB3yQ+CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ixS/Y5wy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234bfe37cccso34436695ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753695698; x=1754300498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pol1HodRL3DW8x2angsI8+qJ7xRrSxpu0Qm/FnDyR/A=;
        b=ixS/Y5wy5MPafT2q4IntsvPOR5HiPiL/AjWbLpsgklPjh8yxfom5T8lwmO2xEV0ehs
         z4JJIB8673JB98u4bZIAdbEboKUDVXsrgpMpQJdrV8P6xSosQDc9PpKK/v2W8GU7XuPn
         KbpEefWRFupM1VMeGkNsKO6btdogq6Q5VFdVa2t0QJB96/KTb1T3s/frXHLfBP8TCgla
         9Kt+eUHU+xRUTsWrjFxkbOeApw0l2DeKheuxlE3tRkQABbwkZ2gv4e90AwfW/03tZoi4
         AQ3DrvNFG11G+0NVXeK6wf7rnOnxVneI4/K0FGYe3CtACqtC8FS/S/q7AtoCEckzXipg
         9/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695698; x=1754300498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pol1HodRL3DW8x2angsI8+qJ7xRrSxpu0Qm/FnDyR/A=;
        b=MVIlANQh4Zk9ou89LE19sXsTepEyrlvIUXk/FfviC8XPF5bvawiv9ACv/vtZq/hjsJ
         0mXesPXiydHvhhvVw4wRyW0GdqF4eKBSpyzX5A2lbLrCRtrwJyRM4zJfKrO3bBKAckqT
         JXF1h6Pv9Nu94hdooyqCeq4RS6mPe9y31202TKlwhCc4T+yrS8+FCDnCQPUJF4dFEFHq
         9RGdl8fplf27PA2An+P8CeF3ErU8HucZpTD6KXdg7cIjfCQCGAhsjKSO6LjJoJv/JSty
         kj0iEVi0wNEHiJqsDI/tSMCBaRzdNeHLC/nzi4E8EZzb7kAepr43EJK9OT+yzOkEznSx
         RH0g==
X-Forwarded-Encrypted: i=1; AJvYcCUdZeDdBktSL65hsa4PB9blKs06X6jpshEjLrK69iqckyNx2OsWl+Dq5PIzsgPf29AKSoOrzYtS9n1z7J0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvoA8nWDiQTcEdBcouUxXzhM1x77eZSc5wxShZNcXFiObliheI
	bXYzxl/jM9mdPhBLMLhvL07UU9NpoYD8ZV/9nRA5Hih9i0WauSKs9fdbVAvMVc9fGYI=
X-Gm-Gg: ASbGncsaeNjKoPA/BtLa8sO3/Rf2rSgQ3Vb/9l1AE+fLAp46JDujmqiC60YNYVeEZVH
	h8dZTjrn2nHnaCjWwvL+V7JlNSwv4P3aJqZrlrrAE7o1yO1wc4oLfd/FWe33klLCMmyELjQvraN
	KZlOGM85S7cEOagpVQU0jGgWrcz7FhdfeurusrfCUl+Ad0Z2/pG/FtCpxD8hF6djLQCfrjEGSQz
	Fz432BipWEk/wgovadnctcBXsQNUmt1j9ylYSs1fY6nmm9q19+x40OafWxK63WVuX5qCm49fCYS
	XmKQNw2o20BKESO3cEc3tuM7haCSFYcJo7OEK4dl48C1I3WQMOgGQwJGIm6qJnRf/4nez1t4PP+
	pDYJfb5rNPWxMsK8qahaZyMZsy+5SsdrFZ+6p9dCK9Ogtyles53BHqVC7WmfJfl41E93neDI=
X-Google-Smtp-Source: AGHT+IGN8mb4tFnpETIIKc3/rN+/pLi5dTp9SQ2WL8XG+KUiU/d2OGBwjoGrUKgURmKHBJWOK248sg==
X-Received: by 2002:a17:902:cec4:b0:234:8a4a:adad with SMTP id d9443c01a7336-23fb30aae10mr134242795ad.26.1753695697525;
        Mon, 28 Jul 2025 02:41:37 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([122.171.19.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832fbf99sm5396230a91.1.2025.07.28.02.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:41:37 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v9 04/24] mailbox: Add common header for RPMI messages sent via mailbox
Date: Mon, 28 Jul 2025 15:10:12 +0530
Message-ID: <20250728094032.63545-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728094032.63545-1-apatel@ventanamicro.com>
References: <20250728094032.63545-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RPMI based mailbox controller drivers and mailbox clients need to
share defines related to RPMI messages over mailbox interface so add
a common header for this purpose.

Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
Co-developed-by: Rahul Pathak <rpathak@ventanamicro.com>
Signed-off-by: Rahul Pathak <rpathak@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 include/linux/mailbox/riscv-rpmi-message.h | 214 +++++++++++++++++++++
 1 file changed, 214 insertions(+)
 create mode 100644 include/linux/mailbox/riscv-rpmi-message.h

diff --git a/include/linux/mailbox/riscv-rpmi-message.h b/include/linux/mailbox/riscv-rpmi-message.h
new file mode 100644
index 000000000000..3f4c73529aa5
--- /dev/null
+++ b/include/linux/mailbox/riscv-rpmi-message.h
@@ -0,0 +1,214 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Ventana Micro Systems Inc. */
+
+#ifndef _LINUX_RISCV_RPMI_MESSAGE_H_
+#define _LINUX_RISCV_RPMI_MESSAGE_H_
+
+#include <linux/errno.h>
+#include <linux/mailbox_client.h>
+#include <linux/types.h>
+#include <linux/wordpart.h>
+
+/* RPMI version encode/decode macros */
+#define RPMI_VER_MAJOR(__ver)		upper_16_bits(__ver)
+#define RPMI_VER_MINOR(__ver)		lower_16_bits(__ver)
+#define RPMI_MKVER(__maj, __min)	make_u32_from_two_u16(__maj, __min)
+
+/* RPMI message header */
+struct rpmi_message_header {
+	__le16 servicegroup_id;
+	u8 service_id;
+	u8 flags;
+	__le16 datalen;
+	__le16 token;
+};
+
+/* RPMI message */
+struct rpmi_message {
+	struct rpmi_message_header header;
+	u8 data[];
+};
+
+/* RPMI notification event */
+struct rpmi_notification_event {
+	__le16 event_datalen;
+	u8 event_id;
+	u8 reserved;
+	u8 event_data[];
+};
+
+/* RPMI error codes */
+enum rpmi_error_codes {
+	RPMI_SUCCESS			= 0,
+	RPMI_ERR_FAILED			= -1,
+	RPMI_ERR_NOTSUPP		= -2,
+	RPMI_ERR_INVALID_PARAM		= -3,
+	RPMI_ERR_DENIED			= -4,
+	RPMI_ERR_INVALID_ADDR		= -5,
+	RPMI_ERR_ALREADY		= -6,
+	RPMI_ERR_EXTENSION		= -7,
+	RPMI_ERR_HW_FAULT		= -8,
+	RPMI_ERR_BUSY			= -9,
+	RPMI_ERR_INVALID_STATE		= -10,
+	RPMI_ERR_BAD_RANGE		= -11,
+	RPMI_ERR_TIMEOUT		= -12,
+	RPMI_ERR_IO			= -13,
+	RPMI_ERR_NO_DATA		= -14,
+	RPMI_ERR_RESERVED_START		= -15,
+	RPMI_ERR_RESERVED_END		= -127,
+	RPMI_ERR_VENDOR_START		= -128,
+};
+
+static inline int rpmi_to_linux_error(int rpmi_error)
+{
+	switch (rpmi_error) {
+	case RPMI_SUCCESS:
+		return 0;
+	case RPMI_ERR_INVALID_PARAM:
+	case RPMI_ERR_BAD_RANGE:
+	case RPMI_ERR_INVALID_STATE:
+		return -EINVAL;
+	case RPMI_ERR_DENIED:
+		return -EPERM;
+	case RPMI_ERR_INVALID_ADDR:
+	case RPMI_ERR_HW_FAULT:
+		return -EFAULT;
+	case RPMI_ERR_ALREADY:
+		return -EALREADY;
+	case RPMI_ERR_BUSY:
+		return -EBUSY;
+	case RPMI_ERR_TIMEOUT:
+		return -ETIMEDOUT;
+	case RPMI_ERR_IO:
+		return -ECOMM;
+	case RPMI_ERR_FAILED:
+	case RPMI_ERR_NOTSUPP:
+	case RPMI_ERR_NO_DATA:
+	case RPMI_ERR_EXTENSION:
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+/* RPMI Linux mailbox attribute IDs */
+enum rpmi_mbox_attribute_id {
+	RPMI_MBOX_ATTR_SPEC_VERSION,
+	RPMI_MBOX_ATTR_MAX_MSG_DATA_SIZE,
+	RPMI_MBOX_ATTR_SERVICEGROUP_ID,
+	RPMI_MBOX_ATTR_SERVICEGROUP_VERSION,
+	RPMI_MBOX_ATTR_IMPL_ID,
+	RPMI_MBOX_ATTR_IMPL_VERSION,
+	RPMI_MBOX_ATTR_MAX_ID
+};
+
+/* RPMI Linux mailbox message types */
+enum rpmi_mbox_message_type {
+	RPMI_MBOX_MSG_TYPE_GET_ATTRIBUTE,
+	RPMI_MBOX_MSG_TYPE_SET_ATTRIBUTE,
+	RPMI_MBOX_MSG_TYPE_SEND_WITH_RESPONSE,
+	RPMI_MBOX_MSG_TYPE_SEND_WITHOUT_RESPONSE,
+	RPMI_MBOX_MSG_TYPE_NOTIFICATION_EVENT,
+	RPMI_MBOX_MSG_MAX_TYPE
+};
+
+/* RPMI Linux mailbox message instance */
+struct rpmi_mbox_message {
+	enum rpmi_mbox_message_type type;
+	union {
+		struct {
+			enum rpmi_mbox_attribute_id id;
+			u32 value;
+		} attr;
+
+		struct {
+			u32 service_id;
+			void *request;
+			unsigned long request_len;
+			void *response;
+			unsigned long max_response_len;
+			unsigned long out_response_len;
+		} data;
+
+		struct {
+			u16 event_datalen;
+			u8 event_id;
+			u8 *event_data;
+		} notif;
+	};
+	int error;
+};
+
+/* RPMI Linux mailbox message helper routines */
+static inline void rpmi_mbox_init_get_attribute(struct rpmi_mbox_message *msg,
+						enum rpmi_mbox_attribute_id id)
+{
+	msg->type = RPMI_MBOX_MSG_TYPE_GET_ATTRIBUTE;
+	msg->attr.id = id;
+	msg->attr.value = 0;
+	msg->error = 0;
+}
+
+static inline void rpmi_mbox_init_set_attribute(struct rpmi_mbox_message *msg,
+						enum rpmi_mbox_attribute_id id,
+						u32 value)
+{
+	msg->type = RPMI_MBOX_MSG_TYPE_SET_ATTRIBUTE;
+	msg->attr.id = id;
+	msg->attr.value = value;
+	msg->error = 0;
+}
+
+static inline void rpmi_mbox_init_send_with_response(struct rpmi_mbox_message *msg,
+						     u32 service_id,
+						     void *request,
+						     unsigned long request_len,
+						     void *response,
+						     unsigned long max_response_len)
+{
+	msg->type = RPMI_MBOX_MSG_TYPE_SEND_WITH_RESPONSE;
+	msg->data.service_id = service_id;
+	msg->data.request = request;
+	msg->data.request_len = request_len;
+	msg->data.response = response;
+	msg->data.max_response_len = max_response_len;
+	msg->data.out_response_len = 0;
+	msg->error = 0;
+}
+
+static inline void rpmi_mbox_init_send_without_response(struct rpmi_mbox_message *msg,
+							u32 service_id,
+							void *request,
+							unsigned long request_len)
+{
+	msg->type = RPMI_MBOX_MSG_TYPE_SEND_WITHOUT_RESPONSE;
+	msg->data.service_id = service_id;
+	msg->data.request = request;
+	msg->data.request_len = request_len;
+	msg->data.response = NULL;
+	msg->data.max_response_len = 0;
+	msg->data.out_response_len = 0;
+	msg->error = 0;
+}
+
+static inline void *rpmi_mbox_get_msg_response(struct rpmi_mbox_message *msg)
+{
+	return msg ? msg->data.response : NULL;
+}
+
+static inline int rpmi_mbox_send_message(struct mbox_chan *chan,
+					 struct rpmi_mbox_message *msg)
+{
+	int ret;
+
+	/* Send message for the underlying mailbox channel */
+	ret = mbox_send_message(chan, msg);
+	if (ret < 0)
+		return ret;
+
+	/* Explicitly signal txdone for mailbox channel */
+	ret = msg->error;
+	mbox_client_txdone(chan, ret);
+	return ret;
+}
+
+#endif /* _LINUX_RISCV_RPMI_MESSAGE_H_ */
-- 
2.43.0


