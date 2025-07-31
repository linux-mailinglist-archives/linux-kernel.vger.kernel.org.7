Return-Path: <linux-kernel+bounces-752055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C99DB170DB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D382E7B0C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61DE1990D8;
	Thu, 31 Jul 2025 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aXVIbMzX"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2127F2E3716
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753963513; cv=none; b=fbYSlIl+KLZknq/y/Gj00Kq39I7nMbbf31oMfn05HVxdQdW62Upw8yXy24k7v3UrUhkMIOxMSeYpVvIvhwAuhHltEOilbQ7G8W2CWhsjY7Z6WqsSCXA+L7V3ualkRjJ7AeZ+FlfWLfcVvRR+llVxyZ20aX/6uvAjPsNgTzWef1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753963513; c=relaxed/simple;
	bh=GBpzead1bfNf0i+JXavVnNWK7fvaerPJsDGtacyOrb0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ORYWAyAFVMr+t1NE0YtfunXazOHbx0nwRyS0tRarRH9NFzLn4zXOXdCloARR75puZ3FrhOjKadE1BvvITTQirUiDj4ez2P5i16yKuoJiGQ8UpG0Oi/zunmRA8rDJ9Ulq13Tai9LIDyxRZkS+o2EgMIM2VxSmFoPt0bQ8yGkgKL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aXVIbMzX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23fc5aedaf0so2235855ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1753963510; x=1754568310; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x8TpDbs7JcYVXpS/2LXWVtJRwBGtp9mOCA3zbGvW+so=;
        b=aXVIbMzXeBDXlRlPAAQQJxS8RZEzbJGQyvCeqtIR3G+C9eENLbb9CrB86oc+2CxHzW
         EwCl2XIsh+2L8B2HhCOH+2ZGdBQY1YQWkMGaG1AJKgiJR7DCWMimilYLzepvnyekyfR3
         ++KVbv1GZ4KdRfHj7qmDWW8QlHixhRcteh4I5p0Ixl2HEISMhNwhisBub9X8NYuPb6Gd
         Bb9ZpWLbgq6DbP0oHcOVVAOmWKU8W6RiEO7xU1r/8cueYOENixdt+IqkKiGW5yQ9FIIV
         ufgp+zYot6EYb0P4/9R4b0fw25e+sAxwasHYAmk+0rm7fAmhNUWmRcDklCAaIHhvsGI1
         wcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753963510; x=1754568310;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8TpDbs7JcYVXpS/2LXWVtJRwBGtp9mOCA3zbGvW+so=;
        b=PUPng5pUrIzwa1fC1+lyAOL7bQPb2BJeIUBrm+ey6gl0GLjUvSJpo8nzjbGj9PfSwY
         0QSufk/XEmtdKM0myIQFYvpSDio63s/bVex+PeLuQqLPZrxva0t1j5Qz2PFh8ZTcIy4u
         /4Mj1AxFbb2MXPxmgc/OASnfzAvL/OCNvaPfdzkQDVxUNJspkr4kx0iqANcmyEL0fa2f
         1FEAcjMTGTndC3J0LIXHD4CYmifZBnCAihwo+4DdNYF99/IxEKc/YiUpFJxrJwLDGfip
         JjKnBZU6dPvY3N+7r1cwIhKHwVjpMOTvKXmHBN9N1JWY43JC/NdWjPiIdkZkN0xhWcfo
         yjaw==
X-Forwarded-Encrypted: i=1; AJvYcCXwh/Zwa5QcliIMvaIqOLRmSrjj/dYZESVM1OmbL5GZ/emVbd8uGnmv9al/wGHMsmnvPVhAvkiJunVtY44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9w0I6HtUdYC3lTzcf2vToeeS64DpX+ZNPlhkDAPg7aWjnU8qa
	0HZ7He2H79bpnA9369Y8DXao+SxrWUFT3SMWCFKxmwca5wUs9Ge4jskbO1OTCoO1See/Z2pSOwC
	kKRM=
X-Gm-Gg: ASbGncuSrPuKplDXZ78vL2Zfu+wzPSqeTZpV9pgg5aP4ZwIMbmApryRpvGhakvC4SZU
	m1p6q/PoZd2C8TAZCMCb+G2ggdcjdAf0clpn49P+9s1DHMSrZXMzRfUaz0DPztBm/fzODC1PVUW
	Ki3iL/e3m4CyXArHe71uKMaEYxBKJhom5dMebF8UmHpwV9rxYTwvGJQJrvldxtMu1IfSZZAEzs0
	KGWoZJGZ7fGSNkqUZr4V2mPnYs8izWL4PMe2g7v29IDA9Cf++fo9ST21ZxNLIDPiP+leNZgua8y
	7Q6gRVxxnuI4Icx1p/Ftg4FDBj9D/xtDFaBweYeeNVo0iumGrP6QNEACSivZf2uJNW9ehFlxh8C
	0liMdgNWVXFMDXJ7b4aDG/SOJJw6YwALnHnw710Hd5pPmuYTEuuIfew==
X-Google-Smtp-Source: AGHT+IGVv5ZLod0tR/OqzurBPLv0cZ4NipkVasS9KzlFuPb8C2B1hpgjIcpBhC0IovXMQWR4Fg2aog==
X-Received: by 2002:a17:902:f543:b0:240:72bb:db0b with SMTP id d9443c01a7336-24096ab5937mr115848855ad.21.1753963509970;
        Thu, 31 Jul 2025 05:05:09 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89a3acfsm16476695ad.146.2025.07.31.05.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:05:09 -0700 (PDT)
Date: Thu, 31 Jul 2025 20:04:54 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource: Use correct limit for wd-cs-wd read back delay
 in printing
Message-ID: <20250731120454.GA309@bytedance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With commit 4ac1dd3245b9("clocksource: Set cs_watchdog_read() checks
based on .uncertainty_margin"), the limit for wd-cs-wd read back delay
is changed from the static WATCHDOG_MAX_SKEW to dynamic ones based on
watchdog and cs' uncertainty_margin, but WATCHDOG_MAX_SKEW is still used
when dumping information.

Fix this by using the actual limit: md(2 * watchdog->uncertainty_margin)
+ cs->unvertainty_margin.

Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index e400fe150f9d7..ae0fcd5af41c2 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -290,7 +290,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 	}
 
 	pr_warn("timekeeping watchdog on CPU%d: wd-%s-wd excessive read-back delay of %lldns vs. limit of %ldns, wd-wd read-back delay only %lldns, attempt %d, marking %s unstable\n",
-		smp_processor_id(), cs->name, wd_delay, WATCHDOG_MAX_SKEW, wd_seq_delay, nretries, cs->name);
+		smp_processor_id(), cs->name, wd_delay, md + cs->uncertainty_margin, wd_seq_delay, nretries, cs->name);
 	return WD_READ_UNSTABLE;
 
 skip_test:
-- 
2.39.5


