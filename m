Return-Path: <linux-kernel+bounces-828707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E77B95400
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280312E49C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9366C320A01;
	Tue, 23 Sep 2025 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmaCJJWK"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4A03191A6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619742; cv=none; b=syArebKi/hJcJQxaBFTpy/yxDMYrSZ55XIasJ5CrYgKfQm96yWTYIqER3QKxvxLkxVEFi+EkaxUYXgk8Qf7nKhagQS/XU18DmtKRYMckcvHT9nFiWWw0+OOdViCr0Z0+g/BtgLVnR0yr8zG6C4YlEiSHvWbYxJ3q98ZEjnK6Ec0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619742; c=relaxed/simple;
	bh=NBEQffd2H9uKpV++ZtU70NTiqjKCKVw4AAQiI8qHzlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bBW++3PMK51m8Qqp4NBNnQsbJjftT1CFGgnVl8VwSBjk9UtopR4oCNCNRMMa0j3GXh6ynZNWa3krPpIRAkGkWMBMjkqA1qbHHYJkR5fSZZKKQNOFr8J5WdPm8KXwziynEV1tXsWrHeA/GzQqMzglC0ELmubjQmn0AvJ1rbssAP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmaCJJWK; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso6129852f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758619739; x=1759224539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xbyITinY33OhIKJ5MBGUt4odwalHEaw3IqQgPt6HVIQ=;
        b=ZmaCJJWKfyfPNMshhyqKIxZU6tW/9Q5gaOCKLbnTnxl5inQ7tBFJNshsHUeBdeb+f1
         i+kwQWyo8cQphIhkeEWRNoyfSGczckqNdUcHcufyOQGOiOmsqVPVGHrethYMCbmTD7Rf
         sX/PyhLipS5Zld5DywQ/w7d4VGz165Z7/k4eHzucq8bM0LTPx5eWmMx1SE8C4cSE+94k
         nFNJlcwWh0VSESW2xcg2Ldz8PjdfrzUJV3xVXd3t/QcBlKAXSSTS8GvUFna8o24943C4
         vfz+1so0SxWBOAIHL4SSPEu/CETD3PVZ1HqNAPkCBs/SawJDd8F5k7XP483uzHwn5PKo
         LxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619739; x=1759224539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbyITinY33OhIKJ5MBGUt4odwalHEaw3IqQgPt6HVIQ=;
        b=xC5rVEPjQSpSP20zpTWy8IpboqHKmm9V7MIhoOjZitiExxfEfAgjSDKFyZboy6sH0/
         5BD7aHPltMLUE2vPlJzsSt5uyIdw8BRlU1jIverltii++bXznkjQNahFHdJQwK9Y9kEt
         uEK9p4jVspWA6pZDuirDDcedW45LTX7noMgVAqo19iCHdKeygdR0pGhXj2SHvXpoKiyM
         NrL2hNELNZ2jq08mB0+dDz0NxT+TlSHBa0em+IpKhgUHrhIMVzy17HKK9KuWETnvcVXp
         zdy+FkAhMcIWhImE0qgmuu6X3qGe0yV+0iGY88MkxLjH7/DHYQkq4AqgdL7zEmtFVs9v
         U9eQ==
X-Gm-Message-State: AOJu0YyEIv0Pk0XSjtN9F9hbZ1cZtSxzTKPp0gqq/9oapbwquc2rysMP
	CzC4JNkQ5i1Nas27PtI8V2lwmkMHAFj6ZiWhNQq2KfZm8i24OCH2IR3P
X-Gm-Gg: ASbGncu/cRmM364lJY3KLkRd8YwoNZDdUx4ZQHyi+6STgS+9tZB6N0zjshZvGMBUwHZ
	6jCHlzcNsQCx/MIVA+wxJdFI7Z+5Ja/2QuyI5MstC0wJ6rtdc8PmYsOp6Ekj/LHZIoB8xKTuXhc
	NMnPrTlkQIzZVWe7EuKpFc8gPue1OpAUPwmIhFhUBRiyUaQ+DJFHmeuu7jR9mya13y9ljkXdMuF
	6UYAa5/tcH7FfGCZJRZbOfWbR4b+NfNT0fJrEL+bph9JQLHdQKkOyird7CruXj72Y0d/27b2cGS
	RzahXDKSgLOOQxzG6rO1ihWBolGEv6Opq7wBGLLMxmPVDgobtHlijzstw0QQJtgs1zycOqxkpGq
	smBk80nZbxu6afuCTBt9kpXGUAAXyQlMzAGlyzERy7Uaitvs=
X-Google-Smtp-Source: AGHT+IF7z73d2VuvQnNwt++NqM3EoWvKvnBFDLgcn+C2wjtH1EryvG8YXOQEMCGihX4URtIuIPau1Q==
X-Received: by 2002:a05:6000:2f87:b0:3eb:7f7d:aefb with SMTP id ffacd0b85a97d-405ccbd73damr1680845f8f.53.1758619738435;
        Tue, 23 Sep 2025 02:28:58 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:a5d1:59f5:ca88:d11c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-461391232e7sm271956435e9.6.2025.09.23.02.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:28:57 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] serial: sh-sci: Add missing header guard
Date: Tue, 23 Sep 2025 10:28:46 +0100
Message-ID: <20250923092846.74517-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add header guard to sh-sci.h to prevent multiple inclusions of the
header file.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index 951681aba586..22f877e2a17e 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SH_SCI_H__
+#define __SH_SCI_H__
+
 #include <linux/bitops.h>
 #include <linux/serial_core.h>
 #include <linux/io.h>
@@ -176,3 +179,5 @@ enum {
 	(((port)->type == PORT_SCI) ? SCI_TDxE_CLEAR : SCIF_TDxE_CLEAR)
 #define SCxSR_BREAK_CLEAR(port) \
 	(((port)->type == PORT_SCI) ? SCI_BREAK_CLEAR : SCIF_BREAK_CLEAR)
+
+#endif /* __SH_SCI_H__ */
-- 
2.51.0


