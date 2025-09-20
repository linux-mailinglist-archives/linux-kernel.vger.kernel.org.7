Return-Path: <linux-kernel+bounces-825886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9F7B8D0B9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C324616DC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0AB29E0E7;
	Sat, 20 Sep 2025 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KK8vn5Fn"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A98F29B8E5;
	Sat, 20 Sep 2025 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758399632; cv=none; b=bYGhpmqVmQCJGM1PtIRpmm6lclua5aBwhB0eR4UYmYTAS+RtcM1uSZeAjoKNysiMk5hbYlAuTDs2vVDSB9qR/H4faQZX5hO+PXdTTi3mXikwjEeM7WOoRRD/JsSffVgEK820F/SNIE1Um3QLvawUq4fAoQrODwNvPzgoKjzbsrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758399632; c=relaxed/simple;
	bh=PrSgpY47sfnficXYN8oj/GmgrBXrsudNXvXWDE5hZYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4r9+dpuhShmMUq2ukzAeQrXAnRUgI82USrBFO1uHHrC8EBxsluCS9QLFfBZUc0ZZSuvqWWIksTxLjqRYcHsvXvw5LRCMO/6ia+Xq2eEf30YgmH8EwPhJKahM+KMv+XOTS1HpWdgUETUlaIYVWHrhogIKdNbEooB5hEczeEUVgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KK8vn5Fn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=/+m3RkTbBF370RPh39k49YAhXk/9orK5dqFtFgNaebA=; b=KK8vn5Fn8nbrgKl+DIWBV389Kc
	yasVuU1NY22WY1UzMh+baXLsn3kCG1WNSel2AvTJPu/TIEdcAUigZl1mGkmZChDdJrRCspO/eFaSo
	zqEVzCYn0ZwqWbArl4HdGJd6egTfb87MhTPNz9+NSdc2dcRxEXt6cOoPGzk0LH1WMsWLPwFJNCt1n
	dR+KS2wDwF9Eq6SdOFwlhUJYbP+1+QOWfW/0d129n9ZBuQGWJWRDHMuo1Rj3glsuVXWaNl7jzoOEJ
	fFDITLDw5q0zUYkXZ+27eWROA/dXj4//kfXCbcH7CjIRSQUQ+ttBLoMcV7wN+hCZ4LyxsYR2XmXn2
	tW/9U56A==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v044J-00000005sNx-390v;
	Sat, 20 Sep 2025 20:20:27 +0000
Message-ID: <982d4494-c91b-4b7f-9e3e-858f5ceed067@infradead.org>
Date: Sat, 20 Sep 2025 13:20:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Associative arrays documentation formatting cleanups
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
 Markus Heiser <markus.heiser@darmarit.de>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Silvio Fricke <silvio.fricke@gmail.com>
References: <20250920024227.19474-2-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250920024227.19474-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/19/25 7:42 PM, Bagas Sanjaya wrote:
> Hi,
> 
> Here's two-patch formatting cleanup series for generic associative array
> implementation docs. The shortlog below should be self-explanatory.
> 
> Enjoy!
> 
> Bagas Sanjaya (2):
>   Documentation: assoc_array: Indent function explanation text
>   Documentation: assoc_array: Format internal tree layout tables
> 
>  Documentation/core-api/assoc_array.rst | 196 +++++++++++++------------
>  1 file changed, 103 insertions(+), 93 deletions(-)
> 
> 
> base-commit: 348011753d99b146c190aae262ee361d03cb0c5e

for both patches:

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy

