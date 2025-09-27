Return-Path: <linux-kernel+bounces-834828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E731BA59AE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76DB8188DA98
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 06:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1B327A900;
	Sat, 27 Sep 2025 06:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mtj3ggGh"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1F1258CD7
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758953367; cv=none; b=LrWlg7hAlS+pC+U4vckBP5zVqIb5tr25/2cgy+zIcYFw+7mVbE7lIjDku9Hq41dWIiBTYakq9U0ZIpyVUHUsr5cOoqubUd6eAIhmA+kr4DHhoSWZ9nvGUJm9WBnc2gkuToOxbTwYj3J2dAqZEs53gh4gqvjTggkQRFhlmOp3L7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758953367; c=relaxed/simple;
	bh=Oj8qJ7rV9ehZRogVERfstPITaEHniz2Ln0i/vX4dVho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tXUouf1Ili6MjeLTNMPkD/FUCbSBDHGZxNmG+IbAGj8XAENzd95PYR6pJutExXX46zt3xCRNKF4hCsGJ42vbNQvmXy/a6eK5Qh7nzY3kw2x+ZmgCdPdaNM8piJUplqQsLmKo+5Hh1gtFZlp7nzrnXdfQ6OGbQ5/HAZD9fLdDs/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mtj3ggGh; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-780fdbbdd20so3322966b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758953365; x=1759558165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=PGKeC8CnX61x5pXWQDTzl5eYQK0aDAaf5xtcWK0Yejs=;
        b=mtj3ggGhBy3LCO6zjwfxHeqHGlbr1Kpli+nATyp7Ya2ioa3St3gX/DHMps7YtauR6/
         lY0aFUt2jg68dPntIGARiNKQYDprgv40hJ3yStGDSYgQpCZO7sA98YQP2CPCXiun4ND5
         Yn7BHpyimS0JPnXby8kbfAdCL3mLLYFDH6fPWC+9dExRfGb5BtgnwhLSqq3yPWvbQGuN
         WNDrrFT+V3gnD9hplyFmL4n0mJpfziup8NsdAf+KGFPNX7N321RQp/XB85cgKlrrTyMg
         HuC1jSlAefeIfPshGdqRC6Xd6C+vRtVGCjRkTgrw+dCVRAWOgqVryXIa9iEXqILoCS8c
         +Q8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758953365; x=1759558165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGKeC8CnX61x5pXWQDTzl5eYQK0aDAaf5xtcWK0Yejs=;
        b=hgWSmxuAiqWpK1Rxtf4k4oHv0jghuC0X9pXwXi9fj1ptXBhZ4sydMd5KJQEfsifct1
         S6queZXGNF9Nh7WHGCEJg0+Ihp1A98QrnHW3gwdxVo7P68RIxCcQXMNcPECsm1vNicZ6
         dP7Yq8QXK0yvVhDGILw6ozvT4uYzIsPOOUkJV1BZ6JWGjgPkAUD39Rv80AZsGN/01iY6
         zQKFHbr2uez1qjszOqPAWy68Qoe0QYhO9Jy4n3wYgfgVaLUvOAc0Z08mCpCM+D/pxSfs
         uZmqHENcsvF6ZtPQ8gp2U0dwqo82TrRnsJXgDZx2OpLEWRX/JAlIla2LEA0hd33jtEDd
         Y7aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRM772LL+t8gVGC8OwqklKUMQWqHd6ejJBgr8WisA/CTLk7b+5Qgipfqca1vgSPmlNRiAuuLKLYN06iZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YymIY1HzuDZSXVvvwXplOnMAYuhD/GCM8y+La61TBNtLFKq1p9T
	bMkDlDTRBSdOgUOzCHSSHwsb9Jgzb6aT+ncMmCg6KyrjGnBh7gR4J3ysEtJ91hezreY5HCly7tR
	WOyWCXg==
X-Google-Smtp-Source: AGHT+IFWQPF7mWizOzq2Vx3bLQVksJPtETuTn097fKU4c6kwXyGdc3Ivu6BvG8tVIpcBVR0dbBw4lv7WxqM=
X-Received: from pgdi13.prod.google.com ([2002:a05:6a02:51ed:b0:b54:f631:e3a3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:110:b0:2fd:a3b:933d
 with SMTP id adf61e73a8af0-2fd0a3b9389mr2889844637.58.1758953365098; Fri, 26
 Sep 2025 23:09:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Sep 2025 23:09:07 -0700
In-Reply-To: <20250927060910.2933942-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250927060910.2933942-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250927060910.2933942-8-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: SNP CipherTextHiding for 6.18
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

The tag has all the details of the feature.  Note that this is based directly
on the v6.18-ccp tag from the cryptodev tree.  I included all of the ccp
commits in the shortlog just in case the KVM pull request lands before the
crypto pull request.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-ciphertext-6.18

for you to fetch changes up to 6c7c620585c6537dd5dcc75f972b875caf00f773:

  KVM: SEV: Add SEV-SNP CipherTextHiding support (2025-09-15 10:14:11 -0700)

----------------------------------------------------------------
KVM SEV-SNP CipherText Hiding support for 6.18

Add support for SEV-SNP's CipherText Hiding, an opt-in feature that prevents
unauthorized CPU accesses from reading the ciphertext of SNP guest private
memory, e.g. to attempt an offline attack.  Instead of ciphertext, the CPU
will always read back all FFs when CipherText Hiding is enabled.

Add new module parameter to the KVM module to enable CipherText Hiding and
control the number of ASIDs that can be used for VMs with CipherText Hiding,
which is in effect the number of SNP VMs.  When CipherText Hiding is enabled,
the hared SEV-ES/SEV-SNP ASID space is split into separate ranges for SEV-ES
and SEV-SNP guests, i.e. ASIDs that can be used for CipherText Hiding cannot
be used to run SEV-ES guests.

----------------------------------------------------------------
Ashish Kalra (7):
      crypto: ccp - New bit-field definitions for SNP_PLATFORM_STATUS command
      crypto: ccp - Cache SEV platform status and platform state
      crypto: ccp - Add support for SNP_FEATURE_INFO command
      crypto: ccp - Introduce new API interface to indicate SEV-SNP Ciphertext hiding feature
      crypto: ccp - Add support to enable CipherTextHiding on SNP_INIT_EX
      KVM: SEV: Introduce new min,max sev_es and sev_snp asid variables
      KVM: SEV: Add SEV-SNP CipherTextHiding support

 Documentation/admin-guide/kernel-parameters.txt |  21 ++++
 arch/x86/kvm/svm/sev.c                          |  68 +++++++++++--
 drivers/crypto/ccp/sev-dev.c                    | 127 +++++++++++++++++++++---
 drivers/crypto/ccp/sev-dev.h                    |   6 +-
 include/linux/psp-sev.h                         |  44 +++++++-
 include/uapi/linux/psp-sev.h                    |  10 +-
 6 files changed, 249 insertions(+), 27 deletions(-)

