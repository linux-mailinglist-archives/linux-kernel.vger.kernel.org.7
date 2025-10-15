Return-Path: <linux-kernel+bounces-854943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E88FBDFCC8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 566874E3F8B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF7533CE9C;
	Wed, 15 Oct 2025 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IuaKdqJf"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DD0334397
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547747; cv=none; b=oM0e4cDxx8f1WpeoRdE5V2q/YrrI4CBzO7OfRIHdxIpXu84UB49MJN+l5BsT93BZhtLRSnMUGXUtoEWY0v9rJoEn8E9sJ6EW8+ujLh9MAY1a+mXD6JMupmJOyhxxfYmfl/n5HSBjThiyKUyod4oGm/WIqdooRSloKJdar80uZjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547747; c=relaxed/simple;
	bh=1jed6GmDT1FsL0aWAQrTOmSmNfkR/x9qXkLi2gdyspE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KdDZKFjNFlQFhLGNw4+1Lajrar6rv53m/k7JO+rdNQdJX7eNqotwSGPZ4xYXNq11fa/TW6N4Zmnd3ry2nRlfUI2FMpqKPBls4SPAzZ4Y0YKCbHmCya8Vsa3BlBFIDCNnf1SoZtUEpJFZ+85c+h8R1OQZ7dZuT+vEQF+sHhOAg9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IuaKdqJf; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e41c32209so41481615e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760547744; x=1761152544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MFa5MsvOEgP3p/Hez6gTFGugruhQ98Q36uD5Tr4UKtc=;
        b=IuaKdqJfvvwjIqtkpNjIUSKpuPGx4QJ9ERpU+mojB0TGlrCD7y43s5Qqjod0AEHnJr
         kQbxj1jTW5bGJStKkMIZLOOlQAxjMi4QCteYt8Rm6AfT8w6iMdWXQv51oLOc3naXhetU
         hcQvdhimQmgDautnYr24mdoHxcSNtjQLtZbYfbGdOLhIjbXlpguQ7tYKuXG+xuoVX9x7
         l4TsZLDQW96G/Ef0ERhjoN6VolYTrbwaQf6ntnwhIZsWbo9NZlx3uX3ipTPR/ouAQ0t7
         M9vVR4MF6tvDcqqAsKc0bIOrkmida+qaEnpHTKuPM0eUjax2D6r/iIU8DfvMYdQzC8Je
         atbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760547744; x=1761152544;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MFa5MsvOEgP3p/Hez6gTFGugruhQ98Q36uD5Tr4UKtc=;
        b=o1g6a8T2uy8EjjcTqsgvejDENlNKAnG9eJHZywbKfGxxxlRZ3umCLubJOqCc2d63cv
         R+T9IAPKduZkUNfLyjOMKdLMhXhAoEY2+k5QWoijcqreJHp7GrhZMsrfux0f9GGhiYD6
         vLrcHYANmFZDsit39za6m7xdxxcMdNWoazZEKgFUyIvZyZYG+JMpbX5bR1m95cIQmQL0
         IJmdpaSIGMwVTVM2HZZ6EPcYslJrookt5DqYXCzA9AJl59TO5a3gwiqz06vM5IrFYPlT
         ziYYU3sOHo1YoWX4OsOMdZsmxtEIekM1FqTNerCzdwAzt+s0f/ZnSzzj3PvcvNm91uQa
         gQGA==
X-Forwarded-Encrypted: i=1; AJvYcCUHitVZ//CcogdOsR+jXducgDHDxpSSgnGHvi3/YZVVCdcOczzOGkjCAzm5GobI4LWaNGneIPcUznZT9SI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+YIKFeJLfzzWBzgVVpVUA9edlMzap9rNRDl//ZA3lqhzZJG6G
	J4xykv/Houno1bdaKZaQkYvXEwkTospkeIY5oxvn+VDZlIgYqbuyGxKE+CdaTfogC+e8IuWiod1
	XXcHrDodEulCWyA==
X-Google-Smtp-Source: AGHT+IFvxc3sGG1SeHoxohU8Q35w8zbZLd6mM8Sf9fcI92y8FVCNPWrspXmbbM6LPsQib/+IzMUzo5jzGr5ojw==
X-Received: from wmoo1.prod.google.com ([2002:a05:600d:101:b0:45d:e2f3:c626])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:699b:b0:46e:410f:f645 with SMTP id 5b1f17b1804b1-46fa9af8fa5mr219134815e9.21.1760547743670;
 Wed, 15 Oct 2025 10:02:23 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:02:05 +0000
In-Reply-To: <20251015-l1d-flush-doc-v1-0-f8cefea3f2f2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-l1d-flush-doc-v1-0-f8cefea3f2f2@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251015-l1d-flush-doc-v1-1-f8cefea3f2f2@google.com>
Subject: [PATCH 1/2] Documentation: clarify PR_SPEC_L1D_FLUSH
From: Brendan Jackman <jackmanb@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Balbir Singh <sblbir@amazon.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="utf-8"

For PR_SPEC_STORE_BYPASS and PR_SPEC_INDIRECT_BRANCH, PR_SPEC_DISABLE
means "disable the speculation bug" i.e. "enable the mitigation".

For PR_SPEC_L1D_FLUSH, PR_SPEC_DISABLE means "disable the mitigation".
This is not obvious, so document it.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 Documentation/userspace-api/spec_ctrl.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/spec_ctrl.rst b/Documentation/userspace-api/spec_ctrl.rst
index 5e8ed9eef9aa84f12fa255af7b15c163ff01aab8..ca89151fc0a8e7205e0a0062134d63b213b9ef11 100644
--- a/Documentation/userspace-api/spec_ctrl.rst
+++ b/Documentation/userspace-api/spec_ctrl.rst
@@ -26,7 +26,8 @@ PR_GET_SPECULATION_CTRL
 
 PR_GET_SPECULATION_CTRL returns the state of the speculation misfeature
 which is selected with arg2 of prctl(2). The return value uses bits 0-3 with
-the following meaning:
+the following meaning (with the caveat that PR_SPEC_L1D_FLUSH has less obvious
+semantics, see documentation for that specific control below):
 
 ==== ====================== ==================================================
 Bit  Define                 Description
@@ -110,6 +111,9 @@ Speculation misfeature controls
 - PR_SPEC_L1D_FLUSH: Flush L1D Cache on context switch out of the task
                         (works only when tasks run on non SMT cores)
 
+For this control, PR_SPEC_ENABLE means that the **mitigation** is enabled (L1D
+is flushed), PR_SPEC_DISABLE means it is disabled.
+
   Invocations:
    * prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH, 0, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH, PR_SPEC_ENABLE, 0, 0);

-- 
2.50.1


