Return-Path: <linux-kernel+bounces-726292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F8BB00B17
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCAAD3B2245
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774E52EFD9D;
	Thu, 10 Jul 2025 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5qXXsUV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBED2741BC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752171065; cv=none; b=YZWSSlPOoPG94Ao9WNV/CPxg1YwLt1g5gshIOV0BXasCEvebeaMh6BF1/l8qobgoG+c1iVeXmn9bES0x+aEggafPnFcn46g9UQ6inQdiIpISc9A8TWV1dG5znB2I3cAs3PcYf9rGpmnpytmFvRXJoER2gT4NxYOOG3qy9FhctuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752171065; c=relaxed/simple;
	bh=kyRQoyVM2bzWbnGPxc1gi9+NEdvtsmR7MWvYL04wqOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kBSWfnIQnawwQu7qJq5mETT0PInyEb4tem4nLBLtPvIBJHKiPJjMVe1o+0zDkyomQYdjtyWcncgrNZjiZLZvSckBVbOFnywP3B9BfkYM7c3zu/vvs0VUs6QFht3LEd6MpGMNV4BE4ylo9vQz8clzWt1DD80sdnnIimtamezgrpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5qXXsUV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752171062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UDaamw5XinBR9QkXrVlCRaMipACe0i/+L3o+AWfTDMU=;
	b=O5qXXsUVUkbDvCcgQ8XCTnPxjxwDLXY02cOupV6BO7eKFtCir+wQ3uXVTNwumgV2h6MzKb
	jp9T6gIy+Ezy8tXofTTN8mr59gytg/DLPfYOZDqQDHTkidfzPtOfOuczREE0yvng2fMrcT
	x3XjdSqepgsFHe3XkPefSuEio/QKk1k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-U2ZcBvD7NFKz8ha2kzHlYQ-1; Thu, 10 Jul 2025 14:11:01 -0400
X-MC-Unique: U2ZcBvD7NFKz8ha2kzHlYQ-1
X-Mimecast-MFC-AGG-ID: U2ZcBvD7NFKz8ha2kzHlYQ_1752171061
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c955be751aso201363385a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752171061; x=1752775861;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDaamw5XinBR9QkXrVlCRaMipACe0i/+L3o+AWfTDMU=;
        b=mGWRRaCuzuveHJTcTunmYveRL1D4gz5S1DQaf33LgB951YDDyqq2tOmxHq3bHWEr9t
         FOi8td5mOfIf1kPcGHWR8Gbp12NWG4trxay056xNvbQVjujR3evM9mObjoN+5/pvPsap
         xmNZKVRs7zfrbWbd4kUWBUy2L3LdFC7MqsXJsvaI8LDmHgYpQHaY/8jgoq80veXszXUM
         uxAIFzYnYJsNhZjFG8z6DKJceWjlppJbOew8bvxrVyEeyeRN2qfb64zTn+ZotBpLn4ls
         apq2x48gn1DQXW7G9Go13dr7KLKGxih+bcd/cDNe2f1yWGwghHzi+zp91gs73wM89ZI0
         9fww==
X-Forwarded-Encrypted: i=1; AJvYcCV9yNTWG+H9tNhv/6To241A3E+K0bVirUsAB/xl0XTnfQK+9/Ao/A7EWBh1B7QLN0Pyq0VAIVEk5BhGVLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRwAWmVyFD7nTIgnXI3WuEB43DaUKJbbZSQZ4W1xaUQXVVryx1
	ktbG/jbFOMsuQWouIAT3D/MMlNMO8NNRTKRxwaY3QF2VgSXX3zfoZFxWtlcvmholIX0W2QNnDmz
	K/NvB8UzUH2Fp5crdHp+j2hbpP1qHn+8m5t6mkkHlkcRH7k/WgwrU78eEbh0ml+Y2Xg==
X-Gm-Gg: ASbGncv/XnJHD97nQ/h8rPUMTApP6BrVNKh1lacnkGuOlUob8krazqXQjgQNO/056bQ
	Q84E2jm5hHsP4+C9Pd/pxaZC4O6BGr3EsBRsJi0ICaM1ZXSkLGqPdPaqg/oMrufP1Llw6WgWnjZ
	JoJtYiVgNBfOzg5z7k5LFOYWPBQPVHC1QIeYcZv1zv/ILndPWz5w4HvbGgaCfmLIBgfIuN6DLRH
	7CLPp8bWxmbkPAC+Mdi9C4TeSkwh5Wyt6nOS5lY7e30HHrSmwJXKyFuMrc2ZYEK4tf17t/A26LQ
	5vvBd+6jIbjpqFKmwxmqNIieCW91pS8AlkDr1/DsXbAZ0xOxrbj/STJigIrb
X-Received: by 2002:a05:620a:4726:b0:7d5:dcd9:57f4 with SMTP id af79cd13be357-7ddea818e2bmr78794985a.18.1752171061204;
        Thu, 10 Jul 2025 11:11:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYWoqzrM13LlMP0WzQq6WZZk3qyqsWk5e4K0LKkki76ZGMrwuKyffsVmVRcU9EDW0/eLxBfw==
X-Received: by 2002:a05:620a:4726:b0:7d5:dcd9:57f4 with SMTP id af79cd13be357-7ddea818e2bmr78788985a.18.1752171060677;
        Thu, 10 Jul 2025 11:11:00 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcde806289sm124403285a.78.2025.07.10.11.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 11:11:00 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 14:10:41 -0400
Subject: [PATCH] hwmon: ltc4282: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-hwmon-round-rate-v1-1-64fbe4bf3d05@redhat.com>
X-B4-Tracking: v=1; b=H4sIACACcGgC/x2MywqAIBAAfyX23IIaEvQr0cFqyz2ksfaC8N+TY
 C5zmHkhkTAl6KoXhC5OHEMRXVcweRdWQp6Lg1HGqlYr9PcWA0o8w4ziDkI9msK4WGcbKNkutPD
 zL/sh5w8hKVKwYgAAAA==
X-Change-ID: 20250710-hwmon-round-rate-1b21b2bf5a53
To: Nuno Sa <nuno.sa@analog.com>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Maxime Ripard <mripard@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752171059; l=5669;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=kyRQoyVM2bzWbnGPxc1gi9+NEdvtsmR7MWvYL04wqOE=;
 b=6eQpeXc1h08bv2MtiVCAFjsSZrIXlAVycUsMGd5pLQ4KsDXNvjBRCIiUC0L5D2hdf/GXf0G8Y
 8Y30vGDGn/qB/i6oj2zQH7Ti/uRnt5rMGt6Znb6AwrL7fqIqUn6jpuy
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
 drivers/hwmon/ltc4282.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/ltc4282.c b/drivers/hwmon/ltc4282.c
index 424fa9e3a0993f74d7bd1b2e3c98acd954217a98..dbb30abcd343f3dac46bd87cc52638b75eb5b275 100644
--- a/drivers/hwmon/ltc4282.c
+++ b/drivers/hwmon/ltc4282.c
@@ -177,13 +177,15 @@ static const unsigned int ltc4282_out_rates[] = {
 	LTC4282_CLKOUT_CNV, LTC4282_CLKOUT_SYSTEM
 };
 
-static long ltc4282_round_rate(struct clk_hw *hw, unsigned long rate,
-			       unsigned long *parent_rate)
+static int ltc4282_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
 {
-	int idx = find_closest(rate, ltc4282_out_rates,
+	int idx = find_closest(req->rate, ltc4282_out_rates,
 			       ARRAY_SIZE(ltc4282_out_rates));
 
-	return ltc4282_out_rates[idx];
+	req->rate = ltc4282_out_rates[idx];
+
+	return 0;
 }
 
 static unsigned long ltc4282_recalc_rate(struct clk_hw *hw,
@@ -1124,7 +1126,7 @@ static ssize_t ltc4282_energy_show(struct device *dev,
 
 static const struct clk_ops ltc4282_ops = {
 	.recalc_rate = ltc4282_recalc_rate,
-	.round_rate = ltc4282_round_rate,
+	.determine_rate = ltc4282_determine_rate,
 	.set_rate = ltc4282_set_rate,
 	.disable = ltc4282_disable,
 };

---
base-commit: b551c4e2a98a177a06148cf16505643cd2108386
change-id: 20250710-hwmon-round-rate-1b21b2bf5a53

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


