Return-Path: <linux-kernel+bounces-660024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1039AC1818
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 01:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BA54A0124
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 23:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D02F271A70;
	Thu, 22 May 2025 23:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SkXKFSYA"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AE12494F9
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 23:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747957065; cv=none; b=o7COW25DnuH0EDdSebNNgZMDlRo2UlodQ0/lUZuS1SMQXY6FMUEEUT6EqMrPPwZ1EInQ6dlz4ZeecJQ2xx0h1ozW1RMpBay+LgyGDdOeC9TRAG1rTevU+5DnFjn03BI1/VCifZe43cafhctDdZIrwSh8dvqruivDNnJ5NEJ6mUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747957065; c=relaxed/simple;
	bh=7HznakEWAX3QxiOzowEE528i6qDkLEzzGNrvSoNsN9c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F/2rPVTXRLKi0XWnUqWz0R3nXfpYPaq47siOEqqf6fMfKxJr6EUsBqJogGHGAnzUfb3guWwAm/JHtn/42XzSJh0d9YaQwEjluPl6Vgoe9LwrRFrNzu4aWggos99JhQTbzzeaI5ORTL+Y12gwl33tovkx1mbwZEzq8/RupwfY7Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SkXKFSYA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30ebf91d150so6962338a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 16:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747957063; x=1748561863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uPxUrn14vuCfCMnKXPuJKpCi+RnH/dlPI+aSAjTgJIQ=;
        b=SkXKFSYApdsPjWpIPz5B9XNLdQ+eWKcQiy0NvTTO3iNZqGZGZopPabFBd65HjlaWYB
         LOUSA3Uy0CijsNzYm9CcHH10rWoaK4Ge9UckmZndNmFjBBC39AU27wXZq0pdKrssiBuO
         MRWCydZQFtPJVR5CHBsIwGdOBRVAo5ZOezsoTed+IKQ3oEjBfzIi0iHgCjrC4mS3jdXn
         eFlJmq+UsK/oxPEMiQh9C6TQds++hzaLO3vYiDw4JZ7EpPlYFjen2Ohre3l2CGsUO0Pd
         B/0l+RIg+qaqijPZ79zzJ0EO8uAcirnw4CoLiN1Ms120Uo627BKikUL0tT4c4/fkth76
         E1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747957064; x=1748561864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPxUrn14vuCfCMnKXPuJKpCi+RnH/dlPI+aSAjTgJIQ=;
        b=B66IwaScjcvbEvSzriLFgJIgZC2mK2RSUDku4CFVXw4pzNdvQf+ZU2yhT/t4GHI28v
         dvbVVXlmhz65f34RKwxbN9uavlF3RC3zWU2DmpCkW3j6sVxvf39uLpw2xBqH/RJXaSJr
         7HlKxSB1YiQFgOvQjkpsSYLlXFXUvPbPz5ipNAr8F58JWbX2xfSCFOn7TRLKbRFzj36t
         Ufb2i12Q+rUoI0RJzUrTWMHetWeISNW5oVMFo2ngnxzqrdI1CJxidI0aB/50DrIveCSL
         Kdj8POfwxgO4vETA0rFDe3rHGB792DjXByNk7mdXwvodmRJmk0tZqDd8bN7t3chwbCm1
         cXMg==
X-Gm-Message-State: AOJu0YxDrbRbf9dvTgqX5z8no7W08ajLBtXXT85gzfzUGnCqbFpi22Gv
	XtSmG7rIHIov0ndB36hIYD1zwqEqqu58fvGagnbFnFb32vpIuDkBsbRo7m1Pz8D4bJrPRcHp2+T
	4Xg6PIw==
X-Google-Smtp-Source: AGHT+IGI69KyPY1At0pbvO9taKFOli2nLHw8tUa/zK4co4eocqDHMTFbGsbKlwZf9ojX+OImaEWTLGTboac=
X-Received: from pjbsw15.prod.google.com ([2002:a17:90b:2c8f:b0:301:4260:4d23])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2c8c:b0:2fe:8c22:48b0
 with SMTP id 98e67ed59e1d1-30e7d555a3bmr38071711a91.15.1747957063457; Thu, 22
 May 2025 16:37:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 16:37:25 -0700
In-Reply-To: <20250522233733.3176144-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522233733.3176144-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522233733.3176144-2-seanjc@google.com>
Subject: [PATCH v3 1/8] drm/gpu: Remove dead checks on wbinvd_on_all_cpus()'s
 return value
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Kai Huang <kai.huang@intel.com>, 
	Ingo Molnar <mingo@kernel.org>, Zheyun Shen <szy0127@sjtu.edu.cn>, 
	Mingwei Zhang <mizhang@google.com>, Francesco Lavra <francescolavra.fl@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Remove the checks and associated pr_err() on wbinvd_on_all_cpus() failure,
as the helper has unconditionally returned 0/success since commit
caa759323c73 ("smp: Remove smp_call_function() and on_each_cpu() return
values").

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/gpu/drm/drm_cache.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
index 7051c9c909c2..ea1d2d5d2c66 100644
--- a/drivers/gpu/drm/drm_cache.c
+++ b/drivers/gpu/drm/drm_cache.c
@@ -93,8 +93,7 @@ drm_clflush_pages(struct page *pages[], unsigned long num_pages)
 		return;
 	}
 
-	if (wbinvd_on_all_cpus())
-		pr_err("Timed out waiting for cache flush\n");
+	wbinvd_on_all_cpus();
 
 #elif defined(__powerpc__)
 	unsigned long i;
@@ -139,8 +138,7 @@ drm_clflush_sg(struct sg_table *st)
 		return;
 	}
 
-	if (wbinvd_on_all_cpus())
-		pr_err("Timed out waiting for cache flush\n");
+	wbinvd_on_all_cpus();
 #else
 	WARN_ONCE(1, "Architecture has no drm_cache.c support\n");
 #endif
@@ -172,8 +170,7 @@ drm_clflush_virt_range(void *addr, unsigned long length)
 		return;
 	}
 
-	if (wbinvd_on_all_cpus())
-		pr_err("Timed out waiting for cache flush\n");
+	wbinvd_on_all_cpus();
 #else
 	WARN_ONCE(1, "Architecture has no drm_cache.c support\n");
 #endif
-- 
2.49.0.1151.ga128411c76-goog


