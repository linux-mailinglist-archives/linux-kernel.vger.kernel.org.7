Return-Path: <linux-kernel+bounces-842693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F025ABBD50B
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 10:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67C86349A4C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 08:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695B325B69F;
	Mon,  6 Oct 2025 08:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R3lmH1U+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A426719C553
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738466; cv=none; b=Gnaql1m9cAENas35i8oEd8lKT6dJ9ir53mVhNKPGImjslv1oped9zmIzu3K660Tjb+XFSApDehV4biGElS/qRMdZ7JgjqPXok98DvdKBpVbzQrFLymK3p3XRACRreewkqE/aFp5w10f+dnRvwVD3IFicFk1gpXIHWZZWWk6F5XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738466; c=relaxed/simple;
	bh=lpdo8shL6qCULRJijFlMV4LAGeuJwJtU6Oa+8jn22uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYnAgE4x/ypwBSWLxcn4IgoHhzau7OPDK5zAtt6Ft/q/ipOlBqnEWRxCex62qbXPDaa1zvTuAk+iwHo2UQGBcD1TRw5YwCeD772UIqLMxlONeQgY2AxigBFUhhOO/hM6M0xmtXhoOTSBD+TbxNkJVDaX234qglu82fOw5kzoxTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R3lmH1U+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC42C4CEF5;
	Mon,  6 Oct 2025 08:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759738466;
	bh=lpdo8shL6qCULRJijFlMV4LAGeuJwJtU6Oa+8jn22uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R3lmH1U+Dg2ouNbNEgM7YyuuQGRj1sMuc8Qnaqt4Zov3Z5TZabmXYeg5f3R367sE1
	 BMhHwh6Mu2ik53xRRbA1cQtaD7grzZs/qVIHE7iQ3SNqFTEGhxJbDWHzOmHqGztUwy
	 zEnA9cOyLZFWfcAnki15E0DFCTLnSHvrM0sWUglM=
Date: Mon, 6 Oct 2025 10:14:23 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "cve@kernel.org" <cve@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CVE-2025-39751: ALSA: hda/ca0132: Fix buffer overflow in
 add_tuning_control
Message-ID: <2025100646-strategy-spindle-ae8a@gregkh>
References: <2025091142-CVE-2025-39751-c340@gregkh>
 <f24f4524894417954b9de4ccec69c2e17aae3d5f.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f24f4524894417954b9de4ccec69c2e17aae3d5f.camel@oracle.com>

On Mon, Oct 06, 2025 at 07:07:00AM +0000, Siddh Raman Pant wrote:
> On Thu, 11 Sep 2025 18:52:52 +0200, Greg Kroah-Hartman wrote:
> > ALSA: hda/ca0132: Fix buffer overflow in add_tuning_control
> > 
> > The 'sprintf' call in 'add_tuning_control' may exceed the 44-byte
> > buffer if either string argument is too long. This triggers a compiler
> > warning.
> > Replaced 'sprintf' with 'snprintf' to limit string lengths to prevent
> > overflow.
> > 
> > The Linux kernel CVE team has assigned CVE-2025-39751 to this issue.
> 
> While the change is good for defensive reasons, there isn't actually
> any buffer overflow as it is to "fix".
> 
> The largest string possible is "Wedge Angle Playback Volume", whose
> length is less than 44.

Thanks for the info.  What was the compiler warning about then if it
could detect just how big the string would always be as these are static
values?

Should this CVE be rejected?

thanks,

greg k-h

