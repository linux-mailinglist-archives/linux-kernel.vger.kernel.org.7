Return-Path: <linux-kernel+bounces-696428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 874A2AE2753
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jun 2025 06:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18D83BF26E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jun 2025 04:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A3C185B48;
	Sat, 21 Jun 2025 04:14:31 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A427494;
	Sat, 21 Jun 2025 04:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750479270; cv=none; b=r3bj27Pz5nuc+G93+yBRsVEWAf+l8oBl8NkYOBMmptrqvo7PVOD4VieydSyOVg72OfIrkfJK7J6GIqelu+xzALRFUaYDSkEWG/nWWIhzsxqTVfaOS6mmhyPA7PgC3GrTtv9jE29rrSBP+DFII0rN+OY4IsHv9Uw53FtCw2mn5Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750479270; c=relaxed/simple;
	bh=HChYt6JMy5R2uE8Aiw6/iMT0U+wx2wA1/MHdZ+BKFJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E92WLv5d+hu62C6QVX8VhUrEFsjiLO90Yb5OIlf7Dy8MwruPWirQLmXLpM7ENQh/7e45y8IQ55QaGZB34OycLV5hKArI8Ou+lV5VmUKK3lNxTBKbfBToDVit8/3rHVfcTELj8AemzSxDCjbGdY496JisYoh5d3mPPwgZd7fJu5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 55L4ELYX026694;
	Sat, 21 Jun 2025 06:14:21 +0200
Date: Sat, 21 Jun 2025 06:14:21 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] selftests/nolibc: rename Makefile
Message-ID: <20250621041421.GA26603@1wt.eu>
References: <20250620-nolibc-selftests-v1-0-f6b2ce7c5071@weissschuh.net>
 <20250620-nolibc-selftests-v1-3-f6b2ce7c5071@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250620-nolibc-selftests-v1-3-f6b2ce7c5071@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Fri, Jun 20, 2025 at 11:39:32PM +0200, Thomas Weißschuh wrote:
> The nolibc tests are not real kselftests, they work differently and
> provide a different interface. Users trying to use them like real
> selftests may be confused and the tests are not executed by CI systems.
> 
> To make space for an integration with the kselftest framework, move the
> custom tests out of the way.
> The custom tests are still useful to keep as they provide functionality
> not provided by kselftests.

I'm wondering, what prevents us from merging the new rules into the
current makefile instead of renaming it, especially considering the
fact that we initially took care of not confiscating the "all" target ?
I'm asking because: 

  $ make -f Makefile.nolibc help

is clearly less convenient and intuitive than:

  $ make help

Regards,
Willy

