Return-Path: <linux-kernel+bounces-806318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F89AB49509
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14EA3203DA7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A263112D0;
	Mon,  8 Sep 2025 16:19:02 +0000 (UTC)
Received: from lamia.bitwizard.nl (lamia.bitwizard.nl [145.131.29.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1EB31076B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.131.29.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348341; cv=none; b=RkRw/xbRo6k0yB6oUVbE+myf+7bastwAoXt/q0B4N8NlcsMd5qAqufMaO4WstJf1HM2/b8X7dtpd3ITWd8Y8YsbUxHRAj9DZe75sDhXYnuEEJ4iKY4aFdoDDpGW3XBLbUekaAp1X42vu/qTr55B29w+Rf/XHAQa8nz6U2tjKxnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348341; c=relaxed/simple;
	bh=NUcausO2zlasUZjFn/E0vCyrO/gIsYH2NliFbPIfFak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ut5dmBhTY3MoxFFPfTdxby9KX9W5CjHTmhgEMKZlpbW45PWgEZXsAnETRD9UeXvrbIxQ1kYCSkrEgT7ECaVtSYXWoUjLPYi9+wQBecFrDeIIQnM11tSvziog11E6tOAtOMN1rYAQEUpUTqaqCFoX3pancRJ6D6CvMrWNghRdlEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=BitWizard.nl; spf=pass smtp.mailfrom=BitWizard.nl; arc=none smtp.client-ip=145.131.29.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=BitWizard.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=BitWizard.nl
Received: from abra2.bitwizard.nl (abra2.bitwizard.nl [192.168.234.34])
	by lamia.bitwizard.nl (Postfix) with ESMTPS id E6D72180175;
	Mon,  8 Sep 2025 17:18:49 +0100 (WEST)
Received: by abra2.bitwizard.nl (Postfix, from userid 1000)
	id 2FAF9E43C6B; Mon,  8 Sep 2025 18:18:51 +0200 (CEST)
Date: Mon, 8 Sep 2025 18:18:51 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Deleting a bunch of files takes long.
Message-ID: <20250908161851.pnnbdqetb5oismhs@BitWizard.nl>
Organization: BitWizard B.V.
References: <20250905103553.utwmp6rpi5rfmvsd@BitWizard.nl>
 <20250905131130.GB3371494@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905131130.GB3371494@mit.edu>

On Fri, Sep 05, 2025 at 09:11:30AM -0400, Theodore Ts'o wrote:
 
> There is a workaround; see the attached spd_readdir.c which you can
> use as a LD_PRELOAD.  It overrides readdir() by sorting the returned

I've now had the chance to test this. With the LD_PRELOAD I'm getting
times of "about 10 minutes" per toplevel directory to delete, and min
(quite possibly due to the "data": from 4:09 lowest to 12:05 highest and
many around the 10:10 mark). 

Without the spd_readdir, I'm seeing 5:40 as the lowest and 13:03 as
the highest. So the performance increase is "about 20%".

My technical intuition says that a factor of 2-10 should be possbile.
(so 50-90% reduction in time). (While hoping for a factor of 100, 99%
reduction in runtime).

Is the "logging file system" a contributing factor? Maybe after each
rm or after each rmdir that something needs to be written to the log?

At one point in time I accidentally deleted my whole kernel tree. That
took "longer than expected" which made me think and realize what I had
done. It was about 2 or 3 seconds. The operating system was Minix and
the PC was a PC-XT at 10MHz. I doublechecked my solution for a couple
of seconds and powered it off before the cached results (everything
deleted) could be written to disk. After the expected fsck my kernel 
sources were still there. 

I have the impression that Linux has been worse than Minix in such
cases for about three decades now.

	Roger.

-- 
** R.E.Wolff@BitWizard.nl ** https://www.BitWizard.nl/ ** +31-15-2049110 **
** Verl. Spiegelmakerstraat 37 2645 LZ  Delfgauw, The Netherlands.  
** KVK: 27239233    **
f equals m times a. When your f is steady, and your m is going down
your a** is going up.  -- Chris Hadfield about flying up the space shuttle.
**  'a' for accelleration.

