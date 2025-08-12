Return-Path: <linux-kernel+bounces-765607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A999B23AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 23:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412EB17A4A9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C042D73BC;
	Tue, 12 Aug 2025 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U4qIh+hJ"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D642D738D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034164; cv=none; b=oNLwoa5fyXFY/evFK4rbde/qTVXmyqZz6YrwoVidi1oBSgYBZdxEFGgY5vYI/BGj281Gc5m3pGRCGL+zZQYkp2PsYVg/EDUsGNMTNmwFBhuuH1vbVsFzo9+Phg49aQGiWyFszO+29pu1Fo0q9kIdAak/I+1xQlFI60DrHhBk/Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034164; c=relaxed/simple;
	bh=9AcDle46sSZ5GtNBAJiYb8IsxvgNROGM8+Rr9YfobSw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=p6TmCFpXTGvykj70LXPsiqixE9gSRmFOssxiIt00DsiqcSHzb7n06HtPPEXcqcpd5WwC9aMCI40FXslNiDGEDAYTxAY6/MDQYI30pMfX726+67+AnCIfKkDxxYxSxoraxjye5SKP92xD+2698Ll2+UMdFI1+LjXgN+2rleeOns4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U4qIh+hJ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755034149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9A88w6834VrTqKLEi9WR7kJwaYhdtTvTEQR33TkiE8=;
	b=U4qIh+hJRzaEk2bbxTNZgXDuMyG3cck7f9g2MeniiFZEx2iTdWC7ZhfBouiG9/cjE3CjQA
	nfxIsEsY7C8l0+nu8LFs7R8oW5jsY1jO1bd3ClBBJXdF7N3uO5qeNsv2k0EYb2mSxRHrrj
	58OMTboK0qdbiNzJt28vcImnQsI9h18=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] usb: storage: realtek_cr: Simplify
 rts51x_bulk_transport()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <b11a19b6-9fb3-4fdc-b94e-33ff01a634b3@rowland.harvard.edu>
Date: Tue, 12 Aug 2025 23:28:56 +0200
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <19E72C72-AFD3-4D13-8F14-9A1F96B971D3@linux.dev>
References: <20250812144358.122154-1-thorsten.blum@linux.dev>
 <b11a19b6-9fb3-4fdc-b94e-33ff01a634b3@rowland.harvard.edu>
To: Alan Stern <stern@rowland.harvard.edu>
X-Migadu-Flow: FLOW_OUT

Hi Alan,

On 12. Aug 2025, at 22:06, Alan Stern wrote:
> On Tue, Aug 12, 2025 at 04:43:58PM +0200, Thorsten Blum wrote:
>> Change the function parameter 'buf_len' from 'int' to 'unsigned int' and
>> only update the local variable 'residue' if needed.
>> 
>> Update the rts51x_read_status() function signature accordingly.
> 
> That last part isn't really necessary, is it?  It doesn't make the code 
> any clearer, less buggy, or quicker to execute.

It's mostly for consistency because the parameter 'len' is used to call
rts51x_bulk_transport() which now expects an unsigned integer. I'd still
argue that it makes the code and the function signature a bit clearer
because now the type communicates that 'len' cannot be negative.

>> 	- if (residue)
>> 		- residue = residue < buf_len ? residue : buf_len;
>> 	+ if (residue > buf_len)
>> 		+ residue = buf_len;
> 
> This really has nothing at all to do with whether buf_len is a signed 
> quantity -- it should never be negative.  (And I have no idea why the 
> original code includes that test for residue being nonzero.)

I agree with "it should never be negative" and ideally the type should
reflect this if possible.

It's also easier to reason about the code when comparing two unsigned
integers than having to think about implicit type conversion.

> Much more serious is something you didn't change: Just above these lines 
> it says:
> 
> 	residue = bcs->Residue;
> 
> It should say:
> 
> 	residue = le32_to_cpu(bcs->Residue);

That should probably be another patch, no?

Thanks,
Thorsten


