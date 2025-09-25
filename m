Return-Path: <linux-kernel+bounces-832987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A21BA0EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D801C250AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E9F30C342;
	Thu, 25 Sep 2025 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/TftEX8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71EB433AD
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821764; cv=none; b=lgG90cfbNkacjHtmpD84SCnspE9q0FCH5Fmy4iAMNBksZEyBTOV0jQseee8lfxcDdEGvhPME1TnrDSwk5ooBm6P5f2+lEmt62N/2XhvrIv444qomguzTDTuXc+INnHo4VRHxT27lsMHbFr43CYfv+br0atbGOynWGNik5kuc49U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821764; c=relaxed/simple;
	bh=6X+Kwq99hJ6RldFuwAIqGeWDneu3vOuSsUP6CqzbVfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMcUbVBE8HANXmBA9m+6bnHGqSR7yrCUgY0eow8Bzt+Vb2Z1+817Ci5ejsnY2IdUWtOf6imwskHYC4PtvKxi6KTar7SXYD89K/e4Shn/XBcpNHSkh5rOY7Ha51WyiTJ41KO/+bLzS9TRyFnSLkdfXvWlAibG4fP+5PMMAgIHMig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/TftEX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A28C116C6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758821763;
	bh=6X+Kwq99hJ6RldFuwAIqGeWDneu3vOuSsUP6CqzbVfk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r/TftEX8EQYkqXGinosO6v7+qLQSZOXcE9dnQBYpDp2u9Wh4HkKGsITtSdPYO6eH0
	 XENj/ROS4rFfbRHo3by8it045lyMpNB5eVEvfBOAJztTy3pTLYdzgUK4UmLEp6k89j
	 C3T8EXVe7RGe9Q8qH8kKLA85q170G+QKA40ZXkEoiqXTePUb92B4fPar7ecv4T+qbY
	 UT9gIAlXrJBZ6CIF1++J2xHOq2Isg6iDiVkI3s19DFv1lYsHdEgNQJAydZ6wZ+Ztx3
	 ElMyJRKcloqBy7Dy3B5HGqgnkWzl8FTT4ibZh1JXkuQT4sGNMJBIMxpNq3WeN5mop5
	 Cm6+743FC0nFA==
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-633c1b740c5so152870d50.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:36:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXyhw64dSZeBuZVxp3N36DUopNYU8/EaKI/YVOSmzp1/VcsR6+XOryKILflM3W/9uMioHkikKwoke1tF48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC8UvKMWMIhCIRWShzMNiOyh2HPf7TJg4J8RSGxEf0lfFL/tqs
	5aueusMxudZJv9CmQ/shNVKM9/idcuneDG4iaCagfq05fzv189Y+/7FPEJIJEzYZydKCtNPiTfH
	YkkHZ8FwXG7xrH5nMsCLwKWlNGP0MrsUYIyGsl7mjdg==
X-Google-Smtp-Source: AGHT+IHiAaqrhjdBeWzemxxoy5Q/R4D0Bg1Krf9r3MkkhdAeLx/hi/f4ggBJoQJ1TWCnJxEIcknHVa4xwmbnHdx/DUg=
X-Received: by 2002:a53:7212:0:b0:624:1660:ba01 with SMTP id
 956f58d0204a3-6361a82db92mr2632679d50.37.1758821762606; Thu, 25 Sep 2025
 10:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924181138.1762750-1-charan.kalla@oss.qualcomm.com>
In-Reply-To: <20250924181138.1762750-1-charan.kalla@oss.qualcomm.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 25 Sep 2025 10:35:51 -0700
X-Gmail-Original-Message-ID: <CACePvbW=-KZhU_qi4UUw7Pjbz4o=SQwHmQyEOkxhpMvdetbPCg@mail.gmail.com>
X-Gm-Features: AS18NWCdaLC1Wp3RSMP0da3-Fs18-J7lkLeP98ZrcoaPfKuh1jdrt-Zu6iPTusQ
Message-ID: <CACePvbW=-KZhU_qi4UUw7Pjbz4o=SQwHmQyEOkxhpMvdetbPCg@mail.gmail.com>
Subject: Re: [PATCH V2] mm: swap: check for stable address space before
 operating on the VMA
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Cc: david@redhat.com, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	akpm@linux-foundation.org, shikemeng@huaweicloud.com, kasong@tencent.com, 
	nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, 
	zhangpeng.00@bytedance.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

?

On Wed, Sep 24, 2025 at 11:12=E2=80=AFAM Charan Teja Kalla
<charan.kalla@oss.qualcomm.com> wrote:
>
> It is possible to hit a zero entry while traversing the vmas in
> unuse_mm() called from swapoff path and accessing it causes the
> OOPS:
>
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000446--> Loading the memory from offset 0x40 on the
> XA_ZERO_ENTRY as address.
> Mem abort info:
>   ESR =3D 0x0000000096000005
>   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>   SET =3D 0, FnV =3D 0
>   EA =3D 0, S1PTW =3D 0
>   FSC =3D 0x05: level 1 translation fault
>
> The issue is manifested from the below race between the fork() on a
> process and swapoff:
> fork(dup_mmap())                        swapoff(unuse_mm)
> ---------------                         -----------------
> 1) Identical mtree is built using
>    __mt_dup().
>
> 2) copy_pte_range()-->
>         copy_nonpresent_pte():
>        The dst mm is added into the
>     mmlist to be visible to the
>     swapoff operation.
>
> 3) Fatal signal is sent to the parent
> process(which is the current during the
> fork) thus skip the duplication of the
> vmas and mark the vma range with
> XA_ZERO_ENTRY as a marker for this process
> that helps during exit_mmap().
>
>                                      4) swapoff is tried on the
>                                         'mm' added to the 'mmlist' as
>                                         part of the 2.
>
>                                      5) unuse_mm(), that iterates
>                                         through the vma's of this 'mm'
>                                         will hit the non-NULL zero entry
>                                         and operating on this zero entry
>                                         as a vma is resulting into the
>                                         oops.
>
> The proper fix would be around not exposing this partially-valid tree to
> others when droping the mmap lock, which is being solved with [1]. A
> simpler solution would be checking for MMF_UNSTABLE, as it is set if
> mm_struct is not fully initialized in dup_mmap().
>
> Thanks to Liam/Lorenzo/David for all the suggestions in fixing this
> issue.
>
> [1] https://lore.kernel.org/all/20250815191031.3769540-1-Liam.Howlett@ora=
cle.com/
>
> Fixes: d24062914837 ("fork: use __mt_dup() to duplicate maple tree in dup=
_mmap()")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> ---
>
> V1:
>    -- Checking for xa_zero_entry() instead of most cleaner way of
> checking for MMF_UNSTABLE
>    -- https://lore.kernel.org/linux-mm/20250808092156.1918973-1-quic_char=
ante@quicinc.com/
>
>  mm/swapfile.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 890b410d77b6..10760240a3a2 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2389,6 +2389,8 @@ static int unuse_mm(struct mm_struct *mm, unsigned =
int type)
>         VMA_ITERATOR(vmi, mm, 0);
>
>         mmap_read_lock(mm);
> +       if (check_stable_address_space(mm))
> +               goto unlock;

This is checking the MMF_UNSTABLE bit in the mm flags.
What is the locking requirement for accessing the mm flags MMF_UNSTABLE bit=
?
Here we hold the mm mmap read lock.

As far as I can tell, there are two paths that can set that bit.

1) dup_mm()
It holds the mm mmap write lock. This path is fine due to the write lock.
So far the above race against dup_mm(), adding this  check is fine.

2)  __oom_reap_task_mm()
It holds the mmap read lock when setting the MMF_UNSTABLE as far as I can t=
ell.
So checking the MMF_UNSTABLE with another __oom_reap_task_mm() does
not exclude each other.
This is more of a question for oom reaping.
Does MMF_UNSTABLE have the test vs set racing here? It seems this
check does not protect against  __oom_reap_task_mm(). I have no idea
if this race is triggerable. Just want someone else to double check if
my understanding is correct or not.

I can see this patch does protect the intended race in dup_mm() vs
unuse_mm(), it adds value.

Chris



>         for_each_vma(vmi, vma) {
>                 if (vma->anon_vma && !is_vm_hugetlb_page(vma)) {
>                         ret =3D unuse_vma(vma, type);
> @@ -2398,6 +2400,7 @@ static int unuse_mm(struct mm_struct *mm, unsigned =
int type)
>
>                 cond_resched();
>         }
> +unlock:
>         mmap_read_unlock(mm);
>         return ret;
>  }
> --
> 2.34.1
>

