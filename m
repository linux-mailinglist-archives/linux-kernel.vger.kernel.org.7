Return-Path: <linux-kernel+bounces-845716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4003CBC5E70
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5604F1885F45
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FA2289824;
	Wed,  8 Oct 2025 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbkxQ+kC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F407924DCE2
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759939076; cv=none; b=CB7kN21M5vdnovykVYgCQBq2qU3rxAPbVz7QDVPq7W8gDfWXRojK9KXPg9NLX8//yR0ObhITKLCon/WcsYDOkXMkiNuH/3fLsFc21npU8sJtf7w4YhuICsF2Yc1rxAewDsePVyrJZJ442O22SksyFU+u7KU7Wc89NFSKcQ/VyXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759939076; c=relaxed/simple;
	bh=6RwJDsqNCtP4Lh2s4rBX6NGHBGUuTrWzO9tqHf9VgIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SekWpjbHx+v/lL8sSxbGKSJAq8uiFL9GdcbioMb5CTWvp0OQidzkdaU/O6yq9n313Dl6sPcspL6P9WyrSs84rCZbJP4P2rhITX60Lj6B3jjWJhEKfw5ez7fvKG++YYA9XJgicFHQIUZRn8oi3D8gZb5iSDmBOz70rimRDTqY/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbkxQ+kC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85D6C4CEE7;
	Wed,  8 Oct 2025 15:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759939075;
	bh=6RwJDsqNCtP4Lh2s4rBX6NGHBGUuTrWzO9tqHf9VgIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AbkxQ+kCh8hI2cIpY6NqiqWKJOYTeF1Vu+1xu9BGBBYpMwIb/yr80OCxkYt/8leyS
	 G4kwa2iEGaMmeNv7lZJawGjGtZZRz0XMql+tJp7LplRLNUtVWv3SQ6aMWQsHh+gfnU
	 sZoUHteYjVqDsafygZ96E2I+oygZ3Y57EUYsvfDXNTPYgzztC7Qi7PUlnqkCaboFAk
	 R1TbNEs9H9Qo0a49wpiH+OfgO+a4D7wImb07IHseaQxwxlY/R5rV1c/4wv8tzdHvhh
	 K/bA4PVIo/+PiB9oOel/aV8XT5fwoEIkBgg6DZv1QqyJxwgUXQYpAkhZO4aQMDobHm
	 vxDbdBcxAsnOQ==
Date: Wed, 8 Oct 2025 16:57:52 +0100
From: Lee Jones <lee@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Improve error handling for qnap-mcu transfers
Message-ID: <20251008155752.GA8757@google.com>
References: <20250923160853.1925674-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923160853.1925674-1-heiko@sntech.de>

On Tue, 23 Sep 2025, Heiko Stuebner wrote:

> Digging deeper into how that MCU behaves, I found out it can return
> more status codes than the "@0" for "ok".
> 
> The additional codes can report a failed checksum verification and
> some "general" error for the command execution.
> 
> This also explains sporadic command timeout messages, I have seen
> over time, when the controller sends an error code while we expect
> a longer reply from it.
> 
> So while I'm not sure yet why it reports an error, with these changes
> we at least handle the error return code in a meaningful way.
> 
> 
> Heiko Stuebner (4):
>   mfd: qnap-mcu: Calculate the checksum on the actual number of bytes
>     received
>   mfd: qnap-mcu: Use EPROTO in stead of EIO on checksum errors
>   mfd: qnap-mcu: Move checksum verification to its own function
>   mfd: qnap-mcu: Add proper error handling for command errors
> 
>  drivers/mfd/qnap-mcu.c | 55 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 51 insertions(+), 4 deletions(-)

Note to self: patches 1-3 look good.

-- 
Lee Jones [李琼斯]

