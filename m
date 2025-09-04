Return-Path: <linux-kernel+bounces-799732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F02B42F99
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7831C23A62
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E99242D65;
	Thu,  4 Sep 2025 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwUnPQj4"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF16220F48
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952120; cv=none; b=BAGUlnPQ8jzrSNgBtOzTkw/5BY3/QMEakIFMxDzZBTwRbaYYE2IMpK7WfQZBz1320/FgDwsy5KgczbCUewVCUXm69NvCvK2HjRlf98mvGDqAgmeeeWJSvx/OLwCRGIQQw/pHrHgThmpPMrqX5mZ0Fb9Csv7xyAwEsWD+8Vhy5l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952120; c=relaxed/simple;
	bh=h1Ogs/KI+mapGEJM/7burIP1V8we40RoeBp8e9GSjc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PuN5fsJO6bD4e0hzeVa+Dm2Pzt6+LIBhkbb7sZ8lGA2VCQ1zNRU2ep3ObHxOhIyeI6eCB6NzhAMjmmvNGDPJvC3fBuuP2mopfGQlY1A84ZdnmO6Gbnhl6hasG4lyIoCyMGeR9rr+bLG/9FyCHefdyGZOnC5hD0bh8rNgLCT9Lo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwUnPQj4; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-7291d89185fso697306d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756952116; x=1757556916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBZIhFsCm/lIrzVsuaOeokkxM+T+BWKeNExcKXnDrMw=;
        b=GwUnPQj4Pipf4idtM1bV5AbKYY8yunQVD+UyUiDIgWisZt7H7KidJlSl6AWXLryU2P
         5gioCd0GE/Jaszj2FFVEaW6YAHX0BU2fNVdIHkZhIwlq+xjlODKJ0/5ghajeonm5cUyd
         ktL/9BS0pgoqlZ3qJpHwVpMedjH0srkvAtSbtVx2aDCqIpDcg1BHaEQL6CFaxN1Ij23G
         K0xWuhTpCyrOlUOJiyRDovT2FquroWeguMvB5HNefhJhg+Dfc34FayshyeGxDb4ni944
         +ziYMrwsxmmEgkEWtCiIkqMP76Zgpo5G6KlA+fE4BYAmC293MtcgVW+VdYH1/iIgMxes
         jYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756952116; x=1757556916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBZIhFsCm/lIrzVsuaOeokkxM+T+BWKeNExcKXnDrMw=;
        b=sTUUYnetYiY+t6t9wASiJQS/vppWMPQApt8fFmTZRiTyUkjfDN5o98tQi7fSBSceY5
         O4bMwVKkJlaQzbJUGJyQEwKI8na85nJ4KbQe43K7xuKjvDE7kSx9GAPwIdjbARorWRc1
         ysA8wwWWStSF3LHkSNKqvj+oU8QksobihrwKukqVnGAArLKXK122BudoawUdW+ZOGgKc
         vEq70JjyH/o3EuNXuXh35Ex7WMquSFuRyPFYGm8e/GCD669VRsHb+WLToNqe+KkKFKjv
         mOp7GEFwoeMKgShZvwxOSqToA4WEgFpFlW84gcIkjaKhiQf/V2H7nKbFHtErAiDE7onL
         WVKg==
X-Forwarded-Encrypted: i=1; AJvYcCVuBb3q0d+L/THck0aaqKqueYwit1Yi05gxYuOT4QNuwNrrGTnpzHQ0DJOpIc9dVmMSD96HkNB7ELGTU5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTJQv1/hcGLcg5YTYouFtQIVs8ufZ0UKUJe1ZDs45x6mVe5bVE
	WA2KPryFdl0QOtlZBXj8oukERqhiyFLIl5OferAWF5eIrIcmzotLIqr23bC/TQ==
X-Gm-Gg: ASbGncsfYRb2rb3sneJJJcKfLMgTk5tVgP7fV7eEvf1djAKC+5elDa8W2t333qey1Xy
	kosAa9ahj+szoZHUPf965V7FLsbDx1xjoGT+XlrbOKNSbB2i3flnbT8ckvs4V9qMOJfgjnP+921
	w2rgJyTwpbsLQP4eZIlGRGZo/KhjEE1vwW8lX2StH2m51DzQ5FemAJzp03Bwg5akLar6z67uWnP
	R+WOtpp74U1uTq1JxXr7NlLzZzUXwHx89lMGwT9/5yWKlbWMiMl+GJxQMqC07ztxVat/TUf66C0
	008myt13bS4WiB63F2YdP0yVpQWKecDWnrhwhzJEV5u5tG82aCkmSbILt97+c4cQlKxzN2Ib6z8
	hzthksd1qKL+1+ImgNp+ZijSKkhUquAQDKAP1upKETxphy1rXRDs=
X-Google-Smtp-Source: AGHT+IGkOHzlIL+n3sXFU8O+vcWJahFE3ez+2DE2NlgIXaycaSRoKiSm0hUQEiQtWGU8UK4YdVgpFQ==
X-Received: by 2002:a05:6214:dc5:b0:70d:97e7:9900 with SMTP id 6a1803df08f44-70fac96ebd3mr208476686d6.63.1756952116065;
        Wed, 03 Sep 2025 19:15:16 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad2cb78csm37714076d6.19.2025.09.03.19.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:15:15 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH v2 11/16] staging: rtl8723bs: remove unnecessary parentheses in conditional
Date: Thu,  4 Sep 2025 02:14:43 +0000
Message-Id: <20250904021448.216461-12-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904021448.216461-1-vivek.balachandhar@gmail.com>
References: <20250904021448.216461-1-vivek.balachandhar@gmail.com>
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


