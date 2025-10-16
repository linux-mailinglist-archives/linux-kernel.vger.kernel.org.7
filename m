Return-Path: <linux-kernel+bounces-856818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07178BE52B6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593991AA0D04
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AD8239E63;
	Thu, 16 Oct 2025 19:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p14gw84/"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93FC1E5215
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641608; cv=none; b=rhuuY6ky1P4p4L4djKKKSYPxB57O75ms4vMrv+jt7zizvRyCnW/KRf89nfR4MSC6zija7lfX9Ki0SvtCbR3KQuVOoHYl6xR6FGO7/DfZs3Nn/Qz66W8Llb9nu3e1GtBLAxRDtF8kdQ+heHnMLu82tWCi49FA+B1MqFqz4MDxsus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641608; c=relaxed/simple;
	bh=fHLCYT161lb+n1QIPDAmMQL9QlVrhfJ5AaY0+ax/iK8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HwODNf/y4bVg3b7l5jwKrSxcNYT952ooBa3JH/DypfT0MzIApmrHbuBoqMD1HNPRHYs57Ne71fDS51Ofh/splOyJXFVDP8sO9rPTQZbb2CW3fFDVeWSZ1vxoPwd8zyFMxjEoEKuH4o4s5nU1ZEq9xeT1Zwy0gJj/rApRwNXlXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p14gw84/; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b55283ff3fcso787316a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760641606; x=1761246406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIOb/2A/2ytYzJ0QwNwSePEDACaGWltHmU20VSHfFcI=;
        b=p14gw84/AUTFecag4h9Xe+nQBlKKMUv4RhUlLSogaPsXcjgB8nRmqO4bDZ/VzKquDh
         lXGfsCxChLi0n9xz2UThlZrrT8uRv4oVHnFetXlTRy76dyV2IYAIqnJgz0WSMu+xxhv8
         uW3pmSGdD7QZ0pPknj9MFC9ubHdMYrfkXlxD/XueRXY4VomapqAk9DMF3j4m0yrwZeyU
         fB7kbKwEQ9nyfkt3IiMrHUALToJ2lPoU6SZfxIdhH0IEK5bmargsyXeVxJyZiHYBKx72
         JzS+f1yPUIPEAatQ/BThqpHYvsKi6uXjNJqT6yeFVvdKUTsPjsr2M2dLcAnjqKRyXSDQ
         mr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760641606; x=1761246406;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIOb/2A/2ytYzJ0QwNwSePEDACaGWltHmU20VSHfFcI=;
        b=XfxzbbrF8Q42+H7GKBoLs5rzViw0dawnvliGArF8zZ6BWg8r/KRltn4mDdVTokPR5A
         7csc6PuolK9PphtkMEL12hWxAiC6QwxEK3PELBpF3qFg7vcfiXM2hdGnUQbZe94B54ZF
         hYQlHs5CQKvH5ujVHxmc2CHqaVdoX8OkZdZH6hPU9qHphcekIdd47G0VAZ4TYmaATAKq
         bq2hMEY/eIOseN7WVL/1e9j1JZfkrGK5Hm46HTub0phRMIOV/83kW6q4hKM/0tChywDk
         QidOq6BwjOt0fwiEuKlKk/IxByeG4BoAOe6gwTn/qa4E5v3B9vT5V66MvNUgjY+eZ6Yj
         iyRg==
X-Forwarded-Encrypted: i=1; AJvYcCVW+NAkTwMnWIP4ujpWUyygL68LwtWYlWvR1W7tLVi7pnGkkJT3yk5iS/dO29q/FFouLHblQAasuEsjimk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH5H1yPsJFIl1uS1ogpGoZ3uTmB5daYMRtSrU5z9+8hYtzrS4a
	5sCt9EI+DPdbc/JZg1XhYRTKYphprQjLr9i4dQHurD+F6FNse/fNUMlam35Y8hx1c8olyi7xoBe
	tYoVYqA==
X-Google-Smtp-Source: AGHT+IG1fKP9GeKfZIf01S3NDQzTVcZoj6VlwLqo9WIAlfYNBF7WNVM9ajyc3SPTpy17QR7Cj18QLLW2Q54=
X-Received: from pjwx4.prod.google.com ([2002:a17:90a:c2c4:b0:33b:ab7c:3147])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5281:b0:330:a301:35f4
 with SMTP id 98e67ed59e1d1-33bcf8e95dbmr1079104a91.20.1760641606031; Thu, 16
 Oct 2025 12:06:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Oct 2025 12:06:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016190643.80529-1-seanjc@google.com>
Subject: [PATCH 0/3] KVM: SVM: Unregister GALog notifier on module exit
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

Unregister KVM's GALog notifier when kvm-amd.ko is being unloaded so that
a spurious GALog event, e.g. due to some other bug, doesn't escalate to a
use-after-free.

I deliberately didn't tag this for stable@, as shuffling the setup code
around could easily introduce more problems than it solves, e.g. the patch
might apply cleanly to an older kernel, but blow up at runtime due to the
ordering being wrong.

My thought/plan is to get the fix into 6.18, where avic is first enabled by
default, but not bother getting it into older LTS kernels.

Sean Christopherson (3):
  KVM: SVM: Initialize per-CPU svm_data at the end of hardware setup
  KVM: SVM: Unregister KVM's GALog notifier on kvm-amd.ko exit
  KVM: SVM: Make avic_ga_log_notifier() local to avic.c

 arch/x86/kvm/svm/avic.c |  8 +++++++-
 arch/x86/kvm/svm/svm.c  | 15 +++++++++------
 arch/x86/kvm/svm/svm.h  |  2 +-
 3 files changed, 17 insertions(+), 8 deletions(-)


base-commit: 6b36119b94d0b2bb8cea9d512017efafd461d6ac
-- 
2.51.0.858.gf9c4a03a3a-goog


