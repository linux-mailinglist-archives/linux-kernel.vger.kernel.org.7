Return-Path: <linux-kernel+bounces-736207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE14EB09A12
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2012A44EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FF11CAA85;
	Fri, 18 Jul 2025 03:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="gEM4GJ2U"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3342C1922DD
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752808197; cv=none; b=bdud9LisvwVBwwtGkqjcpBeSHhWSjxVMQjSIm/oGkekFWxTB7s0D5Ur1wC/iMlBL02YPE7RMW+1IEATKIFHEjGk6eBqKjto58nrZUd8vxxpvy9ZCkY5+iKvvrmB8EOFR3tM61K38XyTxvuSguLROGH2kFiE5bNJz038hhEQoUVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752808197; c=relaxed/simple;
	bh=GqTcIgOld/defhlNDEiJ366p6xek9MAf/gJImSXXyso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZaSetVHj79Cof33+k16XGmW6H3CxZ9a/hA7MGJ0CuYM6m6VUHRLKq41zyon6AFMiZ4rSvghUp/qW9tIrmpbFqthnB77WRIHD1ZoMwm/Teh3NiSzMTyxaxOH62PKNuwxXAuz+QzbTcMKf3CV7Khp/XOImdOuVzav9ty10RuWYxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=gEM4GJ2U; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-26-156-131.bstnma.fios.verizon.net [108.26.156.131])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56I39WUu031617
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 23:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752808174; bh=m1vp9kQR6Q+/C4r2HeJmk31XxekP54s/mI79hwQFir8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=gEM4GJ2Uh6fBXzX8WDgHvLLpZGR6GDuiErXaFb0xSCwX8/sb6Pe7AduKUE9LfO8BS
	 PyITrz8Pd1wCIAMbbezTMp2lM+WRQ6PqNrN0CteAIEWprF6vOHs7xuhEGHtmHGAm5f
	 iplSmw6NU45JcvXckyrundGwrWmXjCwT8d5YhcOFHNXnGKJES34StX1sn1nQKPc71C
	 J6DFNhJO+9fcWCmljIFxWqV/vkPsB0aZT9qCUZLiI0Z3xusAPM2cw63fgydmpY7S/r
	 08kDAr3mcAaqocUuOUzmr2BHQmow8C5fCc5zveliRqa5rgZFsokqwxhU7bOyMZ5vRg
	 ziGtoUtnHH86w==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 6C53A2E00D5; Thu, 17 Jul 2025 23:09:32 -0400 (EDT)
Date: Thu, 17 Jul 2025 23:09:32 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andi Kleen <ak@linux.intel.com>
Cc: libaokun1@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/17] ext4: add ext4_try_lock_group() to skip busy
 groups
Message-ID: <20250718030932.GE112967@mit.edu>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-2-libaokun1@huawei.com>
 <87pldy78qc.fsf@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pldy78qc.fsf@linux.intel.com>

On Thu, Jul 17, 2025 at 03:28:27PM -0700, Andi Kleen wrote:
> 
> It seems this makes block allocation non deterministic, but depend on
> the system load. I can see where this could cause problems when
> reproducing bugs at least, but perhaps also in other cases.
> 
> Better perhaps just round robin the groups?
> Or at least add a way to turn it off.

Ext4 has never guareanteed deterministic allocation; in particular,
there are times when we using get_random_u32 whens selecting the block
group used when allocating a new inode, and since the block alocation
is based on block group of the inode, therefore the block allocation
isn't deterministic.

In any case, given there many workloads are doing multi-threaded
allocations, in practice, even without these calls to get_random,
things tend not to be deterministic anyway.

       	    	      		    - Ted

