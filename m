Return-Path: <linux-kernel+bounces-865521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C91EBFD629
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2068756327A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B653B3446B0;
	Wed, 22 Oct 2025 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="mA7fH5eK"
Received: from sg-1-17.ptr.blmpb.com (sg-1-17.ptr.blmpb.com [118.26.132.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D0432B9A2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150570; cv=none; b=LVcT/wARKt6HVgbYzohblqSKjcbtAnr14sNvqaBeotG4Nm++JwCNA61VhU151z8QwgRMyjuHRFrwcdlXeu+70f6a+XbnTEnI3QgK9hI6TQGo5Ch4e7uyp++qq8fy4brzn080c6WNK1NuSiklxddbpJeIVKtjFjjvBuo2i8q3thU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150570; c=relaxed/simple;
	bh=naLCPT8QruCSsbO4C1gsw20tFuE+6Ghf/ppz3Oxv5E8=;
	h=In-Reply-To:Content-Type:Date:Subject:Mime-Version:References:To:
	 From:Content-Disposition:Cc:Message-Id; b=cRDIqNQ6Y9WBoKjn84jddIjk7heFBPI5NGnfJLtQ97NPg1NYvBX3NoX76zOiUCCIbqMdxkc9RbtcQpI/7WlvTIdFfQ6Z1x4ObVwbZB88xO/C9982GnzH5M4nVhqFnxDrPrKlRhIiAQD28B93or3O3H5HbRXXnQGYxzhQyDOAdHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=mA7fH5eK; arc=none smtp.client-ip=118.26.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1761150555;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=8uejkmSekgy5VFSaXpL18QWdgvHhehs+yN8EUrm6rvI=;
 b=mA7fH5eKUcmj6cxce7+R+1WVjXu6NpBKYKkjrDPvG7BK8Asjwt9TTGsm02ezcActGQCBZE
 3eY2MsC5jSxCm2YEsBNAGmlZoL/lU2/t+Em0StNWsQS0IwkUhM969Z7seDslpYEJd4sJ5z
 2hoGk7FP4kOuzySUs9vcN7jxIB8QiZ5UZMMlTCCKAYXekrrhnrpWY3+Y84unznysGNKb1J
 jhx75KCW+HUIQ9LiimyBfw7YWKVWIRgpqNEEygkVTy7j/hCtsZsIG0h8SVYnwftEkZyyeQ
 oHYYZ++xmVEv1sTwYnFq4PkV0wGbUrwoDhejlhCAGFLYHQ8PdJZMWipgVckmMw==
In-Reply-To: <66608f30-f1b8-4b0f-bd3e-6e039c328873@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Oct 2025 00:29:11 +0800
Subject: Re: [PATCH v1] bcache: Use vmalloc_array() to improve code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Coly Li <colyli@fnnas.com>
References: <20251017111306.239064-1-tanze@kylinos.cn> <bb26wdvihppk6wjpy3ysijfxaj6kofw7zbich4b72bwwnl7fec@cpkvrdhpkj3e> <66608f30-f1b8-4b0f-bd3e-6e039c328873@kylinos.cn>
To: "tanze" <tanze@kylinos.cn>
From: "Coly Li" <colyli@fnnas.com>
X-Lms-Return-Path: <lba+268f90659+f42d8e+vger.kernel.org+colyli@fnnas.com>
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Cc: <kent.overstreet@linux.dev>, <john.g.garry@oracle.com>, 
	<linux-kernel@vger.kernel.org>, <linux-bcache@vger.kernel.org>
Received: from studio.lan ([120.245.65.31]) by smtp.feishu.cn with ESMTPS; Thu, 23 Oct 2025 00:29:12 +0800
Message-Id: <tw4rtosj3jcu73u4eggg7ygh2fstsg5xr774ep2gr2lsnac4md@szuihm2uoafh>

On Wed, Oct 22, 2025 at 10:24:36PM +0800, tanze wrote:
>=20
> =E5=9C=A8 2025/10/22 20:03, Coly Li =E5=86=99=E9=81=93:
> > On Fri, Oct 17, 2025 at 07:13:06PM +0800, tanze wrote:
> > > Remove array_size() calls and replace vmalloc(), Due to vmalloc_array=
() is optimized better,
> > > uses fewer instructions, and handles overflow more concisely[1].
> > >=20
> > > Signed-off-by: tanze<tanze@kylinos.cn>
> > > ---
> > >   drivers/md/bcache/sysfs.c | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
> > > index 826b14cae4e5..dc568e8eb6eb 100644
> > > --- a/drivers/md/bcache/sysfs.c
> > > +++ b/drivers/md/bcache/sysfs.c
> > > @@ -1061,8 +1061,7 @@ SHOW(__bch_cache)
> > >   		uint16_t q[31], *p, *cached;
> > >   		ssize_t ret;
> > > -		cached =3D p =3D vmalloc(array_size(sizeof(uint16_t),
> > > -						ca->sb.nbuckets));
> > > +		cached =3D p =3D vmalloc_array(ca->sb.nbuckets,sizeof(uint16_t));
> >                                                            ^^^-> a blan=
k missing?
> Thank you for your correction. If you need me to revise these description=
s,
> I will send the version 2 (v2) patch later

Yes, version 2 will be fine.

> > >   		if (!p)
> > >   			return -ENOMEM;
> > Except for the missing blank, overall the patch is fine.
> >=20
> > BTW, IMHO tanze is not a formal method to spell the name, could you ple=
ase
> > use a formal format? It will be helpful to identify your contribution i=
n
> > future.
>=20
> Hi , Coly Li.
> Thank you for your reply. First of all, I am Chinese. I often use this na=
me
> as
> my signature on many occasions, and I also used this name for the code
> submitted
> to the upstream party before.

Okey, then ignore my noise.

Thanks.

Coly Li

