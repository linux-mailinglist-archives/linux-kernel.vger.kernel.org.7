Return-Path: <linux-kernel+bounces-758887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BA6B1D520
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D277262CA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD9627815D;
	Thu,  7 Aug 2025 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVVuUJo5"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4B227781E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754559921; cv=none; b=G1Qa87F+yu2CRbUnYL0zxxMTgiOS6wmXoW4lszzbzI8aKg9aidCfy66Ft9z/5TT8APILmbXTpMAeYZMZVgXbjlr8AOivjPlAgDwMr/WAkx/gyXwtKu3RXsrQhvRBKtdiK4SsxSiAedulisERxmLOwYvihXHpdvG6kZRhohQoeec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754559921; c=relaxed/simple;
	bh=9CWqCoQd69akCMvnUCstVkxnK5EnbjHX63MZgi2hMIk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OM6nZ9aWozpUUNYriEsUXoTpwq3hr/JQb6iEL4pLBlTtp+mabLk8VOmjgThODH8bmwacLQqihHseqZCx/P9E4kqZjbRkrCvALxZ43vIwE816JjXzD4xeTtorO4ELZc8AbLWrYoXxd0wvaTvvYubtLRaYR2FKYhGIxuD3MEWFDug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVVuUJo5; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31eb41391f3so919861a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 02:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754559917; x=1755164717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HqQFCr0puXBzxV1mM1+sQ3d9n1yvLLDEaN09Eux/FlI=;
        b=FVVuUJo5MVhgnf8wUYdsLSm9Zyq/ItWPTtbnnoc8GnP96kr3/ddACuMxeDKb/aIMeW
         jGBpLuHqlr0Ca3lDFxGVrKugrg94Zt8K2SetT/fYiVdmMEeqXg98vaDabY13tfqVAfsz
         RkosijVk+NjfAfIpYv5spQwzb6AVdBYJCQU63oIMpQH/nLAYrugqEMMbQMvlarF57Jzw
         QoS5WpClz+EzuqCVgxFCiLHTEbpBXYhlulhTPbSKsMpErIbDgKVF2Lp4IjxM7+A0LKEC
         mn33mIzYKnxqAr90VwCe25VYrAS2WFWdAhE3qNoMYrxL9kZtfhySJ04w2cb1AYvRGNvu
         /HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754559917; x=1755164717;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HqQFCr0puXBzxV1mM1+sQ3d9n1yvLLDEaN09Eux/FlI=;
        b=Dgefkinp7PKzEfAy5SASI+67TLBmwU7xYxm61O/KsDXHBcmr24IVMaRWYaTeTYk90a
         3N7sMucmDuBPW6kErTHEkkyeZwsCMaI13Ck77V+0X0gFi7EkWTD8jgPuAGg/MU1dyIl5
         Fx0jE4vzChHv6tXP1N2Yf2amDia3D/dIST7Xr99PoQHSIDtZkg6eaupkywM4WETk9NYJ
         6Ec5RhPaB/mDNVL6xT0cNY7jUZLZJtDmHnyhaBzvsYTwb5GZlgIbifaNtjED3HEULiIA
         a3pcPK6Ti+FSg0UeZnyh35duHQouWUaubf5ogPHcLZ9mZdTlZGc3FoIXAgOwKp0rsuF6
         WTgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSMquQGeJzP1nTSrCF/J8/NLw0deYur0wyTbWxB4lELtb8vXf68IaXl8Sb6MRVc7fDPFeTXO9mvMARBH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM1xoP6wng0zlxCBrupZKCgy5mDvtqicYqtChgm317pTrj4CW1
	yK5SRCG+NELbl0LnuNR5C2NKGy4RegA1NdgYANbqyh+iLVm3r5lMDjxN0x0eHHnDQAdWXoHr2hK
	enw==
X-Google-Smtp-Source: AGHT+IGgGH634jFvBjcMTqZUObCM6RH+x7mywZlvBZG1zN7YFs+cGifnMo7s9AOHUwNXLTWPVeH0PKoJEw==
X-Received: from pjoa7.prod.google.com ([2002:a17:90a:8c07:b0:31c:4a51:8b75])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1347:b0:321:729a:a421
 with SMTP id 98e67ed59e1d1-321729aa623mr3699563a91.32.1754559916863; Thu, 07
 Aug 2025 02:45:16 -0700 (PDT)
Date: Thu,  7 Aug 2025 17:45:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250807094511.1711013-1-wakel@google.com>
Subject: [PATCH] selftests/net: Ensure assert() triggers in psock_tpacket.c
From: Wake Liu <wakel@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	wakel@google.com
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
index 0dd909e325d9..a54f2eb754ce 100644
--- a/tools/testing/selftests/net/psock_tpacket.c
+++ b/tools/testing/selftests/net/psock_tpacket.c
@@ -38,6 +38,7 @@
 #include <arpa/inet.h>
 #include <stdint.h>
 #include <string.h>
+#undef NDEBUG
 #include <assert.h>
 #include <net/if.h>
 #include <inttypes.h>
-- 
2.50.1.703.g449372360f-goog


