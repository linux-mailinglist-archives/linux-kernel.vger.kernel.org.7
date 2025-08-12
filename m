Return-Path: <linux-kernel+bounces-765125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEECB22BCA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CDB1A27070
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A915D2ED15D;
	Tue, 12 Aug 2025 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w23n4vbn"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3021C10E3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012922; cv=none; b=AyMbrVj+SCL/Vb6IYgWfMpVbC+uxTOV297ZZlmuzBvCppqvwigk4+LO8MwEl/DYYUjE4cbiabeVv9cj6PXiBiz6comeYJmo1YguQSHCMh/dDYC6qJU1hQg5zIZ9nKEdPapZSTZ76oqmVqNaRkk7w9veVWIG49GkzpaHYdBFwQDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012922; c=relaxed/simple;
	bh=hcjs8f2z7+j5KChgRblz6x7gCObUXG821KJCp6xq1z4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ofCg7Aj/zVI0pPPXxa3O1FSULVcWVDSiIL22hJFvU3QkNqePx4IFOUvFny07JXkPrMVkZyhx0U7PmUq/lnku0i6LeiL7g7xMGNj+5AJR4XZd06Ten76cHLxPC32ZnS3JPe6GXWQ0SLpzH49/ThPIZ/AwdDTf0IMHEfFepioAu1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w23n4vbn; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755012917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aya3bRU+icAPQwE00jEQeuvWM/SX27N9+2NIUaDgzuA=;
	b=w23n4vbnCd+gz6ruLa6vsUJzSKHck9W6PrZ4beSopJXiwTnfh8uulxXTwUW/oDV+YqnvVT
	bojn75nALyIJ+/CXo2sclv1k6odmjN2MRn98RD487EZVQgfErMWsc/owA3eCrYl9X7Dqwt
	B3OZ/iSXA+bqNZANWWvGfj7IHeMAp9Y=
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
In-Reply-To: <2025081249-guru-uptight-98bf@gregkh>
Date: Tue, 12 Aug 2025 17:35:04 +0200
Cc: Alan Stern <stern@rowland.harvard.edu>,
 linux-usb@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <41785047-0F4C-4998-8B49-C8D52AB3E5A7@linux.dev>
References: <20250812144358.122154-1-thorsten.blum@linux.dev>
 <2025081249-guru-uptight-98bf@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

Hi Greg,

On 12. Aug 2025, at 17:00, Greg Kroah-Hartman wrote:
> On Tue, Aug 12, 2025 at 04:43:58PM +0200, Thorsten Blum wrote:
>> Change the function parameter 'buf_len' from 'int' to 'unsigned int' and
>> only update the local variable 'residue' if needed.
> 
> But why?

The parameter 'buf_len' is never negative, so using 'unsigned int' is
semantically better. Since both 'buf_len' and 'residue' are now unsigned
integers, we can directly compare them without the additional
'if (residue)' check.

Unnecessarily reassigning 'residue' to itself has also been removed.

> Update the rts51x_read_status() function signature accordingly.
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>> drivers/usb/storage/realtek_cr.c | 9 +++++----
>> 1 file changed, 5 insertions(+), 4 deletions(-)
> 
> Have you tested this change?  What caused this to be needed?

I've only compile-tested it due to lack of hardware.

I came across this because Coccinelle/coccicheck suggested using min()
instead of the ternary operator, but I realized it could be simplified
in a cleaner way.

Thanks,
Thorsten


