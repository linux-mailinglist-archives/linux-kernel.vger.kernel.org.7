Return-Path: <linux-kernel+bounces-885572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64330C335A3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0F018C45B5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379652E06E6;
	Tue,  4 Nov 2025 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bGGXVi+m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3D4AD2C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 23:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298142; cv=none; b=tyzZbGX33s0Hsj5o5GQsRxR2g4jWNjbCt30g7fVPn9uAS49u7znhuImlMVZDRnNfDoUlZRJB1rtd52hZfbh2n5wfPxVIWGO7vqM3dFOaNy7c/qELLA8ITtn4Q362JzLcnKeaY8K5QlVjS/VxRJAvoG7+VAlmzyvksVqT0ArrMQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298142; c=relaxed/simple;
	bh=QCcUB8S4XGVXI1f3hrEdZ4qqStwzPq3/LosEGwLZkUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yyv8Dk0nqqK7xeWXcrOeNzrj8FkV8eOjJHdSmjSYwJusiNR3XX9XWchXV7SCAUFcnuX5oVIa8tcGs2vBY61d9kZN7xY23aUdM+e7RxzzNchubAoD3k8mjuQsbY6095SxWNvfHVJHozBvIj4RTlD7pSXJxhIU3ANZV++cgM7Wi/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bGGXVi+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2686C4CEF7;
	Tue,  4 Nov 2025 23:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762298142;
	bh=QCcUB8S4XGVXI1f3hrEdZ4qqStwzPq3/LosEGwLZkUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bGGXVi+mgBYkFjfzOPTZTyX0K554BSWzOTLUZc8mMjVr9aAKH6Rnjs55P83Lp/bDL
	 /UwgT6i9dEyulfoq1KjzC4LWTESr1lIkSXXWkbcLEwF6LtKpDqNudbybwZkMXFswXR
	 QW8gvH69iWrcV9IoEKXzx3SWplw5zR91kgRl8vNI=
Date: Wed, 5 Nov 2025 08:15:39 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "A. Sverdlin" <alexander.sverdlin@siemens.com>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Michael Walle <mwalle@kernel.org>,
	Hui Wang <hui.wang@canonical.com>,
	TRINH THAI Florent <florent.trinh-thai@cs-soprasteria.com>
Subject: Re: [PATCH] eeprom: at25: convert to spi-mem API
Message-ID: <2025110513-manliness-repayment-d005@gregkh>
References: <20250702222823.864803-1-alexander.sverdlin@siemens.com>
 <638496dd-ec60-4e53-bad7-eb657f67d580@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <638496dd-ec60-4e53-bad7-eb657f67d580@csgroup.eu>

On Mon, Nov 03, 2025 at 05:33:34PM +0100, Christophe Leroy wrote:
> Hi,
> 
> Le 03/07/2025 à 00:28, A. Sverdlin a écrit :
> > From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> > 
> > Replace the RAW SPI accesses with spi-mem API. The latter will fall back to
> > RAW SPI accesses if spi-mem callbacks are not implemented by a controller
> > driver.
> 
> With this patch (kernel v6.17.1) our powerpc boards are totally unstable, we
> get multiple random Oops due to bad memory accesses.
> 
> With this commit reverted the board is stable again.
> 
> The SPI driver is:
> 
> CONFIG_SPI=y
> CONFIG_SPI_MASTER=y
> CONFIG_SPI_MEM=y
> CONFIG_SPI_FSL_LIB=y
> CONFIG_SPI_FSL_CPM=y
> CONFIG_SPI_FSL_SPI=y
> 
> How can we further investigate the issue ?

We can revert it until it comes back working properly.  Can you send a
revert so that I can apply it?

thanks,

greg k-h

