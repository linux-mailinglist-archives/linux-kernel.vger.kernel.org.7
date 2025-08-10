Return-Path: <linux-kernel+bounces-761627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA77B1FCC1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968953B3D44
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B252B262FE7;
	Sun, 10 Aug 2025 22:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpT1zlRW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D4419E7F9
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754865159; cv=none; b=o9gt5JbYakZKNmUDa3lygLU28J4wwmjIcrR9lvhPPqcgQnK1oJfPfz4K6/zy0Hb3dEuimQfWjtnDap+5itzMpGIxlGDgze2cgjlWJHy6x0EXtiKkBAbJ8R6nuGyLldPq80T8H7YQbolFZsdS6+XdEPqdy6RfG52mEmfnKplL8Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754865159; c=relaxed/simple;
	bh=A9FV1U7CIAy2NMAbPMRyp4dSSbe66HlO+3+lB1waQDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QvpYUf3I9FzXlD1JWDbppFM1xV7/FbKbNBewaWxFJY3Pkv0RGJehobSEE8lemgvqM+Fznwc4tzfgFa5Q1SxB/NM3X2OVMElJRfuZ+ISRtZvrD/9ywFSNElmgGVSlKfQdj3gCqtfTh0tlgIp99rK8WVAMJDAZ/pk20aW2tfrzgEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HpT1zlRW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754865157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dJb7rUsTB9SkaGqYqp/qaoDTrI+nSvgfo1YbIvP11Sw=;
	b=HpT1zlRWbCwIgCzW1yFez6cFBBjOL6CszpaOQyZoruyzjPtfO09oxp11SIoV6EdGv/6ae4
	uglYQhFaBDt+Apb502b9iCFprm/hRF1yM7snn4Fjt9koKToKXVNJwthj0cQy/xUMNa7e5g
	4HTMLBcXndJ+uqvr0YckZGy2tAftD9g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-1058jBbnOlqSiK64bpC09w-1; Sun, 10 Aug 2025 18:32:35 -0400
X-MC-Unique: 1058jBbnOlqSiK64bpC09w-1
X-Mimecast-MFC-AGG-ID: 1058jBbnOlqSiK64bpC09w_1754865155
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e809830338so1312323285a.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754865155; x=1755469955;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJb7rUsTB9SkaGqYqp/qaoDTrI+nSvgfo1YbIvP11Sw=;
        b=Xwf3Oe7SH0PRsNdJsq62VJuSl63JN3WsJT7cGVRSp69j+b/CTlJVPEer0d9hEKbEX6
         TEkCMtJHOnHaU0Z1ijy0j0VoDYfXQkzwBDh2m+iL6QOIeLLdAg3Hg2yEubtjVcPOMakH
         LmAl5G7KDNL9tmlRJ9GybVfgGt0D3+wOSu7fGle5KYP/BdupAwjXnbSBRWM/P57KfR1n
         sd0B2pQbZ6Yucwm0aV39P9zoSxhDJR3fcutSqsEUpx+Jgo97CRDHgInvDZxzfMtGvMWc
         soiW19NQL++eRkOWpDmsTL2wz4WU6y5DSJlaVjNDEomb6ZR02JXONXgpskOHQxXRz89o
         eQ1w==
X-Forwarded-Encrypted: i=1; AJvYcCVzLrxdB+UvLvkbYjXe4/6t92l2VgZY8PpcM1CJSMDwzQNSbJBOA9vWfUl9ToYE41BTQ7tTWs2loDsYKjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEfq1wFXMuLjUwru6N++TVGL8LUZgLkEHdf1egAuBLQGxyKOn4
	h2asw4QkY/X/OeMQycc82cv4tg/GeeenfpwZ3TjpfYfm/4X4oYtQ80Qyw2HNxnGDJ9L/Za28r9g
	gqZgjGKbLHTvLDLAd4WRzji0IaGhNoVU+zq30MncOqFyqrNxM60koIVoLywcoiZRMdA==
X-Gm-Gg: ASbGnctwpInMN2yVh4P4Q8YFM6umEukC9HHY/BezV4fPBFPp66p2AEHHuz2q/aDbutq
	HuNBSs6NcNbtMzYhp4k2E0ZCUJwps83Qwb/jCUsrKSZjCdaV83gbB91rGzRGRXeS4GX118dvGVU
	h4iaNHwAeI/Y7icUSWe15J33DvtStTNQhgT6miPAOMT7RorjAzgm1KpQ/zN9NcL7jUjGI9kBFDr
	G0Y5zEyPlXlCyDGI3yviCh6F6stArUD8+9BTAp+oIC/R8+lEuDsJzf0MuBEJoVBzJrkzmthxM0o
	xaZ764htq2LW2tXi+D4hoc6Hq86gb3AarEQolddptpb9mj8U2FQ1lSQY7gQKgP+/sYyoik3D9fh
	odO+EZg==
X-Received: by 2002:a05:620a:3703:b0:7e8:38ca:c499 with SMTP id af79cd13be357-7e838cac80fmr1065028485a.25.1754865155273;
        Sun, 10 Aug 2025 15:32:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSoqXWkVNdaecquXdS5RU3KxC5LuRgDn6mt5MAfNv86tnPuYxMv4lQllMkbIfhq0YBrZt9fw==
X-Received: by 2002:a05:620a:3703:b0:7e8:38ca:c499 with SMTP id af79cd13be357-7e838cac80fmr1065025585a.25.1754865154831;
        Sun, 10 Aug 2025 15:32:34 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e8040a9154sm966989685a.70.2025.08.10.15.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:32:33 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:32:18 -0400
Subject: [PATCH] i2c: busses: bcm2835: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-i2c-round-rate-v1-1-9488b57153e7@redhat.com>
X-B4-Tracking: v=1; b=H4sIAPEdmWgC/x3MQQqAIBBA0avIrBtIRaKuEi1Ex5qNxVgRhHdPW
 r7F/y8UEqYCk3pB6ObCe27QnYKw+bwScmwG0xvXD2ZENgFlv3JE8SehtoO1ziedfIQWHUKJn38
 4L7V+otXBD2AAAAA=
X-Change-ID: 20250729-i2c-round-rate-137335af1fad
To: Andi Shyti <andi.shyti@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754865151; l=5778;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=A9FV1U7CIAy2NMAbPMRyp4dSSbe66HlO+3+lB1waQDc=;
 b=/yTjwc3Hxiz4RhGMiIAb0N96c39PAyq5ltU0bkKcG+K4lHu3Hjn8KL9T1K+zvEXEwQTGuSUPS
 BGS1TacP1ylAqIILUY1oeqj6YDPbvJxC1+0OF/qIqCZOc1U51EKur87
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
appended to the "under-the-cut" portion of the patch.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Coccinelle semantic patch is below. It's large and I don't want to
pollute the kernel changelog with the same code hundreds of times,
so that's why it's included under the cut. For subsystems with more
than one patch, I've included it on the cover letter.

    virtual patch

    // Look up the current name of the round_rate function
    @ has_round_rate @
    identifier round_rate_name =~ ".*_round_rate";
    identifier hw_param, rate_param, parent_rate_param;
    @@

    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
                  unsigned long *parent_rate_param)
    {
    	...
    }

    // Rename the route_rate function name to determine_rate()
    @ script:python generate_name depends on has_round_rate @
    round_rate_name << has_round_rate.round_rate_name;
    new_name;
    @@

    coccinelle.new_name = round_rate_name.replace("_round_rate", "_determine_rate")

    // Change rate to req->rate; also change occurrences of 'return XXX'.
    @ chg_rate depends on generate_name @
    identifier has_round_rate.round_rate_name;
    identifier has_round_rate.hw_param;
    identifier has_round_rate.rate_param;
    identifier has_round_rate.parent_rate_param;
    identifier ERR =~ "E.*";
    expression E;
    @@

    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
                  unsigned long *parent_rate_param)
    {
    <...
    (
    -return -ERR;
    +return -ERR;
    |
    - return rate_param;
    + return 0;
    |
    - return E;
    + req->rate = E;
    +
    + return 0;
    |
    - rate_param
    + req->rate
    )
    ...>
    }

    // Coccinelle only transforms the first occurrence of the rate parameter
    // Run a second time. FIXME: Is there a better way to do this?
    @ chg_rate2 depends on generate_name @
    identifier has_round_rate.round_rate_name;
    identifier has_round_rate.hw_param;
    identifier has_round_rate.rate_param;
    identifier has_round_rate.parent_rate_param;
    @@

    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
                  unsigned long *parent_rate_param)
    {
    <...
    - rate_param
    + req->rate
    ...>
    }

    // Change parent_rate to req->best_parent_rate
    @ chg_parent_rate depends on generate_name @
    identifier has_round_rate.round_rate_name;
    identifier has_round_rate.hw_param;
    identifier has_round_rate.rate_param;
    identifier has_round_rate.parent_rate_param;
    @@

    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
                  unsigned long *parent_rate_param)
    {
    <...
    (
    - *parent_rate_param
    + req->best_parent_rate
    |
    - parent_rate_param
    + &req->best_parent_rate
    )
    ...>
    }

    // Convert the function definition from round_rate() to determine_rate()
    @ func_definition depends on chg_rate @
    identifier has_round_rate.round_rate_name;
    identifier has_round_rate.hw_param;
    identifier has_round_rate.rate_param;
    identifier has_round_rate.parent_rate_param;
    identifier generate_name.new_name;
    @@

    - long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
    -               unsigned long *parent_rate_param)
    + int new_name(struct clk_hw *hw, struct clk_rate_request *req)
    {
        ...
    }

    // Update the ops from round_rate() to determine_rate()
    @ ops depends on func_definition @
    identifier has_round_rate.round_rate_name;
    identifier generate_name.new_name;
    @@

    {
        ...,
    -   .round_rate = round_rate_name,
    +   .determine_rate = new_name,
        ...,
    }

Note that I used coccinelle 1.2 instead of 1.3 since the newer version
adds unnecessary braces as described in this post.
https://lore.kernel.org/cocci/67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com/
---
 drivers/i2c/busses/i2c-bcm2835.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 8554e790f8e36c5a1cf56c0aab8556b377f2bbdf..0d7e2654a534e92a529f27fdc049812359678522 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -137,12 +137,14 @@ static int clk_bcm2835_i2c_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
-static long clk_bcm2835_i2c_round_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long *parent_rate)
+static int clk_bcm2835_i2c_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
 {
-	u32 divider = clk_bcm2835_i2c_calc_divider(rate, *parent_rate);
+	u32 divider = clk_bcm2835_i2c_calc_divider(req->rate, req->best_parent_rate);
 
-	return DIV_ROUND_UP(*parent_rate, divider);
+	req->rate = DIV_ROUND_UP(req->best_parent_rate, divider);
+
+	return 0;
 }
 
 static unsigned long clk_bcm2835_i2c_recalc_rate(struct clk_hw *hw,
@@ -156,7 +158,7 @@ static unsigned long clk_bcm2835_i2c_recalc_rate(struct clk_hw *hw,
 
 static const struct clk_ops clk_bcm2835_i2c_ops = {
 	.set_rate = clk_bcm2835_i2c_set_rate,
-	.round_rate = clk_bcm2835_i2c_round_rate,
+	.determine_rate = clk_bcm2835_i2c_determine_rate,
 	.recalc_rate = clk_bcm2835_i2c_recalc_rate,
 };
 

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250729-i2c-round-rate-137335af1fad

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


