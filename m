Return-Path: <linux-kernel+bounces-821700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35895B8203F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF66716F3B9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761C82C0F84;
	Wed, 17 Sep 2025 21:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JpJWpihR"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4492848A8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145676; cv=none; b=D5RulRE+ttECABr6V29nNjGITGfSI7wBMszKnxF+nqnFyB1BeeafB109HCzwvufLFuuc2ABcRFNbdVvyYuungNSlhInuPPNRgZRIlrFw7PrfBVKjQOyD35e0NZfE+Hwo9CCxImh2JPvN8cA1WVVqVOqLtihuBm2e0jnPWpzdUds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145676; c=relaxed/simple;
	bh=vDwVGMUwoQIN7wRx8wxfl/H6EhwD+FaLehZCfMpO3zc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KM03AlszpbVpWmWFMK19I4n0JU7Mf3qWsM7r5HHtcwcX/bCl3VP2S4xSJ3PwNfAz6ZUpoVpUkt1sq3d7NvvDcUXth7trRcUbwfgvOcv9a/R+7uYclKeOR2cByZv8KnQDNbj/vCf09HNRmjWOSul9UB/697Dg4ZhFpKpVvNAIjX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JpJWpihR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77621c54731so385931b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758145675; x=1758750475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CnOjwU8r714Dt21UtDQelJ2X/q33AiLSuVZHKqtjtm4=;
        b=JpJWpihRe6d3+sa2l+sAJ9wWJFuBBi25gCtu9tNUIA+f712Hh6uNTqDmNItHPqMJ3n
         wmZPgxVbN3fStWypkoXahELfXOOduaDodUFwfyunNgRdRyDSrHk8trbmuCoRlR4fvrPM
         Nc8faOMlRs0yhOLmpDPrWlexgfGFEh0Anby9dqh5rJtyokVzvF70Mnblgrra4b/6JYsL
         9vs3L5vlnzh/F2l2nIdvPROXq1emFe1XfTZiQuyOpz81Cxu5iaOu5pah4Lycx6KutR1a
         Eh7VQTgjyz1CasX9ykoiAMJF8n7hdF9Ej+5Qc6eZc35yLPkrZgl4r2i4Qzn00x7Qy3m8
         xczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758145675; x=1758750475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CnOjwU8r714Dt21UtDQelJ2X/q33AiLSuVZHKqtjtm4=;
        b=F2jh68/D9vV0zBn7wXI4hSWG5KKWEgTxpzblhk2y7/axfuiCmxgI1lfGgatfGUO99a
         2JvGoxPU8ih0Te+6dc5LhfDhGsDs+uFjpVoCEho5QBlYdMXhkQKchqs67qK7SZG2y/4E
         /t+5SghoPiC0wo+wPZCY4uvYQXcD48J6Xzwz0VtSp1NFcuoLodvKHx5f0dVLQDa2IoWn
         16Y6COgwZVupVDt5kWiQlq+Hdatf23sUakcexwPCr/iKM3rGhzjT2fP413OAiv/AUCSz
         UGGPohU+CcL9MAbOgAFL0ADKHyJDcDP/0O/k/FZh2Vl/a8Cfj4rto4dHqGi3H+u/6Yd5
         w0VA==
X-Forwarded-Encrypted: i=1; AJvYcCW0N+wrx3bASPvCLUD9wW4eyEgPGZfRLqhXMPg4HclOTXHJwBrIRl4twpGwvcnu8ds2SSHSrYAwuRb/ZGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP9F97KDIjgmILCckUO27OoWq9nnDqPOMbCwRNMwVWmkvT1Dxq
	832f75HRIanoXxGw+RYUKrMHGF4qSOkqc7TDmqJfr+ShmygwgKOVcGlv9KJpxlTdnaTUtYI/+/c
	E/C/gzg==
X-Google-Smtp-Source: AGHT+IEFUY333coW+9O5ChpDApK9jT9ssFMZZMv4IoI5zkYzkCI5j2G8LD61MmxUj2auUaIOAztnx9RjTbU=
X-Received: from pjboh4.prod.google.com ([2002:a17:90b:3a44:b0:327:dc48:1406])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d8a:b0:248:e0f7:1326
 with SMTP id adf61e73a8af0-27a8ca84639mr5618265637.2.1758145674850; Wed, 17
 Sep 2025 14:47:54 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:47:53 -0700
In-Reply-To: <aMiAaEMucEeOKiTj@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com> <20250912232319.429659-3-seanjc@google.com>
 <43b841ed-a5c3-4f65-9c7e-0c09f15cce3f@amd.com> <aMiAaEMucEeOKiTj@google.com>
Message-ID: <aMssiS12LPPmDjNK@google.com>
Subject: Re: [PATCH v15 02/41] KVM: SEV: Read save fields from GHCB exactly once
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mathias Krause <minipli@grsecurity.net>, John Allen <john.allen@amd.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 15, 2025, Sean Christopherson wrote:
> On Mon, Sep 15, 2025, Tom Lendacky wrote:
> > On 9/12/25 18:22, Sean Christopherson wrote:
> > > Wrap all reads of GHCB save fields with READ_ONCE() via a KVM-specific
> > > GHCB get() utility to help guard against TOCTOU bugs.  Using READ_ONCE()
> > > doesn't completely prevent such bugs, e.g. doesn't prevent KVM from
> > > redoing get() after checking the initial value, but at least addresses
> > > all potential TOCTOU issues in the current KVM code base.
> > > 
> > > Opportunistically reduce the indentation of the macro-defined helpers and
> > > clean up the alignment.
> > > 
> > > Fixes: 4e15a0ddc3ff ("KVM: SEV: snapshot the GHCB before accessing it")
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > 
> > Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> > 
> > Just wondering if we should make the kvm_ghcb_get_*() routines take just
> > a struct vcpu_svm routine so that they don't get confused with the
> > ghcb_get_*() routines? The current uses are just using svm->sev_es.ghcb
> > to set the ghcb variable that gets used anyway. That way the KVM
> > versions look specifically like KVM versions.
> 
> Yeah, that's a great idea.  I'll send a patch, 

Actually, I'll do that straightaway in this patch (need to send a v16 anyways).
Introducing kvm_ghcb_get_##field() and then immediately changing all callers is
ridiculous, and if this ends up getting backported to LTS kernels, it'd be better
to backport the final form, e.g. so that additional fixes don't generate conflicts
that could have been easily avoided.

