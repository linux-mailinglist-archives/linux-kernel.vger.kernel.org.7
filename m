Return-Path: <linux-kernel+bounces-835846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B387DBA830E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23A517AE664
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FB32C21F5;
	Mon, 29 Sep 2025 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0Dpz4E3"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F96C2C21D0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128655; cv=none; b=Hx2hUPl63IyIlWt9YxINoMErmd7Ob85KZ2KqmaywNGjASkQbPadzD8iyqBLLV7O+u8rkKdOp9iCiiIChVoLoyH6gYSmFKssFm+gWsFdeg6shEJx6opHSJuGoccSqoj7Lkolkc3DWNs/92c4BpyAmTHuywTRaFkyc78AigLTuae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128655; c=relaxed/simple;
	bh=h1Ogs/KI+mapGEJM/7burIP1V8we40RoeBp8e9GSjc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ElPhwMeLXFQIJr3Icvx+WZN8GZ8yHSwGILBRFcbDJpCAiHvxe6LijVi/0FZYtzqIUhavhkIEbGNWxNPW3b6YmLSaI3eipOSOpItU9kla8RxZxiedoLZtwuA5NoyxEC33L6PDa+4G2OeZiqyaEgmCxyR8z2MX3kEn1bMtu1oXZfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0Dpz4E3; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7f04816589bso458144185a.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759128653; x=1759733453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBZIhFsCm/lIrzVsuaOeokkxM+T+BWKeNExcKXnDrMw=;
        b=h0Dpz4E3wFbbZNQFB0d6MZWu3r/qiCpUIYqN1qJjgACBbXhRUcJdHkuQNgkAoiAIBM
         dckLEyCOAZOtdcH8p0DZKhQwv/5B/DGbCQDbvwkzXbSQ5e9ux2QNL66l6o44uVwDbdni
         v8bxknEpXd3nOEiIl7Fnq9TMhDJz1jKnCEBSQejFkwd67cUtqItw//qL5POQWzeTYqK3
         wy5njmDl3qbO+y9uWR24DZsQgy7lonR724L6DL7vRgxUC84YN02CC+eAEMaOU9+1bikq
         MU2KHiATxKvwyOWF8vot9AOXLR2w3tpQlRkmjd2G/2FBfBqqshp910L3/7oQU+nrgKXM
         nQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759128653; x=1759733453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBZIhFsCm/lIrzVsuaOeokkxM+T+BWKeNExcKXnDrMw=;
        b=DNk/Dh1DAllxKFBNFcOWhs3ly84LdY5RjYMG9P4D1s01JXARvnJ9QflkU1AYJLcbxQ
         kFlqH0KjR/hQWQBN9d+kePKppWPwqGtAxpjypAAqAWem2RpM2uxuJuqAPo8Lj1s4mhPH
         +Ue6KhLLWXgI4u8HGMJ/n+gMqmTjN8zwNVUE1w1mWIBKo71w/j28TL+H+2flpgNgY2jO
         Ad3BOyIVpMKIo3ofFcKBPNjC72cPJSzKwpY/CWOOyNHpuGp+tUvF68DlxLUQdir+CYs2
         saL4ca9fPRiqqjH0O1ZKFaJwBcwGkPl2NF6uN4v2FnyAb3tuBoQyNX9yugUpNOTY9EOl
         /Hug==
X-Forwarded-Encrypted: i=1; AJvYcCVyAs5kb2swreMuio7DhdwXyAIgoeLeoOIGNsq9RZoy4E1hOIBPTma2Sq92HOZoe2i6I0FFfXsJFF1DdjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyupa5IVcgyXMu6G60+uAZAEI8A/6EbxeqpuKvTe/bGGTPgJ6H9
	+Bmd9gfRv/YTugq6K4fab0YH+EnDARBUiCVdvQzuI2MOWWlfxDYBf9G1
X-Gm-Gg: ASbGncuEUWLMwKO7eAHtxeDtvnI+67RanlJgwIZMKhR3n/GKaKlngj2FWxHdkR/04qW
	zE0wg7viiJ4QhfFN1RIowbnQWlzvwQnr743mtXgxGQpcj3X3No1orjBmErnsX3zXuyO+gi7qd5e
	AefKqOVsDigkM1GL6APZRAjjsAMAvUQvCXVQ0Qd+PBTDGPTrR/ArDSldsrJEl25NGCXt6B6qyTO
	JGrbrQ5/4d2UYzPTwGsxcmalV7fGmPQkDyuP6IyXLYj6CSTDrLOFhjOhehTdstGLi37hfvQjzBa
	sgJhM7and4TERk290SN41X2MFsxlf5HAOcaGMZ9ObV+FkgF9K9jW9jRadEr+RuSdTbScCCiY9M2
	P8YVNBoxqylckCH1B47ZGppVpXAgnXE5xNgfM359dpmTi7PC3H2tinI3SdV80QA==
X-Google-Smtp-Source: AGHT+IHRf9bRRETfP3zaBeMX0VuK6ls8dNMtBz6nnwSYXGmTkR/7gI32pW/5F2TzES/+86UTx18tJw==
X-Received: by 2002:a05:620a:444f:b0:848:a4b7:cb12 with SMTP id af79cd13be357-85ae0ccdb07mr1877843685a.25.1759128652684;
        Sun, 28 Sep 2025 23:50:52 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db10874bb9sm69517671cf.24.2025.09.28.23.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 23:50:52 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v3 11/15] staging: rtl8723bs: remove unnecessary parentheses in conditional
Date: Mon, 29 Sep 2025 06:49:56 +0000
Message-Id: <20250929065000.1010848-12-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929065000.1010848-1-vivek.balachandhar@gmail.com>
References: <20250929065000.1010848-1-vivek.balachandhar@gmail.com>
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


