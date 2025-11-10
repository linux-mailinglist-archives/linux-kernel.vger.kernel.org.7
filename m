Return-Path: <linux-kernel+bounces-893519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AEDC47B06
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E563AD4FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E482FC011;
	Mon, 10 Nov 2025 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PDzqMueP"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9333B224AE8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789109; cv=none; b=cyF7qeM5eLWUfa8Lm7Q+HLRTrB12onjGhCMnCwI6isnDkPW/OMNxXiukQZ9KBjEZyWGy8myQ2Og4c5LxUgqQ4rSQBv7bDeYEgul9tknzHHm4PHi6vlzwNr1ioK6CbNa4xFjd1Hcsv9mbOx+s2cFP7PYC+RqHmzDOy527LY69NFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789109; c=relaxed/simple;
	bh=MH9e2jUGvIq5Ft7KriMkDd6ks0WjI/g+33oaK7F7aYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nCiWLesSj6F0NItasVJkkD7MqG4Ial81Q1k0JkzXh/56OzVl6K3wCRAnD5HFHzFUnQGsX+mtpiHWhbo9TZqr553Mj1vBCHAkV5Ix3VvtpmeH0ftacRC89oJ+DL/DYruMt6HRFqyRhysZ0KAk92bnY9Hu4jt+zY3Yc4r/t06cirU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PDzqMueP; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b99dc8f439bso6385843a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762789107; x=1763393907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BoKPfyuNiGqxtvxZUAx5vRDQ3EuycZdCnNRhVlKwewU=;
        b=PDzqMuePd+MbGhUpzQo5sRzP8cF8KRsNKzJU/6wkdavoASLr0tWbP4C+RBUazVw1zR
         mkQNA8vhOgmd7izpCE321BgvhdSw1Ce1qc+lqBLz0kAc+m33TEhYuQTdlV6WN9AHTbCI
         TpZpbYTQn6ceBRwQA22ReLELGQN2XeqHCf4qjAaMf2f5+Cu8EVi8Rbmsb6WebljMEGK0
         wsO2LW+rnieJTfmG1l2VIVEiPfv8wJYHqPGpGvizCUcBh+EyeDK48tyHytLVAUtzcVWe
         S1qJ6xxnyRyiidVEI/lwllpe327WKVe3AQLQBTWf4S/grcZiLe5+nmf2KdTdx+caBsct
         iJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762789107; x=1763393907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BoKPfyuNiGqxtvxZUAx5vRDQ3EuycZdCnNRhVlKwewU=;
        b=FBzk+pUn2Jrf/Z7iI6bGHUrF/4vXasCHmFsIXZftrrxU6IJeKQpIMTeJ7RRrrRvMNP
         Pfv8sz2oi6p3j3tilxtBp+2N26vGxFLH0wjwgaafPrFjoYYpg1hjhmolMVMMSTCoozqm
         hhoy/amMfhgxfOhKFdeSE2BMPZb78EuwCQwKuN8atGoQEcdFDya4lqm3PmSLUfrV1H1f
         57aLoj2WAzakkxmOvQ21Y0pl00l7QnfMSqXiZp4BY35m5xg7TcRGSOp6NcYTPReTLM8j
         YkQuKkxYQ3xljk0AOyKA4C+648QI8kOR1uMoK/XNBTwEf/6Po3I5kIQcHAV+IH8GN2Dp
         hByQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC89oPzbvPr4QrsJaAHtoWE+iw7NfOYKET0c0UveNvI2WgyEyz5Ql1GS197Oexl27MMBg0P/EFF7TRfcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY8MEVkiwfw7jMXHProbzs+g8c4i20BzX2jJGwi7Oua7ltevCf
	TP5jb2o55P/3NBvA0yBBhy1lvCGg0p3idzgkKYhCyXbcOQt7yOv9qeJHDAMHEOTYUsbXlXmI00o
	FoGCgjw==
X-Google-Smtp-Source: AGHT+IFuNMyIOyWiCmXwIQtmnVOqvD0FU82ow8XbLbiFGi5sUkdbby7hl7o1fcYbsf1vVDa9Ipl3YToxTwI=
X-Received: from pjov2.prod.google.com ([2002:a17:90a:9602:b0:340:a575:55db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d48:b0:32d:d5f1:fe7f
 with SMTP id 98e67ed59e1d1-3436cb29c92mr9068601a91.15.1762789106936; Mon, 10
 Nov 2025 07:38:26 -0800 (PST)
Date: Mon, 10 Nov 2025 07:37:15 -0800
In-Reply-To: <20251106052853.3071088-1-Sukrit.Bhatnagar@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106052853.3071088-1-Sukrit.Bhatnagar@sony.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <176278793531.916768.7425548531906697015.b4-ty@google.com>
Subject: Re: [PATCH] KVM: VMX: Fix check for valid GVA on an EPT violation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Yuan Yao <yuan.yao@intel.com>, 
	Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 06 Nov 2025 14:28:51 +0900, Sukrit Bhatnagar wrote:
> On an EPT violation, bit 7 of the exit qualification is set if the
> guest linear-address is valid. The derived page fault error code
> should not be checked for this bit.

Applied to kvm-x86 fixes (and it's in now in kvm/master as this "thank you" is
coming a bit late).  Thanks!

[1/1] KVM: VMX: Fix check for valid GVA on an EPT violation
      https://github.com/kvm-x86/linux/commit/d0164c161923

--
https://github.com/kvm-x86/linux/tree/next

