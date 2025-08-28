Return-Path: <linux-kernel+bounces-789006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20341B38F92
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC688208A11
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691D2CA6B;
	Thu, 28 Aug 2025 00:04:24 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BE5F513
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 00:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756339464; cv=none; b=Zy/2QdSqCt0jkPYDkWDu+Ruc8reBNIeyx0e7tZEOu9DHTPlV1tCDJ1tow1SaQkHrz1JFfwiFHvq4/WzSFDWxITyLPjqpk+TlyLb8j9iSABWqFVK4zwf+hGUVKfGMzNFXGQKYUhNK2MCOqVGKHrZQ8p8cbpfRr1E6k695DbNtG0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756339464; c=relaxed/simple;
	bh=rHO1ispFcxMAW3C3zy7IHu4bk6d/qTZOWT8fshYSiCY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N7k469HIqS6biyiCcIxSBrMGb7QJ8cC6ATJiKxWxzT3OlUHmUvglx6wWp66/e/136o4RdLZuC83DKET6rYbXkc7Yit7qwCFH5K6F1T7hrni+xUJVWUlmqy7pz/LV8yRNLBzKs215OX4BcbOPPI0po/qUgygOu8779x/cv9d7crM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 23CB7591BA;
	Thu, 28 Aug 2025 00:04:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 3FD3320026;
	Thu, 28 Aug 2025 00:04:19 +0000 (UTC)
Message-ID: <5b914354f29e58097e373dde76ee26b246a64ce6.camel@perches.com>
Subject: Re: [PATCH] powerpc/powernv: Rename pe_level_printk to pe_printk
 and embed KERN_LEVEL in format
From: Joe Perches <joe@perches.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel
 <linux-kernel@vger.kernel.org>
Date: Wed, 27 Aug 2025 17:04:16 -0700
In-Reply-To: <732ae03a-f0a7-450c-8896-e8a4975a5254@csgroup.eu>
References: <df3a7ca31d2002ca447ab062f5b5e32ced9bec85.camel@perches.com>
	 <732ae03a-f0a7-450c-8896-e8a4975a5254@csgroup.eu>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 3FD3320026
X-Stat-Signature: uau5hkr6errx756ojdmfydbea8w4err6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19Ba6ut9WVmmTi9/CJjacHvw6XJzPZwXTI=
X-HE-Tag: 1756339459-982349
X-HE-Meta: U2FsdGVkX18cO46/q+eMU6rG9Rt60S6qUj+EUM63rbXb6VN9Iw7P9AjBQMdGD3MLUsHiamW2QjS/gei4KlRbOJBxbB47tqGF6QB7iMpj8J/jjIXhTcA7UuutXlZIL8AWfKFhR89ZCFa4cS9nHHgFDY8h6xxSBtRyt7n8lJ9RaKLOQqHllfK7YvX6x1GYxkIQ2p2+VjxzZkzgccqwAFKvMfwFGAylFn7uw62w4m9d2orZdIP4MxeB7EU5aTon+SMt9/m9Ac6zKw+/4rNN82ihf2YuQ1nPrQnZ8t1KYh5cDK17cBnE3VTp3+91U9KMKrX0bHIIwusVHOcOtbov+F1MfyCuoTxuh7zwaKprhwA03u+TrspOqmqF7+A1rWgLTbaD

On Wed, 2025-08-27 at 18:42 +0200, Christophe Leroy wrote:
> Hi Joe
>=20
> Le 21/06/2019 =E0 07:36, Joe Perches a =E9crit=A0:
> > Remove the separate KERN_<LEVEL> from each pe_level_printk and
> > instead add the KERN_<LEVEL> to the format.

Hello Christophe.

It's over 6 years since I wrote that.
Is that the typical review time? ;)

I would expect it doesn't apply anyway
though it should make the object size
a tiny bit smaller.

> >=20
> > pfix in pe_level_printk could also be used uninitialized so
> > add a new else and set pfx to the hex value of pe->flags.
> >=20
> > Rename pe_level_printk to pe_printk and update the pe_<level>
> > macros.
> >=20
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >   arch/powerpc/platforms/powernv/pci-ioda.c | 14 ++++++++++++--
> >   arch/powerpc/platforms/powernv/pci.h      | 11 +++++------
> >   2 files changed, 17 insertions(+), 8 deletions(-)
>=20
> I can't see the added value of this patch, it adds more lines than it=20
> removes.
>=20
> Christophe
>=20
> >=20
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/p=
latforms/powernv/pci-ioda.c
> > index 10cc42b9e541..60fc36ae626a 100644
> > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > @@ -50,15 +50,23 @@
> >   static const char * const pnv_phb_names[] =3D { "IODA1", "IODA2", "NP=
U_NVLINK",
> >   					      "NPU_OCAPI" };
> >  =20
> > -void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
> > -			    const char *fmt, ...)
> > +void pe_printk(const struct pnv_ioda_pe *pe, const char *fmt, ...)
> >   {
> >   	struct va_format vaf;
> >   	va_list args;
> >   	char pfix[32];
> > +	char level[PRINTK_MAX_SINGLE_HEADER_LEN + 1] =3D "\0";
> >  =20
> >   	va_start(args, fmt);
> >  =20
> > +	while (printk_get_level(fmt)) {
> > +		size_t size =3D printk_skip_level(fmt) - fmt;
> > +
> > +		memcpy(level, fmt,  size);
> > +		level[size] =3D '\0';
> > +		fmt +=3D size;
> > +	}
> > +
> >   	vaf.fmt =3D fmt;
> >   	vaf.va =3D &args;
> >  =20
> > @@ -74,6 +82,8 @@ void pe_level_printk(const struct pnv_ioda_pe *pe, co=
nst char *level,
> >   			(pe->rid & 0xff00) >> 8,
> >   			PCI_SLOT(pe->rid), PCI_FUNC(pe->rid));
> >   #endif /* CONFIG_PCI_IOV*/
> > +	else
> > +		sprintf(pfix, "(flags: 0x%lx)", pe->flags);
> >  =20
> >   	printk("%spci %s: [PE# %.2x] %pV",
> >   	       level, pfix, pe->pe_number, &vaf);
> > diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platfo=
rms/powernv/pci.h
> > index be26ab3d99e0..870b21f55b3f 100644
> > --- a/arch/powerpc/platforms/powernv/pci.h
> > +++ b/arch/powerpc/platforms/powernv/pci.h
> > @@ -205,15 +205,14 @@ extern unsigned long pnv_pci_ioda2_get_table_size=
(__u32 page_shift,
> >   		__u64 window_size, __u32 levels);
> >   extern int pnv_eeh_post_init(void);
> >  =20
> > -__printf(3, 4)
> > -extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *=
level,
> > -			    const char *fmt, ...);
> > +__printf(2, 3)
> > +extern void pe_printk(const struct pnv_ioda_pe *pe, const char *fmt, .=
..);
> >   #define pe_err(pe, fmt, ...)					\
> > -	pe_level_printk(pe, KERN_ERR, fmt, ##__VA_ARGS__)
> > +	pe_printk(pe, KERN_ERR fmt, ##__VA_ARGS__)
> >   #define pe_warn(pe, fmt, ...)					\
> > -	pe_level_printk(pe, KERN_WARNING, fmt, ##__VA_ARGS__)
> > +	pe_printk(pe, KERN_WARNING fmt, ##__VA_ARGS__)
> >   #define pe_info(pe, fmt, ...)					\
> > -	pe_level_printk(pe, KERN_INFO, fmt, ##__VA_ARGS__)
> > +	pe_printk(pe, KERN_INFO fmt, ##__VA_ARGS__)
> >  =20
> >   /* Nvlink functions */
> >   extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool by=
pass);

