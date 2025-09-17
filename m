Return-Path: <linux-kernel+bounces-821020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC841B8012E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1B43AE1C3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422F933C753;
	Wed, 17 Sep 2025 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="atlWqzmu"
Received: from smtp116.ord1d.emailsrvr.com (smtp116.ord1d.emailsrvr.com [184.106.54.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67AB1B424F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119806; cv=none; b=jQkshn3G8QHaDzr9ACrtigtrDXYjB+wMNENqsyjwRlqqPO+gqAdO3axQhAlbHsrFk3NmTRgM/hUXp2+g1TSUDMaZJjRi2lGM1Ac4xkwmSKXvP+tkw/6/Pt6sprDXt46RoN5hDut1FACcOVIiJmQdMfog7ULavlbM+1tJE7J7XNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119806; c=relaxed/simple;
	bh=6XJlOdSHt3GNlI8A881kDrPY5wrdxGec00yn5gpXLeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFWB2mFGxdiR6gYOXVTWIuN4zk2NcFYNTMzdjAuPtXDkwWoKhe9UySJ0Oa/tHIfDRLCWosIdFME6j2bk6e8d35DJgDgTCvlUPwfM3haVOeGLGFsTWPEJaabiwMJkZHO/uNeTOLcGTKSTI7vQp/+UAzXMYStYgARNstLyxE7bsgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=atlWqzmu; arc=none smtp.client-ip=184.106.54.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1758116510;
	bh=6XJlOdSHt3GNlI8A881kDrPY5wrdxGec00yn5gpXLeA=;
	h=Date:Subject:To:From:From;
	b=atlWqzmuJpSS2Kr8f147iZ1c66OsYm6c4zRa5o7suyjxZqmMih6jgwYknBza+UyKQ
	 n6UDz9WJU5swCu1I+0pfUcBVcr4bngJo2GgBkhoIFn6XSCXRmuYpFmCAFNoIsEFF9P
	 nAmPNheMxmbfM0SgHbPty+y0D7er8ysxV3ZmiwHU=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp23.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 6132A20194;
	Wed, 17 Sep 2025 09:41:49 -0400 (EDT)
Message-ID: <19be6d8a-e923-49ab-93e4-0996b7d3ddf2@mev.co.uk>
Date: Wed, 17 Sep 2025 14:41:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: Replace kcalloc + copy_from_user with
 memdup_array_user
To: Thorsten Blum <thorsten.blum@linux.dev>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jann Horn
 <jannh@google.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org
References: <20250917131349.117642-2-thorsten.blum@linux.dev>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20250917131349.117642-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 6083aa3f-d9ca-4ffd-9bfe-fb53020c92af-1-1

On 17/09/2025 14:13, Thorsten Blum wrote:
> Replace kcalloc() followed by copy_from_user() with memdup_array_user()
> to improve and simplify comedi_unlocked_ioctl().
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/comedi/comedi_fops.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> index 7e2f2b1a1c36..dea698e509b1 100644
> --- a/drivers/comedi/comedi_fops.c
> +++ b/drivers/comedi/comedi_fops.c
> @@ -2284,15 +2284,10 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
>   		rc = check_insnlist_len(dev, insnlist.n_insns);
>   		if (rc)
>   			break;
> -		insns = kcalloc(insnlist.n_insns, sizeof(*insns), GFP_KERNEL);
> -		if (!insns) {
> -			rc = -ENOMEM;
> -			break;
> -		}
> -		if (copy_from_user(insns, insnlist.insns,
> -				   sizeof(*insns) * insnlist.n_insns)) {
> -			rc = -EFAULT;
> -			kfree(insns);
> +		insns = memdup_array_user(insnlist.insns, insnlist.n_insns,
> +					  sizeof(*insns));
> +		if (IS_ERR(insns)) {
> +			rc = PTR_ERR(insns);
>   			break;
>   		}
>   		rc = do_insnlist_ioctl(dev, insns, insnlist.n_insns, file);

Looks good to me.  Thanks!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

