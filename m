Return-Path: <linux-kernel+bounces-787577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AC4B37835
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDDDE4E3A57
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA5527A442;
	Wed, 27 Aug 2025 02:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYr5Pzp7"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B76D279DDC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756262298; cv=none; b=smqaLd6ip7PHYZqwjDfNOfKyzbfFQN1VDynZYTU8mBOp9ZpjyN0VNJc8ajzfj8uYUM7/0dJBmjAutSlcntvh42r/ttzxwfMlZXSP0NZOxZql0XHrMtnnoj2LKCppCpf8EKqDG8v40+zmnXFIrpmuOV8hAy6IZa1Gf6bvyzYRN6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756262298; c=relaxed/simple;
	bh=5wxJCGpIeokObW2E4VfhvhJc7jVk8a0u10rPoZD+5Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=El9u+jwAxMXvbv/agHFgE29GKuZiWS4MyGJ2iTe8pB1eyrTjN0DZRtk1dXv7jF0EMK2M+CB3ev5V6TaW63DudlYfeotlOLHv3O18N4wBofLFe9smyjwKlMnxr6ilLy5hFZ1h1N7yBnvAdoN5c14/EQoPqYDP3h5LihknXDlQp/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oYr5Pzp7; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b2f497c230so21451cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756262296; x=1756867096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wxJCGpIeokObW2E4VfhvhJc7jVk8a0u10rPoZD+5Yc=;
        b=oYr5Pzp7BqAnNyTJ16GPaJZqA9hAcFN81I7W2fHA0j93Aani4l51pCvg3PA7MOmx9J
         pfjnCR/XJQAupRDreLJjBdylJfmqgs3u6Ii+kr2ZKOCDESvWjH4g7f91F+dNJ1hjdLBP
         8D4ZWD2XpYQjx16WIcJO0t4SIK3x5Y3NaOBKRERbrETVt2ivhnagYu3f8xIo8p7P+j9P
         3OB/gKpO+uxtG53r/AWKjTzZvBHXYD/O0gkExgVMoFf428TJ/0yQP9XQbiD4romNKN+k
         OhazvQN+ie6xn0+eVHkdVHNSkXaJrtSehrNfCXrTkSJ612EsNKf+6S1Iji6F0D8TqDxY
         TNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756262296; x=1756867096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wxJCGpIeokObW2E4VfhvhJc7jVk8a0u10rPoZD+5Yc=;
        b=Ig3iNLPshWyaow/7Xib7TupigvW1FStgGXCNjrRQ9KrPTwWZC1fTMRA2TXX3gtC2IW
         wCE2yQ3trrmfVlYcNW1lV5S/nm3dE8QuYuXHa0GG+w/EmCSIMek0jz+HlXccVo7odhzh
         dHcyJAeVxyzzJyliK3fe9l4+j9v4/zK6cRLpxjFjU4jMGrf95f6wcLZ4eg4uIe3sUPex
         +qS9wLlVco5XuzUffKUhqkiZkon4PZms7f8S/thFw1fvhODmBlCRpUDSugAqBlOel63+
         SDOLGOsVyHna1bYJ/HPBQl5r9LA7MMXQhMEyUvmQwRf5GUhJuKMzqw1NTuAK1MM7RlvC
         SZ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUAXgHn/RI375+KAu/wtYxeS3Y2TfB/qSa4xsO9sL4n4h1nbf/zz68c2tYIuLXxASer0e1Xeac3FAWMFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTeMEkLYK9fGeqqK1XTGMLsjOCStgRMruHD4CzWWlkJDsqlOAR
	7fARulrMwdH2piDczEVeefJZ2THgpH8vq7knc9jsPnCl3DXe8m0UgGPm3s46IOItJqgj5Zzr0OY
	EdNJ+zwk3Z7nfpimksX1ibyTKZRQ470ETmA6XH1Y/
X-Gm-Gg: ASbGncs9nPRxWeoKmXKeqMxKMz8wwVXtiFitE4zlbiJFvB7m7NMHW6IPMd5r8/K70Ad
	lGKG86cYiJVOerXV/VwKjP1/Pv/6PSorsOSQy6uRDE3eOo1o9UQmGrJ8EWmdSyL18D8OQam0NWG
	aNSlC55BYEQ5q4IQhpEFDuh/4XFF2sgkg3jtXOK08jeDoGExuOMK6TF3JgowvDNot7CMmiNenyg
	3DCJtPgLFk1
X-Google-Smtp-Source: AGHT+IHkXZk/TosAVwTj41F6DTvN5Ue1gIpGD5Bd+VRvHsa7ptTA61c4W57PBx0gyetDnfjQBN0szf7LJNkOGJNQTr0=
X-Received: by 2002:ac8:5dd1:0:b0:4b1:1ba4:208 with SMTP id
 d75a77b69052e-4b2e1d2adcbmr9920991cf.12.1756262295493; Tue, 26 Aug 2025
 19:38:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755190013.git.pyyjason@gmail.com> <6qu2uo3d2msctkkz5slhx5piqtt64wsvkgkvjjpd255k7nrds4@qtffskmesivg>
 <aKdw6Pkj2H4B6QDb@devbig569.cln6.facebook.com> <tiwa6wnkdf6q2pfchxbbqb6r42y7moykqumvnzauckhavyemg2@zc5haja5mlxs>
 <aK2/Vesgr9Xcl5gy@devbig569.cln6.facebook.com>
In-Reply-To: <aK2/Vesgr9Xcl5gy@devbig569.cln6.facebook.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 26 Aug 2025 19:38:03 -0700
X-Gm-Features: Ac12FXzR8HgXh88Fj0tWSjUnqZsqYDqw6O3AKBz5yz6NGnFo6aufDqeqpkJm6Y0
Message-ID: <CAJuCfpHJMSd16j3ANrtJGVfLieHdeO_Epq=U9OKty3TV362ckQ@mail.gmail.com>
Subject: Re: [RFC 0/1] Try to add memory allocation info for cgroup oom kill
To: Yueyang Pan <pyyjason@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sourav Panda <souravpanda@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 7:06=E2=80=AFAM Yueyang Pan <pyyjason@gmail.com> wr=
ote:
>
> On Thu, Aug 21, 2025 at 12:53:03PM -0700, Shakeel Butt wrote:
> > On Thu, Aug 21, 2025 at 12:18:00PM -0700, Yueyang Pan wrote:
> > > On Thu, Aug 21, 2025 at 11:35:19AM -0700, Shakeel Butt wrote:
> > > > On Thu, Aug 14, 2025 at 10:11:56AM -0700, Yueyang Pan wrote:
> > > > > Right now in the oom_kill_process if the oom is because of the cg=
roup
> > > > > limit, we won't get memory allocation infomation. In some cases, =
we
> > > > > can have a large cgroup workload running which dominates the mach=
ine.
> > > > > The reason using cgroup is to leave some resource for system. Whe=
n this
> > > > > cgroup is killed, we would also like to have some memory allocati=
on
> > > > > information for the whole server as well. This is reason behind t=
his
> > > > > mini change. Is it an acceptable thing to do? Will it be too much
> > > > > information for people? I am happy with any suggestions!
> > > >
> > > > For a single patch, it is better to have all the context in the pat=
ch
> > > > and there is no need for cover letter.
> > >
> > > Thanks for your suggestion Shakeel! I will change this in the next ve=
rsion.
> > >
> > > >
> > > > What exact information you want on the memcg oom that will be helpf=
ul
> > > > for the users in general? You mentioned memory allocation informati=
on,
> > > > can you please elaborate a bit more.
> > > >
> > >
> > > As in my reply to Suren, I was thinking the system-wide memory usage =
info
> > > provided by show_free_pages and memory allocation profiling info can =
help
> > > us debug cgoom by comparing them with historical data. What is your t=
ake on
> > > this?
> > >
> >
> > I am not really sure about show_free_areas(). More specifically how the
> > historical data diff will be useful for a memcg oom. If you have a
> > concrete example, please give one. For memory allocation profiling, is
>
> Sorry for my late reply. I have been trying hard to think about a use cas=
e.
> One specific case I can think about is when there is no workload stacking=
,
> when one job is running solely on the machine. For example, memory alloca=
tion
> profiling can tell the memory usage of the network driver, which can make
> cg allocates memory harder and eventually leads to cgoom. Without this
> information, it would be hard to reason about what is happening in the ke=
rnel
> given increased oom number.
>
> show_free_areas() will give a summary of different types of memory which
> can possibably lead to increased cgoom in my previous case. Then one look=
s
> deeper via the memory allocation profiling as an entrypoint to debug.
>
> Does this make sense to you?

I think if we had per-memcg memory profiling that would make sense.
Counters would reflect only allocations made by the processes from
that memcg and you could easily identify the allocation that caused
memcg to oom. But dumping system-wide profiling information at
memcg-oom time I think would not help you with this task. It will be
polluted with allocations from other memcgs, so likely won't help much
(unless there is some obvious leak or you know that a specific
allocation is done only by a process from your memcg and no other
process).

>
> > it possible to filter for the given memcg? Do we save memcg information
> > in the memory allocation profiling?
>
> Thanks
> Pan

