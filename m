Return-Path: <linux-kernel+bounces-799662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9568EB42EC5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBEF07C4696
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C451547E7;
	Thu,  4 Sep 2025 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT656dtg"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCBC19E98C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 01:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949185; cv=none; b=AwDskIhLFoZ51cVAPGtGl/Snh2Ia/+W6ujTKbRAG2u2AJjExS8qh1i4fY9iOjJC2x2j9PtbLuVNfrhdTd5hAA9SpkOhrEi/PN424/inPaRg+Xb87bX4RZymLM/UdPGjohM2ns7TIPCm1vwT+b7UoWPGfZuBAeccjEobptaHXyag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949185; c=relaxed/simple;
	bh=JmI3rvfGEf1Z1riF8sZuENvE+ZlBl4htm6xrdJ3xaEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MRSqPfdKTwVsWsuF8vVCxez63ni99dsnd3Bl3sKtRjNo+/UeiWzWddlL2uQ3mHH8MsHB65KsKFCemVXeVrhyetf5aiCJYEDlPXOEVGLnyHDL5YHUsEWrjzC251PMC0YBQBsMDt5sAy3HvamlHNiVRifSdAvKGHF4pUhHt2wi/LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gT656dtg; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-720f0dd2809so2496666d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 18:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756949181; x=1757553981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=420xhJpXeiS8O0VHfKZK4Z2TaOUNPYgxom/AXLmk2uA=;
        b=gT656dtgPcoLEBPAUdt5jZSK+9GzGzwII484Wwj/+Vc6xWd7FBhwnD1Jr+5WENhyGi
         CPq1/I23mS5az05Z+MADjvKmlLm3S3q52/mpecr2gaZUSheSEhu9v1hREVgq4rJ6p8EM
         ebyeYkVJf6vdmqsa8JxjZxVE4DaYSGLG16vsySwHz+g+/iVw51FlnyFt6XmbQ5nxPXLS
         XeftXzfdB8s+CujVcD1nVkH5JGj6zz6ihy63LrC4pdwBczEsznrL3MBnJ26IUybltLdS
         T6rLEJTfh8ON5iHzVoICHhnzz3gwlwVfdYYYW7S3cfraDWQVKKClQZCIefudnIzDArQa
         2D1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756949181; x=1757553981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=420xhJpXeiS8O0VHfKZK4Z2TaOUNPYgxom/AXLmk2uA=;
        b=UbmPLkVi+npeWC9TySBjGU1WDwvdKp20qrPC8qPyp4PlZ1RoEWv+vATThonCnLEHYf
         M/N9JOsPMo/WRXhOE3d+k+4GLAjORqBpQfF2sktBh0cGOAqkVgnNDqvu5ugUEI7MuJq0
         T3cXlHgRwsjN5IDwN94b92dwyt0DEzZmjw7LGlD1nB4/djzIOJ3Ll8QZHiGH3lI9ulJO
         AzG+zjoycpPLuVGwGV/NOyHPIgZzp7epQILA5xtFtbggh9KFzR0AfOrKvyWvMbagtm7V
         AIVK6a8bdlTFna2wmk8Qvgd1YxjaiYRwsuSOhBMw6waa09AmEuI/HDuC6JvRIt43kXp6
         cvtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKB1cUk1tE0WI0ANSkITK/ddPHFpB/uz+ehxob6LA9ruOT6M1s/4paWv2Qb/Hlq/G2LtpolrYGrJk5TE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPyrhJziL+Xms1NJ5W6iKn4H+xFqos9b4UWKuQwBHpPgVRv7QB
	AgiyyP88OhpWnQFy6Sd10J77mFTcM7xWYyB1h+5fYLPtbRnhSYpTgBdjY9rdYg==
X-Gm-Gg: ASbGnct9WaJVGVydds40bApFDisvBNkjmNSS2f8IJC9tl6qb96VUQgDeNgnG9qnr2Kx
	iuElPE3DzjyIwVDVgwtYhIV+JzAKSoTmbg9sTyTYXryfBNKVPZhfStjY2b5Rfyqo/C3MdXyIDii
	J1Xz7qkU3r7cIl+yDqPXnDa7vTpGiaF+CPcYVc41C2cSCmjnMlnXHHcsja0s8lVaXjdPymMGiQI
	oMuTI9weeFWMZPDmIWuoHz/1a5Z598qu+mgNnGmCL9iImrNb1fmLHjpZD9Jfebug4AKRQUxk14k
	HfDFOfoRRgEwnuFyI7oIKoN419AFUlBLVSXYrbOYTiqj3q4baJgA30MFZj0KJjwX0MsjoWa/4Qe
	ltV2t7f6JRXIzLaZfh5M++zPkRnx0wyjFHU8/61puPZx5/IqnUh20Eo0fL7yeUA==
X-Google-Smtp-Source: AGHT+IFdg4kYXNK2wp5imxm6qx0TMPC9UbGNFWAN6Hjfu1048qdbbG8CCwPTamkhoRkHUACqjcoF2w==
X-Received: by 2002:a05:6214:20a7:b0:719:263c:a5d4 with SMTP id 6a1803df08f44-719263ca915mr148729196d6.47.1756949180862;
        Wed, 03 Sep 2025 18:26:20 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b682faf5sm38423266d6.65.2025.09.03.18.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 18:26:20 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH 02/16] staging: rtl8723bs: remove unnecessary space after type cast
Date: Thu,  4 Sep 2025 01:25:22 +0000
Message-Id: <20250904012529.215521-3-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904012529.215521-1-vivek.balachandhar@gmail.com>
References: <20250904012529.215521-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary space between the cast and the variable
in two instances of type casting. Improve code consistency
and align with the Linux kernel coding style guidelines.

No functional changes made.

Identified using checkpatch.pl.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 516e736d03f1..43244e950faa 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1101,7 +1101,7 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	rtw_update_protection(padapter, (cur_network->network.ies) + sizeof(struct ndis_802_11_fix_ie),
 									(cur_network->network.ie_length));
 
-	rtw_update_ht_cap(padapter, cur_network->network.ies, cur_network->network.ie_length, (u8) cur_network->network.configuration.ds_config);
+	rtw_update_ht_cap(padapter, cur_network->network.ies, cur_network->network.ie_length, (u8)cur_network->network.configuration.ds_config);
 }
 
 static struct rt_pmkid_list   backupPMKIDList[NUM_PMKID_CACHE];
@@ -2547,7 +2547,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 
 		if (issued == 0) {
 			psta->htpriv.candidate_tid_bitmap |= BIT((u8)priority);
-			rtw_addbareq_cmd(padapter, (u8) priority, pattrib->ra);
+			rtw_addbareq_cmd(padapter, (u8)priority, pattrib->ra);
 		}
 	}
 }
-- 
2.39.5


