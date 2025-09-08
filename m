Return-Path: <linux-kernel+bounces-806674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 693B6B49A42
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20CB4162D14
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8131929BDB3;
	Mon,  8 Sep 2025 19:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="CbO4jud1"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493711A255C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757360669; cv=none; b=buWQBOgwJXZE7BsaKWak3SIhFRGPKryfeP8kVS7xPmaQvVhlgiENv1RLOK0Eaodq92MajATmR46OzXV9YzIZxXT2LOcc51B+YKPLtKoctLu+sleH1wPzLKHTT9W84nd2CECxa6jYnXAKEZz6IDpRA9NJZ2tH2UnCtrbrHhu/yM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757360669; c=relaxed/simple;
	bh=ajChlkp0sdZ8o5fTczZvnPG0l8QZ3b4kK2AhIsbkdZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkFUuUqI8CfsTBaQQBLRhtMeBjUrctRre3OCd4EHrbDn0z1y6A8lZkbk2SBKT+RuzWorV4M9d5DQL1LMaJAr7eL9/V0kcypuBQTdH9ZZ6RJWbQi6DVzkVD/5TRO8Wo+ka8FFkvIG6n6E7Ywob004F/ita4W3r5K3uMGfSFvM5eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=CbO4jud1; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-2.bstnma.fios.verizon.net [173.48.111.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 588JerBD031812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Sep 2025 15:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1757360455; bh=TY1m+BxWrgSiz9Z5P31EmqKjFnsu1bW39FqB8fCJf5s=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=CbO4jud15i/dsL4UEbswl5VP+C45gaPo2RYKrFPuwS0aK2nyHcYn84FBwVxckuzNZ
	 rwdlHhgA70Y5TwfhRRtU+FgseHwSztDnY/jUzxvzURg9c1gXnqOaipuapYm5M3Zrj7
	 CUTbStK7UML1N797nO662zj04MbE7DwsIT5PRmGM5I9Pm1RJt/CIB0Yb5nfrm0d6I5
	 NaeOyAYQFfh0IMa7KI5ZfqiPPPvVoMBVBz3sTZnaKDLyIGDfgI7zcOrQ2gkBLIxhjO
	 Ey2NVF8ff2dhpezBMM5zkiaDti2Iovg/6GdHExVpQOxyNLFeBLY4zPwajWo2tdTBEw
	 xdoxJtcnAY9DQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 428CD2E00D9; Mon, 08 Sep 2025 15:40:53 -0400 (EDT)
Date: Mon, 8 Sep 2025 15:40:53 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Rogier Wolff <R.E.Wolff@bitwizard.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Deleting a bunch of files takes long.
Message-ID: <20250908194053.GA3620067@mit.edu>
References: <20250905103553.utwmp6rpi5rfmvsd@BitWizard.nl>
 <20250905131130.GB3371494@mit.edu>
 <20250908161851.pnnbdqetb5oismhs@BitWizard.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908161851.pnnbdqetb5oismhs@BitWizard.nl>

On Mon, Sep 08, 2025 at 06:18:51PM +0200, Rogier Wolff wrote:
> Is the "logging file system" a contributing factor? Maybe after each
> rm or after each rmdir that something needs to be written to the log?

If you want to avoid running fsck after a crash, it's not free.  So
there is always a certain amount overhead in journalling.  Comparing
Linux with Minix is comparing apples and oranges, since with Minix,
you have to run fsck after a crash or power failure.

You *can* run ext4 without the journal.  If the file system has been
cleanly unmounted, or you've run fsck, you can mount the file system
using -o noload to disable journalling.  Or you can format the file
system without the journal.  ("mkfs.ext4 -O ^has_journal")   BTW, this is
something that Google contributed some 15+ years ago, because Google
uses a cluster file system (back then, GFS) because at very large
scales, they need to make sure data isn't lost when a hard drive dies,
or when a power supply on a particular server dies, or the entry
router at the top of a rack gives up the ghost.  So if data gets lost
after a crash or power failure, the cluster file system can recover
since it has to handle much worse (e.g., when an entire rack of server
becomes inaccessible when a router die, or the power management unit
takes out multiple racks in a power failure domain), and so the ext4
journal was unnecessary overhead.

So if you don't care about reliable recovery after a power failure, by
all means, you can disable the journal with ext4.  That *will* make
certain workloads faster.  But users tend to get cranky when they lose
data after a crash, unless you have some kind of higher-level data
recovery (e.g., like a cluster-level file system which has erasure
coding or replication across different servers that are in different
failure domains).

The other thing which ext4 does is it spreads the files across the
entire file system, which reduces file fragmetnation, but it does mean
that if you create a huge number of files, and then you want to delete
a huge number of files, a larger number of block groups will need to
be updated compared to minix.  But this was a deliberate design
decision, because reducing performance degradation over the long-term
is something that we considered far more important than optimizing for
"rm -rf".

Cheers,

							- Ted

