Return-Path: <linux-kernel+bounces-857026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D50EBE5AD5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 08A7F35155D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5221C2E0408;
	Thu, 16 Oct 2025 22:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sz2ZNN+u"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4842F242D95
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760653700; cv=none; b=hXq4/asKSnTx72hoHf2enP4VJRID31vhgC2pNGf85+h6ZzMCBYfa/5wUj91w5FuUsntELyixe4tHKUrzgqMLILmPyxmMXkSGLbvA2IhWCuir89TYj2ZYVCHR7hMrUVbH8fUmj86v0lfIppz5nPH7xNsqvQxcJaA7ii+tsQ6TPPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760653700; c=relaxed/simple;
	bh=bawSMseT0CqNbdyIWWkFAuACxkZoXEqOQliCkUUeOWE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rEojR1BRZ1X4Q5HUSPgZl6n4V0O9JxdNM+LUUvkTs9te298zLM3PSDhZBr5CG8k0nQs5SxjRffRpfsifJZOAXjt/Yh80ST8v8w9HY8nXH4oYMh4SqZv2jDa7aqtCMtq5/DouhVvljq9Q10glok2IOcbbfw8AZwksMu0TfCqQY2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sz2ZNN+u; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bbbb41a84so1994696a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760653698; x=1761258498; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohe5whqaVI6MNw62Ja9bMHiL/FYf6oWYICNGFV1EN3Y=;
        b=sz2ZNN+ueNY884xvq5mFUbzfwyCcaK2dBMqNdvBlfNxzgkf/Z6sN9Z9wawRIwGxa5R
         BTfV40YRLgMFRQFhtOA29q/xxqMzUCn3/Y2YP94emUI/5M/Q5ddfVheOFFstzn7BhPWJ
         E5wXQOIX4n9o7M4oVMn6WXRxvUEybyhb6a7XGxody6dvCDui1HTGL0obMnFUH7Cz0sv8
         Rne/s/swHuabJZmez+SfJpjPhxjUh+aXtd0Ac6ZhKJqAG2r2wQ0IsUi9Xu9ZHCb83oLG
         mCb3z2eE/CVAgzGlfw7kVbhQGRgr6/+2VQcVkuwCdttm7EaJT9DRFo22QBIIvO9NaNY7
         niCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760653698; x=1761258498;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohe5whqaVI6MNw62Ja9bMHiL/FYf6oWYICNGFV1EN3Y=;
        b=vZbSX5cT3KTb/L37FBvvD/kZSF/Vnb96rdQd1AHZStYcokmVlrLLRq08W37ZiXsIta
         PVS2OMvtAHnnOhkodnWDSDsXaJf+0qiwsZZRBEGQBLPPGUG3Rs88FFPKDzA3JPpMyERp
         Ohb0p6mhp1nmgl4Og3NZUtoYF/a1KuLNK4bWvjgn1qJFDwitNvFH9miJso3sz4Jqi368
         ro7IeSe9HhNzlbxELZNEEymE7yapDRV1Edbw8+kWf4fT8vPrFn9QBkfWpoOYfK+C8930
         rJfPFtbeFwnhW98BoMaTSdGGTNDeKbT7x3aMieaDrFMsdRTZ1z1MI2OJDWPZk+Ct7br+
         S49w==
X-Forwarded-Encrypted: i=1; AJvYcCWepIl3c1yk3+BNS2/P51TCWFQAJplEsTh5PQiYd32TjAHHH6C+kqApsPMUBjVz7NNuKy+/bcnYPy8JtiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgT6mjfIwOGUNxiLZKrgToTG+M+1tHbGc0iZ6muLxMZ7eGoQiJ
	yBnk8mF9cTs8DPfkfL7icyMdodftIhohBrRI3LUa/xqZdGiegJ2wuOfevndBeRnfE7Fhmi8ECso
	zuF7dzQ==
X-Google-Smtp-Source: AGHT+IHEsNMvTZlam2jisTHrsVJg/i/9Fu9TLaM2OcVaUKqK6KMKAv8tlmP6fh1nAXeNkUWB5CqnY8FjWds=
X-Received: from pjsc4.prod.google.com ([2002:a17:90a:bf04:b0:33b:9fa3:a535])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244b:b0:334:7bce:8391
 with SMTP id adf61e73a8af0-334a86500d6mr1818085637.56.1760653698581; Thu, 16
 Oct 2025 15:28:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Oct 2025 15:28:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016222816.141523-1-seanjc@google.com>
Subject: [PATCH v4 0/4] KVM: x86: User-return MSR cleanups
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Kirill A. Shutemov" <kas@kernel.org>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yan Zhao <yan.y.zhao@intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

This is a combo of Hou's series to clean up the "IRQs disabled" mess(es), and
my one-off patch to drop "cache" from a few names that escalated.  I tagged it
v4 since Hou's last posting was v3, and this is much closer to Hou's series
than anything else.

v4:
 - Tweak changelog regarding the "cache" rename to try and better capture
   the details of how .curr is used. [Yan]
 - Synchronize the cache immediately after TD-Exit to minimize the window
   where the cache is stale (even with the reboot change, it's still nice to
   minimize the window). [Yan]
 - Leave the user-return notifier registered on reboot/shutdown so that the
   common code doesn't have to be paranoid about being interrupted.

v3: https://lore.kernel.org/all/15fa59ba7f6f849082fb36735e784071539d5ad2.1758002303.git.houwenlong.hwl@antgroup.com

v1 (cache): https://lore.kernel.org/all/20250919214259.1584273-1-seanjc@google.com

Hou Wenlong (1):
  KVM: x86: Don't disable IRQs when unregistering user-return notifier

Sean Christopherson (3):
  KVM: TDX: Synchronize user-return MSRs immediately after VP.ENTER
  KVM: x86: Leave user-return notifier registered on reboot/shutdown
  KVM: x86: Drop "cache" from user return MSR setter that skips WRMSR

 arch/x86/include/asm/kvm_host.h |  4 +--
 arch/x86/kvm/vmx/tdx.c          | 28 ++++++++++-------
 arch/x86/kvm/vmx/tdx.h          |  2 +-
 arch/x86/kvm/x86.c              | 56 +++++++++++++++++++--------------
 4 files changed, 53 insertions(+), 37 deletions(-)


base-commit: f222788458c8a7753d43befef2769cd282dc008e
-- 
2.51.0.858.gf9c4a03a3a-goog


