Return-Path: <linux-kernel+bounces-775946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B39BAB2C6AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00067188D731
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CE3221546;
	Tue, 19 Aug 2025 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MjxXMXBu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0FE218AC1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612646; cv=none; b=dxqMa5S1cXNPBylfmq4qdiYeLvDbq+WAw1cG8wGYX8duJ6KfqiucJHaNo4vEXAkh+xGQQYXOUzlVF9ocgQfIyNNHltVPntpaBWsbXTpFOvB1Ws2BdDpSjURHhEuIZumUxK3iFusEZeVN4jlulwDMl7NX8YZmdMZFZOGLYUBvjcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612646; c=relaxed/simple;
	bh=wBVPn+OMARjeL9f7DVZMbZqfYr79qt1G8bJMEP+FFTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mc+u/MWVWJBgz+pRH18oLdzboEQ50MIBuvprB09vDbiPRv89rGjEMlVobP46Y4TinI6g7IjkOQO0fjWE1rPyLr35R1Fi2K72xlXP+gWc1I/WgwtNCJNnlvUfl1OEir3tVaBRjuAs4L6AFnwlELB8gdyEtYB1v3cEIybgpo52SlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MjxXMXBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23305C4CEF1;
	Tue, 19 Aug 2025 14:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755612645;
	bh=wBVPn+OMARjeL9f7DVZMbZqfYr79qt1G8bJMEP+FFTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MjxXMXBuHviUIR9gFQdfgmfTnXZ2NldolnMeXDXHkNJ17WifrEoDGelTzs6lpNKhv
	 lgQAn/GRyZ4gkSRF9Sye7AQkpIGmOeKGWEw4VyMlSYY3nbgqeps4DVt4s7d53UFxkB
	 bFYFGBCBwruYslmzbY2DgfRhRjPUQBVtgZ3TjOpw=
Date: Tue, 19 Aug 2025 16:10:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] sysfs: attribute_group: allow registration of
 const attribute
Message-ID: <2025081953-canteen-criteria-c604@gregkh>
References: <20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net>
 <20250811-sysfs-const-attr-prep-v3-1-0d973ff46afc@weissschuh.net>
 <2025081957-refueling-anteater-4720@gregkh>
 <daafd875-d3bc-4df7-a035-5a7dccdaaafb@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <daafd875-d3bc-4df7-a035-5a7dccdaaafb@t-8ch.de>

On Tue, Aug 19, 2025 at 03:59:04PM +0200, Thomas Weiﬂschuh wrote:
> On 2025-08-19 13:22:55+0200, Greg Kroah-Hartman wrote:
> > On Mon, Aug 11, 2025 at 11:14:27AM +0200, Thomas Weiﬂschuh wrote:
> > > To be able to constify instances of struct attribute it has to be
> > > possible to add them to struct attribute_group.
> > > The current type of the attrs member however is not compatible with that.
> > > Introduce a union that allows registration of both const and non-const
> > > attributes to enable a piecewise transition.
> > > As both union member types are compatible no logic needs to be adapted.
> > > 
> > > Technically it is now possible register a const struct
> > > attribute and receive it as mutable pointer in the callbacks.
> > > This is a soundness issue.
> > > But this same soundness issue already exists today in
> > > sysfs_create_file().
> > > Also the struct definition and callback implementation are always
> > > closely linked and are meant to be moved to const in lockstep.
> > > 
> > > Similar to commit 906c508afdca ("sysfs: attribute_group: allow registration of const bin_attribute")
> > > 
> > > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > > ---
> > >  include/linux/sysfs.h | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> > > index f418aae4f1134f8126783d9e8eb575ba4278e927..a47092e837d9eb014894d1f7e49f0fd0f9a2e350 100644
> > > --- a/include/linux/sysfs.h
> > > +++ b/include/linux/sysfs.h
> > > @@ -105,7 +105,10 @@ struct attribute_group {
> > >  	size_t			(*bin_size)(struct kobject *,
> > >  					    const struct bin_attribute *,
> > >  					    int);
> > > -	struct attribute	**attrs;
> > > +	union {
> > > +		struct attribute	**attrs;
> > > +		const struct attribute	*const *attrs_new;
> > 
> > I know you will drop the "_new" prefix after a while, but "new" is
> > relative, and not very descriptive.
> 
> That is somewhat intentional to express that it is a transitional thing.

Fair, but given the huge quantity here, it's going to take a long time,
so "new" is going to be rough to push through for 6+ months.

> > How about "_const"?
> 
> At some point the regular variant will be const too, so "_const" would
> be a bit weird.

Yes, that's when you "switch it back", right?  You would have to do that
for _new as well.

thanks,

greg k-h

