Return-Path: <linux-kernel+bounces-726237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5CCB009E8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87749644CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D7A2F0C7E;
	Thu, 10 Jul 2025 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7eWwSy9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E418D2F0031
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752168568; cv=none; b=JHXLMXJFIQHgCdmP9WMJXcxlugmwg/Y3GUTrverFQBnltfZJ4kvLDRU8Yp8jcsFspXtdenL8NR3lz/SgTacPL6AwhO+K4mrIAN/R8tpSviyL3FXwnZ9xF3abTzao43Jq91mzg2AWTeeyPmpaYQ6yEmlO/9zQqrGa22GhDIH0ApI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752168568; c=relaxed/simple;
	bh=GxRPr2zKFQZkUu6782yLR9XiJNnYjmqxu0FzUn43ql8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kqlpdON23owVxt2CX2yKUa9OwjBO6T0Rg85D8o4BsAFBUpC8WsNVq2etuhUZtalrZimGLfg53b/ZcX+DJIBsMdK7Z6VftjaftxlICblWS622zs5Bf7LydP84dQ8EXNcmrWmOucnYa5z8WFwm4RRrgdCl04E8sTfr8QUr2+XXJtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f7eWwSy9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752168565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=15wuXMlpDA42zFWX/Inlh7bZJioyzoqEY94qxEY0+H8=;
	b=f7eWwSy9HMk5lygIHCn3KVkbLtVfCCF1ddAGuvQYJlR41U7MeWg+yjJn+gcbn7TWnNE3sY
	QEIrwnbXXaud/EJShrcL8kTiWMGASbmHElAjxsDGhCpwhjVjrTK7J9QVCg3V988GGQ9v+S
	fp3I6xWGnjBU3k9zow/3/oYt1AFyoYM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-jgVXDe4jO5WkG1XEq1A7mA-1; Thu, 10 Jul 2025 13:29:24 -0400
X-MC-Unique: jgVXDe4jO5WkG1XEq1A7mA-1
X-Mimecast-MFC-AGG-ID: jgVXDe4jO5WkG1XEq1A7mA_1752168563
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d38fe2eff2so172833185a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752168563; x=1752773363;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15wuXMlpDA42zFWX/Inlh7bZJioyzoqEY94qxEY0+H8=;
        b=NJG2tlfbouksnt1R6ILivi1h470tGS7M2pT4Xgo+dAa9G1YcpAibpVw1KTWqdY14Gu
         Hum4ZneydP5DM3W7wYeKeNteE0HkM1AcHLN50Vo6gjCvV0sCAGhgXblZ98b72bIKrj0t
         bqagjpvcOhOCFgXKg5tYL+yxybHM3VkrsXPS0soNr8KsteZwzGZOWET2WbB8KS9RRx0o
         i9oCI6EIJlQRan1fsf4kzO+uKz6FZxty0z7ragBRuShivjGykXX1js0Yagp+PkDpGebN
         vwk7bgQ3BzwPWVjjf0sPYla2chA/Waz8GMvjGdNQeU06zMR/Hq0dPyqMKy1fjExrFI1U
         HMLA==
X-Forwarded-Encrypted: i=1; AJvYcCVdB4k/rlXZoRCQO7NTIWY4gntQIxeu2tfI/q9JjD14fnUDcJYGjAWw2swVdooQmFNLFCE7QqJswFdLtes=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWl0rXYOmpXdQ2QDFmimkKO7uBhIwi1+9MJ7946VWEw0kOp9VO
	TJ3jfZzQCRv33O86xtuM/w18rC/oqhOStt9EhAqVm1iKIPMF04D+GEBPc2m2dIA3HmEDYye0Izb
	tytYhuGF+z3YlQrT6o8fVAWapVr76U/RXRqV0iml20E1pJGvNl9fjb8II4Z8pLOVcjA==
X-Gm-Gg: ASbGncumBALaCWFAZhrntrOQrbN04nuOJqlP1pHg0mJcuTulHrPbifcyKiGjg5FVAEs
	OpqTqggMQOec17p0W927TMLon39/3xJ4Tl0eas98QWL5qkZm6XCOm5Sdm25FJrDfHaVgXTs+ggV
	Ra4m3OaeT0BKsyXy2e7WsD/uW9jnH6HnRmHYFBPpzG5503dR8frRshG4wIFzZIXbQU7UHqj3Skk
	fDTvADlFfWb/vqfecCh6S84m7jNGxhNIvTQAnKBr3897hlkkBe9U7xmQ2HvhrN3xqfr+8IMh0z3
	xyYpuEEuj+tUI1rdQb3e0f5hmpddDLRx/mqoQW42TOClmkdI7SyVHeUwgR0A
X-Received: by 2002:a05:620a:1a82:b0:7d3:b28d:9aeb with SMTP id af79cd13be357-7ddec83c592mr63866985a.48.1752168563412;
        Thu, 10 Jul 2025 10:29:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrmS1mMpPovOMJ0VVqq6VLSlVkcvsFvwKTzBgf+FoZDJXo+kt+R195oa3nhGmgt3pBm5NJUA==
X-Received: by 2002:a05:620a:1a82:b0:7d3:b28d:9aeb with SMTP id af79cd13be357-7ddec83c592mr63862085a.48.1752168562927;
        Thu, 10 Jul 2025 10:29:22 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcde806297sm117728785a.82.2025.07.10.10.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 10:29:22 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH 0/4] media: convert from clk round_rate() to
 determine_rate()
Date: Thu, 10 Jul 2025 13:29:05 -0400
Message-Id: <20250710-media-clk-round-rate-v1-0-a9617b061741@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGH4b2gC/x3MTQ5AMBBA4avIrE1SfymuIhalgwlKpohE3F1j+
 S3ee8CTMHmooweELva8uYAkjqCfjBsJ2QZDqtJC6UThSpYN9suMsp3OopiDsFCDycoq17nuIKS
 70MD3v23a9/0ApuhKOGYAAAA=
X-Change-ID: 20250710-media-clk-round-rate-50fa3894747b
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Julien Massot <julien.massot@collabora.com>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752168561; l=4880;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=GxRPr2zKFQZkUu6782yLR9XiJNnYjmqxu0FzUn43ql8=;
 b=c+92Qb2p7ihTMFt73L/rC8M0nUDEnGLNwn80xL8u+j6pFqCoWlzO+klFQ1EUtXVInH56W8eSQ
 9IefNmPosfcAQTIVih1LHZqD9nqXa74EV4srVvO5S4pFhhrbwhK8oHe
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated in the clk framework in favor
of the determine_rate() clk ops, so let's go ahead and convert the
drivers in the media subsystem using the Coccinelle semantic patch
posted below. I did a few minor cosmetic cleanups of the code in a
few cases.

Coccinelle semantic patch:

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

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Brian Masney (4):
      media: i2c: ds90ub953: convert from round_rate() to determine_rate()
      media: i2c: max96717: convert from round_rate() to determine_rate()
      media: i2c: tc358746: convert from round_rate() to determine_rate()
      media: platform: ti: omap3isp: isp: convert from round_rate() to determine_rate()

 drivers/media/i2c/ds90ub953.c            | 12 +++++++-----
 drivers/media/i2c/max96717.c             | 16 +++++++++-------
 drivers/media/i2c/tc358746.c             | 12 +++++++-----
 drivers/media/platform/ti/omap3isp/isp.c | 10 +++++-----
 4 files changed, 28 insertions(+), 22 deletions(-)
---
base-commit: b551c4e2a98a177a06148cf16505643cd2108386
change-id: 20250710-media-clk-round-rate-50fa3894747b

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


