Return-Path: <linux-kernel+bounces-730945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B02F5B04CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8D13AA9F1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EA21552FA;
	Tue, 15 Jul 2025 00:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LywTBn4k"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9AF35972
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752539018; cv=none; b=Tk4BJ+RJlmrPuPHg/nKjHzscIZXUoTKjGdUbITBS7r46QmPEhSjd45NBDXxyq4el61opWZ8gLzLFuho1jez0X3xzw2akiWgPLUezt22L1JHOTC+kkFvlxPXMmViIOcNSPF7d3GpcECKyDTjXvz6ZMLAYSNuCAwIzkCy4O9NRc0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752539018; c=relaxed/simple;
	bh=FoFxgarM91o7PNWeWxxkOFiYYgc9SjBMk3YHyF1te9s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CsUmzTe0PbuJyyo6tUGstq7IYw3HFrYr6TvqSDdX44f/TYsr/IJsecPh/vP60ty/VX2s5hdIN9W4uxDD4Mf4CNSBlJbH1+PG6O9ndYl7sj/Ax3yivkq7ZNrEmK0OlgkT85PK/4tNGBbdPsklOjepjyrIzgZzjX1ubNg2DK8D+7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LywTBn4k; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b115fb801bcso5197054a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752539016; x=1753143816; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t1Sx8v8BkbI+tNWtOcPfF0dRwgRjnfx2k5f4KxPLm+o=;
        b=LywTBn4ksAzDrvRsEVrxtmb4xxA9KZf9RqFkBcO6NMTVRz3ruunFeRFDJNybUWrw0R
         ejFu5/lfoJkSqwoIxXtC+4zZD4dmUlqEKXwUDkGikDNiZCaLrERI2FbFrw9Y5bg+ytE2
         Q6zZO7CdGhr/L6FLartuFDhEnCpW97B+5izppYivysrn16tjl9zAGK8367Ciw67TNBU3
         KXgmbPlofs3KYMefCyFdIIHQDCBTtA28k8mng+zJYjtFz0qrvbxU29wcr4qTb3CiygHv
         eS5GTgjQnmnQOBLuy0ThxHipNfQFb+Pl050jSSN3xtXr6z/F+AJgKRoW6CZq2mfk1WsN
         hD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752539016; x=1753143816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1Sx8v8BkbI+tNWtOcPfF0dRwgRjnfx2k5f4KxPLm+o=;
        b=pIUG26dY888iKS27QUykqPMFAcDYCipoUWLrQIevWQxMNYLaO5VnCnkQ7Zh2zeA1He
         j7vq77z8x9qVQVlpSzzGvQqzyY8WQNopDMKhr4GDwgGoXnfUpL59Zjunm/D0+ugrhXyr
         XfHHbUJCzt9bAUoTvOG0Knmw0uojguHxhXWT9aRiJzHVg46ZeaTwN6mDoNQ6Txo/uwVO
         FveJEyaBpDtGmzx5PMI2ckKZndb958yaNyDVpU3l64bjyGECSnZfh2Ycn9MfPDbn/OUW
         LkeKgZ+J2LtECQzqHurPaTpSRIm1A/u7J/PkoE5tdnQaBVbyVX6oWBac+K0PxkYcnEx3
         K7uA==
X-Forwarded-Encrypted: i=1; AJvYcCUF9C6BrmiHqVaV0jVoUCSk2y/ltte0GZ6+VadncQ4W6QCzd4a6ejbdQGDtcFg71YIpWKlrCR3nIDIYMyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9aJmA+sgqoW2xwVmXYUwYCZgeRQ+Aqi8ia0uM3rTkc7VIeJH4
	C8EDdb6YkeVFwuKET9D0z8lbZVl/DEhdEo9tbQmoNwB5l3OdwZH5vzHxBgLVutPvJvZFYtgrD8z
	JTw8bmw==
X-Google-Smtp-Source: AGHT+IEUSBnPd7eOM7GhtRPOwcoXc0WmiyIR3AaHeXO4VnbeKOpBv43O19pa8I27YDeCE1pK+yt2uXecf74=
X-Received: from pjbcz11.prod.google.com ([2002:a17:90a:d44b:b0:2fc:2c9c:880])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5645:b0:311:f05b:86a5
 with SMTP id 98e67ed59e1d1-31c4c973dddmr24995827a91.0.1752539016273; Mon, 14
 Jul 2025 17:23:36 -0700 (PDT)
Date: Mon, 14 Jul 2025 17:23:28 -0700
In-Reply-To: <cover.1752444335.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1752444335.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <175253196286.1789819.9618704444430239046.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] Improve KVM_SET_TSC_KHZ handling for CoCo VMs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, Kai Huang <kai.huang@intel.com>
Cc: kvm@vger.kernel.org, thomas.lendacky@amd.com, nikunj@amd.com, bp@alien8.de, 
	isaku.yamahata@intel.com, xiaoyao.li@intel.com, rick.p.edgecombe@intel.com, 
	chao.gao@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 14 Jul 2025 10:20:18 +1200, Kai Huang wrote:
> This series follows Sean's suggestions [1][2] to:
> 
>  - Reject vCPU scope KVM_SET_TSC_KHZ ioctl for TSC protected vCPU
>  - Reject VM scope KVM_SET_TSC_KHZ ioctl when vCPUs have been created
> 
> .. in the discussion of SEV-SNP Secure TSC support series.
> 
> [...]

Applied patch 2 to kvm-x86 fixes, with a tweaked changelog to call out that
TDX support hasn't yet been released, i.e. that there is no established ABI
to break.

Applied patch 1 to kvm-x86 misc, with tweaked documentation to not imply that
userspace "must" invoke the ioctl.  I think this is the last patch I'll throw
into misc for 6.17?  So in theory, if it breaks userspace, I can simply
truncate it from the pull request.

[1/2] KVM: x86: Reject KVM_SET_TSC_KHZ VM ioctl when vCPUs have been created
      https://github.com/kvm-x86/linux/commit/dcbe5a466c12
[2/2] KVM: x86: Reject KVM_SET_TSC_KHZ vCPU ioctl for TSC protected guest
      https://github.com/kvm-x86/linux/commit/e51cf184d90c

--
https://github.com/kvm-x86/linux/tree/next

