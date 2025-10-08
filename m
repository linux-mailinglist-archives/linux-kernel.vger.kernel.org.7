Return-Path: <linux-kernel+bounces-845682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E840BC5DD3
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F4B34FB076
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178562BE02D;
	Wed,  8 Oct 2025 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MkUEtHk4"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF9825B31D
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938409; cv=none; b=hBxuQSnQygSv4mLp3tPHXOKex5pEu9kySnu+T6fzJoMKTpH0HxFW8FIZy/hsGVU8I0wH3NORsZ34epNk1PjmQZEHOGiN4gLYBGzccCN1VnLV2pg92dHykxu0FsAJ8TruQBSNE1pFaUduaooG/IubRfiHs8CeFvhDGGB3sfdMOG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938409; c=relaxed/simple;
	bh=12RXdlH8WUVCzzyh4vIFws4ja8Gr26ZMeYscmOm7oNE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jJfTPxOS6ebASY/YBQFzkHy9i7Z/ExkbdgeTKylLez0l/RZYptTdq5AzN7hECfgm7tn2g9WCCEE5UT6CS0Y0f9WZJE9zse0+WhGfsEf9tsPDfN9pqWco5Ebk4yVXQyl/2MejDvK1cdourqDUi0tFws9OdI9pXJyeFVtBFKQwbDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MkUEtHk4; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e3af78819so35192775e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759938406; x=1760543206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0AhbZPensuqKG/yW0Qj7LE8IaoQDaRVlqpZyE8QDARA=;
        b=MkUEtHk4snIs5lRXjuc0RGebRrxYuNBdxlqNzkB5nZ/9E+9mGNa75OK+/LDVlerJyh
         0CvnrK97nno0ptq7K2lk9McykRedmKZzhJDexco23c8L/xnDd0E/N2oNlVKqM+E4Vocp
         OFBeHsaRiwTE24y6gNMYzM78KmrsWTPcjgslga+cy4nVKvaeWtXVMNY/99/T+JPgitXS
         LJM/8qzIHQm2IPA6KFlSi1NIjQziIot/G7O1Vm7pFWa7ey/nn+LWh8gF3y42skE5msUk
         kXvJgcHg6zzKIaehoNaoMUvyjI41EJRfDtuZFKxp9LpjHz5XxapMq6j0/jk9wsskEDGs
         Hf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938406; x=1760543206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0AhbZPensuqKG/yW0Qj7LE8IaoQDaRVlqpZyE8QDARA=;
        b=pk7Ly/A4jn4q+vDsHOuXZTa+w+z6pf/xLwzVgAJMRpMIYcB+K7YF04k8L3sqidmfr5
         h9eELU2+fmCchlxX4X6tG9I0XVYQCcTzo0x8Wi3vFYGhYcjwsZqMFcrRwNXh2WthLwEU
         dudaVoAsstLBeHFzO6GYrpjKPSXb9ex18tIThT/7OJuj3XPOGgM12HK5oAvGev6f62m5
         vHUHE6LrVNiHWrkvievAcP212di8nH/96Z3bBe9cLVbLyzCn3hHQLpsZDmqRvNFuAGyA
         UZAHw01CVi9oeHL+J6/FrDZ3n8kf7Igg+TTx1sqgWIRS1MomMBYovSsLS2Pfd3PjY79L
         AuMg==
X-Gm-Message-State: AOJu0YzMpowqs6x0f6MKTCM6x44GriGH9o24vvVC8Noogghrj+CDy5Qr
	EvzsjecIHR3xPkIMX4A488FCJFVYrl1MCJyImQCoMZx4wpKRf5I2cUGS7PCSUBBe4WAgF/E8lQ=
	=
X-Google-Smtp-Source: AGHT+IFGiSWygFLP8i64IlU/Ujr5WlDyO+2EV/4Cl8eQXXpZQ1evYrz2O0ebGMwfs5ylyK1bfixkdj8Z
X-Received: from wmbgx7.prod.google.com ([2002:a05:600c:8587:b0:46f:aa50:d70a])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4f08:b0:46e:3dcb:35b0
 with SMTP id 5b1f17b1804b1-46fa9a94553mr27472645e9.2.1759938405883; Wed, 08
 Oct 2025 08:46:45 -0700 (PDT)
Date: Wed,  8 Oct 2025 17:45:35 +0200
In-Reply-To: <20251008154533.3089255-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251008154533.3089255-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=926; i=ardb@kernel.org;
 h=from:subject; bh=dFhPhM339lpxbecIP5ywrFTMp3sezPQKRMrRY5eAeY4=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeNZu1Lfp9XzPjod2dxh3FPPsqyyScbs3OtNeYcfX7Y+w
 Fm+oNm2o5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzE6QEjwxpeIaV+vccGIcs9
 Dyc+unbs7fSJWqcyfXV2LPXdKGaT9ZmRYVXe3vsMtX7S1jcOe/o0fpbfGaJcmHeg7Mq7F+7nFwd d5gEA
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251008154533.3089255-24-ardb+git@google.com>
Subject: [PATCH v3 01/21] crypto/arm64: aes-ce-ccm - Avoid pointless yield of
 the NEON unit
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Kernel mode NEON sections are now preemptible on arm64, and so there is
no need to yield it explicitly in order to prevent scheduling latency
spikes.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/aes-ce-ccm-glue.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/crypto/aes-ce-ccm-glue.c b/arch/arm64/crypto/aes-ce-ccm-glue.c
index 2d791d51891b..2eb4e76cabc3 100644
--- a/arch/arm64/crypto/aes-ce-ccm-glue.c
+++ b/arch/arm64/crypto/aes-ce-ccm-glue.c
@@ -114,11 +114,8 @@ static u32 ce_aes_ccm_auth_data(u8 mac[], u8 const in[], u32 abytes,
 			in += adv;
 			abytes -= adv;
 
-			if (unlikely(rem)) {
-				kernel_neon_end();
-				kernel_neon_begin();
+			if (unlikely(rem))
 				macp = 0;
-			}
 		} else {
 			u32 l = min(AES_BLOCK_SIZE - macp, abytes);
 
-- 
2.51.0.710.ga91ca5db03-goog


