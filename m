Return-Path: <linux-kernel+bounces-893520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CE8C47B75
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862063A498F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323E13148AD;
	Mon, 10 Nov 2025 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zL6ZXU+1"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4F22264BA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789119; cv=none; b=U1ArGih/pddR0jJXlYQuprKLxZSAZjNypHEO+f+KGu7CBrzNWmAXMGV0v4x0XCVVCbd0PynUt9hn9opeI9WL7JsHEIGpU1ElvoA7kcj29e4lBhduttNaB91G0yetEiCXJ6x9u9YXLRQxj1DpnLywP/dVk9OAPnUrfUSQ7nodKyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789119; c=relaxed/simple;
	bh=wWF6uOjqUv6W+Plh3B4k3LA4DNAjjEGlwhf3dBu6NtY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f93q5E3W1hC8R/3qYAT+9ZpDFTBhX9ix8oHkKW7HGHvD8SLIGAVcbkbobdUn3y5B5b+ILhgdy/8Lm0FtxTR/JtYl/pckUmfLqvMDXRhORl942xRULEiedsnwTvHPUXRh+w4JVHCAK6sFS53s55FGa8of069fqRkxw1tqoDVh9f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zL6ZXU+1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3437f0760daso4221334a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762789117; x=1763393917; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yfPsA9R0m1PbgxrFpo4vz1rRRYntzKHoCzeS0KAV2Qg=;
        b=zL6ZXU+1kZvN2/nDjtTNLLS/91EPST7S/A/BgiUDrMIHamYQI5Pi3/yxTF9ze5j3XV
         Lk29HOsx3HFkpQSIAaKhV+85TL2Qy/ybstwq/o6BEylxuYKkj4yjTfZVbuX4qAJ+LFjl
         19fuZ54Fij6hnmDvSl2BxViA2p3s2BjTq3I5MdT4YH0FEg3mGBZ5h0TUHV0v6Lo3Iezr
         Z7shCvBLrR+CC2KUdK7IHW777D6AqmWtMTr2LEHhYVGyF6Lggn0wIj1yX09SqSS1AdX6
         /0eRZVtCxm0rCYXTe0VI7B6H9Rn4jcusJhZcJur01i9yPOT/2XNVFu2aUs+OsuNKMbWj
         H+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762789117; x=1763393917;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfPsA9R0m1PbgxrFpo4vz1rRRYntzKHoCzeS0KAV2Qg=;
        b=GrEkXGZkRRcNFkkHQe+5wWHgQ1GZfUc/taZn+CWgAfG77Kwg0rlQYv5GgfMimItzi9
         jz9LuAYr+YprXKRIQnEQ2xdUHW0w5tV6rP0ISj3V8yELZWpB+KrdOCMxGTTva+38gaLj
         IsFhqlsqw7cVfNovCnL/n+CqYElFbBhAku4T8BYOdMaUpueHv/ViDL8rrLBrlT5GQ31O
         mFIQxFaYlJWXnYKqK+cbM6UBYc7mFnNl60obsJrREKcEBfmJ0Jh88+SPuIPsOP2e9Ibl
         s7fxHMQIKqOV2va7ACj+SMXbg6iXyy7gBooxyc0RmC9gr9UU/n4zBAnpoEe516qghC9Q
         7vCA==
X-Forwarded-Encrypted: i=1; AJvYcCXOyFPzGAAgEWrB9hM6LkXSn8+1vps/Jkw/nIjEy7RdUx4hPxZ1DKHY6+B5LkatK+hTDc+i6vlvjNRh/8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEPHtZR7mNRqz5dKm1K3Mgb+IEgCZ4GaqINflv8vjvfVorAYq6
	DbHtv0htGrNbyBdoOQQboBiUapHi7ePhp1OIzFEeZ6zySL03W0bYOecbA7iEpEtOSkyX7sSeb0V
	y1rNMog==
X-Google-Smtp-Source: AGHT+IGK1wZ3/zucTg6yFltfJmAFT0YJdOBTxemOkKdCIS/Efg08CIE0m38N8M4xq0bxiDvgMiQUD2dCHdc=
X-Received: from pjbgv9.prod.google.com ([2002:a17:90b:11c9:b0:340:c625:b238])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3811:b0:340:29ce:f7fa
 with SMTP id 98e67ed59e1d1-3436cb7ae1emr12134871a91.7.1762789117528; Mon, 10
 Nov 2025 07:38:37 -0800 (PST)
Date: Mon, 10 Nov 2025 07:37:17 -0800
In-Reply-To: <20251015033258.50974-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015033258.50974-1-mlevitsk@redhat.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <176278796977.917257.9553898354103958134.b4-ty@google.com>
Subject: Re: [PATCH v2 0/3] Fix a lost async pagefault notification when the
 guest is using SMM
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 14 Oct 2025 23:32:55 -0400, Maxim Levitsky wrote:
> Recently we debugged a customer case in which the guest VM was showing
> tasks permanently stuck in the kvm_async_pf_task_wait_schedule.
> 
> This was traced to the incorrect flushing of the async pagefault queue,
> which was done during the real mode entry by the kvm_post_set_cr0.
> 
> This code, the kvm_clear_async_pf_completion_queue does wait for all #APF
> tasks to complete but then it proceeds to wipe the 'done' queue without
> notifying the guest.
> 
> [...]

Applied 2 and 3 to kvm-x86 misc.  The async #PF delivery path is also used by
the host-only version of async #PF (where KVM puts the vCPU into HLT instead of
letting the kernel schedule() in I/O), and so it's entirely expected that KVM
will dequeue completed async #PFs when the PV version is disabled.

https://lore.kernel.org/all/aQ5BiLBWGKcMe-mM@google.com

[1/3] KVM: x86: Warn if KVM tries to deliver an #APF completion when APF is not enabled
      [DROP]
[2/3] KVM: x86: Fix a semi theoretical bug in kvm_arch_async_page_present_queued
      https://github.com/kvm-x86/linux/commit/68c35f89d016
[3/3] KVM: x86: Fix the interaction between SMM and the asynchronous pagefault
      https://github.com/kvm-x86/linux/commit/ab4e41eb9fab

--
https://github.com/kvm-x86/linux/tree/next

