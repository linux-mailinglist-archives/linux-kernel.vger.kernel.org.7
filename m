Return-Path: <linux-kernel+bounces-732844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2191BB06CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F0650353D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 04:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A1A26E6E8;
	Wed, 16 Jul 2025 04:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pKBRxnC6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB962222AF
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 04:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752641598; cv=none; b=bqHMf5NcSvB02Funy36hgTyZqZXtRZ20tftLe1q1JXF6uOoeAVgnJWti1ILMFfR8cZFihsDs6P6ZHxcboVkWG1Ii0pLazPqrz6Be91Uk/61Qli4qhz3t4lLj0tVflYwGxUrmFqb9fe4iRZn9EyTgwwB1eNUYcq7neOz89BPqbOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752641598; c=relaxed/simple;
	bh=JnMdmWLnT8Fj80pRzrVlL/1oCGsL+zOTR/QnPkB8liM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXrJ/NgV0ZpJQaxAbYBPvq2GxGq2GjzLxG2ZkNH4aVtBpdjqr1ZMQwYBlwq+O+irErj1IJTYJKkffnjqXtTKDmu49KAIL/dnb6eG1DWO7Sx1cAPylqpoTC6coDIFOH+4MCANCQNduXUdGibyfIYJ7TcIiKVZSJEa2vy58/lVBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pKBRxnC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24696C4CEF0;
	Wed, 16 Jul 2025 04:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752641597;
	bh=JnMdmWLnT8Fj80pRzrVlL/1oCGsL+zOTR/QnPkB8liM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKBRxnC6N35HjPBwF3gd+MkhHN8toezfiXeHDb43QQlZMcjrQ7ImBBAWznMrAiWFk
	 W+uUWwrsytbugSUBKvbBRrEQhJry2px9L8rUqSx9maTGMYeyDTNFbtsAeXHc5j9hP2
	 zaBqiXnHhY64LHyWORxxRmauPOX2xKRfxaSxq/zk=
Date: Wed, 16 Jul 2025 06:53:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Meng Shao Liu <sau525@gmail.com>
Cc: linux-kernel@vger.kernel.org, visitorckw@gmail.com
Subject: Re: [PATCH 2/2] samples/kobject: make attribute_group const
Message-ID: <2025071603-vacant-cable-0696@gregkh>
References: <5be61d284a1850f573658f1c105f0b6062e41332.1752634732.git.sau525@gmail.com>
 <170a918a8e14b1e0c003b6e277cd5813631c2749.1752634732.git.sau525@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <170a918a8e14b1e0c003b6e277cd5813631c2749.1752634732.git.sau525@gmail.com>

On Wed, Jul 16, 2025 at 11:07:34AM +0800, Meng Shao Liu wrote:
> The attr_group structures are allocated once and never modified at
> runtime.  Also to match the const‑qualified parameter of
> sysfs_create_group().
> 
> Signed-off-by: Meng Shao Liu <sau525@gmail.com>
> ---
>  samples/kobject/kobject-example.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/kobject/kobject-example.c b/samples/kobject/kobject-example.c
> index e6d7fc18e..36d87ca0b 100644
> --- a/samples/kobject/kobject-example.c
> +++ b/samples/kobject/kobject-example.c
> @@ -102,7 +102,7 @@ static struct attribute *attrs[] = {
>   * created for the attributes with the directory being the name of the
>   * attribute group.
>   */
> -static struct attribute_group attr_group = {
> +static const struct attribute_group attr_group = {
>  	.attrs = attrs,
>  };
>  
> -- 
> 2.43.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

