Return-Path: <linux-kernel+bounces-746609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA67B128F2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14B8584F24
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FFA202980;
	Sat, 26 Jul 2025 04:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6AqMclb"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8869A1FFC48
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 04:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753504413; cv=none; b=pwYswem/hs/hhKQ3r2Xw36DQOk93zPYVOkLjnG8RN5qHClfrGmU4j4aV/SleKc/KyB94cpyknvVuPdYK4qs7cCzHS0mr3UDLXIrosQ0RB7H93+zV0fHs7c1mnEjSRx1hUoZoqwyZQkNk9g2V0ZwE+NQUfvB/wuGOJe94e0c9gn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753504413; c=relaxed/simple;
	bh=tYsaqE+HPjL5E1qdQhJfbmYvOalIUtt08sYSjG5aD+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OcMBx9RLkyB3CKzFvbAOqxzkxQ2q1kGMflhCHateS4KvjB2U8aoPSV6ieA3I6gLVRvfVmbTvGkzTqzOzk9RPocPfUsmBAshX0vS0wIVWMItOthzM2fozRX3lNLlmPn2iG0F9Hr15Ajpx121MjeCpxXSmXCkxLo59NxRKi8/75gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6AqMclb; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e278d8345aso264999885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753504410; x=1754109210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/k2cDsMk2oCpoOkSVurQZenmcKjISWvt97q0c4W0lmM=;
        b=T6AqMclbbIUusAjKZXCw2V/OgtIdulhHWQsUNueGOhnDlmCrjAOWYrnMGAwOAyvmS2
         6xc0juG/z0CCWK+04JUpPUH0UlbgzJylRuiMbD0PQr3WfjhBlAkx4Srpdo0QBbg//ZzG
         axjMIkVTMParQ348AvJiDmp/Dv3EYMtCHd+/PZw+Vf2mCVWBQxA+59uopa4lncCgO7Gn
         y2iicXtF/iaXcJOeTsjHINCuN8CTj08djyTmlptySfyw0pmUuygEMqIRkFE1wLi/I9rv
         nONlWdL5JZU30c7F9jwvQ9rW4/o2TyEdPw7PRMYYxvNGY7DP9ATw7sleuqRtzLZ0ODdN
         zBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753504410; x=1754109210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/k2cDsMk2oCpoOkSVurQZenmcKjISWvt97q0c4W0lmM=;
        b=VswBI/BpWtbRe0XQIXdBFzbfhJ0A8+/aNSEoovUOgBmTNYrej5zRLENXXBa1Xxm7DL
         c3finEF4rkUe09lw8wSnz2Tm3SYC6X7XApisy3DhrHZ8lCWcp6gPnA05sqNaPyuo/V4W
         W0pJZiYEeAhSL1lLdssEbn8ng9Jj+wEOULyduwrOnyWQEMasmFiZ3yCLduC97G9K13r/
         SzC6QkYQVAwIH63xLBqAQIdc2Mm7ywrYPTNRE7+DOLAxpD9vowbXVPS4T6Zb6Gqr7tD4
         fXoYxksn4Pj9tEpwfpBTOVsf57mcuUN+VZC6dDyA3mMDZfpYMB+J/IG5TmDBgXJ3+hhU
         t5Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXBrMTBx581NQjVFuT7ksyUnsPcJBn4mArJ2twztffTBJSbBnTwzuNJpUovRJqwNZs8WruqpcmFGNSi4zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUQex78GDTpGX/rlOEPzHNuWqDmzbY7hMKp7cnIBwmJ44HNsVb
	DIijWPB8h2jsJCptt0q6uvv9tvTWcPjFhkHlwZ8msdg4A9R9Nzko+bE5
X-Gm-Gg: ASbGncuLT5IbMzagPBW/Vmsu3/PdYo0NoZWY4T7S9J9n4srXdNw5dubQM/ioM8gZ9an
	een8tF1ampiIlgacELT/lgBY487hwi8XAzhY2iRdPP4piBifH8pY96DkW+rh9ch9nIjJRLIT0q2
	8qFfaO09+S0XTsy0i+ISDFxI952+9n7QqSPMsZaL/woC3XhTpIIE/lIpUMxBvmohuiLFIBm9gSc
	yAgBkh1nxY+8mp1i0K5cngUFUH+Tz5NbaZH5xHDvh0TMKwZaQoiEqf3XFltJ///p7ZChuaArlfQ
	oi+hZD2n+EGirjLIS8wnSUefascFb+hLbN4z2hPZdbDhm+wHXdHAzRL+Om+biSqfHR1n9pqsAuU
	0aiWELR1Z5JBQZfX3MF4Z5QlbKIwzljnuccjBcm00k5+PR/Y3NT8=
X-Google-Smtp-Source: AGHT+IFYfEYgKakbQHiU8jBMRd6ycnt6dd42lkFWDBLnfbudTYbPCAPqxcuWnXkvHgBv69Mub6dI+g==
X-Received: by 2002:a05:620a:462b:b0:7e2:769a:c857 with SMTP id af79cd13be357-7e63be3871cmr599030385a.1.1753504410423;
        Fri, 25 Jul 2025 21:33:30 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432a885asm70322185a.36.2025.07.25.21.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 21:33:30 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH 03/20] staging: rtl8723bs: add blank line after function declaration
Date: Sat, 26 Jul 2025 04:32:01 +0000
Message-Id: <20250726043218.386738-4-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
References: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added a blank line after the definition of rtw_roaming()
to improve code readability and conform with Linux kernel
coding style.

No functional changes made.

Identified using checkpatch.pl.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 24e505111f1f..b1a427a655ef 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2449,6 +2449,7 @@ void rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 	_rtw_roaming(padapter, tgt_network);
 	spin_unlock_bh(&pmlmepriv->lock);
 }
+
 void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-- 
2.39.5


