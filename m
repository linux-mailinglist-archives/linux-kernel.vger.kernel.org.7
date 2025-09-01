Return-Path: <linux-kernel+bounces-793669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1A4B3D69D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D61176D28
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68871AF0AF;
	Mon,  1 Sep 2025 02:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="ihoikpdX"
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1BB1957FC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756693244; cv=none; b=TpJyZUZ1qHfS1f51/vzdpAVVAo6mwp1qDn7BePLiU65hHsAxhgbCNmU4R2hepRx9yPAlz4uZ0M4x1Rf8D5vyWtyerY6LEXvxJsD1bTyy+x2L4dz+TJNfBiFB6mTbvJooosOeFPkmlj1CAHTyYwoKT7ciaeQWuxPXyE978Dknigw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756693244; c=relaxed/simple;
	bh=JT8xpHm5akD0SVc+wble1gZNpbaz8K54nMXqsQ2BeDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJzwEM+vARhx6Q1SX3RwM63/KQ3xWC5l6rmNnzr+nuyToGrS31fp6uiI25+BqMaTVfnkN8mBdwSYJiLRWelh6VmOJCE+he+7m+nmX6dTn91XCIYbCAMYQLyeVqUikg7HKe6r/E9bCe2EYRtv6TXpKlX8KwS7wP1cVENz39bSCic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=ihoikpdX; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ucGLHetyfvHvORDISd/LhKKU2NT0oX5XnMJyBYchNJs=; t=1756693241; x=1757557241; 
	b=ihoikpdX9gKP1ctStIORSGXvJCtlbIlr338I6AHZMZ44fngMcfuAHPqWwuc63f9bT8H0D3IgSvG
	GTY0dr2cIvlheMZraWTPhgN/nFVwpDa3hQSQb7tMIKMSXtFALucfIw04z09p/Kgp6a7FAaRVSkQe2
	5ghfNNqeK4FaEBUw1U0XNViMbIRLPtcRZUSZWrCgZ68UjbIVU2WwZqvorAgkGxpx9P2L9bcmCVooB
	23k3x58McxrU33Dkzosz8kz8psR6yZV8MwrJKm+2xE0fFLxhRQMY4Hrwq0sW56lthmVFH254UtNo1
	2q6+fh5qkKtmOBTHIWWds/T87AL+F+MdFCdg==;
Received: from 135-180-5-199.fiber.dynamic.sonic.net ([135.180.5.199]:58629 helo=macbookair.lan)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <jgnieto@cs.stanford.edu>)
	id 1usu9t-0001Iv-Bg; Sun, 31 Aug 2025 19:20:37 -0700
Date: Sun, 31 Aug 2025 19:20:14 -0700
From: Javier Nieto <jgnieto@cs.stanford.edu>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_h5: implement CRC data integrity
Message-ID: <aLUC3u3ZrF35nIb6@macbookair.lan>
References: <20250827043254.26611-1-jgnieto@cs.stanford.edu>
 <a261ed13-4c0b-43cf-b177-d33272626d25@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a261ed13-4c0b-43cf-b177-d33272626d25@molgen.mpg.de>
X-Spam-Score: 0.8
X-Scan-Signature: f69c4e6b4bf914f22ae37cd490358bf0

Dear Paul,

Thanks for the review!

On Wed, Aug 27, 2025 at 12:56:50PM +0200, Paul Menzel wrote:

> Any btmon trace?

The presence of CRC is limited to the H5 layer, so it is not visible on
btmon. However, I did advertise and connect to a few devices while
running btmon and everything worked and looked as normal. I also ensured
that CRC was being used by adding temporary debugging prints.

> I´d add the above to the proper commit message.

Should I resubmit the patch as v2?

> >   static u8 h5_cfg_field(struct h5 *h5)
> >   {
> > -	/* Sliding window size (first 3 bits) */
> > -	return h5->tx_win & 0x07;
> > +	/* Sliding window size (first 3 bits) and CRC request (fifth bit). */
> > +	return (h5->tx_win & 0x07) | 0x10;
> 
> Could a macro be defined for the CRC request bit?

I thought about this, but decided against it since 0x10 is only used
here and in one other place. Also, the existing code does not define a
macro for the window size bits 0x07. I am not opposed to adding it if
someone feels strongly about it though.

> The diff looks good. Feel free to carry:
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul

I see that my patch fails a few test cases because it fails to link
crc-ccitt. Do you know whether this is a problem with my patch or the
test environment and where the code for the tests is found?

Thanks again for your feedback.

Javier

