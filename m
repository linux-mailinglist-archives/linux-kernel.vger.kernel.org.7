Return-Path: <linux-kernel+bounces-746625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAB5B128FF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 121727B92C0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF4C20E715;
	Sat, 26 Jul 2025 04:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atOiWBta"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156F720C469
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 04:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753504456; cv=none; b=nc8lKMwXN7guBAHpMCoEcDxZ+mDAFm+Lr+aKSWiY8oLlcniZWm0o++C3AskhFR0QK9LC9+6wPhnTab1aXOr1KSJboxjL8fwNxPuO2GNXnv7BAj29+tJKgPdzIdwwNiXCuIn0Hy6JZ6+R0uDs8ifMLY1gPm8KA+4n8sqHcIz4S3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753504456; c=relaxed/simple;
	bh=A9D78ix7GLbEAqRACr7Ln9fr5ydJNxAa+ETZFuRoLY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QTogfMZpJNi4gcSdQqGwRxh+xEx+gmWiRI1EbIyJpwkK+4moJnjjr62mqMeVby5AAP9v7NSMnaInnrxZ/457mniZdXl+I3X0GeEKlXmL4+tK0eUqgvCGpu7XqZ3L5WCfEd1Xb0q974l8UHgMyfmxhiwGZETbXEd/LXg/1qDMRQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atOiWBta; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e344e0212eso242165985a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753504454; x=1754109254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E73v83Bn/ceqqEKIqnNpd+kYBPLgkp0XI+V5cR5WrdY=;
        b=atOiWBtaI1VAESD/nB02wS8rG1K2Ry0Bi7TwZdAtXw2hfYvVx+ZmkULhDatwwD9YFH
         4lKSVxm790CHAs6bVBHsdsEclcwD13TPk+wlY0525VY3BSS8amC26nEiPnU0fl/VsQZJ
         QX8T5kzsdnGHop6nZd0x6ZQKnUM4P6iCSd0svgF7NJnBBXBleCvdfPq2ACnLDylUaut4
         bg6IJ1ESUj/JgGzQ5sFabd97swt0njGZsqi/slnbRuaPf37AREA9USuGEim1ir+UvH2P
         cfyjSGHUxx8nnS10VfGcpXK5ZQf523+GlodayzNoMPoma+DASyB5/tfG+ugENFEGrnWr
         XXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753504454; x=1754109254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E73v83Bn/ceqqEKIqnNpd+kYBPLgkp0XI+V5cR5WrdY=;
        b=bA4DwQbWKzZhrbymNd7UtsbStPpIcm63osJe8GDJ9/h6p0UOGIEYAtQvwg7ScxIivd
         itUAwbgEWAnGW9cCzZ2q2Nfz+5GX7n+uKWbcN5S7p09o0B8Ha+mWoY11OMF7xBJfxUFK
         gL5P4ogzxMulmukrXjOWDlvAzAvSK4yZOY7LeHPB8IyNFRI43ZJGxy/ubBZjtMCnE7U5
         9GFE6RFd2M3QAf227raVi5ZXW2a40yExUtNT3PpWGf8OY4eDCUdN53vVnEaDJClyFbpC
         wkSdaNBx26UdLTTTEFJp+5Homkp5REY3ozWLL1UQ5QvNR5xzrh9ipH25X0IrB510By3l
         tiHA==
X-Forwarded-Encrypted: i=1; AJvYcCXMSFDiurp51hUHtsBP4JDWgmyhKxcuSxf6pKj+OdkBXHGETKdN53yGVlFBPb9ZzJ7xOTnkUNoVuYH7z98=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKPedrvuAptKfQ6ctOHxQyolmubaAmniVA57MQp367bwYpipVI
	SirDPfut/SCXjXky78y673TpsU6ng0Gz3g79EBAiU+QZMh1icvNFK4bH6kYg+g==
X-Gm-Gg: ASbGnctVjVhh4Ep/Zn0nmbTuYDNVyB/CV4yK5ZXK8F8Gd/VZ3Y1TMAp9ItIH6Xb3gC7
	m5rNMZJ6Gbng24ukaVqvK1AkSMcoqJ14WXp5TV7QbxjVhOLhGQCKyUMQ/AWH87v3QoRfUGhgTMh
	SfZexS6KbtGzbP6hJY2mQk2W0yFtsdJrxyw415jSyq6Ize9foQhiAH76sBt1TgA5NOHHaorji1O
	fI9OS5tMBvkXg3VMMV3YP6TXyNecCGRz5AaH3nYAwNLN5Ls0aIFDpucQydRMrbwpzBecBnpZxsX
	TwmS3EINb2+hnnVtc5bZ5O2kXgaBjJMosML2C/7OgY43IC5NqfZEylemtxn8y9Z1rAUBkcIQ8JA
	nrB7rkmNginMw7chbNpaWnsmOSvrZwFkUzW89va566rNbVmj0+ifCXveoRsMmIg==
X-Google-Smtp-Source: AGHT+IHHjE/vicHbTmy5H0DfyQviy6c6NHPxVnv7m9s0aAmGt/gwdfRLBiwM4RPsHvsWk2OBieK+aw==
X-Received: by 2002:a05:620a:1905:b0:7e0:e2d7:e03 with SMTP id af79cd13be357-7e63ba6f332mr530200085a.7.1753504453916;
        Fri, 25 Jul 2025 21:34:13 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432a885asm70322185a.36.2025.07.25.21.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 21:34:13 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH 19/20] staging: rtl8723bs: place constant on right side of comparison
Date: Sat, 26 Jul 2025 04:32:17 +0000
Message-Id: <20250726043218.386738-20-vivek.balachandhar@gmail.com>
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

Placed constant on right side of comparison in one instance to conform
to kernel coding style. No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index ecb7b3823010..dbaaa2357ee5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -746,11 +746,10 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			} else {
 				if (rtw_to_roam(adapter) != 0) {
 					if (rtw_dec_to_roam(adapter) == 0 ||
-					    _SUCCESS != rtw_sitesurvey_cmd(adapter,
-									   &pmlmepriv->assoc_ssid,
-									   1,
-									   NULL, 0)
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


