Return-Path: <linux-kernel+bounces-775957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70107B2C6D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5573563A19
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74F923909F;
	Tue, 19 Aug 2025 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="MheK5weS"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C13523D29A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612914; cv=none; b=ehAYdxSSnkl45yYPKNV5YjuqOSqxVeO/NSyRu2eyzXAbBYRheOYEjNnhY1JBetfcD23SygMTAcxgkF4o/voN7jQDazAB+/WfNQXC09+IEGKW3kFUkQeKI/9vtXGPtsj1Jfyidf9OsvwIFsh1SoRVqlPTpjt/8GlFE3TX3k4uVwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612914; c=relaxed/simple;
	bh=Ws/VhLDuvp9BwVOHbuZ7PLccW8mfappO32GbDbsanl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0tdqbuAt6L/yU2h8q6zhlkEs/XGjsbhYdOPcXP27Ike0kwwfwcDoA4yFB6vMtUq1V2d+11guIM1jltHTNia0fpjVfOcsc3Cajt4Vx5wirKcTfXd50gxgGOViuCieopPfBWEvPHQKYxY3gA5CtNBekpN9NOTi1i9/3+Ldngoznc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=MheK5weS; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1755612905;
	bh=Ws/VhLDuvp9BwVOHbuZ7PLccW8mfappO32GbDbsanl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MheK5weScHTpxz+WTnqi4y6cQ4kz5ypL/3KPLLEMxD/j8a0cbQugUsG5N+x/sbF2P
	 qNHNbWmyvKjcDhy3+GXFsu01L5N+kHm6BsEpVaroWFLG7XVQ11x6F9OVxfP+lcWipq
	 gRfK3+QPu8Rc5bf0Mua2JwV4l6HSsoMYlshKUHmk=
Date: Tue, 19 Aug 2025 16:15:04 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] sysfs: attribute_group: allow registration of
 const attribute
Message-ID: <39a39901-7b10-4948-bd7c-b4c92551b5b6@t-8ch.de>
References: <20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net>
 <20250811-sysfs-const-attr-prep-v3-1-0d973ff46afc@weissschuh.net>
 <2025081957-refueling-anteater-4720@gregkh>
 <daafd875-d3bc-4df7-a035-5a7dccdaaafb@t-8ch.de>
 <2025081953-canteen-criteria-c604@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025081953-canteen-criteria-c604@gregkh>

On 2025-08-19 16:10:42+0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 19, 2025 at 03:59:04PM +0200, Thomas Weißschuh wrote:
> > On 2025-08-19 13:22:55+0200, Greg Kroah-Hartman wrote:
> > > On Mon, Aug 11, 2025 at 11:14:27AM +0200, Thomas Weißschuh wrote:
> > > > To be able to constify instances of struct attribute it has to be
> > > > possible to add them to struct attribute_group.
> > > > The current type of the attrs member however is not compatible with that.
> > > > Introduce a union that allows registration of both const and non-const
> > > > attributes to enable a piecewise transition.
> > > > As both union member types are compatible no logic needs to be adapted.
> > > > 
> > > > Technically it is now possible register a const struct
> > > > attribute and receive it as mutable pointer in the callbacks.
> > > > This is a soundness issue.
> > > > But this same soundness issue already exists today in
> > > > sysfs_create_file().
> > > > Also the struct definition and callback implementation are always
> > > > closely linked and are meant to be moved to const in lockstep.
> > > > 
> > > > Similar to commit 906c508afdca ("sysfs: attribute_group: allow registration of const bin_attribute")
> > > > 
> > > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > > ---
> > > >  include/linux/sysfs.h | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> > > > index f418aae4f1134f8126783d9e8eb575ba4278e927..a47092e837d9eb014894d1f7e49f0fd0f9a2e350 100644
> > > > --- a/include/linux/sysfs.h
> > > > +++ b/include/linux/sysfs.h
> > > > @@ -105,7 +105,10 @@ struct attribute_group {
> > > >  	size_t			(*bin_size)(struct kobject *,
> > > >  					    const struct bin_attribute *,
> > > >  					    int);
> > > > -	struct attribute	**attrs;
> > > > +	union {
> > > > +		struct attribute	**attrs;
> > > > +		const struct attribute	*const *attrs_new;
> > > 
> > > I know you will drop the "_new" prefix after a while, but "new" is
> > > relative, and not very descriptive.
> > 
> > That is somewhat intentional to express that it is a transitional thing.
> 
> Fair, but given the huge quantity here, it's going to take a long time,
> so "new" is going to be rough to push through for 6+ months.

Looking at how 'struct bin_attribute' went probably quite a bit longer.

> > > How about "_const"?
> > 
> > At some point the regular variant will be const too, so "_const" would
> > be a bit weird.
> 
> Yes, that's when you "switch it back", right?  You would have to do that
> for _new as well.

There will probably be some overlap. But in the end it probably
doesn't matter. Let's go with "_const".

Thomas

