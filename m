Return-Path: <linux-kernel+bounces-735086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C9DB08ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029C0173BE6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E86E29A326;
	Thu, 17 Jul 2025 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvOC/64g"
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFBF28A700
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748458; cv=none; b=SPEg93gfL1LnVrzXQCcOxVIH1tMyJFFkm2hsEfngXNNdToaQZByvbpHBIaxtPt2BCI9qTUkOuGv+HN1WUPYJjxn51uQge98Y0avs9j4wSGa0lErDgKwy4yOxQFsyAcJ2CMODLLw9d7IuMMNwt3gYdG2fZsdsMUGDZV/wjKHMFMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748458; c=relaxed/simple;
	bh=DsMQWAS8PxXqK4a9JuCsra4GDSIVQEA8+K5Hj31kEQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIxeG/P7IlEGs0QXXS+AlfdF8eqNH+8KNgFOr2jLDKLCnLD1HRKOrcEkoWsrsR4owFWolR+ENL7MoWNCe+1DhcW7o4L6Sl1jeHemWPG30ztKuteVREP2KuafQJu7Nu8KWW9/ZOUpbtQ8/4m7qIueF8IEnm25zQtH8c4y7ook1mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvOC/64g; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-55511c3e203so769707e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 03:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752748455; x=1753353255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ObXSSq+fxnOlA4Osf6a7oPbXw+WxZOh3yT+SRdiIOyQ=;
        b=VvOC/64gcpU7WmEKhM4qx1OS3FDjHWydGeNXpvHq79DVeB+gdDNrXdy/o4TPQB7fBB
         799hJOD/cqF5mRa39G5wAC2Or8C7R/fcMr2RR1Gu9WFJQufo6k4/qjdwRoIhh4Gu6Oae
         Cz/FdiZ9OkMJbszfEBccC+TxuhZqzIZX4eLevnPmu2nl9yZnrU2U4brLb+w1B4SUBmbp
         U7tocsW88RJ5h75aQc26JSjWVJba6xvJCjoWiai5uBePN4hXimjFG1qpcGUdTkVms1FL
         MorKJqFW+jEFjhcUWFjAo3zPsVlie8RjGs3OKyvHZxmPOohoAAOuEJqNevGYEMs9Ybdv
         PAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752748455; x=1753353255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObXSSq+fxnOlA4Osf6a7oPbXw+WxZOh3yT+SRdiIOyQ=;
        b=XupaDy/7VjM9Dw/ovEofCm5ni7SVuhFTaSHmPU0+OAaYjAMLuCcJtBYA+q+V/cXPiw
         xoFBDVQqiwjHVL5HTjDOYkVZvNWIK7U851CSFK5UomMVN2L3TD2BwYRyI/paBsWnwBHp
         z1ATTJLw/J/sceJja2KcdoHzCFMnRUnxzVK07y/VI19Fyc1FuYCSle7Cnp5SZXx8mK8k
         v4ahouWZtL9DgG3z+RXWlrSNDiaoQ0jhR1WlzLBzJvTlDZA9TpAsi49WKnf8D9zwFvf6
         rwORWHHbERhYCcVQ82RCX3MBaWJrdA616jDQI0Q1kuw8jm+CkH/vPvgmsqp6OX3d7O80
         1uNw==
X-Forwarded-Encrypted: i=1; AJvYcCVI5l1ctVClYfnzNUt0AGGOVVIXZsiKRFJgiPjW0hz5pJSe63doG63FfMliigMFylR81b3Yu158+bnWcuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtd68mptYgXtemATDooUlk4GBaa1g1L0XhqOwICVCHZDCLipr5
	Z+fyr4S+Eg6IRzchcuJ+OA4q7ssShvQbt+6z6KtHgIwTLOCrDin6SdJzqScGADqg
X-Gm-Gg: ASbGncu8AwdZ530q9gNF5sB5Zlx9lyHkfse/eCxsxMZZRcVz2kXTa/82z/QwSNHod+X
	vIlv+4FxOz0KyC11di4SnjGKe1uPKHzdKb87rLzTZAz5HB69HaesRmzP+rbgW9ZfKfCCyUm9qo8
	irdGetOKTnG8D2DcBqKpFUkLidES0VpOeDxM1pZNezB+YfMPHwBJAsaVMdOeZ4q+OZ3I/M0YJK6
	HAk6J/0n/Ehei9z8k4TE4CRvAb0ggMPoGq7ECJAV1OIhIbKL9XTgvIxvqXXtBodcJQ2a0BvZsRz
	xjuA+YneAnD+DfHu1TN6fJMlOf1B7C2Jg+nrc04mZPuNbt4vAq9D1yIWRBUQtApJUu0HNTOa4Ii
	V0g3qKeHZqCdMAlv/
X-Google-Smtp-Source: AGHT+IEdnLqXJarrpv9Y4i9zizR/QRiBWY1pJLAao7BD8j/HcBs4GP4KogaSUwAB5C7uDP4yeSBRsg==
X-Received: by 2002:a05:6512:132a:b0:54f:c6b0:4b67 with SMTP id 2adb3069b0e04-55a23edc9c1mr2110934e87.4.1752748454314;
        Thu, 17 Jul 2025 03:34:14 -0700 (PDT)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d0674sm2995092e87.89.2025.07.17.03.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 03:34:13 -0700 (PDT)
From: Torben Nielsen <t8927095@gmail.com>
X-Google-Original-From: Torben Nielsen <torben.nielsen@prevas.dk>
To: bartosz.golaszewski@linaro.org,
	linux@roeck-us.net,
	linux-kernel@vger.kernel.org
Cc: Torben Nielsen <torben.nielsen@prevas.dk>
Subject: [PATCH 1/1] hwmon:pmbus:ucd9000: Fix error in ucd9000_gpio_set
Date: Thu, 17 Jul 2025 12:33:53 +0200
Message-ID: <20250717103352.4127774-2-torben.nielsen@prevas.dk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPIO output functionality does not work as intended.

The ucd9000_gpio_set function should set UCD9000_GPIO_CONFIG_OUT_VALUE
(bit 2) in order to change the output value of the selected GPIO.
Instead UCD9000_GPIO_CONFIG_STATUS (bit 3) is set, but this is a
read-only value. This patch fixes the mistake and provides the intended
functionality of the GPIOs.

See UCD90xxx Sequencer and System Health Controller PMBus Command SLVU352C
section 10.43 for reference:

https://e2e.ti.com/cfs-file/__key/communityserver-discussions-components-files/184/slvu352c_5B00_1_5D00_.pdf

Signed-off-by: Torben Nielsen <torben.nielsen@prevas.dk>
---
 drivers/hwmon/pmbus/ucd9000.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
index 2bc8cccb01fd..52d4000902d5 100644
--- a/drivers/hwmon/pmbus/ucd9000.c
+++ b/drivers/hwmon/pmbus/ucd9000.c
@@ -226,15 +226,15 @@ static int ucd9000_gpio_set(struct gpio_chip *gc, unsigned int offset,
 	}
 
 	if (value) {
-		if (ret & UCD9000_GPIO_CONFIG_STATUS)
+		if (ret & UCD9000_GPIO_CONFIG_OUT_VALUE)
 			return 0;
 
-		ret |= UCD9000_GPIO_CONFIG_STATUS;
+		ret |= UCD9000_GPIO_CONFIG_OUT_VALUE;
 	} else {
-		if (!(ret & UCD9000_GPIO_CONFIG_STATUS))
+		if (!(ret & UCD9000_GPIO_CONFIG_OUT_VALUE))
 			return 0;
 
-		ret &= ~UCD9000_GPIO_CONFIG_STATUS;
+		ret &= ~UCD9000_GPIO_CONFIG_OUT_VALUE;
 	}
 
 	ret |= UCD9000_GPIO_CONFIG_ENABLE;
-- 
2.43.0


