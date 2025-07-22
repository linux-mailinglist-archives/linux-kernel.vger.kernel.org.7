Return-Path: <linux-kernel+bounces-740410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C427BB0D3D6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E589C188DFC5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8CC2E1724;
	Tue, 22 Jul 2025 07:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciPs37y8"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89724298242
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753170091; cv=none; b=ZYaRJUT1WtdFhxoq+0kU1xNxnM0YH2zKjNgXLV6Nbt4Pl2XHrFICz6oiZq7+B4DexYkesjrXjnMkCUO8IFw5ySzsi+WxnffxGOu2GdDWoUvMIZwIcJitWA+Lu8PDLvR16N6X+/OOY6Q98/8covWTSsvyKUKKtb9apEtlhgSM6DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753170091; c=relaxed/simple;
	bh=EpT+yU0X7Un7J0hwX8aoJ3Y2Y6ydxawfRWvDqxA+f8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prBxipnoBtFc9+jZNqH54/J9pbhuKsNoZBQtaELwMS4mSnwq6bQXUx6g72B4StASyUSVgbRpQDru3DJlvh+CO6R/TsbeplUNSLZbowzbNgqAIdA2qdPRsbPov9Y6JxxxgFNy2ZNBg7XVlEtPnhttnz+4Dk+n/3gk0DcjhtAEE8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciPs37y8; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0de1c378fso769932666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753170087; x=1753774887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=251cVjb0zmvivJ92aefaYEnL7t74uE93HyIsOFkj1Bk=;
        b=ciPs37y811tI2rCWZfDXaP43NtThdmqwz2PdPmASBm25avx6wtjrzlUf8l11zNVw2y
         72jFQ8/qGiz6JAayVH6cPXHlP6EOoErcHqiX5QL/sgLpDysSe5QV8bjt+3f9zfffcb3g
         ipVm4T7Jh20KHyDsFqXo74TtfkS6jTNQzuD9CsYr1q40NLvx9kMEJvZIB7Gr7ciSE2+8
         00LSQYhJxgMPb+avYh7tkzi4gQVTEdQSos1anTFXqDkxOSmbKrGXBSMdNCTtdDVxXPN5
         fUcSzryXi8HmB0tluPcqpthCO+H+y96fsii1Xpc5thBiTQnTKzi3BGBu6k8/FFphYwWW
         MCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753170087; x=1753774887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=251cVjb0zmvivJ92aefaYEnL7t74uE93HyIsOFkj1Bk=;
        b=KnaNljkvNPC9JdlSI5ECMKLmbk1qkMmrav2tT6rQsFVubIGt5Fy5QSO7sXoXbHxWgs
         GX+VW6trM1WtKzAHwApKF18wYURcp9iNt6dZM+1AXiyj+aKCgZJMxQfQQxEBb9NDfCm4
         quiYbQvys0BF21rALgqAQYnA/lsUu3OAJ7O/jVjYLACdt4OO8hhZy0TVN/i+07epdjsl
         gPyk5DtIo3BspwBKvbil3UqXi1WvVQGCB6bx8XDdTaJSi3apCvne/46TxI2k+jcx5HSj
         ngGlzH9WFOyP7yzygoAca+/P1T5XTm898Pnr+9VFYF3zIJYw1pTbLN5NPN1QvMtzB++M
         ovDA==
X-Forwarded-Encrypted: i=1; AJvYcCXtQMl/bVawno+liwZioKp7DZEALiDAdXf+pukCv5RuQnBX+re1F0ak/ilN263x1j8FdLxHMzl3GrvpV3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoUZzx0Z1CieameyYRcsnZKlTW2Szeob4nJReJTBTq9uCmeop/
	XhJ2QCVZG5emRT4purQjWvkOkhrq8nJoKnvbPry9U4AYXrQkalyfdd/7ym/Ahg==
X-Gm-Gg: ASbGncsj6vNolOIJjTVdVerqPWJVavVjkJXqO0Gm/0tZUojfzqUBGig2NwLYoA6HNdO
	Nm6R0BSKcvihDu/TNdDMeB9tbWvOVCi1y+lAJEhlMe0T9RH9+EOcPRvTQgKGoybwUfKvTb7GpWn
	MC0CXucwSTATlTSDIH7ujQ/cGhwIxSC8oA8DU2dd/nCCNwl0kNVGyJqXp3f5B+Ac468d9MYrdGG
	nThkoKz2avVA1Vc2Xha3DvyMyFiuQM7/RdEqjmjC4YssN54M9gRXRG0s1ZyJIKUZ584X76yCFrf
	WflCSzLp4LOl4McQHL5my/5yTU0hfRWOFQMyQ7cCD+7pbesxwVgQNcH6NGD7a6xO4Opdc8YAGND
	4Em2vVu7cFInqheyb/FKLyXM=
X-Google-Smtp-Source: AGHT+IGHzurZHbgcRHkHjOYhhPlJ1/IqhDTnA+ua4GEZLIxVcnjr7CmelJgBtJ/VsaI+uHJSvCfLPQ==
X-Received: by 2002:a17:907:d596:b0:ae3:5e70:332b with SMTP id a640c23a62f3a-ae9ce198c16mr2000680566b.52.1753170086695;
        Tue, 22 Jul 2025 00:41:26 -0700 (PDT)
Received: from tumbleweed ([95.90.185.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79d6c6sm821224666b.32.2025.07.22.00.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:41:26 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/7] staging: rtl8723bs: _InitOtherVariable is empty
Date: Tue, 22 Jul 2025 09:41:12 +0200
Message-ID: <20250722074115.35044-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722074115.35044-1-straube.linux@gmail.com>
References: <20250722074115.35044-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function _InitOtherVariable is empty, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 35f48b564199..73561a63401e 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1094,10 +1094,6 @@ static void _ReadPROMContent(struct adapter *padapter)
 	_ReadEfuseInfo8723BS(padapter);
 }
 
-static void _InitOtherVariable(struct adapter *Adapter)
-{
-}
-
 /*  */
 /* 	Description: */
 /* 		Read HW adapter information by E-Fuse or EEPROM according CR9346 reported. */
@@ -1122,7 +1118,6 @@ static s32 _ReadAdapterInfo8723BS(struct adapter *padapter)
 	_EfuseCellSel(padapter);
 	_ReadRFType(padapter);
 	_ReadPROMContent(padapter);
-	_InitOtherVariable(padapter);
 
 	if (!padapter->hw_init_completed) {
 		rtw_write8(padapter, 0x67, 0x00); /*  for BT, Switch Ant control to BT */
-- 
2.50.1


