Return-Path: <linux-kernel+bounces-795980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C871B3FA49
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A612C02FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE69D2E8DE6;
	Tue,  2 Sep 2025 09:27:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB67246778;
	Tue,  2 Sep 2025 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805239; cv=none; b=WftUMGHI5QsmdBlAnhBmKJE0km0FTVv/idF2QTCAzMEYB8GHSXgsCwso2RipVMV44hzG72VBILsmNLYgdmL2dWD81IVZqBJwhMxP5ftT4TXQX0DcLanPXqbMhFt4wxO1rC1HJyl/1GWkB1mVs9OD0FgHp3339Mt5n6WTpNfiOYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805239; c=relaxed/simple;
	bh=IMmePrNbMJSSeHg6trXEyh/maoVMaV0R0jYCCcsItyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BERtpAuuN78cNsufHPdnPHfpKowzbjKBybGzjAy/+8zjRDwKnjZrT4hYsVIk+UHleYzNIbze5YPpQjC6GTcbSWxVVrjbhuCA5vWSJFO2eB2R2pgX4Bca6g/9RT+2zggL8eN8KJ2WF7EajoQbrXyHqXLtOFcjb1amo3E/JzTRrB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EE5B168F;
	Tue,  2 Sep 2025 02:27:07 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7289F3F694;
	Tue,  2 Sep 2025 02:27:14 -0700 (PDT)
Date: Tue, 2 Sep 2025 10:27:11 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Artem Shimko <artyom.shimko@gmail.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] firmware: arm_scmi: add missing spinlock
 documentation
Message-ID: <20250902-daft-pompous-angelfish-459c6e@sudeepholla>
References: <y>
 <20250901161207.2501078-1-artyom.shimko@gmail.com>
 <20250901161207.2501078-3-artyom.shimko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901161207.2501078-3-artyom.shimko@gmail.com>

On Mon, Sep 01, 2025 at 07:12:04PM +0300, Artem Shimko wrote:
> Adds a missing comment for xfer_lock spinlock in struct scmi_xfers_info.
> The spinlock protects access to the xfer buffers and transfer allocation
> mechanism, preventing race conditions in concurrent access scenarios.
> 
> Signed-off-by: Artem Shimko <artyom.shimko@gmail.com>
> ---
>  drivers/firmware/arm_scmi/driver.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index bd56a877fdfc..6828392152f4 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -76,6 +76,7 @@ static struct dentry *scmi_top_dentry;
>   */
>  struct scmi_xfers_info {
>  	unsigned long *xfer_alloc_table;
> +	/* Protects access to the xfer buffers */

Thanks for your patch but this is quite obvious and I see no point in
just adding this comment.

-- 
Regards,
Sudeep

