Return-Path: <linux-kernel+bounces-817775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A3CB5865F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CF4486B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9EA2BEC57;
	Mon, 15 Sep 2025 21:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bRnmGwR7"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F3E23814D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757970539; cv=none; b=Y3KMTuZGlLYfGjzGlcR9mYeQ2E+1a10ojJ1SCFh+uOpwwOzLTPtJGazb86jiykzWt7w33GH6ESkPt9r4A5JBan6nrVnHvUmP16piskuLT5wumYCJwyLEgxVFcLjy0tzIiPa7vLFEXQQQeRz70kUJiUk8Eke216s+IRUT6kGSCNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757970539; c=relaxed/simple;
	bh=Ih/U4z/3ttn5Yg9C7BXzOVkvezPJKgWCvyMiUq/ik2o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nAFwhaT/puLtBlMD6N8T/S2pGgkeQJpuF/KQivCQ6aACngkoqpYG7mS20XTb+zFE4JAxF5Ns49S0RyspiJFzIBVfd0XwXENJzOv+nWbU/yEGZBkMtrryHaAvLjRWlAcnMRT2YTzsJvIONGGqG3Pv5lIqE8FvezyZBDAkjEcTx4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bRnmGwR7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24458274406so90623005ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757970537; x=1758575337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VHoV5x8lSTUyrMscJova2iCZDY1TZMS3J7e0N01HyDk=;
        b=bRnmGwR7PXthzxKvMGDjb1XJiXTshFtUJ0Qe4PzMc/HRz81I9NkYc2krrjMdP8j9ET
         wrmyO6CPJPFEy/Gjy7ctvSCeiaMLlmcVE/xnJRFXzkIwd1cuIEGWZOYNaLcibgxIfR75
         APTx+62J4ckxpjcI4SNXGmK1puHmD8YLmP492fuhdxaobQVyrgzG15snNLRpYxxWGO68
         7gvvLqzXBkYEwyg8aIjcm6Bdjab0q8lL7wP9rhs4oJPWMqLWIpAIwN4uBgmbA2mOlN8A
         SSU6zxaFMTVYIXNKLe69Ht/oYyNk8BlZ3MOC8gceAtVNCD3OWAJvaFCnDtxorjepQdxl
         eCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757970537; x=1758575337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHoV5x8lSTUyrMscJova2iCZDY1TZMS3J7e0N01HyDk=;
        b=hG9EBbbZ2DPGDnpyry5PX1rxk7QXMRDGEd5B62P1mfa+dwXRBqVUzG5TdwVeMN3juq
         U5JG1/RPjEv2m/oxy3xn9Dyt4jPiE+5xFLf6WiZ8hTDsRZ1Sncf6TLKba588TGqDng0W
         mfmuGbE7mrw0nfO7+AVfNkTT1aV92f6h5qLOPPzcMdnLdWrh6GBfWRFC53sBN2wJ6F0Q
         7sghH4CfZpWb3zbGCJbWTVA7B0OjExtBOciuV0rSkcBKqbrw5rUxU/W+v7hbwyjqFoUn
         LHdjUZy9watv01EzUlWdNMMfnLa2Sw92bP686iP1W37bUsW1N2/MCMFRZRR3R6rw7X+8
         CeLw==
X-Forwarded-Encrypted: i=1; AJvYcCUfBtqvExW85orDFtF6JaDboW056qKkXFUz42xkgvbgxp/yyMiUOJlB48bmAc3xRRyJrLFufKcdDEE6c5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhW5zQNQGdujH/MP6wa8Do+nzFJHK/LkdTofrDPkWfw7k+coBr
	TpyMD49gItADW6+X2IXq2lKbdczxt3/589xFcXUUFXNy1Cj9+hD3Y8tbwFSIadbaUjQMBzUZrVp
	0shihVA==
X-Google-Smtp-Source: AGHT+IFhspb9CP1/t+ouX1v7WI9sXhhBWzH1IoI9+og+oNmjMAVrJzxLQy34obRp+DaPbO854t20JPjzujU=
X-Received: from pjx12.prod.google.com ([2002:a17:90b:568c:b0:329:ccdd:e725])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f785:b0:267:bdcb:6854
 with SMTP id d9443c01a7336-267c4a77eb0mr8403995ad.10.1757970537606; Mon, 15
 Sep 2025 14:08:57 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:08:56 -0700
In-Reply-To: <43b841ed-a5c3-4f65-9c7e-0c09f15cce3f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com> <20250912232319.429659-3-seanjc@google.com>
 <43b841ed-a5c3-4f65-9c7e-0c09f15cce3f@amd.com>
Message-ID: <aMiAaEMucEeOKiTj@google.com>
Subject: Re: [PATCH v15 02/41] KVM: SEV: Read save fields from GHCB exactly once
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mathias Krause <minipli@grsecurity.net>, John Allen <john.allen@amd.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 15, 2025, Tom Lendacky wrote:
> On 9/12/25 18:22, Sean Christopherson wrote:
> > Wrap all reads of GHCB save fields with READ_ONCE() via a KVM-specific
> > GHCB get() utility to help guard against TOCTOU bugs.  Using READ_ONCE()
> > doesn't completely prevent such bugs, e.g. doesn't prevent KVM from
> > redoing get() after checking the initial value, but at least addresses
> > all potential TOCTOU issues in the current KVM code base.
> > 
> > Opportunistically reduce the indentation of the macro-defined helpers and
> > clean up the alignment.
> > 
> > Fixes: 4e15a0ddc3ff ("KVM: SEV: snapshot the GHCB before accessing it")
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Just wondering if we should make the kvm_ghcb_get_*() routines take just
> a struct vcpu_svm routine so that they don't get confused with the
> ghcb_get_*() routines? The current uses are just using svm->sev_es.ghcb
> to set the ghcb variable that gets used anyway. That way the KVM
> versions look specifically like KVM versions.

Yeah, that's a great idea.  I'll send a patch, and then as Boris put it, play
patch tetris to avoid unnecessary dependencies (I want to keep the CET series
in a separate branch for a variety of reasons).

