Return-Path: <linux-kernel+bounces-740409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3786B0D3D3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57539188C850
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E866A289E33;
	Tue, 22 Jul 2025 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOEFNVHf"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B412C3257
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753170091; cv=none; b=tUNraqCv2jIhygTJSocY4IR/vl0yMyTIBocXozpio1CChHdR8hUMMZyVwooL43YhodZunQRYzUI+hvXMlHW1Ej24ZBuVlxEaDuf4lXpt/3Z1wV1RcQuxIiFUqqBeerp6AM9EyE3eWyHH8yfmYv/q+vySAbdKBdpMOWFOJqd20rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753170091; c=relaxed/simple;
	bh=+903zGZvnJBOZvgakEzqbUjZ8qRAgFxUG+gPiyWd7yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wslq/HJBgIeTrB8K2cVOKhEz341VH7HHjBbibJ9OdV9ZkZHtWa4mZ6tewR33LCkd8qUY04PcuMNKIchLF/Oan+/juBZid11/b/TVPhGbaRUX6LpOOE+97AulGGI+iO+kAdP81qXiAui2Y2XlGnXmSG/SO9yiO69PRhyWpdGneQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOEFNVHf; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae361e8ec32so896606366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753170087; x=1753774887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTRKXgPUhQNMg5YfDVPQLtFMcQsgKomN7QTt2xbWovk=;
        b=mOEFNVHfAGmuo0pQnpJw162dQo7sU+8dveRnSaiBN3MtfuHt838s+PX8XH9Z1vwXGM
         excosnAxmSaN8FKl8x/ANsi/uSX/evcmE4HLlNnMQTMZdlbfWKtPr3otAL2gboX2nm0D
         7PhumfHXXm/OeHR6dnGgbsdH7eYZ1+3CJ8mdjKC8Xty2gKHv+QwD16XGvqUinj45ompi
         vnOzUkMc3+BoHPoAllbIC5urrPgw3SOig6eGzjtBft/ejozluKjRgmFUb2bR8pezuvTb
         rWvGWfBl8MvxmK8CR/MfGd9mKtDuDIlgqhEPmhtZa4Vgre8Hf6o3la5rwK39is2hVpK+
         uHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753170087; x=1753774887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTRKXgPUhQNMg5YfDVPQLtFMcQsgKomN7QTt2xbWovk=;
        b=ta3rZVMNTik7ilLlQsLY5sp/iusiiXsdhEMbPs7zSmOUyopDkVlEYhKatLiMBlNkKQ
         ikDA5jE8fOWIj873+tyEhwenjX7HrQ2qI/rhGeWAzbsfIm4BCjUWbwOT/qnOVFkULgt+
         RXV/OdX11PoG8lXvBnP8P2+EipsMAp4OMj9JgfDvfA1O8jnlKiee2KDswhGdcP2Kt9qt
         YM5Ej6X0qBXrUfqTUO6t7ZAAVmTDGdJw6kEbKz69UgJ72lD/k6cEncBUsC2y/S/JUkrN
         dRi3J2WFkziSQ50DAtrzdQBsiWQFBixGlXjiSBpldSLGlIKyOpf/Z0KVAMqUc8Jr+r+t
         xGWg==
X-Forwarded-Encrypted: i=1; AJvYcCWxnt3EUBb++rAJDrowTx5ZatmeNW4HHIrlrQZQrjNyd9RuDbik7tGFUVjXpVN0sbeI1rjoSm7FHNw1gWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrdCZE0tadRYQee4BzsBMWTXSlQzL/+aVQTMwi8G17jC2bx57+
	PMNXifqpNNVUcaWuvnqu16xu2xk56zVLK0iTV/4/UZr8GBXQl5pA70dOPdh7Ww==
X-Gm-Gg: ASbGncsU85RDx9wtW4CajCd2/xfYS3viJBTUbPMOvpgePVgvI0REuHh1R0swDjOn0ON
	TlYHpgQWqg/b22xXWpypc6gEVRd1VwtFGYH09/wJaNnJe/Oac5N0l8P5oOQwqhckJnh9s2MmIOS
	pQeusz6iPs5sT/fojqTkmT6UNOjkCgZaA/w34R0tUy7sD/wkE84rdeXJ84CbhHvsTvzPKHkaw8t
	DITQGR5T/JMSljBEAraFDaBLbzkiID7GluugT2/dl4g499y6ERCQWe3+csQB7tOOSH5lHXTjItd
	lsSumugPSsMyOWN5y5rCJZu6P1iM9zLaut+Z7O67OaWxIaNPAMI1bRl6peDBbAJ6h+sejo2JYUP
	uf0tpfWWySOsFuRPEnyM2XvY=
X-Google-Smtp-Source: AGHT+IHeslD+1Ncf3fbtZY6D7RH6MggfPObIE7haUNbAba/ZYty9LnEejM4kM7jKmSr0+XKGEvx93A==
X-Received: by 2002:a17:907:9625:b0:ae3:7022:b210 with SMTP id a640c23a62f3a-ae9c99812e3mr2376087566b.12.1753170087262;
        Tue, 22 Jul 2025 00:41:27 -0700 (PDT)
Received: from tumbleweed ([95.90.185.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79d6c6sm821224666b.32.2025.07.22.00.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:41:26 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/7] staging: rtl8723bs: hw_var_port_switch is empty
Date: Tue, 22 Jul 2025 09:41:13 +0200
Message-ID: <20250722074115.35044-6-straube.linux@gmail.com>
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

The function hw_var_port_switch is empty, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c     | 7 -------
 drivers/staging/rtl8723bs/include/hal_com.h | 2 --
 2 files changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index d91e2461fd7e..07e9d3423651 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -569,19 +569,12 @@ void rtw_hal_update_sta_rate_mask(struct adapter *padapter, struct sta_info *pst
 	psta->init_rate = get_highest_rate_idx(tx_ra_bitmap)&0x3f;
 }
 
-void hw_var_port_switch(struct adapter *adapter)
-{
-}
-
 void SetHwReg(struct adapter *adapter, u8 variable, u8 *val)
 {
 	struct hal_com_data *hal_data = GET_HAL_DATA(adapter);
 	struct dm_odm_t *odm = &(hal_data->odmpriv);
 
 	switch (variable) {
-	case HW_VAR_PORT_SWITCH:
-		hw_var_port_switch(adapter);
-		break;
 	case HW_VAR_INIT_RTS_RATE:
 		rtw_warn_on(1);
 		break;
diff --git a/drivers/staging/rtl8723bs/include/hal_com.h b/drivers/staging/rtl8723bs/include/hal_com.h
index 258a74076dd9..7ea9ee2b3975 100644
--- a/drivers/staging/rtl8723bs/include/hal_com.h
+++ b/drivers/staging/rtl8723bs/include/hal_com.h
@@ -134,8 +134,6 @@ s32 c2h_evt_read_88xx(struct adapter *adapter, u8 *buf);
 u8 rtw_get_mgntframe_raid(struct adapter *adapter, unsigned char network_type);
 void rtw_hal_update_sta_rate_mask(struct adapter *padapter, struct sta_info *psta);
 
-void hw_var_port_switch(struct adapter *adapter);
-
 void SetHwReg(struct adapter *padapter, u8 variable, u8 *val);
 void GetHwReg(struct adapter *padapter, u8 variable, u8 *val);
 void rtw_hal_check_rxfifo_full(struct adapter *adapter);
-- 
2.50.1


