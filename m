Return-Path: <linux-kernel+bounces-874314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB9EC1600E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 858024E2E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454DC346A00;
	Tue, 28 Oct 2025 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP+v+6HS"
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD3633F8B3
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670702; cv=none; b=YBVLp2fdq7ctUBGrQ2v4lhDlDnMld4EE3GAEcchHM7stDxIjlB1/n0liXnJT/dhcYBd/wcEqaN4hgK6lN4Mi3r6yuEYXJIg202RSmz5jJS/Xq63zWLLmrUyPIDGHSZo4uxh0x5yaEk52tgqhBFZmB85U3PQZDAoXteXAih9dGuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670702; c=relaxed/simple;
	bh=S2YK88oreoElX7onfuW9IzclvPMp4++2KYT8+xCMHWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMDA12jFkLiN7KSyGLB/5xbhmwDiKxtm7ESnMtoRsL9kH2HWX3bRQgju1HwNkMYCc/KKdTJ5q32z6/e4Pf10cRMCghWCAbkbBycD2dp0mka7zy3je7i1IR8heyKYK4Mq9JYHk7MUYzrMUWUclValRc7gZrIuucD56xauC6WCpH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP+v+6HS; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so4215613a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761670700; x=1762275500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DKAJWIVdXY6w33OMTqrvcoCl8DNQe+wsI3uiwsncnTY=;
        b=KP+v+6HSTLrwT2OpXu/6ZePmQxEAkhPAipGgDURxgT9q7sDRgYqNlMbr+L35kyIJb/
         9uLXAacqZyxOU8K2o9ccVVnMTUeIFrw0tynFlLkdfJtqWj6hQmeqoje7AwTuNlBztK6L
         1X1mnzj5jo6AODvZUuQ4cyYbUa9VEYnE7KFDUezu0J0E+wwDkuo+ocIToDenWvldHC6N
         bWVVfHwF2ZrHsgjLUte2EQQXuewkUo/4TkV+wFl8Tlc27GmOPfDv35HxSBPfE7JS2Wpx
         GDEy5gNkgwSzZ8i974XhnKrz3weO2/NCv4ouzVmKBU1SeO2cBLSYSZXusU+4GR4PpZkw
         AWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761670700; x=1762275500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKAJWIVdXY6w33OMTqrvcoCl8DNQe+wsI3uiwsncnTY=;
        b=FF727rnJIIUw6U8tjzo7zbOPmBYFR+drr/vRLiVB59F6xnJRSj4bBgbkvSd49M7rJ4
         KWqk0/bPX89vsO3uTs6NbugLWkN6v1Lp6mY6CxYPhVaJtKLD+z/nYHVcn2PTfulRGthR
         br6tCYHMutENCxiUw2JGhZv+9j9QQcw7hi4dpyb3x2TpbKtQigaQzmoEbFiNYGbfXepq
         N89TgTbrKzP4ueR069+CwoMxN+ARpWjHemjn1Y9FC9ewu1MgziRr2SzLP+JhBTiIW3s6
         Ok5hc8xU4hEKlTpj2CZ0C9rOQsHTzf4tE3pYR/H7G6fTCAFipO3acJxjnQJzpWgstV1p
         qekA==
X-Forwarded-Encrypted: i=1; AJvYcCWt0WPFaWVIFRaCpj7k+vK2PuU4zHRpi0ZacK1wFyi4DSAjaVJlF+z1lUeJWu8bhiToHDuH2il/iHLiif8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4pfbX5S3avvTV8Faxb+poOSRiZMaX5gO5rrrRptWTAPqc+sy1
	zPN3BJv6qigZTiuwwhatFstqUG1e/xH00KIp9NQwdnlkeXp43ia03vr0
X-Gm-Gg: ASbGnctggFQ7ZIAGi9zhyuyFYogPaLPSKPZjJuULVEHR7bG3SOxJJYikJue2cVZFhLG
	w9mnfqweqvw45mLHuEDdEq987etFl2uYNWf7dsx5seiVh77f4oGA9e3tCBq81fw8Y8KeefcR/aX
	osusUw5s/fLlZ7Ty3QkV7uJeG7Y9wlMZU68i+k6XE2PTFZlqYv+VoAZ4swo8ho3/L6yokn+cmB8
	aJSTGkOIvX1C3KtsDYxyfRWsHcZC1ttQysvpHqiWig14G+HPlDamZCCYPCvqmNp9waPclbF0yWg
	hzWvhxIo71wmG0mt7EzEoIWVZueVk+7Vr6oNo45G8hZospCJTi0BAr13SM5w9hTqqhrcJLyy9Q1
	w+5/M79u1sKjXJkA4I/K1hcVyQAv3cRdl45FO+cpLe9Z3hS+lp11sCiL+BZ5DXCXevlStQ96UIA
	MxHUoC3GsNy/HHuhufTB0=
X-Google-Smtp-Source: AGHT+IGoWRXRZauvUG5j1zo0Qxhl0gwoNettufvBODgutBswNwVQoMUoNOz0OY25v/QcS1yZJBzGlA==
X-Received: by 2002:a17:903:2f0e:b0:290:c0d7:237d with SMTP id d9443c01a7336-294cb50e4bbmr54429445ad.36.1761670700123;
        Tue, 28 Oct 2025 09:58:20 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4b0csm121255865ad.10.2025.10.28.09.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:58:19 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:28:10 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] selftests/user_events: Avoid taking address of packed
 member in perf_test
Message-ID: <aQD2Igc3svAF3klc@fedora>
References: <20251027113439.36059-1-ankitkhushwaha.linux@gmail.com>
 <20251027162521.c56c7f89f6ad4e3d639c408c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027162521.c56c7f89f6ad4e3d639c408c@linux-foundation.org>

On Mon, Oct 27, 2025 at 04:25:21PM -0700, Andrew Morton wrote:
> On Mon, 27 Oct 2025 17:04:39 +0530 Ankit Khushwaha <ankitkhushwaha.linux@gmail.com> wrote:
> 
> > Accessing 'reg.write_index' directly triggers a -Waddress-of-packed-member
> > warning due to potential unaligned pointer access:
> > 
> > perf_test.c:239:38: warning: taking address of packed member 'write_index'
> > of class or structure 'user_reg' may result in an unaligned pointer value 
> > [-Waddress-of-packed-member]
> >   239 |         ASSERT_NE(-1, write(self->data_fd, &reg.write_index,
> >       |                                             ^~~~~~~~~~~~~~~ 
> > 
> > Use memcpy() instead to safely copy the value and avoid unaligned pointer
> > access across architectures.
> > 
> > ...
> >
> > --- a/tools/testing/selftests/user_events/perf_test.c
> > +++ b/tools/testing/selftests/user_events/perf_test.c
> > @@ -201,6 +201,7 @@ TEST_F(user, perf_empty_events) {
> >  	struct perf_event_mmap_page *perf_page;
> >  	int page_size = sysconf(_SC_PAGESIZE);
> >  	int id, fd;
> > +	__u32 write_index;
> >  	__u32 *val;
> >  
> >  	reg.size = sizeof(reg);
> > @@ -236,7 +237,8 @@ TEST_F(user, perf_empty_events) {
> >  	ASSERT_EQ(1 << reg.enable_bit, self->check);
> >  
> >  	/* Ensure write shows up at correct offset */
> > -	ASSERT_NE(-1, write(self->data_fd, &reg.write_index,
> > +	memcpy(&write_index, &reg.write_index, sizeof(reg.write_index));
> > +	ASSERT_NE(-1, write(self->data_fd, &write_index,
> >  	                    sizeof(reg.write_index)));
> 
> Simply casting &write_index to void* would fix this?

yes, this hides the type mismatch from the compiler. But i think
casting to void * will not fix the alignment mismatch for packed struct.
It works on x86, but might break on other platform.

> 
> >  	val = (void *)(((char *)perf_page) + perf_page->data_offset);
> >  	ASSERT_EQ(PERF_RECORD_SAMPLE, *val);

Thanks
Ankit

