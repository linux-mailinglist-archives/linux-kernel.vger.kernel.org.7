Return-Path: <linux-kernel+bounces-746956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08896B12D9A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 04:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400A017E6CE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 02:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DCD17A2E1;
	Sun, 27 Jul 2025 02:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH30Xly8"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8AC7262E
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 02:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753583472; cv=none; b=pYiJ7BSYILpDqxsrYsd3FMp65T/AEW3Pj8HKbFSDJpXOSa8b+cmPrw+sgoJp1bIk47MATTfVuF4y8+2BzYiVqDZPZ0vLYPyX4HoipCpXxOXbm8caP/Pd6MFHFJEFODMgzuBSkF7qNlt+2b9a81f0fzwTEBCyyTovwkclZZom/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753583472; c=relaxed/simple;
	bh=xfo+bWUvpL0RQv4Uz0mN3TajrOvcQWcymyzlLRGe7VI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eO3FTo1aYd2141Ydee246Se3ymSbAZFcbIGSC5ZO6QN955Dbjmj3OgcO4NR2r6+vGkiGPzuaF9+xoliTqDINcSb4/O8XKLKyPexDJ5UFk8OE3VsplyI/SrkUlzBAqcI5xY88ajL3SnhWzAhgAXPlAGEoQDWCNASG6VOKJ+duHOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lH30Xly8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23aeac7d77aso31114585ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 19:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753583470; x=1754188270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zSXpmUAcH8gKuzVRHGmOArDUK3DY07YV2csb8d7rjaU=;
        b=lH30Xly89B5OqvU7Z4vJaLUlTbl8a1s7wyjLfbaBuvOXpkm1mondIu5PO0a2bwI60o
         vtGtf1S8RK4gFFahEQB0LV/gF/FehurXYBONBUXQXJdvXSt/kj9cR9Cr4ZqcopcfYBtB
         1vU6ufd/aVT09ihd0dR7FcqHW05gnQTM8DntUySYHpkKi4lq9kl+WlEwtJ5gI8l+w4I2
         nfPb1AzSjFOCDG976uUk1nIWXqzkaEM8aPW0b2Is+XkZiXBiqxntC30GbTVZM5rxVIzA
         yeX/Qvi4+rQYMK88awbCWYcV+tZ1vMyHhuyZZGLlVcMPeJBNJf5Mj/cisTaV78CFph8t
         FarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753583470; x=1754188270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSXpmUAcH8gKuzVRHGmOArDUK3DY07YV2csb8d7rjaU=;
        b=c1u+d7kfgyMYMhr4ZNv2+5qUXNcWvFwJ3lecnmjdOjFcK3a+bOgVswCWXufgOH5NGT
         PEHw0hMAIY+Jrg5hkdbWz9Qnbe01FkoFKiGF+1itx3eq/eRwJ2UGGkdTNfI1dEU8KaXP
         WaoJD3C/dqEMg3aoNM9O/8yrp51LKWB0EDuopSJuZryVw8/PzFxQuiuRSueNqhOFKynM
         2NM4ZFl9W2JMbGd2cO0x29YHRj5Buwj3SjeG44N8iRfBotFK0edD6kY5cB/1sdsRtWqt
         1FWBPIsIJzo9uhjCC/QIQYD79KCylBsc7BNdMqUPPRjrSdnDJdkUxtMS1HRCBDOabAtW
         x8yw==
X-Gm-Message-State: AOJu0Yyx1NUW5XpkmhVPcnYoKq9P4F66QGyv2AgTtUIVM0HIS0XOg8og
	OeN3wM5FRESstuv+Iv/eoy9/B3/hXALRnytgGlZM2ayTxiiMyTBgT0EiZeY0nYU/
X-Gm-Gg: ASbGncu1zV6O+u1hPjzDlp7vCkHruAb0dO7ysZIU3Y1NppAndQv3LikkJgWSCPU1ePm
	MaD5MCqJMOkoiwZk03mOUTuBgLaTMGKMWGE8iCKS4u5E38khKKe2qDdrpxDkxBMGel30xJpVm6J
	nwluogIg2rtnH2RKtNKZI2VXioJSUjpm7E60g0DhKCHT4Ik9oJp1XaoD/ejPEa4Fk9C28UlAbSc
	mNwLJaQMK3z97NpBOIQ1ELSYY52oGqgE3I/TccpZESUdjY76/R/pXC6rLZyHnDfma2GPNQKsXd8
	tpWiSq4Sech5R5LfhcPhMybMZROaCAfFLYyoeLe27jwnCvhkHOLrYNDZ52zQNo9U3UnXK+lnYMr
	3xqCvHXVzVVtWb4ctp0qecHk7TU71meKhys9GXE9ixZl9Jin71hammRHR
X-Google-Smtp-Source: AGHT+IGAvn7Ed62DAr/MyZFpxuIOquQC0pRaTwqVeopbq8hW4Eyw3iYIBtHpM/mDsM1MauTqqulWRQ==
X-Received: by 2002:a17:903:903:b0:237:e696:3d56 with SMTP id d9443c01a7336-23fb3126909mr121197825ad.32.1753583470067;
        Sat, 26 Jul 2025 19:31:10 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ff1edf4cbsm10082775ad.184.2025.07.26.19.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 19:31:09 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/gpu/drm: Fix typo 'paramter' -> 'parameter'
Date: Sat, 26 Jul 2025 22:31:14 -0400
Message-ID: <20250727023114.82461-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 drivers/gpu/drm/amd/include/atombios.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
index b344acefc..2a709f93d 100644
--- a/drivers/gpu/drm/amd/include/atombios.h
+++ b/drivers/gpu/drm/amd/include/atombios.h
@@ -2200,7 +2200,7 @@ typedef struct _GET_ENGINE_CLOCK_PARAMETERS
 // Following Structures and constant may be obsolete
 /****************************************************************************/
 //Maxium 8 bytes,the data read in will be placed in the parameter space.
-//Read operaion successeful when the paramter space is non-zero, otherwise read operation failed
+//Read operaion successeful when the parameter space is non-zero, otherwise read operation failed
 typedef struct _READ_EDID_FROM_HW_I2C_DATA_PARAMETERS
 {
   USHORT    usPrescale;         //Ratio between Engine clock and I2C clock
-- 
2.50.1


