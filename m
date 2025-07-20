Return-Path: <linux-kernel+bounces-738099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC14B0B446
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 10:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671ED188C59C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 08:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5441AC43A;
	Sun, 20 Jul 2025 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eFOmFgaC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A761710E9
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753000431; cv=none; b=lKLojEJdFcesWc4bjQpEUcntpgnltR0FiuLCK027k+1pSxwxpvBINqHO3IpQxrQ2m3npVYc56I7AQbmA6QzHOPr1N2Qz9biIroO/xESOsrkuxa4C/a5ejKqCMEeCyrxpu0ZxpCf7KoTHQMlEuJT2TGKJlLdAYW0/G57Q11qkC9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753000431; c=relaxed/simple;
	bh=V8s0MM5tF+H3qGQuJf7gfPptGeyr/7daqlGtLDcD3kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imWmUkY0EvwoV95ONS+9L+M+h6ABTYvSD1P6tguSjFDLY3a4Kut7oKjPzIE0TYhPmh30pgzSratAI1khNzxkiPVKgMXPpKW/in8jXJmeU1fLlsvjZDUBUtIdj5QAZ17Gl8b3/FAnIvvlGeQ5iTwugD2GcUA8exvsBGnB0kAkuIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eFOmFgaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4EFC4CEEB;
	Sun, 20 Jul 2025 08:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753000431;
	bh=V8s0MM5tF+H3qGQuJf7gfPptGeyr/7daqlGtLDcD3kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eFOmFgaCCC/0eEDSrH62aSU4YWtM1tzhZkJIYoTxeroTxdxEBvajsyLyHRna3PqNc
	 CjHH2ivcwGeRPuH5RsF9ElYstdqoBw1g+ceW2CHxfYu+vY1m9Gx9WE53oJ1qUfWloI
	 JZXXNbkPquPw5w2Hdfdi3mD9ObW1pCVt5fNnXvWE=
Date: Sun, 20 Jul 2025 10:33:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: Eli Billauer <eli.billauer@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] char: xillybus: Replace deprecated MSI API
Message-ID: <2025072004-karaoke-stilt-ef20@gregkh>
References: <8d3513e3-6294-b6df-189a-cc3bee76f0a3@outbound.gmail.com>
 <aHskWESzZdyBFj4x@pc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHskWESzZdyBFj4x@pc>

On Sat, Jul 19, 2025 at 05:51:36AM +0100, Salah Triki wrote:
> Replace deprecated pci_enable_msi() with pci_alloc_irq_vectors().

This says what you are doing, but not _WHY_ you are doing it.

If this was a simple search/replace, why would it not have been done
already?  Are you _SURE_ this is correct, and if so, why?  You need to
prove it here...

thanks,

greg k-h

