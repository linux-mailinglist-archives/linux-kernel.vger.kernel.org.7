Return-Path: <linux-kernel+bounces-798933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F0EB424D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9828A188314E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6DD22DFA4;
	Wed,  3 Sep 2025 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdBMsYOc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DAE227EB9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912536; cv=none; b=V37vRH1baSJ7uI15gNeU4tZpgP0Q8YU5y9VdC0BAGqnVokrJf4LQZmj2+jCBwrctXt472jcH+ezlFBVtK9RUAxyWsvMfZlsRrAtoNbhZrnVVTZS08imBasNmeLYuScioLf82kS7UEav0YZ8yP9UPzlEY1ya3toufWJtjTIi7YDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912536; c=relaxed/simple;
	bh=Xu0cBEqi7Psy9OdAnHfnNSejeDcVKnoUS6N7NxTCby8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dwe2W51sRoRoMqoH4s+gdFDATKZgXH68VtfchaEniATBejrtByTLjY5gB5PBMTzntt7XCBoI07kJ45KBTOm8cmvDHdI/R0yJRVdGOBmorp0ivrgXKE+esESc2oNCCxncHJXdEYJkiqkVIz4E160WqNpgmcyZhKtz+XZgl2syqLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdBMsYOc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756912533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LdY3eJT+Y0XdvlnzE2zEJKsg9kAaBz/9qglzunIg0gk=;
	b=ZdBMsYOcltOqwkhXXj5Ykm6rmvvwDeP+YcmFgMM7Txs+74M1BvIN9zXR8+ajadCvfgQeUK
	ZcCWaf9qKLPsPFFkQqeF2Iil/ccQuZLe41f83TJ+82dj5H/5AqgSWzA5yR6aotDhSFI6JV
	gNDF6NJ+pYWMTzzmkZ/7/v/wQ4MLOXY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-lO0MN6tPPP2i5wyHxDcJEw-1; Wed, 03 Sep 2025 11:15:32 -0400
X-MC-Unique: lO0MN6tPPP2i5wyHxDcJEw-1
X-Mimecast-MFC-AGG-ID: lO0MN6tPPP2i5wyHxDcJEw_1756912532
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-72108a28f05so57528646d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912532; x=1757517332;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LdY3eJT+Y0XdvlnzE2zEJKsg9kAaBz/9qglzunIg0gk=;
        b=i89ZEaYbRbFSA4nPLmMNhk2zLgLhe48KAUVRYAV2hlQpsQiWhey2YZweImyPMP2Blu
         8xpb1GJbNgXW1x+uk6mmBnEUdKaFxse57KZa+6U2VjGF0iQBsV+oj4xXgH/g+B/1J0Uh
         OueEM3Z6yyirtLwO7Dx8CuQ7KuNU2DOMvdU0LyUW3nNznjcu6jyt6cf3j8AKELut3nti
         w9sEAfIi+AsGuRfDVrLrfoVYBDPjMIyWGdl7D852xqok/X14q/MveL19hc0CBiciMIB7
         ShXtMZSsDYnr5u2Q1rsmWw53ZeREPBEl+9P+Bei5j1NdPjU4AAZGeWXbcuEQVSvnYQPi
         lPkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+62k1kHcfNm9MBpBIlH+TlivPIO9EJTlGOM6dnUJLFKRgJacdWKkyoHZEbZz5OVcI5cMA54WYozxbbhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhnlPKr1f4V1gIifjgFsW6yeOZ9RCb0ZDqdn6U8Idqa/hR7cwi
	Z0qeufzjZ394tVpCf2TaO53oMS3fWKCUVWi4JyAfAhoP+LmaoQZv+ONvEGwbsnkUQZiqhB4SU2x
	7DyrmVr5D+bBL+iF4JWYA6J5OUSJUIc0ZdhL1wG1coCZ6ugvE8seG/y01Ucb/nW/Zlg==
X-Gm-Gg: ASbGncubmjYHBR1tummDcSuo8tu7WSUIggCpN7n3lmsXRRYE31i5F4RkUp7H+dYCO6o
	J/Uz2CGT2LWwc/UIg6FTYVKdfDTgIlLqU6gaqUg5uJVJNecOLZ7Z34hqUyXcoo+jvEEy6vpo1Of
	sada3Yq0RrAuEm9OY8244xvf3uomvj0dcjisOthXswQHcOEQmePtiYDQJjjW2KYTpTry8qz39sd
	uXOBRriwdTca7F1VamMt/SoMPJOYBA6j+6nlr2NZyxiUazaMxLu85ySb/Hsv9Ej29wJEKV9b5BW
	6ziZshOkcAcMo45+qjaL3OSgAViOp0na5cMN52D1qLd0hv8piCJoPMsuCayvlcX4L4Ftefi2/+M
	=
X-Received: by 2002:a05:6214:76d:b0:716:17e0:2466 with SMTP id 6a1803df08f44-71617e02b67mr159465866d6.34.1756912528886;
        Wed, 03 Sep 2025 08:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkWebP2Qk177v4NSM1pvKjg7uVb9XRiSsSjX1ArIElnPlsqqP/rGsp6ulP8idla98+4xureg==
X-Received: by 2002:a05:6214:76d:b0:716:17e0:2466 with SMTP id 6a1803df08f44-71617e02b67mr159461546d6.34.1756912525636;
        Wed, 03 Sep 2025 08:15:25 -0700 (PDT)
Received: from [10.12.114.224] ([2600:382:850c:786a:ff8e:13a:e47c:3472])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16de16sm30827706d6.3.2025.09.03.08.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:15:24 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH v2 0/6] clk: tegra: convert from clk round_rate() to
 determine_rate()
Date: Wed, 03 Sep 2025 11:15:01 -0400
Message-Id: <20250903-clk-tegra-round-rate-v2-v2-0-3126d321d4e4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHVbuGgC/x2MQQ5AMBAAvyJ7tkkVB74iDqsWG1KypZGIv2scJ
 5mZBwKrcIA2e0A5SpDdJ7B5Bm4hPzPKmBissbVpTIluW/HkWQl1v/yISidjtEhTMgZyTeUKSPW
 hPMn9n7v+fT+G+jpKaQAAAA==
X-Change-ID: 20250903-clk-tegra-round-rate-v2-af025bac94c1
To: Peter De Schrijver <pdeschrijver@nvidia.com>, 
 Prashant Gaikwad <pgaikwad@nvidia.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756912523; l=5345;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=Xu0cBEqi7Psy9OdAnHfnNSejeDcVKnoUS6N7NxTCby8=;
 b=NcgiVd9SVHO/Mdpi8r0JCLnx5fe5/PII/AMdsLbqulhKFwkgOZbUK4cYUnd4Ko03VbNBh82L/
 Qy2Al6Q9Ao2DpmVWLyPovFd8KUFwookPysJXxiff6BX58YhhLTFZuza
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated in the clk framework in favor
of the determine_rate() clk ops, so let's go ahead and convert the
drivers in the clk/tegra subsystem using the Coccinelle semantic patch
posted below. I did a few minor cosmetic cleanups of the code in a
few cases.

Changes since v1:
- Fix merge conflict against drivers/clk/tegra/clk-periph.c since
  v1 was posted.
https://lore.kernel.org/linux-clk/20250710-clk-tegra-round-rate-v1-0-e48ac3df4279@redhat.com/T/

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
Brian Masney (6):
      clk: tegra: audio-sync: convert from round_rate() to determine_rate()
      clk: tegra: divider: convert from round_rate() to determine_rate()
      clk: tegra: periph: divider: convert from round_rate() to determine_rate()
      clk: tegra: pll: convert from round_rate() to determine_rate()
      clk: tegra: super: convert from round_rate() to determine_rate()
      clk: tegra: tegra210-emc: convert from round_rate() to determine_rate()

 drivers/clk/tegra/clk-audio-sync.c   | 10 +++----
 drivers/clk/tegra/clk-divider.c      | 28 ++++++++++++-------
 drivers/clk/tegra/clk-periph.c       |  8 +-----
 drivers/clk/tegra/clk-pll.c          | 52 +++++++++++++++++++++---------------
 drivers/clk/tegra/clk-super.c        |  9 +------
 drivers/clk/tegra/clk-tegra210-emc.c | 24 +++++++++++------
 6 files changed, 72 insertions(+), 59 deletions(-)
---
base-commit: 5d50cf9f7cf20a17ac469c20a2e07c29c1f6aab7
change-id: 20250903-clk-tegra-round-rate-v2-af025bac94c1

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


