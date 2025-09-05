Return-Path: <linux-kernel+bounces-802653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E4EB45536
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645B51CC490E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B08130CDA8;
	Fri,  5 Sep 2025 10:44:36 +0000 (UTC)
Received: from lamia.bitwizard.nl (lamia.bitwizard.nl [145.131.29.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277AF2DF71F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.131.29.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069076; cv=none; b=ACx2fJf1DWm+6X91o9nu2GChbpzpMm5YH+/ZTWNs0RP8BwbTaKO2ByUnYRyEkwdru2GjF03KXbcW7iM75//3RGIVyiAnOL3GOe9axYzPR519dZe5LLRRylniwN0UqXiNEp0nmIVEITASBF3Z+zDyX6OvMxE0w5mJBJITNygKRCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069076; c=relaxed/simple;
	bh=AunSilM43xhMSqmiAy/0wlto3FsBGtd9sIH1h+zRUtE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kRkFJQpVT686X72QD2kAAaiDrYAYDGpyW3AZy+w4RX9jrc/MkMpeSPRfriPGn/aG3vzYr3g0QlF/tZElsUP5JS5svTGla2MQbzehRqFvEbw5Wqnk+N0mgkgNuTfGsIq2/OmwoHWk0bfAhb+8VsIpocIfKRl/shb/s8v46ckrWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=BitWizard.nl; spf=pass smtp.mailfrom=BitWizard.nl; arc=none smtp.client-ip=145.131.29.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=BitWizard.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=BitWizard.nl
Received: from abra2.bitwizard.nl (abra2.bitwizard.nl [192.168.234.34])
	by lamia.bitwizard.nl (Postfix) with ESMTPS id 7B74F180233
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 11:35:52 +0100 (WEST)
Received: by abra2.bitwizard.nl (Postfix, from userid 1000)
	id 5F626E4273D; Fri,  5 Sep 2025 12:35:53 +0200 (CEST)
Date: Fri, 5 Sep 2025 12:35:53 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: linux-kernel@vger.kernel.org
Subject: Deleting a bunch of files takes long.
Message-ID: <20250905103553.utwmp6rpi5rfmvsd@BitWizard.nl>
Organization: BitWizard B.V.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all, 

I have a little linux-server machine that has two 8T harddrives. I
noticed that they were becoming a bit "full", so I decided to remove a
bunch of files. OK. Maybe a lot of files. About 121 million of them.

How long do you estimate that this would take? Ten minutes? An hour? 

I'm using EXT4. 

Now think about how much metadata needs to be read from the disk to
know what inodes to wipe, and directories to clear... 

So a file takes a directory entry of say 30 bytes? (depends on the
filename). How about we round that to 50. Then an inode. That used to
be 128 bytes, but nowadays 256 right? Addded together we're talking
about about 300 bytes, right? So the metadata is 36Gb. 

Let's round the disk speed to 100Mb/sec. So the OS will get to "touch"
all of the necessary metadata in about 360 seconds. Add in some
seeking and we're talking about 10 minutes. to an hour. Right?

Weeeeelllll.... its been running for over a week now. 

I would think that improving this, also improves things like
find . -name zasdflasdkjf 

I'm hoping that someone with the right skills agrees with me: "this is
absurd" and has the time to do something about it. 

To reproduce: I backup my homedir of about 700k files every day using
rsync. Then I cp -lr the whole thing to a new directory with the
timestamp as the name. I have about 120-200 copies when the disk fills
up and then I batch delete a bunch.

Why do I think that it should be technically possible to achieve
"reasonable" performance? 

I think that the directory contents needs to be clustered better. And
then when the system needs to read a directory it should prefetch more
directories, say as if there is a "blocksize" of 128k or even 1M. Even
if the "hit ratio" of the "extra 990k" is only 10% you're already
gaining a lot.

To get better clustering the system may need to keep "stats" about the
filesystem in the superblock. What percentage of the disk is dedicated
to directory contents? If, say (as I suspect in my case) that's 30%,
of each block group, reserve the first 30% for directories
only. i.e. allocate directory blocks from there, allocate data-blocks
from not-there.

Or grow the two different kinds of data from different ends. 

Maybe "readahead" is better served if inodeds are allocated from the
end of the inode area. All this would not require a significant
rewrite of the filesystem, just the place in the superblock where the 
current stats are stored on each unmount. 

Another strategy might be to allocate the directory info in the current
block group top-down from the previous block-group. 


	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** https://www.BitWizard.nl/ ** +31-15-2049110 **
** Verl. Spiegelmakerstraat 37 2645 LZ  Delfgauw, The Netherlands.  
** KVK: 27239233    **
f equals m times a. When your f is steady, and your m is going down
your a** is going up.  -- Chris Hadfield about flying up the space shuttle.
**  'a' for accelleration.

