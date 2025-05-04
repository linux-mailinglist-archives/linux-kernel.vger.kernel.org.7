Return-Path: <linux-kernel+bounces-631245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFE1AA859F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 May 2025 11:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD55E176304
	for <lists+linux-kernel@lfdr.de>; Sun,  4 May 2025 09:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681321A5BAA;
	Sun,  4 May 2025 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zAgdVJaY"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E0D1A238D
	for <linux-kernel@vger.kernel.org>; Sun,  4 May 2025 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352391; cv=none; b=LS9s0+dQ6Qbryjei5LvxMLLi6XQWU0ufxAxSIgs0WmaD3aVHV8nTvDpnZ/V4HSE+ie7QdB9QXwdYa2GGjKMIRE42mjBAEfMHNLC92e2oSsUK5Lqk+qabaM5s8o7448nTS/ZoC18ag5eMiYk5LOyjiviOtBEK99rGuwB9R8IK2T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352391; c=relaxed/simple;
	bh=B6sTwDf85H/ZctTlQ1ykGUokg6cZvuiTzJxYdCOSrZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N9BcenBaZq2/jotlS6USv7Pv+ry3kX5kDhZuZb71PxxdtOn9Uwx9lOiAmWneapYpNXMxXxszZ8m+96QTnw8pAuLuFMa7pgmZmzR7LQldrDZQ43RXHsTvpSxj7LvitKwLtEBaQykfZMcZTcz8WdHHM7jtfECqKhMlxLVnzn33RJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zAgdVJaY; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so17998915e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 May 2025 02:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746352388; x=1746957188; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=leD0sWlnnaxAT1Wn0YgrpxxEYNPNg7KvvRTlnX38LAQ=;
        b=zAgdVJaYBsiJ7+jYP+IE7vDRB52TVAAsmyt1n/jrqjD3Z1OdaIx9WOBcjqwunliVaz
         p60bfA+s2H1xwEUV9H9PfgXkJoKKHMK+ojlZKOH8qMwU5csC5HT3s1hqqauBPsvxk5cI
         nUQSWvSduDtiRxcXoIJnWO1iAXGAT4dhcTkcqGcWAWtCYCKR5ArOCDzbvZgW3G1guFXi
         GJW6KHSY1m9/voBZ5Q6UCDF40UzQHX6cs3bEyD10nyMcTwlh/soVlqJHTp4UVG0vKCCr
         NhDvjTo+ppAyEEXGwsJ0Tvc70E1gUMZDn+2KO6PKKzWAhBcRD2FdcEE0CZJyw1S2fW96
         T7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746352388; x=1746957188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=leD0sWlnnaxAT1Wn0YgrpxxEYNPNg7KvvRTlnX38LAQ=;
        b=j+1WLbRmZoz6Ulv0rTGazrkccvKVO2/xZ8qhggufnLOidLZIRBqZ/cnzAiySmAQSdo
         RbHTtYbLBMooJkCYFdCej7QePaz39V2EhScW5p/munKTUCQNVnl9In69iCvQg4PnsneP
         2u80JKTyknTaCeDCDY73UFRiVCCz7neVCItF3WEOn97FmR4TmY6GLvWAHRCy/IxmFGiC
         Cxxgbc+pi0+1ysuGDb/TT+fHcdtcpIrALhk7VXqDQnXz4IIChpMqlrdZMOh9gZcvz5e5
         wSeyy9LdlXGdS3u0fDSa2ZQgbAnIfAmIm4tduRPi9nv9uNnVROZ/BvJ322YqOzImqtNT
         08+g==
X-Gm-Message-State: AOJu0YzqUBK6rFymG2bgs2ISyyIfjGumt+14VWoiftH07VXogYjs5922
	NxICq1UU9BR3DVNrYVOLM4dv7NctltSIOxGo2cSA+oNiu32AOZew1v6I7ZtZ2BoRHzs7IIu0FRl
	17VFJ07z4ewpfDuLQxfdkQKJ5UteClOl0qdDHIMVlbDm9/17BHZyZQDylzO3ivrEcmpAdf4lT8E
	PeS2vhzuTAdH8uE2wGAU79Sj75ahB7og==
X-Google-Smtp-Source: AGHT+IEIOlvldtuHxJz4e50DXzMC/TAHLewwMAK9tSa45s8h2YcmOMMcQXUSx2JQi3bFtMgzVaLzExtP
X-Received: from wmsp15.prod.google.com ([2002:a05:600c:1d8f:b0:43d:56fa:9b95])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8219:b0:43d:79:ae1b
 with SMTP id 5b1f17b1804b1-441c1ce8e34mr45570345e9.14.1746352388517; Sun, 04
 May 2025 02:53:08 -0700 (PDT)
Date: Sun,  4 May 2025 11:52:32 +0200
In-Reply-To: <20250504095230.2932860-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=961; i=ardb@kernel.org;
 h=from:subject; bh=VJ8S2Ug4P5Tq9blQL5XdMARbZUBntSDKvggXQxjCtFA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPc4uGGD/IBp66qpE5yN9Kd315tUz0n/ZYo75vWjUGSM
 zTzHwR0lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIkEtTAy9HkEfkw5q5b5L3j1
 xKdrL0sdD/l23WnzW/XYpzc3sYgaGTP8j728eKopz+rLEbPn18n4ubKXWW6cziMSH3J17Zn6ufO vsgEA
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504095230.2932860-27-ardb+git@google.com>
Subject: [RFT PATCH v2 02/23] x86/boot: Disregard __supported_pte_mask in __startup_64()
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

__supported_pte_mask is statically initialized to U64_MAX and never
assigned until long after the startup code executes that creates the
initial page tables. So applying the mask is unnecessary, and can be
avoided.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/map_kernel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/boot/startup/map_kernel.c b/arch/x86/boot/startup/map_kernel.c
index 0eac3f17dbd3..099ae2559336 100644
--- a/arch/x86/boot/startup/map_kernel.c
+++ b/arch/x86/boot/startup/map_kernel.c
@@ -179,8 +179,6 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 	pud[(i + 1) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
 
 	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
-	/* Filter out unsupported __PAGE_KERNEL_* bits: */
-	pmd_entry &= __supported_pte_mask;
 	pmd_entry += sme_get_me_mask();
 	pmd_entry +=  physaddr;
 
-- 
2.49.0.906.g1f30a19c02-goog


