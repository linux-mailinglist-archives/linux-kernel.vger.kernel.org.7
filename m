Return-Path: <linux-kernel+bounces-897575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FB5C5333E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02D86202BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA3933FE33;
	Wed, 12 Nov 2025 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bVHixlYn"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32E633F8C5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961457; cv=none; b=CB+IllkR0B/oHziH2+ecTNoCRCTaLmbEq//Uzzui832KNQ7LLIiB5EDw9u/iVz51/ZVg+ar9mnKKpH7xN2y3eyaNHjc11FoosGdvciJD+S/PnkD5UaeX2ootpcZxD5XfYyyiKvgqr2Q8N89J+VrK/7E125xA5JOesLlw6T/z8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961457; c=relaxed/simple;
	bh=jti/WDC1KJeLUCxADdUS9GjNHsV+LzcXVJp+I1E5YvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYI4jNOKSt1KHSeAoF8Vc9uUFO3ePW7bom+GhNBtOZuxAOGpz4DWY9cJKjw5xroW7lQTx9Ds2IZu1UnLOIiNZlwsRDX2ycs8nF71lYxNSgbzJ2E1fLoYUVas2yETuR7iTwaQ626hPzyPe5471xo6eVDR1fGoUShkdhdLNl4/i0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bVHixlYn; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-200.bstnma.fios.verizon.net [173.48.82.200])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5ACFTXXi022626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 10:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762961379; bh=fFEV1yEu0f2ULh0OpDxAMyYySFsuiDTjToDP1kfqcxE=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=bVHixlYnoXOntlmD86NN2BdGh+eHnNuVozQh1KtMaDTh8lG0lFAxzabpXEjHhf/Pb
	 TF5YNFgPA4iGPyQaBJjd4wDdDZXlS4U/pQENXWH7uxKSzC/AJy6LoDKEwwHkA86HgX
	 4P5Efgltsm5SE9Mze0T8fl3yiePumdgNXjCpDSF/Q49tYHu7vEOvMPRxU8PCBVT3KS
	 vGKMcEXZMTMCSQnNL1Fzg1cl4LDqkAYOb4ncyoHN65IMJ3DDDV8R9wbSgpL/mE9jWi
	 7t42GUyZczx5rSeDGCKG50K8Oxiyh9qMdNCbT//KVWm7AnmV2VMwMne43aXlhDsmj5
	 k5XO7rEC02AWA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 0A5342E00D9; Wed, 12 Nov 2025 10:29:33 -0500 (EST)
Date: Wed, 12 Nov 2025 10:29:33 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, kernel@pankajraghav.com,
        mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        Baokun Li <libaokun@huaweicloud.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2 00/24] ext4: enable block size larger than page size
Message-ID: <20251112152933.GC3131573@mit.edu>
References: <20251112040220.GO2988753@mit.edu>
 <21efa577-a577-48ce-a82b-bce446539fba@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21efa577-a577-48ce-a82b-bce446539fba@huawei.com>

On Wed, Nov 12, 2025 at 02:27:19PM +0800, Baokun Li wrote:
> Darrick’s reply in another thread has already made a similar change,
> so we can apply that patch first for testing.

I'll give that a try when I have a chance.  For now, here's a test run
using a version of my test appliance which excludes the way group for
the config ext4/lbs, and which has a modified e2fsprogs (built from
the latest e2fsprogs git repo) which suppresses both warnings when
using large block sizes if the kernel has the blocksize_gt_pagesize
feature detected.

ext4/lbs: 595 tests, 6 failures, 101 skipped, 6656 seconds
  Failures: ext4/033 generic/620 generic/759 generic/760
  Flaky: generic/251: 60% (3/5)   generic/645: 40% (2/5)
Totals: 619 tests, 101 skipped, 25 failures, 0 errors, 6291s

Fixing all of these filures is not a blocker for getting this patchset
upstream, but it would be nice for us to figure out the root cause for
them, so we can decide whether it's better to exclude the tests for
now, or whether there's an easy fix.

Thanks,

					- Ted

