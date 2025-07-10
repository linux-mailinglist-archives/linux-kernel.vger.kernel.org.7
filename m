Return-Path: <linux-kernel+bounces-725987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44138B00653
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFDFF1894A79
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739F0273D84;
	Thu, 10 Jul 2025 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQyUrXSn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B72727FC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160856; cv=none; b=JtuzWdPpOQfih7jzQv8tvvE8/1DdRyd7b+pWs4zPNf1hCE+mxt0DXfiPXwFtfq4lLh+vIhMACufBzk+km8Z6ffT0VD/CbWYVOqRLyv+ycDcwsrOQOGMOVXLnBnHU3Scvia4XXXIrYkeWcJlkpcV6dAzpk2DHaw85AtsjMhS9Mr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160856; c=relaxed/simple;
	bh=9M3wopRrGysSMIdgOwMKcjjazdX85vpeXMPuYsQrbNY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZsGJLSYOQ/94h5ZbOBFZ4Z0sEGIXNXdV/pqrNc6CG5s12/8zgOiwws2rQcRubj0crd/ojI6hjyUREL1khIS754GwHN3Ku7qGO61E5SMH4xWPDzUYb0iFpW9A4/4kB2bUvQ2AgsjSpOiUqBZWRV6wnRJCua2bFDIUZtOKIjN6G1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQyUrXSn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752160853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ds7++Ij2+1V4ib5aZvqnghth0svM2cKB0bqVi1/rlYY=;
	b=WQyUrXSnG3OSyZ/N8h6G9rY8T+aORV7qo8AB2UEAh0m+pcFGGogrZhp0O6is3+w8mUsRkK
	zdLptw23Iuy9tqiayZ5DJZlJdS3apZ0Fr36CW/xKty52lVvXAWziHP7Bj1SUZ+VAmSuPHj
	lFQoxZEm/PMS+VYAfwrOrdCE9CulnXo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-QJmLeaNcNgaTy5VeA2aAeA-1; Thu, 10 Jul 2025 11:20:52 -0400
X-MC-Unique: QJmLeaNcNgaTy5VeA2aAeA-1
X-Mimecast-MFC-AGG-ID: QJmLeaNcNgaTy5VeA2aAeA_1752160851
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a44c8e11efso30444011cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752160851; x=1752765651;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ds7++Ij2+1V4ib5aZvqnghth0svM2cKB0bqVi1/rlYY=;
        b=qk/o709qBdstML70G637zuyzf3E89NmGmaCSwmDMOijtO8KJ/LNQTiZj0JZIYHni8k
         M4AIwUS38r/JKlVuQongGriHSTXk684wdO2HSocoNcTbu0ueY8p6c4n3JHK501Qz8lFo
         9bsBvTMr9Lfdxtec/eRs6FCKnwGH/wfchaHHR4GN5z7tb18F2LY+yiDX94NzIlmPo+8r
         E3HXa42LT/4FtQL4AbtKKTQJZEnwqKlxFedPumHeTzYq3EzC4gYcbrmuS3hh5+u1gRz2
         /F/1vKDcueVe60MWjd+K2Tl++kdibbTofsK6ErG/BBmCJ+egBuZs6XK5xJiserSvSzQw
         xEvg==
X-Forwarded-Encrypted: i=1; AJvYcCXH+FhYYVqvcHAa90XNNwB5H9zAojwV2ucmx6s+Jv39bHa0LJ6GwC6QY0K1xAw3FikP6ZcCpTtXtHBComs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6l+ySb0cLv1f79To34/H9oK3TVfjp95dNXGko2ji4Hnbe5w9I
	4tGQGaSR2ngslMYBnD9mB8crU2nY6fvlb5+DHIXURBYt4IHuar24cPr/ZOayGggekB86ZrCdFBG
	wJxF4QpN6NL07NhQLgjmTIF1ClA19VngKaw+v+e2/9qoeh+DTIv88x5a6KD12lQSKcc7VIWT9IQ
	==
X-Gm-Gg: ASbGncvmPmDa4xzuLb9gmm644n4m4QjFJoZkR6yHv6XFUx+CieRmI6YEf8TLN4HQc5j
	jl4cr3lwagBZKgYTQvReyGrBUmSmXklcPrD1YKQyyl2HEGNDfyh8t0vWppbw0A2xRGhtjLouQNs
	0EDtdG9Ef3OqbtUF0k9v0FB7aEgU5s1PtLfZA/PAfpgCxekennAuxp+ZiMb7/EyEUcp9diY5fmU
	teB/URNRQ7AesFN9++0ao7MxkU+3PDIqr2QS747W2tvK+/Jas7AGE2NdQ2OZpHLMOc8hIGkYF5r
	5RZMKygjyJZ60m81ZBNFeiROh2s8NzAPZKvOFmc2K5PRBeO2DRfLVHoJ8S4d
X-Received: by 2002:a05:622a:1144:b0:477:1ee1:23d9 with SMTP id d75a77b69052e-4a9ec75e251mr55309981cf.20.1752160850865;
        Thu, 10 Jul 2025 08:20:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEToM0xvOjTAuNFn12a/+Huuy1Y8IvYOkC01RE80GL773b7iqyZVQh3usJvnkGTDa9plKREUA==
X-Received: by 2002:a05:622a:1144:b0:477:1ee1:23d9 with SMTP id d75a77b69052e-4a9ec75e251mr55309261cf.20.1752160850187;
        Thu, 10 Jul 2025 08:20:50 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edeee2c2sm9654471cf.74.2025.07.10.08.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:20:49 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH 00/15] rtc: convert from clk round_rate() to
 determine_rate() and fix a few bugs
Date: Thu, 10 Jul 2025 11:20:20 -0400
Message-Id: <20250710-rtc-clk-round-rate-v1-0-33140bb2278e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADTab2gC/x3MwQpAQBCA4VfRnE3NEuJV5LDtDiZamkVK3t3m+
 B3+/4HIKhyhyx5QviTKFhJMnoGbbZgYxSdDQUVFjSHUw6FbF9TtDB7VHoyG2pLq2htbOUjhrjz
 K/U/74X0/Vlb142QAAAA=
X-Change-ID: 20250710-rtc-clk-round-rate-1093066d1a5c
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752160847; l=6092;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=9M3wopRrGysSMIdgOwMKcjjazdX85vpeXMPuYsQrbNY=;
 b=AA9zUj0gJWaQ5insN3QRj2sCaM8YtZtb1pwCdKfcn8t61rNC+0mFATNTarVGL7O+fipo2Lz7w
 iG1H+HResmQB2HXjyK41d1ZGP7JTaY4eabya5WkXNS64i/eBlg0iQAu
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated in the clk framework in favor
of the determine_rate() clk ops, so let's go ahead and convert the
drivers in the rtc subsystem using the Coccinelle semantic patch
posted below. I did a few minor cosmetic cleanups of the code in a
few cases.

I also noticed that in some of the drivers that if round_rate() is
called with a requested rate higher than the highest supported rate,
then the clock is disabled. According to the clk API, round_rate()
should instead return the highest supported rate. This series also
updates the functions to return the maximum supported rate.

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
Brian Masney (15):
      rtc: ds1307: fix incorrect maximum clock rate handling
      rtc: hym8563: fix incorrect maximum clock rate handling
      rtc: nct3018y: fix incorrect maximum clock rate handling
      rtc: pcf85063: fix incorrect maximum clock rate handling
      rtc: pcf8563: fix incorrect maximum clock rate handling
      rtc: rv3028: fix incorrect maximum clock rate handling
      rtc: ds1307: convert from round_rate() to determine_rate()
      rtc: hym8563: convert from round_rate() to determine_rate()
      rtc: m41t80: convert from round_rate() to determine_rate()
      rtc: max31335: convert from round_rate() to determine_rate()
      rtc: nct3018y: convert from round_rate() to determine_rate()
      rtc: pcf85063: convert from round_rate() to determine_rate()
      rtc: pcf8563: convert from round_rate() to determine_rate()
      rtc: rv3028: convert from round_rate() to determine_rate()
      rtc: rv3032: convert from round_rate() to determine_rate()

 drivers/rtc/rtc-ds1307.c   | 15 ++++++++++-----
 drivers/rtc/rtc-hym8563.c  | 15 ++++++++++-----
 drivers/rtc/rtc-m41t80.c   | 21 +++++++++++----------
 drivers/rtc/rtc-max31335.c | 12 +++++++-----
 drivers/rtc/rtc-nct3018y.c | 15 ++++++++++-----
 drivers/rtc/rtc-pcf85063.c | 15 ++++++++++-----
 drivers/rtc/rtc-pcf8563.c  | 15 ++++++++++-----
 drivers/rtc/rtc-rv3028.c   | 15 ++++++++++-----
 drivers/rtc/rtc-rv3032.c   | 21 +++++++++++++--------
 9 files changed, 91 insertions(+), 53 deletions(-)
---
base-commit: b551c4e2a98a177a06148cf16505643cd2108386
change-id: 20250710-rtc-clk-round-rate-1093066d1a5c

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


