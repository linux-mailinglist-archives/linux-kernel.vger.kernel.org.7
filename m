Return-Path: <linux-kernel+bounces-799676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C53B42ED5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBBE3A8016
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8A61DC988;
	Thu,  4 Sep 2025 01:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ace44Z95"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927891F1527
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 01:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949365; cv=none; b=RzFMmC6cgbNYwPM+ist08YwMrGvq6cp/+rnASy1qppDxGBAw1+wTumHN7w/7IRFNkG7U7rnZGj1YwW/9Ffx+7o9grajHCVRUMeTp9C5uEXvs7rxn/+W6w391gYUVymkU8yDE/our42GTiXKtgmYrWCos80zCyt1M7Izf2k5xYvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949365; c=relaxed/simple;
	bh=jBqMxmVAmMDEYYiw51Q/Ns7mTaKe1/YemzM5cwPGyQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RUf8FMxSrjKJslcNVyqBm13NRrNqsBWv3fL7rfDmg1GVR70nZuJOAr6Ft7NX6djzbZKAlV6+uAX9uBKVgNaAoMLViDRggKFGgE3xQJ3YgPl+b+g5udzUGIN3rxQh1eGgihjZsrynC+on8ErAbtMP9MnRwAh3IrTpZadZ0X8FkBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ace44Z95; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b338d7a540so7859831cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 18:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756949362; x=1757554162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z93vsxuF9UuLH4nsNHNXy3fXQ+B/Eo/YGql6jpQcpLE=;
        b=ace44Z95Kod2i+0bFA7BLEHCgG+bw6s2zw6jg+1lhaAFPPQMf8rCfE/koGvxx+xbJt
         cLdx10KoiXZLcvpazxx9Q39EUVg5STikBhB/kATybARqikV7Kf57cQSXfADLet5M0pLo
         zSqqxSwDv0kA8VzduEOTQ9YQ/0AqDQov4wOMc60/gCV8UfWZNc8whpsxtVWvM9G1UB3g
         ekbQsumWqmA1oo+Vvk8x8CjIquAEKRs3tuP/yIAzwaiDagiKBUo0dMVF9fDWuiH1pEup
         wgRWgqJeuqNMRu71csqbI/QNaYRXGERyenqC5YhHZkXBjNg7ezCIw5FDPuebtWAc0Ot4
         TjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756949362; x=1757554162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z93vsxuF9UuLH4nsNHNXy3fXQ+B/Eo/YGql6jpQcpLE=;
        b=DmYpyjC3YMSMTdnDDxL7bXEdA955oper/4ei1psW9TJRfsj/ErU7wZ/bo75Pzctwj0
         j9xDXzMsDNO+knHjfxttvQuwQubrfs6HcFMvjtFMXH0Cw219RiHw4G9OQ2kmTLQ3B83Y
         GNnBfgg6/kF9SibVZJwvhuUvpDdOPPm9FkB8ivbwTonNckoRpv4gKT0VT+9hqQgiz4ii
         b9gBVm8gHxPwoM62oVv3iZBvbUoRRC7TeM4SW9IN/oGZfPIJ4NRvwie5fODx/4c8sQWV
         zyXvOWJCrrg2u3kMa29oUQIPNKz+INssKwpkOoYqNIdwb9NzL5eSajcFr7bpz+CPiYG9
         cqWA==
X-Forwarded-Encrypted: i=1; AJvYcCXB31Uqln06w4Qv+blUaFFsmZPOoKSdchb9nGGqY+7FzLMsngT73annqWAavERhKC/v743lDLkgmJYRc7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8+CMyZDev3lEo26aZ1Wjf2k5kXnefkYS/skUdd4rsWKHU4tQk
	EqLonTSgChZX5weFcI4g+kgtVuVM0CdE5yixabFGOtl6BUUsgxSe97Ba
X-Gm-Gg: ASbGnctgzv0afHgPSGvOLdF7TUPGR5Q1bG/OCT4wtwdlFN0q9zFGHjkQCN+l6y6aXEv
	Nbqe0s3fS3PZWeGC0/HsxsA0mTtbD2OFDCn5SIh2bMojI4LogCZFwd3Vff4LT4658CSKX8z9UCq
	ogWQtQ2NfYIEeiQg2MiK3v9ivNS/yjYk7b0/IW6TMOTFvz5QjJf0lGPstMYZTI0NdQrZBl3UGD+
	7i6b7a/mPZrL0kXOlH0yIrEdZVzKazt9RyLAPdtKY8hSOwjD3xaQwgoZuwI3AUnvlGrDphlg6Ha
	pVvDZDiDDMSPyHrbmsyzi+v3JOYJXA8PXe/fvMNa44F0GPSij5jolGiB+6v/e8RqO8vWm77sSmL
	ZKgPt1K0yWc+lLgKojavik+r8wxWVLCkqAjXd8t+tRLTV/XJIx/M=
X-Google-Smtp-Source: AGHT+IHL5ISs3lk4VpTxVz+4/orKOhI5WA6KtKgm+/luS+ccrNNMAmM8TBZY7qkiFR7fdyCfE31c0A==
X-Received: by 2002:a05:620a:29cc:b0:7e8:23c1:f472 with SMTP id af79cd13be357-7ff26eab1ccmr1820662885a.3.1756949362372;
        Wed, 03 Sep 2025 18:29:22 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f78757fsm20378921cf.43.2025.09.03.18.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 18:29:22 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH 15/16] staging: rtl8723bs: place constant on right side of comparison
Date: Thu,  4 Sep 2025 01:28:58 +0000
Message-Id: <20250904012859.215565-6-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904012859.215565-1-vivek.balachandhar@gmail.com>
References: <20250904012859.215565-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorder comparison to place the constant on the right side, in
conformance with kernel coding style.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 2c34b68f1d60..80b4dd1e8353 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -775,9 +775,10 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			} else {
 				if (rtw_to_roam(adapter) != 0) {
 					if (rtw_dec_to_roam(adapter) == 0 ||
-					    _SUCCESS != rtw_sitesurvey_cmd(adapter,
-								&pmlmepriv->assoc_ssid, 1, NULL, 0)
-					) {
+					    rtw_sitesurvey_cmd(adapter,
+							       &pmlmepriv->assoc_ssid,
+							       1,
+							       NULL, 0) != _SUCCESS) {
 						rtw_set_to_roam(adapter, 0);
 						rtw_free_assoc_resources(adapter, 1);
 						rtw_indicate_disconnect(adapter);
-- 
2.39.5


