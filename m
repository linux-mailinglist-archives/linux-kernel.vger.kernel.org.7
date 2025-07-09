Return-Path: <linux-kernel+bounces-723835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D69DAFEB7F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BADB5A7EC5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9AC2E54B8;
	Wed,  9 Jul 2025 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KJGQ6yMA"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063F82E425A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069945; cv=none; b=tysInSNuIPgI/Gg14VIULi7BeN17PaDqU/Zl35KX7JT0Jiu/M+THkCHEKt9gONI16akvMGUgpPOxE2xbIE5eucIvFN2U1h1/IkmPCaR4LnQAqK678I1lgQ5rmmq4MeMtJg3sf5VdZEINHCFCJhwJ3JPMlWBAVruiE8g02ozZmGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069945; c=relaxed/simple;
	bh=PUvIaqsWfsVx1IqeqReOjQqX2mL4vrwZF2ErZytGi7Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mqwdSxdJnrsBifFr+AZX+tu4NHDHSh83qGS8/Uxn6+2sVA8njXyzmgord4X8L5CkIvLWm2n0kz4xgKAizwgRlqHGLDTs3aWbT4vSB4sUwRxJc1i30hfqfXG7GHwgwNAn70NHsfagepPPYmmkQFE5LTxooFr4xHIzMqvLU2drzug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KJGQ6yMA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-234906c5e29so71198215ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752069943; x=1752674743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1jYnZjZf6ufM9SyHc+iG+DGsukrd9VmFJ4DhvE9WEkQ=;
        b=KJGQ6yMAST3fNo+SA80C52jiw161cuorLhz14u/Z/eD2kvXSafJA73ffoU9CYeyWR/
         BqyoCfunKZJmOEKl8k4A2ig//+BLNz05x1psftfjSy2csf+699R9vxPCkkUcQ8ykdKVt
         q5ThJHsAn0t1R5lMlSVbSBzCjTCgeCDWHFAdFzQepoox4pkv9BNm03tXJfTtNeO6l2sz
         RzTq0TCT+Sg5XIR+Py3WCMm9dCnU1RklJqUPxNCrMjkNL8jCib0tulAhAs1dcj3w5Jk4
         3QYEDjvr3dooRNsL+0rcyDF7+oWVrYJCVC7JkApDty1QBti2AwsXAfaDygLP+HUvmXd5
         paUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752069943; x=1752674743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jYnZjZf6ufM9SyHc+iG+DGsukrd9VmFJ4DhvE9WEkQ=;
        b=fVNFAWyalFqFSxtJZYrf7b63i0jVvnldjQAdmWZ9Edi7O7wUb3Tqp6BJPa7mRrqn2J
         jWsmPj6rZyssbDyn6ihbH5XfrT/81WFtMLwBxVHeyVIVcXg3MGi9FfMu1mTCEEua0eYT
         xSAVc5RV//4W2nQgjKcBq/JpCxVNIMYs8WlGFMfSrG2DWKmycE+Lo4WUyzjppNFsw119
         Pb4LKhjQ3dTDSTjkl9K3lHZ2D+dbqbMGAU3jDlqazu4JWzVZHLvXiOgMil54HKKqRVUz
         WU0lCDz5A6dUPCGilkv7gtJF53Y+gwzKJLrkKTa7094XzwCtanxtmY41EM0n7tgQmVVq
         K4uQ==
X-Gm-Message-State: AOJu0YypnMXggexg/sn8m8+erBTuq4UBUZfsthL/7xrlZr67QHGTyFoR
	wNBbjHyzryX/G/MK/kJmNmDj50ZX2hQ+x4Sv9K3Q9po56bDnElfXGbwdzBWdI7HAznHd5cvqPZ1
	/RZH8mA==
X-Google-Smtp-Source: AGHT+IF5YmCnSm3azK2lqCf9HxbkqI3KFjMgu2W7dGogQud3tJLYHgc16fRocT/6iMSvPs5pSKJvEZhdEgY=
X-Received: from plbg4.prod.google.com ([2002:a17:902:d1c4:b0:234:c2e4:1e08])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec8e:b0:234:a139:120b
 with SMTP id d9443c01a7336-23de2436c91mr787235ad.11.1752069943226; Wed, 09
 Jul 2025 07:05:43 -0700 (PDT)
Date: Wed, 9 Jul 2025 07:05:41 -0700
In-Reply-To: <20250709033242.267892-6-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709033242.267892-1-Neeraj.Upadhyay@amd.com> <20250709033242.267892-6-Neeraj.Upadhyay@amd.com>
Message-ID: <aG53Ne2hYrG8rfFR@google.com>
Subject: Re: [RFC PATCH v8 05/35] KVM: x86: Change lapic regs base address to
 void pointer
From: Sean Christopherson <seanjc@google.com>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, Thomas.Lendacky@amd.com, 
	nikunj@amd.com, Santosh.Shukla@amd.com, Vasant.Hegde@amd.com, 
	Suravee.Suthikulpanit@amd.com, David.Kaplan@amd.com, x86@kernel.org, 
	hpa@zytor.com, peterz@infradead.org, pbonzini@redhat.com, kvm@vger.kernel.org, 
	kirill.shutemov@linux.intel.com, huibo.wang@amd.com, naveen.rao@amd.com, 
	kai.huang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 09, 2025, Neeraj Upadhyay wrote:
> Change APIC base address from "char *" to "void *" in KVM
> lapic's set/get helper functions. Pointer arithmetic for "void *"
> and "char *" operate identically. With "void *" there is less
> of a chance of doing the wrong thing, e.g. neglecting to cast and
> reading a byte instead of the desired APIC register size.
> 
> No functional change intended.
> 
> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

