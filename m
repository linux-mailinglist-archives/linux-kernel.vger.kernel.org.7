Return-Path: <linux-kernel+bounces-744850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30879B11192
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA3B1CE58D0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E742D8795;
	Thu, 24 Jul 2025 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWntaSPC"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335A3255F59
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385139; cv=none; b=r5oRyunEAIXujHLolvWUx2sCvehSvzOK7zHR0CZZViPxkqsHwbcxvBfDOxrxJWF3GyQ8dTt2pXHpGSzyEKoTfp6sdpwDmMYKSDld9XA2QsXTW+eP7iPi5Um9W/qIlpnz44BIH1sVyU6pqYI/O1DFtHzeu+7hOVSbHO0iJ1fWEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385139; c=relaxed/simple;
	bh=Wl/MVrfadxWCvbcWuLboGbrjuXmRyvy0BBIFUzsNgX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQC2jz8cBoONUGzN3WsyNUORdwXVgUHERNTlzjUqi8QMvDlRV9wTm7qMRNYz9jRx6b90EAuJWyBxHHCnURA6MpfnEyGpM40rr/l2Qg15Fdi3mTjQnZP7Fitvi4FGm6YkCYAcdB8fOow/85uzC1RegpkJmKE+X3WEzLs+7dwOQwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWntaSPC; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-612a338aed8so2277162a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753385136; x=1753989936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjrrUXAL6KpzkIM6/6atzGF3H/f1YResH0MiZx9rdi0=;
        b=GWntaSPCwkJTqg/D8rfptFR5azHnSkPcI7dlSDKhqs3XtYyhRVoDzFSlgvlnccI7uJ
         nIyV9gTXkoZklhhEBLry40xBEJyzDfxynu+WRNYZJmchXdMJVM4vJgIhm/RjBCl4dAQD
         XLZB1bNIDZ9Rvv5zobSQJjxyYWwVhDBQsCHeaFnNiR4iNNI33tspikmpckwhJNTrmDSN
         J7qeHgW5gQimX4xCWuFEeqxb9pVEyFgh8eoEHomsAe/waCGlieyyiX/klr3UtQjJVWDR
         c3Tz5/w7VDEK4aYcQL7GpXeWm4zvlrqTEG6Phy997TVlG7dBh0H7f9Yzpvj+zroyLd4q
         TJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753385136; x=1753989936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjrrUXAL6KpzkIM6/6atzGF3H/f1YResH0MiZx9rdi0=;
        b=vR3stHJHTUbS7GSVrPg9G50uyEfBZnb2XBOVi+wSbP91JvomZxIcGtJB/9Z9tycBjW
         mZQ0AA+7EBlXhk6hehM9QvoFZO3pzkMIwOx5JJufQYHB4GUGQg8+LgNAM4w/c5I+2oal
         bHF0ROPXWlyCNxATdMQBsuwXNFWBl6RwoDXdBm2uvtq0NEFoJ+j1r2l2Cq++4Va8Janx
         bCgW6nSqTBK7GpXVMUbQ3mM4lDidlrH/hMPWJg+GnSo8RuSqDe9VhUGTcVp0Lx/Uw2ng
         wkyXQktfSvxpltEupyTs3U6d+8wLSvdCBm/D63wJixuAUKcJJ7eFq5k09PeNVSmfFWwI
         c6+A==
X-Forwarded-Encrypted: i=1; AJvYcCVMyoB/zDI9FQcSxT1SN1c/+50I1skAclwGZ7vUlHYwejO5vDaAoUZtQKLWMSsiWtEA/l0C9L/DaQrPVJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPVJIq6cicAVQ9K30aP9SDeOnwUCx2f05Cwjon4vPGEeU94WHG
	JbxSUMP7WhN2WmiKe3iJ15QrgpsrCJF07oFN03IhECli7PZWdUetGuJUvVRutQ==
X-Gm-Gg: ASbGncuZD/HjGycSRbl8RM807hdzw7fuAqQbE7Gbbnyy0k37btFgCivP4AXDQgOVJuM
	oPAwADkhbCBokeztF3PdDnLo8i4QdARnkvV55RyLCvryq/pYXuFqVmm9f5oTznTvJ4ickAOqLaL
	IW63KaMCH+y86TTC4ojgIu/x8iB87NmhS+rZ2HPfSfP3n0Ch2k3EjBzWFLmMKFOLga2fWKv47QT
	ku8PKRZLLWEX2XqUP6VqhhXsk+jj2PAuza63f8YQuebMSegjdZCRqyWZgAoldTf7xZin2CkQtwG
	fsynZGQG3Tw6p79o1hIpFr/lcsfNV+SeUmKjS2cCfWNGGdJMzDDPcMMx6gUwg1a+YxRq375ibtZ
	FL2jcQTZBAuDMljoVL9mQ0oU5ps2qr+E3fkL59PQx5B4C/aKJfsp7Ybxe1/3Mh8nzVDYOpT4=
X-Google-Smtp-Source: AGHT+IGpDpA0dhJqXY/Tehkc7V+fIch+YiSFQkfTHsR0tFK0ny2Wg+uQEfflS7ZcZmimB33UjNYdWg==
X-Received: by 2002:a05:6402:5208:b0:601:ad95:ca6d with SMTP id 4fb4d7f45d1cf-6149b42e234mr7715676a12.8.1753385135711;
        Thu, 24 Jul 2025 12:25:35 -0700 (PDT)
Received: from PC01.localdomain (094190205166.static.ipv4.heldenvannu.net. [94.190.205.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614cd0d335csm1199556a12.10.2025.07.24.12.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 12:25:35 -0700 (PDT)
From: Bruce Qin <bqn9090@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bqn9090@gmail.com
Subject: [PATCH v2] staging: rtl8723bs: fix if-statement alignment and line continuation in rtw_ap.c
Date: Thu, 24 Jul 2025 21:25:33 +0200
Message-ID: <20250724192533.21141-1-bqn9090@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025072409-promoter-shame-8105@gregkh>
References: <2025072409-promoter-shame-8105@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes several style issues in a multiline if-statement:

- Moved '&&' to the end of the previous line to follow logical continuation style
- Fixed indentation to align with the opening parenthesis of the expression
- Avoided ending a line with an open parenthesis '('
- Moved closing ')' to the end of the last expression line (as suggested by the maintainer)

These changes improve readability and conform to Linux kernel coding conventions.
No functional changes.

Signed-off-by: Bruce Qin <bqn9090@gmail.com>
---
Changes in v2:
- Moved closing ')' to the previous line as suggested by Greg Kroah-Hartman.
- Thanks for the review and feedback!

 drivers/staging/rtl8723bs/core/rtw_ap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 383a6f7c06f4..c652e0cd35f3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -258,11 +258,9 @@ void expire_timeout_chk(struct adapter *padapter)
 		} else {
 			/* TODO: Aging mechanism to digest frames in sleep_q to */
 			/* avoid running out of xmitframe */
-			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt)
-				&& padapter->xmitpriv.free_xmitframe_cnt < ((
-					NR_XMITFRAME / pstapriv->asoc_list_cnt
-				) / 2)
-			)
+			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt) &&
+			    padapter->xmitpriv.free_xmitframe_cnt <
+					((NR_XMITFRAME / pstapriv->asoc_list_cnt) / 2))
 				wakeup_sta_to_xmit(padapter, psta);
 		}
 	}
-- 
2.43.0


