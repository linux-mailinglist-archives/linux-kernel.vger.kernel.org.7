Return-Path: <linux-kernel+bounces-761626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A53BB1FCBF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B841894F5F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D417E20C494;
	Sun, 10 Aug 2025 22:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cps7ygPr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809EE1C8621
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754865043; cv=none; b=i7izB1qZuQIXTxH9PIHWwIv7gYKJhChfQjicPY4aF38KROopTk7dt7uhLTVELDMX61B3gGT62EpRVRaY78vdSb++CPcJdfTbYQ0JDkMBhVq+UFAdMExGrjmE/7c5zWqZzOwH9LA76dcRvS3Wm8aU6i+/Ng4NteAcLsVdEqaakBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754865043; c=relaxed/simple;
	bh=PaIqapfL+DjRMGEaBBu4F5Fpc+GOWjfzetRRheyL8Xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RK/BuquYEVY6qla9KTn1thSbeTPNvE+oK7t9EYc3qw6g1MM8otAJGsxpbR6LCqv/5fdqOCqMn8vEBK7gO5JY0Z2e/EkasYhfwm8lpPJUHbpa+IkpIIGiqu/NSAXd3ePXk9nfsC+zA+rYMInFdHoe/r+s9eczbMM+TPMwA0w4nPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cps7ygPr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754865040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ieAkdnJ10m1Sx6BAI31JKL9F2di9xBYyM5tJkRAXngs=;
	b=cps7ygPrlUmk88a0oAAlyvxkXf4q79Ei+S2MWN23ctaosukzEaov3gWQOZhl7x2sGpiArJ
	kiZKODO4xaIOcOIlZ+88MtPuhRwFW+8HmlI+twirrb/c7KP1H2FrJSpx+nWD1CHKrl4oMB
	5XzUDhu1Va8HrTV3gK3LTagKceXuE8I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-Si1SgPrxPl-temh32yaEbQ-1; Sun, 10 Aug 2025 18:30:37 -0400
X-MC-Unique: Si1SgPrxPl-temh32yaEbQ-1
X-Mimecast-MFC-AGG-ID: Si1SgPrxPl-temh32yaEbQ_1754865037
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e82a101470so706214385a.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754865036; x=1755469836;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ieAkdnJ10m1Sx6BAI31JKL9F2di9xBYyM5tJkRAXngs=;
        b=pkrNn/54+fo6WI5ZL059k7BZ68T+7eXWRA/W56IsgNn+VKrax4qw6DIBOacugEgdUJ
         1CWZqJvlOb3GRw/2vk3gwXZB8Pwe0NX+GpWdUFH5iwHM5wqDYhzgtEF/GoLbS7khX7a8
         mo/Y5f+bJoQ4Cdy1+htA/oyx8xBPS9c7M7h2AyDXyk52p46+pu4PvJ+i7JlSAHFA46+l
         2Z2njLVK5PMmkxncOWC4ivViaiFXRqFIs6YOqsR+pnaS2f7rsWtR6uBwo3AoQA9tsjex
         jSm9yIZX6iEKcJnxlWgr/34JgGq1hmzo0ebGSzjaqSWBtoiHqTE/aRCBdV+gOrqk52XI
         BOYg==
X-Forwarded-Encrypted: i=1; AJvYcCWgv2LklKU1tJuhsOtva7QGAL5ecaKs+MNk4ppoim7xaYKco+dl99g5lPgpNZlcsQthrd0uZ3c/K1gMrwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsWI9vkvMIeTArvXIhchcUcV8rhEzTix5t2rOKmIcpPLORwTjI
	F5MqLflzpK31BcAaDzjmNpa+i7dZUmjTLeNxt2MjOeFy9rBQGlCjgXg/Ln2Qy6c9qrwAe9qIxA5
	7GlvgGGa1o/opvmPUR2Z7sFN4eI/eLCTZ0ULf88YCxxuulZn4pD9VJj5r1Vexu7gtbA==
X-Gm-Gg: ASbGncvRrM3xiy41p8Hl6+Rd8TpMbOVpQpntWDBP2GVxrLI3FEPCfgpahPTXo9+na6W
	h6Fw2jYHO3CtyGA5bOCqow9uLj7y/YSLV9Z7I6ubqvmnmNueL4q/+DVL585zjQaCOz+gz14DANH
	hG8tjwGGipjgWLLin9qtJiRZP7RBCfSJjzeGdXhaVIkzGZ4b6kTg1J9RyFuTQlLNVfhAHEsi07k
	4CewgsNP5g0SiWVKjoVQ2LNN0ke4OS4pncj9byb7CJsK8uwDltjuC7s40uO+LZFHOypOE6sBW5l
	Ihep3FgogsDk8uSxstb+22uqpYs/rJOnwvR/VLsyLdpEF+eyXg5bGUJPzkEeUtF4gZyH3LpUNHQ
	+a1cVog==
X-Received: by 2002:a05:620a:370b:b0:7e8:2e5:fe98 with SMTP id af79cd13be357-7e82c645138mr1580498785a.10.1754865036539;
        Sun, 10 Aug 2025 15:30:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS0cf67getZDl4Gt+j8YTpvX9pzg662I6YMcBsAYeJBVtCzQItl9qpnu5hbmqruylCHlPr6g==
X-Received: by 2002:a05:620a:370b:b0:7e8:2e5:fe98 with SMTP id af79cd13be357-7e82c645138mr1580495085a.10.1754865035933;
        Sun, 10 Aug 2025 15:30:35 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e83515176dsm364920585a.44.2025.08.10.15.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:30:34 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:30:23 -0400
Subject: [PATCH] MIPS: Alchemy: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-mips-round-rate-v1-1-54e424c520dd@redhat.com>
X-B4-Tracking: v=1; b=H4sIAH4dmWgC/x2MQQ5AMBAAv9Ls2SZUpPiKOFS72IOSLSKR/l0jc
 5rDzAuRhClCr14QujnyHrJUhQK32rAQss8OutRNaXSHGx8RZb+CR7EnoXe1m1ybMRpydQjN/Pz
 HYUzpAxsHGBFhAAAA
X-Change-ID: 20250729-mips-round-rate-dc3cbc8c8c72
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754865033; l=6032;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=PaIqapfL+DjRMGEaBBu4F5Fpc+GOWjfzetRRheyL8Xs=;
 b=ykH167+hDekDrl4mysbaadUzYrZg59ap2OqGOrQMAlFpdB/GKAc79NEFCzNAG76JyO3t45xYg
 m/4sD/vSAGTA5BnG2xwMRh0KyTA1ikzl+afZZ3mojyLDgLmAsPTfM4n
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
appended to the "under-the-cut" portion of the patch.

Note that prior to running Coccinelle, alchemy_clk_aux_roundr() was
renamed to alchemy_clk_aux_round_rate(). A few minor style cleanups
were also done by hand.

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
 arch/mips/alchemy/common/clock.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
index 6c8996e20a7ddc4ddaf924fc43a98c882c4110f7..551b0d21d9dc4b67d9909c0305db659daa8e84d9 100644
--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -211,30 +211,34 @@ static int alchemy_clk_aux_setr(struct clk_hw *hw,
 	return 0;
 }
 
-static long alchemy_clk_aux_roundr(struct clk_hw *hw,
-					    unsigned long rate,
-					    unsigned long *parent_rate)
+static int alchemy_clk_aux_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
 {
 	struct alchemy_auxpll_clk *a = to_auxpll_clk(hw);
 	unsigned long mult;
 
-	if (!rate || !*parent_rate)
+	if (!req->rate || !req->best_parent_rate) {
+		req->rate = 0;
+
 		return 0;
+	}
 
-	mult = rate / (*parent_rate);
+	mult = req->rate / req->best_parent_rate;
 
 	if (mult && (mult < 7))
 		mult = 7;
 	if (mult > a->maxmult)
 		mult = a->maxmult;
 
-	return (*parent_rate) * mult;
+	req->rate = req->best_parent_rate * mult;
+
+	return 0;
 }
 
 static const struct clk_ops alchemy_clkops_aux = {
 	.recalc_rate	= alchemy_clk_aux_recalc,
 	.set_rate	= alchemy_clk_aux_setr,
-	.round_rate	= alchemy_clk_aux_roundr,
+	.determine_rate = alchemy_clk_aux_determine_rate,
 };
 
 static struct clk __init *alchemy_clk_setup_aux(const char *parent_name,

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250729-mips-round-rate-dc3cbc8c8c72

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


