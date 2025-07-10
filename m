Return-Path: <linux-kernel+bounces-726063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24589B007BC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F6617AC9B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ED7277CB6;
	Thu, 10 Jul 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJ3v2p35"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B156274B29
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162706; cv=none; b=NlRFdrE4yZre7JkPDuw5ixEnGTnaAaiAz9oYbr+e8jAfSmhD5uQLhx8TkixZc3GYvGDyiyyuTYKqRqDjtDCPKM16lGsbt4JaeYcpk0YRoGHvstwDyk1DDx/IHhX57wGM90JKkyoGRg1IXK2fhnwoddXjK6xGEtA9T/yfBAyDbok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162706; c=relaxed/simple;
	bh=9HMFkZbuW9ZpnWbftnssfH9Bqhp8qt4XbuXWzr1wRy0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i+8PTJkTSAddmygiNLx7qMs+abjZOchyJbvlOyDsQd4IjXezU6RK7U9odIw9vjumsb3nnTnA4CAFgznMSA75CYzacgFjbE9ZDqd4PxGIzFEkgvfRyY9maRtIPZ+ynJP4Nq19WyhGZbIEKqpqFlcOwMr/VwfXEuTUTM++50qCF2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJ3v2p35; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752162704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WADJ7rxEf5+t43hyxNegpLJp1h0n13l+s0KkiLPhYtw=;
	b=VJ3v2p353chsKjMDRBUelZGFf02Pj1Y1DFPSalctg4pCm8RfJz3jsAzYxBCTF6ZvCDznyp
	LFCBwaIPSmNrZ2vz7y8OR5nDnOBs5Rauza1wrM+6K6j9A/SbC4KiC0RW3YQfZhv2z8zEQ8
	EvkOOvbKIemM7DNyFVnfPPQt2jV+8u4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-NYABekR1OrGg5R6G4K9wqg-1; Thu, 10 Jul 2025 11:51:43 -0400
X-MC-Unique: NYABekR1OrGg5R6G4K9wqg-1
X-Mimecast-MFC-AGG-ID: NYABekR1OrGg5R6G4K9wqg_1752162702
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7048ed0751fso24234366d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752162702; x=1752767502;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WADJ7rxEf5+t43hyxNegpLJp1h0n13l+s0KkiLPhYtw=;
        b=fe1XNMuOTtoKCscMwbsL433v3JoLtmSlMLmGiI6TKnnjuKkexYw4cDMH4lCueVQRYa
         WEVOSVgh09NcQojhQf0GNbnFMGTbMPds65Y1xRPZfZDeQmeAQ+hk9stKgimACGuVit7C
         U3c5NPu0xRhhTClWkJj7ikaa+0P3Jc5rgt5NAYxbU/qXwU3XZSxHQK9vllJ0qzAANpGT
         JUH8afATZGwiKbwSLHY+M8rXIqtPHQrc+/h5RYcYS+j+13iCQucYVlhsriCzSr9r9UKP
         fYTNQIx8RqcjU5wSkB8gSMMdlU/vC6FeY3Jz68oqPHqYTy1DmZt117B9/FZ2y4Y6dv80
         eyQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn6n7G5EFUQuTVe14M+wruHwff+g3a4dsRj0vNzYnL9Bg4q/bg2DJgNEzCcQUycB9M0Boxl+wrgrX351o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3C3L7XKJ6ZfWvbDcqM8Agcm3k0MjL41YneJrSqsRWIVsOfX2z
	+EkGcYeeyUUMURIBAwjEJ5X5f0chd7YkNnJzjqqm6d/s77yMHDM++LXlN6UsE19Ox3j02cP2TWL
	YnWo8ekvNDc/PRAlaLGmJLW7AhIVriLDft/knW7hnOx5Og8mRlHdkL2Ke/fNXageZfw==
X-Gm-Gg: ASbGnct/qhorglkAHgbaC3TTS5MBraxTfO2RO69tLfn0p6h2r4xysywaJ0LKqMhy+12
	BhwaB9XXAQvTo+rKiOnFJRO7scw7196/pG+cxOUVVhjAL7P+529cGZSvrJbXM4aa3bsL2BdKe1A
	8ZKF0aZ1qDrKQofB58VZkrb7h6LTskib9BW+LUCrGF3gIHoRlfnwiAGcXbvJditC2RpV1Bbtmby
	CxWCbds6x+8GAVmW0dBS9hVBLKatNTMw3lq1shyLtzMmnbfdngFbJbNm5OTW12uAJX6lSbW0VJV
	Xk+oLcAccCG6BP4xGRafAOJdh1bzEieuBKyBpGE+cmm376t+hds7jXWI3Dq2
X-Received: by 2002:a05:6214:f6f:b0:6fb:50da:48c0 with SMTP id 6a1803df08f44-704981df370mr48741716d6.32.1752162702214;
        Thu, 10 Jul 2025 08:51:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6tTS21fRt7gW+5oC/mUmMYYDHl8pgKSfHGnscN6OnkB2uw7eNnpNtqA9BjpxUhpgOQUOErg==
X-Received: by 2002:a05:6214:f6f:b0:6fb:50da:48c0 with SMTP id 6a1803df08f44-704981df370mr48740986d6.32.1752162701655;
        Thu, 10 Jul 2025 08:51:41 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d3940asm9475456d6.73.2025.07.10.08.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:51:41 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH 0/6] sound: convert from clk round_rate() to
 determine_rate()
Date: Thu, 10 Jul 2025 11:51:06 -0400
Message-Id: <20250710-sound-clk-round-rate-v1-0-4a9c3bb6ff3a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGrhb2gC/x2MQQqAIBAAvxJ7bkGDMvpKdDDdaiks1oog+nvib
 eYw80IkYYrQFS8I3Rx5D0l0WYBbbJgJ2SeHSlW1Mlph3K/g0W0rSiaxJ6H1o7ZGj75tDKT0EJr
 4ydt++L4fj0lNa2YAAAA=
X-Change-ID: 20250710-sound-clk-round-rate-adb1a71bd867
To: Support Opensource <support.opensource@diasemi.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Oder Chiou <oder_chiou@realtek.com>, Srinivas Kandagatla <srini@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752162699; l=5203;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=9HMFkZbuW9ZpnWbftnssfH9Bqhp8qt4XbuXWzr1wRy0=;
 b=sGBwjqYM4hPVL1CZFdLUsSLiPft7TSDB69HuiD4QNIFy9Mz6ke78nYWLUUl9QcWx2qrOP3kGY
 O85EabSwvs7AKgAZmdJB/ePYT6ukziJUFUbHtudOEOYr50RuwcvWs0Y
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated in the clk framework in favor
of the determine_rate() clk ops, so let's go ahead and convert the
drivers in the rtc subsystem using the Coccinelle semantic patch
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
Brian Masney (6):
      sound: soc: codecs: da7219: convert from round_rate() to determine_rate()
      sound: soc: codecs: rt5682: convert from round_rate() to determine_rate()
      sound: soc: codecs: rt5682s: convert from round_rate() to determine_rate()
      sound: soc: qcom: qdsp6: q6dsp-lpass-clocks: convert from round_rate() to determine_rate()
      sound: soc: stm: stm32_i2s: convert from round_rate() to determine_rate()
      sound: soc: stm: stm32_sai_sub: convert from round_rate() to determine_rate()

 sound/soc/codecs/da7219.c                 | 64 ++++++++++++++++---------------
 sound/soc/codecs/rt5682.c                 | 26 +++++++------
 sound/soc/codecs/rt5682s.c                | 26 +++++++------
 sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c |  8 ++--
 sound/soc/stm/stm32_i2s.c                 | 21 ++++++----
 sound/soc/stm/stm32_sai_sub.c             | 14 ++++---
 6 files changed, 87 insertions(+), 72 deletions(-)
---
base-commit: b551c4e2a98a177a06148cf16505643cd2108386
change-id: 20250710-sound-clk-round-rate-adb1a71bd867

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


