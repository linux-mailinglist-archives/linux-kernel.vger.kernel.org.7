Return-Path: <linux-kernel+bounces-723972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CD4AFED13
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991853AE3F4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9132E5B21;
	Wed,  9 Jul 2025 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBK4/Whb"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C5625A2A1
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073601; cv=none; b=KnudLukMKQwn2pHot3wxO9B2tmriTIDkKV+08qSFHHE4cFk8I8vDYbtOCry+XgzrF4mlInZ2y0yjXUZT3YzIr/v5kp6/tvMqmYjrQxvABSzxmjFIEnwYrLF6Z6z5bOBp5ZSC2vkO13B9d5mz3oaI+MlWfrqNVmIaGwlTxd82wCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073601; c=relaxed/simple;
	bh=hvwdwQ64KjVHwTy47XVtw9Pp+Ymb1X2ttmMlI9VRYTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kl6N4ClhNHGCxTF4L7B1Utw3VOjtJFnCDpPVxon0tmZCcrkm1Id519/LVPlbioxTwJR1rPVMYDROxbxGNAL7ZrZM8Z3kRljxFJ0FNDIHKPhtiwHcBzDA5ixbSQmBJHp84Q88VHadX27b9hrH70+nzW7RF5TPTyYTCFbg8QZCN74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EBK4/Whb; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a9e8459f28so53961cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 08:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752073598; x=1752678398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fd2LSjDPzvM9cn+8iN5hrypSfDyrgOivdhgeXar2Dyk=;
        b=EBK4/WhbpXKRcYKp8LI/KJKQH80Tryc5aL/tYHdWjZg+bipx9MKa4TLqcxGU8QRdAc
         e8WnArb+SVDqcedch5UJjHK/F4Xi9XrMzYAJCiGrdqXgvK8js0vjOChlX1KMwc2kMuWV
         ij2tiE2m84cTsFUIDFqx3+60q7PIEqy3lHcfA7x11Usf6Lx0bws7T4iBJsLbISsEmScJ
         jAJS6EiC5Um5ctsWeXF+5hgFsR3YWO+q9VM4KLdx3urhg/Twy224I/UDSBBgE1n48xDS
         0PiQLTn4SsEDCnmZ36EBS5lNWpnssUpbUj78wOzFQ8heI1HhuEqjyMicxCDDtGpErjpv
         HfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752073598; x=1752678398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fd2LSjDPzvM9cn+8iN5hrypSfDyrgOivdhgeXar2Dyk=;
        b=TBiQq3UCTgJcKNry+FbXA4QQ1HBNvsV7l6ESdVIlf8clC8s9/NY3LZl04IbO7nvkbX
         W6RzZpLYcENKNiQ/h69gvqyqiC+2i/XEu+6qR6Z3kEPNbcdUJJT+tqh6MFHU0+Btg/TB
         ppwMUNYW7H9vJez3IZHjzK+Edvie3UN94OpLZip4p1ylB2HfEfTX/JEodPfddk5PteV7
         /Gz+jrU8469Fe4ET8q/1n/lfmFkybaOxMQuKBgpVvsHn+Pz1pQAGQq98b8mK/5fzBfjH
         hKUvlO2G+LPwb0HigdJ73AQJeh2aVAkoxSwvo0xDIV15q3sxT1XnE1/oLwnnB7blWLeV
         /fzw==
X-Forwarded-Encrypted: i=1; AJvYcCWCWFlSW7zbuQTWlcl7hvdvD0iWsVhLSP3Qq2ZUr7juC9/pvuu4oAAPXGwWgu3sPDlLs8ioWtuR0du7UjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySozjlmY5n/wViRPGCVTcxnLGyZ5Br5l3Y6jYwmff0poLA+Hi4
	Tuqej5e+rs4nekeysnadpTt5h06c8Kj1AcVYKho4bLvSOda/aWiQmjvOjR/ac2bKyehuyawwzJ2
	KdyEfR/1lqsO7O9LAirt2uSgQwfZfzw4DoiZL9Ul6
X-Gm-Gg: ASbGnctlo+oFiju+JRDb/OEC8j0aKLaiKKvj7P2tlljY4bu788R59Nq1TT38HRjZ4Js
	Jr3XzYxOxDOHLsqaRpwsKxbb2UblTMZeFGPGACgi8t2c3P1h5Z9pevL1fwDKj6eBVxG4KRGZg4S
	DYLXu/u/gIrnp0kvGQARtnjlevpVB57A0Nck0preaozq4ke0SeF7WjLO9PsJKWpWYfLURuHxwn9
	oa79+to4g==
X-Google-Smtp-Source: AGHT+IFObe64g8yHGu0QvxHsq+CwSkBURq49auTx3IFoft8wHRZU0csu9NWkwFe0ATMRPTvxjGwBT7kJkbtOJQwk4cM=
X-Received: by 2002:ac8:5f0f:0:b0:4a4:d827:7f93 with SMTP id
 d75a77b69052e-4a9dca9ca39mr4738371cf.0.1752073597764; Wed, 09 Jul 2025
 08:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704060727.724817-1-surenb@google.com> <20250704060727.724817-8-surenb@google.com>
 <f532558b-b19a-40ea-b594-94d1ba92188d@lucifer.local> <CAJuCfpGegZkgmnGd_kAsR8Wh5SRv_gtDxKbfHdjpG491u5U5fA@mail.gmail.com>
 <f60a932f-71c0-448f-9434-547caa630b72@suse.cz> <CAJuCfpE2H9-kRz6xSC43Ja0dmW+drcJa29hwQwQ53HRsuqRnwg@mail.gmail.com>
 <3b3521f6-30c8-419e-9615-9228f539251e@suse.cz>
In-Reply-To: <3b3521f6-30c8-419e-9615-9228f539251e@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 9 Jul 2025 15:06:26 +0000
X-Gm-Features: Ac12FXztVJ5s9fCB7K-LjcBbs5GAqT1LZ8_q7BFwH_XHKRDYfr41flVEbIRKQLo
Message-ID: <CAJuCfpEgwdbEXKoMyMFiTHJMV15_g77-7N-m6ykReHLjD9rFLQ@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, david@redhat.com, peterx@redhat.com, 
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

On Wed, Jul 9, 2025 at 3:03=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 7/9/25 16:43, Suren Baghdasaryan wrote:
> > On Wed, Jul 9, 2025 at 1:57=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz>=
 wrote:
> >>
> >> On 7/8/25 01:10, Suren Baghdasaryan wrote:
> >> >>> +     rcu_read_unlock();
> >> >>> +     vma =3D lock_vma_under_mmap_lock(mm, iter, address);
> >> >>> +     rcu_read_lock();
> >> >> OK I guess we hold the RCU lock the whole time as we traverse excep=
t when
> >> >> we lock under mmap lock.
> >> > Correct.
> >>
> >> I wonder if it's really necessary? Can't it be done just inside
> >> lock_next_vma()? It would also avoid the unlock/lock dance quoted abov=
e.
> >>
> >> Even if we later manage to extend this approach to smaps and employ rc=
u
> >> locking to traverse the page tables, I'd think it's best to separate a=
nd
> >> fine-grain the rcu lock usage for vma iterator and page tables, if onl=
y to
> >> avoid too long time under the lock.
> >
> > I thought we would need to be in the same rcu read section while
> > traversing the maple tree using vma_next() but now looking at it,
> > maybe we can indeed enter only while finding and locking the next
> > vma...
> > Liam, would that work? I see struct ma_state containing a node field.
> > Can it be freed from under us if we find a vma, exit rcu read section
> > then re-enter rcu and use the same iterator to find the next vma?
>
> If the rcu protection needs to be contigous, and patch 8 avoids the issue=
 by
> always doing vma_iter_init() after rcu_read_lock() (but does it really av=
oid
> the issue or is it why we see the syzbot reports?) then I guess in the co=
de
> quoted above we also need a vma_iter_init() after the rcu_read_lock(),
> because although the iterator was used briefly under mmap_lock protection=
,
> that was then unlocked and there can be a race before the rcu_read_lock()=
.

Quite true. So, let's wait for Liam's confirmation and based on his
answer I'll change the patch by either reducing the rcu read section
or adding the missing vma_iter_init() after we switch to mmap_lock.

