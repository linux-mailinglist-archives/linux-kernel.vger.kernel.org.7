Return-Path: <linux-kernel+bounces-762639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 386E9B2093D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465871888C71
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34452D3A7E;
	Mon, 11 Aug 2025 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqV/Npl4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68062DBF5C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916525; cv=none; b=pCAlS9s4D/RCaQo74J03Y0vlV2ysTof8/E9fKMYxt2cRHYhYxKe2B4j2KMrI4AeLs6MotZUECH1IdBaZwjOE6P3L3FbnBDjZTtQeSdXnzxW9qAoANGa17tIB1gU/sg+Ri0ghCDDJrqPBmkopxtFE97j3f0kDnC9a4PXtM27l6AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916525; c=relaxed/simple;
	bh=d4r/MgwDOiJAMmN6yEZ45olvnlGBMIdC6u8+ioBthwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oAH1lfHA1iu84amsSwmaxWN5a3tq+npAmAJSgKsVSS7dftiszbmosLEKobBM3Zig9Wkd7jmYE0XJsS5I161tv0Q+jlfw3+kSTG5q+f4DbstetfXvwpUmAwNWgel+W7xCkHmUNtV1gxLUOB2raPq+J7XAavhEwIsV7kNkUw7ZObQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqV/Npl4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754916522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0FabGW93p0o5EPz68evGzI0JKQlCaJUZlHooFwdD+8=;
	b=bqV/Npl4hmVau0WR2bWNZaGTqsnJUiqRA2vXaaHuGNgM15FDk4J9AopetSFCFAq9GR6zv2
	mPsYJov0PVgi+jyWvuTpV5PeHuxyiPm1JhK2Y2lpuoAU06EHy6up+Flzyfm6OauGput0AT
	TJjk1UXe9E0pN7lGdHfKoIgpyub8sho=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-ecIQ4wwQN_etArhvZBNzXw-1; Mon, 11 Aug 2025 08:48:41 -0400
X-MC-Unique: ecIQ4wwQN_etArhvZBNzXw-1
X-Mimecast-MFC-AGG-ID: ecIQ4wwQN_etArhvZBNzXw_1754916521
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e667b614ecso940887385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754916521; x=1755521321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0FabGW93p0o5EPz68evGzI0JKQlCaJUZlHooFwdD+8=;
        b=mAqcDx1xn8lJRZmahBqag7epqrqLLTlH0r6ogbzMekUCM3srR/FEl3ElF3WEXKqL+f
         ZBIHhg/SAqf3L8p54j8ZSCeyt26KqWHx0DGf7piO7SEYm4l1bpV8ZPOaOGmcsQysLb7T
         OTDkcqYNslLUGeulmLo18cBLsgXsHGO2rX5+kpmiYU9mHcn1PXfH1BEOKliKKEeiEEUP
         CXtRkrscArQh9v9IF+Gnf4ZhqOsaJ1JAN4605/k6jkIWE0aNFmYT8tZrITImxxr3RomQ
         2pZLgrFWIv8Ul2RnbLdYhf15ep3/KI5HJWr2/mGuuPbO4aWS6A6Cnw4/qxZhcWDo5WzT
         uHyg==
X-Forwarded-Encrypted: i=1; AJvYcCUhViYuNSuQvLeSNXdd4oLeIJ8xZZNAM8wma8UsIgAi/5O09XOBJTyLeaIoJ2vHeHCXb0rDTAxkWClNT+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCGCdAOHpMAyptIwyI5SchF7QJUZd5pTe/uF7pcd5XVzN6AeBm
	CzyYwiAa3b6bqr2h3c3IPevgjid9aKc2YJ7VnMEWbT9h2UGcxR56Wn19ZVAr24mDCRSyTXxXp0a
	RzP13yFPQ9dIXlRKiYOOvbP4scboMDgDDmpFvfMj226028TeaD5px8YtSDikouZDYxA==
X-Gm-Gg: ASbGnct0xhwb5SR4TWlFwJREQCcan0j/gFogYtQ5Gbo4VvxvSwO0kBXiZRWHpCGtMkM
	Fs/mJnTJt8eqx0hUkoOD/SyTcLGHZETYNd0i9RZ+91Bqap6DLfdIplxI9mo70yO7d8q9ksKJI7O
	7GBzO+c1SSUoSngqX1R/sYgrvQTzpfi/HpYQiqAgQlFu4FDbcJztQAjro2SrhcoREarO2dBV2ti
	R3tdzL8F/A5degRnpxUmgdZ5NJx6efp19TZF6urd3SzTbY6vpjPAE/2wCHxEPD9XR9f/6jL138B
	XPOH3xEawDsrqb2PhBPvXceSi4/pDQWsHfNDzpBMMzrQkYYXQieZqWy88XQm7RbtL8+/dVGONBI
	fduU=
X-Received: by 2002:a05:620a:4556:b0:7e8:34b0:6dcf with SMTP id af79cd13be357-7e834b0732emr1628906985a.5.1754916520760;
        Mon, 11 Aug 2025 05:48:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH5IG1XDFEMzQnjy90UyXWsCI+yyADgd+lMpmJS7oWuILs7scGAfZnwRui0gk7c+GtmHKWGg==
X-Received: by 2002:a05:620a:4556:b0:7e8:34b0:6dcf with SMTP id af79cd13be357-7e834b0732emr1628901385a.5.1754916520169;
        Mon, 11 Aug 2025 05:48:40 -0700 (PDT)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aef746b6efsm138724001cf.15.2025.08.11.05.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 05:48:34 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Mon, 11 Aug 2025 08:48:09 -0400
Subject: [PATCH 4/7] clk: ti: composite: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-b4-clk-ti-round-rate-v1-4-cc0840594a49@redhat.com>
References: <20250811-b4-clk-ti-round-rate-v1-0-cc0840594a49@redhat.com>
In-Reply-To: <20250811-b4-clk-ti-round-rate-v1-0-cc0840594a49@redhat.com>
To: Tero Kristo <kristo@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754916502; l=1303;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=d4r/MgwDOiJAMmN6yEZ45olvnlGBMIdC6u8+ioBthwU=;
 b=ZXYI0k5UF214vcjvF2S5pTp2vZZGvwDBNbWPCyvcQChrwBFslhaaWy3Uye/F5OEI+WDcrXqb3
 bukwMYnrZdVD6xRhNkTv4k1shexBAsgCQNHEasZdWAnesixMa26c530
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/ti/composite.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index b85382c370f7e49ae320c6c47152a2675ca36645..8cba259188d412fee179efe0ffc5df627e42e3eb 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -26,8 +26,8 @@ static unsigned long ti_composite_recalc_rate(struct clk_hw *hw,
 	return ti_clk_divider_ops.recalc_rate(hw, parent_rate);
 }
 
-static long ti_composite_round_rate(struct clk_hw *hw, unsigned long rate,
-				    unsigned long *prate)
+static int ti_composite_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
 {
 	return -EINVAL;
 }
@@ -40,7 +40,7 @@ static int ti_composite_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static const struct clk_ops ti_composite_divider_ops = {
 	.recalc_rate	= &ti_composite_recalc_rate,
-	.round_rate	= &ti_composite_round_rate,
+	.determine_rate	= &ti_composite_determine_rate,
 	.set_rate	= &ti_composite_set_rate,
 };
 

-- 
2.50.1


