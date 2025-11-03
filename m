Return-Path: <linux-kernel+bounces-882905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E99EC2BD24
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849A5188ACB4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D0B2F2905;
	Mon,  3 Nov 2025 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p1Z3Vxb3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C34228DF07
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173996; cv=none; b=tx5dIBlbfTwXZQVh5y3JsrQWJIyXYgsEietyOVeZUmNOiKmd8bFN+dNleRWZQrWEeZsXLwHBsXWlWikU7uklgbkQRHipPZL8FnMIOfbD9bndSIsUByF/aQflpWUkFgLEFqKautx5ytG1oeVkZePz8YT9j7zB96CE2yWTHL1b8PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173996; c=relaxed/simple;
	bh=1MgeKLRiNDOLajyUxO/fGTeWqc+lJ/9yc5bfpiiVIss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dy665NzKeyvAwzhA+LMyXZglgNb3G/scI9tTEssdKrS93jkQmt3mnO/QqFqWX+pMpNCG9FxOzvceoOYG4S4qPaCtj5FTiU7B22UL9NzaJDvaGyhfwElul2GI6gQ2TceelIgFgs9VN748s3pLLkKCat1mCwmsz80PUYtRvyEPNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p1Z3Vxb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499D0C113D0;
	Mon,  3 Nov 2025 12:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762173995;
	bh=1MgeKLRiNDOLajyUxO/fGTeWqc+lJ/9yc5bfpiiVIss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p1Z3Vxb3pwo8qd3pP2g5F087aPlVZVAYFhRbMdDbUAhT8oIROmm3ZHc7zBzCpslJH
	 u4VQijClxhsdZ2FtTP0kYxXqHb4AJjLoHxBiUSkceuFxhtVa5kO49SO9Hl20Nbxp5J
	 VbQFZcj7sCi103nNiHW4TCWC18XvN8kndkF7+1YA=
Date: Mon, 3 Nov 2025 21:46:32 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: ad525x_dpot: Replace sprintf with sysfs_emit in
 sysfs_show_reg
Message-ID: <2025110333-marbled-viewable-0259@gregkh>
References: <20251103123403.62076-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103123403.62076-2-thorsten.blum@linux.dev>

On Mon, Nov 03, 2025 at 01:34:03PM +0100, Thorsten Blum wrote:
> Replace sprintf() with sysfs_emit() in sysfs_show_reg(). sysfs_emit() is
> preferred for formatting sysfs output as it provides better bounds
> checking.  No functional changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/misc/ad525x_dpot.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/ad525x_dpot.c b/drivers/misc/ad525x_dpot.c
> index 04683b981e54..519f97089a00 100644
> --- a/drivers/misc/ad525x_dpot.c
> +++ b/drivers/misc/ad525x_dpot.c
> @@ -419,7 +419,7 @@ static ssize_t sysfs_show_reg(struct device *dev,
>  	s32 value;
>  
>  	if (reg & DPOT_ADDR_OTP_EN)
> -		return sprintf(buf, "%s\n", str_enabled_disabled(
> +		return sysfs_emit(buf, "%s\n", str_enabled_disabled(
>  			test_bit(DPOT_RDAC_MASK & reg, data->otp_en_mask)));

I did not suggest doing this for existing code at all, it's only needed
for new code, I've said so many times.

sprintf() works just fine here, there's no bug or issue with it.

thanks,

greg k-h

