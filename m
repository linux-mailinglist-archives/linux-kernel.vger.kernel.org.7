Return-Path: <linux-kernel+bounces-845039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE522BC3568
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 983DA3A7549
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD2E2BE7CC;
	Wed,  8 Oct 2025 04:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TnaffeSL"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C11F194A44
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759898740; cv=none; b=WxSLCpcLL0jmv/3wGQT6FvA15oH+Ow5PttTca185r051qZMbD4RLF67cQbQxEV6LvF7JTYYJvm3UfUKp3FVV9lO7p93rha9iB3w4AtzxV4mveDaqw2ZaW612h8vO+BrLV1azLPeReXmq5GWmWxeM83jvtrs/NnHRogF16mXnzJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759898740; c=relaxed/simple;
	bh=wE/kdATIEfdP1bT5DFvn1f+TOEuk6V4ywi7jxxibmN0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hnCJgTQzxPqesgqyAN1TSWLO47s8ShWiT9WD6jRMc67IAN+BCx/AIovhzrfjx+N3IKBgi8oN/yd2WIK4w+abyU/x58rQG3mvk7thM0wpGqBxuehSnwltOpvjXkJycZhb3vTdNyg5C1rDcYOtP4Z4y0L0grlpeI1MyiEAtqpPsTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TnaffeSL; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-781010ff051so4943493b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 21:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759898738; x=1760503538; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5kr1L00wvOVr25j3yOIqLleOM/mW0MLWBZeaiqgZ8Wk=;
        b=TnaffeSL0lm+9MMBv4ErPvZ8StuIMT0Kbv/+8PCrPX64MBPjAOJntXUkKQg86sBT2F
         q3GAfUxTqQGpxR0Ii1CZtUAKqEdAnqC5ebIxUZDPouq9rEQQOdpmUPogXU7qLET+bsYP
         J/a4wYfIh7zY15imAJN8V0FLvsV6b72G1odjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759898738; x=1760503538;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5kr1L00wvOVr25j3yOIqLleOM/mW0MLWBZeaiqgZ8Wk=;
        b=N3J8fJVBU8h11zmjBlz4MAqukVr2sQrT+Ut5j5f12QZIsOFmNRP99pbp4c/ZPdtMH/
         7iaHKHWQpylIqT/o4eLHeLTlrsvij3kdqsRDmkxsqqf0U4kmq3Q+UDk6EDXkQBeyvGUX
         DG1B3j6AF8o2XBLzlcc4TPrS2g7VvMZrBKm7Y9MfHughfmA3zId4x4TxCTrSXuJ5to0D
         2RmZDcHa/7ZgrSGYWsMb9YgyH4arkIVgQ30evc1juEMSBQRVhbA6Vx/68v+M//MIVAZg
         EhbnlAB2SMVa0CWTsRU+hmKmwgQ0PR43ahs/TbrGyHEz0s7GdwMGfs8B8Z8BiGewitjM
         Qj7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSFu2lYnFjVaV0sjkBmVNssJKwDMf3cr5OujD7HuYaMMZ177V2ZZ2P0ul1BAom8ij286dVC3A9yuLD31c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzot/9p4MNatLAZ63Xhp22EVAiM0yx8i+nxXPmlwti6pNH6yx4c
	MNA8ZPPh2F3RFGKrgCkqMftT1pIULbpP5az6rWnoc8IQt7mY9o5wJF9GvQjijaszVQ==
X-Gm-Gg: ASbGncstvPZyzfkt/AsjQ8YOPM+oDkDJQTxaNxZCO/Qc92foXkG+mKt7tOXJouXK5zY
	YUH5Z61YMIohoAopIOsfjaf3vVIls1/Wo5PK5riyU4mRyL7mR8FN+1xuCBhnY2DDL7AaTnQXA6o
	o7BK9bGsHrRcMNmKDWqdq6kwcXaVALlLZ5lTjqe7irxmjVEt780vYhaya/LDjtA6p13zt81hCKr
	1CVIwqBFUmtLCx+IlS72Gbafl3k06kMp7N7NocYglGNg3WNtkEIRmESOT4kSYJwQfxEbqpPpkjP
	BfgBppCw72UQ9bIenIZkFrsnXcGGdwyke+53p1CGItcDSL8Qj0Vy804CyG/p7A96T7YZQInCVxC
	VdhQzASpG5zJfALuoYfD8lPxHbu9ynTJEzWOf/pTGy0KHAiwZPw==
X-Google-Smtp-Source: AGHT+IFLUr0j2WR9Nd0qMRsWsIHFOH6znggjE7lmgxCqD3Uq946in/DRyGXhdUAnZKPPI7qOtPJMtQ==
X-Received: by 2002:a05:6a00:2388:b0:772:3aa4:226e with SMTP id d2e1a72fcca58-79387242fa9mr2116159b3a.19.1759898738380;
        Tue, 07 Oct 2025 21:45:38 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:465a:c20b:6935:23d8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02053b77sm17347590b3a.43.2025.10.07.21.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 21:45:37 -0700 (PDT)
Date: Wed, 8 Oct 2025 13:45:32 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Tomasz Figa <tfiga@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: kvm: arm64: stable commit "Fix kernel BUG() due to bad backport of
 FPSIMD/SVE/SME fix" deadlocks host kernel
Message-ID: <hjc7jwarhmwrvcswa7nax26vgvs2wl7256pf3ba3onoaj26s5x@qubtqvi3vy6u>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commits 8f4dc4e54eed4 (6.1.y) and 23249dade24e6 (5.15.y) (maybe other
stable kernels as well) deadlock the host kernel (presumably a
recursive spinlock):

 queued_spin_lock_slowpath+0x274/0x358
 raw_spin_rq_lock_nested+0x2c/0x48
 _raw_spin_rq_lock_irqsave+0x30/0x4c
 run_rebalance_domains+0x808/0x2e18
 __do_softirq+0x104/0x550
 irq_exit+0x88/0xe0
 handle_domain_irq+0x7c/0xb0
 gic_handle_irq+0x1cc/0x420
 call_on_irq_stack+0x20/0x48
 do_interrupt_handler+0x3c/0x50
 el1_interrupt+0x30/0x58
 el1h_64_irq_handler+0x18/0x24
 el1h_64_irq+0x7c/0x80
 kvm_arch_vcpu_ioctl_run+0x24c/0x49c
 kvm_vcpu_ioctl+0xc4/0x614

We found out a similar report at [1], but it doesn't seem like a formal
patch was ever posted.  Will, can you please send a formal patch so that
stable kernels can run VMs again?

[1] https://lists.linaro.org/archives/list/linux-stable-mirror@lists.linaro.org/thread/3FQHC4GVN57SM2CNST3EMVEBUXMSFOGR/#AQB4LMHLGTUO73GVCVV5QLCEJT3MRTN4

