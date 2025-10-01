Return-Path: <linux-kernel+bounces-839070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78361BB0BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B9D19248F2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81714265CD0;
	Wed,  1 Oct 2025 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bqb7tqJM"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DAE258CDF
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329497; cv=none; b=gkhzYAlL84i4mid/WFqzJkAVYhmiP/nrsaaBJVYdd2LDZDQNenTD3t0aeafl4oXGfd7muTyA5YRry5AhmYQCiGc6IVlxw+wR4Q0HBoSaE8uDRf4Tyfel04bKI4xfUKTbIoDv2bt63bA28IJXTtNU2LkPVeu/+0iy42nsf3KQxEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329497; c=relaxed/simple;
	bh=PFszx48unL3OZdOKxZC+O4/dOvgkdgU64h4yg5QoZts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nsL6ahrWD9EvXAYL3s/RXBp+7cKN2S85bYor8aw9GBTAdbKqL9CvoVD6dEhGZ2TNxl4Ov240mRpmWadps+5jJkGxJNIRXWO6KIoXiSdaKA0fNpU7A16qeaOrxm/XcoILaVjaq/t+0n+oJ4xAAkv5v4mxcpoxyZ312x0/DO2/py4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Bqb7tqJM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3727611d76so1092818566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759329494; x=1759934294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmA+fxDwXNd4r2km4orWOLxYXAzQdDkMb/ExdCUz6S4=;
        b=Bqb7tqJM+CKx25BaY+CQOlG1ghjrPaVYOH8neytec7xr62iK6w9H+8TX8Y9dHz+HcM
         O3fmtijIrPWUixWIaip+xYJ3Lt5fYFhUA5X6jpIsfMN5Bpe73dvFEiodakBD/NEYo3SP
         CTFoUmy0DOPaAF+mWbJ+qHn7z6+oOfAhFrAg6o/CXAMWaI2+KK4fhXh/b0Pm0TZILeZv
         kk4ENOe2wg2DTFloY6HeIcBfuEy4P5ef/mtJSzqSb6BWwwkP1oAtbz81klYc5StkrEp+
         RwDoZQKF0vC4aBbANx3dodwyAgvd8LTUoTB8iplsfOlYqxajvGZRIJUTH2/8uKRaovOo
         5lCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759329494; x=1759934294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmA+fxDwXNd4r2km4orWOLxYXAzQdDkMb/ExdCUz6S4=;
        b=Zj3ZGPlb3lNCx6j6Dy+dSl6Hp/x2x3R8TcgllhEGkpp7nGV+9vbgSNdEF25YytvURf
         og6dH0mQvPZhnQlPSZAFFxdYBYP0s3gq4sFLK/BWHh/LZ0RJTBCgBo9eIdjIIgNZuTRt
         ilIDR5oFfks8+ImuDAjtfvog1fXl9tVchdtWpiQ7DGFXsgQaPU5nvgXwLmwSLBsNwTKC
         DuE5kKioZLb/4l1GCE6pq3SwPGJhaMwe98o+DPkrA+AgfGBcRgPqjtzVvNJeTvZ6R8Sx
         gC1Te4ua1VWAf4fdD5JwYj3dICKOc8MOGnFUwemYbbj9X5oWKDeNs2sdztPTuVFRpu8L
         wQSw==
X-Forwarded-Encrypted: i=1; AJvYcCUDkG63MvnRaJxu0W0KyHQDlvMww31yycV+1iqt5PFzTg0XfV98xgfQPcUnLzwt9x3rueWcMM/pPqOktto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV5/MIXmAjUeF3yiChvQcCwuV2ZudIwc2hCkSCampLsz+UiYR7
	GOtWv3QaFEy8i8shypA8WfRUEpEPEtfUUVnfDZ1APcHA9tpnNKDsNlf6kUT1Gf4JOjg=
X-Gm-Gg: ASbGncsQU1KVk7TxyJyom/dc1zIStmOcY4fr4wKBQs/y+biTNWl0F50uTVzPSh8wr6E
	iZHhsWmBtrCWOhEeaq6CnwosW8xWwU83wqrk58nLkDnGWXkez6IMwnMQ/e9L9fpUMopgcf9pUll
	PqaDu2p+j3LyVxZww/Y3PTVkcD99QlFgynEDs385l+OjTicUANVUVgNvSABfeezD8SXeC+CZDrt
	v5PtQSXxRkFHEjMdA3khoZRClakF2x0ShuTpkSarPYn4ugu6RTyvlQX5MrhHggs/YJmr+Ne9oSo
	2Tvcb+Gc/PKwtSU8JJw1BB21JO4yE88Zzm0bm6asA74/k40MghIvqbLiQP3NtKelbEK+Gpix8DJ
	XOaq2B8vRXh1BvPgOLnaJxpONnzPjAc55LF0md+DcYQio
X-Google-Smtp-Source: AGHT+IHfuFiRimcEv1krPbdAWrrcL7XU+qBwY+On7p+dsFTSv0tKvQyoY3KBf0q61CeTK0ABbzD1zg==
X-Received: by 2002:a17:907:869f:b0:b24:7806:b59 with SMTP id a640c23a62f3a-b46e7bba94bmr458201266b.55.1759329493968;
        Wed, 01 Oct 2025 07:38:13 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b353e5d0d0bsm1401521066b.5.2025.10.01.07.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:38:13 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 01 Oct 2025 16:37:39 +0200
Subject: [PATCH v8 2/3] firmware: ti_sci: Support transfers without
 response
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-topic-am62-partialio-v6-12-b4-v8-2-76a742605110@baylibre.com>
References: <20251001-topic-am62-partialio-v6-12-b4-v8-0-76a742605110@baylibre.com>
In-Reply-To: <20251001-topic-am62-partialio-v6-12-b4-v8-0-76a742605110@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1698; i=msp@baylibre.com;
 h=from:subject:message-id; bh=PFszx48unL3OZdOKxZC+O4/dOvgkdgU64h4yg5QoZts=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoy7Nkf3FAm/tbg/ufOT3QHXX3o13lsu6cyLLuZbKnGq1
 0zKcllcRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAExEfRkjwxr+ehu1Lp7V6+4f
 Nf+w9xDvkw9b1bnvvI/0N9ffzTWjfCIjw5c3S8Q0ZhlOFcg9wJBfUn3wLePtm7sfHSmaHBty98t
 XZh4A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Check the header flags if an response is expected or not. If it is not
expected skip the receive part of ti_sci_do_xfer(). This prepares the
driver for one-way messages as prepare_sleep for Partial-IO.

Reviewed-by: Kendall Willis <k-willis@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 24ab392b4a5d0460153de76fe382371e319d8f2e..4db84a92a517b0aa7bb8d47e809d9848a16e2cc4 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -398,6 +398,9 @@ static void ti_sci_put_one_xfer(struct ti_sci_xfers_info *minfo,
 static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 				 struct ti_sci_xfer *xfer)
 {
+	struct ti_sci_msg_hdr *hdr = (struct ti_sci_msg_hdr *)xfer->tx_message.buf;
+	bool response_expected = !!(hdr->flags & (TI_SCI_FLAG_REQ_ACK_ON_PROCESSED |
+						  TI_SCI_FLAG_REQ_ACK_ON_RECEIVED));
 	int ret;
 	int timeout;
 	struct device *dev = info->dev;
@@ -409,12 +412,12 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 
 	ret = 0;
 
-	if (system_state <= SYSTEM_RUNNING) {
+	if (response_expected && system_state <= SYSTEM_RUNNING) {
 		/* And we wait for the response. */
 		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
 		if (!wait_for_completion_timeout(&xfer->done, timeout))
 			ret = -ETIMEDOUT;
-	} else {
+	} else if (response_expected) {
 		/*
 		 * If we are !running, we cannot use wait_for_completion_timeout
 		 * during noirq phase, so we must manually poll the completion.

-- 
2.51.0


