Return-Path: <linux-kernel+bounces-824109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD59B8824E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D1C3ABD20
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F86E2C08BC;
	Fri, 19 Sep 2025 07:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xJu4s+wo"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F262AD24
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758266654; cv=none; b=ZJFfKjanvjHKChybfU8YvNzWIlr0syHVcvJciH0Cpits/B4U1UI8ukb6sej7x9iBwJqEps/cFOdEX70o7EWWvg2WSnm79kQpHTRT1b3+4jiA9ud0ogqE6PyK2tfAaYDSZA6xKtr23POXr7zeNQmsPGWr5ZEP5t930tH2O/Oglb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758266654; c=relaxed/simple;
	bh=fxZ6sw+WOs4GrG1rHnmaUuy4Gb5tuosew1fSlKu+7iA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZwInDbNkA0nce9a9vB65HC2Wy+vzzRCOGKoab6jopLQiT3gwocg2ZuJtcNrHOK1VqePNmvtNbDfnBXduoIc7IdcTzpvITmcByTOG0pO4LKoFhJ12PnfS93AdnO3AT2Fj4HliaQyPg8CyRgBqnK/sLP6ZmNC1su6/Dt+lQUAFoT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xJu4s+wo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3Z4perxsP8d9vCjAkHxZUXQ59H6PCtwERdPNDJe/SyI=;
	t=1758266653; x=1759476253; b=xJu4s+wo1t+S+Gw9xRfmyv/VJ0eT2eca8ra4N2PMmntWoiu
	lxig2g5S5WqnO+eqY8zVjahulpIVwUXAiuYwPl0ru+I8Vde8zJWprYJyBvUF43BvNE/mx4StFgWbp
	BicxuvTegFVhpk3g96rN/I5/BnIiykcZCmHJd7uKk8iAPGzGnN6d50DpSOQL97hK3NJ0Ou1ATuLQT
	59PqNjJFMEOhxwV43dNhuUh7zyR85qHi5vnIfSRPKI/4vqNlRWzssElJRS4ynwDbadxCl6qMt7wFg
	VXCP5Kl1WU3c7ol8XDT6iuqATgpuyCVcIV4QnoPFHl0oyPBDB6EQp1bfeZnII6VQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uzVTU-0000000FTLC-196i;
	Fri, 19 Sep 2025 09:24:08 +0200
Message-ID: <6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU
 dependency to PCI driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com, 	linux-kernel@vger.kernel.org
Date: Fri, 19 Sep 2025 09:24:07 +0200
In-Reply-To: <m28qib8g1r.wl-thehajime@gmail.com> (sfid-20250919_020320_735898_47C8CCD7)
References: <cover.1758181109.git.thehajime@gmail.com>
		<4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
		<a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
	 <m28qib8g1r.wl-thehajime@gmail.com> (sfid-20250919_020320_735898_47C8CCD7)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-09-19 at 09:03 +0900, Hajime Tazaki wrote:
> > This doesn't make a lot of sense to me. Why would we even want to build
> > PCI on NOMMU-UML if PCI in general is dependent on MMU now?
> >=20
> > It's not like ARCH=3Dum with PCI and NOMMU has any value even for testi=
ng
> > if such a configuration cannot exist in reality?
>=20
> totally understand your point.
>=20
> now I see that we don't have to have this work around by using
> --kconfig_add option to kunit.py.
>=20
> # like --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=3Dn (in addition to
>   --kconfig_add CONFIG_MMU=3Dn).

That's not what I mean. I think it should be made impossible to build
the broken code.

The problem is probably UML_PCI_OVER_VIRTIO selecting UML_PCI selecting
various PCI code, but nothing depends on PCI in the first place. Which
it should, then?

johannes

