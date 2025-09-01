Return-Path: <linux-kernel+bounces-794457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBADB3E209
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA43200D9B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018F1321432;
	Mon,  1 Sep 2025 11:49:42 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D651A0BFA;
	Mon,  1 Sep 2025 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756727381; cv=none; b=rkGFUWB0+wV2MjU1Ysd2SvhomLv1EnxvLhGWg9a/a0fpyEGaVCjnoVnLfL2zXBXw5vY8i0SyClupV0aWdDIbdKAkv0kAyGMUboLR+p3M6BhFg7rHaBLNpm/7SN+ym3jUipJulQlSwQMR+sWevsR1/+/oe17FXmcn12hxMwg9j2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756727381; c=relaxed/simple;
	bh=d/k6MOFRJc5wejuzcGuVOIIas5UTe55EJEkZvxcVtMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Csfe3wjWcPB2WoTiXWMVtJNfFz0bB8w8eyOID/ghIMJq1wbOt9BsCym/lQSDPTQQdvShAdO3R1yXDYQt+zwhD9RljB6t+8N6YWHq3cfHOFqIMB0GEhQYNbj/BppCVquJdJBUOrI06VT2Ul0Q9vhT53WKGUzxwnTPrxgyltg7pjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00915C4CEF4;
	Mon,  1 Sep 2025 11:49:37 +0000 (UTC)
Date: Mon, 1 Sep 2025 12:49:35 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	arnd@arndb.de, will@kernel.org, peterz@infradead.org,
	akpm@linux-foundation.org, mark.rutland@arm.com,
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v4 0/5] barrier: Add smp_cond_load_*_timewait()
Message-ID: <aLWITwwDg06F1eXu@arm.com>
References: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829080735.3598416-1-ankur.a.arora@oracle.com>

On Fri, Aug 29, 2025 at 01:07:30AM -0700, Ankur Arora wrote:
> Ankur Arora (5):
>   asm-generic: barrier: Add smp_cond_load_relaxed_timewait()
>   arm64: barrier: Add smp_cond_load_relaxed_timewait()
>   arm64: rqspinlock: Remove private copy of
>     smp_cond_load_acquire_timewait
>   asm-generic: barrier: Add smp_cond_load_acquire_timewait()
>   rqspinlock: use smp_cond_load_acquire_timewait()

Can you have a go at poll_idle() to see how it would look like using
this API? It doesn't necessarily mean we have to merge them all at once
but it gives us a better idea of the suitability of the interface.

-- 
Catalin

