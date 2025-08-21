Return-Path: <linux-kernel+bounces-778735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B33CB2E984
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC0A1BA326B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D7D1F1505;
	Thu, 21 Aug 2025 00:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rQffoihc"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016F91E9B19
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755736976; cv=none; b=jAW9KPk3T7Krcl4tUGZStxLcMWBSZBZQA7SgNxdnW+HXqauUKgxAnO2S4dRUa6c5GooHsFgtEVt2tBnLOwSsp6NNXsAmDrOLT2Cwa8LWo1pkGfnEXXByaTAjznKxhnL2qfSKXyGiVQ+D9JjdLybOkyeXk6Tmmtsm1GGDghf7Rfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755736976; c=relaxed/simple;
	bh=2lP2MUQuOgx41bHQcQY3UUFM4RqOiMsYu1XcW3FaZ8I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n9AiLGJo29olVzb2OoxBmeR0tLlOKtwAm9tgaeJU8zar/vzXd/fR5BIbVKS5g4T7q7mLvjEKDZZpiiUL1pQS2XtMQfli1NtWl/f9Sxt3rVfnsMg+BEBQlidYeuUxcB5xYsx49pyq37EqeZiGjMbW/XyMmrQGhTRyDcN0ZmMLqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rQffoihc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2eb6d2baso1201134b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755736974; x=1756341774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=whxbRvyrG2R6Ou7PNckHYEhGY8IAGr6EflBJLkvDYbA=;
        b=rQffoihc5Zlo5diIPKBE3DkHdiAMxW2/QNuuch4dnRTJHb5ksS85d6Y5+tUjmMRVRE
         D1MoKP4Wa14XoxkOyXZsUAQGHtaKV26OkhdS/8De4tFcAkvwNW/IkEhSRHHZrP7wfymN
         vqY+rTWIWh+9wRYQmy5baqrCcBO89aGfFHICCDGB8cM0LWxSQ7RJKwt2UNcdC7qLosFH
         zepM5H0p0+Ysl4omECTgjO2zJFMq9cUC1/cPgWZXHzI8g+1dsn4kvG17j74P+vwL1evs
         pWFhTVmW21t1X1ZMt3rXbE64h5uz3mfqyJU0/t0rtuADcSpY7rf5uQz56ESw6sdywvgU
         KLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755736974; x=1756341774;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whxbRvyrG2R6Ou7PNckHYEhGY8IAGr6EflBJLkvDYbA=;
        b=u++z6VEBjLDesy6WUetBVGlyCF3jYBHnV69S5KP9R4YXfrZyNeupQ/Gw6Q+WaZyEMv
         blMjafmLiDHr4+EEzWt/oj3WsC0yh9bJQQjbU1596pmZD/xui5YRZD1fFmU216io+dH8
         c4XoG/fLGUlcyB2DA/pv00X1PBXMyQogdz1n3N+OGFtOViy08JqThavCm/C6rk88x2m4
         m3TDyHhSqmfttvBb+1XDrD2JUx4tfFjyEOFcjcw5Xe5RJLRjM2MWL51CyOWgFCxIy/ro
         cGVCYC1fzAsMHOwjF1JPNEVaaLEngskyHE+PVqsIazDPkLf/sjQFZaTGXw5crGQH5t5T
         HtMg==
X-Forwarded-Encrypted: i=1; AJvYcCUtCDzTp0p30FRVdxA61458H26cODS+m+eauQS++UYBIzMQeOkysjAH+MoHvLXj3ehbG6ZE4OSQh277Oro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2qKImK6Z3CpF7wBX95CotSw8210f/0S5NYNuPX8psUSoIJp2
	2dXa8f3t8PG8isblEEIFROo373rS0GBeEhsbH6THIZs357KYc4yeBygie2HWlzy2j8OFwG672+M
	cbLgwfTdKH8kSlQ==
X-Google-Smtp-Source: AGHT+IGiw2oiWfhdnXju/fyAVoDAT9Nlowj94H89J/6yKp/tBjPFanTJHaBE2jWVd3ljUK9vgOw61mk3YqX/Wg==
X-Received: from pjbtd3.prod.google.com ([2002:a17:90b:5443:b0:31e:fac4:4723])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9183:b0:243:15b9:7656 with SMTP id adf61e73a8af0-24330af16d3mr629567637.48.1755736974379;
 Wed, 20 Aug 2025 17:42:54 -0700 (PDT)
Date: Wed, 20 Aug 2025 17:42:33 -0700
In-Reply-To: <20250821004237.2712312-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821004237.2712312-1-wusamuel@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821004237.2712312-2-wusamuel@google.com>
Subject: [PATCH v3 1/3] PM: Make pm_wakeup_clear() call more clear
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"

Move pm_wakeup_clear() to the same location as other functions that do
bookkeeping prior to suspend_prepare(). Since calling pm_wakeup_clear()
is a prerequisite to setting up for suspend and enabling functionalities
of suspend (like aborting during suspend), moving pm_wakeup_clear()
higher up the call stack makes its intent more clear and obvious that it
is called prior to suspend_prepare().

With this patch, there is a slightly larger window when abort events
can be registered, but otherwise suspend functionality is the same.

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 kernel/power/process.c | 1 -
 kernel/power/suspend.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index dc0dfc349f22..8ff68ebaa1e0 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -132,7 +132,6 @@ int freeze_processes(void)
 	if (!pm_freezing)
 		static_branch_inc(&freezer_active);
 
-	pm_wakeup_clear(0);
 	pm_freezing = true;
 	error = try_to_freeze_tasks(true);
 	if (!error)
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index b4ca17c2fecf..4bb4686c1c08 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -595,6 +595,7 @@ static int enter_state(suspend_state_t state)
 	}
 
 	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
+	pm_wakeup_clear(0);
 	pm_suspend_clear_flags();
 	error = suspend_prepare(state);
 	if (error)
-- 
2.51.0.261.g7ce5a0a67e-goog


