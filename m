Return-Path: <linux-kernel+bounces-842014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F14A6BB8C62
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 12:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 903C14E0FE7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 10:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3925025CC6C;
	Sat,  4 Oct 2025 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUCEPerC"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017C8156C6A
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759572648; cv=none; b=mqq72oCpKS3D5apJecHsBKxsJE9ytVyCgTKLDaumSSY8529sULYe+C228lT3d47iXgwgIVFSuGeyqaikvTDl081PFUkMOhxK8g576DbIsQo6GlkPw7p4yK5wWdShHTtw6eQ1hFjhdQ/DXmhaNP8PGVW+aizGShLonSxYkhJOZJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759572648; c=relaxed/simple;
	bh=qPwDC5nuZkzu0IGOT3SooZBzDPmuTwFRd6vD7umpYgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OpyvNEjlzm5fjhNQg1ZWYonSrdQEiMEyyd6sZXRS3tSYGhmXYljJzyPhn/Cs9jcePneEPBzM0UKpTPJIJM6hlCYVIrLLhaKd9sM7U67Fxvwqs4bxa3v44QOAss5fDysHb7L2F0UUc8OB4lYVfJY74dCXAMLDZZEGVAeSvkOReX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUCEPerC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b07d4d24d09so577288966b.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 03:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759572645; x=1760177445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tFV0Rbv7UxWT395pItSgd0J0HOojkalhaGP8JovflMo=;
        b=VUCEPerCKpPGYd1rInNdibr6ifJLSnken3ELackHMU1soaor2sknSuGdOwqu0UAwYd
         mGLhz6p1DZaBFLWRHBTejPnX1Dt265SF1BMgig75bEz6D1vnTvR29IsTaLSX18sACDpJ
         F7F3cyG8D43n4BqdQLnSZKwKoVHhAee0xuEKwc4Be3UZL7IpmeIozE2/AUP5TEkSkc+G
         iEqGmz+6vrXCyMzp5rkNaXq9fVZ8aLIwAZVYUYC3Tm9GqGxfnfVeXtlol29RIRLPd9lK
         BfsQPxlwhyzl+GaRWy9OhF0w5OTHng/5lT5OF2eJ4TdJeJkbgQqdeRt/G1KHGdn1/uFu
         m08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759572645; x=1760177445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFV0Rbv7UxWT395pItSgd0J0HOojkalhaGP8JovflMo=;
        b=xPsRcTiQ7Y2rgJ/BHkNl5s405EF5pqWyOyaogOnxj+C3oV3CLKu3Wnab1zGpvkbfh8
         XdbkruWQrppp9vQh/WrqMDqQvS9wSjilVC5D95qtMf/JPCgH/kMIUMJpxGrUEvmMFXSV
         +Ruwfr2pwb/CQrbgRaFu5OX4TCntpH/4sz3+A6TKFPYI7IDAVZd3nca0cyPJUClTVBon
         +iFGySjaPXW9kj4PE6v63STWkBuzyIH4D0oD4pkk+/LojbX/3V1bee0tRiHhutwuExFv
         g7Mk/stMYhJa2ni3qlsg/QiCLxUtz3VyuCGBcy7nxB2M6GAOijK0hBrYbMA3qc+jvvlb
         V/Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVvGOJoKcnKRQLLTgvu8m/bwK0ZkssX8jMh2rNP77M13/8ooFWIUCwJT9RgNTz3VXGCIV3SjLdhKcg33Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVtWKScTcxEgo1NL5gO7+dPfhj3jmm/g2iPExnPFx+Tmphg7Nw
	CrfN42UUrOUVh89sOXVaG7ME0UNJYvJxCQRI7fgaBlGQAP2o6i7BeG/t
X-Gm-Gg: ASbGncuNE9ps1F6zhbODBzgZxVlUpJhE+WgjQeNJ6GEi/b6jXsqYk5709AhOhdOkKWZ
	A9u90F5R92967u8IcbJrqvwwc2I0KdrZE2g1gHmL6QnL8YePQXwpvoXMoYm8AUhwGNCImdaCMrp
	kL1PpR3iiXFi6tOSkohZFMsoBeSo/z41Cr7xsDeEDWhkqvQnbi7ur4lMtq3Mi7Kkk8qQk6vYQWS
	LcpGv3A/VyseW98tpnCFU/PRfTYmZhd3dDL2M9lBgwfwa5tI2pHP3vLSOwHCx8BnImlzdfNquxp
	5A87vXsOfVenDy943r+50gBm7HYOd5AqNA6bOMjwqFUqLpvhsm0PQ+pS6SZJ4XtLuHip9/yPDQj
	lSQN0xaTdAXsZZ2q+LtQsjyaVeroODY+TBSfBz0u5LOB1WcZrrTvXbICJfkEpGcBK6folA+WziC
	UaBBQ=
X-Google-Smtp-Source: AGHT+IH0c2naAO4lXwzQkD+k6vPjbzkl1A28iEcQHuUM0hgRbQTGs6OFsIxPmvxUYAU7ofKDgf4KkQ==
X-Received: by 2002:a17:907:3e13:b0:b33:a2ef:c7 with SMTP id a640c23a62f3a-b49c42769bcmr750600366b.55.1759572645170;
        Sat, 04 Oct 2025 03:10:45 -0700 (PDT)
Received: from tumbleweed (ip-77-25-33-35.web.vodafone.de. [77.25.33.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9f5dsm650069666b.11.2025.10.04.03.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 03:10:44 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: fall back to random mac address
Date: Sat,  4 Oct 2025 12:10:36 +0200
Message-ID: <20251004101036.673834-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a random mac address if we cannot load it from the efuses.

Do not use a constant mac address as fallback. This may create conflicts
if we have several rtl8723bs devices on the network.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 6f1f726d1630..4e81ef53dc47 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1014,14 +1014,10 @@ static void Hal_EfuseParseMACAddr_8723BS(
 	struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail
 )
 {
-	u16 i;
-	u8 sMacAddr[6] = {0x00, 0xE0, 0x4C, 0xb7, 0x23, 0x00};
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
 
 	if (AutoLoadFail) {
-/* 		sMacAddr[5] = (u8)GetRandomNumber(1, 254); */
-		for (i = 0; i < 6; i++)
-			pEEPROM->mac_addr[i] = sMacAddr[i];
+		eth_random_addr(pEEPROM->mac_addr);
 	} else {
 		/* Read Permanent MAC address */
 		memcpy(pEEPROM->mac_addr, &hwinfo[EEPROM_MAC_ADDR_8723BS], ETH_ALEN);
-- 
2.51.0


