Return-Path: <linux-kernel+bounces-780393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A1DB30137
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616ECAA42CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B18338F50;
	Thu, 21 Aug 2025 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v0Ea6qhT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28719338F3F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797742; cv=none; b=DgbnCysBWkmDnzvRAggeS2lYnlUr9D6H6YZu3ZXDLw+s8Bgl4C2DnrtFZ+2h9auT3GoxpgfhWxT6tkRaGvrgfbH2hTIcl9ha59HdwAi7Y0Xp4dvAHvYjaLChVOltLBUq9npvFFToU3rw5QhhZQMy888cEc+2YyoHKonQNvaZBdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797742; c=relaxed/simple;
	bh=o3yhU9SSorXlPvrNfEarEDF4CeBrwu0U8cVLlQ9O6H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UU96CAIe9Vpjz6QeaVsd+wACD0SJ+LEj9Kuv35JGfuIJnfm+Ocrg5wlfxgMasHa/JEAo4MN1CZT1s+QCLldW+wQVLEQsJ2owVmfwd5Ow7qYhsWTvOrasIi3J+cdxGVg4QpsfUFc83p0f4Gh8U+FlxjOX8qyqalUoZ3v52GApaAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v0Ea6qhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313D2C4CEEB;
	Thu, 21 Aug 2025 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755797741;
	bh=o3yhU9SSorXlPvrNfEarEDF4CeBrwu0U8cVLlQ9O6H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v0Ea6qhTEMc9wwTIUsudOzcHUahyKjphFIrInrAlS9K5MSUKq/Y4f2PR4IHvwA+4o
	 LnZeg2Ox1gHjAF1V65k1ZE5PEtzabkRjFaAV7hzMoSrNq8TO/eAEY4S/5UGnN37dbH
	 uNhZsSB6Q4pjEtrDCx9Sl/SnxhAyF5SLnI+qN+jE=
Date: Thu, 21 Aug 2025 19:35:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
	safety-architecture@lists.elisa.tech
Subject: Re: [RFC PATCH] /dev/mem: Add initial documentation of memory_open()
 and mem_fops
Message-ID: <2025082126-sulfite-unwired-c58c@gregkh>
References: <20250821170419.70668-1-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821170419.70668-1-gpaoloni@redhat.com>

On Thu, Aug 21, 2025 at 07:04:19PM +0200, Gabriele Paoloni wrote:
> This patch proposes initial kernel-doc documentation for memory_open()
> and most of the functions in the mem_fops structure.
> The format used for the **Description** intends to define testable
> function's expectations and Assumptions of Use to be met by the
> user of the function.
> 
> Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
> ---
> I have a couple of comments from this documentation activity:
> 1) Shouldn't the check in read_mem() <<if (p != *ppos)>> return
>    -EFBIG (as done in write_mem())?

I think that check implies you don't want to read any more memory,
right?  Try changing it and see what happens :)

> 2) There is a note in memory_lseek() that states the return value
>    to be (0) for negative addresses, however I cannot see how that
>    would happen in the current implementation...

How that you could have a negative address, or how you would return 0?

Also, you should cc: the mm developers, they touch this file all the
time and know it quite well (recent changes to /dev/zero just got added
in the past few days from them.)

thanks,

greg k-h

