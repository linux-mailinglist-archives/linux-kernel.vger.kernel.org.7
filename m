Return-Path: <linux-kernel+bounces-768716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF13B26479
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A53817AA16
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B962F39D8;
	Thu, 14 Aug 2025 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XaOBMk1i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991672F2913
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171567; cv=none; b=lporVgqUJUdQ/HmLdjVVrIKwpKn0g5HN+CFE+CAE29AefNzkp6Cexawe26JQujDrl59EQrlIeOwl87SNRV1PY1JJKLLSCaulZeFW//9cqopXNpmETRDzFKU2e4Pkhh5BNoMYNfvSkR7iCEBB++pQBU5z4wD/eAA4b8jF42JYqxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171567; c=relaxed/simple;
	bh=GQDLy57Y32CXA1avGsT/qnqUi16QicSXlJeiomVegko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDgsSqzPMjRHU1Uc3dCktWukfwknADTTGPzVvCvIyssmv/jSxLQZjUS6yMW+MX9SxK73FyWnvwcefg0yGw+0JgtxUeOhG33E8o8DChTX0LZRtCizHWLctKTyQ24t152vVffOYLi7AuooDCas9D+hc5iI5AtovONnmLDaOH1AklE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XaOBMk1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8E0C4CEED;
	Thu, 14 Aug 2025 11:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755171567;
	bh=GQDLy57Y32CXA1avGsT/qnqUi16QicSXlJeiomVegko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XaOBMk1iLNKWbIxiz1QoW6iZMUQ9B3OUgYX8KdR0YTbfufgdP1ibuPdgd4mF31jNL
	 yoNYN28yWywAIEd1OlGqCKATCLrrpK5D9HnnA0kpkt2A8EBwsA2A6OY7bmQSEe37nd
	 7svBh8KuBQhmv8FakU04AxHGcXWMbOz91A87jnHk=
Date: Thu, 14 Aug 2025 13:39:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wang Wensheng <wangwensheng4@huawei.com>
Cc: rafael@kernel.org, dakr@kernel.org, tglx@linutronix.de,
	saravanak@google.com, robh@kernel.org, broonie@kernel.org,
	linux-kernel@vger.kernel.org, chenjun102@huawei.com
Subject: Re: [PATCH 3/3] irqchip/mbigen: Use fw_devlink_relax_consumers()
 helper
Message-ID: <2025081405-automatic-perkiness-7145@gregkh>
References: <20250814111023.2693-1-wangwensheng4@huawei.com>
 <20250814111023.2693-4-wangwensheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814111023.2693-4-wangwensheng4@huawei.com>

On Thu, Aug 14, 2025 at 07:10:23PM +0800, Wang Wensheng wrote:
> Use this to prevernt the consumer devices of mbigen to be probed too
> later.
> 
> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
> ---
>  drivers/irqchip/irq-mbigen.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> index 6f69f4e5dbac..4e96eb9b6a6a 100644
> --- a/drivers/irqchip/irq-mbigen.c
> +++ b/drivers/irqchip/irq-mbigen.c
> @@ -252,6 +252,8 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
>  
>  		if (!mbigen_create_device_domain(&child->dev, num_pins, mgn_chip))
>  			return -ENOMEM;
> +
> +		fw_devlink_relax_consumers(&child->dev);

Ick, no, individual drivers should not be doing this.  Saravana, any
ideas?

greg k-h

