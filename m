Return-Path: <linux-kernel+bounces-883978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C8EC2EF8F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 03:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A125E3ACBD1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 02:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAE423EA81;
	Tue,  4 Nov 2025 02:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zl5hiNbc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74267260A;
	Tue,  4 Nov 2025 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762223421; cv=none; b=U5P/Qb4fjg63kC3QhPVGCUMihmPfttSGeFmoF8JgqUSu6pARXL5Gt7IjgdEJ031JkTik20yiRv4MTks7fKDmPQ94nfJw/PD6g2pKNDNfkBjwDNT53p55DwTkf4EgtGOBly/EF6FupFu6ws/z94TlB/mtjfGk54gwZXJC4RQCif4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762223421; c=relaxed/simple;
	bh=fxYpS4zNrgdnsLg/kO47yYNbok6j8zNogFxSseVv2m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clgFsAUFfZ0rUinIFarRHH9TOFWod9a5jkYZAgJFBoLeVIKSWVjqISlZdv1Reer3zE9N/A5F7QkURocn0jj0mnsq5tdtUpgJoqA2GgrKFaDba9Ur5Mv6Z53uquIBua3VS8ViRQwTTUEp9+mdKB79Sa5yD2fWE2dA4Er4cXSKhVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zl5hiNbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB652C4CEE7;
	Tue,  4 Nov 2025 02:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762223421;
	bh=fxYpS4zNrgdnsLg/kO47yYNbok6j8zNogFxSseVv2m8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zl5hiNbcSkoxQ1H58pOLcKzyCMGZ7HUqkW2nqLjPPwfHsIygnj4artV7/m1JsRJWF
	 oTIipZrQt/Kn2+ELb8bRObnybWIzAlLylVP9gudMW+r2Wbw861gfdO0usZJ8iSFxYn
	 2HdO4bT5zcFjRf4aq+Zpu0Pm6U6ja3wbWniY/DxM=
Date: Tue, 4 Nov 2025 11:30:18 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Vamsi Attunuru <vattunuru@marvell.com>,
	Srujana Challa <schalla@marvell.com>,
	Julien Panis <jpanis@baylibre.com>
Subject: Re: [PATCH] Documentation: misc-devices: Fix C macro cross-reference
 syntax
Message-ID: <2025110402-going-swore-319e@gregkh>
References: <20251104022242.19224-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104022242.19224-1-bagasdotme@gmail.com>

On Tue, Nov 04, 2025 at 09:22:42AM +0700, Bagas Sanjaya wrote:
> Macro references in Octeon CN10K and TI TPS6954 docs are erroneously
> written using :c:macro:: (double colon) rather than :c:macro: (single
> colon), making these rendered in htmldocs output as italics with
> verbatim roles. Correct them.
> 
> Fixes: 5f67eef6dff394 ("misc: mrvl-cn10k-dpi: add Octeon CN10K DPI administrative driver")
> Fixes: dce548889650c1 ("Documentation: Add TI TPS6594 PFSM")

Please break this up into 2 different patches as you are doing 2
different things.

thanks,

greg k-h

