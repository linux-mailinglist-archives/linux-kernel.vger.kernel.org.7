Return-Path: <linux-kernel+bounces-743215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2489BB0FC04
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EEF04E0FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004342586EA;
	Wed, 23 Jul 2025 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWmsSVtM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706921E7C1C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753305242; cv=none; b=aERtNMeM9N36sSH1OmVEI0LRJ2lLHHc5eDPfaBmc8Uw0W7e4PR5gSYblVGf4ExwN/NszOMqNk3MfV73NxUdSc+ZaawLam7UQnCAH2zTHRMqJ9Mv3arEsHkxAngrnIA6rrgHO5bDoLE1xL38ggZ4w75mNcaD6g3xvMnpYcSzqolA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753305242; c=relaxed/simple;
	bh=w8IGsQxBfxh3nbHiAy+GRvDG7bpNglYahwAaEeLwQQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5c9riP/lPCw/B87PBujBpmhguSZRZBq0a4Yd1m08LUekYE3xy5iMnYqkSvxPWCr1S4kFSTanRc04w8FUglzeu8xZRG+RPKij9JYF3CFos7Gzdd9mnZN6fUdiNepahSvJGU7woDc+SReNLX1posH0kPRlrmdAz/OB2S+Nx8uAns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UWmsSVtM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753305239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KEFFKCC6CirY6Qu+LFOWn/4wjxHopYc9Cu/eHLmtLrk=;
	b=UWmsSVtMTjyVDXMa0TKoOm/8we+PvdI57HvYwhjApAB2RiDlgQX5kzL7G4Io4SCyDhBOoR
	bCEUWuj4q26sbaPh88P1pyhn8KDWeo7TEo5PzfRdgJ/tIsJQQYWsTnviGTO3maUASC9Ys8
	7nMGdpbAxTq4Ejnh6gGKUaqbcR4Hhhc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-2I-nRuTrNTms_MNzp7xiEQ-1; Wed, 23 Jul 2025 17:13:58 -0400
X-MC-Unique: 2I-nRuTrNTms_MNzp7xiEQ-1
X-Mimecast-MFC-AGG-ID: 2I-nRuTrNTms_MNzp7xiEQ_1753305237
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-70e86a2a1b8so6483127b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753305237; x=1753910037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEFFKCC6CirY6Qu+LFOWn/4wjxHopYc9Cu/eHLmtLrk=;
        b=RP7X6zQZNz7EWzs0mfp2gh8sFGDwoABZv0pl15AXJXng8ten/tJTbiDcmxj4SaW6jF
         oED3EIRNi7Z1ty3qvZD0NFi4eucWfJDEMWVi5GvQS1evX/zpGgigPGpr/zycijuRWo8E
         sZcim/KvyJau3zYQaXvGZa0SdRfbEuwv5FnBZ8UVTs4A7SqWPN/rAuS22cJuWNwYfG6C
         BTbiui5jhkd4HCJV9sJSoH4CzS36fvCKPafDq5tfUNWW7aEZcBf4kesxYe3+SsibkZBo
         SJ5kerFZ8PoVKeebpxTj7e0TOtwREMD9zu9l7dlbUwUbe6gvNYzNSyoXTk7njTFbq843
         VoSA==
X-Forwarded-Encrypted: i=1; AJvYcCVC+HVFFynVGtBq66YJO7eOnVyw5ZFddOe+Xx8tzCEYg+jh7Z+NJWyLL3ZoSKhaSJXMFbjg8NPcpJISZvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmTh976Unlrc18P8zmOAR1cFM2qfrDQSIqvR8AjQ3RP4fj5sQ5
	JfVWR93CtHYHAyjy6mKrDryF4HyQ/hg/w6Z0tL7pGfOba6wKmwOnN/dLZ8+EW7dmbDhZUGljpO+
	mc3ONn1H2efS/mPpIyJP3lB6nL2r6n76dKP/2C2zHuH99kY9hAdahADUjbIyqF2E4TlDTgdJPZh
	hOwtK8XH9ROQuBN3jg5+vhaRF7KkWMTIDFWGqEBD1KRzVM2+ayVgA=
X-Gm-Gg: ASbGnct4XcO1mdjORTXbtm3A9L99Niwte4sgmLdsLq67IqRe5WXzqKO+9iGJX8QLUuI
	sGCSMgmhHG1oInDUPKiv/oA7yLLvdpsA6QSslz7Yd55hwSs82mbvc4XAjzOUjSIG8xrtaoD9Gf9
	Ujq/w0fi815y5as4MydA9Gc4g=
X-Received: by 2002:a05:690c:600c:b0:710:f39f:a2bc with SMTP id 00721157ae682-719b4208ab4mr60589787b3.8.1753305236961;
        Wed, 23 Jul 2025 14:13:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHKu4d3onHAb7X8LWAPu0O+WUZ/aYhsMpnRlh9HgSTUlujJWY4TnCn/IV7CVGxpS2q71+P/Xaq3BIZIvRa+hU=
X-Received: by 2002:a05:690c:600c:b0:710:f39f:a2bc with SMTP id
 00721157ae682-719b4208ab4mr60589447b3.8.1753305236584; Wed, 23 Jul 2025
 14:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704040417.63826-1-dev.jain@arm.com>
In-Reply-To: <20250704040417.63826-1-dev.jain@arm.com>
From: Nico Pache <npache@redhat.com>
Date: Wed, 23 Jul 2025 15:13:30 -0600
X-Gm-Features: Ac12FXwzjaonSZ_XBVSayzqL2leWBYkEuOCfl6SDlX5nA8rmqz_ZykeRteEcbLw
Message-ID: <CAA1CXcD2fRc-apfDi2UtQ-cvDwazxOu+bAVnKvVj2rgwdHedsA@mail.gmail.com>
Subject: Re: [PATCH v3] khugepaged: Reduce race probability between migration
 and khugepaged
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, baohua@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Oscar Salvador <osalvador@suse.de>, Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 10:04=E2=80=AFPM Dev Jain <dev.jain@arm.com> wrote:
>
> Suppose a folio is under migration, and khugepaged is also trying to
> collapse it. collapse_pte_mapped_thp() will retrieve the folio from the
> page cache via filemap_lock_folio(), thus taking a reference on the folio
> and sleeping on the folio lock, since the lock is held by the migration
> path. Migration will then fail in
> __folio_migrate_mapping -> folio_ref_freeze. Reduce the probability of
> such a race happening (leading to migration failure) by bailing out
> if we detect a PMD is marked with a migration entry.
>
> This fixes the migration-shared-anon-thp testcase failure on Apple M3.
>
> Note that, this is not a "fix" since it only reduces the chance of
> interference of khugepaged with migration, wherein both the kernel
> functionalities are deemed "best-effort".
>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

LGTM! This is a nice check to have here :)

Reviewed-by: Nico Pache <npache@redhat.com>
> ---
>
> v2->v3:
>  - Improve comment (David)
>
> v1->v2:
>  - Remove SCAN_PMD_MIGRATION, merge into SCAN_PMD_MAPPED (David, Anshuman=
)
>  - Add a comment (Lorenzo)
>
> v1:
>  - https://lore.kernel.org/all/20250630044837.4675-1-dev.jain@arm.com/
>
>  mm/khugepaged.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 1aa7ca67c756..a55fb1dcd224 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -941,6 +941,14 @@ static inline int check_pmd_state(pmd_t *pmd)
>
>         if (pmd_none(pmde))
>                 return SCAN_PMD_NONE;
> +
> +       /*
> +        * The folio may be under migration when khugepaged is trying to
> +        * collapse it. Migration success or failure will eventually end
> +        * up with a present PMD mapping a folio again.
> +        */
> +       if (is_pmd_migration_entry(pmde))
> +               return SCAN_PMD_MAPPED;
>         if (!pmd_present(pmde))
>                 return SCAN_PMD_NULL;
>         if (pmd_trans_huge(pmde))
> --
> 2.30.2
>


