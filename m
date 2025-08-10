Return-Path: <linux-kernel+bounces-761629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C85B1FCC7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A8C1896D62
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FF5245008;
	Sun, 10 Aug 2025 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eq6tYMJT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3915C1EA6F
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754865458; cv=none; b=Uh7DapqmHLu+00Sp0iQxNPtluNlACLkIOfkd+38sl7CcrM6zMYuDFqj1LagMuQTi+Xv2Ed1+yWz5X7RVshNW7H/96FUQY9vLGfMp2gOfTX73s2ZZSF3zHdjXhvgknQK4IoPSoVzLmtnDeAmv25MmHLd25eoGf+FTXbaTYYW/phk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754865458; c=relaxed/simple;
	bh=meq0bX7mDoXROc9zguZ8B+x1Av8NFVxhuJLsAfGxMM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Xqcp8ry0PJOcoXj7D1M0VaB/ktj0W0HVqxd+V5vziLQw935ryVgvt+AzFIynygMoQ1TqUXLZdcxP/DRuza09BzE8ci2xgQG9Yh76OeJtSIbMXrCZeMHp4+1aeRkuA/9CfXZ2zsueEnahyXkY/HYSwel3PZe6YKm25QaE8yKe+qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eq6tYMJT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754865455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a+XJl/ofyE5M4mj3w7aAb/RfjRLgr/5H/Di0mrRB1LI=;
	b=Eq6tYMJTrDR387huwTWNZfj9rHDTZrSarTqbK9961jfRVEwMfidT7632B/Xf+5NJNxO81Q
	rsyh22gVR0faHunAZztTd2G6lkkJUb6NnKjmuXK8lpHRj+6xuU1h1DwdXY2UcEVnMVi7fP
	jUt247GaTEbJH77DlbrwnW5z8zgdNsU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-pcRYMKQiN_OUUqEabHsXuQ-1; Sun, 10 Aug 2025 18:37:33 -0400
X-MC-Unique: pcRYMKQiN_OUUqEabHsXuQ-1
X-Mimecast-MFC-AGG-ID: pcRYMKQiN_OUUqEabHsXuQ_1754865453
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70739ef4ab4so88357226d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754865453; x=1755470253;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+XJl/ofyE5M4mj3w7aAb/RfjRLgr/5H/Di0mrRB1LI=;
        b=Caog/G3MQBrGYYnE1AM6fQI8juBjjvd1IHKhbTMabIN5XRif4TwCYADx54XWKitIR7
         iN/q7sstQM5kaI0xBEKH0iIi3ELGkqBiNjKg18OXqIjkImRto5rAbD2zcoR7hPzSFqnP
         qlPCCuTef5aJzXx4MH3N28H/D1eRslnwSgbdYfi69d09p07Z8bSY/uVg9Boj03bXaAl3
         CBQppD6On9Nwabgcs7TEuSCVZPFBfU0CAcejwuujrRlxfeDzxKCpLNuRYcnX3bZknSNT
         DOapt6Cm2VcYGagBrIlupGXAyQ6xS+0w5xP02BlaApUayjs/EEyLfsJwIP+EIIqOkM2d
         VBKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs1xmLtn7zH3S0cRdZFkQxk6qzwgBeAoquHaYfeQwRM/2nE5gDoflmSTYxZ8YSF30XVu0rWGb5NWj0us8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFQ1+aPZjRlLapOaL8u/I+/jyVSJFkYWh+7q5nE1eyE5qiJ+nk
	tBjwiHKUzl+7uzDd9TKmjQOqzrz+xaKXehNiZJ/ZOZJCbqRe+DWtm1/bAn7CWunJ0WX905q7lwV
	ZNveLVzcEnNcchC2OAx4kGXKvcgeIBAt37T15Dpj7d4zk4xRTzYKin7OBjE0NC6wYX6mYuVll9w
	==
X-Gm-Gg: ASbGnct5zkEDk0UB93y1L1eC+IaVPnjjBb5ECjZ9Sp9FczJONs1tx/PakuWM/qvspKL
	+0fjiGn9QNyUzWB/Mq+In2pA7sy0cQlNCd+6DxsrD6V3BqNiHjqh5VAsBbi6pzagVDUon8Bv+v3
	I0qgAWb0ZWKC2q71VK0yJUL15kAQPqGFqT2poL63e7FwCHhEeZvrVM/9Ll38YCPSJGe9slFCOcp
	brg/ZLbjH30ldI4Y3anxd3mG7saomAOsa8J8RmVG1AV2ZbIhrPFW+RfNLAtSSa5QA8RSkh7qOau
	FqSxKos847+XCFxWWcLAJ0MGA06atvCAKsLCyunfY/aMVrJteXiGsIikY10JZ9Btic/4DqdXWss
	fa0Z6bA==
X-Received: by 2002:a05:6214:f21:b0:707:3c3c:39ed with SMTP id 6a1803df08f44-7099b655f18mr151097646d6.0.1754865452732;
        Sun, 10 Aug 2025 15:37:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzCJW32oe98GKQXmd85A7B5PLB1EPuwgRFHWt7z/lpPyjUYJGVx8hiHq2jmHPMRcrjYmpBNQ==
X-Received: by 2002:a05:6214:f21:b0:707:3c3c:39ed with SMTP id 6a1803df08f44-7099b655f18mr151097446d6.0.1754865452269;
        Sun, 10 Aug 2025 15:37:32 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077e263efcsm144763386d6.85.2025.08.10.15.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:37:31 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:37:10 -0400
Subject: [PATCH] clocksource: ingenic-sysost: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-clocksource-round-rate-v1-1-486ef53e45eb@redhat.com>
X-B4-Tracking: v=1; b=H4sIABUfmWgC/x3MQQrCMBBG4auUWTsQA02rVxEXYfJrByWRiS2F0
 rs3dPkt3tuowhSV7t1GhkWrltxwvXQkU8xvsKZm8s73bvA3lm+RTy2zCdjKnBNb/INHRIQUnCA
 M1OKf4aXrOX489/0A3e4FmmgAAAA=
X-Change-ID: 20250729-clocksource-round-rate-8eae6d60ce67
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Maxime Ripard <mripard@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754865441; l=6634;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=meq0bX7mDoXROc9zguZ8B+x1Av8NFVxhuJLsAfGxMM0=;
 b=07y06Mp/1nerDBs5szSBwoA7sp3zjViOMSYcOsDPZb+WUlA1fKy2L1L81AmRJOd0xc9hPleCU
 QLTx6xjR1Q4D3KozgqTJNjP/ytvNAnO63+PhgerzVjEZw+tzt80P+8I
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
appended to the "under-the-cut" portion of the patch.

While changes are being made to 'struct clk_ops', let's also go ahead
and fix the formatting of set_rate so that everything lines up as
expected.

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
 drivers/clocksource/ingenic-sysost.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/ingenic-sysost.c b/drivers/clocksource/ingenic-sysost.c
index cb6fc2f152d467bbb2777f39eca94eb33dd4e179..e79cfb0b8e05f68896bc4e6caf6597bfe41c91a2 100644
--- a/drivers/clocksource/ingenic-sysost.c
+++ b/drivers/clocksource/ingenic-sysost.c
@@ -127,18 +127,23 @@ static u8 ingenic_ost_get_prescale(unsigned long rate, unsigned long req_rate)
 	return 2; /* /16 divider */
 }
 
-static long ingenic_ost_round_rate(struct clk_hw *hw, unsigned long req_rate,
-		unsigned long *parent_rate)
+static int ingenic_ost_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
-	unsigned long rate = *parent_rate;
+	unsigned long rate = req->best_parent_rate;
 	u8 prescale;
 
-	if (req_rate > rate)
-		return rate;
+	if (req->rate > rate) {
+		req->rate = rate;
 
-	prescale = ingenic_ost_get_prescale(rate, req_rate);
+		return 0;
+	}
+
+	prescale = ingenic_ost_get_prescale(rate, req->rate);
 
-	return rate >> (prescale * 2);
+	req->rate = rate >> (prescale * 2);
+
+	return 0;
 }
 
 static int ingenic_ost_percpu_timer_set_rate(struct clk_hw *hw, unsigned long req_rate,
@@ -175,14 +180,14 @@ static int ingenic_ost_global_timer_set_rate(struct clk_hw *hw, unsigned long re
 
 static const struct clk_ops ingenic_ost_percpu_timer_ops = {
 	.recalc_rate	= ingenic_ost_percpu_timer_recalc_rate,
-	.round_rate		= ingenic_ost_round_rate,
-	.set_rate		= ingenic_ost_percpu_timer_set_rate,
+	.determine_rate = ingenic_ost_determine_rate,
+	.set_rate	= ingenic_ost_percpu_timer_set_rate,
 };
 
 static const struct clk_ops ingenic_ost_global_timer_ops = {
 	.recalc_rate	= ingenic_ost_global_timer_recalc_rate,
-	.round_rate		= ingenic_ost_round_rate,
-	.set_rate		= ingenic_ost_global_timer_set_rate,
+	.determine_rate = ingenic_ost_determine_rate,
+	.set_rate	= ingenic_ost_global_timer_set_rate,
 };
 
 static const char * const ingenic_ost_clk_parents[] = { "ext" };

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250729-clocksource-round-rate-8eae6d60ce67

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


