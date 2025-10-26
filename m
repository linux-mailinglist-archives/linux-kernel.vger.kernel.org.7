Return-Path: <linux-kernel+bounces-870307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F3DC0A6DB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E34189EDB5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C024D2652AF;
	Sun, 26 Oct 2025 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceDAd8OH"
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B270253F05
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761480787; cv=none; b=Gf9tWRTM5LjGrronmIr3rrQkZYeti8TiEFHh/nDcH4+He/N/PQ/1l2gp0O4GrfBSgimWUH5FiCLoEr2bt3bJEILghFtFJzptNuUvaZOsaNF65h4lC65aeslbRWQs4Df0R3M2hyVLFZPjZUVUcOWJQ1xVPjqogZEMoXBB6ClL3po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761480787; c=relaxed/simple;
	bh=fSAfFGnWpYn/dZ6LVH9R+UmFT4gpUozqFi1yTtvIhew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1iCKvTf7BaVTT4euOFBcarMPNCStYp2ZvRkXlHvB9jA9buHTR4uND4sUUcQkN4sQU2csX5wIky+yjWi4ntuFe6QGXBUfIlbtXRAMxt03v5Cl+afSsb4hECReV361Xkiyhyx7OXzXOQt+aWA8qGnxyZ0pfTpT8Hgrs9yOkaN7lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceDAd8OH; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63e35e48a27so3690038d50.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 05:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761480784; x=1762085584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSAfFGnWpYn/dZ6LVH9R+UmFT4gpUozqFi1yTtvIhew=;
        b=ceDAd8OHWEm80qmRg0qiGGmqcq6L4pAkRfQcKlyeuFcq6EHGucmMM1Q1xR2+ggNd2Q
         Vls+TguJ/U63PlGzld61bezxS3aIfUlifkT248kupP8yrcaLQ3wPKpz05A+9OKhg0lkV
         sfUd69gp0wAGuurkLUcXh8Uf+FpKUeNfsUjZrZ74tXCbiF/DQMLsjfG3iZfFQFjPGQ9Z
         3ZXlXnCb1bvdu0XEZOrMwdsz1pUJndQK2YkYys8Yya9hsuzn4T7RvBqQ3Bm3qNnBrhOw
         fOTe3vQrNeSrcw5njspziVwF4gG9FNrZ14a4rIj0+RtranyYD5WScGhh+yTAakL+qMAe
         3Asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761480784; x=1762085584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSAfFGnWpYn/dZ6LVH9R+UmFT4gpUozqFi1yTtvIhew=;
        b=o3vAqMkJJs0czgrGlI6hxKc59PSav5qxZ47S0VYQB1h1CNdFipl9CYjEnNuDJMWf98
         OHzOlSa/lwXhsN6dYnP01KC/nTysdQ8FyVb/pWZspqbsT+Q7FRHOuLajTPxBq/R5Suyo
         RioW8wLCDks/atfofMD6r/2gB09ojvnchjMg3RHQCyGsK9P4pbsJ8juIqc1ejCHE5fq/
         Lr6HqkagKpnPH7FQNGO0vCpnpvlKs2fG+K6gB7hEvzAVSWJaOGTIB3RNGaQZBSj+h0l3
         etJ8mfnPi7MT1Vy4XWkPxQHOmHJ8bX5ak594rtGXPy0BUeEGsUbY/AmScKKuzdhJi+1X
         F7NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKqfArEKzscAiDit4wLAvyt9yUFmFwQiH/Lzu48rrDXL+yfgO7cYxlDjLk0wsc+n08Jp25qZHCpkBTZ0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ6W7id/EaTaznumZ92jyWkXPm1RD2ZP81RN1uru3eYT90L+65
	J8IuUkgsbcm6F7y+4bFoBgjNMyN25DYZeizCzNrgOoUc8DLNK2NcYNQmVxIAQE5RBK0sffxWzja
	rel4qBqevInv6RRy6ikyC28/pRkD8HcE=
X-Gm-Gg: ASbGncuLrX1dgMyo7P4oJk9SSVNZNjPMt80R4J3+ugztO2BkFsShrM0XYHn/L6+RgG3
	T7T0pgvcazcyk0SuZHNxcoIwn4kG1cAEUI49iGE3ymlCLCbPMMKvmYVXHWrDPhQZTDsgmLuKl1u
	TXxrL4EQjP077rE61q7zsyLZ46k3o327uEayCKXpX/m0Bl5NUESogSus6okg9EfzWtXU1DuflAm
	JG7vVTG/+iVORzv5cf3WNFBj8ECcRKElkPzR/40VY/Me5P8Wb5OkSOA8vXJ6ZDdk5v6ftjP
X-Google-Smtp-Source: AGHT+IG7PGd0U1694qdjVf5ZY8i0ed+hvlevVbZGyO1DN04H3gVvS6A5MEP2qMY4ZXrpbiRWoYwLMS6Eww9iMDtwDCQ=
X-Received: by 2002:a05:690e:d8f:b0:63f:35b3:aa7c with SMTP id
 956f58d0204a3-63f35b3ac7fmr9475382d50.4.1761480783993; Sun, 26 Oct 2025
 05:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aPpv8sAa2sYgNu3L@shell.ilvokhin.com> <aPstDXRerYqi1O2X@tiehlicka> <aPtg1vUnpkaK1Ce5@shell.ilvokhin.com>
In-Reply-To: <aPtg1vUnpkaK1Ce5@shell.ilvokhin.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 26 Oct 2025 20:12:27 +0800
X-Gm-Features: AWmQ_bklbQ8LeCAd8iCMkzhDl9gft9WmH6KmOChrMON5i99JpRRIVdnJ-oHNJR0
Message-ID: <CALOAHbDneRGZFGcTM0YuObcK0Ugctb+6Hsxvkcy=76xDmgYapg@mail.gmail.com>
Subject: Re: [PATCH] mm: shmem/tmpfs hugepage defaults config choice
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 7:23=E2=80=AFPM Dmitry Ilvokhin <d@ilvokhin.com> wr=
ote:
>
> On Fri, Oct 24, 2025 at 09:38:53AM +0200, Michal Hocko wrote:
> > On Thu 23-10-25 18:12:02, Dmitry Ilvokhin wrote:
> > > Allow to override defaults for shemem and tmpfs at config time. This =
is
> > > consistent with how transparent hugepages can be configured.
> > >
> > > Same results can be achieved with the existing
> > > 'transparent_hugepage_shmem' and 'transparent_hugepage_tmpfs' setting=
s
> > > in the kernel command line, but it is more convenient to define basic
> > > settings at config time instead of changing kernel command line later=
.
> >
> > Being consistent is usually nice but you are not telling us _who_ is
> > going to benefit from this. Increasing the config space is not really
> > free. So please focus on Why do we need it rather than it is consistent
> > argument.
>
> Thanks for the feedback, Michal, totally make sense to me, I should have
> expand on this point in the initial commit message.
>
> Primary motivation for adding config option is to enable policy
> enforcement at build time. In large-scale production environments
> (Meta's for example), the kernel configuration is often maintained
> centrally close to the kernel code itself and owned by the kernel
> engineers, while boot parameters are managed independently (e.g. by
> provisioning systems). In such setups, the kernel build defines the
> supported and expected behavior in a single place, but there is no
> reliable or uniform control over the kernel command line options.
>
> A build-time default allows kernel integrators to enforce a predictable
> hugepage policy for shmem/tmpfs on a base layer, ensuring reproducible
> behavior and avoiding configuration drift caused by possible boot-time
> differences.

I'd like to better understand your kernel deployment strategy. Are you
maintaining separate kernel images for different environments in your
fleet? We've found that this approach can introduce significant
maintenance complexity in the build system.

In our practice, we standardize on a single kernel image across all
environments and handle variations through dynamic boot parameters.
This approach is quite straightforward to implement. If you're
concerned about uncontrolled environments, you could set default
values like shmem_enabled and tmpfs_enabled to 'never', then
explicitly enable them only in approved environments.

>
> In short, primary benefit is mostly operational: it provides a way to
> codify preferred policy in the kernel configuration, which is versioned,
> reviewed, and tested as part of the kernel build process, rather than
> depending on potentially variable boot parameters.
>
> I hope possible operational benefits outweigh downsides from increasing
> the config space. Please, let me know if this argument sounds
> reasonable to you, I'll rephrase commit message for v2 to include this
> reasoning.
>

--=20
Regards
Yafang

