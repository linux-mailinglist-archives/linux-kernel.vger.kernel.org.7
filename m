Return-Path: <linux-kernel+bounces-720161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A52AFB7DB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC273B54E3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0481E22FC;
	Mon,  7 Jul 2025 15:47:37 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A8242A99
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903256; cv=none; b=W8cr3s2ZSo1XbNb3PlRBBB4Oz2KKr8q6DHMLJQASUAFHR7KQxPyLhLwUk0dNFvhnbHn48+7btrabv/ytDk5JtYiZh8yl5pcbxRCIFuUYmEizEkkl4Io7k718FXt16t+jVTNYORszcwZyoKyGJNJ6kH2+0jkX0eJBGSG6LYuYJHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903256; c=relaxed/simple;
	bh=CZuAQ9diVZDmt3+ZqSs5UaeNeVFfqrgNCWnyCkmtNhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u72xqKnjyhWoyXlTsHsAhvHMC27Smhelcr/eMFJpUiVxNgZ64QqXoX6+FW82kTUMx9G6WMKz37ACs69DUpS92KUAm8Ioq5bo3wCuWDik7gQyrsd9gYI1KZVU4Z5rdpIuX/FRJfy+PCrTpdktuKqj33s4XRQbDCghl43Y6ePdGJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-52d9a275c27so3752776e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 08:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903254; x=1752508054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWAje+TfHCruGybMEHfBY+8ZUpO/up4oHuhPw5vp5fE=;
        b=f37C9FASwn99Nz7twqcaRc/xTqItgNv2PObw//zUoX+5E30G0Nup4LVUHekb88AQ/h
         CfLcjcvCanCNGW+b2wZmN29mtyX5Enp0sgZRfDRMrB0edhToBQuLBjCkJuj/5zq3NUZM
         EMzt+0KkFOcCuxroMOtqMMG4BN2dk0LxQtrOlPIGs9SfWhWjh2K1ynua2Doijcl5z2qI
         G2QMJZMp2ts/76dhC80F1Mz7P1z2ufjRlPU3EMW3MDo2ONrndhICvHxaBdyL56T+VNuh
         Rodem67rjXzKRvp5ykG7NqZQUOd7IlMiIRTbdorS3SS7EzJ4y0Ics5SoFVn0bJfnN79i
         6wJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyjo7h4Kqldx6fC4Tb+s8Ti6BydDDLvHErKq1veWSVTYBOqg8eLOt7d1WFBjXzsEakZ/DJbDH2WAzDurI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ8W9MBR4p/6kqVlf7qNvxFxdF52C6xQDRh1mMRWNa0Jsp5JBI
	5qVgmaAiKF5+ewZjabiNukepUCyDJIB9KFOLi6sHq8iROzLtLoAtc04sMzNNlCSnpSolm7iBaM0
	17l5DRGUnT3AbaG/goT+z/rWKImlgKb0=
X-Gm-Gg: ASbGnctg3adL7V/ex4aWNmr26DCehk13kxjd1D1AVqHSEVB01NSY3iw1TtZEgiAAF6Y
	UXGe1MJJZrnNwDU/wuSU0UoL6H0qCHxT1hfSUlxdaXPQW3+WWlqF253SHjqYS2sJRPhqArNfa4x
	LSXDOxDxopSBrwTM2kjBDmi94ViX1s3563wlQIAJ7Wxp/GLwqUq3KJ/wQ=
X-Google-Smtp-Source: AGHT+IE833j0/lVpKZX+KPtFSePtF4+1IEDQqHjPEGgdCfGk57QwMgoGEUubWqc2Jv3YYoVViwTUp5SCjjobcj2Tpyc=
X-Received: by 2002:a05:6122:660c:b0:530:5308:42ec with SMTP id
 71dfb90a1353d-5347e7545e7mr7554655e0c.8.1751903254221; Mon, 07 Jul 2025
 08:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <440940e78aeb7430c5cc8b6d2088ae98265b9809.1751599072.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <440940e78aeb7430c5cc8b6d2088ae98265b9809.1751599072.git.baolin.wang@linux.alibaba.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 7 Jul 2025 23:47:21 +0800
X-Gm-Features: Ac12FXx8oWQdUphdbM5vEIm5WcLCzobffFJgLPPrNw0K1ckpoEsbg-1aB-8khwM
Message-ID: <CAGsJ_4w1Ag5K3uy1+hBXt8cEvMcaGyC-w-th8h3cspEbwUwZXg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: fault in complete folios instead of individual
 pages for tmpfs
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com, 
	ziy@nvidia.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 11:19=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs"=
),
> tmpfs can also support large folio allocation (not just PMD-sized large
> folios).
>
> However, when accessing tmpfs via mmap(), although tmpfs supports large f=
olios,
> we still establish mappings at the base page granularity, which is unreas=
onable.
>
> We can map multiple consecutive pages of a tmpfs folios at once according=
 to
> the size of the large folio. On one hand, this can reduce the overhead of=
 page
> faults; on the other hand, it can leverage hardware architecture optimiza=
tions
> to reduce TLB misses, such as contiguous PTEs on the ARM architecture.
>
> Moreover, tmpfs mount will use the 'huge=3D' option to control large foli=
o
> allocation explicitly. So it can be understood that the process's RSS sta=
tistics
> might increase, and I think this will not cause any obvious effects for u=
sers.
>
> Performance test:
> I created a 1G tmpfs file, populated with 64K large folios, and write-acc=
essed it
> sequentially via mmap(). I observed a significant performance improvement=
:
>
> Before the patch:
> real    0m0.158s
> user    0m0.008s
> sys     0m0.150s
>
> After the patch:
> real    0m0.021s
> user    0m0.004s
> sys     0m0.017s
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
> Changes from v1:
>  - Drop the unnecessary IS_ALIGNED() check, per David.
>  - Update the commit message, per David.
> ---
>  mm/memory.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 0f9b32a20e5b..9944380e947d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5383,10 +5383,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>
>         /*
>          * Using per-page fault to maintain the uffd semantics, and same
> -        * approach also applies to non-anonymous-shmem faults to avoid
> +        * approach also applies to non shmem/tmpfs faults to avoid
>          * inflating the RSS of the process.
>          */
> -       if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma)) |=
|
> +       if (!vma_is_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
>             unlikely(needs_fallback)) {
>                 nr_pages =3D 1;
>         } else if (nr_pages > 1) {
> --
> 2.43.5
>
>

