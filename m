Return-Path: <linux-kernel+bounces-653875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7B1ABC00E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 15:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24F33AD8F3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 13:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A4227AC47;
	Mon, 19 May 2025 13:56:59 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C70F280A3B
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663018; cv=none; b=Ird0TZjR4A0itTMwAURMgbOwjA3AoA9jINX3dgSQ9ZvPMBTEICEafxgkaWFaNJ8ciJhGN5wcfnV6cExRYs9nBO0hLnSKVqgCDnNnOhHDcrsOVmWXhzZvE3DIdLvRD9BpLrnfBvMq6tecBkpsJQhB8xNjcgZDd0STGkYmxtLSGkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663018; c=relaxed/simple;
	bh=3hbqHKmWFsNLHw/fa4d26mjpP3dAYETleGjy1aQoctQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIO1NkAYX4yS1KW8MKd2WU+qr6JhhDocQeAyRUX9t4GZ9n7PL2N+XHjqOrRcNi67Xk/wnYG6Byv9K3HozrkcNquThirmo2o6YrAFw0xY58o2RLnotQA96uouTqNpIkibXM5ccQDxXF4W/NIv9JTX38PHUFA5XeN1rG+73nc/ZzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54JDuX8K016210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 09:56:33 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D84D52E00DD; Mon, 19 May 2025 09:56:32 -0400 (EDT)
Date: Mon, 19 May 2025 09:56:32 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ethan Carter Edwards <ethan@ethancedwards.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        oe-kbuild-all@lists.linux.dev, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ext4: replace strcpy() with '.' assignment
Message-ID: <20250519135632.GA38098@mit.edu>
References: <20250518-ext4-strcpy-v2-1-80d316325046@ethancedwards.com>
 <202505191316.JJMnPobO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505191316.JJMnPobO-lkp@intel.com>

On Mon, May 19, 2025 at 01:58:02PM +0800, kernel test robot wrote:
> Hi Ethan,
> 
> kernel test robot noticed the following build errors:

Hi Ethan,

I would really appreciate it if you would at least do a build test
before sending out a patch.  In addition, it would also be helpful if
you ran a smoke test, using "kvm-xfstests smoke".  The instructions
for how to use kvm-xfstests can be found here[1], and it was designed
to be as easy as possible for people who are sending "drive-by
patches".

[1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

Running the smoketest only takes about 20 minutes; although if you
want to run more sophistcated testing there is also "kvm-xfstests -c
ext4/4k -g quick", or "kvm-xfstests -c ext4/4k -g auto", or if you
have a 24 hours to kill, there's always "kvm-xfststs full".  (Although
these days I generally use gce-xfstests[2] since this can shard the test
runs across multiple VM's, so it only takes 2.5 hours of wall clock
time.)

[2] https://thunk.org/gce-xfstests

Cheers,

					- TEd

