Return-Path: <linux-kernel+bounces-785758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC8EB350B8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E573E1A86EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 01:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922232641D8;
	Tue, 26 Aug 2025 01:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y8XBmyN0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED39985C4A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 01:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756170333; cv=none; b=Csy8SjCUs+cmA004gZ2dtSK6L5l1abu7LxkxgeEvCuyhsB9tW8jlXoEiO4AKupqAqbI5rC1x/WvE8zN7rxunw4dHJfa2J1R5h56O2W6Mu1U4zr+GL+OPTSSpKSp0Jska5paoAE/CW8l9oWYGph4tbcXiwN/k1cGV7ciXGVLyo1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756170333; c=relaxed/simple;
	bh=9t+LpWoHJIsYPbMjiU2USC8E5Wcpyq+n6+4DJhGHFvo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I8xXCWRwRHY/zXqrzxuTEU7/3oRtLB2+5cID4AWlEbIqU/OG4v58CsZAschD6ugMYi9Bw2d9wGJoFZA4yzTnDEaTcJRcU951Qt4NhsJdgsFt3ME1wxCZWLPhupswGNqU3YzMjguJXxvyIzxSL8zZLJzEXS3906rAHnKUYEHMuXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y8XBmyN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1935C4CEED;
	Tue, 26 Aug 2025 01:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756170332;
	bh=9t+LpWoHJIsYPbMjiU2USC8E5Wcpyq+n6+4DJhGHFvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y8XBmyN0f/0MgGjeKimTUShtaB8EhLKUUrrmRMR3IbngvR7S1rg8rHkhnN78HfAhX
	 DkF1xazVTsIy6tOSICzsHTiycb3Y3thNj93LolbqqMl4AQS5gOJlcJyEdyCIp+1zxZ
	 rCJn2sE5Sff8NjTQL5EKgcgv+i4W35W228YHKaoo=
Date: Mon, 25 Aug 2025 18:05:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Coiby Xu <coxu@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, kexec@lists.infradead.org, Ondrej
 Kozina <okozina@redhat.com>, Milan Broz <gmazyland@gmail.com>, Thomas
 Staudt <tstaudt@de.ibm.com>, Daniel P . =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, Pingfan Liu
 <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Young
 <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Dave
 Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, Jan Pazdziora
 <jpazdziora@redhat.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 1/8] kexec_file: allow to place kexec_buf randomly
Message-Id: <20250825180531.94bfb86a26a43127c0a1296f@linux-foundation.org>
In-Reply-To: <yng55a2z25m5upehczerzhi6zawe3j4ka7amfu4vw4cu27bbg2@x2lgbuk3iqyf>
References: <20250502011246.99238-1-coxu@redhat.com>
	<20250502011246.99238-2-coxu@redhat.com>
	<oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3>
	<yng55a2z25m5upehczerzhi6zawe3j4ka7amfu4vw4cu27bbg2@x2lgbuk3iqyf>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 09:18:53 +0800 Coiby Xu <coxu@redhat.com> wrote:

> >diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> >index 532d72ea42ee8..287b25e674d76 100644
> >--- a/arch/arm64/kernel/kexec_image.c
> >+++ b/arch/arm64/kernel/kexec_image.c
> >@@ -76,6 +76,7 @@ static void *image_load(struct kimage *image,
> > 	kbuf.buf_min = 0;
> > 	kbuf.buf_max = ULONG_MAX;
> > 	kbuf.top_down = false;
> >+	kbuf.random = 0;
> >
> > 	kbuf.buffer = kernel;
> > 	kbuf.bufsz = kernel_len;
> >
> 
> And also thanks for posing a fix! The patch LGTM. Can you add a Fixes
> tag 'Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf
> randomly")' and then send it to kexec@lists.infradead.org? Thanks!

I turned all this into a regular patch and queued it (see below),
thanks.  No additional actions are needed.

I'm really not liking that code.  I laboriously verified that all
fields of kexec_buf are now initialized, except for `cma'.  Is that a
bug?

This function has a call frequency of about 3x per week.  Can we please
just memset the whole thing so people don't have to worry about this
any more?


From: Breno Leitao <leitao@debian.org>
Subject: kexec/arm64: initialize the random field of kbuf to zero in the image loader
Date: Thu Aug 21 04:11:21 2025 -0700

Add an explicit initialization for the random member of the kbuf structure
within the image_load function in arch/arm64/kernel/kexec_image.c. 
Setting kbuf.random to zero ensures a deterministic and clean starting
state for the buffer used during kernel image loading, avoiding this UBSAN
issue later, when kbuf.random is read.

  [   32.362488] UBSAN: invalid-load in ./include/linux/kexec.h:210:10
  [   32.362649] load of value 252 is not a valid value for type '_Bool'

Link: https://lkml.kernel.org/r/oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3
Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf randomly
Signed-off-by: Breno Leitao <leitao@debian.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Coiby Xu <coxu@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Liu Pingfan <kernelfans@gmail.com>
Cc: Milan Broz <gmazyland@gmail.com>
Cc: Ondrej Kozina <okozina@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/arm64/kernel/kexec_image.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/kernel/kexec_image.c~kexec-arm64-initialize-the-random-field-of-kbuf-to-zero-in-the-image-loader
+++ a/arch/arm64/kernel/kexec_image.c
@@ -76,6 +76,7 @@ static void *image_load(struct kimage *i
 	kbuf.buf_min = 0;
 	kbuf.buf_max = ULONG_MAX;
 	kbuf.top_down = false;
+	kbuf.random = 0;
 
 	kbuf.buffer = kernel;
 	kbuf.bufsz = kernel_len;
_


