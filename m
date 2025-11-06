Return-Path: <linux-kernel+bounces-888348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCD3C3A964
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CE4462179
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C91C302745;
	Thu,  6 Nov 2025 11:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dZTasoi9"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958931A3172;
	Thu,  6 Nov 2025 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428344; cv=none; b=BXa1Y7ruI5/uiYJCDrrapO/sHCF/tkAvoKefzUUWoHxIXhJ2lBnPOjfPmAHuFRv7uHmQ6yXxL+5L/1JKFla6gvSjy9Y/Ds9M8/tTsLSCmpzdrvf3zI/mQgBOyrjjTiAhQCcmprfhmr8y3eFGvit14YQrj1j9RGj4S8s9X8c4WTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428344; c=relaxed/simple;
	bh=XET+IcJuAYfnsms+ISFMGypNCJAlIAs6tZmrjg94L2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPepGtX8RBwVEmAM4mNbRrT0Y6HBA0aszWO0Pw/zx01Ccv24AoP8S+r/bkxuzVxqFYGcWp75Kc5WfVtRnDhj0Pd9pMRsBFC7XBDH0mzj9Z1pUa6Jhu9Y/712yJhSfRLfnxm+qEl9RuTqpwe+zLVyIZ8PTeHsToYkFV8xQQ0fA2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dZTasoi9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jB+LBuSZ1dURclZUkhzkUyuMw+z6UsEAt5tW8gy4Avg=; b=dZTasoi9Fqs0aakyEjv4lq6nZ7
	IiZBwUyM2xyD+V2IbEL2QeOmsHtOx/AnB35cketAuxr2Ycp2x0ftRpSi/xR6/kdRWMn23uimcVz0m
	FnqQydvOUg/mLd3igCNdFCv7TQ/cg5vWzP+4O91D86lg30eCOJT+dcvFtpzyMHJmFmSNvJ0Dfd61S
	jGhhRV7LAWIn+vS10EsRTs9zehl5yJn8rdJT6jGCxM3/23BYltILq38WtZl/g+BR3EgqCHpybzs8/
	LMxZo9rWuLPXPdFZ24O3yy1mdVhYxv0dqsrSHrCj+SIUGUFeZhUxl3HQbkvkDHbA5FU0ys66sm2ff
	ccL2EkYQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGy7W-00000000axN-1SID;
	Thu, 06 Nov 2025 11:25:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 17C5D3001D0; Thu, 06 Nov 2025 12:25:39 +0100 (CET)
Date: Thu, 6 Nov 2025 12:25:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <lkp@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [tip:master 11/25] vmlinux.o: warning: objtool:
 fred_exc_machine_check+0x185: call to __kasan_check_read() leaves
 .noinstr.text section
Message-ID: <20251106112539.GR3245006@noisy.programming.kicks-ass.net>
References: <202511061245.gdMzEtVA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202511061245.gdMzEtVA-lkp@intel.com>

On Thu, Nov 06, 2025 at 12:16:10PM +0100, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
> head:   8411fdb92360d0b4d3337492a25ee2de7fb6c425
> commit: 8375dadb8d4c6de0dc916ea50b376d9d946ce544 [11/25] Merge branch into tip/master: 'perf/core'
> config: x86_64-randconfig-2005-20250721 (https://download.01.org/0day-ci/archive/20251106/202511061245.gdMzEtVA-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251106/202511061245.gdMzEtVA-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511061245.gdMzEtVA-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    vmlinux.o: warning: objtool: exc_debug_user+0x1c9: call to __kasan_check_read() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: exc_int3+0x15e: call to __kasan_check_read() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: noist_exc_machine_check+0x179: call to __kasan_check_read() leaves .noinstr.text section
> >> vmlinux.o: warning: objtool: fred_exc_machine_check+0x185: call to __kasan_check_read() leaves .noinstr.text section

Right, this is a tree that does not yet include:

 cf76553aaa36 ("entry,unwind/deferred: Fix unwind_reset_info() placement")

which should fix this report.

