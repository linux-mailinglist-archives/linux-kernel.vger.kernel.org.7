Return-Path: <linux-kernel+bounces-840554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB12BB4AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE80B2A3CBD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4375279346;
	Thu,  2 Oct 2025 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSwNn9Yv"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAF82765D0
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425845; cv=none; b=I2dNzxYIPJh0EVF5qq/gt4ZdVqBy5gKC/uHWxXTIk4hWzVi9S1YsucHiZ5zQ56Tldt7R3qJvvPO2HoXiBWSZYrC/xR4JtcFaZQvcXKnH5CJiiMQinpbWSxIvUXIGGoQbAPcsVwaRLquSKFMjrSdQpbIUQef5Yc+fgIdPotrXQV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425845; c=relaxed/simple;
	bh=Xq5inIJK2vQ2shTwCNZCBfAF6a8VsTm/tnUso0yKW4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V9cO+G33hlr5LpTgMhKRehmQ6nULdssl/jqZsDnliSPaFEuj7MOwAo+RnwUMU/gTBR2ukhCCCubkLiughhihqCP/Jxg1QXPwg46wZbFRwV3WxzZrkq9DCNwWTQeIaXzlgra2YQasc4gRbqTS3ng/2d/P0OoQIWJHtFxaFeMgN+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSwNn9Yv; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4e4b340f99bso10976651cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759425842; x=1760030642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQfGyuA4h2BhdbRuM3F0j8bEgiT9wVaAoWNs8W+J4yM=;
        b=WSwNn9Yvccl7RlrBHxbhFxk+33fziaiLo3eufEwzeAqqhUc32a8W8CXbawV7KsIByH
         rJiYrXDETUFTOy+bcCBMBsPC3eUzTR62LVG1IdEwSlyiP2UbTbRNsZpG0nDNAP2GUt9K
         kNrbj4vxwut979b01k/huM7/OGW5OSTZDfGApFWgz1DB+5+as5zIviklsRQN0flhULNV
         ZNKKrJf1fsZ3/pAvtZenjUaGRXSmQararf9c8kV187FNolaebKI0Ri2ifEu8iEXb3aFu
         S2wlME/FMK/2sen1AJYrPMwf3kjR+Idwv7c50mjb7OncQ2Cm1CL0FbrS1ipOMYK/5Cay
         kLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425842; x=1760030642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQfGyuA4h2BhdbRuM3F0j8bEgiT9wVaAoWNs8W+J4yM=;
        b=jDZ/QS6hseawX9ijLiKBjpqxBuyFHXW4t3WDZd67hFJeW+pOmahWCZKE6RQD4nXLu2
         UHjlIreUCjO/QDgIDyW++CInhEySm9RIga5rY/fw8mpWExf9yuTUnN30w0fa8kWwygyq
         6dvFeUvDr6hrkr74ZQ6VNuU1L8VTWwNmWLKe2QJ9W3g3MV1KdEsG60aipxBO3OeOy0vb
         DrTfVCDDyCL7fYqOA+Vyfla5BqRtTT3moJy0LJtZ6IAxSul0EPNtUaDmAiTbk3OGah47
         wJjPk3xiHSwUU+7bOaKFtoq/3/TKhT7RyHAiZulSiyzxeA0sBsw/GY+AiKwL4Fxi+0xw
         0wBw==
X-Forwarded-Encrypted: i=1; AJvYcCW8l6hjOx9d8Iiz8/cBJYPBKvl/GqgFEqCYgEHK0pvo++Pc72xBmsPzXYWEAHF9w0e4noFfL13AnWriuZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUQuQxpyORwJQ2YBHebeIPXfs3BY51OsW9y78oM8rhYo8znfkG
	z0jHfUZx56vIaH19t0FWXw21revZioKXk/2wsBJY5BWmOsV5HyjAQ9F6
X-Gm-Gg: ASbGncuO10LLhSuiajYVxMOclg/O7H18oUnu4f10UIYDq80oPwMsxRJThfy4yQ38IcR
	E1bodB+WnSH1LrwV0/WxNQxMMjOhM7Tz6woVRAVQoB/eUfSqfmZ/w/Iz2TINcE/40H67Zi9YsYU
	7D4cmYmxRZOqXSm63fAKrOB95rcO8v2sZ9ugFcyeTjJLvfnR+FOzfUyhtKeNpaegf3Viy7H0Wy5
	+rG/9jbq1ODMWB4hpvbpJ/sTXSLKO0FQ1lBiT0gyHY4CpKxDprt1VuTajHxSPTk1rg7QnMb5dF+
	JKxpSNkZgl27vXt9iHPPrxfmjBJgVYHfUic3AfOP4qKk99CKr4do8h00pkrngWzohqwmrbZ8WlX
	soTaSSnHwZ3U7yH7/d+de6hWwDhtYC6TuartmwxEXYr4GLBP19g70gOD7B2Gj7oMM+zo8c4mwiE
	4=
X-Google-Smtp-Source: AGHT+IGApgHMJg/nrekY9eF/PTEqYvnnAf1jYL5BRf5oau9AzMrpvcTid3LZDrvVzOuMkpUxqAR3sw==
X-Received: by 2002:ac8:7d0a:0:b0:4e0:b72b:7f6d with SMTP id d75a77b69052e-4e576a7df6emr1384981cf.29.1759425842128;
        Thu, 02 Oct 2025 10:24:02 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55cbd3d9fsm24504971cf.32.2025.10.02.10.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:24:01 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v4 08/16] staging: rtl8723bs: remove space before semicolon
Date: Thu,  2 Oct 2025 17:22:56 +0000
Message-Id: <20251002172304.1083601-9-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251002172304.1083601-1-vivek.balachandhar@gmail.com>
References: <20251002172304.1083601-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary space before semicolon

Drop the extra space before a semicolon to comply with kernel
coding style. This change affects a single line.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index ac313ec06587..5d31684c7cf3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2236,7 +2236,7 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 	struct	wlan_network	*cur_network = &adapter->mlmepriv.cur_network;
 
 	/*  adhoc no 802.1x */
-	pdev_network->privacy = (psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0) ;
+	pdev_network->privacy = (psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0);
 
 	pdev_network->rssi = 0;
 
-- 
2.39.5


