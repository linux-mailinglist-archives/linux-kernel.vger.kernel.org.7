Return-Path: <linux-kernel+bounces-760977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9343EB1F289
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 08:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A290A565E05
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 06:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B831F4E57;
	Sat,  9 Aug 2025 06:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k8UC3STb"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C991EDA0B
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754720422; cv=none; b=N6iK4V/kEVI9yf3klrMbpd1T55G3TH9E4lN17Dwk+OOwSJm9f3xypicmq8dPhSzqYPKu0Pa5s0fe2kPL6PjqRu/xXepLa2jxSOy3syQQMjZ6DF1T9YcGxRya88oEHNvhb5GXER7admVvwce8fnXgwRnniGxl/7bVSetIPIfLKLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754720422; c=relaxed/simple;
	bh=Vsi4bvt3i+4MCaiXSH90HhxJh3VZvI/UVulnMlqMVIY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MtRGfupi3lvRZHE12jKnV/ChXbCpr6nn0+3s0TzbcKWwQT3W1v/Gxm0cWe09rKlDemBLv24DzGDmwMFq6jy9KDQl/lqJsCfqaDfJiebWM2bedWbGeVclntJuCK7BA3f/1FjRBf4RIYFEvFWpzZ7h6uEiATLmV4VJmEoaTAblpR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k8UC3STb; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bb73b63d2so3039734b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 23:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754720419; x=1755325219; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QZ+FYSIf313DQiqdHJ8DSGaBKM3x0ZwAaKOEdduY9g8=;
        b=k8UC3STb/zwvhpkFm5jYbO+Tv0pV57gkxGT1VMVuY5/muQ9E8z1ibvzTp8N7f3OeTC
         6CnXsSEJehPHiLEbtwqepqJ89ECxL8wiu/Pyuar89N/Xa17d5pde2gH3k2Hbqja15E72
         qNx44vbECxy7SDcQt89qFN/NJql1NfdWRiDgfY0P9FVcTho8oggd0hNAtYZvPV9qMeYM
         Nm7TNWb7/HwwLLU6JyAIVKR3ftSWHsbw5G2L1K6NL3jSJHn8psBCCTjoW98uPzYeclDw
         l5GO3aj4c7Xee63UI3Tv0/vk7XCXy+WtjGZdqYKjd+yvHS3nhMmmLJH7dbUH6EYb8QO8
         uqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754720419; x=1755325219;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QZ+FYSIf313DQiqdHJ8DSGaBKM3x0ZwAaKOEdduY9g8=;
        b=jA5lgSY6y/vmoIhvJ0TlhLep451MgRlkcgIhwfABwbGMxS2rJybkdTJ404Jr2egGF7
         kid0lonMnvxnqCpslLi7c5r4fecVKBP+VGVHac5UsC1bCUTEqBt4elTdEBLe0wh0a2PU
         6AbQqid/SCJGwG2a+bIMESeux+dQuKZc2/nk1Hbu4yXulFIsi7WXR0UIkqXofdlEQHzw
         J/rNkhiGR67vWzYDAdZTC2RyMNJmM2iHIO74GVLaQtxeNfNxgar4/C8vAEWbqBjs3S6C
         mfbcSNHfvjc4WOFgOm9SmMegJQZSYlE3kX5DVJf1IFCFbY2htAsr/GTH1CK9p8DPkKeH
         g/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaFNd0KGM3qXTqB3pIHaW3Wm8GYupbZunAvUipZrfyh5irfqICvrdQZSx/oEU5QM9RyGRRzCmpyPrX0PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHwjqq/arP5Y0zagVWphtot4ND/s+ymhpct0Pa2CiRtVWyas8R
	z14pHmGNkOk+ZieBNJg50WiZ5TN4Jl/dWPX2HKZe2kKx59g99jSjxThdoMG7yDJwgKZvlOr44D/
	umw==
X-Google-Smtp-Source: AGHT+IFp9mOjKmTbOVKDY9cjbMKEgm8xFNc/WIg9McOlmcwo7mRCu5csxBYCyKRXT/VavkWSZ41LJUaxiw==
X-Received: from pgx12.prod.google.com ([2002:a63:174c:0:b0:b43:f9b:89d2])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a124:b0:230:3710:9aa9
 with SMTP id adf61e73a8af0-2405500e326mr9508565637.4.1754720418731; Fri, 08
 Aug 2025 23:20:18 -0700 (PDT)
Date: Sat,  9 Aug 2025 14:20:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250809062013.2407822-1-wakel@google.com>
Subject: [PATCH v2] selftests/net: Ensure assert() triggers in psock_tpacket.c
From: Wake Liu <wakel@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="UTF-8"

The get_next_frame() function in psock_tpacket.c was missing a return
statement in its default switch case, leading to a compiler warning.

This was caused by a `bug_on(1)` call, which is defined as an
`assert()`, being compiled out because NDEBUG is defined during the
build.

Instead of adding a `return NULL;` which would silently hide the error
and could lead to crashes later, this change restores the original
author's intent. By adding `#undef NDEBUG` before including <assert.h>,
we ensure the assertion is active and will cause the test to abort if
this unreachable code is ever executed.

Signed-off-by: Wake Liu <wakel@google.com>
---
 tools/testing/selftests/net/psock_tpacket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/psock_tpacket.c b/tools/testing/selftests/net/psock_tpacket.c
index 0dd909e325d9..2938045c5cf9 100644
--- a/tools/testing/selftests/net/psock_tpacket.c
+++ b/tools/testing/selftests/net/psock_tpacket.c
@@ -22,6 +22,7 @@
  *   - TPACKET_V3: RX_RING
  */
 
+#undef NDEBUG
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/types.h>
-- 
2.50.1.703.g449372360f-goog


