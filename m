Return-Path: <linux-kernel+bounces-837976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFECBAE296
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD0B4A4D01
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1FA30DD26;
	Tue, 30 Sep 2025 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B+dKGYhu"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E697630CDB8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759252925; cv=none; b=L5FjrrrOXh7XdW5Six7kaqmIroY3IsFC1arnhOAtLLz0Sc6Ctw0mPD3eAxv+OCd16d/LSAwu21GIk1W9seSLslfxdEOygrRk3AE5Hqk2jW58xn5jUe8qfFVdZJ+Kd9HA+bSPYmaSr7lt7CnJznKCrw24yLlSMv9HYYfZDGw/fsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759252925; c=relaxed/simple;
	bh=GFEUQIJUCkmPFCCykSE+SQS0O7PhGUwsWOftaDX6dYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bmAp2BYCOEDqAqHMXOxYqJv3uS2N20UESuisuHJ5dmzgUfrsvMSyhaCyAOsy5jVuOlY/A021jyWajO0tGoNK5wg/BUJ4XOxdIpSqsMSgL5ePXXgbrrvBn7RnaQX93wMR2J6fqUof4gy3w1jJj2MH8bWAEDbmxR40PLfPHldQQKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B+dKGYhu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e3cdc1a6aso808705e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759252922; x=1759857722; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9dKhQXGovS1oeaED9pOXvi/m/Bjh7MbLIiNntfgxDU=;
        b=B+dKGYhuwsDe9mTLv3pd3s4es69ryfY9AbHk1N2vPrOia2kQ89hGqPLyggl5crrzgH
         CYjWvlUcok3v+1oV4hgxPOuloeJRIt1v2P/1Hign0qa4Q0d4NhCOWXnBTMMfx5KaSZC1
         3oQB1K/To40bmMNi38HhAawT+mVozwrBufNO7GPwRvtmafLfnJzU/NOWieBe228reoqR
         eWHL1+VS2VTDwHcW/EvyiSvubo7rBQu0HrB7hvCR02san0VRGTDkJesRKd1cH/wx0FPv
         T+IOBWlVT0a1CZYlAX3eK+bt69TUvJAIU4ZZh7qatOC0zN2zau7d+pUHMAhG8qV7AA5l
         DRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759252922; x=1759857722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9dKhQXGovS1oeaED9pOXvi/m/Bjh7MbLIiNntfgxDU=;
        b=MR1FRnquMKFaHzokx+lHvFObc9zorLBd0EcB+4CYnXNTuUT4R+7thQixAmwJYXNMQD
         MUc9vSDRS51/gQnxyzT50OpAK3eZAvXgsTm4BftQE9fkNwe6S3vwXS68Kr0GmfbPPL47
         u439U18kH9/YnXySWLIktGmuA9XZzPyi/2kNzTLNqoecb2ygnFAqJnMgoFPw0zv1gLv8
         SfncVXoVtSO+R/TqPvg1XLzIucpwqbNPC+s9uJiozKflrKpKtnFMkfzzQoXxzjAeNLOa
         jgFxxTUOiodUZdh8IhaoUoWQwdccE9l30melIJzyv+UldyHv9Iu05la9Pua6/9ujnXdA
         opow==
X-Gm-Message-State: AOJu0YyUTZmao7hyvvxZ0PZXaLCogzJXfo6aMGuqpGO4s+43QDbafh+Q
	xg4jOLn0p+cWgPUKFWzaTQHwSrMKoDADHSBBILAaChLVGKlqGCvzW5R415fPMbfV1jc=
X-Gm-Gg: ASbGnctZBloEq7rbwoB9oLJHP1DAb7WYGSEut4+hfpUMl3kDxHxEgMA1VtwpKRvk6C2
	u7zpU9cuX3WGa90395glFOKZRR09ceoB5s1TERwbWSyfeJnwobKN754zaEZX1kl5a4hcAonyais
	jX2/X9q+ot/D+KHyn0dq4+Z+CVl7Gqw6tXwIiurVT7N20NBoXf0h1EdKWuPhUag2j2e9YbtVhg9
	/vyrMm69EKyNJjY4RmnIaEMLN+OHqgQFKNOEuDkMJ/weS0L8ln67EBishwB/Vi737DEdkAC2tMJ
	4gHfYKryIrOzfwVPUn7NHQFn1THPl5QhjgfN1pN3xdbpVHtm2Aa/iYqrrLqtNvDhS7w6DMgdKSZ
	haDRmymV/Ie/zl1Ro4E6i7A6LnDSGUSCzW0GuitssvCk8rm0sG3vy3kY5stM/EQuWLSOIFg==
X-Google-Smtp-Source: AGHT+IGc/NKF26+LZgWofl7aRSsll1HM8ZP90q7bmD+iyDXEN3293SZ+SnTVd9LCf7IaiSBF0ffaJw==
X-Received: by 2002:a05:600c:4815:b0:45f:2b0e:b835 with SMTP id 5b1f17b1804b1-46e58ce0e22mr30359725e9.10.1759252922138;
        Tue, 30 Sep 2025 10:22:02 -0700 (PDT)
Received: from [127.0.0.1] (88.36.160.45.gramnet.com.br. [45.160.36.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a17a0dsm2459465e9.17.2025.09.30.10.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 10:22:01 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Tue, 30 Sep 2025 14:21:10 -0300
Subject: [PATCH v5 4/5] printk: nbcon: Export nbcon_write_context_set_buf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-nbcon-kgdboc-v5-4-8125893cfb4f@suse.com>
References: <20250930-nbcon-kgdboc-v5-0-8125893cfb4f@suse.com>
In-Reply-To: <20250930-nbcon-kgdboc-v5-0-8125893cfb4f@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759252905; l=2672;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=GFEUQIJUCkmPFCCykSE+SQS0O7PhGUwsWOftaDX6dYs=;
 b=pWgf2sGREzN+vcWhVnIUx1xJEgLE/ERGoDb8uj5i/w203YIEwWIF4ZVYz2irbFcYn4GNXrx2S
 TOepELNeoVsDl2vpibyVqNPnrQAdW7wQwSeTdWSzgT0EkZSchA9RrPj
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

This function will be used in the next patch to allow a driver to set
both the message and message length of a nbcon_write_context. This is
necessary because the function also initializes the ->unsafe_takeover
struct member. By using this helper we ensure that the struct is
initialized correctly.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/console.h | 4 ++++
 kernel/printk/nbcon.c   | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index b34c5a0b86303e2fb4583fa467d8be43761cf756..e0fc2608bd9d6a886f5ddc56d26f19b21ae8663d 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -602,6 +602,8 @@ static inline bool console_is_registered(const struct console *con)
 extern void nbcon_cpu_emergency_enter(void);
 extern void nbcon_cpu_emergency_exit(void);
 extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
+extern void nbcon_write_context_set_buf(struct nbcon_write_context *wctxt,
+					char *buf, unsigned int len);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
 extern void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
@@ -654,6 +656,8 @@ static inline bool console_is_usable(struct console *con, short flags, bool use_
 static inline void nbcon_cpu_emergency_enter(void) { }
 static inline void nbcon_cpu_emergency_exit(void) { }
 static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
+static inline void nbcon_write_context_set_buf(struct nbcon_write_context *wctxt,
+					       char *buf, unsigned int len) { }
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 6e4641350fe8985438f53bcd32f3adf72d9d6835..2492b14bd272562378c4cdb465eea2269638e127 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -854,7 +854,7 @@ static bool __nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsaf
 	return nbcon_context_can_proceed(ctxt, &cur);
 }
 
-static void nbcon_write_context_set_buf(struct nbcon_write_context *wctxt,
+void nbcon_write_context_set_buf(struct nbcon_write_context *wctxt,
 					char *buf, unsigned int len)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);

-- 
2.51.0


