Return-Path: <linux-kernel+bounces-843467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 909E5BBF8AC
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B22189D169
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359EB2D7386;
	Mon,  6 Oct 2025 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWC812KC"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30AC257AC2
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759784829; cv=none; b=QSOuYrbkI7rtDS1Jncmt4HJRHDEKKqEIEoFNhguZUyAXQStMedVIZgC9VE1IbOaCy08gu+HPkZ84iqDPRa5PitwuGIz9cuaPWo2mVrhgUHW16qvAW188ESmLBYO8/HnUEEaxhhI8PhPkKrnWrsHzpZJInj3483W7bxdt46dW934=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759784829; c=relaxed/simple;
	bh=wYCmKJc3tz/56/8AL6vA7yNzpeZ/DGVhrWPi6gymzBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GhgirHyw+R5zsSfTcN84ZpbykuMFdHGe9kIzy8ie67LgxKe8+SJ1jHJxK2jvrhHJPVwCYfZR9wQxq19JBKSukGySrXvx0wabOm/beyfHvZn2xzH4ZEBSMc+Y6i3ni+uauylLbDOLEziyTglr+lY3q9CeRLTYQ6SwzoiU6WwoqAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWC812KC; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-339c9bf3492so4390407a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 14:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759784826; x=1760389626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycCXn7HCBHZVIgihBYyqRnShLRsn7MlEdfR5jY2NQjs=;
        b=eWC812KCOrNMekgJ3DUgKq6vOC3JXUQLhLBJ2NFX7C4JiEod6QUCIbswVxxdjB+a1n
         ERmAAoHady2kT5gBBzwSkwtEo/GB3cKrcSNHlspMSixUTALm5cFYNjDrgFHwuCBXS4zu
         r9oZwJTU0O0XNejRr+cLqc+4CNMAJVyi4Srd0Z59EV97C/EASf0Xz0WjdhfwWG0OdBMC
         hpEIguYnvpd+1jDNytbxUjjW7hdFI6tciDjfGZ93Q3zO0cIvPde0PCAtbJC05AcEBNIO
         Nc+v04ZWzLuMrTgfdRbf8bfS0nMRe2mI+WFzSwEOPgDrKhQZbGlI1ZQRE/dL1c2Hsgzo
         L5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759784826; x=1760389626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycCXn7HCBHZVIgihBYyqRnShLRsn7MlEdfR5jY2NQjs=;
        b=uCxgSSNavnUrsb4wR6pnO15eRTFRUxMjGy7U3eTuvP89HD7BxMopaeDwHqFIk3tSft
         CRt1T3qlVberBDR0DIRG6L1w/rABdtuFBxcfypuTmPXlmXerrJy0hVftSy0IXsBRVB+y
         eCG9jWdGXL196DOsb1aCUNKtUYa9TWwvwtvdjOaaMAqaKS9UbdXT+BGpC1RfaH1D6Ieo
         ed4MPq7e589cwSmEfHTK9VbmuGrJ1ssNp+Gz+0253rPwhpUmPVb2GKDyy9KqVBxft+3r
         9y5DBsLhMyrVCKvYZn9RGEgOjLvMJqdwr9Xw71LUWY3r4XDFv1bEnYhT0Y0Q0TXK9KkE
         60iA==
X-Forwarded-Encrypted: i=1; AJvYcCWi7BNxx1AwfrdMDEludWBCUdE7akAUW8LUazTnj1d2niocd5iwr972shK6uiOoIL1XGY8iilS0hrDe/Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx71jH6QTseiDrSje20mUbiFcri2bnKgqAXQGpAD/BbBc37CyhC
	AsuX/yIXFApj923lWcqC1N6TtFomV/7bgVKfXK7c6iY7cGRT3FvJ1lylRx7neLBsx++yRAA4Wug
	GQecRnlvE/KOfPgcfB8ItuGBwjHr/aG8=
X-Gm-Gg: ASbGncvc3Wn8huWiUXcPuD0ImbiKZ5JAnzzwC/TanrTVKMpI8AOCWqorxhEjamNJl3Y
	fJPiYKMmFWnwgY7KaCrirddf0MXiymEsy66WpGcF/I9oa7L+OzCJBPfrFWeUTsO5BiIyWeoJ8Ze
	jCc3I7evprwlUMzlrFuJxCrEyAYC52hyzGpTdooY8FW50T6famqt/e8IgpMk0nhM+ID3gyjXQCD
	dgYDMZiYC3ML6eNpsfYPgCZu2sLannRjzjtaNrMO5HLqBw=
X-Google-Smtp-Source: AGHT+IFwvar+wsG4FBl5vSzTKtvzzcZSSsUwcJKm4NYVGJjyCTw+UOVFKL0QtUgf1sIodiucxXoPhufdjxE1FCU+EnA=
X-Received: by 2002:a17:90b:4d0b:b0:32e:43ae:e7e9 with SMTP id
 98e67ed59e1d1-339c27a50ffmr18199311a91.17.1759784826013; Mon, 06 Oct 2025
 14:07:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930055826.9810-1-laoar.shao@gmail.com> <20250930055826.9810-8-laoar.shao@gmail.com>
In-Reply-To: <20250930055826.9810-8-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Oct 2025 14:06:50 -0700
X-Gm-Features: AS18NWA5h_LyhLDePhUuadn5dRHPb5TmltG_t5VK7dL6TJb8Nc89-wJV0_TukYU
Message-ID: <CAEf4BzaGRDiW3fRt3i+7vvRB+oQszKjaLWVMSU6JrfmXHsJ45w@mail.gmail.com>
Subject: Re: [PATCH v9 mm-new 07/11] bpf: mark vma->vm_mm as __safe_trusted_or_null
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com, 
	rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, tj@kernel.org, lance.yang@linux.dev, 
	rdunlap@infradead.org, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 11:00=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> The vma->vm_mm might be NULL and it can be accessed outside of RCU. Thus,
> we can mark it as trusted_or_null. With this change, BPF helpers can safe=
ly
> access vma->vm_mm to retrieve the associated mm_struct from the VMA.
> Then we can make policy decision from the VMA.
>
> The "trusted" annotation enables direct access to vma->vm_mm within kfunc=
s
> marked with KF_TRUSTED_ARGS or KF_RCU, such as bpf_task_get_cgroup1() and
> bpf_task_under_cgroup(). Conversely, "null" enforcement requires all
> callsites using vma->vm_mm to perform NULL checks.
>
> The lsm selftest must be modified because it directly accesses vma->vm_mm
> without a NULL pointer check; otherwise it will break due to this
> change.
>
> For the VMA based THP policy, the use case is as follows,
>
>   @mm =3D @vma->vm_mm; // vm_area_struct::vm_mm is trusted or null
>   if (!@mm)
>       return;
>   bpf_rcu_read_lock(); // rcu lock must be held to dereference the owner
>   @owner =3D @mm->owner; // mm_struct::owner is rcu trusted or null
>   if (!@owner)
>     goto out;
>   @cgroup1 =3D bpf_task_get_cgroup1(@owner, MEMCG_HIERARCHY_ID);
>
>   /* make the decision based on the @cgroup1 attribute */
>
>   bpf_cgroup_release(@cgroup1); // release the associated cgroup
> out:
>   bpf_rcu_read_unlock();
>
> PSI memory information can be obtained from the associated cgroup to info=
rm
> policy decisions. Since upstream PSI support is currently limited to cgro=
up
> v2, the following example demonstrates cgroup v2 implementation:
>
>   @owner =3D @mm->owner;
>   if (@owner) {
>       // @ancestor_cgid is user-configured
>       @ancestor =3D bpf_cgroup_from_id(@ancestor_cgid);
>       if (bpf_task_under_cgroup(@owner, @ancestor)) {
>           @psi_group =3D @ancestor->psi;
>
>           /* Extract PSI metrics from @psi_group and
>            * implement policy logic based on the values
>            */
>
>       }
>   }
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> ---
>  kernel/bpf/verifier.c                   | 5 +++++
>  tools/testing/selftests/bpf/progs/lsm.c | 8 +++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
>

Hey Yafang,

This looks like a generally useful change, so I think it would be best
if you can send it as a stand-alone patch to bpf-next to land it
sooner.

Also, am I imagining this, or did you have similar change for the
vm_file field as well? Any reasons to not mark vm_file as trusted as
well?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d400e18ee31e..b708b98f796c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7165,6 +7165,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
>         struct sock *sk;
>  };
>
> +BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
> +       struct mm_struct *vm_mm;
> +};
> +
>  static bool type_is_rcu(struct bpf_verifier_env *env,
>                         struct bpf_reg_state *reg,
>                         const char *field_name, u32 btf_id)
> @@ -7206,6 +7210,7 @@ static bool type_is_trusted_or_null(struct bpf_veri=
fier_env *env,
>  {
>         BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
>         BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
> +       BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct=
));
>
>         return btf_nested_type_is_trusted(&env->log, reg, field_name, btf=
_id,
>                                           "__safe_trusted_or_null");
> diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/self=
tests/bpf/progs/lsm.c
> index 0c13b7409947..7de173daf27b 100644
> --- a/tools/testing/selftests/bpf/progs/lsm.c
> +++ b/tools/testing/selftests/bpf/progs/lsm.c
> @@ -89,14 +89,16 @@ SEC("lsm/file_mprotect")
>  int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
>              unsigned long reqprot, unsigned long prot, int ret)
>  {
> -       if (ret !=3D 0)
> +       struct mm_struct *mm =3D vma->vm_mm;
> +
> +       if (ret !=3D 0 || !mm)
>                 return ret;
>
>         __s32 pid =3D bpf_get_current_pid_tgid() >> 32;
>         int is_stack =3D 0;
>
> -       is_stack =3D (vma->vm_start <=3D vma->vm_mm->start_stack &&
> -                   vma->vm_end >=3D vma->vm_mm->start_stack);
> +       is_stack =3D (vma->vm_start <=3D mm->start_stack &&
> +                   vma->vm_end >=3D mm->start_stack);
>
>         if (is_stack && monitored_pid =3D=3D pid) {
>                 mprotect_count++;
> --
> 2.47.3
>

