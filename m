Return-Path: <linux-kernel+bounces-887472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED24C3850A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2338E18C5455
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193442F5A13;
	Wed,  5 Nov 2025 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODue21CA"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0731522D9ED
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762384588; cv=none; b=JHPFE5DJ0qgNivNwL64SmIw6+wRqnTIriqSaS7Y/AuR5x+6qh0iKnN2F3B7vBTSa9qa/xGCLgm1D5tJaIVg1KqzWFmo50ofSh0/77QmgdWN7pTP1ZxcG/Es9ggfSAjRq1r5Dt/4e1ixOzy/itBR60IWa/pA3wVzFFgT0+mCAWsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762384588; c=relaxed/simple;
	bh=e6jD5hdSCkP9wj9F2pVu+mv4QnPWEtyyZd10Wf48DLk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LapgcXe7ugSAGLrOaGx/SFGtj0uAn9XtP+JIM0igPta5V0SSabA1gn0kTHHRjtquNC31Ik80RIuITYoajd5pGHaR4xURD/dTDb95Vnl+c+r97/NQTg+dj/xFX1zOEqX5tui18ssmC31YoVfKPOBYN/ziErtneqb7wR1GYO3M3RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODue21CA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-28a5b8b12a1so4131405ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 15:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762384586; x=1762989386; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RX1qE9JfxvrjTv2HrVqHbweUGcmRUr75mVzjILMuovE=;
        b=ODue21CAHcCp2wxcltdGLt1/v42uqheVEW16dsSaoTsFlFh8rNfP4y/nf/LyWphYi+
         lxGViqqAyaOJT6nZpe5Wu8pAlDbrq9MMTW3rOmqghS6DMUayKEKLoHgf5CaaJxUxP8Nc
         tc31qs9v4SZxbIo/F+qIoHqEnuaxBjvd8ShldpBXoF3krCSvSXdnkv9LuBKW1M6QsrAx
         2/zkRymOqRe7BKH3pct4sj7GzsKMbbeB+kS0bTsDfC83I6XX3+Dhvz3yBssxBQ8Nq6wU
         GtF8bCfIu8JF9T8JhKVnd2xa7YhAbRatUhBZZZ5OlYSMJKrPU5rjAiRDDzjTu8Ey7nIj
         TLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762384586; x=1762989386;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RX1qE9JfxvrjTv2HrVqHbweUGcmRUr75mVzjILMuovE=;
        b=hKe8GqBxIOh9LUr4L1Ire/+2dGn50Pe16y4AeSYAbIQZ1K2xs2A7Y2YVhqQoFa2JG/
         SqaL1Z18gCwrYtvwvLS41jpATty5z/WV93DAJ+yyzkzPvBb7EYJQ8OVi2d8YbZMqWKH/
         IQa0B8j7sPFKzHA2WWt2J2RYvHPLL3S92KvH0hlsVKgKCiM9WCfNcSDtJ++Na24Lcn3a
         GxRCEUhw+sSY5nbIrFA/4wwjf3BSSnS83FrngF4EsuiFXwc8Fz5A/1W3uEOgc3Mst+eB
         2XsC3sEsO6hltMtyvB0RUw5iARunKsWta/o1j2f9wzr5Ss5eASCN2k6njNbTMH3iNQ7a
         YjCw==
X-Forwarded-Encrypted: i=1; AJvYcCWFteHu8hTqP4ngf+XHA6Y3/4VcR4H3tNtHQez50gPo4vynkdKrpGWUxWXhMWbVnR96nmXueIToxYdnSxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXf7gAoZ0CmnA0R0OY2wgn2nTtUGZKHYE84JMYbkSIf/w1bmCV
	25apBkn9XHbUdTbAWZy1xFQoIomrEl2tMTNxeXz0EUan45Yqt0ukH5zi
X-Gm-Gg: ASbGncvVgFaN6aEG7ZFgCyoJTLffU+4J5C+ZCqQmH2DEX9sRj6/dm/XAiGoAGm3Ue7t
	C947J6jEO8vR+QZFax/K1u8KHZvZierGqwgAaX3FB0UvzEfjGf6w2xchEGEw/Ez76/Ok87mc4UF
	D4M/Yt7Xybln3I7ZPiMEqDhjZA+XMEQIUOT/u4A1tybay7C3DEdozLiSL3NSd8F0ru/KqpjjDIp
	YHsJKgUmgHDEAsl2oslgIAdZQ0p+MQbBYt4sQGx2aDXT1vZQOBtL/dgevB1jlD78QLPHKgmSKJh
	0Dso+jY61SKFOTLibENjDjTM4uOsEk2mLVQOGi/90Ri/78OwSJWttRisRV2UzMPhDOX9ZblRX2X
	tuVmfmxG1k1eLlzhsO0lcFSB1wf1KznXRnmQpvHoEZ4nKTNolVrDQOSS0TgwHqX+29GzMqAeSGa
	FEdxVOsOqn0z5jAQP59cFATvBiOy2gc7o=
X-Google-Smtp-Source: AGHT+IHwGnokLCjvbcdSCINEWl8ApF2UrW7eRnkmyHI1JquVYGX4YrDuAGrD18oyRDIe0c25ehldhQ==
X-Received: by 2002:a17:903:17cd:b0:295:987d:f7ff with SMTP id d9443c01a7336-2962adb91e3mr66930325ad.42.1762384586138;
        Wed, 05 Nov 2025 15:16:26 -0800 (PST)
Received: from mitchelllevy.localdomain ([131.107.1.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c93ce0sm6391925ad.88.2025.11.05.15.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:16:25 -0800 (PST)
From: Mitchell Levy <levymitchell0@gmail.com>
Subject: [PATCH 0/2] rust: cpumask: Bindings for core cpumasks and cpumask
 iterators
Date: Wed, 05 Nov 2025 15:16:13 -0800
Message-Id: <20251105-cpumask-iter-v1-0-7536f906d7ed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL3aC2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwNT3eSC0tzE4mzdzJLUIt20NIM0w0RTC0vLJGMloJaCotS0zAqwcdG
 xtbUAxNVusF4AAAA=
To: Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762384584; l=1188;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=e6jD5hdSCkP9wj9F2pVu+mv4QnPWEtyyZd10Wf48DLk=;
 b=ChVOHNPTUc/c+seiCWWmxZ4Pl21Y12dVmttpw28i93SVkwr2K1YyQVNlyum7ql7gazUAxqtZM
 2NxEnp1ucRhDNM+uLmVq+NlnUANtz5EyOrOLM+rQs/j4OvvPp5c/WGn
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

The kernel provides a number of very useful CPU masks from the C side,
including CPU masks for possible and online CPUs. In particular, these
are very useful when some operation must be done on each CPU (either
each possible CPU or each online CPU, etc). Therefore, it seems to make
sense to add both of these functionalities at once.

Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
These patches originated as part of my work on a Rust per-CPU API [1].
Boqun suggested to me that these may make sense to merge separately, and
it does seem like these might be useful beyond the per-CPU work.

[1]: https://lore.kernel.org/rust-for-linux/20251105-rust-percpu-v4-0-984b1470adcb@gmail.com/

---
Mitchell Levy (2):
      rust: cpumask: Add a `Cpumask` iterator
      rust: cpumask: Add getters for globally defined cpumasks

 rust/helpers/cpumask.c |  5 +++
 rust/kernel/cpumask.rs | 94 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 98 insertions(+), 1 deletion(-)
---
base-commit: f3f6b3664302e16ef1c6b91034a72df5564d6b8a
change-id: 20251105-cpumask-iter-ff0f1a5899b3

Best regards,
-- 
Mitchell Levy <levymitchell0@gmail.com>


