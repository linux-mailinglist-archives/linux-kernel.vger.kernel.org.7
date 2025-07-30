Return-Path: <linux-kernel+bounces-750334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDCFB15A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9A4560A07
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2DB238C29;
	Wed, 30 Jul 2025 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKDq6sVm"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268682236EB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753862620; cv=none; b=A8vMyGHyfgHuxAGJdo8mgcImn/XAZuiSTfmJk2+hudMfYGBc9AjhPMYwd+MLtIhVGMYC7GX9quby2LF9Himvc4QaNB0b0P/X/zQ2xAvVx16dWpejESugZyFETY7pJa+vlRkCHREvprA2zFt+AW03nrq9B+E7pV/dGgOQyyJhJcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753862620; c=relaxed/simple;
	bh=Aa24vLyXllnQg3WiYXULS3Wr+CT5idpVokShGpFyeRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZWa15jYIsMrNATLTOBxhr0P1dTIjaoTH9xiCr0dWuV71xNlF/0KwuMa1+rqxKPolXg2YQJCMNDHUkqk8p8Yn+3R3MlB6WHKt+hgBSb7BTtW2wZGuo22OADYcdw+QhX7JfDlZeJ7iU2ePokKkDZfcLFl2rGrQbwBJWVW1SNO4iYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKDq6sVm; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e6696eb4bfso111060785a.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753862618; x=1754467418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWnQEPlkqPV7cSY+6x+N1AZksE2srmMJWG66mvfTM4E=;
        b=EKDq6sVmaKFiQA63EcvyHkrMqPE2vaiyLoSvHG6c8dzViOdWxGzw2ja6Odkei443XU
         Yh6xBxNMaVFVAHPkxcT05THspb2zLxOMImBn/Rael3Bay6GP5qEIzZcov6HXGvyk68Sl
         0vA2gKrci8nBq145W27Eawlgib3/nEk6whflGRHKDJs/1I83JBHZjOIajvOd7zJiX0rO
         E3RwzzpQo4HNMgY4AIUU7NY4aJxjMdCA9HWWVOhAL32Jm/AcCy03rg43gffntDr+PQPt
         CoDrouozWF+vK9BAxKBmatTOkKX8169oDKx33jHATF5XKGhT8kKAQY6SXBqRnJHTkQx+
         KbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753862618; x=1754467418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWnQEPlkqPV7cSY+6x+N1AZksE2srmMJWG66mvfTM4E=;
        b=Y4FOfr1NpvgphBusCSLto508pfsdoXI7bin9QAzxrJcUqDBg8fQFlXgFENXTtsS1a5
         QLxnKRxwAPigRMZ1i4mxfsOl1zv3M0Gg6emWgBkWNma6hRxuhO0CpTEoARk0qUuEgwBp
         vcNuyxXFHCBn/HfSFaiFLua/4e9TyqupPr5lQfKxjZUK7MpWyKxjanZf8fXACeG34NRa
         paAsUP8SAs4IREsX8yEyMynneO2fkPo/jVoxyM0JR6+asnqGncV8R3rBqTRQFmneBctV
         wO9SJsLXCLgeZvZVkXgzwYRJAU3c4br/UWjagfxvaSrv2jb4smproy7T/K5F9GE05Xjp
         TloQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2j2yHgM3c2BNwAR7QuH2NpxzMSy8m75hbVeqgKnyT8J1iBSo7IvFLa6kktOqXo0Rz7x1tCf6EpMzMWME=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSTG62kuC6uLpig8FYuJ+4s50Q6MeCtTc0gM2Ig1FdoVsxh+VQ
	vGqZCI+Hl+PKBnEUC2j54qRrl5aNrmFLohKVZOAgsqr046Tbd7SBHUcI
X-Gm-Gg: ASbGnculh6Qw51bVpe/MoktGYBWSmiZppU4BrZm73Sm/zgu/aYBqXYYP/273KzznH3p
	2L8iw/dQsCiPogkgwS/gpRNH69afRhRcvLvvMa4QHcO/PWtKxYOjOStkQ6BoDgpDfMROwZsjKQ7
	YNrBnSrcK5Oxjqq67o7sHXM89snqmhyIbdxfDTgF6Rq62EkFmgdXJz+iB8wpuc2/s9DSVO9Pln5
	l1mE9+tIxRBPgLanNBXfRPSQ94ItPE1Scfo2l9QJgYApk6eno8q4k7UUadlI6tkMWaLK42mFwXi
	32v2Yr0rXZqJ6Ekjfxh/B4F0i0L317QNCn+zy4shbNKEQrsWcy3U2xIWpPQzMl0hprJQzXteWxX
	uEo7yQfG6LXhfjXkf94EApjGUpan2bczNZcsRqm8pa0XBM8cbhak=
X-Google-Smtp-Source: AGHT+IHCJuWpsQB07TGtQhgp//yWRYtMBSVH9da8NNUWbPjYxj+T51roVTDFRzhkXvkIH9EtoQ+9Tg==
X-Received: by 2002:ae9:e008:0:b0:7e1:9c2d:a862 with SMTP id af79cd13be357-7e66f3534ffmr243727785a.39.1753862617814;
        Wed, 30 Jul 2025 01:03:37 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432ae1f7sm530027785a.40.2025.07.30.01.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:03:37 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: vivek.balachandhar@gmail.com,
	Markus.Elfring@web.de,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v3 14/20] staging: rtl8723bs: remove unnecessary parentheses in conditional
Date: Wed, 30 Jul 2025 08:03:23 +0000
Message-Id: <20250730080323.491138-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728064328.423024-1-vivek.balachandhar@gmail.com>
References: <20250728064328.423024-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extra parentheses around the function call in the if condition
are redundant according to the kernel coding style. Removing them
improves code readability without affecting the logic.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
v3:
- Improved explanation of why the parentheses were removed as per
  Markus Elfring's suggestion.

v2:
- Mentioned the wrong version number in the previous patch.

v1:
- Fixed incorrect wording: the change was not around assignment
- Addressed feedback from Markus Elfring.
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index b8d72d28178b..7552f7e4d14a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -699,7 +699,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 	rtw_set_signal_stat_timer(&adapter->recvpriv);
 
 	if (pmlmepriv->to_join) {
-		if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
+		if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED) == false) {
 				set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 
-- 
2.39.5


