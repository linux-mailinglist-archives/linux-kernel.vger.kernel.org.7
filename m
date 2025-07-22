Return-Path: <linux-kernel+bounces-740407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF12EB0D3DD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A4AAA4109
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DA82E0925;
	Tue, 22 Jul 2025 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2Mnh04F"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE2AE56A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753170089; cv=none; b=BHvcKLJEuz6SIAejyYiIo08tCGMnl637ZYy5FRfyd+3Bfn2dTsAveY8g+Pq0RLm+uNgH2g7029w3rJJ8yKebf/+H0MlBSNMqIxCCGpOBfvSm1sBV5l145A27UCxLqh0aYekzzPs/uMeKpar5CSxMrfBlhjzaFAbrRPFvPV0+Nok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753170089; c=relaxed/simple;
	bh=1l3HjrUJiABwtuxU2wIL/CGF1DZPSxv1vgQ9ZaOoRIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGPDIeVjDE7jkFa7EV8atYWS75UCIqnA1DSqdSE/Qy+86Pz5/clnK4MAyzUV/mLRNrFrxqgEwBIEeWDtO86DnxmEN+0Yvb4sETvfk8ggiIGJEXrXRMg49DGGu0ya636C9+4OY8W0zoJP/7BkJemvVIahCijg47sGOcLmoOMcPXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2Mnh04F; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae0d7b32322so794445566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753170086; x=1753774886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7sE0GkdsD45T0HLSOYCdFV1j0QzJKJmMfNON4MWVo0=;
        b=I2Mnh04Fw5Mhmi3WxdsQ3xjkVNVYoUYQKc9OXGGivePAVNRv8QEQVrWBLPqjZ1uRh2
         nNfEA0iJghw/52o+e3GAIAHTejRrFX5KRpaDIJ1D0ke+Ce+fR6jaehXiEM08YvlihaVV
         VMI/7KKmKoNvikiM3MBzAh4PQtO/XiErKgMDXjU4zv/ow/2za3zqtYf95+HpCTRpXnml
         /5ytJeW5LRFX570tgKOpWNQF4zNtGmUzAigZdZ+Dl4Llv3QJ4AFC9f23jNYmP68D9lxB
         GzUO8NIQFaFzD+Q/c1589YvC+lJUjW87ur+N7h1tLmfqtGJDYfA1TA80fTbhJ9RP78zb
         EXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753170086; x=1753774886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7sE0GkdsD45T0HLSOYCdFV1j0QzJKJmMfNON4MWVo0=;
        b=njjutR3sj5yoTUv0rBhTCEXQJ7sHYLJQAHqAhulPy8oulHscsWBEsGQyU2vSXx+V7q
         6Zqujv5VLvT93WiNuYUd/KerTiGirRrWgv+OCOFmlwhrz0bowSktPmYjJpSEGja2RIRf
         auK5tNBpq7KL3OMT/HOpKuz0edkoudntYsEoLZJNmHzuuEFcMOhSQN/1k65fHVcIWBV5
         5bB7osbOvOKHapwVjd8jwwt8wh8BGOb+b/qGUtFDUJUc3r0UrzQKvmUbJ1/cDupU3H09
         rygyztPYXg2PUgANDxn3uGsZ46qRqGOSUEhvxpgRl8wKqBPFJkKqF2N2xTb32C/9+UYp
         GURA==
X-Forwarded-Encrypted: i=1; AJvYcCWo+r0SHdrDlWLUeXMjLojcv4mNmdNWFPkuMr+K6RC7aQYd+SQeR0QABa5HIa210uTfm2oMonpuMlPMR08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDK22vhptvO0+oodc4DhPkfFrjAFGDbd5z0J6DRzc+lThOqPY9
	4F9weKNHGPCldtbkMTwR+L63U+4Pr7noYMJtk/k4v4ryyAhL+WLAFjnf
X-Gm-Gg: ASbGncuzNiayNZezJt5HJgP7T04BYxOPJWW8GCFB0U8ApcmOcc4g+XcXs8J2fdh/9bI
	cPK22JJw4SHRIZCZpc6xg6SvEVW29k1S0CCYOT2vTzJv4wx3T4BA6TbnX4iGT15QpdTpQ5Rgxzu
	3HtrxY6aihHgVB0clnQExpA4D5xquDPXBZrp58yW6npnSz6l3o7AwKXViXY2ypJD0K900KZj/+N
	azFawLEkVzU4Y48Ne5Dt/kl14RL9PC9clF8ebQuh5icjn9k4MBOhZ6RAkWtaUQ0FrpWdStTXLtf
	cCARug9nwv3DAMe/OxCDEOPe0JUThc3zuShkvtv2Q/uQKzUoonMcULG6z7W7Il9Muktf/33Lsyv
	SakwWfk46oK/BC8I+qmZwHqM=
X-Google-Smtp-Source: AGHT+IG3gF9sE/0Jdy1kh7EZCr4YbiDOyy3LD42YXJXtzPUkI8b7ra1CAa9x8WSs55Pu8qd79Zg+kw==
X-Received: by 2002:a17:906:d257:b0:ae3:ed38:8f63 with SMTP id a640c23a62f3a-ae9cddea78emr2252508466b.14.1753170086114;
        Tue, 22 Jul 2025 00:41:26 -0700 (PDT)
Received: from tumbleweed ([95.90.185.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79d6c6sm821224666b.32.2025.07.22.00.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:41:25 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/7] staging: rtl8723bs: rtw_get_encrypt_decrypt_from_registrypriv is empty
Date: Tue, 22 Jul 2025 09:41:11 +0200
Message-ID: <20250722074115.35044-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722074115.35044-1-straube.linux@gmail.com>
References: <20250722074115.35044-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function rtw_get_encrypt_decrypt_from_registrypriv is empty,
remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c    | 6 ------
 drivers/staging/rtl8723bs/include/rtw_mlme.h | 2 --
 drivers/staging/rtl8723bs/os_dep/os_intfs.c  | 1 -
 3 files changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index b60f5a456543..742e6a212a02 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1092,8 +1092,6 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 	struct wlan_network	*pcur_wlan = NULL, *ptarget_wlan = NULL;
 	unsigned int		the_same_macaddr = false;
 
-	rtw_get_encrypt_decrypt_from_registrypriv(adapter);
-
 	the_same_macaddr = !memcmp(pnetwork->network.mac_address, cur_network->network.mac_address, ETH_ALEN);
 
 	pnetwork->network.length = get_wlan_bssid_ex_sz(&pnetwork->network);
@@ -2095,10 +2093,6 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 	/* pdev_network->ie_length = cpu_to_le32(sz); */
 }
 
-void rtw_get_encrypt_decrypt_from_registrypriv(struct adapter *adapter)
-{
-}
-
 /* the function is at passive_level */
 void rtw_joinbss_reset(struct adapter *padapter)
 {
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme.h b/drivers/staging/rtl8723bs/include/rtw_mlme.h
index e665479babc2..3cf68b85eb32 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme.h
@@ -341,8 +341,6 @@ extern void rtw_init_registrypriv_dev_network(struct adapter *adapter);
 
 extern void rtw_update_registrypriv_dev_network(struct adapter *adapter);
 
-extern void rtw_get_encrypt_decrypt_from_registrypriv(struct adapter *adapter);
-
 extern void _rtw_join_timeout_handler(struct timer_list *t);
 extern void rtw_scan_timeout_handler(struct timer_list *t);
 
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 3e857aa41d53..6ca6dc548805 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -521,7 +521,6 @@ static void rtw_init_default_value(struct adapter *padapter)
 	pmlmepriv->htpriv.ampdu_enable = false;/* set to disabled */
 
 	/* security_priv */
-	/* rtw_get_encrypt_decrypt_from_registrypriv(padapter); */
 	psecuritypriv->binstallGrpkey = _FAIL;
 	psecuritypriv->sw_encrypt = pregistrypriv->software_encrypt;
 	psecuritypriv->sw_decrypt = pregistrypriv->software_decrypt;
-- 
2.50.1


