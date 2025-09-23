Return-Path: <linux-kernel+bounces-828152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C85AB94108
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E8618A49C8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC011DDA09;
	Tue, 23 Sep 2025 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FCLFePm9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FA8223DFD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758596853; cv=none; b=XYAGgBk6RJAw7o3sL0lttxF5DkhBnROPzE9SqqYZUyTCvX+Yyc2pLmpHzIeMDRiVct//RAmVCAGdMhdfkfNoqCjn7W74ng4pDm+h+QmRWL/5CsTBqNKF2aiatax8/eKzTKX8iF5keRBd/UXMW2Q3UVewhfDWy7igfUVw0Fuum6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758596853; c=relaxed/simple;
	bh=86Xxar4vRcinCahBFuQlLC0lBKykHJS+rMOTXHO6mII=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mv230VB3e4kRivN9I+H3myU+TraMZPFFOFiWfpPsm4KF/argysia0bXOqRdtTp+0EdR3ooURHOtEnJ1gkw9x4d4COylzAj45FAinahyb6W+3IdqzqE+ilcepO846JhWTkR1s5uwfebNZv2t3efwbbN5pOFcUobvtkDPHM4QZovA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FCLFePm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9E6C4CEF0;
	Tue, 23 Sep 2025 03:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758596852;
	bh=86Xxar4vRcinCahBFuQlLC0lBKykHJS+rMOTXHO6mII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FCLFePm9McSbrWerrTzJUCkPyWJ2VBkWUJWJn5AUvV0L7dPAgosiGJJ9HOUcqRNjV
	 hSsx0IzVlc77xyTJjUFjjJv/LUVymKA2lgYBpn/U+521SM2afv4V3a9wrkFfrLU0vL
	 2n3t9qAGri3DBNxsTEkbbNmzNZ/D8B89udzneY8o=
Date: Mon, 22 Sep 2025 20:07:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: "Bouron, Justinien" <jbouron@amazon.com>, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, Petr Mladek <pmladek@suse.com>, Mario
 Limonciello <mario.limonciello@amd.com>, Marcos Paulo de Souza
 <mpdesouza@suse.com>, "Graf (AWS), Alexander" <graf@amazon.de>, Steven Chen
 <chenste@linux.microsoft.com>, Yan Zhao <yan.y.zhao@intel.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Kudrjavets, Gunnar" <gunnarku@amazon.com>
Subject: Re: [PATCH] kexec_core: Remove superfluous page offset handling in
 segment loading
Message-Id: <20250922200732.f5c68c706e495635b1536ac2@linux-foundation.org>
In-Reply-To: <aMO5eKSpvwYAtDtX@MiWiFi-R3L-srv>
References: <20250910163116.49148-1-jbouron@amazon.com>
	<aMKZUY/zg31qN+68@MiWiFi-R3L-srv>
	<1659446A-F17C-4FF2-BE1B-3EC37520DDCB@amazon.com>
	<aMO5eKSpvwYAtDtX@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 14:11:04 +0800 Baoquan He <bhe@redhat.com> wrote:

> > int sanity_check_segment_list(struct kimage *image)
> > {
> >     // ...
> >     for (i = 0; i < nr_segments; i++) {
> >         unsigned long mstart, mend;
> > 
> >         mstart = image->segment[i].mem;
> >         mend   = mstart + image->segment[i].memsz;
> >         if (mstart > mend)
> >             return -EADDRNOTAVAIL;
> >         if ((mstart & ~PAGE_MASK) || (mend & ~PAGE_MASK))
> >             return -EADDRNOTAVAIL;
> >         if (mend >= KEXEC_DESTINATION_MEMORY_LIMIT)
> >             return -EADDRNOTAVAIL;
> >     }
> >     // ...
> > }
> > 
> > > That better be explained in log.
> > Does it warrant a second revision to change the log?
> 
> I would appreciate it if we can tell the reason a little bit in patch
> log. Because we have codes as below where people assign a non PAGE_SIZE
> to kbuf.buf_align. With a general conclusion, people need explore code
> to find out. At least that's what I do when I check this patch.
> 
> arch/x86/kernel/kexec-bzimage64.c:
> static void *bzImage64_load(struct kimage *image, char *kernel,
>                             unsigned long kernel_len, char *initrd,
>                             unsigned long initrd_len, char *cmdline,
>                             unsigned long cmdline_len)
> {

I'll drop this patch.  Justinien, please send along an updated version
for the next -rc cycle, thanks.


