Return-Path: <linux-kernel+bounces-750588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2133B15E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86C25A426E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD4A293C51;
	Wed, 30 Jul 2025 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTuwxk5o"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE08D4C62
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753872312; cv=none; b=TY+xDxnB1whLO4S/RSDkVnhCzgTegdebL1nj9yyI9SvrduTCeUX1tHaAzohyHRKZPbhNmFf7A1Dj9Lj/kqOaNvTqR/M+5H/Gd75J9febqlyZd1tgt43465ndhHarUl/5W3Ky40eTnmVWTQfnbJrB4F1dMy6G+B8uCrPMJpRyshs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753872312; c=relaxed/simple;
	bh=L77oU8lZo3lzX41cIKGEPd9c8cdZbSewguoNoT1+x70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJvHNNx+JOisZWOh/yV15MKZ+wmvHt9/xCn2FLCFdtGIto0Sh7AXFpyCHoIWeWWWFf6XLilSBVnqZ925QpVD9YprwwvqylMcasJ2GapMgNUDXBY8NS+Id2j7dgArPDEHA7z5mIgb+rit9RkOA/bvJzrSvLStdpNr9029qmkvHf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTuwxk5o; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso10614380a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753872309; x=1754477109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHtF4hBBASGxHUgQMYqKRKFf8D8GGRC79rjCKEZrjZg=;
        b=DTuwxk5oPre7a7Dq9/nzis5+PAWVpZcSY0NNjBqKGwa9OBLtnvWfuQHiiAR4tm1anR
         op61hI8oHPJjZBAT8J8AIbPj8b9wCKSRhApqeomhVheruNV+C9rhl5dQH34g/qI9HPxA
         DCi724wNAV+eI5IcZhfbjdwgh/gRNlHm/yo21UWJSpwalLPrt/pVbUmQkYU7zvUWR/2I
         P6hdyElAbE8TxPJ0hTYT6PPHz6hs8uJX9nMabCXNZOiuTwdYNwKJMWLivUMeWDhIQyM8
         2DnZfEmcdKgfr6ZYJYd6CAwHGoBLEA8PmctjSJrJy7WnqQIxsCuP8l2cMiGiOLMxrRh0
         LTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753872309; x=1754477109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHtF4hBBASGxHUgQMYqKRKFf8D8GGRC79rjCKEZrjZg=;
        b=Uqup5GxSNy1bQQLuBOBMuG9mfdzHnLKXizaxvz8mhcvMhRP5CdeiEHK0xiH20nafLm
         GRP4NWmSvVJyq4vDUY3OfA72Zzn5LytYYOgTABgO32YErG73IoJ6ME50n7Vg8MP+/Rb9
         yyyak4WmA1Yz4xSyQztUY2Osx7o0YDnoAEdjdNQ+KkqZlPbgadu8g779ILJG1SbaN2ib
         qsw0j1Pau5neFzjgXrwTQvRNgoQBof7UUEpeBSiOfU/lxBGzdNl7qFiUkrGGt0AwAjL1
         6owVAqXGrBOgfNszE2eEgiYCJ605k6CB8i438lTh8UhQ4atP3Kfdd5Fhc+VjFPt5GLbf
         9+wA==
X-Forwarded-Encrypted: i=1; AJvYcCWb+5EUuPlKfpo4N7gAomPnkx8z7eSWzyOHBRoeof7b/2x2/ZL9CVLXAcdIxcGtjm4WJC2KrwI/QLizPpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9rfrsnPdp+x3LEr5VfkfoARO75tDtGdbMMOgvX/ZR/pAXrFN+
	TPTiekrfgsydQdFtVvH9pUEYjtRN58p2FSrZUpQxyKdpukAjaeW3Kpao
X-Gm-Gg: ASbGncvqFh4HL7MFHaDg4hgHYYd3EW3JjG6pzP2R7mmG0oPqqyrmQw0MH8EIyhY8l7W
	93E8A+qkNMUur71iPlu7scc/kx9W6NG3MCxo1WV7I6iSS7V+dQmKPWFImUvgrNM2WU1yoy53gr0
	vpPCPQl5wESJNa0iMjifOpEP4RxUAQc8cgGVcHb0b82Xk/rkIVn21tYO+YZSyWdf/2JlUBuemsJ
	1okpFeIZR/2zM1JxWZBT1BrVB+OIcW9xPS5bqJzBOP7+zZIzQd9TMCbVwcOgnlHUytZUnqZrf9f
	VWOsz/nXxi6c+N1zE3bE/IyC0DgWrFiHucriwYXn2JMMhPoTcpuI7Rnzk+LpuUD+3JV22G5ihXG
	QXnFsosSDZ/r+zFfJ3af/8aXaeq0N+5quaPO1oMYkPyf/BUC8+xqSYgizmHvqVje0UMk=
X-Google-Smtp-Source: AGHT+IEtUMni+dyL/zZ5x2IMONY/kuNiW77XyB8eQcmhC0XIqdWrLXMCvMYcprCXdHoQpdcQCthApQ==
X-Received: by 2002:a05:6402:520d:b0:612:cdb2:d4d7 with SMTP id 4fb4d7f45d1cf-61586f6213fmr2816821a12.15.1753872308995;
        Wed, 30 Jul 2025 03:45:08 -0700 (PDT)
Received: from tumbleweed (ip-77-25-32-208.web.vodafone.de. [77.25.32.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6157974fde0sm1582734a12.7.2025.07.30.03.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 03:45:08 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/8] staging: rtl8723bs: remove wrapper rtw_os_indicate_scan_done
Date: Wed, 30 Jul 2025 12:44:54 +0200
Message-ID: <20250730104501.150270-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730104501.150270-1-straube.linux@gmail.com>
References: <20250730104501.150270-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function rtw_os_indicate_scan_done is just a wrapper around
rtw_cfg80211_indicate_scan_done. Use rtw_cfg80211_indicate_scan_done
directly and remove the wrapper.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c      | 2 +-
 drivers/staging/rtl8723bs/include/mlme_osdep.h | 1 -
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c  | 5 -----
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 692d0c2b766d..ebc4bd6ecce9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -909,7 +909,7 @@ void rtw_indicate_disconnect(struct adapter *padapter)
 
 inline void rtw_indicate_scan_done(struct adapter *padapter, bool aborted)
 {
-	rtw_os_indicate_scan_done(padapter, aborted);
+	rtw_cfg80211_indicate_scan_done(padapter, aborted);
 
 	if ((!adapter_to_pwrctl(padapter)->bInSuspend) &&
 	    (!check_fwstate(&padapter->mlmepriv,
diff --git a/drivers/staging/rtl8723bs/include/mlme_osdep.h b/drivers/staging/rtl8723bs/include/mlme_osdep.h
index f0d19637fb0f..c84c84c68286 100644
--- a/drivers/staging/rtl8723bs/include/mlme_osdep.h
+++ b/drivers/staging/rtl8723bs/include/mlme_osdep.h
@@ -11,7 +11,6 @@
 extern void rtw_init_mlme_timer(struct adapter *padapter);
 extern void rtw_os_indicate_disconnect(struct adapter *adapter);
 extern void rtw_os_indicate_connect(struct adapter *adapter);
-void rtw_os_indicate_scan_done(struct adapter *padapter, bool aborted);
 extern void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie);
 
 void rtw_reset_securitypriv(struct adapter *adapter);
diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index fd4ae870a617..09bf363efa8b 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -53,11 +53,6 @@ void rtw_os_indicate_connect(struct adapter *adapter)
 		rtw_signal_process(adapter->pid[2], SIGALRM);
 }
 
-void rtw_os_indicate_scan_done(struct adapter *padapter, bool aborted)
-{
-	rtw_cfg80211_indicate_scan_done(padapter, aborted);
-}
-
 static struct rt_pmkid_list   backupPMKIDList[NUM_PMKID_CACHE];
 void rtw_reset_securitypriv(struct adapter *adapter)
 {
-- 
2.50.1


