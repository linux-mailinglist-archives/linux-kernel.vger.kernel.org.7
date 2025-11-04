Return-Path: <linux-kernel+bounces-885501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC7DC3324A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170A918C2456
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A459F199931;
	Tue,  4 Nov 2025 22:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="k51sqvou"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B286E2F2E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 22:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762294568; cv=none; b=rrlnV7txbpDGJ3XhH8ihHlZbkrNdNUyVLPVAmnA+MFJzRKCG5f2C5qxr2r2ZEPfrn+DhTHElLxnQNgcNEeDPF4ajHWOERZSt97YyU89soIsYvCVHikVYGP6ySPGPPQPJtJ3cFfdpO3J7MJq1xA3tij3lnbb3UHobKumFlXLGuWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762294568; c=relaxed/simple;
	bh=WVeyLHO99XjF2UfZfAmNY/K2ke/7Hw2YT/26lkl0n00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTTdn6JUdX61Ia27cQK1zkYrI93HWw7kb4zWPWXUkQWY1Ofrx0QUd2jvTA+V/2gRh1IP5WCCfxpkTU/rfTSXM3YLn6VJy6xJdKnAGROReisfUibgT0FXrA0KX0ayoqqp7VyXjHMxNYSseSpHzSbcg88AVvwm5g8ZDP5nzwmlMMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=k51sqvou; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-121-96.bstnma.fios.verizon.net [173.48.121.96])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5A4MFpdn030529
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Nov 2025 17:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762294553; bh=Pr/wrCrDh895xdoO2H8NzvOaQz7GEFrY4OzxZO2Bw18=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=k51sqvouhrY9egjiUoMwz3FDG30ayWJblOOBJZiUrxueku/Zsl6LoToz7MSCEg+CY
	 Ern9/gmAxnrXFjQj8L793HLqD+Lm3IyCRGYCgDjgZ+A/QBPIwwuo0vAHEuPLq8O9r+
	 IoXQM8iD8lmVQlhUzgNJo+vAzsNtzmQpSvbAP4GFblCdHHE6Wb+khVyKDkA2vRRAjl
	 jd+MQNH0jQMXoxkjERFGt1hN3CZtTOR/uaD6IGCxUZsTYojxFVW5HymMxtbRGFA1KU
	 bk1LvVpCSg+II5XPJiHm7k6mvGg2S/2kdl1jDJEIcGlw9WVRf4nx8N7FsZcIDe+sLZ
	 OAqmdUIMfYMpA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 7BAFE2E00D9; Tue, 04 Nov 2025 17:15:51 -0500 (EST)
Date: Tue, 4 Nov 2025 17:15:51 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: regulator branch mess
Message-ID: <20251104221551.GA2968640@mit.edu>
References: <aQoZ22aT27wHBpbI@smile.fi.intel.com>
 <aQocq1eRjOOjiRdY@finisterre.sirena.org.uk>
 <aQogTFANK1fMtloW@smile.fi.intel.com>
 <aQojdTvP94aYVW4l@finisterre.sirena.org.uk>
 <aQolne8AKHXdJw0-@smile.fi.intel.com>
 <aQonVNgqJI56nspA@smile.fi.intel.com>
 <aQoqPqVeQiHJ2tiF@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQoqPqVeQiHJ2tiF@finisterre.sirena.org.uk>

Andy, I don't know what github is doing to confuse you, but my
preferred way of understanding what is in a merge commit is to use the
command line tools, which are less likely to lie (or at least, to be
confusing):

% git log --pretty=oneline regulator/for-next ^base/master
9de2057bbdfb58f4d9bb1476135317cd3fe6aa52 (regulator/for-next, regulator/for-6.19, regulator/HEAD) regulator: pf9453: optimize PMIC PF9453 driver
2ecc8c089802e033d2e5204d21a9f467e2517df9 regulator: pf9453: remove unused I2C_LT register
0144a2b29d95af8523c308116de65d398d6e935b regulator: pf9453: remove low power mode
a2d4691b3fec6a2360e4ec953d06819ea055c3e7 regulator: pf9453: change the device ID register address
252abf2d07d33b1c70a59ba1c9395ba42bbd793e regulator: Small cleanup in of_get_regulation_constraints()
28039efa4d8e8bbf98b066133a906bd4e307d496 MAINTAINERS: remove obsolete file entry in DIALOG SEMICONDUCTOR DRIVERS
dc74a00c7661a14a672ea7660caca5c4aa661a79 regulator: pca9450: add input supply links
4c33cef58965eb655a0ac8e243aa323581ec025f regulator: pca9450: link regulator inputs to supply groups
86df0030b71d7172317d957df17524a7fd6232d4 regulator: dt-bindings: nxp,pca9450: document input supplies
01313661b248c5ba586acae09bff57077dbec0a5 regulator: Let raspberrypi drivers depend on ARM
d054cc3a2ccfb19484f3b54d69b6e416832dc8f4 regulator: rpmh-regulator: Add RPMH regulator support for PMR735D
f76dbe127f1b5910e37dfe307d2de5c13d61ed89 regulator: dt-bindings: qcom,rpmh: Add support for PMR735D
5263cd81578f99a00b2dd7de1da2b570b96a1b7c rpmh-regulators: Update rpmh-regulator driver and
fb25114cd760c13cf177d9ac37837fafcc9657b5 regulator: sy7636a: add gpios and input regulator
65efe5404d151767653c7b7dd39bd2e7ad532c2d regulator: rpmh-regulator: Add RPMH regulator support for Glymur
6a8cdef7dc2a4c0dbde3f7d7100b3d99712a766b regulator: rpmh-regulator: Add support for new resource name format
1356c98ef911e14ccfaf374800840ce5bdcb3bbd regulator: dt-bindings: rpmh-regulator: Update pmic-id DT prop info for new CMD-DB
835dfb12fc389f36eb007657f163bd1c539dcd45 regulator: dt-bindings: rpmh-regulator : Add compatibles for PMH01XX & PMCX0102
433e294c3c5b5d2020085a0e36c1cb47b694690a regulator: core: forward undervoltage events downstream by default
6277a486a7faaa6c87f4bf1d59a2de233a093248 regulator: dt-bindings: Convert Dialog DA9211 Regulators to DT schema

% git log -1 base/master
commit c9cfc122f03711a5124b4aafab3211cf4d35a2ac (base/master, base/HEAD)
Merge: 8bb886cb8f3a 3b1a4a59a208
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Nov 4 14:25:38 2025 +0900

    Merge tag 'for-6.18-rc4-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
    
    Pull btrfs fixes from David Sterba:
    
     - fix memory leak in qgroup relation ioctl when qgroup levels are
       invalid
    
     - don't write back dirty metadata on filesystem with errors
    
     - properly log renamed links
    
     - properly mark prealloc extent range beyond inode size as dirty (when
       no-noles is not enabled)
    
    * tag 'for-6.18-rc4-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux:
      btrfs: mark dirty extent range for out of bound prealloc extents
      btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when logging new name
      btrfs: fix memory leak of qgroup_list in btrfs_add_qgroup_relation
      btrfs: ensure no dirty metadata is written back for an fs with errors

Cheers,

						- Ted

