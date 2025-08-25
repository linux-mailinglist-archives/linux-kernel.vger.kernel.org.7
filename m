Return-Path: <linux-kernel+bounces-785029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A4EB344E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFECE1A84A54
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC36D30148E;
	Mon, 25 Aug 2025 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GcvgPcRE"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD59301037
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133895; cv=none; b=j7Bj0KC/9q8lijxuFKCuwuK1KMB1hwGvbPz3aNneYWUKwnx3nf4R8Lg+zmztVlNmY/pKBgdZNgY6pja9Dc+6uQkFzv1Est+M6kUkle4DvMYZ6FP91JMXdazdGrLBrmFsz6gMJpUXfw9G9UVxOADN1kfOj+5vLChfsLIaUwfGqXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133895; c=relaxed/simple;
	bh=0BGpDIvSRWnL+9XoMN9WOJgDbPiOu14Iony9ATZBpSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DN8LjdZ5+8C53Es7cuBMv1/eF0Oqfak/SQnBIn/hiNzLfvAMd6gtjmPaUrauN2VkRKCLhLvLMZPjXY4kPO1fkKx4KrkrIrdxybpoAe+p7i++So+ht0qOlyUREtV+2BLfkxpOFyk3onuwN/G2kppB/eXRHvC5QLEVcAkllAf2xDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GcvgPcRE; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7a0442bso739018566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756133892; x=1756738692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtPmPO5XNYkE7V8xoQ7flpHn7rik8pyLeIH7/5dO6qM=;
        b=GcvgPcRElz5dzOBuUxwmPvGTSfJ+77Sxe9H+5XF+T6pcK8k/BD4SdFck9LsS1f/QyI
         PIR9Rpn8KINW0aEKbKt1Ed0pX62i5tR+NDETkiR51fnblNS1LtlOAIqC86ftBcZ7Rn4o
         E7ESOge8DCsoo2PiQUW21rm1WoaGZCj7AXLzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133892; x=1756738692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtPmPO5XNYkE7V8xoQ7flpHn7rik8pyLeIH7/5dO6qM=;
        b=dx7G8GQ4s2ZHUR2rw3CUMGwWQLG5U7fPrlSBydoMw1PkHOb1iBgRz8C1BNvM4krzjp
         4VNY8TI7gAKZX794Q+3BQOknbsUa+vtXNNsbDu0BJ9qQgpc/pVl8dSES380OAgRIU4cZ
         O5pFcCGa6OkadmH6/NMQcsUsG+BlBXAvUScxnCUa6q+KnX8v0BY8fY8ZDCEy8WCKxIRg
         6rwwII+oz6rVPrtW+6p2mspTri4npcqkGGDdUgcUX0+N/e5UYm2PuJOjQrp5op31r1lX
         HNlNZ06G12Ro5cT/R+P6MsR3nKJYrTSKKQX6hwKdOV5BpjYz6T+jScCsUa0obGxRlqFB
         JlRw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ5rDetdjXJYjZey+lQqZexqbfvwmwqbCMTJrQm3sC2bjbJFtkcZFBlrzx+k8+Tk7/NTeENGnW0HXG83E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh2yJ1SGibI/YsBxHDhdbIOWmb0se3K5aF4N4bPCNePDRJ2P8G
	ADUSrm6WZUq2ChtXAXPxvrmjyRhkTAIqeSX00yDwQplxA7RbggYe1oanwZIdXacZzw==
X-Gm-Gg: ASbGnctLq+30vE3qyu/PqZXr1Zp0qR4UkE469Y7IZwU4+HymlPF3etsH/Ty6Z+SOkZP
	mktgYRdLM0SOyZSG82mICJyeoF3rwq8QmiaRZMy2zU9+5b4/G9sGCA4CY/x88zA3N1kW6pufLlR
	dI6s3Pa6/dFxOdqEnID/uCUfDKVp2518zbxHEx/2bovfO+OeBNnQJM/Rewaz3s/UIQx3SKAUDCb
	7mm2Gn4oxoat9yN+AatUGOBvrER6J6NIGogUDPtTeom/AJH7mmcKZGRmKKiG1G5HY1LSEvp3rml
	so23CcsLdZfIpeTOLe/KIIyPc/+U6KZjHB/aHrjVqVNijf4wOGYccKwqOnYAuB0rWRfFh1jF3nO
	KW/1nVNsGe/aOE6hn1clA3LXWaH0KnsIMgNqZ8WP2g7YCLDuAQtEn0kgti22IxfYE2yVsj9VFQw
	jOQ6JwFBikkoKG
X-Google-Smtp-Source: AGHT+IFHIKJNDrGoroZVVpWmctlQ9FpQ8lFadPfFf19Uh7Mtgvrs7j6pKi3bP2ml+nSy2qOMBnyr+A==
X-Received: by 2002:a17:907:6e92:b0:af9:5b3f:2dfc with SMTP id a640c23a62f3a-afe2965ac9fmr1000432766b.47.1756133892254;
        Mon, 25 Aug 2025 07:58:12 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (168.23.91.34.bc.googleusercontent.com. [34.91.23.168])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe8d03f981sm117294166b.60.2025.08.25.07.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:58:11 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: Guenter Roeck <groeck@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>
Subject: [PATCH v2 4/5] usb: typec: Implement alternate mode priority handling
Date: Mon, 25 Aug 2025 14:57:49 +0000
Message-ID: <20250825145750.58820-5-akuchynski@chromium.org>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
In-Reply-To: <20250825145750.58820-1-akuchynski@chromium.org>
References: <20250825145750.58820-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces APIs to manage the priority of USB Type-C alternate
modes. These APIs allow for setting and retrieving a priority number for
each mode. If a new priority value conflicts with an existing mode's
priority, the priorities of the conflicting mode and all subsequent modes
are automatically incremented to ensure uniqueness.

Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 drivers/usb/typec/Makefile         |  2 +-
 drivers/usb/typec/mode_selection.c | 38 ++++++++++++++++++++++++++++++
 drivers/usb/typec/mode_selection.h |  6 +++++
 include/linux/usb/typec_altmode.h  |  1 +
 4 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/typec/mode_selection.c
 create mode 100644 drivers/usb/typec/mode_selection.h

diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
index 7a368fea61bc..8a6a1c663eb6 100644
--- a/drivers/usb/typec/Makefile
+++ b/drivers/usb/typec/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TYPEC)		+= typec.o
-typec-y				:= class.o mux.o bus.o pd.o retimer.o
+typec-y				:= class.o mux.o bus.o pd.o retimer.o mode_selection.o
 typec-$(CONFIG_ACPI)		+= port-mapper.o
 obj-$(CONFIG_TYPEC)		+= altmodes/
 obj-$(CONFIG_TYPEC_TCPM)	+= tcpm/
diff --git a/drivers/usb/typec/mode_selection.c b/drivers/usb/typec/mode_selection.c
new file mode 100644
index 000000000000..2179bf25f5d4
--- /dev/null
+++ b/drivers/usb/typec/mode_selection.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2025 Google LLC.
+ */
+
+#include "mode_selection.h"
+#include "class.h"
+#include "bus.h"
+
+static int increment_duplicated_priority(struct device *dev, void *data)
+{
+	struct typec_altmode **alt_target = (struct typec_altmode **)data;
+
+	if (is_typec_altmode(dev)) {
+		struct typec_altmode *alt = to_typec_altmode(dev);
+
+		if (alt != *alt_target && alt->priority == (*alt_target)->priority) {
+			alt->priority++;
+			*alt_target = alt;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+void typec_mode_set_priority(struct typec_altmode *alt,
+		const unsigned int priority)
+{
+	struct typec_port *port = to_typec_port(alt->dev.parent);
+	int res = 1;
+
+	alt->priority = priority;
+
+	while (res)
+		res = device_for_each_child(&port->dev, &alt,
+				increment_duplicated_priority);
+}
diff --git a/drivers/usb/typec/mode_selection.h b/drivers/usb/typec/mode_selection.h
new file mode 100644
index 000000000000..cbf5a37e6404
--- /dev/null
+++ b/drivers/usb/typec/mode_selection.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/usb/typec_altmode.h>
+
+void typec_mode_set_priority(struct typec_altmode *alt,
+		const unsigned int priority);
diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index b3c0866ea70f..571c6e00b54f 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -28,6 +28,7 @@ struct typec_altmode {
 	int				mode;
 	u32				vdo;
 	unsigned int			active:1;
+	unsigned int			priority;
 
 	char				*desc;
 	const struct typec_altmode_ops	*ops;
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


