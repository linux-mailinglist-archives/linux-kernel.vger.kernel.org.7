Return-Path: <linux-kernel+bounces-693710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01702AE02A1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 12:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08933A93D2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 10:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E54223DF5;
	Thu, 19 Jun 2025 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JqML1Wc7"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9EE223302
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 10:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750328848; cv=none; b=nPU0O3V+6EFtrFny07dcjnfVbCKb0qRjNtFio4kfeos0NDEya6ILqDy9hgt6EiSH3/GWFX6QBPD63WmcqSLVAXDNZetk7tPISjjWr5tf8vmCLmaj0WqyPJXH3e0vmZjfEbWzSIAXnTt6nGxnPyn1PwdQOhM0fWBr2itJGd8EGP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750328848; c=relaxed/simple;
	bh=Ha5pBnLB+/Wbwr2eoWpkZtiP3585DllDK64zqWFbpak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oh1pyZaAYsctTcmhF6vIhBYD/Uo61w7c409bDsSN35wjSkSCWF50GIUZtztVFUCjF/xTRp+d4u7e6EpPB+ND1nTNrgchQaXCwjQ3StPf+2bzZnOAJNGZpVFwFandTbWYi3+7NGv99U4lf0avVuSrPZZdK+e4N7CWmYRAL8t661w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JqML1Wc7; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso1128364a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 03:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750328845; x=1750933645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rZdjOXoFyem5NArONK8WTWDxOqEiaiq3A+0Wr1BizhY=;
        b=JqML1Wc7NAPWv3jL7VLHB1MZbHZO0/r1ugdc5f4weQlFrr1GcdTqHydNmE1MRa5/kF
         ufOTkR6Ig3UNdJpMBWSqTtwOgRx4lbho2ahCK3FlZ+C/wPRXwOSOmpB0r25t784+HrEy
         x/SVy/S8+1DCYV1HsHi7k/G6cEsirZgKD43YVS3AlN5OI3wIsvgX6F1XPX7jZtuIAnF8
         se2axncjg8I/2lDU74Ut+MARSWJenNq+UyJBid+NkgVdEWSBmnjO+rXWIaizPTOGG7Yq
         cL/NBlzsaURJZ4qEyE2PDh8jMPNd5fgfj8c/Xubce2jbOjIdmt3hMD0wYGpGqeYn/3av
         eIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750328845; x=1750933645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZdjOXoFyem5NArONK8WTWDxOqEiaiq3A+0Wr1BizhY=;
        b=Yp28aerFDHtxPgzuGhptPs9ESHkm1JMqEyezEXANnVJ+zow6mIROTXtoGXNoLK1Sip
         1EtMdHTykxQfIlUaMFMyMZCdaBEKlySNl4JLouZOa+cq2KJY6lcvKs+QmQMS35ChjqQE
         ii/p4yDb57MhUem2+qLGbIWIyHu3Ah3h1a8xSoLY7l+rMDS0rOdgsCqCs6FFCietck7r
         3cegmf5+CLFKCu1D+alMUgY4vt/SNwz1O7Slirx/VuRQwKLaK7oVCTXRG6VD/OBiuD2x
         e8m9H+i8tjDRZ1UTXaPVBjCvNP27ocrhcyQX+YSfvG8lBZuDm/JEy4q9bMu/IGoelm15
         67Og==
X-Forwarded-Encrypted: i=1; AJvYcCXAkA3RsuTZagqvoIu3fhze2fBxXs+mG0jZJcI2dl+BZkQK2vSHxsnpD9+VMMfQleY1bo2bs4vihufPCEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1aHGtI2lWNOUZJisY3e2LzfqXRS1SArnoBjI5LyCsQhYOX4fY
	55dTx0lMDeSqsQR+VdGdwqUyBStUWr6tyk0HGxwzwZ5BjB8hxl4cdsWoNsPyVeblmWTXFWlzRfG
	S6rfraLLxdBIL7MojKKygEhzDVzczOzMHMULLe/Ma4w==
X-Gm-Gg: ASbGncs81Q5pdgEVY6gWTNHhh2Xm0pqngY+UdpYuYqgfZaDBvs0wxhtVGYCTUvCW8r1
	20mB690kNpjgoVsG+pFx05JDSIWF1MLdtuxJebo0z0Z3qmhLaWs5K2XzJKCVp5KYbQ3IUpmxhu/
	33nAzRnVEq/WleZuUIfR+od/88ik5kZt2AIKjyo2mckQ==
X-Google-Smtp-Source: AGHT+IFYv31V1VgYj7wiOVm2AcC04l9vXTzMKPEBeuLWE5AE7D0FfXX1iQiGE7VRTJ93WYdkcN9OxbbTEzQSKRnBhmU=
X-Received: by 2002:a17:907:3d45:b0:ad8:91e4:a937 with SMTP id
 a640c23a62f3a-adfad6d19a6mr2027896366b.57.1750328844882; Thu, 19 Jun 2025
 03:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613183753.31864-1-ebiggers@kernel.org> <20250613183753.31864-3-ebiggers@kernel.org>
 <20250617201748.GE4037@suse.cz> <20250617202050.GB1288@sol> <20250617204756.GD1288@sol>
In-Reply-To: <20250617204756.GD1288@sol>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 19 Jun 2025 12:27:13 +0200
X-Gm-Features: Ac12FXxSj7KHDxvaD5P250FA9B_gw9jTRxjEbr9hoYukN-7E6ZC33jFtxLAiusA
Message-ID: <CAPjX3Ff-A+M9Ad7iJFTDGAs=M1d6zOqDq48i1GmRn967a_GDsw@mail.gmail.com>
Subject: Re: [PATCH 2/2] crypto/crc32[c]: register only "-lib" drivers
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Sterba <dsterba@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, linux-btrfs@vger.kernel.org, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Jun 2025 at 22:48, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Jun 17, 2025 at 01:20:50PM -0700, Eric Biggers wrote:
> > On Tue, Jun 17, 2025 at 10:17:48PM +0200, David Sterba wrote:
> > > On Fri, Jun 13, 2025 at 11:37:53AM -0700, Eric Biggers wrote:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > >
> > > > For the "crc32" and "crc32c" shash algorithms, instead of registering
> > > > "*-generic" drivers as well as conditionally registering "*-$(ARCH)"
> > > > drivers, instead just register "*-lib" drivers.  These just use the
> > > > regular library functions crc32_le() and crc32c(), so they just do the
> > > > right thing and are fully accelerated when supported by the CPU.
> > > >
> > > > This eliminates the need for the CRC library to export crc32_le_base()
> > > > and crc32c_base().  Separate patches make those static functions.
> > > >
> > > > Since this patch removes the "crc32-generic" and "crc32c-generic" driver
> > > > names which crypto/testmgr.c expects to exist, update crypto/testmgr.c
> > > > accordingly.  This does mean that crypto/testmgr.c will no longer
> > > > fuzz-test the "generic" implementation against the "arch" implementation
> > > > for crc32 and crc32c, but this was redundant with crc_kunit anyway.
> > > >
> > > > Besides the above, and btrfs_init_csum_hash() which the previous patch
> > > > fixed, no code appears to have been relying on the "crc32-generic" or
> > > > "crc32c-generic" driver names specifically.
> > > >
> > > > btrfs does export the checksum driver name in
> > > > /sys/fs/btrfs/$uuid/checksum.  This patch makes that file contain
> > > > "crc32c-lib" instead of "crc32c-generic" or "crc32c-$(ARCH)".  This
> > > > should be fine, since in practice the purpose of this file seems to have
> > > > been just to allow users to manually check whether they needed to enable
> > > > the optimized CRC32C code.  This was needed only because of the bug in
> > > > old kernels where the optimized CRC32C code defaulted to off and even
> > > > needed to be explicitly added to the ramdisk to be used.  Now that it
> > > > just works in Linux 6.14 and later, there's no need for users to take
> > > > any action and this file is basically obsolete.
> > >
> > > Well, not the whole file, because it says which checksumming algo is
> > > used for the filesystem, but the implementation part is.
> >
> > Oh, right.  It's one of those sysfs files that don't follow the normal sysfs
> > convention and contain multiple values.  I'll update the paragraph above to
> > clarify that it's referring to the driver name part of the file.
>
> I revised it to:
>
> btrfs does export the checksum name and checksum driver name in
> /sys/fs/btrfs/$uuid/checksum.  This commit makes the driver name portion
> of that file contain "crc32c-lib" instead of "crc32c-generic" or
> "crc32c-$(ARCH)".  This should be fine, since in practice the purpose of
> the driver name portion of this file seems to have been just to allow
> users to manually check whether they needed to enable the optimized
> CRC32C code.  This was needed only because of the bug in old kernels
> where the optimized CRC32C code defaulted to off and even needed to be
> explicitly added to the ramdisk to be used.  Now that it just works in
> Linux 6.14 and later, there's no need for users to take any action and
> the driver name portion of this is basically obsolete.  (Also, note that
> the crc32c driver name already changed in 6.14.)

How about instead removing that part since it's useless now?

