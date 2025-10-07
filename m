Return-Path: <linux-kernel+bounces-844013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AEBBC0D44
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E46B834D6BA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F7E2D6E5C;
	Tue,  7 Oct 2025 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcWC7FMD"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323412D7D35
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828415; cv=none; b=SUJOOjb//N4vR3j60wlrRCgAl/Tbq4QbPi/3P5FTBwh99wfLptgX9wpBREcVd06BY9pbJg/LQO9X5sX9cZLAZmn1vSQ8DkD+WmJd54jMundHwx9/Fd+Hia26DVS6AHTvuaZqmV3Y2aJPHvcgV7iaD50BqMSAMhL8mvCELLBspDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828415; c=relaxed/simple;
	bh=jkbLiLfCNgRMGiwrFTu8kZjFsk0J7OXvqhTO3tO5NXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tF/q8sv3/lco9tuzcQ/OuiplCc+0hba/2y6t6P4t4JQtdC64ZemCkK9zSZUHfNMhhWgElEyzcAefAf1+R5DcnE+ivQBcJebkMvlCSg8cqiNhHo5iGvbnQeqOlCrFtZ+gUsP04TBR78Ka5tNfX3pSj+wyZF+mgswtT1nko/wXMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcWC7FMD; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-780fc3b181aso3356022b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759828413; x=1760433213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RN9CCg/2ynTipVBwKKdllYQe5GOyUI4/kg2R9VILyuQ=;
        b=XcWC7FMDZUgicucbNP2C4HaxetmCoylTVZDEtByRkYedIVdthUrAFGtIEtXo5wA/Xw
         SHSV11vrbg59IiOIhapgR1tohivJ2m9IqJmUPLexA3Nc1ezdQxYseDFZ8IM0QpoVijYE
         YxQRiPlvXSMvEIBBo/Zsq27m5UWiNOIJMmiZo4m6pI/yATtFIzBJyOiOiZ8yCGYvEiZZ
         ffG8GdBKjI5+WzBcu4KD6FR0Z+dW7sFuolwDMylM6dOPPs27L8UjSPHu4u0BcYTxX37l
         y9OJ58aN6zR94UwHZlVKLkmzS2/XmJRp4PZB1GSdhxGWBT0iXeLTX9mRqOpaZ8MU1apT
         pr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759828413; x=1760433213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RN9CCg/2ynTipVBwKKdllYQe5GOyUI4/kg2R9VILyuQ=;
        b=UbJ7o1stPGNeyo0B0BLBWspOP7eTYfQmtwlGE2F+m04ljbkPSFhhohrst5Ddf5Yk2F
         K9lHu+HSqO1oWikiOIFpOeHniun9CV2juYBGllZwI2VsQDGVN6YEUAVGHr9CwiVTNzYy
         kvTlPjg+e1DKeN7uadJ6xUtSKubIxnE6/x1CLUUcu/PjyNdL1t+clf544v0PQem1Jkni
         UvMTz52mZFlcY5L4ZcpYPEqj7TV+eutYF+RR5e1NM1B3YFOnAvWg/poCW2xIrJ0QLFvP
         qRd/snCuKi8RbKcKr+ZzcBA+FPNKIqRqmcjwkS97mskci1DOfoGkNNfDkdTIGTfBYmXd
         W1KA==
X-Forwarded-Encrypted: i=1; AJvYcCUBMzUDfRfIhRsNFfOkrawcAuJXE6j1cjuN0+2ZyrPET9OSHqVdTigQSpD4tcFmBpB44lpQlpRdlUisD0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7JWDmlKKTmErDVXCRHaqVgy3118/5JiJgetSugeMliwJ6SZ4T
	H0HPF+YGeY3vqfEJnDcqArv2eBJQLa8gqnznuAZTp+ccbofmV+xL0vB1
X-Gm-Gg: ASbGncu1hsTfkJloRczsX+G6C47g5nrpsc9+KyAuqBe8WA/joymR78mbobaDskM9biU
	QxRAaU102cuc1qXIQgHsdty8TBU78x0DupzYxpVUiqhrlJnvNslAyG8mPEuuFFckS8GvK3ja+0j
	6/RThsVYfiQndvombQCFsMV/va7dKpRon0rxeSapfA7ZJESdn1OLBcriFY7pMcnm8C2s0RY/IdS
	KMjj8NFfmjvlVNCRNLyvLlK1s6lJh6OcCQe74EgrG331IyzHELZp1lnKA2Tct5SqxdBKGedcl36
	yGqYe/mj/vGsvL6C6tMJd0qxwfWoYREZwUKNUHPftmBEsGsyKON3JazLfv6/FSJ7ICGJhYb8YMK
	gsYDE3CPi7rHyhqZku8vfBoYVjZb5xzhfE9oRKYOAkOl6krLLu9h2jsUi4/q2
X-Google-Smtp-Source: AGHT+IEHlg7XaEwUGl2bAIFdJghjQoeR94dkaA/3M66hMtX76UtmSW2eUuCc7yY318TwiP+ey2zt6g==
X-Received: by 2002:a05:6a00:2d12:b0:781:f0a9:a38 with SMTP id d2e1a72fcca58-78c98cc2757mr19962809b3a.24.1759828413431;
        Tue, 07 Oct 2025 02:13:33 -0700 (PDT)
Received: from Deathstar.anonymous ([172.56.42.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9cda9sm14941784b3a.13.2025.10.07.02.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:13:33 -0700 (PDT)
From: Rohan Tripathi <trohan2000@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Rohan Tripathi <trohan2000@gmail.com>
Subject: [PATCH v3 3/6] staging: rtl8723bs: remove dead code in rtw_ap.c
Date: Tue,  7 Oct 2025 05:13:00 -0400
Message-ID: <20251007091303.491115-3-trohan2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251007091303.491115-1-trohan2000@gmail.com>
References: <20251007091303.491115-1-trohan2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes a commented-out assignment to
psta->dot118021XPrivacy in rtw_ap.c. The comment indicates
that the statement is no longer needed, so keeping it adds
no value.

Removing this line (and the superfluous blank line that
remained with it) improves code readability and matches
kernel coding style.

This is a cleanup only. No functional changes.

Signed-off-by: Rohan Tripathi <trohan2000@gmail.com>
---
v3: move dead code removal into a separate patch
v2: previously only realigned the commented-out line
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 4bfae77a5fa4..2faa1e14a039 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -391,8 +391,6 @@ void update_bmc_sta(struct adapter *padapter)
 
 		memset((void *)&psta->sta_stats, 0, sizeof(struct stainfo_stats));
 
-		/* psta->dot118021XPrivacy = _NO_PRIVACY_;//!!! remove it, because it has been set before this. */
-
 		/* prepare for add_RATid */
 		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->supported_rates);
 		network_type = rtw_check_network_type((u8 *)&pcur_network->supported_rates,
-- 
2.50.1


