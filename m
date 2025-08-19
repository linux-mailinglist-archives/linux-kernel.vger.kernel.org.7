Return-Path: <linux-kernel+bounces-775926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B36B2C66C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0675C7BE259
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BDF1F03C5;
	Tue, 19 Aug 2025 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Jk3DQvyF"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409F61798F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612033; cv=none; b=GRsJCBxzdI5fGBGDtl1QCB2fUiVAA0BCJiHessd9AHEpgjPgvRgFVMQAck+imKlj8R+H6m/TFqQsH6yEI5+1H6D0M5y/S7ybssptMTfy/ziS+bLVk77GXFSbP/bc+R6z7Efte1I5IjEh3Ng2xJ2wrHp0cT6Tssx3H4/QU/D7fJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612033; c=relaxed/simple;
	bh=ICYOW+xWFSo7o/nHtrPK6TAi38U951zCNJNXcd69Un0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfmpCmDfJYLmAJEFHIANT9QbFXUTDwvBILe6mKVKJR5reZ66nuPFnQJ11Cm95NsDc9dYMvsRGbV8ZFKpEH5Pz+FCaG3TuZlO5PRFKl2Y0PfqFsVhGBUpnPxzsYOz0KASc10dr6U7/kS6af8OlZa1cG5XQbtZaoNviU+KvEzf1ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Jk3DQvyF; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1755612030;
	bh=ICYOW+xWFSo7o/nHtrPK6TAi38U951zCNJNXcd69Un0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jk3DQvyFw1A0apya5qO0Gd/jsXbhl7Ksxu/fFQ5QOOmj+RdNHKPVLH6RZkE5QJcNk
	 gsIBhx+XAM/z7j78jU56fJXS+LnUiaN43nxVs5uk8A04HF4ueOeN3cvjhRvKzCutOS
	 2HBDiWzT558pHPBIytSibci6nolQGzpISdcn+M20=
Date: Tue, 19 Aug 2025 16:00:29 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] samples/kobject: add is_visible() callback to
 attribute group
Message-ID: <d57603c6-d7cf-4d37-aaaa-6bad477075d6@t-8ch.de>
References: <20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net>
 <20250811-sysfs-const-attr-prep-v3-5-0d973ff46afc@weissschuh.net>
 <2025081931-deprive-overtime-b353@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025081931-deprive-overtime-b353@gregkh>

On 2025-08-19 13:24:04+0200, Greg Kroah-Hartman wrote:
> On Mon, Aug 11, 2025 at 11:14:31AM +0200, Thomas Weißschuh wrote:
> > There was no example for the is_visible() callback so far.
> > 
> > It will also become an example and test for the constification of
> > 'struct attribute' later.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  samples/kobject/kset-example.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/samples/kobject/kset-example.c b/samples/kobject/kset-example.c
> > index 579ce150217c6e613887e32a08206573543b3091..1aac595ed9498b30448485a60d9376cb5b5ea1d3 100644
> > --- a/samples/kobject/kset-example.c
> > +++ b/samples/kobject/kset-example.c
> > @@ -178,7 +178,22 @@ static struct attribute *foo_default_attrs[] = {
> >  	&bar_attribute.attr,
> >  	NULL,	/* need to NULL terminate the list of attributes */
> >  };
> > -ATTRIBUTE_GROUPS(foo_default);
> > +
> > +static umode_t foo_default_attrs_is_visible(struct kobject *kobj,
> > +					    struct attribute *attr,
> > +					    int n)
> > +{
> > +	/* Hide attributes with the same name as the kobject. */
> > +	if (strcmp(kobject_name(kobj), attr->name) == 0)
> > +		return 0;
> > +	return attr->mode;
> > +}
> > +
> > +static const struct attribute_group foo_default_group = {
> > +	.attrs		= foo_default_attrs,
> > +	.is_visible	= foo_default_attrs_is_visible,
> > +};
> > +__ATTRIBUTE_GROUPS(foo_default);
> 
> Wait, why?  Shouldn't ATTRIBUTE_GROUPS() still work here?  No one should
> have to call __ATTRIBUTE_GROUPS() in their code, that's just going to be
> too messy over time.

ATTRIBUTE_GROUPS() can not handle .is_visible().
There are already a few users throughout the tree.

Thomas

