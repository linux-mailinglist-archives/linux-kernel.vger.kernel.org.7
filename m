Return-Path: <linux-kernel+bounces-804064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D46B4696A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 08:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208B2A45B3E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9032C0289;
	Sat,  6 Sep 2025 06:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="a8cK6Jce"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79B221ABD5
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 06:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757140105; cv=none; b=Uzt1wZdSPOt6NQ2bIubpa4Yof6msjPxD51o8P6H2viD7KzaofST2FbyTor1Imn02XkPkYrHxKPd+gBO0kz+yOHVjnHyLnFyuGVwpVScANgZo8UwLaWeme7y7O1N/HCmnPRspMtqldGsMt9KDuJcvovAFFLGCFyHCGw/5E8k8LO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757140105; c=relaxed/simple;
	bh=6yeju41LRBTjYcYvYrUPJAx5rR6fSfSV/7wVhV6FX+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Do2tq4ilPzOKpwQCV/HEvMArnHAIZ5B+itejkuMqiYvf9QIss90rtdvt7v3RPv3T3wCB3D3t2Gbcrg8CRtkhsXV0wgZ4KCti8CbwcB59zJLAsYHrxTMu2GIXQ7kbapEIKPHWjZ916lO9Pxqv6W5uWJ5Zbiwb15WhrRg1QlrsOTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=a8cK6Jce; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=seGORosSvkh1VOib08ZYZZHEfmAEdmOoIa3OMqy1vbA=; b=a8cK6JceVSxmQID+OwTyYUZ05d
	OPWB2RDB1po1k1j4vIlxlzxiMov2Cj7xDudAQgm0R9DniTFjy73+3DbsP298pnZS20UgJLjaJwZNf
	1p91kYa5+W6jw8Yu0B64eCa0K+34rjkmJfoSyvXAB1+9WSegzDhn3WSsBwH1f19Z70HjPOvAM9uMx
	KpGA04zc/K0FtYndWNU59+tF9CLEg5S9QYeW5SE6Asl+XPtwYmq6PCJPxXH4xjD8dC6KGf0o9+tRk
	fO8tbIp9OGvYBYXfPwrE1xiMAiBFEQIzLn96fW6ORRGl2CmNLxr9zSOMU9Z+M/H/e9+ACdOGMHE+L
	kaymDQWg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uumPL-0000000G7eO-2S1X;
	Sat, 06 Sep 2025 06:28:19 +0000
Date: Sat, 6 Sep 2025 07:28:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: Phillip Potter <phil@philpotter.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cdrom: add parentheses around macro arguments
Message-ID: <20250906062819.GU39973@ZenIV>
References: <13378f5c9cafc29425b6e420cad8b513f4a9f1e1.1757095005.git.joeypabalinas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13378f5c9cafc29425b6e420cad8b513f4a9f1e1.1757095005.git.joeypabalinas@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Sep 05, 2025 at 07:59:40AM -1000, Joey Pabalinas wrote:
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
> ---
>  drivers/cdrom/cdrom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 31ba1f8c1f7865dc99..462ee74621da6f32da 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -408,11 +408,11 @@ static int cdrom_get_disc_info(struct cdrom_device_info *cdi,
>   * hack to have the capability flags defined const, while we can still
>   * change it here without gcc complaining at every line.
>   */
>  #define ENSURE(cdo, call, bits)					\
>  do {								\
> -	if (cdo->call == NULL)					\
> +	if ((cdo)->(call) == NULL)				\

You do realize that the right-hand argument of . and -> is *not* an
expression, right?  How would anything other than identifier work, anyway?
Note, BTW, that such identifier would not work as a standalone expression -
its meaning depends upon the structure of union you are dealing with...

General advise, from painful personal experience: before posting a patch,
make sure that you have
	* got enough caffeine in your bloodstream
	* looked through the patch
	* tried to compile the results
The order of the last two may vary, but the first one really needs to go
before anything else.

