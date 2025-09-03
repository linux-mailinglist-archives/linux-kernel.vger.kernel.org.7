Return-Path: <linux-kernel+bounces-798855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2E1B423ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A9D176E9A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9B32153C1;
	Wed,  3 Sep 2025 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xuj7Vk+T"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26531C862D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910597; cv=none; b=cyFb3HokxY53BFF8vFh/2yqS63WUhj/S8Z6Os/zuNx/c03K+upZgit5G/zgbWN36Q+D+Yst7NpIdLosrSkgXqcz/I8743lNqQG9Hw7w5sQ0xFpqUb0csu32z1dtjcHgkpmvr8Snu2+Rgzu9MATr02aygWBIL4AawujDQIrMy8Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910597; c=relaxed/simple;
	bh=WGwaaiEgG2uJ739eo0IvB2a3tBMnpx7x96amjNxXmdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4fXzmrWG8+iG/BMYfB8xAc4IX4WUfvsEe6zXCCZ7FtLyg3w8oiilcNrVSeZndZ5ghQA+VD9rRLZogs9uj2S7wh4NS7Kl8FnT4SClN16ITfBM0qCzGrXsOWDYi7fPiRvOSReSMz48Tj82eMjpZF9AOkoAgB6taECoQraXI78Wp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xuj7Vk+T; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61cfbb21fd1so12094a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756910594; x=1757515394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGwaaiEgG2uJ739eo0IvB2a3tBMnpx7x96amjNxXmdE=;
        b=xuj7Vk+TjcVRJ6F0rQrm1fqYFBC46laDaewvEfS9gbWn+dgnPJUWDJpzjzBIaZ+60p
         EfEHhOcglYwpsKAAs+785auNpzqRfCG0nKkFEBHAuflUIDCpsX/FElcYsWH9z48GdJRP
         UTmpreDoAJSgo7HhbzkBhA0WO4WXsbMreirmq2bGOcVxNrA0A7To+gKxXy6yfmiq3Uet
         Ubit4eYPgsOrpF8Lu2h0QvAcmm/5VKwx6j/iIqaKJnSO4eRCQDvt0Ekc3rDvGZx0bI6u
         Rp0JR62EocWP0G41By8h5ZSdBG5vuDanOnGn6S9pc0+KDlngIjxzrPgGLK9ZBKSYdyz4
         ge1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756910594; x=1757515394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGwaaiEgG2uJ739eo0IvB2a3tBMnpx7x96amjNxXmdE=;
        b=reOqNxfeBJtKmk4XyymPWQFJokGh0pkQwte69VT23nL793AzTyrog9D0sBN6cZqNpu
         NHYkf54RIMAj5+cUc3qAl7rJqgCfjEE1sjbDsSH7PYeNU+EfapxpgXtHold1UfQ5NPlo
         sZUqt5A8oH5fixnebEhd5YSFSSu4h5SvU3eGPYzl9CwCR6ZbVICR0smPCGFanNBBEE3I
         Wb08QUW2QJrpMJvX+eS+Y9GVSEATt+YXODQWkA3n4uQZ77ox4oe1KGU3JRZkp+7aMDQx
         48P39bc/7ArLo3tA8oWJdqVNnZjKF73D7Ytmi2Gv1N+yhd5pG6rAa7iffO31vKBhbEAV
         XOVA==
X-Forwarded-Encrypted: i=1; AJvYcCXR7b5tOdGdan5tPbxz3A+p7WMFM7WKDQICY7ZpF+rUEqkZVswOIEAH2B3GUWOhcgga2RCX+2gr2mXZx+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyknYk4tQBfoEgJI2jTH8RO1yUXrSSowYU6MPIPDmMYh3FHcqaT
	ruWpEmfBUsrIEN15GbQmvkGsiAByNAVPStYrwwP5K4BznNQ0SAueTU59XMeRHYWCff7mvebn/R3
	73CPftnGvQPDt41B/9iCA6Ceg175Z9Clnmup7LOBj
X-Gm-Gg: ASbGncuf+CKbB30cqBLZw7+MjJlMHjoZaHHfOgtPa5S67XtEcPf+taMiHyrecpi4MsE
	cMuRKyQFIYsUle6f0pWgIYtHzjcBNG68r2oPmOZUog4vs8qmSuvreU0y2KgVM4haxbNnq4y8kzJ
	QIjKffVubDR6DM7LKXW+ORWMKV4n5MOxNBnoSOk2CcZb7CTrKzqDYTdYLDTILVJvb2RaFkkqs9v
	xvaRJZ/BkCcS2oN21sU6Fj5m4CP1rbwHqxctfN0mj06Qeo0Hwpl
X-Google-Smtp-Source: AGHT+IETLxUe+4k2b4K1IWMHfq+S9CNpDio0ukz77dfuuxwdkY0trZdeCTyAjWWcWxymJkgDSATXOOwKKAuH67K7jyM=
X-Received: by 2002:a05:6402:11d1:b0:61e:c5d1:5d4b with SMTP id
 4fb4d7f45d1cf-61ec5d15e4dmr191325a12.2.1756910593673; Wed, 03 Sep 2025
 07:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226030129.530345-1-riel@surriel.com> <20250226030129.530345-2-riel@surriel.com>
 <aLcQ3UCXXNcByW1O@gcabiddu-mobl.ger.corp.intel.com> <CAG48ez1q_Sgk5nr7Bngyt0UB3FkYb6e0cHv18wqD=sLEdrZkmw@mail.gmail.com>
 <920DC212-880C-4688-A577-2589CABEED75@gmail.com>
In-Reply-To: <920DC212-880C-4688-A577-2589CABEED75@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 3 Sep 2025 16:42:37 +0200
X-Gm-Features: Ac12FXzU2aeQNhD7RbGeHx_UXqP-ts1SYeO5NRICDK9MHW-Hu7SIMmM_qY13dsU
Message-ID: <CAG48ez27-HYHoorKU00xByDa9mu1Vnuh4yjE3sr+6z6ATKnzSA@mail.gmail.com>
Subject: Re: [BUG] x86/mm: regression after 4a02ed8e1cc3
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Rik van Riel <riel@surriel.com>, 
	"the arch/x86 maintainers" <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Borislav Petkov <bp@alien8.de>, peterz@infradead.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, zhengqi.arch@bytedance.com, 
	thomas.lendacky@amd.com, kernel-team@meta.com, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, jackmanb@google.com, 
	mhklinux@outlook.com, andrew.cooper3@citrix.com, Manali.Shukla@amd.com, 
	Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@intel.com>, baolu.lu@intel.com, 
	david.guckian@intel.com, damian.muszynski@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 4:18=E2=80=AFPM Nadav Amit <nadav.amit@gmail.com> wr=
ote:
> > On 2 Sep 2025, at 19:05, Jann Horn <jannh@google.com> wrote:
> > On x86, IOMMU flushes happen from arch_tlbbatch_add_pending() and
> > flush_tlb_mm_range(); the IOMMU folks might know better, but as far as
> > I know, there is nothing that elides IOMMU flushes depending on the
> > state of X86-internal flush generation tracking or such.
> >
> > To me this looks like a change that is correct but makes it easier to
> > hit IOMMU flushing issues in other places.
>
> This change is not correct. Do not reference info after calling
> put_flush_tlb_info().

To be clear, I worded that very confusingly, I meant that Rik's commit
4a02ed8e1cc3 looks correct to me.

