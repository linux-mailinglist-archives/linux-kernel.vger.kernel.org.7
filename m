Return-Path: <linux-kernel+bounces-831110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB01BB9B8F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547C81768A5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB013168F6;
	Wed, 24 Sep 2025 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="htg/smbd"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2ED2264BA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739535; cv=none; b=KoSs3tGf/cQYDtyK5ZXhA1ZPoqDowzToKcS8rF1T3YMik3gT+/kd6eq0LzIxFbuyltuU6Bs+IsMQiagovp1rb/+9+82mJnThPBMeitKl6tb0bqR5YYv6eEgqC3ITvu6fRAx1IAqr0Tvk4gpsUue+mcZp/TqCVxwN9dPMS329wyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739535; c=relaxed/simple;
	bh=vrPS3FrZXCObU9xbj2Kr1lt01FSI3RQMF3JUALQpUqI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TxNdHl1R2YsJ40ufMHGZAMMh1I7tk9jwMvaCmuls99f5HGDjYQZZedcqg1tAg8Q8OF3Twhfw36rw6d99YNgaYFs4eXEA6Fii3rGdfffFA6jzeC1UbwlVIX59f3XDLUTMBj7EiXnARVcXcjVxS0xrU7d0/+yxKMqE6UkAS14ifc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=htg/smbd; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5509ed1854so82240a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758739533; x=1759344333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hB5Y4r4rf1lehr6FQtEOmozlH00Twktr9vU7PqamHQU=;
        b=htg/smbdWD9z611RaEZrKg44EJNy6NpeaIB/P1lDiWORJ/EkHofZtKjQyLd5kAkUwR
         lxpwvnC7r+cpnmrcn/4TbztCCKRf82xNoHE365PCuFnSl1aDZy2d9ZM+ET/wZnlI1Xb2
         nxdtdA2rKUi4O1+a4mTPxh4ugxt7uSGe3Hh9KfaWjg8YdvkkU1ZG63Gm6XRQQDgzek1b
         WGk/H3W/5UyUt3f/xV4DJJpeTNVoLsulsqJu63dnSUIEQqPDWkRXPZIbiO45Ck7tOwkz
         K058tuk+XnxREd9xOHjLkrrm3Mzicj49fRk7E+76n6rnh7cvSrquNfMyOhPHFS8rGo94
         u1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758739533; x=1759344333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hB5Y4r4rf1lehr6FQtEOmozlH00Twktr9vU7PqamHQU=;
        b=D2Kq7cOjghZp6SaWg98Tq+1KKOOKpSnEXEmL1Rx9givtAXEl8t4RYNFBR1kvmjjOZK
         K07qk9iN1Lbk7YRCf2tWHjwBt9eAoDjCJrbe6aysUUYh6IQd2m+FPQreXVZ3cEBNWCVR
         KS7QssuAP9o9WRDivvVJL51c4zFZbx53QlC56ehJpOvPBGmSHhd49vSxzeTnpdXiok2x
         vySBTawRiBSnsLmeaWRxC8euld2LgaV5bPerjFl2cW9LkNZ5+0tbNwNzvDo3Ymkctqg/
         2Qiqp39dQlTmqQrZm64ovy4CUWlALPrI89RsTF6JNuBj/JzkdW30rH4hiqDeUw6g+wPl
         IhCw==
X-Forwarded-Encrypted: i=1; AJvYcCVx5DlvLWGnKXE8j8iOGl6pTxgv6UNpV/iscxnxMawBS75KX91Py0oT/qureuoN2uA/iQV8Fl5E4vIp4+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3vHFGP1FqLikF7khDmTbOlNjgodfOEDaDcpWmmesQAYete8EZ
	VJvLmqGf4QrxoTAQ6ub5EIrTO1G0tZzhsl3voXcrbkAcl6oXxSP8MxSw8Yb2eYD7wQyUOQQQLRI
	DnCgw5g==
X-Google-Smtp-Source: AGHT+IEh0mqwW4Zok+OWIvmwE7+RJDlDgyy+51Q9hwEsOLuS9L6xhBhguqHptFn2ySqV6wYcmNX8Bvzg728=
X-Received: from pjyf4.prod.google.com ([2002:a17:90a:ec84:b0:32e:aa46:d9ab])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7c1:b0:32e:7340:a7f7
 with SMTP id 98e67ed59e1d1-3342a272c3cmr621593a91.2.1758739533283; Wed, 24
 Sep 2025 11:45:33 -0700 (PDT)
Date: Wed, 24 Sep 2025 11:07:45 -0700
In-Reply-To: <20250919215934.1590410-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919215934.1590410-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <175873642529.2146862.15667445717361040728.b4-ty@google.com>
Subject: Re: [PATCH v4 0/7] KVM: SVM: Enable AVIC for Zen4+ (if x2AVIC)
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Fri, 19 Sep 2025 14:59:27 -0700, Sean Christopherson wrote:
> Enable AVIC by default for Zen4+, so long as x2AVIC is supported (which should
> be the case if AVIC is supported).
> 
> v4:
>  - Collect tags. [Naveen]
>  - Add missing "(AMD)" for Naveen's attribution. [Naveen]
>  - Make svm_x86_ops globally visible, to match TDX, instead of passing in
>    the struct as parameter to avic_hardware_setup(). [Naveen]
>  - s/avic_want_avic_enabled/avic_want_enabled. [Naveen]
>  - Print "AVIC enabled" in avic_harware_setup() so that it's close to the
>    "x2AVIC enabled" message. [Naveen]
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/7] KVM: SVM: Make svm_x86_ops globally visible, clean up on-HyperV usage
      https://github.com/kvm-x86/linux/commit/44bfe1f0490d
[2/7] KVM: SVM: Move x2AVIC MSR interception helper to avic.c
      https://github.com/kvm-x86/linux/commit/eb44ea6a7aac
[3/7] KVM: SVM: Update "APICv in x2APIC without x2AVIC" in avic.c, not svm.c
      https://github.com/kvm-x86/linux/commit/a9095e4fc436
[4/7] KVM: SVM: Always print "AVIC enabled" separately, even when force enabled
      https://github.com/kvm-x86/linux/commit/ce4253e21fa8
[5/7] KVM: SVM: Don't advise the user to do force_avic=y (when x2AVIC is detected)
      https://github.com/kvm-x86/linux/commit/ad65dca2ca4c
[6/7] KVM: SVM: Move global "avic" variable to avic.c
      https://github.com/kvm-x86/linux/commit/b14665353162
[7/7] KVM: SVM: Enable AVIC by default for Zen4+ if x2AVIC is support
      https://github.com/kvm-x86/linux/commit/ca2967de5a5b

--
https://github.com/kvm-x86/linux/tree/next

