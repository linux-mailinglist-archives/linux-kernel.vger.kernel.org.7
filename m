Return-Path: <linux-kernel+bounces-782826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 716C2B325C8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 02:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDB70B6013C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52859224F6;
	Sat, 23 Aug 2025 00:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A9FOgL3T"
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494FE2BD11
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908867; cv=none; b=KUP2/nDIPSojsekjdi5ZXwmFNiFoUysFIH72d6iMZftwN/Tg2QPHR9gcH/XgqdR1xWVuwLd19nHQ4640Mp3a0obom7yaK9HaWK+aQa/Ov8aH5rxCVvOPsmiXdlNi6biiHEDkDox3ycLKBnsX+3KTC0878+Ip0rq6TVDnXyHjO9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908867; c=relaxed/simple;
	bh=IJ2EgA4PMU8jKiLbI6D6sQEpVy/SdYV6CoTn8B7UEN4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NMZhUks2kml88dtcYgrOaeeHYmOiItBjT8fIe89+naCYKdHaT1e8rPGy7haGnfCZIZ+ijn9Gxk4j8DMnq/V3yT132pcib8U6ZJZHIKVoILEYCwz8IJZ0bukStBg+TrBFzZi9PrOCNw+bX5t7XgyShIOoVciY0rfYOktNg6DWzE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A9FOgL3T; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0ED8014000C9;
	Fri, 22 Aug 2025 20:27:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 22 Aug 2025 20:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755908864; x=1755995264; bh=3EJfbfJCcNsDCVVmWo9KKi5NcVI7ubF/vZ1
	wxrk7GFo=; b=A9FOgL3TB2Te/4b/RvoI2duMblc4j+JC/Vl9DYV1qfgVRU3BFJW
	8XvsmXR4mYEtmx2R7VzK6JAn/OjtYFiJwn6KCkcrP2ngRKTdeD+6KE9eJSAzPTLT
	RlwR1x6GlkTPWjpi9In2UL/Nkt5wre7mPG+uZpluh8QaNbFpTdzvGyqdnZWb4Sv+
	BN6PZKEgfiSDYiRFTDTQDB/Rs6JNQycRIt6Avl2hVdIFzSPIif4gBMHukF50/NoO
	IfEAnwaGn6KHNb/YC46ymgBhicUDelC9EHO0AhmraRUU3hUM21vD+TPj+6Ll3lIn
	dRchtiaHZTP1No+6sR5KQ9ulTINscYcfxrw==
X-ME-Sender: <xms:_QqpaAeW26jjmZ0KDQT1TAzQlZ0-jteAO8QnWYnvV-IO3JtnedX0yA>
    <xme:_QqpaJ2jdIaAcxzPKCyaiuhYmCAqXvX-WKjSv-5nOa9W3x4XqCN9T-mLrSnz9_zwF
    2IQ8jWDmKG89Jj9le4>
X-ME-Received: <xmr:_QqpaBu_LRvYiBjDRZFN7Rp5xYQ5kc7wjH8zwwgwbIkstt4eBIOeKPFIG8RXIXKG5ScV5eg9e6mfKYvW5guYelkKQP8GBZmRZqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieehvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopedvfedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgrnhgtvgdrhigrnhhgsehlihhnuhigrd
    guvghvpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghp
    thhtohepmhhhihhrrghmrghtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhpmh
    eslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepfihilhhlsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopehl
    ohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhhnrgdrshgthhhumh
    grkhgvrhesohhrrggtlhgvrdgtohhm
X-ME-Proxy: <xmx:_QqpaN-F0qnA6n9LAA3KakdA6gMInLh4d-tvCSpjWKwFFdHH5_ZVNw>
    <xmx:_QqpaNQAjwRkmGcBKD9ysNPqX1wKdPw-Z_VvKlZlCendTh4Vxwndkw>
    <xmx:_QqpaLBuDNXQLDsa4jrRlC70DChRyfomhlcwrcJnw_Xcey5rxOe4Zw>
    <xmx:_QqpaGY0To6pwBe2UDds7EJA3JO7oUrdVYyVwLeCzJsRwavDS4osRQ>
    <xmx:AAupaPG0JBmZTRLoj2IL0dROUsIKlZfSVH-oxEZUkxm1Qo9gB8sUREB6>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 20:27:39 -0400 (EDT)
Date: Sat, 23 Aug 2025 10:27:27 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Lance Yang <lance.yang@linux.dev>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, mhiramat@kernel.org, 
    akpm@linux-foundation.org, will@kernel.org, peterz@infradead.org, 
    mingo@redhat.com, longman@redhat.com, anna.schumaker@oracle.com, 
    boqun.feng@gmail.com, joel.granados@kernel.org, kent.overstreet@linux.dev, 
    leonylgao@tencent.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org, 
    tfiga@chromium.org, amaindex@outlook.com, jstultz@google.com, 
    Mingzhe Yang <mingzhe.yang@ly.com>, Eero Tamminen <oak@helsinkinet.fi>, 
    linux-m68k <linux-m68k@lists.linux-m68k.org>, 
    Lance Yang <ioworker0@gmail.com>, senozhatsky@chromium.org
Subject: Re: [PATCH v5 2/3] hung_task: show the blocker task if the task is
 hung on semaphore
In-Reply-To: <d0fe3163-32d9-4d81-81bb-d964f2f43f17@linux.dev>
Message-ID: <6ec95c3f-365b-e352-301b-94ab3d8af73c@linux-m68k.org>
References: <20250414145945.84916-1-ioworker0@gmail.com> <20250414145945.84916-3-ioworker0@gmail.com> <CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com> <da53a828-137a-4efc-a192-a2b49a06d050@linux.dev> <CAMuHMdVTBSq2D+-rzGTr+Fz52sDFeeApUcG=LdDYBO5sY+rQxQ@mail.gmail.com>
 <d0fe3163-32d9-4d81-81bb-d964f2f43f17@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Sat, 23 Aug 2025, Lance Yang wrote:

> > 
> > include/linux/hung_task.h-/*
> > include/linux/hung_task.h- * @blocker: Combines lock address and blocking type.
> > include/linux/hung_task.h- *
> > include/linux/hung_task.h- * Since lock pointers are at least 4-byte aligned(32-bit) or 8-byte
> > include/linux/hung_task.h- * aligned(64-bit). This leaves the 2 least bits (LSBs) of the pointer
> > include/linux/hung_task.h- * always zero. So we can use these bits to encode the specific blocking
> > include/linux/hung_task.h- * type.
> > include/linux/hung_task.h- *

That comment was introduced in commit e711faaafbe5 ("hung_task: replace 
blocker_mutex with encoded blocker"). It's wrong and should be fixed.

> > include/linux/hung_task.h- * Type encoding:
> > include/linux/hung_task.h- * 00 - Blocked on mutex
> >   (BLOCKER_TYPE_MUTEX)
> > include/linux/hung_task.h- * 01 - Blocked on semaphore
> >   (BLOCKER_TYPE_SEM)
> > include/linux/hung_task.h- * 10 - Blocked on rw-semaphore as READER
> >   (BLOCKER_TYPE_RWSEM_READER)
> > include/linux/hung_task.h- * 11 - Blocked on rw-semaphore as WRITER
> >   (BLOCKER_TYPE_RWSEM_WRITER)
> > include/linux/hung_task.h- */
> > include/linux/hung_task.h-#define BLOCKER_TYPE_MUTEX            0x00UL
> > include/linux/hung_task.h-#define BLOCKER_TYPE_SEM              0x01UL
> > include/linux/hung_task.h-#define BLOCKER_TYPE_RWSEM_READER     0x02UL
> > include/linux/hung_task.h-#define BLOCKER_TYPE_RWSEM_WRITER     0x03UL
> > include/linux/hung_task.h-
> > include/linux/hung_task.h:#define BLOCKER_TYPE_MASK             0x03UL
> > 
> > On m68k, the minimum alignment of int and larger is 2 bytes.
> 
> Ah, thanks, that's good to know! It clearly explains why the
> WARN_ON_ONCE() is triggering.
> 
> > If you want to use the lowest 2 bits of a pointer for your own use,
> > you must make sure data is sufficiently aligned.
> 
> You're right. Apparently I missed that :(
> 
> I'm wondering if there's a way to check an architecture's minimum 
> alignment at compile-time. If so, we could disable this feature on 
> architectures that don't guarantee 4-byte alignment.
> 

As Geert says, the compiler can give you all the bits you need, so you 
won't have to contort your algorithm to fit whatever free bits happen to 
be available. Please see for example, commit 258a980d1ec2 ("net: dst: 
Force 4-byte alignment of dst_metrics").

> If not, the fallback is to adjust the runtime checks.
> 

That would be a solution to a different problem.

