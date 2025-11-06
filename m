Return-Path: <linux-kernel+bounces-888464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62090C3AE4C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 13:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97131A46BA8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D5D32B9A0;
	Thu,  6 Nov 2025 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnewM3NA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B56632ABD1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762432213; cv=none; b=T+Q7+qpP9bKhDNKxHcBrIanMF9y5mTTenQkFvIyrMbfCNEJpkDrDBzN69U+rpBY9Sqgoa2ogNgX6rEpb+PA7fCwcJ3wB3M+wmYsFkVzgIw9IQF8p91iRH0WWc9hEcz192IRhHvObkEI7MfxM7os0YMHgUcnpgNVnP0kJm4Q48Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762432213; c=relaxed/simple;
	bh=Zxv238Sh/My5WupzWXJ5MQHjYqFRMOz2qFcj9KoIvAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUlnl4S/yU8v+SBrcxIS4YFs2GGUwhLouB4vfW067R59R5XPVCmeAPDjZo+LHoUP30CoH5kPlmCqG5FLJ3B6k+x+B2Ka2AlwnnJic8EUVqTShkhkyuehNjvVUHP7o2ya/xiv9Q+BaNmhvpLVBvN6nPuBweeT3fsYaxhtgzMibAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnewM3NA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E11C4AF09
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762432211;
	bh=Zxv238Sh/My5WupzWXJ5MQHjYqFRMOz2qFcj9KoIvAM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RnewM3NAGeeXi664eFAadOd4km/YPRZtGTojr0Pg9xCttOSHiw4fSKBASbO1fzUQD
	 lifL3pV5ToV+FPoG4dUqB3AjHBvuNq8fJsWqPljVSetD/BfC1g3k7gYrHjbBC6SDOl
	 SOiyvCIXNy/pt5DuugplRBlsFKoS6ax02f3euQhMjxPa3DBQASdDblU5u6vszoOlGc
	 CWJggJXToH2wxdqrXjcmy1LJL0iNQRe8ydQRdav2Ks4jlTxoOaPaybvCWMW7jdA2XN
	 9AWR0jWZAw5Bdc5nZQ74W8DyzeHSv0j1HR2caIeNJ774TcrEISu5SoTzVYA3J/UGtW
	 Ooc8qWpUf14pA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3e9d633b78so155288266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 04:30:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzLKP0mzdGJYqhQjiQOb5H2CXdpnYTtzX1EnXSox9ZzgWssuIzT1i+bFhIG+qtHAgVVCJXercv+GD8uqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytU/4uqmhnS+Z/eMSDY2iv7BoA3rImVutxR42lbKvluoW4fCvu
	eUUmTsePaaqGCX/V8BOi9xyIjXkKXl3W16UcMFpwKoPv2uAjoSL2GgxHF9xC53VEGfb5nK8r+zu
	MOe+kKcfp6CzVih0NtGBGbKPnMtEYs+0=
X-Google-Smtp-Source: AGHT+IGQEaG1Jr8KNRKTKhKSGldPg2aCZWHEsSxhESBypSgE7Lwo8wgnhpm146x+RnaEjQknFnpLfsOoNAnq23QHBTU=
X-Received: by 2002:a17:907:d20:b0:b07:87f1:fc42 with SMTP id
 a640c23a62f3a-b7289537134mr356096166b.16.1762432210334; Thu, 06 Nov 2025
 04:30:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930091702.2610357-1-maobibo@loongson.cn>
In-Reply-To: <20250930091702.2610357-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 6 Nov 2025 20:30:08 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7bo0d4qO695nJ+t5p3Bf2Ogzmeas1wKE2beKmdRvLpng@mail.gmail.com>
X-Gm-Features: AWmQ_bmB66uKwtpDAnzIJNSSEa0MWJtWtXfudDySosiSwEl973K_bVHQ36bASy0
Message-ID: <CAAhV-H7bo0d4qO695nJ+t5p3Bf2Ogzmeas1wKE2beKmdRvLpng@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: KVM: Set page with write privilege if dirty
 track disabled
To: Bibo Mao <maobibo@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Tue, Sep 30, 2025 at 5:17=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> With secondary MMU page table, if there is read page fault, page write
> privilege will not set even if it is writable from master MMU page
> table. This logic only works if dirty tracking is enabled, page table
> can be set as page_write if dirty tracking is disabled.
>
> It reduces extra page fault on secondary MMU page table if VM finishes
> migration, where master MMU page table is ready and secondary MMU page
> is fresh.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/kvm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
> index 7c8143e79c12..a7fa458e3360 100644
> --- a/arch/loongarch/kvm/mmu.c
> +++ b/arch/loongarch/kvm/mmu.c
> @@ -857,7 +857,7 @@ static int kvm_map_page(struct kvm_vcpu *vcpu, unsign=
ed long gpa, bool write)
>
>         if (writeable) {
>                 prot_bits =3D kvm_pte_mkwriteable(prot_bits);
> -               if (write)
> +               if (write || !kvm_slot_dirty_track_enabled(memslot))
>                         prot_bits =3D kvm_pte_mkdirty(prot_bits);
>         }
>
>
> base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
> --
> 2.39.3
>

