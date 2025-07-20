Return-Path: <linux-kernel+bounces-738114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DE7B0B478
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 11:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1159B7AC219
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 09:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F035A1DF75C;
	Sun, 20 Jul 2025 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wtmt3vWH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C98317741
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 09:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753002466; cv=none; b=EBQilTT5NCNhXhX8t81/Gd9+5Nxx8ejgJp8gn3q7Wcj5lixm2I6/3XQD0a6izbsfcTOakYuzH62KJQFaiET6PsuSt3X/8bnZC4uYtYBo8Way3n8SWb5GTCDBTcnUpfpuky2/ZUsCDkAe31fXklP6Mhsf3uFxmZWwEFybmvQpLlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753002466; c=relaxed/simple;
	bh=VC2hiq6gXIHTHWIs7CyGibaVaPNl36kIjJQ+B2OrhYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIZWDLHNZPOwDvggiCdwsPPC4iW//2qfT4zrUBO6ZZJQ7D0WXciIN1rg7l8Dfmg9Ge8wcSJ/NjrkA525yN6kdN1FPf80xHHkpnWlIqdHbxMgLvIxX+YOpDuOh3Vn0glb1ajHsexuMnEfIoIGcng+q5l5vgmc41ARwjWa5cFoFa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wtmt3vWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADC4C4CEE7;
	Sun, 20 Jul 2025 09:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753002464;
	bh=VC2hiq6gXIHTHWIs7CyGibaVaPNl36kIjJQ+B2OrhYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wtmt3vWHKCtac0B/6R4W/VJwTO72by1yv/fvA2u+eSyXgUnCQejQlIfhtnF/qYVzK
	 njSHXb4+6w4AHeRn4ns27s/YSiIT94Y1ROCKhGEIb9+XK+P96AUf9KkwDRdKnU1tH1
	 c9v0Te+sTAaNbM/ityq6DeJqP0NBWgpp47H2BPZc=
Date: Sun, 20 Jul 2025 11:07:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: Eli Billauer <eli.billauer@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] char: xillybus: Replace deprecated MSI API
Message-ID: <2025072038-improvise-polymer-a538@gregkh>
References: <8d3513e3-6294-b6df-189a-cc3bee76f0a3@outbound.gmail.com>
 <aHskWESzZdyBFj4x@pc>
 <2025072004-karaoke-stilt-ef20@gregkh>
 <aHyvPWeN_4JmPAzc@pc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHyvPWeN_4JmPAzc@pc>

On Sun, Jul 20, 2025 at 09:56:29AM +0100, Salah Triki wrote:
> On Sun, Jul 20, 2025 at 10:33:47AM +0200, Greg Kroah-Hartman wrote:
> > 
> > This says what you are doing, but not _WHY_ you are doing it.
> > 
> 
> I did the replacement because pci_enable_msi() is deprecated, isn't that
> enough ?

If it was a simple search/replace, why wouldn't have been done already?

Again, you need to prove why this is ok at all.  pci_enable_msi()
shouldn't be used in new drivers, but what's wrong with it being in
existing drivers?  Especially in ones that you can't test to verify it
still works after changing the code?

thanks,

greg k-h

