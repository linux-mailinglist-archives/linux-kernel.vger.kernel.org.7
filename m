Return-Path: <linux-kernel+bounces-813718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E49CBB549E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58F11CC0AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0603D2EC0A1;
	Fri, 12 Sep 2025 10:31:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF822EC097;
	Fri, 12 Sep 2025 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673101; cv=none; b=hfmG8y6XRSNOXxNm5k7UBIdiuoemjewCl6ibs7Td0clVf34Tpr5tNyvh913f+Y5yCVah2tp+5eQ4lG2SO5J+rDJUKKvv2BUr3cMAX0pDFKpnaxitBlAZQZ/ir6ICTJO30W/dmMhBRYvm7JM40BOYPUU1pyxEea1KXskxXxGV7Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673101; c=relaxed/simple;
	bh=XZOmmnTzV/tCeT4NypbEAW/KZ7NsBshSl1ifwWF35Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jThOaX5/1ZrEEdz4iMgjPRNclRlCVcXZiN5s0Or8KFiXWZ8k5gDIygBWfAbPqGlg8gP5QT5VVEOuoFB+hZ16wK8l4XRN4mmWt5oAmtbP0a9PS83v/KLuqGwWFzYc/i8zJL6gesW/R/18Ro9iYotu4msiXsSkn/ODw5NJO+gWGrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DEE516A3;
	Fri, 12 Sep 2025 03:31:30 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CDAE3F66E;
	Fri, 12 Sep 2025 03:31:37 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:31:34 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: Simplify printks with pOF format
Message-ID: <20250912-axiomatic-pumpkin-teal-9c9fbc@sudeepholla>
References: <20250912092423.162497-2-krzysztof.kozlowski@linaro.org>
 <c5df4196-b951-4f8e-b2ca-c63fba63d1ee@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5df4196-b951-4f8e-b2ca-c63fba63d1ee@linaro.org>

On Fri, Sep 12, 2025 at 11:34:53AM +0200, Krzysztof Kozlowski wrote:
> On 12/09/2025 11:24, Krzysztof Kozlowski wrote:
> > Print full device node name with %pOF format, so the code will be a bit
> > simpler.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  drivers/firmware/arm_scmi/bus.c                | 13 ++++++-------
> >  drivers/firmware/arm_scmi/transports/mailbox.c |  7 +++----
> >  2 files changed, 9 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
> > index 24e59ddf85e7..c7698cfaa4e8 100644
> > --- a/drivers/firmware/arm_scmi/bus.c
> > +++ b/drivers/firmware/arm_scmi/bus.c
> > @@ -401,8 +401,8 @@ static void scmi_device_release(struct device *dev)
> >  
> >  static void __scmi_device_destroy(struct scmi_device *scmi_dev)
> >  {
> > -	pr_debug("(%s) Destroying SCMI device '%s' for protocol 0x%x (%s)\n",
> > -		 of_node_full_name(scmi_dev->dev.parent->of_node),
> > +	pr_debug("(%pOF) Destroying SCMI device '%s' for protocol 0x%x (%s)\n",
> > +		 scmi_dev->dev.parent->of_node,
> >  		 dev_name(&scmi_dev->dev), scmi_dev->protocol_id,
> >  		 scmi_dev->name);
> 
> Heh, I misread the docs and see now in the testing that my patch changes
> the behavior. of_node_full_name() is just node name. pOF is full path.
> 
> This might be desired or not...
> 

That should be fine. I am in the process of changing this but happy to
take this for now. We may have to move to fwnode as we are in process of
adding ACPI support for this. Not finalised yet so it may be a while before
I tinker with it again.

-- 
Regards,
Sudeep

