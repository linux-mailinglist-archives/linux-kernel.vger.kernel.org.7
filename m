Return-Path: <linux-kernel+bounces-799672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7B2B42ED1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC911C234D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D01233E7;
	Thu,  4 Sep 2025 01:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P388QNwY"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1AB1DBB2E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 01:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949357; cv=none; b=Vvd3DL3zSeAQdnyM8lsqZqhHjzZkjTpUpglKc7qupecHPpDsmNS5/cJIiHDu4iRjhRiCG1cp9EHG6HVkXBSxTsIcCsowz/vl41/mE505xgSDpO6M6ero1rEMRWrHitLUC1+43xXdxWyVGfcaiH67yvgnfAzv0tgfHrnjmZGW8d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949357; c=relaxed/simple;
	bh=h1Ogs/KI+mapGEJM/7burIP1V8we40RoeBp8e9GSjc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hw9BptJf3F2jCTlIikhZoiXTSMy055r0JoyGfheVD+5oj1+XJcR8OYB5y1S2fFg7xiKcs/UHO5ex8f1HS0WKfum9UnKRnsJcEdEEDzoNush87TVtGhhEpzqndAwLHxbhbTt71DTdSyKBWUeVqk2nPSVZVqoAkOITWxAW50ndlyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P388QNwY; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b30d24f686so7053771cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 18:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756949354; x=1757554154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBZIhFsCm/lIrzVsuaOeokkxM+T+BWKeNExcKXnDrMw=;
        b=P388QNwYCqbL8BdTP6oroogMpVUCI0+Ftzd0wjbOuYrtHIE59sqhRJ5QUs4HeFPlt4
         vilnaOcRuJ88fgx3hmwyVqK4b8oCFTH0alugdOmsvdOepGqOlrG761+01ZyVLd4iEUAI
         aHv360bgd7M2GUYQiIjFjEZGVlrMB4dMA7597HP6pN68auJ4MpPFGYDqbUopwPJD7+f7
         D6Rf9vzH/ilVIfptKj+maQChUfIwhWtWVr9FYyeBscGxuqp79Cfq8mipkrxLoqXFGSmb
         UZ6GcF9XBYtm+JVHfhkEV6XXyNw0DxL9A3bbVKFYTkra+bpbzu+Zdk2UZ8p2D43nJOEd
         hwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756949354; x=1757554154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBZIhFsCm/lIrzVsuaOeokkxM+T+BWKeNExcKXnDrMw=;
        b=LJ22cMK6FcTQSnqXnBS6/8XyYWb0qFfZTbdtmooke/5XntiJydWPQV3QjRuGcE+LOh
         xiSJYJ86n9Mc9kItTZw9c9JxKIjgN1VhYJ9j/xTl8j+lajG/PkAQumZ4FScfT/7abf/a
         6TuLT+gpCDuy7kkKuHx1NJuiF0OptMXg5xjIDfWGakPVSdeAT3rNl0ek5CRcpcR+k/fM
         xQiQNet6/pmuquP/Mx2ogsuWoFiyOKty92H6f3tKPI5PYSo7P3iL/HDJpoYaU2j4A9J9
         FPNR/T9suGTED17t81DyJar3gNW/6Da6tyWmFAFRBgnKHY0yLm3ui6eFeJHY4AzaQV1Q
         aBog==
X-Forwarded-Encrypted: i=1; AJvYcCVSAuzjQFjn0Ng1Yez5iCZ/Udq7uVaDTHwxpU23C/0KhccBYKfqVGOR+60qqSBmXffK6+r4SyKdXpKQ6cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY/M3RaRcfkY9wJLFkj9Qd8KxPkyxUzdeL/F72m/oYZLXXwvXx
	odkRc48WwOx6N75t4Ix0LXFyrcfHzthDOAqQPfO+xwtE4XO+QeXMdfxh
X-Gm-Gg: ASbGncv+9ofx1s3jI/wC9W56lW3clnVpmE24siq532hszJHGWR0TokCIr794HlJPdhG
	/6mI9BKHtah/FPOUc+vdAJ892GGZew/OZaXPqT/WAq28XuWuSy13jJ1lLW+betgOhU5dDhgQVpH
	xSkgaJTRIOTYXzVtkakKtojBN8IRQcTg9TWBhM0UlVf/rGitVZ6821ik/emmFIz6zSLSAA/ZTYl
	qWiFKDvfnCpyAD2AG9K9z2NU4IUJp+TDYbPAMLTd7rfiMhtvrNCkIk+yHPoH2a8iLNaE6Ax3hQf
	HeXg9pVi2xHRG9BYAYnrBRVAIZTUKygc7R4vzECDXGLDv+6Muiu7n03hXMjRoUtk7UmsjlWzxri
	ji/NprO9m4bxWhtBRbjIchk54+tTM62yfQIxvSTx5IABNxd7ZOzg=
X-Google-Smtp-Source: AGHT+IGQNXKXRNa/56XxhtdOFgify33huflAjGqtq07eZh2LuQ4YgOzu3PQlAQxhklpwBmRzOY+0yA==
X-Received: by 2002:ac8:5805:0:b0:4ab:6bd2:e25 with SMTP id d75a77b69052e-4b31d842179mr202769561cf.25.1756949353760;
        Wed, 03 Sep 2025 18:29:13 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f78757fsm20378921cf.43.2025.09.03.18.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 18:29:13 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH 11/16] staging: rtl8723bs: remove unnecessary parentheses in conditional
Date: Thu,  4 Sep 2025 01:28:54 +0000
Message-Id: <20250904012859.215565-2-vivek.balachandhar@gmail.com>
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

Remove redundant parentheses from a function in an if-condition.

These parentheses are not required and violate the kernel coding style.
Dropping them simplifies the expression without changing its logic.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 050fc54e251b..ef9057456768 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -730,7 +730,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 	rtw_set_signal_stat_timer(&adapter->recvpriv);
 
 	if (pmlmepriv->to_join) {
-		if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
+		if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED) == false) {
 				set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 
-- 
2.39.5


