Return-Path: <linux-kernel+bounces-849725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB99BBD0BDE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC4624E4386
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E89A2ECD34;
	Sun, 12 Oct 2025 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="HoHMdWtr"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537E1509A0
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760299068; cv=none; b=a1KXXIIE++XHJCXaJWYBHsS3nM8y6+KqJxdkEGX+TxW0DMWHaOld1dAquz2zt6UjLSW0Ar1WCJJwoKL5qb/62idAVWKWxlpyFkZqAM8b9BtfuM3p7q/nhasI2DBg1AxhjSKh8Qs11y5r6KXYyrmlre6Stq+vN4OjTbsJAhYPOss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760299068; c=relaxed/simple;
	bh=gCLk5c6ldi0yie6zeA0N3pqyyIaQvO6v6fdlz4qoT0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nglxLJbRIigKkqahxYVrdjQUfgSsKOHirk3u3GeIwGDSbWsThdtafnlz0BqetCVmsJWop1V99de2hyGK18lYy9F4JkGAPtg2EwS2BrccxEyTlw3Hnmy9RLCnXLTiQuDm/oiLlxTpLT7iZE8NHXfcwQU0Gz+7Lq/Spu/l63i6Ruo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=HoHMdWtr; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-184.bstnma.fios.verizon.net [173.48.113.184])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 59CJvVqW004342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Oct 2025 15:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1760299053; bh=LvrlMRA4RhyctjL+VzTW41Dwbxad1RspvWf+dp5Ot2s=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=HoHMdWtrdff1SHCtcqX6wdtmVUa/u1jD6A49uOJg8jSruFjKV+2XyDEyr6I5RPa98
	 QLuH29Q9Xilf+dEfUrjR9gd5O0HCs8r55dCssTZ+0vTRm0N8QE1kN1weHGFUvC9zDT
	 PCuS1NrQH9Y9ND79nHd4YPtARvRu/wyeEGquMGF9ylAeNJZ6zjzGE1fLOOps5YePwk
	 btx+ZB6iD5k3mwhoeygyLAKbf4i2iPT3Iz1DBaK+SuqNszxThAjMuBoocYC+Ho3f3R
	 LudxDLCe2wZrNtOResiH0LjbROfgzNcvc7639EiXEdAPow48QsgvAeTT1nPL8P9Xw4
	 bXgDq/W6Ay+5w==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 7FE332E00D9; Sun, 12 Oct 2025 15:57:31 -0400 (EDT)
Date: Sun, 12 Oct 2025 15:57:31 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        srivathsa.d.dara@oracle.com, linux-kernel@vger.kernel.org,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH] ext4/060: Skip for dax devices on non-4k page sizes
Message-ID: <20251012195731.GG354523@mit.edu>
References: <20251011134708.2426769-1-ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011134708.2426769-1-ojaswin@linux.ibm.com>

On Sat, Oct 11, 2025 at 07:17:08PM +0530, Ojaswin Mujoo wrote:
> This test tries to trigger an ext4 corruption by resizing past the
> meta_bg size (8GB on 4k blocksize) in ext4. Since the test is sensistive
> to the size and FS layout it hardcodes the 4kb blocksize ignoring user's
> $MKFS_OPTIONS. While this is okay for most cases it fails for dax based
> filesystems where system pagesize is non-4k.
> 
> One way to work past this is to make the test blocksize agnostic, but
> since we still need the disk to be as big as the meta_bg size, this
> means for blocksize=64kb filesystems we need a scratch disk of ~4TB
> which is not feasible.
> 
> Hence, just skip the test if fsdax is used in a non-4k page size system.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Makes sense to me.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>


