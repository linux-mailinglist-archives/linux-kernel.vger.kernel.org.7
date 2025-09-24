Return-Path: <linux-kernel+bounces-830373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47577B99806
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C59326A7A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67CB2E1F01;
	Wed, 24 Sep 2025 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pfXct+1S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBA42E1C56;
	Wed, 24 Sep 2025 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758711171; cv=none; b=bxU4bxn+adNvygQxPp/gOSZJJPq4L23Axl2FyHKmXbT+1lbOhQsnBTBpmDBqV9WcRiczRwVucraaBBrRCryLil919MikVPFlR6BFIsaT68Rp9StNXG802GQX3UTxAGk1cDrlkHkwoKlvMChONv9VAlCtume2nZFZweMguzRpCGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758711171; c=relaxed/simple;
	bh=mS9/Zki3fhvWxi5tDc3K8QUX3Ph2SWEaxUiy7dy4C9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByfgS632ddxHo0XOO5sZxlu2O1xZvqnBEKTVhWMZVtdnSnr358d/cm8muRdmh51YF4D6h2RDH7ljIwZkrDXfNNr/qUJbyYvC144MnfQfRXqAGoDNSI9VZoSM7jcuzKcz/GqJjaHuYrXZJAB5HVl5Hoy7OIXgejkG1zmjyBHBAQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pfXct+1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2231C4CEE7;
	Wed, 24 Sep 2025 10:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758711170;
	bh=mS9/Zki3fhvWxi5tDc3K8QUX3Ph2SWEaxUiy7dy4C9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pfXct+1STk1MPGFrPNKalM/8qJed+6n69m8u7MwE4Y9INm5+LrtlQ8TITuX3I7HGG
	 e/EOZlqXiTlyF7ciU82ciYJ/MD2NJvMj8LePhbu8UMvh6/AN4CsiYNQIycWhDZn7Pi
	 snoVRV4mJ5fQGkPQbOSGr81NZdiDBZt/hPB0DHLI=
Date: Wed, 24 Sep 2025 12:52:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Benno Lossin <lossin@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org, acourbot@nvidia.com,
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
Message-ID: <2025092432-entrust-citizen-0232@gregkh>
References: <20250920182232.2095101-1-joelagnelf@nvidia.com>
 <20250920182232.2095101-2-joelagnelf@nvidia.com>
 <2025092157-pauper-snap-aad1@gregkh>
 <DCYHCLM67KRZ.366VS9PDKLYKY@kernel.org>
 <2025092125-urban-muppet-1c2f@gregkh>
 <DCYIX8URVIWM.2ZK3GHH3J82XQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCYIX8URVIWM.2ZK3GHH3J82XQ@kernel.org>

On Sun, Sep 21, 2025 at 03:47:55PM +0200, Danilo Krummrich wrote:
> On Sun Sep 21, 2025 at 2:45 PM CEST, Greg KH wrote:
> > Again, regmap handles this all just fine, why not just make bindings to
> > that api here instead?
> 
> The idea is to use this for the register!() macro, e.g.
> 
> 	register!(NV_PMC_BOOT_0 @ 0x00000000, "Basic revision information about the GPU" {
> 	    28:24   architecture_0 as u8, "Lower bits of the architecture";
> 	    23:20   implementation as u8, "Implementation version of the architecture";
> 	    8:8     architecture_1 as u8, "MSB of the architecture";
> 	    7:4     major_revision as u8, "Major revision of the chip";
> 	    3:0     minor_revision as u8, "Minor revision of the chip";
> 	});
> 
> (More examples in [1].)

Wonderful, but I fail to see where the endian-ness of this is set
anywhere.  Am I just missing that?  The regmap api enforces this idea,
and so the 

> 
> This generates a structure with the relevant accessors; we can also implement
> additional logic, such as:
> 
> 	impl NV_PMC_BOOT_0 {
> 	    /// Combines `architecture_0` and `architecture_1` to obtain the architecture of the chip.
> 	    pub(crate) fn architecture(self) -> Result<Architecture> {
> 	        Architecture::try_from(
> 	            self.architecture_0() | (self.architecture_1() << Self::ARCHITECTURE_0_RANGE.len()),
> 	        )
> 	    }
> 	
> 	    /// Combines `architecture` and `implementation` to obtain a code unique to the chipset.
> 	    pub(crate) fn chipset(self) -> Result<Chipset> {
> 	        self.architecture()
> 	            .map(|arch| {
> 	                ((arch as u32) << Self::IMPLEMENTATION_RANGE.len())
> 	                    | u32::from(self.implementation())
> 	            })
> 	            .and_then(Chipset::try_from)
> 	    }
> 	}
> 
> This conviniently allows us to read the register with
> 
> 	let boot0 = regs::NV_PMC_BOOT_0::read(bar);
> 
> and obtain an instance of the entire Chipset structure with
> 
> 	let chipset = boot0.chipset()?;
> 
> or pass it to a constructor that creates a Revision instance
> 
> 	let rev = Revision::from_boot0(boot0);
> 
> Analogously it allows us to modify and write registers without having to mess
> with error prone shifts, masks and casts, because that code is generated by the
> register!() macro. (Of course, unless we have more complicated cases where
> multiple fields have to be combined as illustrated above.)
> 
> Note that bar is of type pci::Bar<BAR0_SIZE> where BAR0_SIZE in our case is
> SZ_16M.
> 
> However, the type required by read() as generated by the register!() macro
> actually only requires something that implements an I/O backend, i.e
> kernel::io::Io<SIZE>.
> 
> pci::Bar is a specific implementation of kernel::io::Io.
> 
> With this we can let the actual I/O backend handle the endianness of the bus.

Ok, great, but right now it's not doing that from what I am seeing when
reading the code.  Shouldn't IoMem::new() take that as an argument?

But, that feels odd as our current iomem api in C doesn't care about
endian issues at all because it "assumes" that the caller has already
handle this properly and all that the caller "wants" is to write/read to
some memory chunk and not twiddle bits.

> (Actually, we could even implement an I/O backend that uses regmap.)

That would probably be best to do eventually as most platform drivers
use regmap today as it's the sanest api we have at the moment.

> So, I think the register!() stuff is rather orthogonal.

I think it's very relevant as people seem to just be "assuming" that all
the world (hardware and cpus) are little-endian, while in reality, they
are anything but.  As proof, the code that uses this register!() logic
today totally ignores endian issues and just assumes that it is both
running on a little-endian system, AND the hardware is little-endian.

As a crazy example, look at the USB host controllers that at runtime,
have to be queried to determine what endian they are running on and the
kernel drivers have to handle this "on the fly".  Yes, one can argue
that the hardware developers who came up with that should be forced to
write the drivers as penance for such sins, but in the end, it's us that
has to deal with it...

So ignoring it will get us quite a ways forward with controlling sane
hardware on sane systems, but when s390 finally realizes they can be
writing their drivers in rust, we are going to have to have these
conversations again :)

thanks,

greg k-h

