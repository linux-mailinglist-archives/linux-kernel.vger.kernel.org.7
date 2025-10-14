Return-Path: <linux-kernel+bounces-852858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F28BDA19B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F9BC4E90E5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A973002C5;
	Tue, 14 Oct 2025 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="lCD1g43r"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8282F616D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452780; cv=none; b=ahiiCuXHCThFYf8TEt/ecXDJjPtJGsP2XyIHkVag2r6T+pH0iiIN8zbOaEr5GjjkM4wuKh1NmeWfVgRtuvIAzpVOLh2RwB2koY0VsT3hG3w0bp8rhS2nddgdGuVVB1e/YEJII1rHBwvJw55E/4bWKrMQWyfei923KzII5fEFSHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452780; c=relaxed/simple;
	bh=K9UdknQRETW4MZX1ZU3bx3AEkIexbx1mUK4OnnOeiTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCRJPuZOZQiBQ80Euuh19A0u925GJHWV3eN5Fw/XD6O6euvR9Fd5IoAjbivBvDOk+WTpjVjxmC1xYxsjOiL+A5+x8nLQdviqoxntuWvGuNaGMXcSTicHTa09iDlkPf9dhGpau0Z4KqQ1sl5/Pqw3cE4zHKyrpnR9CdwDyt/f8eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=lCD1g43r; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-184.bstnma.fios.verizon.net [173.48.113.184])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 59EEdHuu008528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 10:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1760452759; bh=7RDxMvNV9uO3veLRooNIOYHHyh1ceXq3G+yLqWiTMTM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=lCD1g43r+h+FgZe1pWaLpL70YweCYF/7Hl4Vqj6lg6XqYzoIgjS/oFMtF00zqfxqv
	 8dcIv4iiINgrybMaLtK5BPhHiWDt2qQnom1Lf2QbOB459N5nfn9t0150QZ8oxvKw8M
	 RvhZVSqhborSqnvEDeR9ZYM9RbScoXNarzDMDKGI6MXwV5tAHz6DjaN0ybxXuABD22
	 NphZ+jnc0HHV7DZxROPe/QXpA58SCeg5nJjXc4dvmqu0ns54rNKfszjlqCjyn3v0qz
	 S9wq2nF9sW5b7FZ0bLBcCu8JylAwSbYWLujApuWKy1Yp06TNuVBpuvfAcqXRlCckuN
	 dOcaw04KGjimA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D80FA2E00D9; Tue, 14 Oct 2025 10:39:16 -0400 (EDT)
Date: Tue, 14 Oct 2025 10:39:16 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: John Stultz <jstultz@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Matthew Wilcox <willy@infradead.org>,
        Arnd Bergmann <arnd@kernel.org>, Tyler Hicks <code@tyhicks.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ecryptfs is unmaintained and untested
Message-ID: <20251014143916.GA569133@mit.edu>
References: <20241028141955.639633-1-arnd@kernel.org>
 <Zx-ndBo7wpYSHWPK@casper.infradead.org>
 <ef98d985-6153-416d-9d5e-9a8a8595461a@app.fastmail.com>
 <20241029043328.GB3213@mit.edu>
 <CANDhNCpsoPcotnrjH6y0yEBf43652DRasSsEnAyEbrKN=tjEfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANDhNCpsoPcotnrjH6y0yEBf43652DRasSsEnAyEbrKN=tjEfQ@mail.gmail.com>

On Mon, Oct 13, 2025 at 11:07:56PM -0700, John Stultz wrote:
> 
> Yeah. Sadly I'm one, as I needed something to migrate off of when
> encfs was deprecated.
> 
> Is there another soon-to-be-deprecated filesystem to encrypt
> directories I should move to? :)

Well, the closest way of encrypting directories is fscrypt.  The good
news is that it works on top of btrfs, ext4, f2fs, and ubifs, and it's
not likely to be deprecated given that it is used by chromeos and
android.  The bad news is that the integration with traditional Linux
desktop setups (e.g., login, etc.) was never completed.

This is probably because for many desktop and server configurations,
using dm-crypt is actually better suited and more secure.  It
certainly doesn't solve the "just encrypt a directory hierarchy in a
file system" and the "support multiple users' who might have different
encryption keys and which are mutually suspicious" use cases.  But
this appears to not be sufficiently interesting for distributions to
do that integration work.

					- Ted

