Return-Path: <linux-kernel+bounces-622611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667B5A9E9B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 09:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C901727BE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 07:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BC31DF735;
	Mon, 28 Apr 2025 07:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BvhsmWnE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726571CEADB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 07:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745826143; cv=none; b=ZOtUR0S1CDpw/ZmUhljcg1OEM/fRct2G3ltl78W7caB8MqQQn7UCHSZb2Waeuf34HaNltxzmmi/8HuxwFvmwKBY5HPk0lHp8DCdKKqJSV+t4H9AabYoTWLUSWTY9R0kuKA+5pfIOikRpx8/whPcXZlwyTCQ024ed44wt30KcetY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745826143; c=relaxed/simple;
	bh=RO4fe7hF3YRJO+Sakz3qlIuEQu+QpUlcCFkVjyWJZoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1I5+p0JZcQGz7uoGD0SmVycQMwT6wJu9/MX2M2tGn+G7uH3i57bDSApXfRvNZqG4junm6gmo1ZDKp6mP9aWW5AN4dmtwS0yljQ8Z6sgqMy24RiuD+dICFVd1ssMbkJVCzv4TtyMVjrjkovvTZBNXPrJhBO2aR2GMxbDfEw+28s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BvhsmWnE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745826140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dpj7I8mgxfJqgam51CzzudZUWclMLZg1KKSrTJW4zYg=;
	b=BvhsmWnEqyNYNCIOmCz5HCnXmGQyaybbRz7mlkHGHx/lm2YQczr6dglfcWTQpt4Ny1jtog
	G5DDEbqSIp82RaY3kcWJncAU+el3Z1CnZY+JyaUXP1iY7thdiV9Y7GDFQt6hXUFHhwPSin
	PaPMUIYDaAg/19biSWLGBbepVJAJJg0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-x2yU-W0hMjKz4u5apKOdWA-1; Mon, 28 Apr 2025 03:42:16 -0400
X-MC-Unique: x2yU-W0hMjKz4u5apKOdWA-1
X-Mimecast-MFC-AGG-ID: x2yU-W0hMjKz4u5apKOdWA_1745826135
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac2aa3513ccso318162766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 00:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745826135; x=1746430935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpj7I8mgxfJqgam51CzzudZUWclMLZg1KKSrTJW4zYg=;
        b=tOkcUHY8I46XT4Lmc2nm6A7CP2XxJklAxnrnqHa397LiAbtiyjBpGsn4x0/bcxmcW1
         oA2jNKqvqS8nWnCBKSp2IY2U2P5wTh1H0LuUSzjFv6NsJ6OVkPHw5MHnjy/amSvZLBzT
         ILGsLy4E0UuXbDWhB5Vtl/21DfpJedcjuy4+Xja5S6yKDJ0DKe4jpcK3af2LbI5oifqy
         2+4J1XdQMKbu4auANWbECsRxKV7Kei6j3AfxpFo09bBFD3JB3ddFpvebsjTv76EYy1/z
         ulhJhqzOQh/1oS4OOS8jtMMO1NReVuJkA66MaFZLdGm7xY9pTfkLSxg6yD88CMFDWoB3
         FTPg==
X-Forwarded-Encrypted: i=1; AJvYcCXCeSRX0Q4tbxR7/MHDcdAd7g6PXf0zlFBnB+6HdPz5i2oBD0fsKc40WUPNzopOk1qXvMI7UrxqwhHJLU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy8ihkOAiczxWOR4KmfpyJyR4NECGHjD8buuzYTwvtaCxZiyLp
	/KrF4e5vAIn/PHtd/laMVE4nTlojqQh70PPUrS9ev9Sf/6IpkBq5x/gI9H28ZIqA6/bT4UKY5kh
	muKJ794q/TOooLaqViaMkqJyBdK7UxRBQS2Ni3mHkUNUuwZNZo3aFBnZcvvZ1oA==
X-Gm-Gg: ASbGnct+EpHuuU8IR/K7994l7E8rg4W+PoAwEEBml3HAZ0SG7UTAmxNCEZdF9PydyvE
	AoZHY/CPRQVN15o7+NBihS3QhUqRfDo+5tEeqxnoGQcwxbRb8PkJhjAX044YCdNb5WjXFGBNz/1
	JxwyDeAI2cHLt9vGwpRgwQniowTZwBg6OlOZqDneKrLYT3DgFwhm0cXjvP1IcYkjnl9b5KgcQrx
	cSCTkqHWbtW5Whja0hf0rs+aYGQcSpL8tQIt2U+k4adokB19BjLo7kaJcOmg7/mdTRmL843fwf1
	CyxORzoTBdXtzn8O2A==
X-Received: by 2002:a17:907:1c27:b0:ac4:3cd:2cb2 with SMTP id a640c23a62f3a-ace7104e5d8mr1000674866b.1.1745826135422;
        Mon, 28 Apr 2025 00:42:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXzAr0+bjExObNijhwwYl1i6kI6R1HoChQXPYHAU+nUMCp81+2mz+T7WI44sNlBU3yht/5vw==
X-Received: by 2002:a17:907:1c27:b0:ac4:3cd:2cb2 with SMTP id a640c23a62f3a-ace7104e5d8mr1000672266b.1.1745826134717;
        Mon, 28 Apr 2025 00:42:14 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.219.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e4e70bbsm587228966b.63.2025.04.28.00.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 00:42:14 -0700 (PDT)
Date: Mon, 28 Apr 2025 09:42:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Ingo Molnar <mingo@kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, mst@redhat.com
Subject: Re: [mainline]Warning while building tools/perf
Message-ID: <CAGxU2F4X2TYM+fD-TnLjTPd+AcwSccREBnO1+geSFs-KVM4kRg@mail.gmail.com>
References: <9c40ab1a-3d08-4af8-a430-0ba245842959@linux.ibm.com>
 <43507075-ec04-44c8-a95f-49e074d933d8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43507075-ec04-44c8-a95f-49e074d933d8@linux.ibm.com>

On Fri, 25 Apr 2025 at 18:07, Venkat Rao Bagalkote <venkat88@linux.ibm.com> wrote:
>
>
> My bad, missed to mention the warning in the previous mail.
>
> On 25/04/25 9:32 pm, Venkat Rao Bagalkote wrote:
> > Hello,
> >
> >
> > I am seeing a new build warning while building tools/perf on the
> > mainline kernel, with base:
> >
> > commit 02ddfb981de88a2c15621115dd7be2431252c568 (HEAD -> master,
> > origin/master, origin/HEAD)
> > Merge: 30e268185e59 b0b7ee3b574a
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Thu Apr 24 13:01:31 2025 -0700
> >
> >     Merge tag 'scsi-fixes' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> >
> >     Pull SCSI fixes from James Bottomley:
> >      "The single core change is an obvious bug fix (and falls within
> > the LF
> >       guidelines for patches from sanctioned entities). The other driver
> >       changes are a bit larger but likewise pretty obvious"
> >
> >     * tag 'scsi-fixes' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi:
> >       scsi: mpi3mr: Add level check to control event logging
> >       scsi: ufs: core: Add NULL check in
> > ufshcd_mcq_compl_pending_transfer()
> >       scsi: core: Clear flags for scsi_cmnd that did not complete
> >       scsi: ufs: Introduce quirk to extend PA_HIBERN8TIME for UFS devices
> >       scsi: ufs: qcom: Add quirks for Samsung UFS devices
> >       scsi: target: iscsi: Fix timeout on deleted connection
> >       scsi: mpi3mr: Reset the pending interrupt flag
> >       scsi: mpi3mr: Fix pending I/O counter
> >       scsi: ufs: mcq: Add NULL check in ufshcd_mcq_abort()
> >
>
> Warning:
>
> diff -u tools/perf/trace/beauty/include/uapi/linux/vhost.h
> include/uapi/linux/vhost.h
>
> >
> > Git Bisect is pointing to below commit as first bad commit.
> >
> >
> > a940e0a685575424d33324ec7f0089045249de0a is the first bad commit
> > commit a940e0a685575424d33324ec7f0089045249de0a

That commit just updated the documentation, no code change.

I guess in tools/perf they copied vhost.h and there is some check to 
control if they are in sync.

CCing Arnaldo who has updated the copy several times.

Thanks,
Stefano

> > Author: Stefano Garzarella <sgarzare@redhat.com>
> > Date:   Mon Mar 3 09:52:37 2025 +0100
> >
> >     vhost: fix VHOST_*_OWNER documentation
> >
> >     VHOST_OWNER_SET and VHOST_OWNER_RESET are used in the documentation
> >     instead of VHOST_SET_OWNER and VHOST_RESET_OWNER respectively.
> >
> >     To avoid confusion, let's use the right names in the documentation.
> >     No change to the API, only the documentation is involved.
> >
> >     Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >     Message-Id: <20250303085237.19990-1-sgarzare@redhat.com>
> >     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> >  include/uapi/linux/vhost.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >
> > Upon reverting the above commit, warning is not seen.
> >
> >
> > Bisect log:
> >
> >
> > git bisect start
> > # status: waiting for both good and bad commits
> > # good: [9c32cda43eb78f78c73aee4aa344b777714e259b] Linux 6.15-rc3
> > git bisect good 9c32cda43eb78f78c73aee4aa344b777714e259b
> > # status: waiting for bad commit, 1 good commit known
> > # bad: [02ddfb981de88a2c15621115dd7be2431252c568] Merge tag
> > 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> > git bisect bad 02ddfb981de88a2c15621115dd7be2431252c568
> > # good: [cc0dec3f659d19805fcaf8822204137c9f27a912] Merge branch
> > 'net-stmmac-fix-timestamp-snapshots-on-dwmac1000'
> > git bisect good cc0dec3f659d19805fcaf8822204137c9f27a912
> > # bad: [0251ddbffbeb213f0f74ef94b2cacce580eb8d76] Merge tag
> > 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
> > git bisect bad 0251ddbffbeb213f0f74ef94b2cacce580eb8d76
> > # good: [bc3372351d0c8b2726b7d4229b878342e3e6b0e8] Merge tag
> > 'for-6.15-rc3-tag' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> > git bisect good bc3372351d0c8b2726b7d4229b878342e3e6b0e8
> > # bad: [fbd3039a64b01b769040677c4fc68badeca8e3b2] virtio_console: fix
> > missing byte order handling for cols and rows
> > git bisect bad fbd3039a64b01b769040677c4fc68badeca8e3b2
> > # bad: [a940e0a685575424d33324ec7f0089045249de0a] vhost: fix
> > VHOST_*_OWNER documentation
> > git bisect bad a940e0a685575424d33324ec7f0089045249de0a
> > # good: [16c22c56d4282584742022a37d4f79a46ca6094a] virtio_pci: Use
> > self group type for cap commands
> > git bisect good 16c22c56d4282584742022a37d4f79a46ca6094a
> > # first bad commit: [a940e0a685575424d33324ec7f0089045249de0a] vhost:
> > fix VHOST_*_OWNER documentation
> >
> >
> > If you happen to fix this, please add below tag.
> >
> >
> > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> >
> >
> > Regards,
> >
> > Venkat.
> >
>


