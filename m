Return-Path: <linux-kernel+bounces-897704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BABAC53A02
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F463583B62
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591BF344032;
	Wed, 12 Nov 2025 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WnHC4DSp"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3713F34321D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963635; cv=none; b=b5446jrydqqe5Gi5EKEAd9h0lrWzlHUubaOukPzH5o210cXGaP0r38nqcbPvnf38Cj+c/1aorcnNgRU1FebmckPWz1MIL3Zrc7ynbUHs2vpJFDDbuX4vgfKVTPQQi4wJLJ8gBYzsNa42PEHXe0FvTR+XHazYMipTkWeWZ789S8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963635; c=relaxed/simple;
	bh=FWETxRtMVjkLK+WfqnbYriRIlbE+xBHWvnDlkLiYk1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c07q3ex0cNl16133rx9+DJ9M794nowSrTpH9s0W8x5dMkRVOsEzhZQbEgNoZbfg+us7q3IQ92kSjptZ6nHeCqBoZAAMrQWRVpZbdlg3KvDmUygazpz7x03b/r50xtVBvyxEnnoyHRY/Ny+Gtf9aiwPtK3eyf1stOSmHQxSZl2/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WnHC4DSp; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3416dc5752aso2543931a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762963632; x=1763568432; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=eTjoKHmggOYgTdGIQs6uKfwAZuQVBnxqpwF3nx2QCb8=;
        b=WnHC4DSpUfKJhsrRGPaaQ+CzvM+A6EP8PztrnUZmOFMoK6rBZDY/JJlvVrF8CRWoyf
         HirmaA2stDhrnK+fUM8O2l+izCeZFQDGo2Bol48Q60CVVt9J8Oiy6S/DuoFSM5JTk7FP
         2yNUbwTWbYg96JlI+HFWqE153YaSmSVqfUI9dTdhEpaq5JKV5I/8VXalYqIZpoLVxtO0
         KTJL4VQ2EC4i7kj/uKserRpZ1L/idhNNqARjT4GNFD5uFZ7XJ+ZaO/ZG7o1cG/rxaLlu
         cn1SM0QGrbmvhEfVOyOgr8Xq00u0Dmwp77Pvxg6iD4XjK9gRGYVAYeKBzZZj/Ju+ZAIV
         zQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762963632; x=1763568432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eTjoKHmggOYgTdGIQs6uKfwAZuQVBnxqpwF3nx2QCb8=;
        b=XNksNfvd2kX3Yv++gFrcsNL78Ug3HN8qNnjkjJf7t/oa5vAfELFVuBuxmnsTr8j6ie
         egoiIsiAGdQU8Ga9v8/1spT9JqjSndP3cBbOI0My/Nsnkiz5XoFBb8S5XC75dFPuxkvB
         a7nkrJHM7MSnnuSnI5/PEyoKTi9n+4J98zrkM1RcU9ijfZ+7DMiiHyFQkTNjn5kqNzKb
         GDexPq4a8yp/UXlECvzqzQDZnA/JDM2BcIxnfZrePvtS3Wa+LQjTBYHsQleZIKTwml3K
         7aoa0DUGnHZSPz/YVEKNc46xLplWE1jVQf7tHcpMp3fls99/76Ax/IbMRktdW9B7brgG
         qywg==
X-Forwarded-Encrypted: i=1; AJvYcCVDbTUtq5dM/Ji1ZGOpfPZYy4u1M5HbPDSs5mitL3QHS4MWhzsYacAxrQDvRkhysIs1l14Be71E+0IlPPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcr5iUX3yKZrHo4MKTJZqdKpjDtwEeNGwGFCkfh3rfZkc/6J0K
	Ew5xtb7JfthXMVL34FhcyDLHJ+xXCBmdgj2RC92VfG9irdodMQedEUnTow4S3cZpVQDc/W+dyzt
	0ZvHUjw==
X-Google-Smtp-Source: AGHT+IHJZKkEiToM4fKaG/NQNsxc49aGGeWBuNh03TBSSQJQx8lPhD3KWW6Av/PBLEC9yzKJDa1KrmBSRaU=
X-Received: from pjboj14.prod.google.com ([2002:a17:90b:4d8e:b0:33b:c211:1fa9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:bc9:b0:343:e082:b327
 with SMTP id 98e67ed59e1d1-343e082b6ffmr2584900a91.31.1762963632513; Wed, 12
 Nov 2025 08:07:12 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 12 Nov 2025 08:07:04 -0800
In-Reply-To: <20251112160708.1343355-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112160708.1343355-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112160708.1343355-2-seanjc@google.com>
Subject: [PATCH 1/5] x86/sgx: Add a missing colon in kernel-doc markup for
 "struct sgx_enclave_run"
From: Sean Christopherson <seanjc@google.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a missing ':' for the description of sgx_enclave_run.reserved so that
documentation for the member is correctly generated:

  WARNING: arch/x86/include/uapi/asm/sgx.h:184 struct member 'reserved' not
  described in 'sgx_enclave_run'

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20251106145506.145fc620@canb.auug.org.au
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/uapi/asm/sgx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index 2dd35bbdc822..a438ea43bfd1 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -166,7 +166,7 @@ typedef int (*sgx_enclave_user_handler_t)(long rdi, long rsi, long rdx,
  * @exception_addr:		The address that triggered the exception
  * @user_handler:		User provided callback run on exception
  * @user_data:			Data passed to the user handler
- * @reserved			Reserved for future extensions
+ * @reserved:			Reserved for future extensions
  *
  * If @user_handler is provided, the handler will be invoked on all return paths
  * of the normal flow.  The user handler may transfer control, e.g. via a
-- 
2.51.2.1041.gc1ab5b90ca-goog


