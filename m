Return-Path: <linux-kernel+bounces-835534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC04FBA766F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 20:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA4C1762A8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 18:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF7E25A2D1;
	Sun, 28 Sep 2025 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b698gJ5I"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC51223DFF
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759085784; cv=none; b=oksK0wrM1XEtE80kekHvB8DA1O9imje03m4b2RYxBh9yLirAdi9mpFoh3HndROV4WGIlPPTvhs43jd6qRXId+Et+7fmT3hGtdyd5Bd9wUAelACcp5qELJXtI1MWtCcQpRM9/F5ORzmNrhb2VcKAHFr4gcKao5z77EKXq36xQYS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759085784; c=relaxed/simple;
	bh=IIY+gMYsuba/+4OqTyDx5xayTLYKf0LOx4iot1O/PPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUtZifG5XWQal/gFdNz77paDRgemgud77t1zu2p7wMLlYw55m6sYqc1eG1qSor4jQKS+o4A+tcS7GxFs/ozme1oILBqVYie80lHcbeiFgaGPkFtTaFlZLTvYIaD6c5DJayZaqSwIrBotrr/HVfx5GVAtcMfAdZuuxFGRgGkJbiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b698gJ5I; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-86420079b01so176803985a.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 11:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759085782; x=1759690582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TGLyWOkC4KUmwBoD05Lz2YatWCzChawGrCPkfQ6WKFE=;
        b=b698gJ5IS30ELAY9ioADCMK2pnnEfO85a92ngmjDhYa0r2ZsyIptKrRT7b9tysfFtH
         5JBv7WzmBDxvxVxLhTtss6trERiGGSyKznzfD6mN+YnmZVWZzIcv9q8T/yecBdTgSjI+
         pzGk0CxuLCJQ5W3U0hBPn7RZTJhIVCwlQJXyrk0+CsyXE89Y0FFhS5nxC1UCd6snELbY
         m/ViQJP7fZfs7AldvtPTtmXz6GRFRjcOIpaoZ0qRYGGKA9vRGLWXp6Tvr7uyiohCAU76
         VA472dyw+7GucCK/xXY/OU3FEu4tK2RwMzRp12FFzMsJgGH78WL4C9T96TI14MYBrKht
         Cq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759085782; x=1759690582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGLyWOkC4KUmwBoD05Lz2YatWCzChawGrCPkfQ6WKFE=;
        b=HH1Xa5ItVZng1p0ED2L4ESz59ovjcjB1ZLxl50rcPBe8WiK7Ek+lBUyfO5F00fY0XZ
         yYkMYwiDqrUzOV1GDzdGMhtR6Zei/4cZltOaoksa6suxImVVKd5vUdzaccHpJ7V7IjDh
         SzZPVyMy6JDmr2qrwNFfb9KdiFAji/aGxw7Q0+QAOaVsPzCOzUnJ4svBQpj1VTkinQIO
         jlmheCo4xEsKFr1ty9PWLbuI2d2J748F5EkXyESj6oKDc99JP2xJk76ZM99G4HSTbdut
         VcYXGe9cx/LkiFMKggKIRHEoyWLR+HcYZ4XSdjwb16WzIqtSmE4s2cqaBJJ4RBptk7TM
         AXfw==
X-Forwarded-Encrypted: i=1; AJvYcCWWpNbnWfIdyFLe8mpGIZ2aNh+yUUVKB9GY1dyAFHTdtxy8BpiFUgVxrrhyTRdq2k6s4AuF5mbLEfFE4h4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9cM+npd7PMtmssvM+5ErHLP58MNrOZ6G+x3R8i9NnlkvZ0f82
	cWTc/2rN+vrX8gY9+IoBI0EdX4goSnOAt0oAhYycpPb1g5bE83UCVUh+
X-Gm-Gg: ASbGnctSsLWcbvPkQ9r5hHCtfUPrs0I9O8jtGULgciKDR0gLKvRm47YKSVmpfMpE6YU
	OO66+gGULGV7tCaxLPYci0DBAkgtzBRKe0wauA758ktoBg21gDQkpuWvky9g34GugHLlJ4nZt5j
	EywmD4WDKaoG98mXQkX04JiDJCsP+LQ5+H0a/rDtxsJDDmay5+FDgyYXavsTpTaC8WXaCZn6nEJ
	N4l38HoUIMMLq89zKZTY/Wd23s5Smv1wUmwPSlfUP9FWm3l57ZsmmLEGJ3WHTioUhFUD3Z0t9YJ
	+0OF7vOaBYLZreM2i55zdRpdCgNA3WiRpzP4ps8id5bLuNgWl5RvqUYQDN9bBa5kLbycKvlvGcU
	tEIW2EwBVDdo/Srhql4HgGbS90uO9sbdqF3WPsiNnM3r6BJcb54kjr9EdFH49OSHkvlmwQHi60D
	rGCF1Zx/kGXMoNIMOwGJ02v9VQ0MULinW4yEbL/RcSrTWd224HfQedMcfGlwIyhd5gVwt5UCo=
X-Google-Smtp-Source: AGHT+IGCienOOAXPOzXv0RjWDI8W0f9AevwWnxU/CqqiD/Gq8WdLhiXtiD5kKW8ENAGc5zFV0rlHkQ==
X-Received: by 2002:a05:620a:f07:b0:81a:a1a7:763 with SMTP id af79cd13be357-85ae156a7b4mr1812596985a.37.1759085781806;
        Sun, 28 Sep 2025 11:56:21 -0700 (PDT)
Received: from seungjin-HP-ENVY-Desktop-TE02-0xxx.dartmouth.edu ([129.170.197.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c306b5f64sm630686485a.32.2025.09.28.11.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 11:56:21 -0700 (PDT)
From: pip-izony <eeodqql09@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] USB: Fix descriptor count when handling invalid MBIM extended descriptor
Date: Sun, 28 Sep 2025 14:56:11 -0400
Message-ID: <20250928185611.764589-1-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

In cdc_parse_cdc_header(), the check for the USB_CDC_MBIM_EXTENDED_TYPE
descriptor was using 'break' upon detecting an invalid length.

This was incorrect because 'break' only exits the switch statement,
causing the code to fall through to cnt++, thus incorrectly
incrementing the count of parsed descriptors for a descriptor that was
actually invalid and being discarded.

This patch changes 'break' to 'goto next_desc;' to ensure that the
logic skips the counter increment and correctly proceeds to the next
descriptor in the buffer. This maintains an accurate count of only
the successfully parsed descriptors.

Fixes: e4c6fb7794982 ("usbnet: move the CDC parser into USB core")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 drivers/usb/core/message.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index d2b2787be409..6138468c67c4 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -2431,7 +2431,7 @@ int cdc_parse_cdc_header(struct usb_cdc_parsed_header *hdr,
 			break;
 		case USB_CDC_MBIM_EXTENDED_TYPE:
 			if (elength < sizeof(struct usb_cdc_mbim_extended_desc))
-				break;
+				goto next_desc;
 			hdr->usb_cdc_mbim_extended_desc =
 				(struct usb_cdc_mbim_extended_desc *)buffer;
 			break;
-- 
2.43.0


