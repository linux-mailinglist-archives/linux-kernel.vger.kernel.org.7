Return-Path: <linux-kernel+bounces-889871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B70B1C3EBC3
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 627C234B0E1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9708726462E;
	Fri,  7 Nov 2025 07:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqMuzZ4g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EA72D063C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500377; cv=none; b=d4ZmO/dPrgc5OV3LwfdPRVfluDVDR9oSmVM1I3SuDwxcFqD6wsL3zjyb2MgSqE3LGoYinmBAnA3W0pSJ7mMRvlN2z8q6yqjeiw6o3k8V8jtuAYO89M+LikbmJPERBiIYjOOT3Lo4PM6RQ2sNBbXQ6bWjGyj6qrxGUeGy0gKp9d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500377; c=relaxed/simple;
	bh=NTCkAr7CCC3V4KXMLky1Q53LUYY+hgHt+cfzOEtykj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9jraKjcSrZ518Ap1Sgspbq74SmpmYBtn5gJtxNjetZXLfqsoYuGLp79zlvF41XwmGSI/klUG9sSsXvA1WyGeUCXBZG5qOX3RJDmonZucmDth7I4+XYzaYFcb2sejf2h+ZXjyrAdcgxjEMifRnwFDqxWYg46DK2TkozIAF5sWPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqMuzZ4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8981EC4AF0D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762500376;
	bh=NTCkAr7CCC3V4KXMLky1Q53LUYY+hgHt+cfzOEtykj0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WqMuzZ4gSWWpeASCfXcfQn/L1aWYNWsMeRDGJ6o/GnRbOI4pvQyUCv4SspE5NrYMQ
	 1Sw/ZVg1dJs85BvWl93R90pggeOOaQp+KT+P8/MXixM17BaRa7fuoIzfFdTTB0QqB4
	 1XHSsKjU7asRJCfMgVFwNu7opcaFBChpt1rRfTYgYYaVVh2npN4LVhrOXweKCwq79s
	 Zyb9gXNNVHcdB5iA9MAhBc1sbOvrcoIjfDq09iC4dV3aFtPebKEt60bxvHsxnMVywM
	 4HcQWAtRRdh1cTAPsj4lurIB7ca8EvW8hbDQuY7Pd/FqOz1y1/Qo+Kcj9dLHFBmyep
	 VhxAub5fBRyww==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b726997b121so68278066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 23:26:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfVuVJumt72jX5wv9XOWhN7g3TSF7cdcMvj459df/521X8Qa3TGOirDtNua2jN+HOCrm24FWIzCsTfPpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsIXer0s/4tOzbQujy9B/a7Gkckj3jM/rcnrH7lp4xe7j1VePa
	f5keh0HhydWcG65CTlvZBD6s43tiiiN5nMdfMI8nn69rjGqBc4RSxfzUQ2AzC/k5hk8GTAXyto1
	81sQ03UyDvhaIX1VGhK7bgScN4A9cIGM=
X-Google-Smtp-Source: AGHT+IH1D3L7YSycRpWTDk4GBHk+/sA91OgbnjSfYLSPp6w9J3OvGmeptBOdkhYe4F1fk1Hq1SP5no/0if72Xe9b+3Q=
X-Received: by 2002:a17:907:9489:b0:b4a:e7c9:84c1 with SMTP id
 a640c23a62f3a-b72d08e8bbfmr86879466b.7.1762500375178; Thu, 06 Nov 2025
 23:26:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107035805.3094024-1-zhangtianyang@loongson.cn>
In-Reply-To: <20251107035805.3094024-1-zhangtianyang@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 7 Nov 2025 15:26:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6CyWCqgp_x1OQ0o_UPKeom1CoLgkebwEOPPHS=KGfHmw@mail.gmail.com>
X-Gm-Features: AWmQ_bkg92nWYYDP41MKJNq77vdxVMVUjuudLq9Q2Awhp9wZxCUZayTgvOP8lC4
Message-ID: <CAAhV-H6CyWCqgp_x1OQ0o_UPKeom1CoLgkebwEOPPHS=KGfHmw@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Let {pte,pmd}_modify() record the status of _PAGE_DIRTY
To: Tianyang Zhang <zhangtianyang@loongson.cn>
Cc: kernel@xen0n.name, akpm@linux-foundation.org, willy@infradead.org, 
	david@redhat.com, linmag7@gmail.com, thuth@redhat.com, maobibo@loongson.cn, 
	apopple@nvidia.com, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Liupu Wang <wangliupu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Fri, Nov 7, 2025 at 11:58=E2=80=AFAM Tianyang Zhang
<zhangtianyang@loongson.cn> wrote:
>
> Now, if the pte is dirty _PAGE_DIRTY but without _PAGE_MODIFIED, after
> pte_modify() we lose _PAGE_DIRTY, then pte_dirty() returns false. So
> we need _PAGE_MODIFIED to record _PAGE_DIRTY here.
>
> The new modification involves checking whether the original PTE has the
> _PAGE_DIRTY flag. If it exists, the _PAGE_MODIFIED bit is set, ensuring
> that the pte_dirty interface can return accurate information.
>
> Co-developed-by: Liupu Wang <wangliupu@loongson.cn>
> Signed-off-by: Liupu Wang <wangliupu@loongson.cn>
> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
> ---
>  arch/loongarch/include/asm/pgtable.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/includ=
e/asm/pgtable.h
> index bd128696e96d..e0b92fe850b3 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -424,6 +424,9 @@ static inline unsigned long pte_accessible(struct mm_=
struct *mm, pte_t a)
>
>  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  {
> +       if (pte_val(pte) & _PAGE_DIRTY)
> +               pte_val(pte) |=3D _PAGE_MODIFIED;
> +
>         return __pte((pte_val(pte) & _PAGE_CHG_MASK) |
>                      (pgprot_val(newprot) & ~_PAGE_CHG_MASK));
>  }
> @@ -547,6 +550,9 @@ static inline struct page *pmd_page(pmd_t pmd)
>
>  static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>  {
> +       if (pmd_val(pmd) & _PAGE_DIRTY)
> +               pmd_val(pmd) |=3D _PAGE_MODIFIED;
> +
>         pmd_val(pmd) =3D (pmd_val(pmd) & _HPAGE_CHG_MASK) |
>                                 (pgprot_val(newprot) & ~_HPAGE_CHG_MASK);
>         return pmd;
> --
> 2.41.0
>
>

