Return-Path: <linux-kernel+bounces-726480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB70B00D82
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB4D1CA485B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C872FD88D;
	Thu, 10 Jul 2025 21:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mt7vuXVk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3B9274669
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752181877; cv=none; b=iGz4eM0JlRNHkJqCoB9k+MKWk1BWaiNwxfaDGrd85o4DpAfTxv3E0ehMwMtaHc3jbfauAxJp08jv1CjOwbn1MLSIuFUOBZkwgUB4wHG5UKhKt3wfSiqQxv0ZbAp0KPCQvw9PX11LgBM4OuGrHycxwKqJ7sD59FgjuRujDghHjuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752181877; c=relaxed/simple;
	bh=VkBZymHS4NSLMC7bHgMfljy60rdX7BJ1DlxpAOHOtqM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QKZ4X70/OBUHnTXrGAbxHW3IQ0AQPPbLxjs+/gAoAtPbdVnGosAb+d1DGhp04L+HcjYoffEOMvx1aLcO+jXScctcLeLxbztkCxUcEXKByobOLPjuCudzVnBm5OphD1frWAmrjClbjfew0Wh/zC+rf7XHUUjDxDHOymLRUev+wEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mt7vuXVk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752181874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HWFTFh/TUDhf+twgmA9UYYg8LGXRjMgTLJemIO/awsw=;
	b=Mt7vuXVk57HJuy7iAh/ghk6mr1IGP1JiIglimU54kK5yk/9iogE+FdCLdE0C0sZSibolIN
	NqfNkLl8A1cia408IJRMwI3MzqTrwDk6jmFI4EcbWhVcArLDjVk8Hw2jAYqGqob1ZehQl6
	goQeoyLIqoJSDCDy6NqBMnKaPeQKNGc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-qCsEJytfMN61a2Da2c807Q-1; Thu, 10 Jul 2025 17:11:13 -0400
X-MC-Unique: qCsEJytfMN61a2Da2c807Q-1
X-Mimecast-MFC-AGG-ID: qCsEJytfMN61a2Da2c807Q_1752181872
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-234a102faa3so10453865ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752181871; x=1752786671;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWFTFh/TUDhf+twgmA9UYYg8LGXRjMgTLJemIO/awsw=;
        b=JqG/3IWfsguOQ5b0c7YC9EbhuYu6HHmIe44+H3SEHWY4F9pFuhKBfyp9P0AYrNbkgD
         21ACTtKCwawGD4nB9fs+5kubryrOydwHXxs/QwHCDC0eBM7u2UtJvjnD2URsDG/9LTIj
         Hogz0I2BcxCjvYaHuTtZx9DkHe7eVcKMnOh5kSiLppIO5BWd0CN7y+TIXHBkLuusgxVa
         U9uOkJ54+EAdCdscJb5a+OZiCSnaklQcg92mQqfTvG7TyfcLpvACDGXcg9WKH/X0aJY7
         eQmO/ITmOdJ/GGNkG4scmF7e85dst3p6RqGZbCiX5RI4JoDps0j5H+nZn2XYckRYq9lP
         42bg==
X-Forwarded-Encrypted: i=1; AJvYcCVcvNVq4FJM48jz93IinFm4OnphRHvLx7hdNMPgrQgQybatoVuQzWXUR3A82blRlnOg+qwByiuhNw323YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0HTFWJB1xW4kchafIoFWbtfq1VzEVBDMAHtQb//8tuS8I41Gp
	cYg+RRy/XFk6k8pI7lOexmvZC+jw25L8jew1WTt9gZLijukRuJLzuHFfCkmfbQdv/xCQqtSina1
	eI5BEEfKyBAKHTY4d2rc7rBffSvH7v075rapaGPA+4ljJ1dg3BLtgh5iAESycfqvM5W+CNkFjn4
	QQ
X-Gm-Gg: ASbGncvIT78pboXaET2UsYL6IT46ogaDGhb2UIBwYF6Sn+nSEIVgtICn90FIOSTPl3Z
	YRbz5Xog87BR7zrdYCxZiNGr3z74uCXbeQXTtpmXJF9uh5oC6F2LGsHp7/NBdikwQBzJd2QGM3w
	QyjpdW0zCaPXn2IN9gr+RX9ohCRJizY/y4WuwXj5IL4tVN9FRXmD5aHkwgAL5Xwqtreq5coQ/0k
	Zj3MThbz33IDLTbbPBVhAHvbE6TAoXr36/9aeFMgrzohQV1v6fjj9Q8k1iH3XliZTMWJh5YvK09
	fLRpm/ic6ogAdbivED41hkiHsoKoRG8qKA9yA2IgCW0qgQ==
X-Received: by 2002:a17:902:f603:b0:234:d292:be7f with SMTP id d9443c01a7336-23dede7d45dmr8541125ad.31.1752181871130;
        Thu, 10 Jul 2025 14:11:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZTNelfVFxvxHSdAlOlXRMFMf2/RyOZ5QtlGD9msicHprkJxdJdgF83ESayB5cXzsffEjyTw==
X-Received: by 2002:a17:902:f603:b0:234:d292:be7f with SMTP id d9443c01a7336-23dede7d45dmr8540815ad.31.1752181870703;
        Thu, 10 Jul 2025 14:11:10 -0700 (PDT)
Received: from [10.144.155.224] ([2600:382:7716:65ad:9491:c054:6f2d:80ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de433e51asm27790595ad.180.2025.07.10.14.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:11:10 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH 00/13] clk: imx: convert from clk round_rate() to
 determine_rate()
Date: Thu, 10 Jul 2025 17:10:32 -0400
Message-Id: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEkscGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0MD3eScbN3M3ArdovzSvBTdosSSVN0ky7TkRMM0M1MLYxMloMaCotS
 0zAqwodGxtbUAfAjR6WQAAAA=
X-Change-ID: 20250710-clk-imx-round-rate-b9fca1f65834
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752181866; l=6081;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=VkBZymHS4NSLMC7bHgMfljy60rdX7BJ1DlxpAOHOtqM=;
 b=CrzLst5JnkrbKUpNZRNqaXnvvYvt1GcPkPG+C45YmBjicrsMj6s8Nm5XOFjqOO+Kg+zCXpt3F
 RsqbGkgNN4PA4SdWkh6apyXXBaECQKvPe6pDyulRd/j5BsPuKYd5aYu
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated in the clk framework in favor
of the determine_rate() clk ops. The first two patches in this series
drops the round_rate() function since a determine_rate() function is
already implemented. The remaining patches convert the drivers using
the Coccinelle semantic patch posted below. I did a few minor cosmetic
cleanups of the code in a few cases.

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
Brian Masney (13):
      clk: imx: composite-8m: remove round_rate() in favor of determine_rate()
      clk: imx: composite-93: remove round_rate() in favor of determine_rate()
      clk: imx: busy: convert from round_rate() to determine_rate()
      clk: imx: cpu: convert from round_rate() to determine_rate()
      clk: imx: fixup-div: convert from round_rate() to determine_rate()
      clk: imx: fracn-gppll: convert from round_rate() to determine_rate()
      clk: imx: frac-pll: convert from round_rate() to determine_rate()
      clk: imx: pfd: convert from round_rate() to determine_rate()
      clk: imx: pll14xx: convert from round_rate() to determine_rate()
      clk: imx: pllv2: convert from round_rate() to determine_rate()
      clk: imx: pllv3: convert from round_rate() to determine_rate()
      clk: imx: pllv4: convert from round_rate() to determine_rate()
      clk: imx: scu: convert from round_rate() to determine_rate()

 drivers/clk/imx/clk-busy.c         |  8 ++---
 drivers/clk/imx/clk-composite-8m.c | 16 ---------
 drivers/clk/imx/clk-composite-93.c |  7 ----
 drivers/clk/imx/clk-cpu.c          | 10 +++---
 drivers/clk/imx/clk-fixup-div.c    |  8 ++---
 drivers/clk/imx/clk-frac-pll.c     | 20 ++++++-----
 drivers/clk/imx/clk-fracn-gppll.c  | 17 +++++----
 drivers/clk/imx/clk-pfd.c          | 18 +++++-----
 drivers/clk/imx/clk-pll14xx.c      | 29 +++++++++------
 drivers/clk/imx/clk-pllv2.c        | 23 +++++++-----
 drivers/clk/imx/clk-pllv3.c        | 72 +++++++++++++++++++++-----------------
 drivers/clk/imx/clk-pllv4.c        | 29 +++++++++------
 drivers/clk/imx/clk-scu.c          | 36 +++++--------------
 13 files changed, 146 insertions(+), 147 deletions(-)
---
base-commit: b551c4e2a98a177a06148cf16505643cd2108386
change-id: 20250710-clk-imx-round-rate-b9fca1f65834

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


