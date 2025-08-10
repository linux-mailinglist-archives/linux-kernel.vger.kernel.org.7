Return-Path: <linux-kernel+bounces-761622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ADFB1FCAF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0298D1894F87
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043342D661C;
	Sun, 10 Aug 2025 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKSwrXw2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAAB2BF010
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754864527; cv=none; b=T7nfK7XFTd8SORhSBt7p9/8GyqvhkFnz23E7NHWfjeuauZDwZREqx2CvtVpSGBfulWk7Q4IvhDDAYMZc/b2ctPTwLzGW6FBGnMeLtn2W1YpvQfy5MKnw8gt6memZorqKC300mPkErIQahtn0ZwQ2XlrmPEBV+z2IUAdoABEB5nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754864527; c=relaxed/simple;
	bh=L6jvK6ACaYL1SKlK5QC34DBWw1qmKVlL/yCAWgBC/h0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sl8NIkC1eeU15bNU1msCHIjWmSx0dkmM3p/Z71jfk0vecc2sAZEv2A22LP0HoM+M2immcrimOIHjmtKbp97AhwPw3k2xfj6j8E3zwQZa0hOUpYELax/EGj3SxCYsY5To/MNfcbVWPAWRHx8oQntgChaEPbZ+TEGNW4ie/xfo3hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WKSwrXw2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754864524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DTxIrdPV4iWneFJR6EUg7IhXT4i8rDJLDvWWCgyO0NI=;
	b=WKSwrXw2yhHBMIouI6qOeWCkVgGxMf7vEB6I8ABl4pMikXp8NcUzx4QS3x2n6+UCZBy7mx
	sY+nWYaFQfKSF0x//lAXqUQH5d4JeM3acESKeQje2PflehftExY4X0td8mx3bKsQpLP6c7
	3FiHSdHfcYXdfU8g+JGzKcNfgzcGPIU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-Z8vXp7SVO8KZNb6XNkfppQ-1; Sun, 10 Aug 2025 18:22:03 -0400
X-MC-Unique: Z8vXp7SVO8KZNb6XNkfppQ-1
X-Mimecast-MFC-AGG-ID: Z8vXp7SVO8KZNb6XNkfppQ_1754864522
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4af210c5cf3so160866701cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754864522; x=1755469322;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DTxIrdPV4iWneFJR6EUg7IhXT4i8rDJLDvWWCgyO0NI=;
        b=LPfj9xVT9hKrMFRREphfMLb1a9NbnevKah8vZPqF48CxWGxSwALyJZoa1hOSpkNQ/z
         1gPvLADQekBtOz8e8Zq85HSafTnvLQN4lyFDE0y+WLoK+f4KGUiHzJ70HYULQbt9wsxS
         1/9fE8SiPyUX4Co1nPK7sZs9O1XoKRLaSKEJYcPQsTNBFpNGiq2yz78iQqwpS8H5j1iM
         cKVk58ot69xpv/B4+ATIgtB1VHnqIzxgTmBd/DYnRDouylIGz9PVpe2y2MmsrGJ7CAlp
         usmh2vVRnkDhA2ewn3waSXiKoqvGMwtJyES5KHbZuMMNCzWKPV7ad8CGRVkU4a/1ACiz
         eAzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxkQRWogOolfK4HX0XpkTp1oNL/VPh9C32rFnI289ItQjMeNNL7gVMvfNFblPIU/pqkcuaA23OIAYbd9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfT/B3yILw2ddTXpOaEj3sqVS5l5qO6eYPdiXy4cGS3z36DaHu
	h9mw3XykMv6mBrLCCN4oDUL2guLn67U3UtUiZue1OP5irJVZD2Zbl91GvlBtoNS4GXn8KTXptHU
	nxDfHYutFQb3AM0UP9FUC4MqEVQAmifieP1XdhRB4RgAXJO3w0sNKkOwIz3MZpSIZPw==
X-Gm-Gg: ASbGnctPyDBFwY66V0khsK9viys7I0q+5wES0RnI1WjqQrpMXKX6ZDHvJIB/0XFCV7L
	8Ngijqc+2tMCiY68P3vgviZBy1R/LJpVW1NNgdtV3eKLw6UxmiEyZ4QtAg05L22Rk3P089LFHPq
	Yd0cXRbVrpoqaeK53NXMVtUDrXY5dJvHlWFuSB1yUWkdYCYGqh2gLQabBD8MMEyROkieJJngixw
	Ptb0qlTYp68gJ7GakOF5WpHEn87R47ubJcjMwdnZfA5aHw+/NARZRQ/v6gM0sMJLreaGrUcRtvu
	F+Yj93we4HV1zbmARIAn5CikwzKrQ95YvSFnw9LDTlHqTZ3WEolKmA9514IHe9w0enKlk/DFokQ
	UGRQDqA==
X-Received: by 2002:ac8:5d0f:0:b0:4b0:8092:9912 with SMTP id d75a77b69052e-4b0aed42512mr175423841cf.19.1754864522404;
        Sun, 10 Aug 2025 15:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0/+zhF0BEbIolaJOCDjorPdn+0fQDWtw+ZQnbIpL+/rhtw0D1XSan+ygZuYsN1eYwat9u9w==
X-Received: by 2002:ac8:5d0f:0:b0:4b0:8092:9912 with SMTP id d75a77b69052e-4b0aed42512mr175423681cf.19.1754864521987;
        Sun, 10 Aug 2025 15:22:01 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e816a9a3cdsm714913185a.23.2025.08.10.15.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:22:01 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:21:51 -0400
Subject: [PATCH] peci: controller: peci-aspeed: convert from round_rate()
 to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-peci-round-rate-v1-1-ec96d216a455@redhat.com>
X-B4-Tracking: v=1; b=H4sIAH4bmWgC/x3MQQqAIBBA0avErBsorcSuEi1Ep5qNxVgRhHdPW
 r7F/y8kEqYEY/WC0M2J91jQ1hX4zcWVkEMxqEb1jVEWD/KMsl8xoLiTsO/0oK2yhvwApTqEFn7
 +4zTn/AGKlAVXYQAAAA==
X-Change-ID: 20250729-peci-round-rate-543639297ec6
To: Iwona Winiarska <iwona.winiarska@intel.com>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754864519; l=5809;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=L6jvK6ACaYL1SKlK5QC34DBWw1qmKVlL/yCAWgBC/h0=;
 b=ExfjZ3UpYQJq/TbnRfU0VlhnPXC/BUUDuaJmbmTAojaDwiZAdey0YvI5/J2A7xXNMUS9wkF5N
 vb2GIQ8yHxiAnFyZY8qfOjL4oDD/6ms/NRhowThZjXsoS9w0+utR2C+
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
 drivers/peci/controller/peci-aspeed.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/peci/controller/peci-aspeed.c b/drivers/peci/controller/peci-aspeed.c
index ad3a7d71ed4c61e6123dcbbad264812cb83cbb07..a0c99ecf7f3805a1cdac55a8d5db9c61ad3cf37c 100644
--- a/drivers/peci/controller/peci-aspeed.c
+++ b/drivers/peci/controller/peci-aspeed.c
@@ -362,12 +362,14 @@ static int clk_aspeed_peci_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
-static long clk_aspeed_peci_round_rate(struct clk_hw *hw, unsigned long rate,
-				       unsigned long *prate)
+static int clk_aspeed_peci_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
 {
-	int div = clk_aspeed_peci_get_div(rate, prate);
+	int div = clk_aspeed_peci_get_div(req->rate, &req->best_parent_rate);
 
-	return DIV_ROUND_UP_ULL(*prate, div);
+	req->rate = DIV_ROUND_UP_ULL(req->best_parent_rate, div);
+
+	return 0;
 }
 
 static unsigned long clk_aspeed_peci_recalc_rate(struct clk_hw *hw, unsigned long prate)
@@ -394,7 +396,7 @@ static unsigned long clk_aspeed_peci_recalc_rate(struct clk_hw *hw, unsigned lon
 
 static const struct clk_ops clk_aspeed_peci_ops = {
 	.set_rate = clk_aspeed_peci_set_rate,
-	.round_rate = clk_aspeed_peci_round_rate,
+	.determine_rate = clk_aspeed_peci_determine_rate,
 	.recalc_rate = clk_aspeed_peci_recalc_rate,
 };
 

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250729-peci-round-rate-543639297ec6

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


