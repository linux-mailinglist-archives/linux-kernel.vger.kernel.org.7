Return-Path: <linux-kernel+bounces-761857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 755E6B1FF53
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43F6D7A8F52
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99482D879D;
	Mon, 11 Aug 2025 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaGGoC/b"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA50B2D8DA3
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754893393; cv=none; b=UsDTu6wklGNzOxeuhDVjCCccGX7IHX+PoSG3HsOzvdfrnKSSE4b+VN4tPNrJ9wLlG6TkpkBbb0l+/HR77Hf/tZyyDfYp4E74omLMgwTRu7znYvzy2lHrcZUjWKzAq72WtNxaB9C0I+c0vY2eFqxA+INQVbMxOquOx1uAlamPOkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754893393; c=relaxed/simple;
	bh=BDHfmpGRoMLI2dfKAdoBmS9LLQ+5JJl77qRq4cIAqr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnYx87w/gjjwXHMIQ0fvBPlu7rZk+wM5O6VmftDvUBvA1wHMK/n6xzcedmSyAQ300Un+rrixSJ6pZJMRBHInclh6XKVlRoZwO0DmfvJBhyJqxO4XU/uLXYQIXfn0zruYqb5VTs2DvenXI7XyflyQMjjypNAPPrcbVjGSdXXtW0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaGGoC/b; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76c18568e5eso4343510b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754893391; x=1755498191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4706zPWsZ8yK/O+0ngyqMtIMgZD2SQFMOmzvu1UjvI=;
        b=JaGGoC/bDr3/CVOC86cg+1rYC45cDnaC3QNNPC0DbtvVpv9r2PQYiNlOKJg7h++9gs
         kw6vbjryaryYxIc96ddMM8KaZ3nQcmBNyxrtVPttAEV6z1iz0rUHm6U1Uw3s+hgteVh8
         xKRy3Y9KoNrhJIbuFXYnh5VVniZ9ZYJPGRrzvfdeKGv/OUK8ZQuEyXiPLymjLp23Ti/I
         WYRF7WHEuxgkfeesYSGQfwIMoH/xuZwqz8SLRL2NqDer7Q2PycOrBCIGS5nK1b8jwbwJ
         6mlttQv27T1gkzG0U/5OHP+nnoZHbzaoviWs7KTJfBZgJOhuSp6jt5oX59itAoZZkLDq
         df6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754893391; x=1755498191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4706zPWsZ8yK/O+0ngyqMtIMgZD2SQFMOmzvu1UjvI=;
        b=EQwbrTU/6GItRi+3abF5A9v+f/4bip9lN9GSS4NGR+FQFSIZSQ1Gmi6JnHVmFP64P0
         k475y+BXIRcf5RJIj8YPpmj1ifcHoSfrbRvzuiV5pXfc/USKceBhMqTcBESu9RpYc6fv
         q5yPc7sbhA9SlGDXkL4tQJuO19z7QAhVa7PiwvytU2LW7YboUSvArjHegbU9eguiAYgw
         6/OrDG8a8M6axe6rQgDXSs1CqbIK4vhwc7D9nOVMCvD8hVfBifTnSgGI0hzuAXxPogqd
         KlLedym+RiLFQCOa7GcQaG+4SJcSx1JguyfXA0dQbTGuZN7Qp2yxQp7zUOU6aWXUdpGp
         kBPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRhOvakbexg6/7QlDb6cgWPBoyAnNHZRnx9IXudTMy5swa8SsRXh8vH8haVj6wDAZcEG5NBsQweX5Xpk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJxeLWRDXy7rfLOOOOv5O64/TWEXBzQmdOfDsArUAc2a2ddvT3
	n7GADuQ3tUOYDNv80e7J+PWTGoGADAcN2wvvJZfvVIN/rNRMSamPDIqd
X-Gm-Gg: ASbGncvFHCenI1KPtIyklQTj1l0DTjKgQQRMNoCt2Duj6g7+AY627x/ZbwHTqMUwQbZ
	/UL0+22wbfPHLdDuAenn3DqTnvmzEioCQ5HSEk8iGZ3RWpC0w18QdELmmMkbswk7iTHHsw15QbI
	76q7GqNa+Tk9eLUkRO6xm8CbXifxYXLXcsjK764G7aZ01j0lazZKh7PfVX/bfqlfRvrd/Tw2rSj
	8ByS7nF7ajF/j/W3NxpQT8K+/1xkNv+qeLowCEiQOYWqqfLb1a0Dh7cbB8bijETwhGfqhkdeacM
	jcb9G8x5BLRWZyi7oAjJ90RHePobv7sIW1QFAw7n9QDN3xPYeOq8i0+OpOTdzLYwJ1QCmD1JZbp
	tH8a/YQ9QK4OQPUpplly6RfNrUstsOgYwl6UG0PL+JMCaFoCORb9NwGkTrWzcmVysWXa+37ghRt
	N2ZF5rnNAAEG23HddzDLKhC/LBoLwfhwDyI21ZyZIq
X-Google-Smtp-Source: AGHT+IFbGEPaPuUEkhChA58oNSDpiejZ/DR/wKPGJ/Y5MGLXpbFfvBgUHgEdzDjXrtXDnuo8xalmow==
X-Received: by 2002:a05:6a00:2daa:b0:749:b41:2976 with SMTP id d2e1a72fcca58-76c46095e41mr18598350b3a.3.1754893390935;
        Sun, 10 Aug 2025 23:23:10 -0700 (PDT)
Received: from wen-HP-ProBook-445-14-inch-G9-Notebook-PC.. (36-239-105-221.dynamic-ip.hinet.net. [36.239.105.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f800sm25861623b3a.42.2025.08.10.23.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:23:10 -0700 (PDT)
From: Yao-Wen Chang <changyaowen19980629@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yao-Wen Chang <changyaowen19980629@gmail.com>
Subject: [PATCH 09/11] staging: rtl8723bs: Rename camelCaseVar to snake_case_var
Date: Mon, 11 Aug 2025 14:21:32 +0800
Message-ID: <20250811062132.102525-9-changyaowen19980629@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811062132.102525-1-changyaowen19980629@gmail.com>
References: <20250811062132.102525-1-changyaowen19980629@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace camelCaseVar with snake_case_var to conform to
Linux kernel coding style, which prefers snake_case for variable names.

Signed-off-by: Yao-Wen Chang <changyaowen19980629@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 1f9a3af84c7c..d8a474602c61 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -396,11 +396,10 @@ void update_bmc_sta(struct adapter *padapter)
 		 */
 
 		/* prepare for add_RATid */
-		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->supported_rates);
+		support_rate_num = rtw_get_rateset_len((u8 *)&pcur_network->supported_rates);
 		network_type = rtw_check_network_type((u8 *)&pcur_network->supported_rates,
-						      supportRateNum,
-						      pcur_network->configuration.ds_config
-		);
+						      support_rate_num,
+						      pcur_network->configuration.ds_config);
 		if (is_supported_tx_cck(network_type)) {
 			network_type = WIRELESS_11B;
 		} else if (network_type == WIRELESS_INVALID) { /*  error handling */
@@ -869,15 +868,15 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 
 	pbss_network->configuration.ds_config = channel;
 
-	memset(supportRate, 0, NDIS_802_11_LENGTH_RATES_EX);
+	memset(support_rate, 0, NDIS_802_11_LENGTH_RATES_EX);
 	/*  get supported rates */
 	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_,
 		WLAN_EID_SUPP_RATES,
 		&ie_len,
 		       (pbss_network->ie_length - _BEACON_IE_OFFSET_));
 	if (p) {
-		memcpy(supportRate, p + 2, ie_len);
-		supportRateNum = ie_len;
+		memcpy(support_rate, p + 2, ie_len);
+		support_rate_num = ie_len;
 	}
 
 	/* get ext_supported rates */
@@ -886,11 +885,11 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		&ie_len,
 		       pbss_network->ie_length - _BEACON_IE_OFFSET_);
 	if (p) {
-		memcpy(supportRate + supportRateNum, p + 2, ie_len);
-		supportRateNum += ie_len;
+		memcpy(support_rate + support_rate_num, p + 2, ie_len);
+		support_rate_num += ie_len;
 	}
 
-	network_type = rtw_check_network_type(supportRate, supportRateNum, channel);
+	network_type = rtw_check_network_type(support_rate, support_rate_num, channel);
 
 	rtw_set_supported_rate(pbss_network->supported_rates, network_type);
 
-- 
2.43.0


