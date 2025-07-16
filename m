Return-Path: <linux-kernel+bounces-732831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E32B06C8D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062EB3B2184
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 04:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78609275115;
	Wed, 16 Jul 2025 04:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5NJL1na"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5959717BD6
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 04:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752639161; cv=none; b=hlf+FTIEiS10jCA7Z3rlep6R2BWdZhCPC1Rm/6HoSXwzYARy8R0AsvhJzugMzdxycTFulPIH3tCQaxQgz/J+LFx/sq7EOwhfWi9+aaGxMaMVP4+8AWtYoEUHIpR0P1dA9JMfMneYzWTU+9xwfT3jWbPWjby8uUz4xpjTS9C9Uow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752639161; c=relaxed/simple;
	bh=TL99k2WBQTdeYLNnMKuKrZlEpk/EaSle7CfpZmEzI/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=E3AkuF4k9s0EefdBLWAfFIt3pyMDmbX9V+qAJ9OjGYcXyZZG8p1U7zX6uY1lnhkpmas4H1Z3K5F7J8rCzZVF91AvYfKbpK50tGyv5E6NGK7v3eocBzszsv88ZqWRiMmhGcyGYOgtVKKdR6YmdibyZEIoAmw8pLXNopZShX7s9Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5NJL1na; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-41d826eb310so136b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 21:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752639159; x=1753243959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gWiUjZu9ZnCa6LYAWdZFUNk548lAPSY+9yO5ufM9NFY=;
        b=Z5NJL1naDjXxhdWBNNtYidXPKYlN6r47MjGL1Auvt6PsLNNJr67aow8BL6Fz7df1un
         n7PsGcncIjH2NigLhBya/FKsxTOkkS2gefUAq5Wcjc0nIAmpHCStxOjAOEM61Qmh6qWQ
         U6dFW4yui+Pg9OkxddGaut2WRujWMCQinNvimIgRTN3e2OppxBpaadGo7kGMQWRZug3R
         1p4lo8Y9/NNrvbqTLJgMkSkRP02W8r/J16ebJgrCtchivalLDkaW/qAlJbRPIAmmJhhZ
         xNPTEQ5uuLA4NxElhJ8uoegidH3NtQYwmaFmTbXHPSCvEZBC3KmMrdoDXF7PEnHuBDon
         ZUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752639159; x=1753243959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWiUjZu9ZnCa6LYAWdZFUNk548lAPSY+9yO5ufM9NFY=;
        b=haoAoirvEIuf800kzZLWjFyvSvFbAm0QvESkcjeq4vB+3bj0rlzILNPCP5kuxAaN4H
         aN/mB0tgni9GWI7a8dc7xbinbAzhHe5wIXc+/3g0hLjKEoMfiAY2LXAK33pnWlbainqs
         BYAaP92fh0vcr+pN7XRi9I63BmRMKUfjo5HOBtjsdOk+q645oJ6AobpGdf0GQ4n1yTTK
         pHE5XLT+gm2leXP3ba8oxvSdqWIc1/jkR1zPj8jrYvoPSe3WeiMxKH1/+iziN704c3n3
         rVqRHwglDE/0BxVwaX/I0I5OVOGm9lUTG3XfPEtVig6OOVqn1M8wOdd2HOh0MO1F8ZDV
         bIGA==
X-Forwarded-Encrypted: i=1; AJvYcCUr580YZMvg6MoYXJZjm5Qys99VJC70B8qEbWSw4hm01y6I/o6fxu1xFf0iCG9mLUWfHCFFAVn4jxMy7rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhKMrYTgrI/wyHdUvtevhWfDtoHWNqGPNjBwaRYfJ9uphkeNpu
	LA8Hm8lLs4QmfMfVXOBFxuX3/jfho3qdTMBjUhNdIBEg4qvX0kkJ3kWT
X-Gm-Gg: ASbGncuQ/tU243VuyqjX2MzqtgkDxp+cZ3l2UjCxxan983obJZvtZTRVGPJR4SkdbIe
	Hu4KG9HTBv6k99PJnrEGqgyHeyZ6lsRwi2vYbgUknr5DMwSC24JJGeDE1kr235Tf79hs5YVKQ+s
	G7XLEu4u3MoLKLxImS/4bPDaaQCa1XLbSTeY/uDy6UpvidsiAYPiVnq0QoQDQOVlOX8+nc6D/ob
	0aJ5+nOtbCB0qEeFn0GH++UjhWSipKNV6XK6wl4KzJ+E/eAOvt7DJk4HupXyRBuXnW24TxMl3Um
	OTD41oW9I74+EtmdNBH0T5M4z8+HAgSLOX+tv5ukLWvmdIRbVhGDV+Fjtk6FXrW3Ac74VscUjRv
	sldU9eNPADNH5FEF/XSUmZB9xzJUbD0nNWGkd2Fqu+yynQoOOhFJR
X-Google-Smtp-Source: AGHT+IEA8WP+WxB+Wq7vj8kS1HXqnmSin399JMoCg5Mj4EKJN0gjGZwGRIljWTBikJ+i4TyXjdf9ig==
X-Received: by 2002:a05:6808:2210:b0:411:96a9:7ea with SMTP id 5614622812f47-41ced9970eemr1295317b6e.4.1752639159341;
        Tue, 15 Jul 2025 21:12:39 -0700 (PDT)
Received: from localhost.localdomain ([181.161.11.224])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4141bbde341sm2488309b6e.27.2025.07.15.21.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 21:12:38 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
Subject: [PATCH] staging: rtl8723bs: Fix multiple checkpatch warnings in rtl8723b_cmd.c
Date: Wed, 16 Jul 2025 00:12:36 -0400
Message-Id: <20250716041236.61270-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix the following checkpatch warnings:
- Comparisons should place the constant on the right side
- Braces {} are not necessary for single statement blocks
- Block comments should align the * on each line
- No space before tabs

These are coding style fixes that improve code readability.

Signed-off-by: Ignacio Peña <ignacio.pena87@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c | 40 ++++++++++----------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index 56526056d..4f33f4f0c 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -24,9 +24,8 @@ static u8 _is_fw_read_cmd_down(struct adapter *padapter, u8 msgbox_num)
 
 	do {
 		valid = rtw_read8(padapter, REG_HMETFR) & BIT(msgbox_num);
-		if (0 == valid) {
+		if (valid == 0)
 			read_down = true;
-		}
 	} while ((!read_down) && (retry_cnts--));
 
 	return read_down;
@@ -35,13 +34,13 @@ static u8 _is_fw_read_cmd_down(struct adapter *padapter, u8 msgbox_num)
 
 
 /*****************************************
-* H2C Msg format :
-*| 31 - 8		|7-5	| 4 - 0	|
-*| h2c_msg	|Class	|CMD_ID	|
-*| 31-0						|
-*| Ext msg					|
-*
-******************************************/
+ * H2C Msg format :
+ * | 31 - 8		|7-5	| 4 - 0	|
+ * | h2c_msg	|Class	|CMD_ID	|
+ * | 31-0						|
+ * | Ext msg					|
+ *
+ ******************************************/
 s32 FillH2CCmd8723B(struct adapter *padapter, u8 ElementID, u32 CmdLen, u8 *pCmdBuffer)
 {
 	u8 h2c_box_num;
@@ -57,13 +56,11 @@ s32 FillH2CCmd8723B(struct adapter *padapter, u8 ElementID, u32 CmdLen, u8 *pCmd
 	if (mutex_lock_interruptible(&(adapter_to_dvobj(padapter)->h2c_fwcmd_mutex)))
 		return ret;
 
-	if (!pCmdBuffer) {
+	if (!pCmdBuffer)
 		goto exit;
-	}
 
-	if (CmdLen > RTL8723B_MAX_CMD_LEN) {
+	if (CmdLen > RTL8723B_MAX_CMD_LEN)
 		goto exit;
-	}
 
 	if (padapter->bSurpriseRemoved)
 		goto exit;
@@ -80,7 +77,7 @@ s32 FillH2CCmd8723B(struct adapter *padapter, u8 ElementID, u32 CmdLen, u8 *pCmd
 		else {
 			memcpy((u8 *)(&h2c_cmd)+1, pCmdBuffer, 3);
 			memcpy((u8 *)(&h2c_cmd_ex), pCmdBuffer+3, CmdLen-3);
-/* 			*(u8 *)(&h2c_cmd) |= BIT(7); */
+/* *(u8 *)(&h2c_cmd) |= BIT(7); */
 		}
 
 		*(u8 *)(&h2c_cmd) |= ElementID;
@@ -438,13 +435,14 @@ void rtl8723b_set_FwPwrMode_cmd(struct adapter *padapter, u8 psmode)
 
 		}
 
-/* offload to FW if fw version > v15.10
-		pmlmeext->DrvBcnEarly = 0;
-		pmlmeext->DrvBcnTimeOut =7;
-
-		if ((pmlmeext->DrvBcnEarly!= 0Xff) && (pmlmeext->DrvBcnTimeOut!= 0xff))
-			u1H2CPwrModeParm[H2C_PWRMODE_LEN-1] = BIT(0) | ((pmlmeext->DrvBcnEarly<<1)&0x0E) |((pmlmeext->DrvBcnTimeOut<<4)&0xf0) ;
-*/
+/*
+ * offload to FW if fw version > v15.10
+ *		pmlmeext->DrvBcnEarly = 0;
+ *		pmlmeext->DrvBcnTimeOut =7;
+ *
+ *		if ((pmlmeext->DrvBcnEarly!= 0Xff) && (pmlmeext->DrvBcnTimeOut!= 0xff))
+ *			u1H2CPwrModeParm[H2C_PWRMODE_LEN-1] = BIT(0) | ((pmlmeext->DrvBcnEarly<<1)&0x0E) |((pmlmeext->DrvBcnTimeOut<<4)&0xf0) ;
+ */
 
 	}
 
-- 
2.39.5 (Apple Git-154)


