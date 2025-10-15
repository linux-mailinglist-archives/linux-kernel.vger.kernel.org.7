Return-Path: <linux-kernel+bounces-854942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EABEBDFCD1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF79A3BF983
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9854F338F3C;
	Wed, 15 Oct 2025 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dj4EeDmV"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F1326AA94
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547745; cv=none; b=rwztD/NNEl+LhCEHteteGWnb9rvMDrOerC8S1eR5a4sTmJUi0sLvvmvlZ0qtixd5Bagd4D/jUeMB63UuDZDq+kaTXjILHFMt/6uS9fcXhRKGz8YWTG/J77OFt+cPSM5qUfAJ78aXZyD+addQ6gjJAunuQQ3RWkuJOnDlbzu1ttQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547745; c=relaxed/simple;
	bh=i86tQ3kj9pxFfvbB1RlkpDvt8HyVK+EIrvCSKTEJEOY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=H1zLu687nliqHH7tpjJQTLn1iKTgEgw/COZNblunT241TvS5ojjjvZO3A0YsvFShwAmInBu9KDScj8gjU9MeB/FYPmSSJ23TbKVqa7FgL5H6s2C2pXKljm0moMBLPGc+D7QzGwHRngOfdH1s5LfPi/FVLi7Ad8yWASZlvaZDw1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dj4EeDmV; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-470fcde7fedso8579815e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760547742; x=1761152542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QBHxDRWHGxliOHReP/u8RLd4c9AB9k+2LzcGnCl31xk=;
        b=dj4EeDmV2RgjiAfvzCvrlA0lJ51f5zDIUQd8AcCNPu/EVxXeaqQ+8V7zh2+sRxI4u5
         LTKd2UEA3lKrPqRdbtbNcd0e0nZpsQCHF4Aw0zRLu45RXRgNte4DP/z+HfPrkcUENqEF
         vOCpwAD8NPGabya5RhOHAjAWEQB0ybNMcfBC7XxBJL/Kw018NX9UQ8FlEElTojPKPfyF
         yV/wy2p64l9k9KtTiO3Zp+018a7C63rt3zrkLoCCOXLi5sGkakf8hOxurRZbzUX9W5mq
         15ZXuqCd778tfi/X7hvgdFMPaC0mTJm20Lo4QcVfL++jEjv9Myw2rUHPnYM/Au9StdpT
         Rihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760547742; x=1761152542;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QBHxDRWHGxliOHReP/u8RLd4c9AB9k+2LzcGnCl31xk=;
        b=p9U6t2FqjJwyLe6gMdRL91KD/LzukdeuQMM5odSv/ReV8bDwZ1K0djLG/yiHqzVpUu
         OqSxtQPa2eLTup9d99m5Z7Pbhd7wMai7BIepBWHvd7INlBr9nlhwJnXLvBaHp+o5aMMd
         Bl9qH+Jc9FMveSyv/mM2OFSYWXK30q5EgftH7uAn3N0ggxzgYgIRCX8JBoiu5HqmOC9N
         JOD11qTJIh9SlH1FPO3ivBMfymld1QqyDzvPbmTX7gsgDamukvNmdaisJ6B0oqrtWoPA
         EMtWUjcI7ru50nfIwzA1OX0xB+3T6XerPkhXHWchUZjAFfabeSfiYqHd1AC4YZjIrJGo
         gqqA==
X-Forwarded-Encrypted: i=1; AJvYcCVG2/fOdNy/dHiFiKZkqC0vSvwxVs2AHM7nxNI7r161YvxBW8E5x/iOiFukyRU1ABARkhNLa9haDsXmnGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC1Xf2ecvcoQSLxLvVNhUxFHY97Yjo7zzjWZSDAsic9N1qVnkN
	KY7LWchziApfjAl9BflOOYnxSwtTuUNS1ZQ2KJeXBrkRRxoP/ttUpw+44Zbg0ZFTdJH3go2ZbKF
	uSFiwrOyHm+ggFQ==
X-Google-Smtp-Source: AGHT+IEahAjAWZz7ci0nmRAMGYaCHJkgfaP8dEV1z56+QjWTGu9Ae6CsrJK+bfQ/1Y+7KAn6biwNhcKlq6ZdJw==
X-Received: from wmwm26.prod.google.com ([2002:a05:600d:635a:b0:46e:774b:d42c])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d18:b0:45f:2869:c3b2 with SMTP id 5b1f17b1804b1-46fa9b1834dmr224393765e9.33.1760547741874;
 Wed, 15 Oct 2025 10:02:21 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:02:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIzT72gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0NT3RzDFN20nNLiDN2U/GRdAyPLNDOTFKMkgxRjJaCegqLUtMwKsHn RsbW1AJwmSTVfAAAA
X-Change-Id: 20251015-l1d-flush-doc-029f64d2b0d3
X-Mailer: b4 0.14.2
Message-ID: <20251015-l1d-flush-doc-v1-0-f8cefea3f2f2@google.com>
Subject: [PATCH 0/2] Documentation: fixups for L1D flushing
From: Brendan Jackman <jackmanb@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Balbir Singh <sblbir@amazon.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="utf-8"

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Brendan Jackman (2):
      Documentation: clarify PR_SPEC_L1D_FLUSH
      Documentation: fix reference to PR_SPEC_L1D_FLUSH

 Documentation/admin-guide/hw-vuln/l1d_flush.rst | 2 +-
 Documentation/userspace-api/spec_ctrl.rst       | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)
---
base-commit: 0292ef418ce08aad597fc0bba65b6dbb841808ba
change-id: 20251015-l1d-flush-doc-029f64d2b0d3

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


