Return-Path: <linux-kernel+bounces-725994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672ADB0066E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96946486EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478DF277031;
	Thu, 10 Jul 2025 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iK+1TXej"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE0B277032
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160873; cv=none; b=pZ/EzVHFYUGxXRbNp+L0UbAbgJDDFbtwdqrJijMn3Syzfl0a0KzI7EWs5ErSdQyARQCUVYb452GEwDHVTu07uExLjBF0egJe6ltS/fJ4gSvYoVht2Q7Z2DLEywG0w+DCsG7qFzgCzKdnwu65bmoB98XYvcz7aIhWX2LgiBjOeTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160873; c=relaxed/simple;
	bh=y+AZFWJL051hZPxzrLPHAl9zoCHqdwam8bIR61IfRhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=egENRVGqbk8xd0GOO+cqXqgxBziCnjo6wgLqoNgeSOuCYSVfVC2HJO3W5JKj9IvUAJ5UaLZpe0QqQhTK7vJsYQs6B9QsF+UaDOjs/pw76xjQwQLoNfYkmQrqw0ZezqWJivBc4vWgsbcjI6D3x2h53GC+FzjWwp3zJUmEkUek054=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iK+1TXej; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752160870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tSPmB88QF1UNyRARNUEoZz86JZ+YjWuFEV+8k9Qdm2c=;
	b=iK+1TXejIWMMEsCwUtM4YYc+CqSZh7IfLxrcsuoOnnupsXKtlhYehso3FnHWrm/i548Pou
	r1YGwzhAGcrN830cdItmcupd1hzqaLJBX1LRB/XHKYILV2KVaq5sOaD/+v6JhlgsyAA2OI
	uYNnB7nM6nE4pvGJoipvXXR3zVYeP3k=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-OpLiD0piMgubq5t9cx481w-1; Thu, 10 Jul 2025 11:21:09 -0400
X-MC-Unique: OpLiD0piMgubq5t9cx481w-1
X-Mimecast-MFC-AGG-ID: OpLiD0piMgubq5t9cx481w_1752160869
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a9aa439248so13780971cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752160869; x=1752765669;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSPmB88QF1UNyRARNUEoZz86JZ+YjWuFEV+8k9Qdm2c=;
        b=BY+R0cJ2wkyAN3lX/L2351yfrnD9/8mG2n87o+rVa1V+wlmHzjT+QSSAx7xS7CWkDo
         +yP8fxveWvg7ns19aBLlOBf2vQ4xqtt34JFX5K6Hg7Ge8lyJoq9HwXkqJnQjCu/n4r0h
         G7IXGzdD2qSnu5YexPyNI9euBYGNJnTl6Wr3CzJ3aldP5fRfz/h33wlM7OS7Y4LVLtQE
         /QulDTrXbCA0M6piZgsFcuOw9M4azmTLMvW/YBLV7A5hBlem+FvP0l03p+UnF7w7vgcy
         7mEr6GekNJd2BVG0dZ6nnbhLuBwkdKwK2vODkPbcFZ6L8SRcAwcmFgKUL1CWMI3Ud55V
         fuxA==
X-Forwarded-Encrypted: i=1; AJvYcCUCLBvWqO5MIMoLc+t6JQLTVrpTlt3T/k2ORlxcDJVKBathD2+4SQFI9IFhydgP8gkBiko5rEa3e4NvBzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnUicPHMUrgvWGv1XivDtReqaT0dDYHZD1gDSmZUN1iExr1PJg
	oLbXj0BeMV5IO5t61Yfdw6hANPZU1opt3+upu0BUhj50pQOH3xnwSfFzXBl2JXFw7LACcoDlsJc
	4N8AbsA8aerneKetfXnfmy9AjYVJJ0DhdFcYHgpOMW2/qJPfWV8iFLTf/mCQOE9LubA==
X-Gm-Gg: ASbGnct8nyykmb1LGvErJ41AHuzQ9j4i0uQwPfOHIZzXhvWrvCzYH0d11GjWwFpJKAA
	aXmHGkpvf/fibKE7XnQ2kxPJc4LjESWGWThccZT1cAvsGvrgrSIUoYMz0m0DTGmtY6LNoLwEdxj
	5Bs0acXcjuoaTj77YFNuxnuhPGeOuFRON8RbaXnfZiNUwLZRNEViU95A5OiAONZfX/Cd9K4M5BS
	tjQmSVt/TJN04QwHJ0k8R+qXdO5k6eIfShJddN2lr7DKPkm0MJrT/I/VGkrxzBts5Ue3+B7f/ik
	fLk5J8J/RoxMH+WDt438R9tzitNGQFOz7he4EoRjDJ4heaYjoXJ3begXn9Gq
X-Received: by 2002:a05:622a:4110:b0:4a6:ef9c:eaf6 with SMTP id d75a77b69052e-4a9ec7fc1a9mr45333411cf.41.1752160868721;
        Thu, 10 Jul 2025 08:21:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuCfhZPQ7Idmvh1qtK7kQPM/uffYT3OzQJBiz87ujd30b3ETbzpQriwnIDdG+tuY1zMSqkBA==
X-Received: by 2002:a05:622a:4110:b0:4a6:ef9c:eaf6 with SMTP id d75a77b69052e-4a9ec7fc1a9mr45332871cf.41.1752160868384;
        Thu, 10 Jul 2025 08:21:08 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edeee2c2sm9654471cf.74.2025.07.10.08.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:21:07 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 11:20:26 -0400
Subject: [PATCH 06/15] rtc: rv3028: fix incorrect maximum clock rate
 handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rtc-clk-round-rate-v1-6-33140bb2278e@redhat.com>
References: <20250710-rtc-clk-round-rate-v1-0-33140bb2278e@redhat.com>
In-Reply-To: <20250710-rtc-clk-round-rate-v1-0-33140bb2278e@redhat.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Akinobu Mita <akinobu.mita@gmail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Heiko Stuebner <heiko@sntech.de>, Andrew Morton <akpm@linux-foundation.org>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 Mia Lin <mimi05633@gmail.com>, 
 Michael McCormick <michael.mccormick@enatel.net>, 
 Heiko Schocher <hs@denx.de>, Parthiban Nallathambi <pn@denx.de>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752160847; l=1044;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=y+AZFWJL051hZPxzrLPHAl9zoCHqdwam8bIR61IfRhQ=;
 b=0KJSbBt0DCZNkUMOmwxns1NITMSVMXCg2QJNQ7+FpDcQdwXvMZxfWyFb+ZQw34oW708cql8Z0
 8ZzDlOPfUDOCuuTRShwnoG3D5ui88qCACdqmSjcf+TQTW6jSrQvcPZi
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

When rv3028_clkout_round_rate() is called with a requested rate higher
than the highest supported rate, it currently returns 0, which disables
the clock. According to the clk API, round_rate() should instead return
the highest supported rate. Update the function to return the maximum
supported rate in this case.

Fixes: f583c341a515f ("rtc: rv3028: add clkout support")
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/rtc/rtc-rv3028.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index 868d1b1eb0f42e8cdf2895033c24f0d2690587ca..278841c2e47edfefd339f04bf5193f6970ba0c65 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -740,7 +740,7 @@ static long rv3028_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
 		if (clkout_rates[i] <= rate)
 			return clkout_rates[i];
 
-	return 0;
+	return clkout_rates[0];
 }
 
 static int rv3028_clkout_set_rate(struct clk_hw *hw, unsigned long rate,

-- 
2.50.0


