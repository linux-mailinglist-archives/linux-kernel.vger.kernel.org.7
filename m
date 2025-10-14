Return-Path: <linux-kernel+bounces-851675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E902CBD709E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62CCB3BB7E2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED17303A11;
	Tue, 14 Oct 2025 02:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="emvJXMRk"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7614115E97
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760407340; cv=none; b=S/7l6fYrmCtPGqwe1YgDD6Wy57etQIeLKrSMyQUR98QjZurP2c4oR63ISo38xp6FTD0GUrbaAwWAJCtA9c2Yo38K55nTvN1nrJSQD9RmEjkPP5uc1BjiS5fnNIUTfL1Sb92Mlcoe0gamHN22jWO6Gn86JgH0RQq9k4a6sYkXJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760407340; c=relaxed/simple;
	bh=tG0Ls2sX7cAXQ8rOwM0BndGq2KDEe7rj0F88iQp6UtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QphqaxUdQofybVpay/4LfQUEL/3RFu/wZyCHJ6BHGFy/nxXZUO4PK53l4qt7823XFHYjN9vcWJgGVCIUXHi7TqZM2jzr6nnSUt6e54bVI7LQmGL4pn04n/XuAxtHY4Q7nDEk39L1exHuuBZ4jFphy8D1n3v/3Lk7V/4NYUHM9n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=emvJXMRk; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-170.bstnma.fios.verizon.net [173.48.82.170])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 59E21Lqj014560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 22:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1760407300; bh=l86hQk+N6R7Audvo9X9KY1B9shzAeKHmIgvA51jCSG4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=emvJXMRkUZ+NIJWiLt3ryLx/hPmoVrEQ2lDvJt+ZBu1E1XVxPE3mJCB50zqiw+qHq
	 cdwbajlx0Zr9DhDG2qA7Kwy/IQ8nCwNSQrEDHHeFtdXBxIsue+NtQ0XikXAqCHLz/f
	 EB0wQ0yUbIKslJtrjMQvSSzWmM55e00VMOpiwSIAEQA34kGsM7OLGnAtF63+k3diCR
	 n2Zm4Sx89tHRh+fNAos5E+UzTF82ilpyedZkTUIW4es2mRywhxyk746B08elp+oSyJ
	 lvh0jB66SIUq0hkcRuuTaVGQLRcC87HpQu1bMe3n1O5b6fvxoBHciDOp/HH3AeCivh
	 tMrr46xOqor6w==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 295042E00D9; Mon, 13 Oct 2025 22:01:21 -0400 (EDT)
Date: Mon, 13 Oct 2025 22:01:21 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Feng Chen <feng.chen@amlogic.com>,
        Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>,
        Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: Linux 6.18-rc1
Message-ID: <20251014020121.GN354523@mit.edu>
References: <CAHk-=whPJTtX5u1m47fPUD2g2Dc=Did_6OqCVj6OQPKFgfKn9g@mail.gmail.com>
 <f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net>

On Mon, Oct 13, 2025 at 10:08:22AM -0700, Guenter Roeck wrote:
> Test results don't look that good, unfortunately.:

Sorry, as Guenter pointed out, a number of the failures were caused by
a cleanup patch which removed CONFIG_EXT3_FS without fixing the
defconfigs.  This resulted in test failures because the root file
system needed an ext3-compatible file system, and with the backwards
compatibility Kconfig lines removed, it meant that the defconfig test
kernel wouldn't be able to mount the rootfs.

I have a fixup patch in the ext4 tree, for which I can send a pull
request shortly.

       	       	      	  	  - Ted

