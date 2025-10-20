Return-Path: <linux-kernel+bounces-861301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 933FBBF2526
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52D494F74DE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE462773D4;
	Mon, 20 Oct 2025 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Lk//sBX"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C819C1CEADB
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976621; cv=none; b=GwV63h4YGAbC6iA3ruJKo1bPVcX2eaQx91HGUsA+5K5MIF8dgm0AkjYFLr6NkDxisFrWzDIvVtQWcap9hQSU0qviABE9VN/GZktbtdDYfZZkv32GUn8mPDCYhHuO92hOWiqaUapsEgPZI9/tleUkBu/GbsVB0QULHq6a57mpGTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976621; c=relaxed/simple;
	bh=NE26bYfoFFrIsWDpJOzZL4KrJBFLdl0TaANwy0FsKOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LD4/d50YsaimuWX/pbvQ5u2sAY8pqCioFtldcf0r/T8QYsaraO3ej6U5+n5pCooF/EE0RrypgaTPatETr+icMRDcvnXFfpGn0wGWr3rn3+R0KKvbnlHa/IoVgp2nnz6zhwP0D2ueNYyd5YVj7gFwWQOQ2U9B3ghyJktaU7jID+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Lk//sBX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33bc5d7c289so7864542a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760976619; x=1761581419; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xu0WN8ythofnvoWOCKr5Ol3+oLE60o8C+tmt+Bq/TD8=;
        b=2Lk//sBXNYMHMrDphL13wGF9pO/RYoP1Bz1PzVmBZFyzau+qOvyeF4Yd2QJYpkKs1/
         Ezvsc0CdLyOfSh2Mg9ypOmgccD47e9+2Lu2qr69nxaEjwFqrcM0ssCMiYiynOmUeVJ1p
         vXHAZ+990JbAZPJaL/z2+lyiVu5aKKyTDDxrzTpU8afpAPS7TVvVIkwBCFF6dxb906rq
         TvG6h17RwrW/WsLswjdTkX6Gc0XvMq9KVPhPYDleOMi8sHJa9+uwPrQHmVWe9kf1zCnb
         4IH5rCN+qZXRnSSY+KD1kZWGSvdCyX2oWcnBqlkRUskLlqe1LSee4p7DXsiVDYDq7y2x
         AEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760976619; x=1761581419;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xu0WN8ythofnvoWOCKr5Ol3+oLE60o8C+tmt+Bq/TD8=;
        b=i40EO4xt9gClKw830g8hfLJGsaPIBsDNq7NlGN++pzZS+Vpte9tqYRPNWAdsfs8dtY
         IUMkODqeOrU7enSjjiFTvUyc7P9TWU5dZ4gHo5QTSYcLRm0EahZka0yQNBruIXc/J1kM
         M8KVJYjbDKKyzClj/gUDDw8SBwX3BWeDWKJhtU4X/wIWfw68KP4arrbSAio6QHB8pNUz
         Gg4S9VaSttQ/k2b+gFUEqN+cIIuBcNRIr77+po8IpIFKavbb55fxI7sLzN3feTZA7PoB
         EcRIwza788yYpVKcGXaKOOEL19cx2pOqjmM1hw394Vr8NIDiHuG/sQTwU+O/pCgtQ3fn
         d7nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvBHUWU3XyNXRlNtubg0X7PPniZusMS94XuEOEpV6BC2n5fF0YJLtfAi4SHP5JfLauJILA+tPGGHtC0Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Sj3NfKzYEsx0cBJEhebV1boesaP7lzKfOAughCje5yisRGTf
	rG3qKVJcBjKec5u3OPkKzWLjBWbwuIAZQzpp9B2hKb7R6RZTbbTvznqhKXQVa2/sAAggkxK4EUl
	EEkAtFg==
X-Google-Smtp-Source: AGHT+IGJLbXrm62yjngKT3FP3u1oyPXRP6DoV0W7nmjBQLe1fhWafGHsJm096m+Nlm5LTnuEg5uF8cgAl3k=
X-Received: from pjzl22.prod.google.com ([2002:a17:90b:796:b0:33d:6d99:1ed4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5111:b0:329:ca48:7090
 with SMTP id 98e67ed59e1d1-33bcf940e76mr15500567a91.37.1760976619094; Mon, 20
 Oct 2025 09:10:19 -0700 (PDT)
Date: Mon, 20 Oct 2025 09:10:17 -0700
In-Reply-To: <20251015-vmscape-bhb-v2-2-91cbdd9c3a96@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-vmscape-bhb-v2-0-91cbdd9c3a96@linux.intel.com> <20251015-vmscape-bhb-v2-2-91cbdd9c3a96@linux.intel.com>
Message-ID: <aPZe6Xc2H2P-iNQe@google.com>
Subject: Re: [PATCH v2 2/3] x86/vmscape: Replace IBPB with branch history
 clear on exit to userspace
From: Sean Christopherson <seanjc@google.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	David Kaplan <david.kaplan@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Asit Mallick <asit.k.mallick@intel.com>, 
	Tao Zhang <tao1.zhang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 15, 2025, Pawan Gupta wrote:
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index 49707e563bdf71bdd05d3827f10dd2b8ac6bca2c..00730cc22c2e7115f6dbb38a1ed8d10383ada5c0 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -534,7 +534,7 @@ void alternative_msr_write(unsigned int msr, u64 val, unsigned int feature)
>  		: "memory");
>  }
>  
> -DECLARE_PER_CPU(bool, x86_ibpb_exit_to_user);
> +DECLARE_PER_CPU(bool, x86_pred_flush_pending);

Rather than "flush pending", what about using "need" in the name to indicate that
a flush is necessary?  That makes it more obvious that e.g. KVM is marking the
CPU as needing a flush by some other code, as opposed to implying that KVM itself
has a pending flush.

And maybe spell out "prediction"?  Without the context of features being checked,
I don't know that I would be able to guess "prediction".

E.g. x86_need_prediction_flush?

Or x86_prediction_flush_exit_to_user if we would prefer to clarify when the flush
needs to occur?

