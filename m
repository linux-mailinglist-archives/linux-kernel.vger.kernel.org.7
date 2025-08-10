Return-Path: <linux-kernel+bounces-761618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE9AB1FCA5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E121895AB3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623F72D29DB;
	Sun, 10 Aug 2025 22:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1WNl17D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6482D29AC
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754864088; cv=none; b=BObMaqdL9YF8DrAgLczBVjFdAl7IJu9Rte+tVaE6Y4sqkbiQChz3kGoAeN3cmaAwO416qjoBle+k2rpjudlK4Nq9KXvdiy8+yLIM4xNDXD/V3gmGGnTKKoFiuXNmJp24Lah4IPJdVLYYmL8mjc4Izscu4ZVEpHGZyhadUJuY9yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754864088; c=relaxed/simple;
	bh=jz7/9LA5nqtTc8DEmJ3tySqiNMryRr+zseg+ZWr6gdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Zox6ATm89KViXF/5TjLzuG141pdY7U4Dzf0On6cfnyICB6kKYScdqcMxqb1ok593R+JbjNqY/GrCKeiHgDQ0wQNJJZVQ/CHOOnC6pciuj2w2o+yuvWYYB10sFCHDVV+aWyi4Qgi9WkABd9SG5Y5MgdEU9EpZOElAVkwyq2NKuz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H1WNl17D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754864085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2GwKtVFUrlpaPE1JQwv83mROvsduJB26dF0XiBC388g=;
	b=H1WNl17DMVyV++8z/n7by23GwY/WGf+1fbW+o/WAjoI4+UYXcpkvyFV3mGnBoFpApmIAik
	idVxihdhBpp5+5fo6W9xpI8tN5VtIK4KgUeLmIvApC0O1idPx8hCYP8YLS6ZJELTR/DRyN
	ueb10GCB7Jyt2oMmcROFzMyLwLDajno=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-gMl1EO3WONW3v8NCdal5Dw-1; Sun, 10 Aug 2025 18:14:44 -0400
X-MC-Unique: gMl1EO3WONW3v8NCdal5Dw-1
X-Mimecast-MFC-AGG-ID: gMl1EO3WONW3v8NCdal5Dw_1754864084
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e7ff9e2738so850525485a.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754864084; x=1755468884;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GwKtVFUrlpaPE1JQwv83mROvsduJB26dF0XiBC388g=;
        b=KlSOmp/G+lZvRAftMkYX7lkhoyAKWVcJkjHJMtV+bWLH+svrDz+yRNFDS6rsTeauia
         8Ce51bIl/yWoTb+W76yZbEAQc+BJ9cp3zwQPXChc1er6InE5N/QGAfsUSqfOu86t3cA7
         2YmBDzypCxvAp5qxpjLujhTMXbsp11tCeX0F/KJm+BsJxWoh+aKLN1RZFBR2rKb/uN18
         QD4cVILgAfOUa/QpMDmdfyUUGySdS0CtNItI6v9RN+F9tvAZnJ0GV8PBVmP/ob5Kwv8U
         8R0menCyfLYXsLWnKcY/PeaysIEqMSu8QdhQ9ZckJ0YeO6Fm/XeBYUmsGorfMMdWZj5V
         0hSA==
X-Forwarded-Encrypted: i=1; AJvYcCVoLQl7ugCBq+hW7hB8AoWD8Nny1nJ/h/SwVPJ1V57KQvddNfOhxM/IZu+lJMfYcxrGqTIi0OPIrBhUNFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBkeS8Bh0aE3sD41Zlz87XnZ+RurmGyMiIxrN7Hb5Q6JxrrwSx
	6NdpdYnyfQgM3m7DOIOql2ugsj5n1mRNgZHxYiSwMMtp/xLZwQkTP5RzH2E0bu1keFXmIgOanfZ
	z93xUwdf1ha0JB3cDnNH4IlXBWi3W5T76YAVfK+rltsU/dzKknreDjymQ9LIWL/LsmA==
X-Gm-Gg: ASbGncs9X+ulnU2y+0yDg8VUQl7qRcvCw0KyQ9NoqYMEf7nB1oUz0Tk/3j4rL8Xpc5g
	sG8eGSLWFsHlX13FPvbM/ZtSEw4Co5aA3oRL8DlzdV7RnGGH1pexlL6zYEcFqfz78j+MerGhjBZ
	bWikG+hhvfWqYNKUQN34nyzfct6+6Ab8WM7/lTWuGNFFcAZCiQc4HK6HbhzsNsOOM43OQkg8fnc
	iifZiDXn2+snEDgv7WhVb+i0QqZN+l5GWQmWwqXZ2NFpHgBp/+stQQZcHIYr5ojQKHD4LG8SF87
	h8HTzy+Z/iU3vOYsa7/nuoDYb4/SNQh9CJjcNz617IaX2Xe6Kl9sV6rMSM3eCl344zTprP62Hjv
	Ff8s/Ow==
X-Received: by 2002:a05:620a:4d51:b0:7e7:fc32:f07f with SMTP id af79cd13be357-7e82c69ba2amr1112914485a.22.1754864083663;
        Sun, 10 Aug 2025 15:14:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9NI96bWeLh5lxwdnlOadp7uqXcJhAUsM8BjFicctQ3xkj0L8GeIoemwkVa7G3O4MR88fcEg==
X-Received: by 2002:a05:620a:4d51:b0:7e7:fc32:f07f with SMTP id af79cd13be357-7e82c69ba2amr1112912385a.22.1754864083264;
        Sun, 10 Aug 2025 15:14:43 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e80c0e6ff2sm859068285a.30.2025.08.10.15.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:14:42 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:14:25 -0400
Subject: [PATCH] tty: serial: mvebu-uart: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-tty-round-rate-v1-1-849009f3bdfd@redhat.com>
X-B4-Tracking: v=1; b=H4sIAMAZmWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyNL3ZKSSt2i/NK8FN2ixJJU3ZQUi2RjIwPLpGTTRCWgpoKi1LTMCrC
 B0bG1tQAL24G8YAAAAA==
X-Change-ID: 20250729-tty-round-rate-dd8c3209bc5a
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754864081; l=5898;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=jz7/9LA5nqtTc8DEmJ3tySqiNMryRr+zseg+ZWr6gdc=;
 b=URcjH7lCRhkpxA2IIBHqR/PqogtMFfXPxQTAFLohl31GisVmeaLicg7w7s+TwY8XZ5al4vX/c
 8pFak9Mvep6DkuHVlqdJocWOO3x/W5NkOV6arKOAHnVrZR5Mh18Je3d
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
 drivers/tty/serial/mvebu-uart.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 5de57b77abdb03f2fd46b2dc7f9bf7f00c34c15e..8e52be2b34ea20634bf45c26773728af1e5e150e 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -1264,14 +1264,16 @@ static unsigned long mvebu_uart_clock_recalc_rate(struct clk_hw *hw,
 	return parent_rate / uart_clock_base->div;
 }
 
-static long mvebu_uart_clock_round_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long *parent_rate)
+static int mvebu_uart_clock_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
 {
 	struct mvebu_uart_clock *uart_clock = to_uart_clock(hw);
 	struct mvebu_uart_clock_base *uart_clock_base =
 						to_uart_clock_base(uart_clock);
 
-	return *parent_rate / uart_clock_base->div;
+	req->rate = req->best_parent_rate / uart_clock_base->div;
+
+	return 0;
 }
 
 static int mvebu_uart_clock_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -1293,7 +1295,7 @@ static const struct clk_ops mvebu_uart_clock_ops = {
 	.is_enabled = mvebu_uart_clock_is_enabled,
 	.save_context = mvebu_uart_clock_save_context,
 	.restore_context = mvebu_uart_clock_restore_context,
-	.round_rate = mvebu_uart_clock_round_rate,
+	.determine_rate = mvebu_uart_clock_determine_rate,
 	.set_rate = mvebu_uart_clock_set_rate,
 	.recalc_rate = mvebu_uart_clock_recalc_rate,
 };

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250729-tty-round-rate-dd8c3209bc5a

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


