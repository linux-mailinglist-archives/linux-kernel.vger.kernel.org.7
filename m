Return-Path: <linux-kernel+bounces-732383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9DEB065FB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E194A7AB2D3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6612C158C;
	Tue, 15 Jul 2025 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQfJk7Gg"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F552BE657
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752604117; cv=none; b=QwvgPHNnam2gkmwKKMwJH47yw5M2Tuv87yqNVe6gYsVPBilmZ/omChqXjNFtPSx154FUTIXM8m3+0NEnIe1KUAThfJliVpkX+NaM4UZwBgfM8yjkbW4uYWwPGrQakFMG99pFBZRdp67YMaoMij/u2xtsLW+b/Q0BGAJ2SywZ4V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752604117; c=relaxed/simple;
	bh=TkTC7lCUvRX5IgkEtTiK0ajKdF5IVeXDZfOY0NHXRgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCA6vV1/fYzvJWjG22BTHEvfzeNzF1cyCdvpIfOlrKj02tifMTQvak0nBd349T07s/4cKP+36NGR2c/GDIzDyb7i0YHmaCzLuQaM7mGD+JQylwLj8BT5jCLgaPemJicedimawDXKbeLKUZzTkuAmAmOqKmKlpNvtGG00AEJPstk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQfJk7Gg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae3a604b43bso959923866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752604113; x=1753208913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYbT1bwVU7Da+KtvSfr27h+1VS/LPzjDzfer1EdRGO8=;
        b=kQfJk7Gg2Hd/Le30KGMZVRQXyd3fZEm5qg8jYyRkpQfviCaoRz/IhpZSDEINeMC1LN
         VlEgFJaseA6GS1SUn/Ls7peHGXIwGKwd1V5XTT3Rs2C/vVapvs69JbTe07UM/xbmsFjT
         Oo9j5W8pro0EsJ6n+5D0MhqmQmRR9a0/Y090qgUAAmULbNcx53dD6I6XmAtbX4ol0Oft
         s97Ap+MVqMhQc2IIRZwbcE4l3F2Asxo16L+Yb1HmVZ/+GACQZuRZUY+5P/5cXlABfWz4
         D4ByKi+KnKi1DLpFSXO9kfCd5BFiSKqy5+W/eHr4ikoNzDQz6+om2YEBimgd6FYRdnH3
         9LDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752604113; x=1753208913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYbT1bwVU7Da+KtvSfr27h+1VS/LPzjDzfer1EdRGO8=;
        b=Rt7yA3XaIl4B6SiH5WD359aERXRKFxMnrTtkrnfQEoF69jbptpsFl8s3mcW2r8ZfBG
         YHbvAXGijCMUtuxYy4hnjF8myFj1k439YkUD5LhZYk17DoEMLb45Ov2PbT3GMVnqS5UV
         LrJ6nmrZeHAVGbhdE9rhUeE5P8owMSNHWW6oqprg/hZZU0YxSVOfx9gs4Bri4zPum0gg
         MS/SahvNUw85XH5CznR55KDdfz1oyiMIMI9bQcpWDyTBhGjtwTClRvdPkPA4di6OTHXW
         7jyYW5NkS3UVimEZCDzx1dpuQ0gQcngCyDiUvWh7hkkNtp566rSh6QzcEFUk6+rQpuRe
         thpA==
X-Forwarded-Encrypted: i=1; AJvYcCUk1BnM+0QDC0TkDa4ozjbsDAdJKmAEEkQEPQ9KfnpC7ySeLmC1TOFwiIRu44WQvMuN5VgyvhQ4Ipu8bIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD1imdm9iktz9H7LJeb3MwoGcXWnMSCtSgJYeJEmyMXkA1uwZg
	eBR8YabTbMxDUlVy+uMzd/vLxBHyePLL+qyihM3c/cDL0K3U8JAUpdcfHQhX/w==
X-Gm-Gg: ASbGncvwJhjOOZEZFUEaWq7ecXUCZzC2HJEFrsz1MSAbUNfM0eYitniN3ico8CSlwvp
	NBSgjhb+/kRoXELII0+LbJyWxVGZ5pRGEsH8cO6c2Usnl3zx7hLkNY6zzxaAUvXnBvlPACtjXfl
	VPT2u5ijO93npeVoXWwASYP6ZpuidFsOaugel1CWu0ClXJiY8dVxRbeTwf5pQ2Ix/O94SKwGYGt
	Qzs+JB22EVH/FGECX3m9fgro8kkwPRtyWo5KLsBIGcBumbRiQX1bcHvU/Uhw6/m1l6aAXG0wOB6
	2XamvM6xXIfrA8bQ/JekLuFH2YBtAgizXc+kh39Uc00MDG/iXJA2IsbWDhJOgwYjTj52s9dNiVM
	QF/8tNGEkQ/cc4+rIMGzn6TA=
X-Google-Smtp-Source: AGHT+IHiJmMishS1JlRphNJ1dh63va8CNcqSMl2t6OQ3Cn0fUOgu4FZP9pQmC92BBIpVMpMDJ9Wqug==
X-Received: by 2002:a17:907:3d89:b0:ae9:c494:1ade with SMTP id a640c23a62f3a-ae9c9bd76d6mr47022266b.53.1752604113403;
        Tue, 15 Jul 2025 11:28:33 -0700 (PDT)
Received: from tumbleweed ([95.90.185.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df2fbsm1039562766b.158.2025.07.15.11.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:28:33 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 06/11] staging: rtl8723bs: remove function pointer fill_h2c_cmd
Date: Tue, 15 Jul 2025 20:28:09 +0200
Message-ID: <20250715182814.212708-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715182814.212708-1-straube.linux@gmail.com>
References: <20250715182814.212708-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove function pointer fill_h2c_cmd and use FillH2CCmd8723B directly
to reduce code complexity.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 7 +------
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 2 --
 drivers/staging/rtl8723bs/include/hal_intf.h      | 2 --
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index beb4272a0992..d9791027a2f5 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -346,10 +346,5 @@ s32 rtw_hal_macid_wakeup(struct adapter *padapter, u32 macid)
 
 s32 rtw_hal_fill_h2c_cmd(struct adapter *padapter, u8 ElementID, u32 CmdLen, u8 *pCmdBuffer)
 {
-	s32 ret = _FAIL;
-
-	if (padapter->HalFunc.fill_h2c_cmd)
-		ret = padapter->HalFunc.fill_h2c_cmd(padapter, ElementID, CmdLen, pCmdBuffer);
-
-	return ret;
+	return FillH2CCmd8723B(padapter, ElementID, CmdLen, pCmdBuffer);
 }
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 10224d096886..c6fda239d020 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1318,8 +1318,6 @@ void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->xmit_thread_handler = &hal_xmit_handler;
 
 	pHalFunc->c2h_id_filter_ccx = c2h_id_filter_ccx_8723b;
-
-	pHalFunc->fill_h2c_cmd = &FillH2CCmd8723B;
 }
 
 void rtl8723b_InitAntenna_Selection(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 64f5d7b58258..7b634180c6c0 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -164,8 +164,6 @@ struct hal_ops {
 	s32 (*xmit_thread_handler)(struct adapter *padapter);
 	void (*hal_reset_security_engine)(struct adapter *adapter);
 	c2h_id_filter c2h_id_filter_ccx;
-
-	s32 (*fill_h2c_cmd)(struct adapter *, u8 ElementID, u32 CmdLen, u8 *pCmdBuffer);
 };
 
 #define RF_CHANGE_BY_INIT	0
-- 
2.50.1


