Return-Path: <linux-kernel+bounces-748438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2741CB14152
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA6F3BF344
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE06B21D3DC;
	Mon, 28 Jul 2025 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tSb9UqeX"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4336274FEE
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753724621; cv=none; b=KZeFTnrp4vpfcp6KRnCW4ygzXBK3VDy26g/lU+ZgCCNS5qY0stPoBs/Oh4YTPFFk9yDA8b0nudeDeAYLMv5euWS4Y2TvKRUh4AVDQb3UVIw9cUGUCIzXNUoR908OGpyEDlM07n2FVNRE8rpLC6f6TIAghnDTHUORxB79k6qzrPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753724621; c=relaxed/simple;
	bh=tTSVZFhM/8KfEpOJ5B/nufZRthIAg5fmsk2+H3mu4/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaYQ12XGuQErFNLQFVKqJlXaatq2DhTpdridx+nR589YIgvL2vrXOVrQRFKRIHvgmvdmcLRxuzMuskzPJryvfKT9/LvQ2Z/s8dfaQ/iZ+ADZxnVSEkfrZJsfMFaTgf9Wx/zSfmoILSD6+63NeWm+lRt8aJs/19LF4m0l526YHtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tSb9UqeX; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso51771cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753724619; x=1754329419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEghI5pYEjufZFW6NqCQuT9m+lJJtlDUIlnDJTdNb/A=;
        b=tSb9UqeXfXEhdjHdDTR3Xjz4HwRb/8dGO5gCvsdjYKoQWYt//2LlFmGm7ZU6kYbl29
         EeumAVt+bat0o158Hi26Vdp2pxWQihLuhBP3iy9Ryp6SR1JjBNdaMgjyKkP5P0QN9mx6
         bv3bjngXbxxwybmCddG1k7Of3LnjUSSJEy8c905a0r3v+gzVtNpNTlrcRbB1XglxG4UT
         JmEmYrtKrzGrwi199UzxaoFvk5jQ0O8BfPtFM31jTQYF0sno2OIAlbs66NZqAsVB01xr
         kFntR05YnOQDVx2ox62N+BTUhVdRhUmwHPYNXopHPv7L61f2TybcqsyTaVNplYki/XJF
         +59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753724619; x=1754329419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEghI5pYEjufZFW6NqCQuT9m+lJJtlDUIlnDJTdNb/A=;
        b=PNL1u50qQSzZZqx3JO9xT4vwDY+Rlon+IUVZaH0Bq7EhU8TIj/cHcjyUxzOgFTPS1v
         Ui1t6SexnyvEoZvkbfb6XG5lg5A57/pjytAyZyv/MougayMySRXyuYCcErmyWHu0X2PJ
         jmHmrsPDlFLL+WjA9nHLaL9M/H0msysmhKzD3PjgUqmIylgyXaooFKC6agTEm+afYHfS
         wjYy7sePe43pglwatdRexBS1pxvf3CtJxdKJ0ej57i2EeeUShlKs+f5T5+MA3/ERNEK9
         OhtvZir45z1Qut4R5z3uHrnG14yMtVMtZJgq0xAoD7FGdlewJ5Vxob+M5Dn7fuZww/n1
         7YlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBPBsSxM9CqvFvGAz1kVd6Ewb/43O8IRCiBX00hIfC2rSyFDDmrN9E9zejFNybqGqUCi3EJLb4pKs2O6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2kmkWpVAKFjkbEXZMV/vWdP9sUE8P5PkboTm4864523EYBYdk
	bMcri43FDyxTmLPLHkmAR4LF08koOtZFiCKTxZ5ma9KHCDOPeIp3/RLYAOp1ZaFuf3iI8Iu77w6
	OpG1K+yEe/o+JdNsBCSpVFPvPHiOmfQk4/VESh6n+
X-Gm-Gg: ASbGnctKvtK25mzmHXhRa3Htng7sQIpk7C1ebFyCePM4QDyxeOjUqQVMbpDbH9jYUwd
	HW3/+Uelr6xdjJv0FiN7pGlvgkNYxfAhmIVwQQ1/zqA9LU/sOvmIJBptidOUPe/ZnCKiH+A+MUM
	XyY1LU1cOVxCYbqN1L4v+IiIkh+egj38SkHeixToA9STTj/XiupFadGiHa/5o6F/dSYVNCU4CCP
	CCsEh6SF413vyAm
X-Google-Smtp-Source: AGHT+IHxByOEzP2Xq3Dzg1Babc28QbNqFKhq4fL9Ckik/VGrbhh3ukcLUktDijqaR+JqVUL0Q5B2QLam3WeUYEHkrQI=
X-Received: by 2002:a05:622a:143:b0:4a9:a4ef:35c2 with SMTP id
 d75a77b69052e-4ae9e887e3cmr7745801cf.23.1753724618069; Mon, 28 Jul 2025
 10:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728170950.2216966-1-surenb@google.com> <3f8c28f4-6935-4581-83ec-d3bc1e6c400e@suse.cz>
 <CAJuCfpGZXGF_k_QVQqHWZpnypB-sWB8hwZeOYMOD0xmAFOBxkA@mail.gmail.com> <97938dc6-5dfe-4591-ba53-3729934c1235@suse.cz>
In-Reply-To: <97938dc6-5dfe-4591-ba53-3729934c1235@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 28 Jul 2025 10:43:27 -0700
X-Gm-Features: Ac12FXy5kos_F88NmjNLuh5BxW7TbmMP21eggfxR6rOr4N2InO9laPUKFKTi9xY
Message-ID: <CAJuCfpHgyzQxmAiriFM59KGi465ocxH6T5nBSBY1fcUazOj9Gw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: fix a UAF when vma->mm is freed after
 vma->vm_refcnt got dropped
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, jannh@google.com, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, pfalcato@suse.de, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 10:39=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 7/28/25 19:37, Suren Baghdasaryan wrote:
> > On Mon, Jul 28, 2025 at 10:19=E2=80=AFAM Vlastimil Babka <vbabka@suse.c=
z> wrote:
> >> > +      */
> >> > +     if (unlikely(vma->vm_mm !=3D mm)) {
> >> > +             /*
> >> > +              * __mmdrop() is a heavy operation and we don't need R=
CU
> >> > +              * protection here. Release RCU lock during these oper=
ations.
> >> > +              */
> >> > +             rcu_read_unlock();
> >> > +             mmgrab(vma->vm_mm);
> >> > +             vma_refcount_put(vma);
> >>
> >> The vma can go away here.
> >
> > No, the vma can't go away here because we are holding vm_refcnt. So,
> > the vma and its mm are stable up until vma_refcount_put() drops
> > vm_refcnt.
>
> But that's exactly what we're doing here?

Ah, you are right. At the time of mmdrop() call the vma is already
unstable. Let me fix it by copying the mm like we do in
vma_refcount_put().

>
> >>
> >> > +             mmdrop(vma->vm_mm);
>
> And here we reference the vma again?
>
> >> So we need to copy the vma->vm_mm first?
> >>
> >> > +             rcu_read_lock();
> >> > +             return NULL;
> >> > +     }
> >> > +
> >> >       /*
> >> >        * Overflow of vm_lock_seq/mm_lock_seq might produce false loc=
ked result.
> >> >        * False unlocked result is impossible because we modify and c=
heck

