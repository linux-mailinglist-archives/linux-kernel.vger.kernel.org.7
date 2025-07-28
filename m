Return-Path: <linux-kernel+bounces-747542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 802DCB134FD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2FD53B80FB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED109221550;
	Mon, 28 Jul 2025 06:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXfIU0K1"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009C520F062
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753684537; cv=none; b=BVrbTPilEq6B+JPTHUS8x3CTeWXA+aOAtUyhq4iBWXVs84bYNbtUECIEAbaxUNbQyzxGj0OFbFJs0y00jDk9GCJK5jFXlLfr2+tZga+EB6hIpeoDHs1aHuX2WEoOv1m2pxnwWKcMw1aMywKIdnezUfNgR1yR+UZGjIs+TQJaeQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753684537; c=relaxed/simple;
	bh=+fXDohrWMWo9G8EI9UAt21V6WgzDKIUmV2hR2xxLtzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e+Z40Dp4SqDm2stfVeq8Keps+G5hGOphIkX20xAfPJRTX6FYcJp0eB5QiJED0qwF3y1GNRCvc37+JZHf2e09EsUCtbUYzbHiGTdDPE0qF6UnY9BDn9lEoBUJc+j4lvd644v3Eo6iBDbb8HQ8M5uG/DdgqzKzm2lhYNc5B6cQbxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXfIU0K1; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab61ecc1e8so31828591cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 23:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753684535; x=1754289335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnJj4JAljjvMTcZBxH8ZSi1hv9zlYq3kQG99bS/CAPo=;
        b=JXfIU0K1bRLmQLJNa0xp8B08FXBGsEJqHuCY+gbS50YTEsYP4r/0cvH8tsmfoHAnwg
         S5jS92mq06jnuPPgshvLlE0gPtcP0qkD3zSq07Y2VjkbwtpuoTjjqB+k5AUu1GgNVswc
         iHJIyeylksuYl9MXl9NXwwOYfVnDlDy1n/gD6CZddlK7yR7bDtScwJGdXQ2NR4sFD/0A
         nkeR+X/KrHaZ2ZL6GcgYHpFs3lVj+uzF6NeGuxtUC65+bJ1fHm/Xv7LcEPOJmDTLhl7D
         APGOBaVwFmwkf3B+nnzHBZOox+aGv6Gd7SHxFSPeG0ckprwI08zEPp6xYtiY2QDSL5xp
         3a6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753684535; x=1754289335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnJj4JAljjvMTcZBxH8ZSi1hv9zlYq3kQG99bS/CAPo=;
        b=T17WBdjn7CXGAXV9B9HvssIyaTey/JdAPzW/x+LlAFVMlN2uO/UcAeOCs+ESLB6p9I
         k3SibfC2AFobC0VKeV0WkQ2uUexAWo9hv4mD056/jJcZwDb+Svd7Mlpdd8hKZH9phbbV
         mO+6WhycpY7x9p6Dp9eehpUEi1OQJ6D5O9+ZGRPZQIfbdyJB9Sx2f3TDei1I8aehz7Eg
         DcP9iI6JJmyZ2gr7YKiK6hCCqVniXScD0p7N8Jh6SMRG4RKKM/a8VGEaH903oQBRj88M
         nQ/8MKPJENzcXtlMMDhBRBArZHFcV2X9n3L94tcfVGt1ZYVlvQPmchjXALb8/qUtZR0H
         CSLA==
X-Forwarded-Encrypted: i=1; AJvYcCUWWJtP8u7/vp0JKQ3CkTf3glc2ujoVKCItOCq0XpZ2JpxPGdixhJhz0tvzIx0M0TGTxUl2p7zS7Xs0G04=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIDEHAIjnzLjo5u8sQQx/ZyqFKLtaxpIRxxSrPMA/FFvlLp03p
	Wb++vslQyl/Ri2USMK1cIpHAKBCy9z9j8AV6o6Jz93FI/Qjs/ImqikRI
X-Gm-Gg: ASbGncsBCysPvJmsW1HAA7VQYgsM1bNE6FylxS4DS8VuGGfIcl7lv4I2bZaMzFmTtEI
	04xDgKXocSDHySv/moJ/Wx2oKgQk8WfcR4L2x4Vk4DHD3hzGRE4EPz9vNnHaB2rSu/F5cW43L/u
	PPVV1lgK+XGrUn+Wto74h6Rve7kb/oK+Pw+DtdWaPFYoQgdBZWrOyUMt2Y3erKlQdEMo+w3Jz2R
	vd4kIhYi1ziyv3Cfk4gOpQGfi5WcwqTEGdFjyuwLg1oiEuFQxUv7/XkOP3+4JoRbPRsxShi327B
	6Ds8ZPt55dQfBo5mUacCIos6sf3DYqIMrUobYIV8oy7qPcsFrojigluSwuYzqRYw04IKHKhSU2t
	0MTpa8IN1oybyeeWdsRaRje0Uw6KezgtoT4vQxkRZcxClTYmyUgc=
X-Google-Smtp-Source: AGHT+IHkIrJWx/FbtzBKxauRdVEfXuJLg8qiUDLkKh839y0eXpuhwwiXmrYE+HCfGM7zV2yuyOjivQ==
X-Received: by 2002:ac8:5d45:0:b0:4a7:1401:95a0 with SMTP id d75a77b69052e-4ae8ef1b433mr148830851cf.2.1753684534328;
        Sun, 27 Jul 2025 23:35:34 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae99544c17sm31612571cf.16.2025.07.27.23.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 23:35:33 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v1 14/20] staging: rtl8723bs: remove unnecessary parentheses in conditional
Date: Mon, 28 Jul 2025 06:35:10 +0000
Message-Id: <20250728063510.422849-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250726043218.386738-15-vivek.balachandhar@gmail.com>
References: <20250726043218.386738-15-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed superfluous parentheses around a function call inside an
if-condition. These extra parentheses are not required and violate
kernel coding style guidelines.

Cleaning them up improves code readability without changing logic.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>

v2:
- Fixed incorrect wording: the change was not around assignment
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 3702d7e7a954..d845eaecd615 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -700,7 +700,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 	rtw_set_signal_stat_timer(&adapter->recvpriv);
 
 	if (pmlmepriv->to_join) {
-		if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
+		if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED) == false) {
 				set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 
-- 
2.39.5


