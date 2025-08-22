Return-Path: <linux-kernel+bounces-782062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E967B31A74
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6DF56062F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159F130AAC9;
	Fri, 22 Aug 2025 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh9aisck"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB463074A0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870920; cv=none; b=NqOu3TxPMYoKjXU4krAH0ZS2/e1Cl8S50pqEib8mcNSecJ+N65BXJs9nFb6XCzU5OnMuU6ZNvJwA1cxL8IolBmvz+/0D6pvDKg1fyzVrhCjiHyqDNsn7p5tUTJrtImJL3+8/mQNEFfc9rSr4GheFQfOSanjne2KMOcnfScyOZRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870920; c=relaxed/simple;
	bh=IpB9cvK5kSt7dw+GGmoQNb8wx+qNNv0Enrmgu4f1kkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/ZvmXZEzTBFq8Ebs94BR2ReXvZn4YAyoeC5VPM6JAx92fanZutZQ6JNefWdHdnLgvd00OqA7VNsfgzCYvHi4z5jcwTnCGPm91nkPeEC4foErUT7VbG8uALUFEUZkD0TbLa1FxvTxyuexgUBU7ZaRF5ZgKTT3ZdrtoSqlFUhMcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh9aisck; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb6856dfbso383994366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755870916; x=1756475716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhtnvBKwGmstz40ZlcV+VAZTltaTKGtbvDCCJ8E5i60=;
        b=Gh9aisckAv6vgkP/a1tSWoBU4lRXUBWcZNfAP65/9J8kxk05XvKrAtmzhj9YZlvEN5
         6yyP16UHkuhKRAz38RkuGlW+9e3qVG91M0o/lKVqPHka3HrtYSEXngHcxJe0cqwfPTlg
         XzGM0RO0NYW/Mnxmk1ee+J9qgkIAuMNgw7NW3d7DDVrTtIg1MrUo1fNAX8FAHu82l4B4
         WXXzPYj43m3qwOQya2V4ghxHCn0Dc+Sa4CChuU7VEX+3bupkm6gdNmVLauxrgvxMe1DD
         sAM9ujnlF+QvF+Q5ox5h4MNczihauWgWPUvccNgnkZI4t9ztJpt4ovW1ozyUHM2jnnBY
         kgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870916; x=1756475716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhtnvBKwGmstz40ZlcV+VAZTltaTKGtbvDCCJ8E5i60=;
        b=qfUJi9kxapdj67wKiq/8xiqCYWpz5+8NHh99TWCxmiJjVH3ADfNAVbfAbYQjAT8grB
         Nybu7rCWmdjs6GVkYpPk9TzVRyaAGAkvE1ptZPoic/QHbDGQDuNi152fwbbUEr+OO3V0
         v/ru3EywneN/XO7Q2nKAkmSir3bGzS37Fw0LwoNbGNnZQGcOrPrMRgBWSAyHVeq63vIt
         3yxjT2V9c4cPTJt2Rcn0c/3Y2k4NTQkGsdRUG/ExctMInDCwO3tbT344zvL+GdQzz1YO
         FgeDEeqX1PksCYhpH3R/lt8uew5GghttFNI/U8KyjcnZE3UYQMzcMhNMrLc04ZHxfh1Z
         XCSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnCQcMZcEmmuL9WVvg8jwu8F9zDmDmxC3P+ot2GXnRtC4zbLra7fdRIRJHBm8yBFQB6vCUYgth3QA3wUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeuBvoNkswCt6dtJKNaQDikWazojmlARRUCM2XrCqO1T9h+RYb
	xJkJHNFZQiTdPtMRbvxwGG/B7QY1Vy0gWwhcrYxxy+yeNn1fSyZ7/j9b
X-Gm-Gg: ASbGnctobeIxJqiev2afmf1URhYz8HXvcIGUkooyhPhVQAcIzAyqD1gYZ7p6UV/NMoI
	y3sHvn8FOlod35NYR/W36jlUPo/yJ0cHAFYj/cRLwqtlqc44a8EsrAQ0Af5i0YVHJB1Ml9H58xd
	9JsQNIOm71vqDiljKOWprT/cMqK4e2NwVk+7T4lzI8T3YklsLBCePSWSLG3144CybEeoxP8pJic
	rceijFDX+7mrKshpN6ZZf9kXvTnzzHL3Oe26IFzdpw2PA30ckBEo7zOFIQtYeK/jNjiV3w2EBaA
	U/b7Y13pTm87bJ/hpvWCxZC7SsU4cfhFEX4AlUZPXA7b2vQRLkFh5bTt++i/Git39j2cela8yLx
	jvxuIvTvPw8VbOou/aLvj/cEhyw==
X-Google-Smtp-Source: AGHT+IHT7+T8WawmQGKLOfrCxwkolKFWqCzlOiIQiq3BB7UaJMLgc8Dx0GdNjecGWbrJC7emLM3BWQ==
X-Received: by 2002:a17:907:98a:b0:ae0:e1ed:d1a0 with SMTP id a640c23a62f3a-afe29018bbamr297028266b.8.1755870915954;
        Fri, 22 Aug 2025 06:55:15 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded307138sm612353866b.45.2025.08.22.06.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:55:15 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 09/13] staging: rtl8723bs: rename rtw_os_alloc_msdu_pkt
Date: Fri, 22 Aug 2025 15:54:14 +0200
Message-ID: <20250822135418.118115-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250822135418.118115-1-straube.linux@gmail.com>
References: <20250822135418.118115-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename rtw_os_alloc_msdu_pkt to rtw_alloc_msdu_pkt as the _os_
indicates operating system dependent code which is unnecessary
for in-tree linux kernel code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 4947099d8595..a8b388822719 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -1622,7 +1622,7 @@ static signed int wlanhdr_to_ethhdr(union recv_frame *precvframe)
 	return _SUCCESS;
 }
 
-static struct sk_buff *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_Length, u8 *pdata)
+static struct sk_buff *rtw_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_Length, u8 *pdata)
 {
 	u16 eth_type;
 	struct sk_buff *sub_skb;
@@ -1691,7 +1691,7 @@ static int amsdu_to_msdu(struct adapter *padapter, union recv_frame *prframe)
 		if (a_len < ETH_HLEN + nSubframe_Length)
 			break;
 
-		sub_pkt = rtw_os_alloc_msdu_pkt(prframe, nSubframe_Length, pdata);
+		sub_pkt = rtw_alloc_msdu_pkt(prframe, nSubframe_Length, pdata);
 		if (!sub_pkt)
 			break;
 
-- 
2.51.0


