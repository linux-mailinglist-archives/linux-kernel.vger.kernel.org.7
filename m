Return-Path: <linux-kernel+bounces-792749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B939AB3C87A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 08:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097181BA7D32
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 06:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CC5227B8E;
	Sat, 30 Aug 2025 06:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O4s9gljo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB711E47A5;
	Sat, 30 Aug 2025 06:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756534949; cv=none; b=GO9RJP2R/H54db7VVjoB3OdV8rjmTyhMSsNmMOt3KCmheEEWtJTmgdLbcSZxHHU3wahnuvdN1jA3lVBw7x/HNHXnRTUOob1dujYlhiF9Mt3Wc146gDUJ5hd+Wluyub8t78+CIKCqqqNKCTXkNgseOLhhDG6ZvgatC2n/7RD8oVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756534949; c=relaxed/simple;
	bh=mabqiHyZkrNxJJlgR88JTFnhROF9Xw7ZYNAKxgXinHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDzTzmAEmWA80LVln34zRa4pnzEW03NfU2yhTFlIwky1eoKgejR1I6nn6FJVdMU74aO9eIj03y+K4qrfFS9pGX0a2lVWbAMDBl67TYlqtY/PkoMPXs/Zt8H5RoF0r9oA9TV3M7gXCCwUrmMyx9WEAb+zxOIDDrFhB1r98cc+/KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O4s9gljo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AE8C4CEEB;
	Sat, 30 Aug 2025 06:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756534949;
	bh=mabqiHyZkrNxJJlgR88JTFnhROF9Xw7ZYNAKxgXinHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O4s9gljo/JGYAbaf+4abg4B5sjFa182g58nm4EO+hGtF4tPvimGM+QZ7wakrKzuA6
	 kNSxWEVq97pqqQEJdfWhxs3/KKNDzYAMmPcUMCkuk8oYvV2Kn6gfMUfRwEdcpdIMCK
	 xIm4dNbaIWxKh8pbkPbVg2tXWygWSC5YjJk35sbY=
Date: Sat, 30 Aug 2025 08:22:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] rust: device: fix unresolved link to drm::Device
Message-ID: <2025083018-playful-villain-f5a9@gregkh>
References: <20250829195745.31174-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829195745.31174-1-dakr@kernel.org>

On Fri, Aug 29, 2025 at 09:57:42PM +0200, Danilo Krummrich wrote:
> drm::Device is only available when CONFIG_DRM=y, which we have to
> consider for intra-doc links, otherwise the rustdoc make target produces
> the following warning.
> 
> >> warning: unresolved link to `kernel::drm::Device`
>    --> rust/kernel/device.rs:154:22
>    |
>    154 | /// [`drm::Device`]: kernel::drm::Device
>    |                      ^^^^^^^^^^^^^^^^^^^ no item named `drm` in module `kernel`
>    |
>    = note: `#[warn(rustdoc::broken_intra_doc_links)]` on by default
> 
> Fix this by making the intra-doc link conditional on CONFIG_DRM being enabled.
> 
> Fixes: d6e26c1ae4a6 ("device: rust: expand documentation for Device")
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508261644.9LclwUgt-lkp@intel.com/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/device.rs | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

