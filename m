Return-Path: <linux-kernel+bounces-721923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF7EAFCF82
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06641AA03C9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA65E2E1737;
	Tue,  8 Jul 2025 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9WpH0sk"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECA32E11AA
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989201; cv=none; b=TxnLq3QhdsTS24q06T1lvpe2M44YeOqNhiqoeLjjSujC3G9+JRNn2WRw1BFU9PE7krZpVpSctJtWC5b/WjU6mn0TEiATEEbOIa1h3OGed3Zy48tIGO2xh4Em4OpPGBRcxlCs79UXYJG7y7LguYCukW0KZFcex3n+cv3ZLcQ551o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989201; c=relaxed/simple;
	bh=/XygNlSmc7jYkBz+SlTl7nsjnFXuRu+7W/+6MamxwAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7yW1F2oBvVlagvPQb2DUcJhKPE9Tdv9kdZJFzKJvsKsh7zkqYk51GyjBYI2kQHhIAxX0ZrwTtObi2933HLogSZvXPsmGeJjJQJQHN+39S4yCmun3rzl4235o9xcEQDkbeaVvTfBtvnBiUlu3g6vgP0RqyTAEQYc/Ei6MP3rULE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t9WpH0sk; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a7fc24ed5cso353681cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751989198; x=1752593998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NLf7r1SqdhHC1Id+7p34mmn58G9MGm6E8awmU3gkNU=;
        b=t9WpH0skWYclKX5Yl1UOgukM5GgEpEvU3S/yqVps/ONLUw3/rxS3Od87fWbtPye8Qm
         9BHvthwfLNKxsBdQR+PVk3vfX22LPKexmmZPzogFKEc9JOzvi0Esy3DwZEmGyYBhyprh
         /m9r+4oFUzZsyJUxocchVvvEZxcQaFZFnI7rQDsD4EReeRpKvdydLFFGIs7XMW+eXZ44
         btwwv9AiF4deVZw1VNMtxp9Ik3fAn79ey9twhwquz7utyullspAWH11aWn8OoiJ9o4mK
         UgIcdIUW3IaXMsgtKPoAqnWKrtTfMAg+IwnxkTOWC7VN9hTL8ZaAZMV9cCT1T7DWZ0wo
         CylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751989198; x=1752593998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NLf7r1SqdhHC1Id+7p34mmn58G9MGm6E8awmU3gkNU=;
        b=duMTlL8V/vNA20J7dThXNTe5OMoQ4wjNvzfRp+3oliR/0QDZr4ZfFdj4OPjfzAxoqk
         bQjL6IHqyBLo/PNvMmHMIlcogulU8tovrUy1znBA/KFS1iTNeQrdgayOq3/2XzwuO5bp
         k6pAst4MClNd86iCYfTsHkn6Pq6tfZ4zk5PPmJIVoCQeZvgOrtxMltoE8P8Ek5tS8TlK
         0d9cuCHNxyRIMJH6/H7oCe7L3wmiIHBDI7LrGwBvGuqMzDrfaOR9QWBM0Tn3czf63BEX
         MJkesil54D9NqPfQSqp7euqJ5SxyLlk2LlQuKeWERAr/Tspnr9EkpKkLJw1QdEdEnIGG
         aGKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8uS0q5mC8BJYmlTfh9pF62CEmb++wSsKSV1uh8V5RTEWgMGWiZbI+aE1/l1W6ww+CD9fpVuk5yUPCCc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBcbW7ZisZj4JLLhe+RxREDZexICkOPi2NmemIBjXH+TJ1Yyop
	4gTkgFk4Chl1tvb5hTocZ/Dnw63dS9+/lZMLLgEcgfJ9qe8kRPx7NxlinxiZ1kXcPiBX4rots/M
	H9Mz/KkoUH99yNhY8NePEaTr9Ji3/NW3N6FCkAb1oJAkzTAXgK6sKO/YRHD0=
X-Gm-Gg: ASbGncvxzuhJm1LSQMbFJVfVN9TVrzbxAir9NNp7elmL82MW2O+OZ59jndYSAoepI9z
	ha940osSjTevxeSHtzMfs6pjZd6LfKe1cLILBd0UrYmiSl6pcioCNuzWh7Dwfg9C7cfGlKhCO9c
	RbP9Mi2VSkAW0LND1JL91JVs8wWa1wFYnbH5e805M6r2VcM/55wTWQjedDs+Os6GtYqX8YznZtH
	Q==
X-Google-Smtp-Source: AGHT+IHG8Emt+gyL8UvFNaFyi+O07zeBWkW+UVHfL/feE1C+ZTRqBaq0OQuwKFyF0Kg/LheKjk2b3XFv0JAoeL/sHwo=
X-Received: by 2002:a05:622a:8345:b0:4a9:c8bb:459 with SMTP id
 d75a77b69052e-4a9d48ee47fmr2280891cf.29.1751989198055; Tue, 08 Jul 2025
 08:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630031958.1225651-1-sashal@kernel.org> <20250630175746.e52af129fd2d88deecc25169@linux-foundation.org>
 <a4d8b292-154a-4d14-90e4-6c822acf1cfb@redhat.com> <aG06QBVeBJgluSqP@lappy>
In-Reply-To: <aG06QBVeBJgluSqP@lappy>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 8 Jul 2025 08:39:47 -0700
X-Gm-Features: Ac12FXxgax9QRUHgWfWnI6-7Cpsi0Gj1hqhyNry_hrJmcV9KjYxfNpCr2VuvWkY
Message-ID: <CAJuCfpH5NQBJMqs9U2VjyA_f6Fho2VAcQq=ORw-iW8qhVCDSuA@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: fix missing PTE unmap for non-migration entries
To: Sasha Levin <sashal@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com, 
	aarcange@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 8:33=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> On Tue, Jul 08, 2025 at 05:10:44PM +0200, David Hildenbrand wrote:
> >On 01.07.25 02:57, Andrew Morton wrote:
> >>On Sun, 29 Jun 2025 23:19:58 -0400 Sasha Levin <sashal@kernel.org> wrot=
e:
> >>
> >>>When handling non-swap entries in move_pages_pte(), the error handling
> >>>for entries that are NOT migration entries fails to unmap the page tab=
le
> >>>entries before jumping to the error handling label.
> >>>
> >>>This results in a kmap/kunmap imbalance which on CONFIG_HIGHPTE system=
s
> >>>triggers a WARNING in kunmap_local_indexed() because the kmap stack is
> >>>corrupted.
> >>>
> >>>Example call trace on ARM32 (CONFIG_HIGHPTE enabled):
> >>>   WARNING: CPU: 1 PID: 633 at mm/highmem.c:622 kunmap_local_indexed+0=
x178/0x17c
> >>>   Call trace:
> >>>     kunmap_local_indexed from move_pages+0x964/0x19f4
> >>>     move_pages from userfaultfd_ioctl+0x129c/0x2144
> >>>     userfaultfd_ioctl from sys_ioctl+0x558/0xd24
> >>>
> >>>The issue was introduced with the UFFDIO_MOVE feature but became more
> >>>frequent with the addition of guard pages (commit 7c53dfbdb024 ("mm: a=
dd
> >>>PTE_MARKER_GUARD PTE marker")) which made the non-migration entry code
> >>>path more commonly executed during userfaultfd operations.
> >>>
> >>>Fix this by ensuring PTEs are properly unmapped in all non-swap entry
> >>>paths before jumping to the error handling label, not just for migrati=
on
> >>>entries.
> >>
> >>I don't get it.
> >>
> >>>--- a/mm/userfaultfd.c
> >>>+++ b/mm/userfaultfd.c
> >>>@@ -1384,14 +1384,15 @@ static int move_pages_pte(struct mm_struct *mm=
, pmd_t *dst_pmd, pmd_t *src_pmd,
> >>>             entry =3D pte_to_swp_entry(orig_src_pte);
> >>>             if (non_swap_entry(entry)) {
> >>>+                    pte_unmap(src_pte);
> >>>+                    pte_unmap(dst_pte);
> >>>+                    src_pte =3D dst_pte =3D NULL;
> >>>                     if (is_migration_entry(entry)) {
> >>>-                            pte_unmap(src_pte);
> >>>-                            pte_unmap(dst_pte);
> >>>-                            src_pte =3D dst_pte =3D NULL;
> >>>                             migration_entry_wait(mm, src_pmd, src_add=
r);
> >>>                             err =3D -EAGAIN;
> >>>-                    } else
> >>>+                    } else {
> >>>                             err =3D -EFAULT;
> >>>+                    }
> >>>                     goto out;
> >>
> >>where we have
> >>
> >>out:
> >>      ...
> >>      if (dst_pte)
> >>              pte_unmap(dst_pte);
> >>      if (src_pte)
> >>              pte_unmap(src_pte);
> >
> >AI slop?
>
> Nah, this one is sadly all me :(
>
> I was trying to resolve some of the issues found with linus-next on
> LKFT, and misunderstood the code. Funny enough, I thought that the
> change above "fixed" it by making the warnings go away, but clearly is
> the wrong thing to do so I went back to the drawing table...
>
> If you're curious, here's the issue: https://qa-reports.linaro.org/lkft/s=
ashal-linus-next/build/v6.13-rc7-43418-g558c6dd4d863/testrun/29030370/suite=
/log-parser-test/test/exception-warning-cpu-pid-at-mmhighmem-kunmap_local_i=
ndexed/details/

Any way to symbolize that Call trace? I can't find build artefacts to
extract vmlinux image...

>
> --
> Thanks,
> Sasha

