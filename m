Return-Path: <linux-kernel+bounces-751205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5185FB1666C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614C33B98DA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA39C2DFA21;
	Wed, 30 Jul 2025 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O14JS54B"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AB82BCFB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900809; cv=none; b=APxE75N91WCuA4pM7je88nsOgAxKpwQ2ZBgI3sD9vVH60tQJ42GYhA9eehcsDAfshNb7ZJBN+QFb7mI2LE8n/I6FDZ5qnVirbIIYqZzl48Ot2/XRdI6gVPhCICTaYiXWPCu64Oga8NgbGbo0vkNzuHp1DP30aQhnWk83CkePLyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900809; c=relaxed/simple;
	bh=q12LXBzQtE5vNm2i/WY7kOjnYF8AThpIfB96tzBkLf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3F9WN4F9vfEHVqIWj5+gzrMyaSG3c0lJqBICA14ZbqdS8hsRjtbfJk1VQAWNw/yB2JcR2v7N+9Khuuyrt56D+NnJ+mgHFn1OXUGT+Enoy2EsTq/0W66GxxUyxXqXY/srd+WfuONMPk+lfkEw9DFipoApApc4Xf5Qxf5AZ2D9gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O14JS54B; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fafdd322d3so946836d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753900806; x=1754505606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWLv1kUgn6SKLcyh8VLUuc6r9Cuh/UEKenIns7AFq3U=;
        b=O14JS54BHAoKqSOUnSWmuYI3Etse7fPzFcQTyaUliDuxA1/iiS8s2g1cXDXkthAmp5
         eqNq9IiOJth4Z6iSmeZhgLG2Wq1+QD/4vPp+PLSgtqJFDFmlKShIS+27+lB9guk36+gO
         tEm9JBqP09NGlVQ2LjwfpdDCMRSjr8cXm3tmFrt5wioUk1IGjqvQcb/fYGHNoHITDOkO
         0jZqZ6p0KgF9z/WfFNiCZYr20N0xOSl3hNZaBmm5SegncnjSQ5nKlIYikEX8SfBVbAqs
         LPfDHGmAil0sKUmDa4RXHtV4OJSGaoqTVtD561SHUMZOK22bi9J37O9J1r/R0XZinMhM
         6u8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753900806; x=1754505606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWLv1kUgn6SKLcyh8VLUuc6r9Cuh/UEKenIns7AFq3U=;
        b=AB+6PzRNxGTpqc2HfBJOnUHTv2mSR7bt4Sjl/8GPnTpTdw+4c/XUYPQ1SA31LdI3Lb
         ZdE05ZlHKsNSGsD5zCi8dBf5j9UAbRRrTkCtpS18L6TCXm/1bSeSq3P9es0AXqPA8wNs
         g0svr+OkWacyENkddIK+hkSMgwQcX+OKWFXjBwrX2pzakgbm76TGXRiGXdD27eIgqsQD
         AmL0+Eh4ucevCiQ87p0wL4OQH/Jz8JWlgqlrovnwaOL5dIOXpzu/O4KkS2Y1OIm2O4Rv
         quNelgbbMPqFpbalkmsPPvJGfFXV6JW4zcfHWvc+4M0qCXOgHWiEot/4pG3hasES0LG0
         Q2Nw==
X-Forwarded-Encrypted: i=1; AJvYcCU9Q9T65bGC2Hj6FkPcRS3+BMfwxNLKJDjZ7yisFJnHoZN6vhYrK+jcgKYgj10kVo8FgbkcI76dZ3mhqow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+cjqHnAzr18ljs7Qz/Vhof4yobiOrRXtliXbweBF8wBl8Y96h
	JRIDpL2k5bzASHVNM8cU7KYV4iZfK8QqnQ/gZDj54krLVbNtK85d5Oy4
X-Gm-Gg: ASbGncsC33wADc+QuY4wa5TiWfuBmdknhCq6i5vguA/1Zxm3BhVVgB9G4wfLNyNTVzr
	nGUfc82A3/ZBBT7eGSZKfd2QRrSwNKM9smMJ+8MHppSTEMsr+h/aYP9/9NGvrb7ovfxF+FRTXet
	uKikESlZGd2hUHdNs4YeOrAEVxxVEGYJ7p5BIBLobMOGl4jUgoA60GP/+sXctZXt3/I7AWcjRfF
	SI3IX0iSgmeyLCI7+gVhN8Yin0pHw82trqN0ViGM73Y0pVJ0AVV/fC5+X1LYnPPST6jyUzdI73L
	S7Tt1tEcueYe/fVlINmXUZVLR19pWrTKARiC1/Nk24+4cMl39Y5svMWcmPye9OeIyol7tfk7YYk
	tnBEq9K5f3pZ5FpamVMYnj1dL6tx5UX+COFEZuqlnvxVzMquu7GQ=
X-Google-Smtp-Source: AGHT+IE4++CNg3UAGgJK+/LWn+6RbEykwxS/T6Kamr85O+qD0SFzQUdw4RX4iRcCF4uxmqUwf5GG0Q==
X-Received: by 2002:ad4:5cae:0:b0:705:11dc:546c with SMTP id 6a1803df08f44-707674da9c4mr81435576d6.37.1753900804873;
        Wed, 30 Jul 2025 11:40:04 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729c15762sm65463206d6.51.2025.07.30.11.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 11:40:04 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: Markus.Elfring@web.de,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	vivek.balachandhar@gmail.com
Subject: [PATCH 14/20] staging: rtl8723bs: remove unnecessary parentheses in conditional
Date: Wed, 30 Jul 2025 18:39:54 +0000
Message-Id: <20250730183954.500155-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730080323.491138-1-vivek.balachandhar@gmail.com>
References: <20250730080323.491138-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove redundant parentheses from the check_fwstate() call in an if-condition.

These parentheses are not required and violate the kernel coding style.
Dropping them simplifies the expression without changing its logic.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
v4:
- Reword the commit message to clarify location and purpose of removed parentheses
- Use imperative mood as recommended
- Remove ambiguous phrase “around the function call”

v3:
- Improved explanation of why the parentheses were removed as per
  Markus Elfring's suggestion.

v2:
- Mentioned the wrong version number in the previous patch.

v1:
- Fixed incorrect wording: the change was not around assignment
- Addressed feedback from Markus Elfring.
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index b8d72d28178b..7552f7e4d14a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -699,7 +699,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 	rtw_set_signal_stat_timer(&adapter->recvpriv);
 
 	if (pmlmepriv->to_join) {
-		if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
+		if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED) == false) {
 				set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 
-- 
2.39.5


