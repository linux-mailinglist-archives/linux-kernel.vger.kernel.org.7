Return-Path: <linux-kernel+bounces-885266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8647FC326A3
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A8DAA34BBAA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F5633BBBC;
	Tue,  4 Nov 2025 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8YCkQaV"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D482FB61B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278374; cv=none; b=YJ+BPrBdSo4kz40o8dXg9vFqUuLG7JjBVMCRd8NoTrmXYLGnG92u3WTc8WF3TjqdXhZxovcFB6H/X6AbtBAPuOFJAA9I4GJtqsLdxNjQbrR0WG8AhJHekSbxkCbc0fz/PYv/IYdVUTv/YGblGlkCGZpy1DyZHxuIpRQR12yJlaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278374; c=relaxed/simple;
	bh=zvK3AGR/wfWblYlZlGaB0GtsE5DjaYWmJ5QCpM+ehoo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mH2M9CnmvyBXvjF/wruqaJcQyootG/rT9zIR7jzu05F4r5Oulv5v2p6SY0OGtnFEb9/iHewP0/1lchz2rfdzopcYmesg6qg7jK6OBBwVhNHE5K8P9UdYK6qzNLuMLfCtk3GkKfr6om7bJ+lA6xFVgmzz1LvHAtfKWRLlJ2PoTtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O8YCkQaV; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2956a694b47so38042075ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762278372; x=1762883172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H0VNiWAjsdYdl3WJhMa7XY5d4qYfHVmup3jEU4PY9Ko=;
        b=O8YCkQaVyBTVgmZ69hk/Ntw8BmTzQPm8lnNTOQmaI/i/9BYhGTiS6/kO/eyq5tEP0W
         JGUd3uLVSJk4MWUU/8T0pni+fi2x52RzC8uY2YF3Dsy8tTKaInUFQtkc8LXARLP4Yrrn
         ZCVwYHw5RvcdTsYex0Le3SdbTnhCk0F6MYQ3RYaGZpCMrrskhALnaMeUiLR9l1//gEdq
         EVEeC0Kx1da8xAWgpgWOmobSsvEkdOtlGHYBfmCzayHi8m5n1o4km9wgBelHZdtzspgq
         YvBGSbJ250uta8u5eQeqbr7mtXZrCpyIVxY3AVaY+uYm/k62giCiZUp7/fB/GigYRv38
         ax5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278372; x=1762883172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0VNiWAjsdYdl3WJhMa7XY5d4qYfHVmup3jEU4PY9Ko=;
        b=izq070GeKnA0Td+tWhP9R6HljhcMq8too0UtijSJczFuWlUEnX3JOif7BdoAfHKKWa
         wE8XrZ06mTTqaENetXsw3CDrsFzDSDStLcM39Te4R41/y9FERHZCbBLnFzirXDX3/tMb
         Q6cXI/gkZCvhc79wsCX3M+ZXF8NErbNpxR4U3ReySLDLc1nC+y6vU63RZyZ2AKi5xZCK
         RrGfCt9UTLXKigHTsRKlIq0ViQFAiwiHyKK6zO1PRj6DYNPNIOpCWemuS86jzTb01BeV
         ir28gQqzgd28jpiwWcdWnlNHFAFuhX7TxKNBqIAoc55bo6GUVDGQBvBsAOEu2PxVpgNb
         wuOA==
X-Forwarded-Encrypted: i=1; AJvYcCWev7uBlJo+15lMlAAtjZTGgYLx7V08y1J53OITeHoKclLGvn7fFNQWGKcJeiG6gJTIF76mDz6MlgZ+nG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCjbCqXzKLsmNI9PK+GasSz9aEMjBBMtEpUNmxIWwZZjxKlSC6
	dhKvxxpLH98imImYBgpETXXS6GYbwdbhpMPhSVSLbyP+Tm12X+p5WrXfHlQSr/smmMhFqHN0kwR
	wqd4B2A==
X-Google-Smtp-Source: AGHT+IH/4RfaWZuPZrBPg1BQIo1EQLknH0ihFneDscbhHvDFB4mHizM2ii7GyfQACuJRrOjP8M7SvfZf+R0=
X-Received: from pldr17.prod.google.com ([2002:a17:903:4111:b0:27e:ed03:b5a5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:94b:b0:295:8dbb:b3cd
 with SMTP id d9443c01a7336-2962adf009fmr5333595ad.27.1762278371863; Tue, 04
 Nov 2025 09:46:11 -0800 (PST)
Date: Tue,  4 Nov 2025 09:45:00 -0800
In-Reply-To: <20251030185802.3375059-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030185802.3375059-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
Message-ID: <176227794415.3934259.3450243632077976793.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: x86: Fix an FPU+CET splat
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 30 Oct 2025 11:58:00 -0700, Sean Christopherson wrote:
> Fix a explosion found via syzkaller+KASAN where KVM attempts to "put" an
> FPU without first having loading the FPU.  The underlying problem is the
> ugly hack for dealing with INIT being processed during MP_STATE.
> 
> KVM needs to ensure the FPU state is resident in memory in order to clear
> MPX and CET state.  In most cases, INIT is emulated during KVM_RUN, and so
> KVM needs to put the FPU.  But for MP_STATE, the FPU doesn't need to be
> loaded, and so isn't.  Except when KVM predicts that the FPU will be
> unloaded.  CET enabling updated the "put" path but missed the prediction
> logic in MP_STATE.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/2] KVM: x86: Unload "FPU" state on INIT if and only if its currently in-use
      https://github.com/kvm-x86/linux/commit/8819a49f9ff8
[2/2] KVM: x86: Harden KVM against imbalanced load/put of guest FPU state
      https://github.com/kvm-x86/linux/commit/9bc610b6a2a7

--
https://github.com/kvm-x86/linux/tree/next

