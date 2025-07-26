Return-Path: <linux-kernel+bounces-746620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC310B128FC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6AFC1CC44C5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8E1204F93;
	Sat, 26 Jul 2025 04:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZKZ7SS3"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6FF21ADC6
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 04:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753504442; cv=none; b=DvUwfAVe+40YA2K417bdpfCAutmThDrniEjWouRi6huJSkM6lZHiOu8J+midkF0WNgfhj2AJygzx1Pkhh4RihqzMefkVYkHD1kIfwzEahWKvR0Yxqj58ja42ld9IVV9eGPB3nB1AAHqjwDbWLmf0G359VHpd2KjpoNOfuppJiF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753504442; c=relaxed/simple;
	bh=Z5OaX+7jHTU3mMvL+WEAgHUArV9m2T9NzvHRba30tZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dtIqM+PGum38GijE+50SPaqtRfekfgPjTeoiDf4HEEIAWTzc/bZ4uwFQAKj6wz3xfnv/jdhih6tkOQu0Js9tQbnhwUbVN4pkWYThaiXkiQKvswdo+GqJXqyff+CTcTfjCBwA02YemoXBijtLywjoHmfUZuLIM/roxwkH1xST2tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZKZ7SS3; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e29616cc4fso249140485a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753504439; x=1754109239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODpIvfyNJQSFOOSJUan5t1Okvzxpa4QfGplGbiE7DTQ=;
        b=NZKZ7SS3KJsfjXQZD6mFm0mgWKDjbr8pYajLqiggYP91AihPU5d87mXEZ7fK0CRMKL
         lhtkEr+GoPHZrrD3z/j/PB6DXTnD9NEDaOHFEDxVK89D8i/c+a6DL5F+j/n0/F1dVstC
         af0nj98aqqQhsBQQZJX2VVn8xnPN2FQ3L9zTQ5oN5WchiRfjvpELMQy9X47eEOnjpLBQ
         Zfs1oKmK6qMu6l2x39rbR34k0rA0HUZpluII+AeS2UbkrLlCCOVLHVJPEip0JuRj8FU8
         O694flS1sGfZVBGRlWikqNNAshr5YCqN0Ebh9y+VawOH3R8VKYSLApTLxQiH/IUyfzgA
         RY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753504439; x=1754109239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODpIvfyNJQSFOOSJUan5t1Okvzxpa4QfGplGbiE7DTQ=;
        b=Fq3ZQDlKjSF8owJ7AgDkUgmPK8+kuk+nsBaO95LzKxeNOUOsMpVEW1gvMVXFIc6WYm
         7FrlyozaUROHHWaXOkaZ3Wvl291hbHCUoSsN7salxkiPvTQVJN4JOAoD6/em+zTmmce7
         wrv9RXGkHBra1dLrnyBLyqVvlmothTQ8xyBygS1XJRl9KLs/kBTsW5WXAIpCTy3co3X/
         cJ5UzfWDXCslar0Tg+bT0IIdqF9Zv5oS9ei/3nEsVrpEjHEYrPd2aUHKPlIcZKJlqn83
         fdbh4c1gxqa4E9JUrIRszhOy5i94bY8Exy97r9xdXGAiuYqNbWq0Gm+qiprGIx3rooG8
         cXjg==
X-Forwarded-Encrypted: i=1; AJvYcCWp2E9KnLxW4T5cASSQi6xdLEg5VNCncWJgxf8tAcGBHo5na09X7Z8rxDJsi8XfdInRCPeKiJ3zpHKipTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDzPaaVMenF+1i6Fa3o6kjKYTfadYQ0iiOUIScbEAADoa1MIOc
	RmdBPrvwI7IaxFfiGjn9i1RQf2qQdsJctJyfjAFWUIQN98FhULKBmsP1
X-Gm-Gg: ASbGncuxml1eutJvgzlJgIxpMxi8bba1NhVlIEUbQG6sO1MT8+998bhTMmkP/kzt6yP
	Pmryp7CCBzXlcWZSfjwD5SvwiNiyp/zoTKeHsVf45jCXmvMQjg4ZjCynhjokug9EAiwrOlAbCuZ
	su4Tq0/DCmouW/Vqn6XAldRC9PtwALxtIA/IfWrpJ5W2lAbdjYbABSNGrcJhhn3pJlWCBNQ5Y1T
	EEo6qr/jJH+mGyYSDCv7/E+g8+cawxPAZ1atAW3IdIxLoNt3rUF+IzDq7WgFTOVjbHqnZEein//
	PEWJS0dXbBDMj0P1uahsd9Jf8MFSGq0emF0nSMLe8BZFR/sSrGiCQ2k2H07gG3TUQ+1MQLczIOB
	rpUI+Dg02u19x3xfMTiaZvcSOEei7oA4IMKAtwjSAmW5Ye/Q3kq7VbcFOZN6aGw==
X-Google-Smtp-Source: AGHT+IHSwjMogwktb6Ggg2pYyg91/CxlwjpPDIMYKadReDTC0+8wXd6HyXUmMXE9QwJMXp80jeRtaw==
X-Received: by 2002:a05:620a:288e:b0:7e3:477d:53ae with SMTP id af79cd13be357-7e63c1b1868mr579325085a.54.1753504439572;
        Fri, 25 Jul 2025 21:33:59 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432a885asm70322185a.36.2025.07.25.21.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 21:33:59 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH 14/20] staging: rtl8723bs: remove unnecessary parentheses around assignment
Date: Sat, 26 Jul 2025 04:32:12 +0000
Message-Id: <20250726043218.386738-15-vivek.balachandhar@gmail.com>
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

Removed superfluous parentheses surrounding an assignment to match kernel
coding style. This simplifies the expression and improves readability
without altering logic.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
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


