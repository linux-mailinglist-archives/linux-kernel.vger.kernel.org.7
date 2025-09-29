Return-Path: <linux-kernel+bounces-836758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9931BAA7C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5DF3B2DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1800244665;
	Mon, 29 Sep 2025 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fDK7hvo/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD7D1F1932;
	Mon, 29 Sep 2025 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759174668; cv=none; b=BourO7flX1X+b5AexHuohuktiCQf7YxLWqsupoRErXpS4UF25XJmNCs8LuL5jsduH9om7g4kzo9daw3nVzQEQFq0EaXX5T0PclhrMFNf5bx6QHd7e/ezjAntZnZnE+5AkgqrHqxw8nfTYaawNpNXvprhcvDN/81zEc74yGhMmdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759174668; c=relaxed/simple;
	bh=/ySbA8wRc6NkjqRPcqVdfv7w1rKuBdESIeJ1MkD9F3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgXOCVWcf6tS1JxOzJZpqChypy4vbbCRop1b0xT53ozOQkcMVV98eH8KUi+hiV2saBJX5CI+e398stVo/jITaMDuyZagOFIpTRXdbp6QAybWUvhu333waCFilo4NxOQ3N/XWnLwnldmQL9DiQ5nlf3Nd99GqgkGZZNsi4G7AU2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fDK7hvo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0DCC4CEF4;
	Mon, 29 Sep 2025 19:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759174666;
	bh=/ySbA8wRc6NkjqRPcqVdfv7w1rKuBdESIeJ1MkD9F3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fDK7hvo/7FDQmZBMmAj4TMRwPYHiPY9prHY35LLyTilCv/drsPhw5eLW1lU8+7Trx
	 Tc+icGUWm8QEUwxffgB1aOyPWr5iiKEQ+63AQGm8JXvUdogfMOM2+dlXzbm43lALy9
	 /zTSBeqKce9y5hrP2/pv46++olaQ8w/kRC4S78c0=
Date: Mon, 29 Sep 2025 21:37:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
	dakr@kernel.org, acourbot@nvidia.com,
	Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com, Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>,
	Yury Norov <yury.norov@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	nouveau@lists.freedesktop.org
Subject: Re: [PATCH v4 1/6] nova-core: bitfield: Move bitfield-specific code
 from register! into new macro
Message-ID: <2025092924-cork-mobilize-cfbf@gregkh>
References: <20250920182232.2095101-1-joelagnelf@nvidia.com>
 <20250920182232.2095101-2-joelagnelf@nvidia.com>
 <2025092157-pauper-snap-aad1@gregkh>
 <DCYHCLM67KRZ.366VS9PDKLYKY@kernel.org>
 <2025092125-urban-muppet-1c2f@gregkh>
 <20250923222434.GA2479829@joelbox2>
 <2025092425-sinuous-playoff-3618@gregkh>
 <76f87707-17d8-4cb0-8c81-e67ebf62984a@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76f87707-17d8-4cb0-8c81-e67ebf62984a@nvidia.com>

On Mon, Sep 29, 2025 at 03:26:57PM -0400, Joel Fernandes wrote:
> On 9/24/2025 12:40 PM, Greg KH wrote:
> > On Tue, Sep 23, 2025 at 06:24:34PM -0400, Joel Fernandes wrote:
> [..]
> > 
> >> For the separate issue of enforcing endianness with respect to (across)
> >> multiple fields, I agree with you that if the user's backend (the consumer of
> >> the data) is not doing such conversion, say via regmap, then that becomes a
> >> problem. But that problem is orthogonal/different and cannot be solved here.  
> > 
> > But that is exactly what these macros are being defined here for, so to
> > ignore that is going to cause problems :)
> > 
> 
> If needed, happy to add endianness support as needed by providing additional
> options to the macro. Based on this thread, it sounds like we want see if that
> is really needed here or can be solved elsewhere (?). The mental model I kind of
> have is this macro should only be dealing with CPU native endianness, much like
> bitfields in C deal with CPU endianness. Hmm.

Just don't go down the old path like drivers/net/fddi/skfp/h/supern_2.h
does with it's definition of:

	union tx_descr {
		struct {
	#ifdef  LITTLE_ENDIAN
		unsigned int    tx_length:16 ;  /* frame length lower/upper byte */
		unsigned int    tx_res   :8 ;   /* reserved      (bit 16..23) */
		unsigned int    tx_xmtabt:1 ;   /* transmit abort */
		unsigned int    tx_nfcs  :1 ;   /* no frame check sequence */
		unsigned int    tx_xdone :1 ;   /* give up token */
		unsigned int    tx_rpxm  :2 ;   /* byte offset */
		unsigned int    tx_pat1  :2 ;   /* must be TXP1 */
		unsigned int    tx_more  :1 ;   /* more frame in chain */
	#else
		unsigned int    tx_more  :1 ;   /* more frame in chain */
		unsigned int    tx_pat1  :2 ;   /* must be TXP1 */
		unsigned int    tx_rpxm  :2 ;   /* byte offset */
		unsigned int    tx_xdone :1 ;   /* give up token */
		unsigned int    tx_nfcs  :1 ;   /* no frame check sequence */
		unsigned int    tx_xmtabt:1 ;   /* transmit abort */
		unsigned int    tx_res   :8 ;   /* reserved      (bit 16..23) */
		unsigned int    tx_length:16 ;  /* frame length lower/upper byte */
	#endif
		} t ;
		long    i ;
	} ;

CPU endinness, hah, as if...


