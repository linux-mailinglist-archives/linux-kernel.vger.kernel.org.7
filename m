Return-Path: <linux-kernel+bounces-789311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9250CB393C9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59CB3205BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A231124A046;
	Thu, 28 Aug 2025 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b/WxGr7+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HCWS8eRt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B21013DDAA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756362736; cv=none; b=WaimKZokfq4MufZO21y3gsgoyrUv6EYfk/r9pwoaYVz4a6o7DOysOJWqiKWxUaD0JfcUitsXZlhWsxca/GkBktcPAaF9ByRPTHw1NhCL9nx661+sqRbmxon2Ci1eGtEpb9DU5tm2LPQOcxGmnSgLXdsezuDCK/7bnLDkaKnF46Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756362736; c=relaxed/simple;
	bh=b/6wVIc2eK9oO/vtAOEBW9WbL9AC2Yb6EtMmDI2rGvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5WPrz9sHplAf9MeknulaplhJJJnrohN7xsuhoY/3uneg+u9bUwe3xRGJxMveaKpp8wIltOPKWuhNlcyl4htlWzu6nBUxpCVD+unLUiHDCGrhptk3qAACy4CczI3HlaVCNwN7i6ozOKqEjVM2ds0Tq7+lVmHLqe1SovTzr0QP9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b/WxGr7+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HCWS8eRt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 28 Aug 2025 08:32:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756362732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zeXvl9rWyQ+AyXYarOAzt5ngzr4AnZGT+81doiYne2s=;
	b=b/WxGr7+3JU7anpOWZatoNobPZdpln6pspZGgFv5QoSPqvYnVfAcRBAdF9bJLGGy1f98bk
	1E+5/YQ1AfVtmrLhEYTVc4F23lkp3JIziFDmKsbCkaADBX3zdGSyiQ/1WqXpxrmRBLZ5VA
	Tg9EKRn1ZYBLnP8856qQKbVlToHx4GE+Js12KFmdsjbhnw4upq8kb33tqY5SvfmCvEiq/C
	kS2AYCr2W3uj9ZBvVEvcfp0zt3OgLVl8b/hfqPvj64hDgm/buA6uW96mN7DSDNlibA3676
	oOnsSIdxOnPamH3Na7+/QD0bwad4EEJzWoJZzCjkNMBXEEljQCQBA812yUrdag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756362732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zeXvl9rWyQ+AyXYarOAzt5ngzr4AnZGT+81doiYne2s=;
	b=HCWS8eRtKadzblK0l11lpueI9CqURbTlQqEHWQ/erwU0PZyAvGSmgI0gHQ41pk+/c8LK/E
	zPjUyb60OuN248Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <llong@redhat.com>
Cc: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Borislav Petkov <bp@alien8.de>, kernel-dev@igalia.com
Subject: Re: [PATCH] selftests/futex: Fix futex_numa_mpol's memory out of
 range subtest
Message-ID: <20250828063211.h-gpZAEb@linutronix.de>
References: <20250827154420.1292208-1-andrealmeid@igalia.com>
 <9d4c0d27-0ebd-4c6d-af38-d32ef420fde4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9d4c0d27-0ebd-4c6d-af38-d32ef420fde4@redhat.com>

On 2025-08-27 13:58:50 [-0400], Waiman Long wrote:
> On 8/27/25 11:44 AM, Andr=C3=A9 Almeida wrote:
> > --- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
> > +++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
> > @@ -168,6 +168,17 @@ int main(int argc, char *argv[])
> >   	ksft_set_plan(1);
> >   	mem_size =3D sysconf(_SC_PAGE_SIZE);
> > +
> > +	/*
> > +	 * The "Memory out of range" test depends on having a pointer to an
> > +	 * invalid address. To make this test deterministic, and to not depend
> > +	 * on the memory layout of the process, create a "buffer zone" with
> > +	 * PROT_NONE just before the valid memory (*futex_ptr).
> > +	 */
> > +	buffer_zone =3D mmap(NULL, mem_size, PROT_NONE, MAP_PRIVATE | MAP_ANO=
NYMOUS, 0, 0);
> > +	if (buffer_zone =3D=3D MAP_FAILED)
> > +		ksft_exit_fail_msg("mmap() for %d bytes failed\n", mem_size);
> > +
> >   	futex_ptr =3D mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVA=
TE | MAP_ANONYMOUS, 0, 0);
> >   	if (futex_ptr =3D=3D MAP_FAILED)
> >   		ksft_exit_fail_msg("mmap() for %d bytes failed\n", mem_size);
>=20
> This patch makes the assumption that consecutive mmap() calls will alloca=
te
> pages consecutively downward from a certain address. I don't know if this
> assumption will be valid in all cases. I think it will be safer to just
> allocate the 2-page memory block and then change the 2nd page protection =
to
> PROT_NONE to make it a guard page.

You shouldn't make any assumption about mmap()'s returned pointer unless
you pass it as the addr argument and expect it to be followed.
Using two pages and making the second a guard page sounds sane.

> Cheers,
> Longman

Sebastian

