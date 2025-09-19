Return-Path: <linux-kernel+bounces-823794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B3CB87737
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 977A17BBC13
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D36A2AE89;
	Fri, 19 Sep 2025 00:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eL8KQv8P"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A37E26AEC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758240675; cv=none; b=n8rThiDwMmZDOykKvdStijJrECn4DKK4eH3nANrKMPY4sCYPKXoRGPkxYwvQnNfTx5MPUAOh8hPtpcLEzNN/vuYTFKLd/sc3J807v3s0QnbtTFbuKaKn/+Hq+Dkexpl3UHMr9yXfP1NNH9iPSpTf/xjOriQZBXuosK0Pk2OcCgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758240675; c=relaxed/simple;
	bh=5kZbjwa/6BVoxn5wegMROAiVV9lXMCurcroc08yFVco=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X5Tf1C/xpnPSHbErXTRQwJAPtT4OSuXK9E9GKW3LYZgVzbsE5IKiWv4aXhJUUmMDUzdUU5QpjO1huzY8XUZj2DbBUYFQU3Fl4B/GhoQBWQURYtECEz8YLO3VMQU5VkAzW/NLplpBwmrrVcLCGkmFbL+w74AXKCbmmMZSoc/pPwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eL8KQv8P; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3304def7909so1504022a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758240672; x=1758845472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WDq+VavY2pE4pyHZXsVu7LM0OhcCfDkB6zYweV3fNcw=;
        b=eL8KQv8Pstu8SY7UNwZbUO08qZHz+zeR7DquqpSOJDAHBtzGIC6g+cleyHShEfubb6
         pucUJRKpSR3mBhJFG7YBfaXDLSy4Qi5NQUZ5Ku6GjJjKW1A78e23OBBwtFOH+avA+S1p
         6aydHGj/mTV5nIEXt49JmK+zjQ5vEDsTJCvQVuBFJWhqrmtFk6u7r5O2yFOTYXI3+SJv
         lOPjOstzBuZ3wDNDn6y5bAPpuluaRhikHKAF8gjDWl+l4he0fNOnJBboFGzn7Qw2W8Oo
         LFdELRU493AOlsY9+oVqsartGnLOOiKQ+4y40Dqt2ZC3kDsYs0lUYQXnLr80qFRjWg3J
         xIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758240672; x=1758845472;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDq+VavY2pE4pyHZXsVu7LM0OhcCfDkB6zYweV3fNcw=;
        b=d5GjcaGAbj6Mtr4oR0IPaO1l+wHK8c3C5a2631OwCNlhTE4W+6VGmcT+xFmZDZ1qZW
         e0O+3EM1zcWQ1VVv45O7KRy8xvj8vfeo7IJAXx5IsfPUFZqcojoOFHVKbLAme0fWC6IS
         THVDwWtBMOVjf3Ow7I9plEBtOE9ZyhF0/IB/Pz1Ygkc+vuD2RSo23wvrFJbSlb7B6ftZ
         HVKzGrxlfPub3ga5JEl28WYEcK/PBUvO0HDyhqvTBhpVNsYNaOnw3rE8/313X22fW9mx
         02xK5559Jg2JjVntajHGwoHQr59Qzl2D2/trQVFUP3MxGNNwMEbafXez7QYb3kVsoNvR
         ylJA==
X-Forwarded-Encrypted: i=1; AJvYcCXmg53QlcPaY6VGz7jENtFzdS28RNmgYEVcJdJrkNMcFwf2PNS2b8EG1CgA11QBAQrqnAxnnoPJGcbTjH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLFbBuhJvyUQsTziR8QRt+rW+2cIT5ie8YoHt0+6JvXNa823hh
	K5Krix7sJwtCKyrzgP6ek5q8XtjUCKUdG7bcwDFrqlaHWoE31N2/qytJ9COgFx8iRzmLeOFTbsU
	2e0qvmA==
X-Google-Smtp-Source: AGHT+IH/rnw53WJfJ7eWmpB7rOT94jvdcHNYPMI0N+5Kli3XKXZCk6CSFlJKKvZxXUFlpHPnz2Wr4v6yW/M=
X-Received: from pjbpl18.prod.google.com ([2002:a17:90b:2692:b0:330:6bbd:f57f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:da8b:b0:32e:3552:8c79
 with SMTP id 98e67ed59e1d1-33098369dcdmr1600058a91.29.1758240672393; Thu, 18
 Sep 2025 17:11:12 -0700 (PDT)
Date: Thu, 18 Sep 2025 17:10:48 -0700
In-Reply-To: <cover.1755721927.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1755721927.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <175824019789.1343495.7167726134042080248.b4-ty@google.com>
Subject: Re: [PATCH v9 0/2] Add SEV-SNP CipherTextHiding feature support
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, corbet@lwn.net, pbonzini@redhat.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	thomas.lendacky@amd.com, herbert@gondor.apana.org, 
	Ashish Kalra <Ashish.Kalra@amd.com>
Cc: akpm@linux-foundation.org, rostedt@goodmis.org, paulmck@kernel.org, 
	michael.roth@amd.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 20 Aug 2025 20:49:45 +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Ciphertext hiding prevents host accesses from reading the ciphertext
> of SNP guest private memory. Instead of reading ciphertext, the host
> will see constant default values (0xff).
> 
> The SEV ASID space is split into SEV and SEV-ES/SNP ASID ranges.
> Enabling ciphertext hiding further splits the SEV-ES/SEV-SNP ASID space
> into separate ASID ranges for SEV-ES and SEV-SNP guests.
> 
> [...]

Applied to kvm-x86 ciphertext, with doc and comment fixups.  Thanks!

[1/2] KVM: SEV: Introduce new min,max sev_es and sev_snp asid variables
      https://github.com/kvm-x86/linux/commit/d7fc7d9833f6
[2/2] KVM: SEV: Add SEV-SNP CipherTextHiding support
      https://github.com/kvm-x86/linux/commit/6c7c620585c6

--
https://github.com/kvm-x86/linux/tree/next

