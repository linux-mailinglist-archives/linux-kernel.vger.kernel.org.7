Return-Path: <linux-kernel+bounces-815484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B379B56722
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 08:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5C53BA71C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 06:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AF727AC4C;
	Sun, 14 Sep 2025 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+W4DQlK"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5A91D7984
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757833000; cv=none; b=ZzIqSk38zuUJTWN8Gei0MFtIhzLyVWFSh3s8+ixOCDyGIqEq+yUOw0MoQx4RR5yUipsG8lEzgVhTX58RFWeVKaY91FGfsyCSfm1CrkVtUPbBE+TRCKLFizVkjSMqpdTsCmifQC0vHRKdesVbmVdYFJh8/sqPRiVSnRqs4yMisDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757833000; c=relaxed/simple;
	bh=Q812AXx6dejqCWgirZNijQXyD/Rb4pPDTgkvtVVfJtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mTlIfV7/QsXJnDwW9HJNy2qgby3bdlQqXqtAJi8ODMP8MvTG8r8ocqp/D1WhtKN+f7l/O2mkdIvFbDIaL8Qbat7GXYx4t5OmdCsEwL47DJoyiNqMI5vZ6/BfrFxJ4cvMneX78G3NJNrOw3HNJt1NtzPVrdg0OpBKOXkprNQI244=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+W4DQlK; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7724df82cabso3324505b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 23:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757832998; x=1758437798; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j3j+6RFJp8fBl5UFi4n25Nhq071AJDVG4+e0E5+b4Qw=;
        b=U+W4DQlKYhCsMuDEhJw3Bj0AzjKY0PDui+fN5SISBCuL2fXCJXRHbF1AJgL4NtBqPN
         dmXD8WzYcbNozXJh7co8cC2f+wP7lZl91sj5xRuxjQ7RtoWxVb5HyKnh9+BaKfeAaNnC
         a6Vno9HpBYoxzq6rSuiXd7sj2GrZEGDBfBUWGRL1H2bB2OqUc5HPrDJniCflaY4ECd6w
         CxAX+cV+fvyNQlCT/cIFGMQATHZ29NMnxIDRN1LKEGbEhjgYb3w/RA+sIb+ndkjEcOMd
         v7QFc14esfwfdGKGrSgVknb5GWjhw2xQoZ4L2PBUpOGpZ0VU3bvkU0CnUTf7zJXa7xqo
         yeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757832998; x=1758437798;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3j+6RFJp8fBl5UFi4n25Nhq071AJDVG4+e0E5+b4Qw=;
        b=A9/2RPdC7fkyRg9rwuB3ixsWi2pq5kTHcMS7MFnquyzaladZPh6uYQ6rmf52tdp8Kt
         hKgxYu20q48MuAQFTdt2KoBR7TtCqq/ieP+cF8ii0b+AODDgyrunoS1oyz+DFvfymKE6
         0TwejgTMNPIc4JnnzA9EKEVDolEBANdNrfTDUiwL9Tmg5zTxCOjLUi/wTFLFgGrFwQMt
         X3nAaucY1xhcuZBn+9+HJ83Q5rJ3XHYCVC/UDZ8WSXPN1IO/CEGzZAdLtvFYGpXoCo4z
         MDTYLHPOjohMTM6P4rYWF0cdGoaaPEnPhpUgbQmK2bCwmW4gQQnoEt7y0CzJAy0mVVwu
         SFjw==
X-Forwarded-Encrypted: i=1; AJvYcCUiA5bdbAt0DcZmutSvr5bob1W6j9xShoV1L4Nc/8ukZvVVtsVkV+euLe3UVgVV/mNsbytcyocGTuWJuOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbsOchzDaGs+jlwW7XOUZhsSS3Eut0FFgxyftnzOHaU8n5uLuX
	nNgpZGyDLb9U16lE+ne82xjtmHFKya2Lt/7pcLU02L8W9rXeBW7bngmJ
X-Gm-Gg: ASbGncvoYrmcmaKP3cQk+q+K7E0VeLXNeLUPGK5FnvnFl+t6WGRCgxkdXRTdqruC+mc
	yqn8kRGnlkgt2W1g/gi+4BT11ViU4uN5MLfW0G+1EgAJuZzuhlLcW9U37GB4cHBIPS9UlanmA/N
	zgv8CbPCoHRwaYcSij14dSjMmZ1Fc8wouIYZynT+eL5KXBC5yNFFWHGLRbNZF8FtcKOHzoG6wMF
	aB5fVOQTlbD1HQ4mOPqmxhixjEiVXClEmzxw8bFoAamp7iTz8iqGLkN7/dx/ixh391+a2IUIePe
	ST0ivSl0DpcfG2IlszckhO05UrAsT3DAd+WcDtEbhO7lrHR09mZeFscFrLJ7thDnVaWmplcSxTy
	OQI4FFIsa1CUAeeB33zCFvktUQ0QDcrM=
X-Google-Smtp-Source: AGHT+IGznuor/LGxwCbRZQ1XmIF0s2BXLDSzFLDiBks6mLGDvb81hNwtxuW7F5JOgR4jeZyqmWNTwQ==
X-Received: by 2002:a05:6a00:3d51:b0:772:5513:ba3b with SMTP id d2e1a72fcca58-77612077d87mr9562392b3a.5.1757832998188;
        Sat, 13 Sep 2025 23:56:38 -0700 (PDT)
Received: from localhost ([159.117.70.219])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77607b18ec7sm10171435b3a.54.2025.09.13.23.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 23:56:37 -0700 (PDT)
From: Nai-Chen Cheng <bleach1827@gmail.com>
Date: Sun, 14 Sep 2025 14:56:18 +0800
Subject: [PATCH] Bluetooth: hci_bcm: use str_low_high() helper instead of
 ternary operator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-bluetooth-hci_bcm-string-choice-helper-v1-1-05e05bf0e21f@gmail.com>
X-B4-Tracking: v=1; b=H4sIABFnxmgC/x3N0QrCMAxA0V8ZeTbQFgfOXxGRNsYlMNuRdiKM/
 bvFx/Ny7w6VTbnCddjB+KNVS+7wpwFIYp4Z9dkNwYXRTf6Madm4ldIEhfSR6I21meYZSYoSo/C
 ysmGM7EaayF9SgB5bjV/6/Y9u9+P4AeoxQfJ4AAAA
X-Change-ID: 20250914-bluetooth-hci_bcm-string-choice-helper-aae05c9c18b2
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linux.dev, Nai-Chen Cheng <bleach1827@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757832995; l=1308;
 i=bleach1827@gmail.com; s=20250730; h=from:subject:message-id;
 bh=Q812AXx6dejqCWgirZNijQXyD/Rb4pPDTgkvtVVfJtc=;
 b=KFujJ9fybEPgVWX3e1HODwtSS+x2VXNY21xe436FpBVJyjq65+B8JpNBYc09NOVfTF6ClgkUd
 qkNZqgIwnraBHy710hekebvsj59+EQdtU/Ti6iez22l7o+TI9SHmg96
X-Developer-Key: i=bleach1827@gmail.com; a=ed25519;
 pk=jahFPRplw20Aaim8fIt8SxlFMqkHbJ+s8zYBGbtHH5g=

Replace the ternary operator: 'dev->irq_active_low ? "low" : "high"'
with the str_low_high() helper function. This enhances code readability
and maintains consistency.

Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>
---
 drivers/bluetooth/hci_bcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index f96617b85d8777972137ca146ab99a3d8da12584..65740b86c49c42b65a67cbd892daec2358a09394 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -26,6 +26,7 @@
 #include <linux/dmi.h>
 #include <linux/pm_runtime.h>
 #include <linux/serdev.h>
+#include <linux/string_choices.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -1213,7 +1214,7 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 	if (irq_polarity != -1) {
 		dev->irq_active_low = irq_polarity;
 		dev_warn(dev->dev, "Overwriting IRQ polarity to active %s by module-param\n",
-			 dev->irq_active_low ? "low" : "high");
+			 str_low_high(dev->irq_active_low));
 	}
 
 	return 0;

---
base-commit: f83a4f2a4d8c485922fba3018a64fc8f4cfd315f
change-id: 20250914-bluetooth-hci_bcm-string-choice-helper-aae05c9c18b2

Best regards,
-- 
Nai-Chen Cheng <bleach1827@gmail.com>


