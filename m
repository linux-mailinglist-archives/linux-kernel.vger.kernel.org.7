Return-Path: <linux-kernel+bounces-779092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5466B2EF01
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B28956165C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701612E8B75;
	Thu, 21 Aug 2025 07:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yE6lWCfO"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA08B24336D;
	Thu, 21 Aug 2025 07:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759701; cv=none; b=Wvd3VWDiYz1E9ZVSkjgPMMz1PZjxPlXLtgHUdf2DX+utsSR5sdr4HOlJFmE08SmgZjLq8VmDnusHJeQjJRhNy19hga/G75B6kMKjxKN1AwxfpNVmDxWtWqjww0eliQSnfx524YLJF04+zWHuSB3lG+4asyaHAJbAh0vp8RIr6UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759701; c=relaxed/simple;
	bh=9mgn0g08IWjAFNfAgqxShZTHc59LDenB3q0KmCWzCCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqV8wQrhP638wtJwKueIWkCtrMxksdcQmMt58KlkYzAWXJ2vzOqrVKhsYYWf5Zj5SBj2ktL669KdcD4eSUaCNcA/kTs1/yyk81zZDRz86XdgSkX9srpgfqeXSLEiVN4X8lB4EMjIk4gIqZNUldvgSNqkhHc21Ofcm0Kmv6EmsuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yE6lWCfO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=IBLG9GGMB1THBlFX7bW9gweffzcBL/w89urM794NbgU=; b=yE6lWCfOFItsmhWsral6yyHX/I
	54DXUyCnN5GwS7NuqshyUFth9w6zJwXsR6rsBivqXN/965TuLWV2q16TLMBrrfId3NBuCbXYrt8x1
	yTQVIIP9NotKbY7ypJ7e4MrIbHQwDMDOQRyqfHbgLFSLuDgKNis3DdwQ+eELx8Fw0PxZTAaFCoR5q
	rWALXvkDiqBWCjYl3pu7OvgcEkN3vQcqfi5XwE/ouQZmbmZH257vHej9PEJTdtbiKUm4/Qvd2Ry9O
	BTwSlaP3d/P3tKNrncM6NynGcYsJrbcO/cXpK9+w8C49p+K27UpUMP6itJRdf7m2l6Arq7jxwBriN
	VRa5l1Yw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uozIm-0000000G2lS-2FHM;
	Thu, 21 Aug 2025 07:01:36 +0000
Message-ID: <08e2b6fa-b80e-49ce-b65c-d08f40f13e07@infradead.org>
Date: Thu, 21 Aug 2025 00:01:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix awkward phrasing in reporting-issues docs
To: Abhishek Jadhav <abhijadhav.dev@gmail.com>, skhan@linuxfoundation.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250821065635.336305-1-abhijadhav.dev@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250821065635.336305-1-abhijadhav.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/20/25 11:56 PM, Abhishek Jadhav wrote:
> Signed-off-by: Abhishek Jadhav <abhijadhav.dev@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/admin-guide/reporting-issues.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
> index 9a847506f6ec..8de0acb37d94 100644
> --- a/Documentation/admin-guide/reporting-issues.rst
> +++ b/Documentation/admin-guide/reporting-issues.rst
> @@ -471,8 +471,8 @@ before proceeding.
>  
>  Note, you might not be aware that your system is using one of these solutions:
>  they often get set up silently when you install Nvidia's proprietary graphics
> -driver, VirtualBox, or other software that requires a some support from a
> -module not part of the Linux kernel. That why your might need to uninstall the
> +driver, VirtualBox, or other software that requires some support from a
> +module not part of the Linux kernel. That's why you might need to uninstall the
>  packages with such software to get rid of any 3rd party kernel module.
>  
>  

-- 
~Randy

