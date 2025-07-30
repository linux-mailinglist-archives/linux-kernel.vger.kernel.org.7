Return-Path: <linux-kernel+bounces-751212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECC4B16679
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960E9583899
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E92E2E2EEE;
	Wed, 30 Jul 2025 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvUHgqB6"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3902E1737
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900986; cv=none; b=MAbDrN9Vr6vVy2MnCE3EziJCB0694O5CV6W4fXxG4KgH9GqUf8qZT614+GY6hO1iQUV9riu4m78/+ufa7Ajx4eEy8f2IVfREqpy5qzPylzoF4XEZd7EMaDX+wvEj2VXaooCXbHr3Gvo9vkqrIqKWbARWDhAkEYDulExwvT2vwQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900986; c=relaxed/simple;
	bh=q12LXBzQtE5vNm2i/WY7kOjnYF8AThpIfB96tzBkLf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D4wkA9BYN7vi6D1gpKouHrh/G5pRpBBdqkOyw81YjY6Akt+EtY3P7eS3cbtqwtET+7JSwbQZhjssQytM9cj6au/5x/f1/8cZd5nyILSh2A1YBMY/V7n/1qh3+YequSF+i113Etz3hyMdTW3ZT1nC/OOk+3K9eLdodIn6k8VT7p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvUHgqB6; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-7072ed7094aso984816d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753900984; x=1754505784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWLv1kUgn6SKLcyh8VLUuc6r9Cuh/UEKenIns7AFq3U=;
        b=OvUHgqB6NRt2mvDmtVkhXNr/roz5PHInBJDJQVeG8qUFk1+YGuAUrV8hkJNW7gMkgJ
         CORMBISQSmYkxvuB0IetvvhdaGL1wLdYSxMw3qOQ7BYNE5Z/1BLP1a+7xu0jNBNkUR0y
         eqkQM9WARMkpS1q3hEp8JgccHERDWXs78iSnlt7SR4SEbh5fQXzz1ymYjAkH3zGa9iH0
         JV+tFlkA1a9LB03jeEFmSaoa6st7I5lWm+Da5WoToDY/WY/mFEYD6Zd1mGH6aRR5HMJ0
         mk017u3vbS7YLNGuiJHRlp6RcR70kMG61ckGLXiq5PUbtwq76dCkl6OMUiZN5mBplgq8
         kQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753900984; x=1754505784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWLv1kUgn6SKLcyh8VLUuc6r9Cuh/UEKenIns7AFq3U=;
        b=u6B9Fb3OtMDu9tEVDaHkUdj0M/wNKiYNxyM62qO7ScBWVGXivEu4kScjEofwfUKNXL
         vhMTI5J0A1vnPijyV2oLA0hD0LPg/OTfdDaIjYHn1PNlokT1WyP0Wy3XophX8RVRRXG6
         6f0jfY6PbL8d9tLSHS3lQZaq7C3B2PKoC4H4kglI95U4bizXgDp2wv9gGNiWbh9Ga3Y4
         pAImnfwpD3epAM066L1utZ97hOaN8cbHSpBmjyQbluQTbhpbafLnaXQDMr/Do6eplmRa
         lbBij8CKxTXWM/SdvwwoZ+OvXM+KEw/YfKPGGJSBtGX1ge94hOxs88I/FOMHFJIWdWgF
         ClNg==
X-Forwarded-Encrypted: i=1; AJvYcCVx5J4DD1Hh74OgkmpLxe1IjC8rD+BSyxYqjChSbhl2zsNt19dDYujmnauNJ7VFimKL/BAiHdLWj7/SLOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/tA4whGuJOBkjKbTHG5CLrY9ce/hYndM7kFm24WmsxWEP47ij
	rBvO6RfI1qlVt5QyfQXoptrUTyezJOWzn5pbR7vmSjohSUXEf6pVnQJ8
X-Gm-Gg: ASbGncuiWscWkqNbCAqEfZ6z4oGhGw+Zi8a7G02HGXuMKTXBEeFQ0QhIRywwWJQ/BOI
	ztqVRpSO84I3ADxuZXJyNqqHHxTC0D13vI1mpvNRgATy+9tSx7UHbGDtqFxJSaxkghi+1aqoBYf
	nNYrzd9H30XoLdcsc8wFD+1VwWE4yCaUtsau99dPc0pW37hAwPbnZI841X8slrI7mJy60VEWrrt
	wgLA5Z5fBQMN5/JpKVj5/uGTHhUqxx42L9LV2123UzREVlizy1k7SPeIJEEZDAz7Qal5PncFfAT
	cLw6gmQsDR1as6EJnpySIf0J4oDeYNvs0t4hpEQ6hhethqjwHR4Y/08QKKb8JYyhNktddpmbDOB
	N4+CXUIhdQGJVS689BXuk6a0gsmoS7u6WF12p01Kxe9+AQR00ZCI=
X-Google-Smtp-Source: AGHT+IG0Q+uHzcHzb8w7sy5BFJOOfLtV6durLh/Jmsb1pc3QIRNateAySU72crVn0OEXtmQw6mUCng==
X-Received: by 2002:ad4:5f4d:0:b0:707:7be:2f5e with SMTP id 6a1803df08f44-7076722f948mr54361546d6.44.1753900983913;
        Wed, 30 Jul 2025 11:43:03 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729ad99d0sm64498186d6.46.2025.07.30.11.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 11:43:03 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: Markus.Elfring@web.de,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	vivek.balachandhar@gmail.com
Subject: [PATCH v4 14/20] staging: rtl8723bs: remove unnecessary parentheses in conditional
Date: Wed, 30 Jul 2025 18:42:39 +0000
Message-Id: <20250730184239.500199-1-vivek.balachandhar@gmail.com>
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


