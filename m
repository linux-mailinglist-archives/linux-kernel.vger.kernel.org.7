Return-Path: <linux-kernel+bounces-738511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24411B0B960
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 01:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CADA3BB5F4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 23:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1302522FF39;
	Sun, 20 Jul 2025 23:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLOzNG3x"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE19D22DFB6
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 23:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753055093; cv=none; b=r/v4oYUNYx2UeB/2WfUY6UAedD/pJ8+0mAYzsQHTXn5CZpeDYbChYtM7kH9vHq09UcqD7U3y87cCys7XmodkMiOIAAMwgN29so68ZTVqtQntPZSiOV6KWvRLds58opCwU1/U6OaGOTQLY3iythUZhcdCgQ2bVaHTrErJFJdwAwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753055093; c=relaxed/simple;
	bh=haICpv4Afyf85vccFf6Ukv9WsiT2YS4eV/97AVxjxEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPQhTa8urWbwUAwGfBHfOf2wr3WTF+CRNIyJ+sEJMyxXxFmn9m/kijL2vhmOolDSndtUIJo29vU++ja5CgFOra/fQchP4HllhGhH6Visrgi7DnYzqKp0a+8E116JIblmyXcLJyc/rnfgJglZfDNqasBrW++wRZvWTPtli7fXYec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLOzNG3x; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-87f1b3a3e7bso1957742241.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 16:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753055090; x=1753659890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LBnzd3v/hpHhCUNhojeHVoFejEzEwc/Hd5UG60oSVY=;
        b=LLOzNG3x1p843Z9Gx7VVToi+gFMwYniU0lC0lhJ1a79HRuwF7YE/l+pEXV3n8tAivm
         sl8qbLNn85cibshgikMSn4jmzdTaMBymYRFnPDK06Qcm4c1kUzfcUWmw45NHb/guNomS
         JFudo/Hoe3QCjOFh63edPVJSBBlanjhyH+SRoh5xhjGF8czZvgTRbBbLI6q1FkaOlkYS
         9NBWrT/InGRMJJ0XU3TcLbhAx5NWW40ZC0kfACPQQXOqTqIrKuReM0kXdWZnS/iyr79C
         grsHu94eG4OSWvtfteaDA5MJPovvuUX9PgAlXb7lP3brYf9C9BWCcyXTxQAsIxf5FbFG
         FqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753055090; x=1753659890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LBnzd3v/hpHhCUNhojeHVoFejEzEwc/Hd5UG60oSVY=;
        b=C8btvqHO94Y+kYtiekVhxbRVuiKMlwHtdEtzU6KhzmduCMlGjosxSRbiijHKcr2leq
         mGpROPYbYQMZP+80IIC99cyNilNcZBW42GrdQg3+vBQ7UcYN+gMHszwsLgM8qihYfFr2
         4oIly9HaQNxdMmpxDfRG/9IN0yrBPkL1Bnw9l2HtozpduxaXGTdVkzx2zyAQ4W2iknq8
         iNslHHQke9Q9T2P3B0pmg1kJdkUd9bAdOPfXMKX9iigkMQTBkAfHpQb8yZx+ZtkY4DYO
         w+40+VIjWaUggHU4npNp7MRUdeV4/09P0A8u40ZyQ/7HJ460c16b8tM/1ddlSxnkQ6GI
         eStw==
X-Forwarded-Encrypted: i=1; AJvYcCX/MKmatGVDw1O2YORkJDH7lCNAuB1c0uHxbP/KtX/QlMZCgc2qhBDCqXGBCYRHH+vdxzMpxN1CzUDp+OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNzoGWS7r31Y+UuITl3isG2ky79/3kqns0PwDi3dWljIMN8f6e
	KYhB6Lm033P9F3qoaOaiqkF7OomabwU3U8p98LQPe+ks1dV9/0Q/MaC2mN9PHC0aufTXmbIIr1A
	mSytbyPxesFKxjyU/CIqNJSp1IPJzVJo=
X-Gm-Gg: ASbGncuEsTC//4y1fpGoYAMcDJAZ2q0cSn6UUfy4yyqs8L3fzGR7QL65jVIRbFtiMul
	PpSZJLu22xYZVnSA6Am2o3vVtOO4/bFAjVqujox6UYnH67PYhZt1onfCC7RnG/TbzKVMxXq4WRu
	X57CpP31IjmmwTgyBpMUuq/26BHfiSEy/tInhN0Z9BoR8+2rcgxBllq3R4gSXv8o1PDWT3RdJhU
	y6ZXT0=
X-Google-Smtp-Source: AGHT+IE5Iww1i00Pt12bS4PeAauPkTugTt4uJE2TsnwTnY38yNwpFQjV6A6pNGslKMdLzsjoyJUdyCljvCrlxmmznjI=
X-Received: by 2002:a05:6102:3f0c:b0:4cb:5d6c:9946 with SMTP id
 ada2fe7eead31-4f95f30463emr10103615137.10.1753055090526; Sun, 20 Jul 2025
 16:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718090244.21092-1-dev.jain@arm.com> <20250718090244.21092-2-dev.jain@arm.com>
In-Reply-To: <20250718090244.21092-2-dev.jain@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 21 Jul 2025 07:44:39 +0800
X-Gm-Features: Ac12FXzBjmVqmon0-2uZp6WT1U6OMbiYJHYosmIwhhkMAqnhdJDT2LExr2m1S2w
Message-ID: <CAGsJ_4y1rJ7Omv-8ADk-cZdkAA37bxOxaeM3-vpz1MMaT_G04A@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] mm: Refactor MM_CP_PROT_NUMA skipping case into
 new function
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com, 
	willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com, 
	anshuman.khandual@arm.com, peterx@redhat.com, joey.gouly@arm.com, 
	ioworker0@gmail.com, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, 
	christophe.leroy@csgroup.eu, yangyicong@hisilicon.com, 
	linux-arm-kernel@lists.infradead.org, hughd@google.com, 
	yang@os.amperecomputing.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 5:03=E2=80=AFPM Dev Jain <dev.jain@arm.com> wrote:
>
> Reduce indentation by refactoring the prot_numa case into a new function.
> No functional change intended.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  mm/mprotect.c | 101 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 55 insertions(+), 46 deletions(-)
>
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 88709c01177b..2a9c73bd0778 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -83,6 +83,59 @@ bool can_change_pte_writable(struct vm_area_struct *vm=
a, unsigned long addr,
>         return pte_dirty(pte);
>  }
>
> +static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long add=
r,
> +                          pte_t oldpte, pte_t *pte, int target_node)
> +{

[...]

> +       /*
> +        * Skip scanning top tier node if normal numa
> +        * balancing is disabled
> +        */
> +       if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) && topt=
ier)
> +               return true;
> +
> +       if (folio_use_access_time(folio))
> +               folio_xchg_access_time(folio, jiffies_to_msecs(jiffies));

Nit: I wonder if this should be moved elsewhere, since this isn't
actually about 'skipping', even though the function is named
`prot_numa_skip()`.

> +       return false;
> +}
> +

Thanks
Barry

