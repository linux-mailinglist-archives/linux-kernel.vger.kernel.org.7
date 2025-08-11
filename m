Return-Path: <linux-kernel+bounces-762640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFD9B20941
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B863AD626
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0212DBF5C;
	Mon, 11 Aug 2025 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyVsjbGc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67B02D3746
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916530; cv=none; b=baefDnXU85Ie2Aib1IQEUq59/yQO18amwnHfhLkg8yuESyYDcsKvu68eVdvIIVTj7sYs4jxucnDx1RejmGPxHgtnoph0XWIahl6ulC9UBhT47xpSbEjfwMhTlDF4y63nAKhso79YN+M0wpQzwsFgbp5cN/spNSJgzx/gQUOejaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916530; c=relaxed/simple;
	bh=KZev2woXWU9HznU+gcnRnr0OtzfEyHcHVt06Cr6pNMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ILakO9ifaZrd8/+73Zv2YziHhS8iSKdO/6+qxYu3y9LKPSnSuBe0xOkkLXu3ggJlXXAXHNZPVrzWrLVNmklXbmQouvGpVhAIp6FqONaqQnwR7fseUh+dxg4ZHgsS6sp6ho3LYa4gTMQODIN3ZWDFmFnnfiz03yrDbvivqXa8olw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RyVsjbGc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754916527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kv4JIx5nA2wF0cDefvytjovFmfVgfiGYSd/ZtzOrYfk=;
	b=RyVsjbGcKv7GxhEVyS4uT84u+6pjrLmtHtm4pdmIIWuxuC10bu6FIV/iceIzRvRnMqiFi+
	E3aMac8ci8xUSGQBWA1OckCXcE9pUj8HjkNGZU/sPDkGSj0gxeAalp7RTenoJPsusg8Ea6
	UkyLR1D7EpEUsAsgMs1li4jv8/LjkWc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-M5pysz6BPqCr8pIjLqM7GQ-1; Mon, 11 Aug 2025 08:48:44 -0400
X-MC-Unique: M5pysz6BPqCr8pIjLqM7GQ-1
X-Mimecast-MFC-AGG-ID: M5pysz6BPqCr8pIjLqM7GQ_1754916524
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b08b271095so119891111cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754916523; x=1755521323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kv4JIx5nA2wF0cDefvytjovFmfVgfiGYSd/ZtzOrYfk=;
        b=XmwsLTeScVVD122QumdihLw529PO6bdjtMHWJAkjYWIcktTRu5vc1UpfRmczLHwotL
         Wd6MMbYo98MTKbh4+gGqHIiHmp98hX1Xpld/17SMUCPJsE0lqHu3+xYejeH+D5JLN3rH
         yhpOAu4jRfGWASIiIhqz7GlJad7ezHEuK7/pMXigKCeFgYkspgzsLZ/23IE88IllNTqS
         O7KbNxTivSNsUSmNMuOkLJmuerTg8j8iLyfI1Hl3dhUO/RufhE6Kv+v8HH/PWD0DH31p
         i8F5KxSECmeRyWppeGkVJknpN717re05XR9o8HRzScpORVXIm6vbnopmPd4VRNXHn5ln
         9awg==
X-Forwarded-Encrypted: i=1; AJvYcCU+9OKx2rkp1NBBv6AqW9euZw2qnwofa2wYSvpkiLC+jSI4TakOLVhMSoYt6dx8meZLV8U+dlD8z/5LVXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPidIu2XwB4TGvEaGsDfBsPa0uMC+1imGnDA+TZnJDcVgaxJc3
	oi5A8YpCeG9rW4tjDnFxBMdPW+4hrhexAkgYDipd8MkdG3ku9371pNBepZ/2krwzBQkWyPBTf9N
	YvUg8t/XmjHH59la0eq31OhpDsKreq+LkdheOFvh4DeM8o6rWqurEol1XMCFKzONOYV46U191OG
	mK
X-Gm-Gg: ASbGncsQ5CgLa48vQLq3KzVxY741RA5N6JCtJycUJwH6g2vAtT1mhqbjcPcb6/CB1ZP
	FhsO2EWgxMd7eWkD7f60HzZ+cNRntU4uy1RtyV6BkO8MnMXCM2bVfuiSnPhcIEnUYKwBL9eRKZ6
	2Rtv6RbJ+3pZbS7DQllIaXD1CXHnn1PUq9LMn4Hqv65oEFyW5lOEr2kzCgVNy15yXZr5hNVsryq
	uGYtFwxT3pnGf3InwuNKJjDu+b+x30+6Fz33H+5TGgiReot1mzi6ykfr4dwDlyiRq1Djk1ko8J8
	eVnLshU7rZjkNEBRB3ebJ7B8pAImZzkIzXNm7F+HNayG+3JZMre9KHUcbD1PBXOouae7W4KrWYy
	85uU=
X-Received: by 2002:a05:622a:11d4:b0:4b0:70d2:5dae with SMTP id d75a77b69052e-4b0aedd7c6cmr184053631cf.32.1754916523236;
        Mon, 11 Aug 2025 05:48:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/s9J1rhGKt71vKkorwhvcmkFojr3YuVPBRRrYFELwpV8zzT+UTulziPC71u8GjxQnYOpeGg==
X-Received: by 2002:a05:622a:11d4:b0:4b0:70d2:5dae with SMTP id d75a77b69052e-4b0aedd7c6cmr184053171cf.32.1754916522674;
        Mon, 11 Aug 2025 05:48:42 -0700 (PDT)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aef746b6efsm138724001cf.15.2025.08.11.05.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 05:48:41 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Mon, 11 Aug 2025 08:48:10 -0400
Subject: [PATCH 5/7] clk: ti: divider: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-b4-clk-ti-round-rate-v1-5-cc0840594a49@redhat.com>
References: <20250811-b4-clk-ti-round-rate-v1-0-cc0840594a49@redhat.com>
In-Reply-To: <20250811-b4-clk-ti-round-rate-v1-0-cc0840594a49@redhat.com>
To: Tero Kristo <kristo@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754916502; l=1648;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=KZev2woXWU9HznU+gcnRnr0OtzfEyHcHVt06Cr6pNMU=;
 b=9HtWsQuOhfM98X55HNWOck7M08AwApUYonHPDgwcZa8S/UhZwBGL/lFQadP95RXlxeEt3lQtd
 BZJ3vwA7z0fDwJ7YnZJoOWmOvTB+trUUgK5JvgAJBPVoJnuqf7KVZLm
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/ti/divider.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index ade99ab6cfa9b18e5bcfb616273b5c06637035c1..6f58a0f2e74aec14fd3711d722e66b6ecbaef104 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -223,13 +223,15 @@ static int ti_clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
 	return bestdiv;
 }
 
-static long ti_clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
-				      unsigned long *prate)
+static int ti_clk_divider_determine_rate(struct clk_hw *hw,
+					 struct clk_rate_request *req)
 {
 	int div;
-	div = ti_clk_divider_bestdiv(hw, rate, prate);
+	div = ti_clk_divider_bestdiv(hw, req->rate, &req->best_parent_rate);
 
-	return DIV_ROUND_UP(*prate, div);
+	req->rate = DIV_ROUND_UP(req->best_parent_rate, div);
+
+	return 0;
 }
 
 static int ti_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -299,7 +301,7 @@ static void clk_divider_restore_context(struct clk_hw *hw)
 
 const struct clk_ops ti_clk_divider_ops = {
 	.recalc_rate = ti_clk_divider_recalc_rate,
-	.round_rate = ti_clk_divider_round_rate,
+	.determine_rate = ti_clk_divider_determine_rate,
 	.set_rate = ti_clk_divider_set_rate,
 	.save_context = clk_divider_save_context,
 	.restore_context = clk_divider_restore_context,

-- 
2.50.1


