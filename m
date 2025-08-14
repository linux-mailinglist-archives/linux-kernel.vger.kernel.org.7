Return-Path: <linux-kernel+bounces-767940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39679B25ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394A71C23149
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA06221F17;
	Thu, 14 Aug 2025 05:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UCw9iIsj"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274AC1EDA1E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755149504; cv=none; b=r4sDmnX7ZBOJLqb4h0HnIhB4RRrgxsx22T/WfRyZNjTQwLKcyRUXg9G8cet8dzpfZezlPSM6Cpo/XGmVMQs/eRopXXp1osFe6yn+tV1w5Wj/tiP0hFynJr4vy9dlIl53nWyVgnZ/vGXpxB+ZQ5CTLriwmFndP8Ru7MOUS1XwDfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755149504; c=relaxed/simple;
	bh=jZvzmSyGn7T089VYJe2yp2prqHAiYftE0tbdCJ3bvK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGbScmh+3h19rKWLDqSibZoQmvs0bESKhIfUAsSAj7IEaTqsVEVwxq+BCe08Gj65OB1+STZWv9RBHuzOeIA/+xUTuJCL3+Cao/PixqQxQuPRBLIV2PYUk0Ybd2R9GbfVvYjaSAw9vuOPNoRkS2rnULjDoAsdMIT97gnBRl6NPFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UCw9iIsj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-242d1e947feso124355ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755149501; x=1755754301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5LVkqNa+t7tEOlEpRROaBVNxGWm7/JKJk9MQgMlMwQ=;
        b=UCw9iIsjMA+IkVwjKZ963HLMLXLpCO8Is7qC4fBgFL5rzSpOSGyqNl7MH8m6DGWacT
         wNafMWG4EkhA387wVtJh3/XyFgo21YyC/36MJh5gsFkUA/6Uyyh9bQ99OVVJmGK8JKAt
         umVIE2ob/pl3amR60U8PNLhMLksaVvvdlm2q56lbmWnNSh0YEc+EXTWUt9WGc3fq/qo9
         Bzs5T8bWsh1lIL5jJDqETudvlQH/IfdYXJ+G9JGhufSBUXeCbmTN1yCmCAAp8M7+x2JE
         Uv9951XoKekKZWzJXYd0g1N2JKSZEpO9T3U8ydx1UZPVdcnjcpbqPdmRcwHv+Xdem/Wd
         QGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755149501; x=1755754301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5LVkqNa+t7tEOlEpRROaBVNxGWm7/JKJk9MQgMlMwQ=;
        b=CkkIkNmRklXpJ5juzwSy4/vXF2S5l3AixYm3V5rn5x7As5C4nAl6ZnwfbpPinStucD
         SMjAJtPUGzyIy0xwNmUDTBHFqtGZ7mx5TsisJSVS66ZcUOD9RcvaDa7zVMv/tm3KdFHS
         ubnLxFXXcYZbeX0ecV02Aih0Zt4uL6kGnR9/iJIMl68wlbHUOUBSv/lqlz6GMJI9Bs6Z
         9HtdkTbVpdt8YSR1igdpUxnXV+71hy40Vti7n4m9zO6KEkoW5ciTkc6tS680RY2dkMoq
         SXenItf+IqduHxK1M8etMvvGnnmU8Q7fTBsxydhRXmIuc+Le5P7MJYHcZccqO2eVbVHO
         15mg==
X-Forwarded-Encrypted: i=1; AJvYcCUGwq9fS+QSRnwcGQdiraJYkw+0enEC4oQn7Zkp4xa6L5SwiL8LylJpF+kK80s33RZig34ZeO5hZTvM5sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4CH9E/AUt5+D54BQ6y7jfivGsJRMGTyaPNekoupnE+StFSEM
	d0N9WiVL/KEYTG2wbP1Ehxubc1UfINl2Tj2h41HZXTdww4doo/4pKfrGFsJsn3DLaoGYoptYXaH
	w5I1DdZJJCI4v6EUIRW+dFKVJ1p8Mwj+aQhD2oyLH
X-Gm-Gg: ASbGncu29PanFoYTwEytV6Gt7DiKKcDQA+gJuAnsI85cukjKsyEXNn+LdiiAH9r/O1C
	+6/5XkaraOb38OVp6Ln8MeisKjkClwai+ECcU61XThyT8l8oL2mGuDH8Cnb3d0YGgF1i1ALcKrz
	yQvv7tw6jTVFNCWigW55CO6PTwKoSzxvqzNkuNajj1cp3Ei/ajjq0IqVQ9erRuzzTnCFI3Dlz+1
	MS/KWSok409LuuZEhgJ/thaSiOuDX1yrgUo3BWT/RU/9Rc=
X-Google-Smtp-Source: AGHT+IFDKsOfNVeujTT3ep/sGHvnByYBZ/JoScmRAGpHffWGDkBCsAMududAym2fsPhHWFP4OlU0YkU4mCSedHl/Eag=
X-Received: by 2002:a17:902:e88f:b0:240:5c75:4d29 with SMTP id
 d9443c01a7336-244588884e5mr2748565ad.0.1755149500742; Wed, 13 Aug 2025
 22:31:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807093950.4395-1-yan.y.zhao@intel.com> <20250807094616.4776-1-yan.y.zhao@intel.com>
In-Reply-To: <20250807094616.4776-1-yan.y.zhao@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 13 Aug 2025 22:31:27 -0700
X-Gm-Features: Ac12FXx7HXi6s_U8y98YfVtv8jGpTEPlMpBsLrxhxzqCYXdQ9oJQT1rAHK3Q8sE
Message-ID: <CAGtprH8a4i-U-4Z6=Bk87FsC2nG+UbTVWB1Sc8oYXMJs7pHUwA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 22/23] KVM: TDX: Handle Dynamic PAMT on page split
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, x86@kernel.org, rick.p.edgecombe@intel.com, 
	dave.hansen@intel.com, kas@kernel.org, tabba@google.com, 
	ackerleytng@google.com, quic_eberman@quicinc.com, michael.roth@amd.com, 
	david@redhat.com, vbabka@suse.cz, thomas.lendacky@amd.com, pgonda@google.com, 
	zhiquan1.li@intel.com, fan.du@intel.com, jun.miao@intel.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, xiaoyao.li@intel.com, 
	binbin.wu@linux.intel.com, chao.p.peng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 2:46=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> wrot=
e:
>
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> +static struct page *tdx_alloc_pamt_page_split(void *data)
> +{
> +       struct kvm *kvm =3D data;
> +       void *p;
> +
> +       p =3D kvm_mmu_memory_cache_alloc(&kvm->arch.pamt_page_cache);
> +       return virt_to_page(p);
> +}
> +
>  static int tdx_spte_demote_private_spte(struct kvm *kvm, gfn_t gfn,
> -                                       enum pg_level level, struct page =
*page)
> +                                       enum pg_level level, struct page =
*page,
> +                                       kvm_pfn_t pfn_for_gfn)
>  {
>         int tdx_level =3D pg_level_to_tdx_sept_level(level);
> +       hpa_t hpa =3D pfn_to_hpa(pfn_for_gfn);
>         struct kvm_tdx *kvm_tdx =3D to_kvm_tdx(kvm);
>         gpa_t gpa =3D gfn_to_gpa(gfn);
>         u64 err, entry, level_state;
> +       LIST_HEAD(pamt_pages);
> +
> +       tdx_pamt_get(page, PG_LEVEL_4K, tdx_alloc_pamt_page_split, kvm);

This invocation needs a return value check.

> +       tdx_alloc_pamt_pages(&pamt_pages, tdx_alloc_pamt_page_split, kvm)=
;

IIUC tdx_pamt_get() will result in pamt_pages allocation above, so
this step is not needed.

>
>         err =3D tdh_mem_page_demote(&kvm_tdx->td, gpa, tdx_level, page,
> -                                 NULL, &entry, &level_state);
> +                                 &pamt_pages, &entry, &level_state);
>
>         if (unlikely(tdx_operand_busy(err))) {
>                 tdx_no_vcpus_enter_start(kvm);
>                 err =3D tdh_mem_page_demote(&kvm_tdx->td, gpa, tdx_level,=
 page,
> -                                         NULL, &entry, &level_state);
> +                                         &pamt_pages, &entry, &level_sta=
te);
>                 tdx_no_vcpus_enter_stop(kvm);
>         }
>
>         if (KVM_BUG_ON(err, kvm)) {
> +               tdx_free_pamt_pages(&pamt_pages);

If tdx_alloc_pamt_pages() is not needed then this can be dropped as well.

> +               tdx_pamt_put(page, PG_LEVEL_4K);
>                 pr_tdx_error_2(TDH_MEM_PAGE_DEMOTE, err, entry, level_sta=
te);
>                 return -EIO;
>         }
> +
> +       if (tdx_supports_dynamic_pamt(tdx_sysinfo))
> +               atomic_set(tdx_get_pamt_refcount(hpa), PTRS_PER_PMD);

Should this be
atomic_set(tdx_get_pamt_refcount(hpa), PTRS_PER_PMD -1 );

as tdx_pamt_get would have increased the refcount by 1 already above?

