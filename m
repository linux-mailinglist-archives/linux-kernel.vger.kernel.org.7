Return-Path: <linux-kernel+bounces-723920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC4FAFEC76
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34925A61F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEF52E5B0A;
	Wed,  9 Jul 2025 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CNGaTJ7E"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8B22BD04
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072235; cv=none; b=VwtnCtAIHGOldkF3Hts8WsxCb8sPusHB8dnpZ9/ywzzlx+0ImvmdW+NNuE3E6uhjGlGjyWKt/pStGaa0jnt9RcYXfxqEcUdDiXzjzDclKyLj2hYagX3t9xoGR7PDRSzL1O+2RNVSnOAv0zOx3SAW9HqRt8MXt6kP2p5a0s3xbHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072235; c=relaxed/simple;
	bh=l2EoRIEOm1tWa3RQ3yXDYhhzRpdZ5cCSLcCdICp+VvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mC1datoF1zlH9wI2fxAxWMAr6KKDLGKcQw9QW3H4JoCjBgWmjmOEmNMv3IyDh8viL778IJ82YVHYyuxVh1/66q6Ab1kNQ8Zq+gNdLhR5tgbdidcXHnVfwGd6wdPLDrJpDna+5X/BJhjx6EtuJt9u0PfQvOspMlv5Q2W6N4H4vc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CNGaTJ7E; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a5ac8fae12so486301cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752072233; x=1752677033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9h4iNrqmrgYRYNHEm412mE4N8zc3N+lVl0+OkSxU5fQ=;
        b=CNGaTJ7ECtSUZ6aDEjfcDf2OdjGYEzyklc/2IqPTv5LRrUvofj/l9imWgLNi8rFMWf
         2Uo1KsEn2hl1R5hGIqb6Web4HXcsmah4XA7qiSsvvmpqAVvl6hO+4UExlQZ3Mye8VQlA
         gvpw1CpvGjKu705LBOYLqizos3XOFgWScAGYH6nQ9hRmNNj/nBGwkIWcyxmH9ATGeQz/
         R9fSc2ui2azxcoD0GJaQeJrHJnv5tAnIkiWUWMivAS9NYL9XqqtmWiayryynAprSYnE7
         By+iu5knp/1fFZbxvHbXSHqrWxXmTApIIYO/98R29g6GQJ6+O7XvgozBj7WCm2b8MGTj
         7l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752072233; x=1752677033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9h4iNrqmrgYRYNHEm412mE4N8zc3N+lVl0+OkSxU5fQ=;
        b=vggBc1t1mwF1R5yFI7qum45nqV9I4/f0uJB+Q6Pvb18x2TMo+aR+EwjfbuE1cj0EeA
         gr7QC6epjNR7guQcsEGdPhj1S5H9Wbfy7W7LHxaatPm9mdWGw1TVTIaalvKoNQGmxykh
         fPszsrVQ+56ETqV2UYsDh/yWchpjPH73rsV0Z99/inApW7CfiZTVjE3sWyD33pDdpEAj
         zzjh0UG9yC8su/lgr2EnAj75sYN2YUDDzynxKzWLDlhN1+afT9SwU9Df2fOu5CsDhZto
         Pri/V3QMxOmSolBpvb2uM2p6WsmCIrWk5/uDTO7n9QAV3aU7wn7FkUx58J03GwOCkVlo
         0FCg==
X-Forwarded-Encrypted: i=1; AJvYcCX+etfUz3iidBgqRv6rNJVDxGcCh8AjuexBePKDJ7SsiqH8dY3HKE72Z8Ggqb69wLV+GcMdjAoK7NVlNjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBWUgZIUv1+jDoyMpEiaos9Ppb0hWAd282ZN1DKgsDSDQubr5n
	DE02MiqgfO2Idz5VCbOxTf4CfvXHfDkKedfn4GZvjaAcCIrGK3UXOcDN/nOfl0nMIJ22tkhETxd
	C9IQ0P1rJ/IBXy8nF9UPvarkKPeEjGCCV0iy3hdXo
X-Gm-Gg: ASbGncvXaxn0AtfFmMllXgpyrV2HPudZP5+Zkj9maVLKt/C+6ziqh8o1DXhrlnETlCG
	kag1UcJrfmwwtyHOQQRIUZI5+kzbQU66QxzIlYiwt/xxsJnQJQb6EuYGn2jgSDYDG/baje1NBqT
	sMjcdxkJ6QvD9XFPu+8pRbPiEPb17myHRc1milvVg3Z/sC96GpAemidPHOAASju+/A3BFdKY7nI
	Q==
X-Google-Smtp-Source: AGHT+IEU/TvuWoEbQ4te2ysqypswU5dT7NndQazyOFRc4vkSO/Fq1Wv/2Ic2ztMR6HHz0WqYXvto3hPD9kQ7BwMTx3U=
X-Received: by 2002:a05:622a:306:b0:48d:8f6e:ece7 with SMTP id
 d75a77b69052e-4a9de07279bmr3534091cf.3.1752072232239; Wed, 09 Jul 2025
 07:43:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704060727.724817-1-surenb@google.com> <20250704060727.724817-8-surenb@google.com>
 <bcba384b-0161-4d3c-b632-67e25dcd1efd@suse.cz>
In-Reply-To: <bcba384b-0161-4d3c-b632-67e25dcd1efd@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 9 Jul 2025 07:43:40 -0700
X-Gm-Features: Ac12FXxjAN0XIip7JsJyjMywVS_OrT44fU8TqxqHaIiIlNUJxwEx3Zvd-AP4Q2Q
Message-ID: <CAJuCfpELdDi0G5Tdf0GQRNVvLxFW6HzKN-gfTLW4Yiw0jNRHQQ@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, peterx@redhat.com, 
	jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 3:03=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 7/4/25 08:07, Suren Baghdasaryan wrote:
> > --- a/mm/mmap_lock.c
> > +++ b/mm/mmap_lock.c
> > @@ -178,6 +178,94 @@ struct vm_area_struct *lock_vma_under_rcu(struct m=
m_struct *mm,
> >       count_vm_vma_lock_event(VMA_LOCK_ABORT);
> >       return NULL;
> >  }
> > +
> > +static struct vm_area_struct *lock_vma_under_mmap_lock(struct mm_struc=
t *mm,
> > +                                                    struct vma_iterato=
r *iter,
> > +                                                    unsigned long addr=
ess)
> > +{
> > +     struct vm_area_struct *vma;
> > +     int ret;
> > +
> > +     ret =3D mmap_read_lock_killable(mm);
> > +     if (ret)
> > +             return ERR_PTR(ret);
> > +
> > +     /* Lookup the vma at the last position again under mmap_read_lock=
 */
> > +     vma_iter_init(iter, mm, address);
> > +     vma =3D vma_next(iter);
> > +     if (vma)
> > +             vma_start_read_locked(vma);
>
> This can in theory return false (refcount overflow?) so it should be hand=
led?

Yes, I should handle it by falling back to mmap_lock. Thanks!

>
> > +
> > +     mmap_read_unlock(mm);
> > +
> > +     return vma;
> > +}
> > +

