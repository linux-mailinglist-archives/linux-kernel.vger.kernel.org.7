Return-Path: <linux-kernel+bounces-838559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D03BAF874
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7A987A8EF1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 07:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B94826A1CF;
	Wed,  1 Oct 2025 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/g4j24e"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302533770B
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759305625; cv=none; b=U7Xr4Fx0Jc4oGFuti0FzR9AUx3GeLiH1j1ivST8jsyJoRCbtnrGLILKtUF2/Ta5k1t3VrBGSO8bE2KNAk8+XQQV6hqOTYuDU1kiHzc3xIveWjNJEKwvdHee0U9rsmJHtu0ABThhh8BCKk6fA2y7jvSXoGjsON295WfkYzM0JAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759305625; c=relaxed/simple;
	bh=Hy1eDptd3RnDCLhYADdcAkwktCJao8VLHf5Lwifc0jU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lhosGFVzDr1nAf8Kci0T77NE/SX7QtftwG4ySWtMz9kAUi0P0VTCWB0ul/xu6/gyueKbs+X9WnxO+Gxzi4sssGHXECVIHtSGTG4bNIEo2L9VW75lu1ZG0wQ98PUfjSUdUXSxpX2AyMUzEpTmRuvycu/UoQhY06cbRLLMdULwPXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i/g4j24e; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ec69d22b2so6540288a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759305623; x=1759910423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Tl+hed0N6TppaJ6AKUhyqnsxkebUjy4YDJ4+LU5qyE=;
        b=i/g4j24eo96B+LajOT7NZj/WhyINLwG22XB3FlxOlPP/IxKj6i1d3ED3ItJrhdCpUx
         QqsPgP2q0r767kAbU5FCp6svyHPcj1h+GoCWkN4J9IclWUOeYEXELOgCiRhsdW/tdAyl
         CeXNNOHicYyf2UfOFSNaMnW4JDA9iy1X2KpnRUacjZp1eAuRtcrQcAnDSUTpH9l2aEdu
         r8bNPArtcK8bNm73+uXQrpW9m06j6rzuf0FFPPjotwZ7iKm8RBETz0pMd+JYf55sUriB
         yHKhKb3pDwhlS7L2PrHajKYB92wkRyR+1D0+5G1jxDsiuc1FYXmxQd4fZBWYTX/sB7c2
         sfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759305623; x=1759910423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Tl+hed0N6TppaJ6AKUhyqnsxkebUjy4YDJ4+LU5qyE=;
        b=aR5TMzjzfmxK23WZeY4dpScaUa642AH+36rmbYkk569CwBudW4e9ihCdOLG9qQGXkQ
         H3Gu0GOir7FOdFeAocE4E1NysKezSsc2KrvPgyvGBbKaYGkh+Mjvirc9DYwauhE4lqK2
         rP6kP2FoRtk4FPy/s8oVqY5dl2z1+pRXLymwmxAHzUj9ruLdjtzZjYRuSAj96FL3HHMv
         8PQvxgClAi/XHSVvmf9YKNocpRWamdiHBrDgw4eeYjteVU3TYI1F8eG6LTpvYKPfoozH
         fCw1cmQdkdEOKM3Go5s5YWfzFwNMQ5ValqLzPdqrk4XH+GTsnAutZ539q/i9hPqI82QC
         AbCA==
X-Gm-Message-State: AOJu0YzKBtio2NfuWZiR1g2vC43JRrMoDfyYbmjEPrCZsxN86sgYiB5I
	oKBjUnK7laG7NW2khMrfreWoDpRP1DgcU1jNMalV1FyMQRZYU0/8lD7Dp/SZWdcP35EVwjy1eQ3
	27PTmbLMrHhCTamXJTtiLSAqMGA==
X-Google-Smtp-Source: AGHT+IFOxY0jnEcQfjZ7ErODgrPkCwI41v2vt546rzZ8qNIQTJpctxaVBVP6CbAGfqh6eDUwSlLw/ARkE9aRRb7Viw==
X-Received: from pjvg23.prod.google.com ([2002:a17:90a:db17:b0:330:6c04:207])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c48:b0:330:a301:35f4 with SMTP id 98e67ed59e1d1-339a6f30424mr2773499a91.20.1759305622740;
 Wed, 01 Oct 2025 01:00:22 -0700 (PDT)
Date: Wed, 01 Oct 2025 08:00:21 +0000
In-Reply-To: <20250807094503.4691-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807093950.4395-1-yan.y.zhao@intel.com> <20250807094503.4691-1-yan.y.zhao@intel.com>
Message-ID: <diqzecrn2gru.fsf@google.com>
Subject: Re: [RFC PATCH v2 17/23] KVM: guest_memfd: Split for punch hole and
 private-to-shared conversion
From: Ackerley Tng <ackerleytng@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com, seanjc@google.com
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org, 
	rick.p.edgecombe@intel.com, dave.hansen@intel.com, kas@kernel.org, 
	tabba@google.com, quic_eberman@quicinc.com, michael.roth@amd.com, 
	david@redhat.com, vannapurve@google.com, vbabka@suse.cz, 
	thomas.lendacky@amd.com, pgonda@google.com, zhiquan1.li@intel.com, 
	fan.du@intel.com, jun.miao@intel.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, xiaoyao.li@intel.com, binbin.wu@linux.intel.com, 
	chao.p.peng@intel.com, yan.y.zhao@intel.com
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

I was looking deeper into this patch since on my WIP tree I already had
the invalidate and zap steps separated out and had to do more to rebase
this patch :)

> In TDX, private page tables require precise zapping because faulting back
> the zapped mappings necessitates the guest's re-acceptance.

I feel that this statement could be better phrased because all zapped
mappings require re-acceptance, not just anything related to precise
zapping. Would this be better:

    On private-to-shared conversions, page table entries must be zapped
    from the Secure EPTs. Any pages mapped into Secure EPTs must be
    accepted by the guest before they are used.

    Hence, care must be taken to only precisely zap ranges requested for
    private-to-shared conversion, since the guest is only prepared to
    re-accept precisely the ranges it requested for conversion.

    The guest may request to convert ranges not aligned with private
    page table entry boundaries. To precisely zap these ranges, huge
    leaves that span the boundaries of the requested ranges must be
    split into smaller leaves, so that the split, smaller leaves now
    align with the requested range for zapping.

> Therefore,
> before performing a zap for hole punching and private-to-shared
> conversions, huge leafs that cross the boundary of the zapping GFN range in
> the mirror page table must be split.
>
> Splitting may result in an error. If this happens, hole punching and
> private-to-shared conversion should bail out early and return an error to
> userspace.
>
> Splitting is not necessary for kvm_gmem_release() since the entire page
> table is being zapped, nor for kvm_gmem_error_folio() as an SPTE must not
> map more than one physical folio.
>

I think splitting is not necessary as long as aligned page table entries
are zapped. Splitting is also not necessary if the entire page table is
zapped but that's a superset of zapping aligned page table
entries. (Probably just a typo on your side.) Here's my attempt at
rephrasing this:

    Splitting is not necessary for the cases where only aligned page
    table entries are zapped, such as during kvm_gmem_release() where
    the entire guest_memfd worth of memory is zapped, nor for
    truncation, where truncation of pages within a huge folio is not
    allowed.

> Therefore, in this patch,
> - break kvm_gmem_invalidate_begin_and_zap() into
>   kvm_gmem_invalidate_begin() and kvm_gmem_zap() and have
>   kvm_gmem_release() and kvm_gmem_error_folio() to invoke them.
>
> - have kvm_gmem_punch_hole() to invoke kvm_gmem_invalidate_begin(),
>   kvm_gmem_split_private(), and kvm_gmem_zap().
>   Bail out if kvm_gmem_split_private() returns error.
>
> - drop the old kvm_gmem_unmap_private() and have private-to-shared
>   conversion to invoke kvm_gmem_split_private() and kvm_gmem_zap() instead.
>   Bail out if kvm_gmem_split_private() returns error.
>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
> RFC v2:
> - Rebased to [1]. As changes in this patch are gmem specific, they may need
>   to be updated if the implementation in [1] changes.
> - Update kvm_split_boundary_leafs() to kvm_split_cross_boundary_leafs() and
>   invoke it before kvm_gmem_punch_hole() and private-to-shared conversion.
>
> [1] https://lore.kernel.org/all/cover.1747264138.git.ackerleytng@google.com/
>
> RFC v1:
> - new patch.
> 
> [...snip...]
> 

