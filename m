Return-Path: <linux-kernel+bounces-864461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105CABFAD87
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E373BF080
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B826306B06;
	Wed, 22 Oct 2025 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLD4BJX1"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C150306491
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120902; cv=none; b=ca6aG2TBaoa/1tkHwVU/yCjA7iFFspOUbW7sUyLPqFWkSPi+21bQPCVCfqWyuhm/LHUM31W2j1/9POUBjqd13fBfPUwv98/JCxeRyJipQcfSRSuoSi1JHaitObW10u5Zm/OoUR5P3FwSBJ8PqSgg5mVEDQSHWdnPeB2QnkYFC0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120902; c=relaxed/simple;
	bh=cyBpFy8UVkMelmryAwIuaBdqPxaLwG651keCJoXKZYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqqjCrdLWIlOw/H8mSYA2JKxaWD8uZGgRCwF3BjngqYu5u2ABFXjC01SdxOjSjJgp2vXu54Bk7a/5icndmzJIyLw1BCV8zMn6PscbD4g1YfrVPJNg5IbS29uidcgkYw90OloUiybgVuY4rMGjr9iKWQTzQQnsti8zpMsVGEJTn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLD4BJX1; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-88ed6837e2eso1373318485a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120899; x=1761725699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kc+KKthH3EZzvZbA3/zNivfsabMNFBxOZip1Q8c96nE=;
        b=cLD4BJX12pa6PX1uQH+dN3e2c54eYJ8Lh3xC2yQ7f+7lfdQdRiwlbjtCYSK+oiI3LK
         CX5B0vX8T9aLou18D5/2xMwuuBMn3CRdugJneFGjlK8bwHi77gNUfx4+pnTi+mm7Kx5Z
         8h0pCDfjaNH6X5+p/Desd7wWiotvFMd8Xa0LiEKzv/+USFU0QwiqJ1cAqXgEBAfuAEsu
         /GnGu9EjwvZPpRJ3F9jnCtuJOMHGwzGMdkUICaDmvO99TErgmdbryQgxP6850UwdwRjf
         FmzMWIuqyDjenqVGElM+M7VJUK0asHkfcctX/8ctR1IS8dHhKW4ONYOD/Cl0XGzbD/XK
         MhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120899; x=1761725699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kc+KKthH3EZzvZbA3/zNivfsabMNFBxOZip1Q8c96nE=;
        b=CfGWh/+CV8m5D96Ol6X4hNRi7lNHpxeN21ery66JWaxEnOC8LcZYbxmxoOym4m+CnX
         HhuP2GgBVIN05Dnrh4ZWsk+48dl7p7QeqIlH+8Wd8a/O5YYNNRDeaYZv52xVp7GPLOvy
         cpuVUbhRhEPyXYo8+W7uR5t/tiAdJ0+RgjnjAqfCsnNeDcjt81EkwXo3mhpJ+W22TQPg
         Zut5RwoDRr4qBrPbfL+8wRTzGvglqpZ9MPlnlAKuLKVHBlH5p9ZwSaj/yWXN2Bfewcss
         sASOpPAYlkkr/098HU1tHQBAF0MXFLrvO2wi1eM7aUgd8IszwdZgr58XAJLWDgpRFHkO
         v9aA==
X-Forwarded-Encrypted: i=1; AJvYcCXrDlE1bxx24JodTzVqSMDCQtZSZdEd7DjCeGVpzzTR/Q6owQMEi/yi7xZfZlJAwe0Nb7g2Q9BvFgY23ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyxKW5su8zLkrApsJPzB/lpKzStPSNJgnSKGMKM7mjWCVgVcNF
	NU7BhjnePpOMptSnV6c/uGauX72/QV1+sdZ62hfl9DTc2vAyDUCuw+f53GdANqbVLUEv17gLTwS
	xXPrJMueUIa7EJKRhdyLHGLmkL0G4gZ0=
X-Gm-Gg: ASbGnctsacpnpPsD3W6CTIys4wjgd22t5C4Kujfti9jxM17n8tibMDZbt2OtjvVMq5J
	LR2ByJTh6suh+IoM1RS+tUv9cT7F+XM5uITGhUkFNviMG4usrNbrnuxDBCE/Ft5sb9gL3ItCY6+
	UAYrLmvOpg5v1/3O3NDdsYrzvuUaKx5HIsni99S8+c0JDflQjsgDWU59LMtTWpaiBjrs9YVsimV
	Kaq+q3cwzAPmD3xTU+4XHic/TiBPXqsA5qvE1+baUPqiAyXQRipHlTmq6Aj1uQunrWv8W1ZEvBJ
	ExGS9GQc725JexLP
X-Google-Smtp-Source: AGHT+IEhER7MQg3744Yoz4/uML1arKqJYpMl8e42fCr1hdvltEI2c6JTn5tM+Uei72z9xIzjCvWCn/SXFXsGhGVB7zM=
X-Received: by 2002:a05:620a:471e:b0:892:624f:7f71 with SMTP id
 af79cd13be357-892624f82b4mr1714089585a.88.1761120899131; Wed, 22 Oct 2025
 01:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
 <20251013092038.6963-3-ying.huang@linux.alibaba.com> <CAGsJ_4xaA8QRjP9H=n1hQfEfGop7vOd5Y=J+KQzuOyfa8GK-kQ@mail.gmail.com>
 <87a51jfl44.fsf@DESKTOP-5N7EMDA>
In-Reply-To: <87a51jfl44.fsf@DESKTOP-5N7EMDA>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 22 Oct 2025 21:14:48 +1300
X-Gm-Features: AS18NWBLKZ7qT2Y1R89WO7GO8UtVmSMjKHbsauP0TH-Q88ewqIZQTW6sMd0AXws
Message-ID: <CAGsJ_4zPH0fwBOLQwh1y6jG3tCXHLGRCTyVVSCWb+NfLCEMV0Q@mail.gmail.com>
Subject: Re: [PATCH -v2 2/2] arm64, tlbflush: don't TLBI broadcast if page
 reused in write fault
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Yang Shi <yang@os.amperecomputing.com>, "Christoph Lameter (Ampere)" <cl@gentwo.org>, Dev Jain <dev.jain@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Yin Fengwei <fengwei_yin@linux.alibaba.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> >
> > static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
> >                                            unsigned long uaddr)
> > {
> >         unsigned long addr;
> >
> >         dsb(ishst);
> >         addr =3D __TLBI_VADDR(uaddr, ASID(mm));
> >         __tlbi(vale1is, addr);
> >         __tlbi_user(vale1is, addr);
> >         mmu_notifier_arch_invalidate_secondary_tlbs(mm, uaddr & PAGE_MA=
SK,
> >                                                 (uaddr & PAGE_MASK) +
> > PAGE_SIZE);
> > }
>
> IIUC, _nosync() here means doesn't synchronize with the following code.
> It still synchronizes with the previous code, mainly the page table
> changing.  And, Yes.  There may be room to improve this.
>
> > On the other hand, __ptep_set_access_flags() doesn=E2=80=99t seem to us=
e
> > set_ptes(), so there=E2=80=99s no guarantee the updated PTEs are visibl=
e to all
> > cores. If a remote CPU later encounters a page fault and performs a TLB
> > invalidation, will it still see a stable PTE?
>
> I don't think so.  We just flush local TLB in local_flush_tlb_page()
> family functions.  So, we only needs to guarantee the page table changes
> are available for the local page table walking.  If a page fault occurs
> on a remote CPU, we will call local_flush_tlb_page() on the remote CPU.
>

My concern is that:

We don=E2=80=99t have a dsb(ish) to ensure the PTE page table is visible to=
 remote
CPUs, since you=E2=80=99re using dsb(nsh). So even if a remote CPU performs
local_flush_tlb_page(), the memory may not be synchronized yet, and it coul=
d
still see the old PTE.

Thanks
Barry

