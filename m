Return-Path: <linux-kernel+bounces-731424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6263B0540C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40FBE1787B3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7878227381A;
	Tue, 15 Jul 2025 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AT1dOuif"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE6372615;
	Tue, 15 Jul 2025 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752566733; cv=none; b=LzVL4BkNIzFPFpXESXZaSxa0JuiTx1ikI1GuZRFzmV1LG5d/XA58Pm2OCj8Moo1Xu5pngagJWUSUNQJKPmlm9Y9xAt8lemVXnhx9kT0TdyXVd3uCyn/0aoakn2VxSytBvLDcu1DFNgjPpXJ9ckZTc4QfC+2fWY3nDc/IKbOEPQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752566733; c=relaxed/simple;
	bh=KuLjHZFy6jp55nnqajTexY8+wReRQgnYu1xerCHVT3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdZEsSgdbhFeZTONG7wIz3MVpxKB8bTr57Rx/yZKIwzENCvxFUg/u6mwjsI/cltM1sRjmccoKnrLM7RqNIx20XYXl2Wi95rfkQgEJNaHQvfmHHEA0rCXGWDr4ZjH+UM0yUpYF2g4botePIQYQR1Smv17QrZl/1rUst/UOjt5qCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AT1dOuif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD68EC4CEE3;
	Tue, 15 Jul 2025 08:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752566733;
	bh=KuLjHZFy6jp55nnqajTexY8+wReRQgnYu1xerCHVT3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AT1dOuifk4hg+z8o7oX3gqmo0arWBWuUb4bAYCNSsO2LF+A508K6Kpo5r99YW7fX4
	 8d3BX4yqrJoGXEu+o+Nc5605ZnvlbVih6l0M7vrDejBtBL4363s5FoXAj1HNEZxdid
	 mQ7zVLUmtVg1wrLgytcZZE+5xLThoJ191ojcck9o=
Date: Tue, 15 Jul 2025 10:05:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rui Miguel Silva <rmfrfs@gmail.com>
Cc: Akhil Varkey <akhilvarkey@disroot.org>, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	johan@kernel.org, elder@kernel.org, ~lkcamp/patches@lists.sr.ht,
	koike@igalia.com
Subject: Re: [PATCH] staging: greybus: power_supply fix alignment
Message-ID: <2025071540-sepia-amuck-c757@gregkh>
References: <20250714135606.41671-1-akhilvarkey@disroot.org>
 <DBBXCAEMM5ZO.GTKVMMR2XDJ7@linaro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBBXCAEMM5ZO.GTKVMMR2XDJ7@linaro.com>

On Mon, Jul 14, 2025 at 05:38:31PM +0100, Rui Miguel Silva wrote:
> Hey Akhil,
> Thanks for your patch.
> 
> All looks good with the exception of a small nit...
> 
> On Mon Jul 14, 2025 at 2:56 PM WEST, Akhil Varkey wrote:
> 
> > Fix checkpatch check "CHECK:Alignment should match open parenthesis"
> >
> > Signed-off-by: Akhil Varkey <akhilvarkey@disroot.org>
> > ---
> >
> > Hello, This is my first patch, I appreciate any feedbacks. Thanks!!
> 
> Welcome, and continue...
> 
> > ---
> >  drivers/staging/greybus/power_supply.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/staging/greybus/power_supply.c b/drivers/staging/greybus/power_supply.c
> > index 2ef46822f676..a484c0ca058d 100644
> > --- a/drivers/staging/greybus/power_supply.c
> > +++ b/drivers/staging/greybus/power_supply.c
> > @@ -324,7 +324,7 @@ static struct gb_power_supply_prop *get_psy_prop(struct gb_power_supply *gbpsy,
> >  }
> >  
> >  static int is_psy_prop_writeable(struct gb_power_supply *gbpsy,
> > -				     enum power_supply_property psp)
> > +				 enum power_supply_property psp)
> >  {
> >  	struct gb_power_supply_prop *prop;
> >  
> > @@ -493,7 +493,7 @@ static int gb_power_supply_description_get(struct gb_power_supply *gbpsy)
> >  	if (!gbpsy->model_name)
> >  		return -ENOMEM;
> >  	gbpsy->serial_number = kstrndup(resp.serial_number, PROP_MAX,
> > -				       GFP_KERNEL);
> > +					GFP_KERNEL);
> >  	if (!gbpsy->serial_number)
> >  		return -ENOMEM;
> >  
> > @@ -546,7 +546,7 @@ static int gb_power_supply_prop_descriptors_get(struct gb_power_supply *gbpsy)
> >  	}
> >  
> >  	gbpsy->props = kcalloc(gbpsy->properties_count, sizeof(*gbpsy->props),
> > -			      GFP_KERNEL);
> > +			       GFP_KERNEL);
> >  	if (!gbpsy->props) {
> >  		ret = -ENOMEM;
> >  		goto out_put_operation;
> > @@ -634,8 +634,8 @@ static int __gb_power_supply_property_get(struct gb_power_supply *gbpsy,
> >  }
> >  
> >  static int __gb_power_supply_property_strval_get(struct gb_power_supply *gbpsy,
> > -						enum power_supply_property psp,
> > -						union power_supply_propval *val)
> > +						 enum power_supply_property psp,
> > +						 union power_supply_propval *val)
> 
> Here you fix the alignment, but the last line goes over column 81, even
> though 80 is not really one hard requirement anymore, all code
> (strings is ok to go over to be easier to grep for messages) is on that
> register.
> 
> So, to be coherent, if you could please send a V2 without this specific change
> would be great, Or even better, if you could get rid of all the _ and __
> prefixes in functions names that would be great, and will give more
> space for function paramethers.
> Your call.

Nah, this is fine as-is, we can go over the limit to 100 for tiny stuff
like this.

And the __ prefixes should be there to show no locking, or "internal"
functions, right?  So changing the name needs to happen very carefully.

thanks,

greg k-h

