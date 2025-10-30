Return-Path: <linux-kernel+bounces-877557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F512C1E6A5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE9C189A913
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8324260587;
	Thu, 30 Oct 2025 05:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljlp6zzo"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED89B32D0CF
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761802133; cv=none; b=XxF8+YH/N7t/e4WQw9OM7x/7KP5ntff6mF5vXjXaevPEB9FaRuoCtEXriLoKxre9V7SjLeOhHmz3SDCvRaWhgB3Mhj6dhXyZoV6ktngH2QFiZwcNMhpi2IYGeSlJCDbPc8YN1K3J1CPrSXmYt8aHhUla2uDQOeeb8l2ejdlK9No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761802133; c=relaxed/simple;
	bh=f1kCG5TcAfbrPxtCZoUNFHaApQsksHuvWbM7GauKnp8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dQ9sJ/zRV4uv+7ZTKFn/QaFTX55KdY986S+7eTnS/OwmyFCrkE8pEyd44lnVRMDenb8J107gvyvvS6nHyj5YO6AJ6FdprH+Gur2cQ9fkjub0EIbZnAFxx8CwKsU95R06i13LT56WG+mKaWfbgqYZcgU7e1L5j085G3Ghnzuk60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljlp6zzo; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-78125ed4052so1035889b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761802131; x=1762406931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FSKUHSinYJjKvjZWn7Ylkm232SOv2kasPBkc5nSYgqk=;
        b=ljlp6zzo/P5KFGBvyInGtKCmUS98ZmUtLqjFpX929KKyy0jI409obG/VNv1gdyNDZ0
         YuMjN+x+aMQ33vgWtUPeR0zVStbYyQWyqC5E80af3T/UaiMjRSSuQHTTN3dowIiV6ryd
         wp81olkl+oQfAsQJLO9kvluxMmiY/5jzdjAd0XjWFfvaBRnYvFE3f2+9uvAplw9h1gkP
         shvA5NbFbT0BGaZfwL7eDNRiujLfJyAh6YpLsfOowLYCFnAN+JZo3tDhv01Zgtn0dSpw
         mRlrqAQl/uMRrS2txkL3YKVeqEZ+9vN0frU6dt5qsREk0XyqO65ZCuEfcne46p1TtWKF
         8TBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761802131; x=1762406931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FSKUHSinYJjKvjZWn7Ylkm232SOv2kasPBkc5nSYgqk=;
        b=v2c2fg62WgkOsPleM1B3D5m8X56NTyO0JqpnJwMSy1jHJicWY+GpEdVSQQIpA6TBtb
         pSXORnbugmCiuwaC7uqGaA94Lri2enlSUBP1cGYJtNRdgwi3iZ5cmyncawbMcDNZ2oMj
         WZPBP1BS3SRH/He3+wIkV6We8ZQV/vm8X++b/G4dF45qG7vrllW+PTbTMH++FPQAOWWx
         jyW43Li0He+IDMrN46GVbRpgU5Q2EU34h8EqaWpmMmRty8g/I6xkdBlQAXaux6zx4wZr
         3lpRgPXiP7sUS5bgVrm5Bu666xARt7LnaP587tjcfXvsLap8IzfCk2j+p5xJvcNzOQfy
         1YcA==
X-Forwarded-Encrypted: i=1; AJvYcCWu4UZB+WfdUYj6tbgSt5vn9j/tjXuug2cSWGXDh2L8xpZOguWwmpmpEizLIU3gUZD5fqm2fvzaY23+DdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPE25bf7wpK6Y55Hj0zW58tiPDDdyME/8pPIODc904+R7kcImz
	ocLrr73i/TKcmQAiu2qKpwouhrERf7A8ZbtTmcx0zvt+8AnGBK24hDd0
X-Gm-Gg: ASbGncsbjjRM92kfwRnXCw9GKPWvKYei2pdtf9/CXw0TJU9UtBRAC4FegrJUA6MNwlt
	/zIUA08qiAod9y51Nsd8Xe2OO7pqU1sH/K7c0weorfr+ABZDe5LDhrOWoArKZ0amF1glAi6cf1Y
	bSc6paBIwHGUQzBYsGgDy26cVOqa6qEKPrX8zoKjLhWqx0vZa5/bVQA+yR/FzI6T/PGc+EHYWg2
	CU5Ccwf+5d0VMF+IONMtNM+lS8D8VDAQzf0yelWc7jtO4Bcm1/BVRC+xKKDmYO7ZjvVJinc3ahv
	pxtCG52W/uiafvyysTHKvCYTicydfNueVuVc5zTe19awoIJDB2C7sjwMEJcy79FaysWhbt44W+a
	GpiKURLKKEwmmgzP/YZkgfQX0UrSJD4FYhuYvGlqqvk4woYvh2hOhpLEL29turrVTthC/9tZER5
	XyiZzPlFb9648IgFFKQEESKArMzf0Pz3Pt8BaCHJyQ1VY=
X-Google-Smtp-Source: AGHT+IHX4O7EKdx50iJVWLjggzkcWZLDrobpQhA0LDtO34kiExl+IAjGVhwdQR+ULIc3k6u6F/FiaA==
X-Received: by 2002:a05:6a00:244e:b0:781:19e1:c4c8 with SMTP id d2e1a72fcca58-7a62a940ab5mr1870941b3a.9.1761802131220;
        Wed, 29 Oct 2025 22:28:51 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a414066d0esm17479391b3a.43.2025.10.29.22.28.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Oct 2025 22:28:50 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] misc: eeprom/idt_89hpesx: prevent bad user input in idt_dbgfs_csr_write()
Date: Thu, 30 Oct 2025 13:28:30 +0800
Message-Id: <20251030052834.97991-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A malicious user could pass an arbitrarily bad value
to memdup_user_nul(), potentially causing kernel crash.

This follows the same pattern as commit ee76746387f6
("netdevsim: prevent bad user input in nsim_dev_health_break_write()")
and commit 7ef4c19d245f
("smackfs: restrict bytes count in smackfs write functions")

Found via static analysis and code review.

Fixes: 183238ffb886 ("misc: eeprom/idt_89hpesx: Switch to memdup_user_nul() helper")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/misc/eeprom/idt_89hpesx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index 60c42170d147..b2e771bfc6da 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -907,6 +907,9 @@ static ssize_t idt_dbgfs_csr_write(struct file *filep, const char __user *ubuf,
 	if (*offp)
 		return 0;
 
+	if (count == 0 || count > PAGE_SIZE)
+		return -EINVAL;
+
 	/* Copy data from User-space */
 	buf = memdup_user_nul(ubuf, count);
 	if (IS_ERR(buf))
-- 
2.39.5 (Apple Git-154)


