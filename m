Return-Path: <linux-kernel+bounces-732382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DC3B065FD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C34188D701
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79932C1586;
	Tue, 15 Jul 2025 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjTKc9g9"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4BC2BE640
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752604116; cv=none; b=NXQxQA2hex7fC99GvCFMo29TI64puaopAYXQkVNKdBFxuxLhjJMHlP7adK1wTS3tMNYCLa5zAVxTPdhMoIKmrfc2PKqzhYTQCmYopgbxOiibm9XIpad9NsSFGdFsm82wjz3f0yCZovzOqwon5kn1ZelyY+nuF/b5eppM55qA4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752604116; c=relaxed/simple;
	bh=2gMWcrlVP/2PMkXpsqACwdxWoRmVnHNKMopuvTPlXyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4/7wSa7dSsWdFWQl+KPZ42jhRU6VyfuqSTQW1ZbEb7/kKTw1N+CoLXDhJAH8XzH/EDFNXuUmOFfirW0V7EPKSG44//4XcY/zH7wCFf7grRanVeddeUdBg88pX4NeXzNlFzU3z3QCvae6iwuqurnoOk7Xc8Xdtc1o63aVxk7SLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjTKc9g9; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae35f36da9dso1185519166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752604113; x=1753208913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoAgfdpj6XWO6IsqKcPBce5kLl9KKg9mYA8xl0WEpR4=;
        b=hjTKc9g9St0gXRX1P4WxAeICcK4z0Eb7/422Tlu+VgKFAKhDQCnp3bZycxF/YwTVzG
         7dGyNJeFBJEPtP440EJAsgks/1yGWRdgrCUTMlcl1CGpBphxm/Zk7RwkoAUuFsHa6PYd
         on8qWbpO+LuVHgPHwKz4RpmSxnmGjc+RrKoaxKRx2xw5ImQnz+94xQiRN+lnuLMyL9tP
         gYeohOdh31NXsFKccLmVAXJFX8jbPDv3P/6LLA+dDD/RDoYuaVIl6hvnQGb04TN+y12a
         0m06XM7rcrchGQ5Y+yWIjIgXHVe5JeDEqhuQWE5etIqNZRduB/UneiA55BnBVtUQNAG3
         KsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752604113; x=1753208913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoAgfdpj6XWO6IsqKcPBce5kLl9KKg9mYA8xl0WEpR4=;
        b=f9TvKOig6MrUaFToydpWWxdg/I1f0M5cFfiPGvCadnRo1k6m3yUsD2nxtmPL2+PjoS
         ulomYMZD9rO4PoxtFWMgIOKh8nnb5H6FNdx3IMtK2Aig8p45b2IF9B98GNsCKLkUmIWJ
         R7Xh4YDSj9fnm7AGxxqFIfQ13Bqcpq8ULGTRV0A9Kw2t4m+3+xsKfzXEwuJCD/px/x+/
         WU6kXPefMzSnUI8fifrCrfeUlXl/kd08xrfkSKrhKv+OGYMwsIJ+Uz40AiEqnyQz/+Bc
         8zD/PBRjP1hKw1tnxFn9g+1j80qQseUTf7LUHpkVofixd5F+bHTomE3NPUSJY/9AAUx5
         Gvkg==
X-Forwarded-Encrypted: i=1; AJvYcCXI8uDCFwghE00EalHf0i/UYZj3dsdsMkoV2RyBQ5AWky4eSheLYcJElVmitU9ZpXCXFBiQSgEUGwS6xRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YziyVXC8OkyO27QJMglPfts0v10Ns8OI/grIXnO5dPVc4Q9NEIv
	Y9A5NnboCPnmz5R0+OMdbZC1sT3owXcZqXUj4wxbcekG1sVVbQjGA0Q3
X-Gm-Gg: ASbGncuG1j/N/7Y2wvcFUBSGwtQspaolcPgmJFfBPw4DYO+24l/tcKOjW+qvNp3YC4J
	W5CkSQCujXALUY41eOcJ4JkEd1HW7lqZGWgOHR+q/NvnM65QQ1H53JxH0nHwJMIfTNGrttXzrD+
	rAethlEzfBswsTwfHw6m3e03anfEzZO0ZVjywVg4uTBgqIcR6nm1HvEaNX6igFZDSVDnrDfRNQx
	sU5SEa7MELr1Fw0et3h8WhXl1Z7GMKG3DM98hTMUhLQAhjSgbol4qwbGCLK5IsrK1C70bm3VqTE
	HbU+TJL98wptnggtzIwHLZe64e/GaQLngpUVJeUcfIBWU0HiYT7BWYR7gi02COGco/SiYIx5UsB
	fzdS2+Ql2kknXJScezQmFw4o=
X-Google-Smtp-Source: AGHT+IFsjvBQY2CWoei5kxCeOEhLCE17FpzwXWJjBu67npFD0/1jEC5cSYFcoBr7I2N3ku2dsXkAkA==
X-Received: by 2002:a17:906:7308:b0:ae0:5137:fc44 with SMTP id a640c23a62f3a-ae9c99957d9mr62812666b.18.1752604112768;
        Tue, 15 Jul 2025 11:28:32 -0700 (PDT)
Received: from tumbleweed ([95.90.185.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df2fbsm1039562766b.158.2025.07.15.11.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:28:32 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 05/11] staging: rtl8723bs: remove macro FillH2CCmd
Date: Tue, 15 Jul 2025 20:28:08 +0200
Message-ID: <20250715182814.212708-6-straube.linux@gmail.com>
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

The macro FillH2CCmd is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtl8723b_cmd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_cmd.h b/drivers/staging/rtl8723bs/include/rtl8723b_cmd.h
index dbcf01bbf051..0665c4955936 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_cmd.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_cmd.h
@@ -181,5 +181,4 @@ void rtl8723b_set_FwPwrModeInIPS_cmd(struct adapter *padapter, u8 cmd_param);
 
 s32 FillH2CCmd8723B(struct adapter *padapter, u8 ElementID, u32 CmdLen, u8 *pCmdBuffer);
 
-#define FillH2CCmd FillH2CCmd8723B
 #endif
-- 
2.50.1


