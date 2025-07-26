Return-Path: <linux-kernel+bounces-746591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60EAB128AA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 05:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA437A9DB6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 03:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EEA1E5B88;
	Sat, 26 Jul 2025 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="fEBgv/hf"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F4B1E51E0
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753499421; cv=none; b=rlc5SmOoQAgz+COxbKuXJ97TfbVzpNW63l3e24x1jNqSldCvshsiEwC3dFCl5RDrfLjLemKWBNtmByiYZHSWS2/vFrFofpBzSSvQhVRnN6t52Q2Zedg9YfSXz0H2frkxqQpk+MWo2LznklQfYNB7cwr1mM/xW/cNO+iOhwbJhMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753499421; c=relaxed/simple;
	bh=mAH8Yj6gzn9GcwjVv/hNDs89nxL93fomisgORjn0VKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcID2+58tz80nIqJmhVlr+rUmQvID3ULIv5vdTkLTVDI1T78qT7J3XNhTFXROC//rC5v1VoetbvRiAc5wAtsy83P8hewn8fpcNI1fE9KXlqfgyiAbU7AYulVZNuwP2oN+Gh3H/bC+Z8JtSiMOlTj1kelpRJTsVlYdnh9MQjsAPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=fEBgv/hf; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-116-187.bstnma.fios.verizon.net [173.48.116.187])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56Q39KIo000331
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 23:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1753499364; bh=YSr4qw00KAYudz4+C02hI1TeYU9XzzWkEqDLG4aNg/o=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=fEBgv/hfDiz9k0zx4fEMSQqZ6sJld0+33wK3VMjWUjz7n1wYxFXnduydaF2EplDdo
	 0i9vug5O6crwlFPSYYuW+xPPTp/LTkKSFfvR2Fw2V7aGN0hBoJV2C3VdV7SuuPrCsf
	 Vj07oRl2gHsFqo9b/RpWayhRr4qkOLZnXMd3qru53LxOpp5mQy0WDUjZDHpPIoxlTn
	 hwGsgoFSDQa7skJ00/owq0lNe1741TY86TnV1BxCPgl8lRYxMbAupJLG4Sal91793L
	 6lsHOB/V0O7VGUA6+o/eGMXVV4HOfCgVzOG0XepwGk/g8tHwUfHLJt+dQKdckFE7ZZ
	 G6gB81760QUNA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E441F2E00D6; Fri, 25 Jul 2025 23:09:19 -0400 (EDT)
Date: Fri, 25 Jul 2025 23:09:19 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, linux@roeck-us.net,
        yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH] ext4: fix crash on test_mb_mark_used kunit tests
Message-ID: <20250726030919.GA273706@mit.edu>
References: <20250725021654.3188798-1-yi.zhang@huaweicloud.com>
 <av5necgeitkiormvqsh75kvgq3arjwxxqxpqievulgz2rvi3dg@75hdi2ubarmr>
 <20250725131541.GA184259@mit.edu>
 <2f53f9a8-380a-4fe4-8407-03d5b4e78140@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f53f9a8-380a-4fe4-8407-03d5b4e78140@huaweicloud.com>

On Sat, Jul 26, 2025 at 09:42:37AM +0800, Zhang Yi wrote:
> > In the future, we should try to make sure that when we modify data
> > structures to add or remove struct elements, that we also make sure
> > that kunit test should also be updated.
> 
> Yes, currently in the Kunit tests, the initialization and maintenance
> of data structures are too fragmented and fragile, making it easy to
> overlook during modifications. In the future, I think we should provide
> some general interfaces to handle the initialization and
> deinitialization of those data structures.

Yes. I was thinking similar thoughts; perhap some of the structure
initialization should be refactored and put in mballoc.c instead of
mballoc-test.c.  Even if we have to have some #ifdef
CONFIG_EXT4_KUNIT_TESTS so that some of the test mocks are in same
place that the structure manipulation functions in a single file.

      	       		 	      		- Ted
						

