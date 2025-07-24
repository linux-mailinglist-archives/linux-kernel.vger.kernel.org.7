Return-Path: <linux-kernel+bounces-743525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D06FB0FFC4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 314557B13AD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 04:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19091FECAD;
	Thu, 24 Jul 2025 04:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Q9eu57+x"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA281E98E6
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 04:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753332989; cv=none; b=XGlDelIP185UjCHBtoST0x1RlBEm3NSHMepVyY/jnrW60xw1joZrdAxZvOT4LgYZOb2cB0npuLbv5FrwwITv0c1vXGnif7ya4tSXLn5zB/ASNFyG9nFVkLd7ftnfp3MJPPysr8WYVZWo57ufFAHx2YG9LTBu8qd63rK4KjcsqK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753332989; c=relaxed/simple;
	bh=fP6kX1LMGmOTclonzU54n3N9v2G92MN3VZq19VXBsgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRlguGmTtCF7BenY8YAX49lc5pZInL8IRdJjdLz0vJa+keZLI9q9eCYkcAORNd7TJSU8IROYlv7RI4dOgR/LcJEIbQDiNAdGrJWPFrfwC94WQiGHiLqfEuohM/+gKNXXgLD7oymce6yJmm/nSnPYj3jFo/e6lDYDW9lCQAHoHho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Q9eu57+x; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-231.bstnma.fios.verizon.net [173.48.112.231])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56O4suTs029451
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 00:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1753332901; bh=1TXGdBZR9RlN4AvgbzOvBSB5nCw6F2aas8EVLPSRxe4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Q9eu57+xuy3qN3Iwbp/+OHTKDS/A1hIvgruYiiuKEWAEqUK+X9CZSu3cz0EQThwtL
	 5a1tv5ioqGrp8Rsu5OGMrTIs9WQz3iYVPlnYR6+Ia8vPVJtdMTA/v4+HP8Xo6fA5qf
	 4OU1O4rRrNrekBNJrEwzaN7F+zaLnhe7FvJdSgzSfgK2HRT5an51HQOzRzxJQ7wrbi
	 X/FAKjkSX8ZMPqzTtDod5e+T13qZLhhOodzrcTdfCsR96TqRhCGyZsiBwr5glXsKvc
	 utIRh6bYPDmWRWNm65+v6W7U4xdSwUsf+QreeCxTecVq7lPWEWOKNhA8mnvnwQMZWO
	 cF2EMzz2CFIeA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 6A76E2E00D5; Thu, 24 Jul 2025 00:54:56 -0400 (EDT)
Date: Thu, 24 Jul 2025 00:54:56 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, julia.lawall@inria.fr, yi.zhang@huawei.com,
        yangerkun@huawei.com, libaokun@huaweicloud.com
Subject: Re: [PATCH v3 15/17] ext4: convert free groups order lists to xarrays
Message-ID: <20250724045456.GA80823@mit.edu>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-16-libaokun1@huawei.com>
 <b0635ad0-7ebf-4152-a69b-58e7e87d5085@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0635ad0-7ebf-4152-a69b-58e7e87d5085@roeck-us.net>

On Wed, Jul 23, 2025 at 08:55:14PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Mon, Jul 14, 2025 at 09:03:25PM +0800, Baokun Li wrote:
> > While traversing the list, holding a spin_lock prevents load_buddy, making
> > direct use of ext4_try_lock_group impossible. This can lead to a bouncing
> > scenario where spin_is_locked(grp_A) succeeds, but ext4_try_lock_group()
> > fails, forcing the list traversal to repeatedly restart from grp_A.
> > 
> 
> This patch causes crashes for pretty much every architecture when
> running unit tests as part of booting.

I'm assuming that you're using a randconfig that happened to enable
CONFIG_EXT4_KUNIT_TESTS=y.

A simpler reprducer is to have a .kunitconfig containing:

CONFIG_KUNIT=y
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=y
CONFIG_EXT4_KUNIT_TESTS=y

... and then run :./tools/testing/kunit/kunit.py run".

The first failure is actually with [11/17] ext4: fix largest free
orders lists corruption on mb_optimize_scan switch, which triggers a
failure of test_mb_mark_used.

Baokun, can you take a look please?   Many thanks!

	    	       	    	      - Ted

