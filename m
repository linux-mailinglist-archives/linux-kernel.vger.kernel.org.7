Return-Path: <linux-kernel+bounces-893522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 911CFC47AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 970F64F66C9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A909631D759;
	Mon, 10 Nov 2025 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zFqZdDec"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EFD2264BA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789133; cv=none; b=QMh9My0TEx6nq+PzRfWIMiTBnFJvbpDCrZW1QWT0OR1YWEvvW0Kt4XoRuY5o1qJpVC3G6Ly6ZplvCW6QaVh1hvfJDOiJzg9QsPD6NvOQa2iiMERBRFi9C1EKYiojY+wVxmmNqeWpZ0g8lGJ/9CDywjOo9rhEQRnHvjJJ3Gr2CHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789133; c=relaxed/simple;
	bh=WYo31m3heuJFHd2AleHIkwCwmVtacFIEhcJ51fkn2mU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ilzvos5wtdbHJ0TSVqzybjFs8dUtJcWv0nhiNPaAl1bS7WlwUCyw2ZyPgpmimxobAvUh3wQYQGAAv998y6nDNG8+KcBEaNhhRB359pHoYuES3xoW0LzFuPx2BWSgkgRibJ7PGWFfFN2sHncy6qaDtHJfB9QR8Kaodmiuq08nRKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zFqZdDec; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-340d3b1baafso5686559a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762789131; x=1763393931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UMGtDSMhLp7PwCftwD5VWBt9/H+12AqeZNXDWEVNOss=;
        b=zFqZdDecMTfURgE0Vc0HAdqEaPBE+hLLdocxPPkL4Tdd4jXBRtbgrSHe5Int4jVkF5
         9OwWASgiq97ASKGQQ33ovNmbcm1YjQ3EFTsV90h1xlix7+33Ez/LTVHjqyD2AWvnJOkw
         ox5K5Fw53ds0P95rkuQvMBs4u9p49N2MPJ5B0cLNT0vIu5CRj51jnuO1ZowDcSQxZVVz
         rQscTLkEffgZxv/vN3N5X4Te1cTQfnMpeF9LsezHIPbdqD3s4O/4zIiddo1oAD9b12qb
         K/tq0tE0n6XFWsLop2tOxi2dcH3YOfeoC1c+hlxtSgIMrEio/AJhb5aMNJDboaEWDdze
         W1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762789131; x=1763393931;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMGtDSMhLp7PwCftwD5VWBt9/H+12AqeZNXDWEVNOss=;
        b=BMKaQN6z/ugoTNAfO8Zey5SIu1QtHsq7p6mmaCQ5UJudpVkKlfz6Fz6SQLmJTSMZnu
         RBdQEOVMeJnDsCFbW14Bf9uC2Y8P5vvspCeLhKnk/lDJF9btdIjqmzinK8zXrzCvMMdC
         k3NS52TtVZ2Rnna06SUhjn0Oov4sNyi/3bIQwMayxa6WEuvggos517dUdgr/zdjqqZ7+
         1JgJJ+Ucxl3CEVf6q/uL62MoWXhrHfs9uJTG9SoQ59cD86z67JG2SMmHcm66x0SKZHLu
         hWgmG62eJFOIZLMMm53SeJjs4a/CObWiB8ZZwvWlO9rcZ/cajh4JeI1wOs87pJGAUsvz
         ObZA==
X-Forwarded-Encrypted: i=1; AJvYcCVXkFwNZ3YNkz/jZW2XRbxhnRQWyWz6I+pKicyMaZ3v4/JpggAhGN8kMLspHdXcP4XgZGq0PCwICMIhZiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsXqGlENKvL/QeI/ehsd4tagomciNKnCX6sr2vwGouwH+ZdzEG
	hdMSVTXDBNql0KrAz+gTjVAkDv9ei8wwQNtrTara8ilFsscMJHC4aESCiYGKAAioshLRx1CQQUo
	HPj4e5A==
X-Google-Smtp-Source: AGHT+IEp9sm7tBdgsbr2NYRbGOtKx/P5/qWT3g321cSR22hpudavx53XGYsuVNRtFk/NTp4RaBYyBOym9jY=
X-Received: from pjon19.prod.google.com ([2002:a17:90a:9293:b0:341:8b2e:afe9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dd1:b0:340:f009:ca89
 with SMTP id 98e67ed59e1d1-3436ccf1f55mr11306347a91.22.1762789130950; Mon, 10
 Nov 2025 07:38:50 -0800 (PST)
Date: Mon, 10 Nov 2025 07:37:19 -0800
In-Reply-To: <20251030224246.3456492-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030224246.3456492-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <176254658743.821204.2042588290407024138.b4-ty@google.com>
Subject: Re: [PATCH 0/4] KVM: x86: Cleanup #MC and XCR0/XSS/PKRU handling
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jon Kohler <jon@nutanix.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 30 Oct 2025 15:42:42 -0700, Sean Christopherson wrote:
> This series is the result of the recent PUCK discussion[*] on optimizing the
> XCR0/XSS loads that are currently done on every VM-Enter and VM-Exit.  My
> initial thought that swapping XCR0/XSS outside of the fastpath was spot on;
> turns out the only reason they're swapped in the fastpath is because of a
> hack-a-fix that papered over an egregious #MC handling bug where the kernel #MC
> handler would call schedule() from an atomic context.  The resulting #GP due to
> trying to swap FPU state with a guest XCR0/XSS was "fixed" by loading the host
> values before handling #MCs from the guest.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/4] KVM: SVM: Handle #MCs in guest outside of fastpath
      https://github.com/kvm-x86/linux/commit/6e640bb5caab
[2/4] KVM: VMX: Handle #MCs on VM-Enter/TD-Enter outside of the fastpath
      https://github.com/kvm-x86/linux/commit/8934c592bcbf
[3/4] KVM: x86: Load guest/host XCR0 and XSS outside of the fastpath run loop
      https://github.com/kvm-x86/linux/commit/3377a9233d30
[4/4] KVM: x86: Load guest/host PKRU outside of the fastpath run loop
      https://github.com/kvm-x86/linux/commit/7df3021b622f

--
https://github.com/kvm-x86/linux/tree/next

