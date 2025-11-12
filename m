Return-Path: <linux-kernel+bounces-896327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C832C501D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A153B21F9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DFD44C63;
	Wed, 12 Nov 2025 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mcn77Ai1"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F4714A9B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762906257; cv=none; b=i0BI/iDSHEcm9MZNiNru05CjbmhMvvIvwlDzu+kPgTCdBuCeXWPaxjAhNXc9cGIQGQ/BqiPt0Exa+fN1691AGs6qyVcEs6jGzoMThF+boeDaTh71rPaActR2yAnlGRMSB1T/PKIH3T/Q5c0T/O4ZMeIgMt1FniNIz34+I1am7Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762906257; c=relaxed/simple;
	bh=DN1Fe5een/t3qa9Cu485Iq092WLt4D7xS4UEK4Wo+l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0usnkkk7SgdwKTBgDzndNY/H57tfw9jnHdMCiLJ8xcf4Ip6pTtxhx0Mk6tkBhu3OyyvVYvcu2+h50vCFY3N2L4Igb7f8xolsS6gV0ML4zxL6dBSUr0AOCIYKgWN0jCEKnhgHsaD0qghnFfujougxYVD9DTsd9F1JYtuwMcCbds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mcn77Ai1; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ed67a143c5so123311cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762906254; x=1763511054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TofOimS+W4wPqm1YozjJKcKMNkewdNdNRtQ6Og3Qixg=;
        b=Mcn77Ai1GprVUyaVgJ7yuh4ywK9CRmtpJ+sS1ivK8jPxVH/EtzNpAitfvi0o5JJpom
         LBlgaeuyzQ1m9KdvWy38V1SnffZjGk3BZ8S/CJPQ/ckANzDbUQjqX+2icvkYBKHbcABG
         rnsi3Rrp7rbmoy8ne0m78hW3tcza3YAsZJXdXRV4a6pGxDVJDh4DN3DtikEMR1/1mhmj
         1XY5HEw1vXfjNru09R8DzdLis9fvzr4HBp8e46sFkX1w+kKgtWSI7NlnVtjOii9t+vmd
         zQl87oYWeyJjFonuu1pdO6RRii+MoNgVhJJPw8iMeybkXnrZwduEOgl5Xfu4+XYd5783
         MQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762906254; x=1763511054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TofOimS+W4wPqm1YozjJKcKMNkewdNdNRtQ6Og3Qixg=;
        b=XFFvNHK9kHEjJpPIjVQbOrCJx41auGaaNHCjd9/UijakXLXYporZWd9rh4cdgOAc3s
         bauTN7GsgIOGPLlsDv9T9TcCVPZCpzwCg9s4DOrPmOvtRQvgln8Z2/3Mi8DCpDC2+zmm
         J3Ap62y0IWfgTMlrfsolzesLDP0ZO+z9Rw9Le0Xks9pl0FLfvrP3TlegHAKQCOTqR+3j
         Hi2znwnNzrg7RgKM+FkCRP5OwK8GBuAAe3fH25egJ/fyzffhXleOAYc4dIE233x6C2tm
         1ofb7sWP59BkRzqomF7E2JfpfJTlRn7ObmI6C2biTbRrp8NiwNAFXbT2zqA3mB6V/C0q
         KRQA==
X-Forwarded-Encrypted: i=1; AJvYcCVLDHjfyIkNSladl+ZZc3Y3CsZTh+MaeIaedbpa3rmlwFQ3M0YFhNVR5XKlif2j+2ZBERsv2dvHQ9K+COA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf2X2cyldlZf8EJHFeXNjbQoGSW6DZJ/dYBWZ+rnqapjTeVaEs
	f3OdjP8vXuCVb7mRDo7kGz/x+2ifWGm/7yPCCeVArKAKcmTM4kOS/kuSs4OWak9KHeCvrj5S1DW
	WcCJf3LDtRc964LRCCe7hvqBwM8Sq2gT3Jdkj3Gu1
X-Gm-Gg: ASbGnctPl0an5kJwZID4FZTdRlTZmi8pWRmJmZl+mkZLWW6ZzBWUFyyqBor1E8XT2TG
	Hu1OgDAb07Tt2rE5Terz8tEYKpo7+h1vJYqoFTe+dRULh46we4WMnBVMc8qKDCHXxjg2pc+URd/
	ETH2B6ngD/9/yatey0v5wKZYZPNropbVl4WKF/3hsKLpSjaqQE5icGpvuBabYeazx2/fZLRd9Pg
	vbbxoJphC7I2bcdcITMh/RnKLLWrC6xmQcYLpCMemEDA54e0iauvGLuaOQ6rMpRWpRsyh8a3XZ4
	LXahZ9gqyi8/JVHzr7oV7+L+dnAaiaOT98s=
X-Google-Smtp-Source: AGHT+IG1ecyNEMTs/bPngxeeJjhChHGBg4qLSCj1E5+5//1j9A4bIiyry1IsaHfEA9GI8rjBudj4rW/glVxvWiugGjQ=
X-Received: by 2002:a05:622a:2d5:b0:4ed:7c45:9908 with SMTP id
 d75a77b69052e-4eddc1171d0mr2843151cf.10.1762906254090; Tue, 11 Nov 2025
 16:10:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111215605.1721380-1-Liam.Howlett@oracle.com> <8219599b-941e-4ffd-875f-6548e217c16c@suse.cz>
In-Reply-To: <8219599b-941e-4ffd-875f-6548e217c16c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 11 Nov 2025 16:10:42 -0800
X-Gm-Features: AWmQ_bkHdozyKSgPF1d5Bsi9z5t37_9KCgiztdRPoTJRYXVkpDN0VkjU8MHCXMY
Message-ID: <CAJuCfpESKECudgqvm8CQ_whi761hWRPAhurR5efRVC4Hp2r8Qw@mail.gmail.com>
Subject: Re: [PATCH] mm/mmap_lock: Reset maple state on lock_vma_under_rcu() retry
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jann Horn <jannh@google.com>, stable@vger.kernel.org, 
	syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 2:18=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 11/11/25 22:56, Liam R. Howlett wrote:
> > The retry in lock_vma_under_rcu() drops the rcu read lock before
> > reacquiring the lock and trying again.  This may cause a use-after-free
> > if the maple node the maple state was using was freed.

Ah, good catch. I didn't realize the state is RCU protected.

> >
> > The maple state is protected by the rcu read lock.  When the lock is
> > dropped, the state cannot be reused as it tracks pointers to objects
> > that may be freed during the time where the lock was not held.
> >
> > Any time the rcu read lock is dropped, the maple state must be
> > invalidated.  Resetting the address and state to MA_START is the safest
> > course of action, which will result in the next operation starting from
> > the top of the tree.
> >
> > Prior to commit 0b16f8bed19c ("mm: change vma_start_read() to drop RCU
> > lock on failure"), the rcu read lock was dropped and NULL was returned,
> > so the retry would not have happened.  However, now that the read lock
> > is dropped regardless of the return, we may use a freed maple tree node
> > cached in the maple state on retry.

Hmm. The above paragraph does not sound right to me, unless I
completely misunderstood it. Before 0b16f8bed19c we would keep RCU
lock up until the end of lock_vma_under_rcu(), so retries could still
happen but we were not dropping the RCU lock while doing that. After
0b16f8bed19c we drop RCU lock if vma_start_read() fails, so retrying
after such failure becomes unsafe. So, if you agree with me assessment
then I suggest changing it to:

Prior to commit 0b16f8bed19c ("mm: change vma_start_read() to drop RCU
lock on failure"), the retry after vma_start_read() failure was
happening under the same RCU lock. However, now that the read lock is
dropped on failure, we may use a freed maple tree node cached in the
maple state on retry.

> >
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 0b16f8bed19c ("mm: change vma_start_read() to drop RCU lock on f=
ailure")
>
> The commit is 6.18-rc1 so we don't need Cc: stable, but it's a mm-hotfixe=
s
> material that must go to Linus before 6.18.
>
> > Reported-by: syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D131f9eb2b5807573275c
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

With the changelog text sorted out.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks!

>
> > ---
> >  mm/mmap_lock.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > index 39f341caf32c0..f2532af6208c0 100644
> > --- a/mm/mmap_lock.c
> > +++ b/mm/mmap_lock.c
> > @@ -257,6 +257,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm=
_struct *mm,
> >               if (PTR_ERR(vma) =3D=3D -EAGAIN) {
> >                       count_vm_vma_lock_event(VMA_LOCK_MISS);
> >                       /* The area was replaced with another one */
> > +                     mas_set(&mas, address);
> >                       goto retry;
> >               }
> >
>

