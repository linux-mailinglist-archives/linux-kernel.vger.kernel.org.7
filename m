Return-Path: <linux-kernel+bounces-842941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCF0BBE050
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC36F18970A9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4442B27EC80;
	Mon,  6 Oct 2025 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2yagZYC"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483402905
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759753534; cv=none; b=XEOhl5kj6WErCo37Zgy0zqcQK/Axusyu5MSAE2AG0nlg3JMPTClVUT8SKEcXK7noNSIlemW4lQT4ytQHsEw0OP2Q5A7xdF57pvb6EvwN/Qo4djz0damS4SU7KepmzpG76g4c78ldy3/ZV+lP+xuVlsRRW5iFNUuvKxgZ/4d1mE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759753534; c=relaxed/simple;
	bh=kGnUJMNjHO71kFp4EtWKGHp2JB8jldGLhc9l8su+EgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y/ad9aK4zeO5vMvYlMvlz9+WcVRpvdh+txoB0ftnhO0z55W6w2GWoxQ5v9TXWQUEVlVckgcrGm/GkVtzXAMzFGUnMShoD5PaBzeyHI8oN/lRBrVhDtSzE+SCJHltyr6H9yz36lkHoLbBLHZTtd2xw3lLzZ/mrPYtMvZj7KUkuL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2yagZYC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27edcbbe7bfso76271215ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 05:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759753532; x=1760358332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g1VoA28QAB1LaO/0AKqL4O/Y2EiakdoSDbts9AjpHeQ=;
        b=Y2yagZYCo30Kyvn9HSO1S05gU8TzJcL8DmvA0ZFckptED5hFxhz1FLtJXz46Y3Bcsp
         rx9sf1UUH2gmjnysNQmelOX/iM+xDwfrhJ1e2SEELleYepQTrKjrmnu2gc905vt0HsRg
         Lj3e3Z0lQD9BfEKbLMoeNOE21O46VgvjFkNCSZMW4eFDH8SK3CrNJWgWrx75vLklhODC
         xjUrDmjfTEA9HaNcArNFR6+EQBMH11aWRoP2MvSuQ/gbl4WMnJAqv1rya/Sl5XeoceGu
         ISePsJG1AGakoC1f1xj64AEosIksx2/Beb+ZpTFqhxY4nQZE+lBWq0fF5OF742fFg6R5
         wiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759753532; x=1760358332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1VoA28QAB1LaO/0AKqL4O/Y2EiakdoSDbts9AjpHeQ=;
        b=NQpDMFkU7q4ahHrvqVcIvNWsvvT4fVL+rX9TSmZp5JnvfY9fbph3HoV14MoFdzJsIE
         4pBwN/lpZL/u+YDeRjFW45HSAjG9gBj5+eQ+cUI4SzpnAg7pB2Hdp2KKc40W48pHyX1Q
         jwTeweadXY0d8SGANlOXso8nor1xF+t7ib1+cyenpSH4wB0X2yV0ZWp7I5r4MLlJnW9T
         lqQkYEWbOb8V6E9ESbhL0iOw1VKq0relvveWmdsbYQGIe3RtTYE2kIrNOMhM/IpK6vH0
         NLePbZM+kSJWs1/YozqM5p5SMunAP6bKy5ohlYrqHVXEl8Qe4mxSweHTBNtKiJQE/CAs
         9NZA==
X-Forwarded-Encrypted: i=1; AJvYcCXU4HoZ5/6ePAOuYqr5lrRk0AmkINe4m3p7Q6Monp7IYlWt7uJlYCh7wKWi4yAd0IHcI+4PVz1ALuDuZCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQkVTh+XFIPUA2sOGQxhTC0a81c3EYA+h/a4tw792AJ46Yf8Cn
	KhXnMGJce0+4fSxQU2ffMPbpdozQ+EeZ/MSXxofqOlw7PcnzsQRlPApJccO8CA==
X-Gm-Gg: ASbGncvqwrd404YMnVDn99N83pMUUkhGiY6DKjFBPao+osAINc8WbESF9yPf0RpUhb3
	+8YPlmmwXzFKpQ48mjrh/lBV3AanchzTQH/aFljhPRUW7jCl2jQcyygr9xHXLdorl9GMFYz9Bzw
	qFIYPDP1KRsz85KY8N3SUEkJUMN9ALefS8Eon08xxStlHufou9eqrccObJ6O0pknghiN91Mb0Gj
	2jL/m2K1o9BRAXMw2cI+wOodwE1W0JkZ78fMlcJ6Kj75b2c+ZO3f0WFLp9IYZo6Y6orJtKWwzOm
	FISvBy6vUcJcgPaEsqV73dnP14lBPXZTqQsBB+8AM+pY7Evv2WCIJynX8BetL1dLwwbTzIxDFcS
	p7xHjmVtM6fymYO9wFETDw8FH9uYYAMU1iO9Ct6k1TYmy3PLQsE1Vn0D5X8pgG2aA6hoRag==
X-Google-Smtp-Source: AGHT+IE2fxagLBcV89KYI+/k7E4e/L0HbfHVoGRjzzCu/Trvn+QFvvsXy3CuD2dSestm6zz0PIeoAQ==
X-Received: by 2002:a17:903:1b03:b0:269:d978:7ec0 with SMTP id d9443c01a7336-28e9a62ffb0mr162012545ad.28.1759753532584;
        Mon, 06 Oct 2025 05:25:32 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:fa6f:67e6:9404:f1b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d1c5csm131201565ad.101.2025.10.06.05.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 05:25:32 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: Remove unsupported PALTFORM_OS_WINCE ifdef
Date: Mon,  6 Oct 2025 09:23:19 -0300
Message-ID: <20251006122524.9442-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Despite the typo at PALTFORM_OS_WINCE, its a reference to OS Win CE,
which definitely is not applicable here, so clean it up any mention to it.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_mlme.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme.h b/drivers/staging/rtl8723bs/include/rtw_mlme.h
index 4c15d0194d4f..2a128568c6df 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme.h
@@ -18,11 +18,7 @@
 
 #define		SCANNING_TIMEOUT	8000
 
-#ifdef PALTFORM_OS_WINCE
-#define	SCANQUEUE_LIFETIME 12000000 /*  unit:us */
-#else
 #define	SCANQUEUE_LIFETIME 20000 /*  20sec, unit:msec */
-#endif
 
 #define WIFI_NULL_STATE		0x00000000
 #define WIFI_ASOC_STATE		0x00000001		/*  Under Linked state... */
-- 
2.48.1


