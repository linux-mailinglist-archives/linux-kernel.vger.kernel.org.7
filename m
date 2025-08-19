Return-Path: <linux-kernel+bounces-775530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E474B2C041
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E135817E641
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F293218CD;
	Tue, 19 Aug 2025 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vyHPvVsN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C031C1527B4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602578; cv=none; b=k6M8vb41Wz4B6ZutExI+WNSTi1HyTeBfu2cHKtJf5V8Y7Hw1PDryVSxCKBW4plHOuGjMy+jPuT02wDxxqVcfaA8yWWGuRHb5joqew42iw8ARvn5KcUIC2A03hS1woxg6aUGSmKbaDYWmrLU8ca1PgDbRbzAqvGEps3ylwbZ6ozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602578; c=relaxed/simple;
	bh=lx9i6RfMrgZPvRQQSqU1GeDKClYxgkVDFORTDq1kJPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hm/fYmnlPqpVBMoEzbffV3QqKsBfA+Vm46ukDabzaEh7HdA2CgVTJgciuewjuFvtUUaE2DCxtD+KmvUBkIsZ+yCP6ksdq1GdiJd9uswQTu5Bkw1AvIAWSJG1FVsXWpmkdqegOGziPRCvMh3GMLNLWCO7rWLYk2VNbl/AvCIcqzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vyHPvVsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF892C4CEF1;
	Tue, 19 Aug 2025 11:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755602578;
	bh=lx9i6RfMrgZPvRQQSqU1GeDKClYxgkVDFORTDq1kJPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vyHPvVsN//mEC01avZBgD78qndXXtI1fpr4EeHGtuNnYfbWr9DDIMeXfM4UcBBC56
	 pcZ0e0xSPe3yb2azlw1hyS3jiEXMIb7/5dwN4DMuA51GyaBPAI5GrzWZlyHAA7chTF
	 tiGH5bP1LtoWWSHEEwqc2pcpmmmiUREjfKlI/pDM=
Date: Tue, 19 Aug 2025 13:22:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] sysfs: attribute_group: allow registration of
 const attribute
Message-ID: <2025081957-refueling-anteater-4720@gregkh>
References: <20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net>
 <20250811-sysfs-const-attr-prep-v3-1-0d973ff46afc@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811-sysfs-const-attr-prep-v3-1-0d973ff46afc@weissschuh.net>

On Mon, Aug 11, 2025 at 11:14:27AM +0200, Thomas Weiﬂschuh wrote:
> To be able to constify instances of struct attribute it has to be
> possible to add them to struct attribute_group.
> The current type of the attrs member however is not compatible with that.
> Introduce a union that allows registration of both const and non-const
> attributes to enable a piecewise transition.
> As both union member types are compatible no logic needs to be adapted.
> 
> Technically it is now possible register a const struct
> attribute and receive it as mutable pointer in the callbacks.
> This is a soundness issue.
> But this same soundness issue already exists today in
> sysfs_create_file().
> Also the struct definition and callback implementation are always
> closely linked and are meant to be moved to const in lockstep.
> 
> Similar to commit 906c508afdca ("sysfs: attribute_group: allow registration of const bin_attribute")
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  include/linux/sysfs.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index f418aae4f1134f8126783d9e8eb575ba4278e927..a47092e837d9eb014894d1f7e49f0fd0f9a2e350 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -105,7 +105,10 @@ struct attribute_group {
>  	size_t			(*bin_size)(struct kobject *,
>  					    const struct bin_attribute *,
>  					    int);
> -	struct attribute	**attrs;
> +	union {
> +		struct attribute	**attrs;
> +		const struct attribute	*const *attrs_new;

I know you will drop the "_new" prefix after a while, but "new" is
relative, and not very descriptive.  How about "_const"?

> +	};
>  	union {
>  		const struct bin_attribute	*const *bin_attrs;
>  		const struct bin_attribute	*const *bin_attrs_new;

There is no bin_attrs_new anymore.  Finally.  sorry about that...

greg k-h

