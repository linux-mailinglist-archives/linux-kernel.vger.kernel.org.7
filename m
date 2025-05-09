Return-Path: <linux-kernel+bounces-641130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2DCAB0D38
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 10:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435CC9E18D5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 08:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5212741CF;
	Fri,  9 May 2025 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AwTYapvb"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7110522D9EF
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746779817; cv=none; b=PmQa61H1n26Vb3fht7YsY2wnkzfFp/LBujs+RAHJU8Vl/JDooh4WZydaYp/6KUxtatq0tS0wSzcy4c6J2CuvAdnWiO8ekwQxb4Y77Vc4tckpZ6caO+cWUeo9mQQoFT5nMVwMhdg+P/MMHmqMwVZWGFg3HHsIH+0odUr9JWG2uKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746779817; c=relaxed/simple;
	bh=jYQoJcACfY1pkP1CNoxq+CRMf69D5FZadKRYDpnPPJE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YZBUGArlQ1W6F/asICtrJMgCpHL5wt9Jg41OXfRgexIRjiQ61bEg83l5Tq4BppA3MEWTTeC+G47lIMhUSN1T7fyc2brMNB5r5Dyoe1sNyctvbxftt8GPxBtE0AKtCmtcWQ449kYEbGuHHha0KWj2BXaFQGkBb1nXcJHxCWtUjFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=AwTYapvb; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Zv2RR4fPMz9sv3;
	Fri,  9 May 2025 10:36:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1746779811; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYQoJcACfY1pkP1CNoxq+CRMf69D5FZadKRYDpnPPJE=;
	b=AwTYapvbHm/b+X/4Q9PibHhnW/TC2uHpFba10VXlHBivD7eGIlRKCV3AbIWUa3HQqHaqUE
	M2mzrPFl7PEDzqCILSYCa9efFHesk19cFMLBwDD2w4z8DA1BfyO5V/tnfZsKIzLteQ44Gh
	msiI8yLDtcolaWGqPQUqeVGY39+/D9M1ZfNyCIG31s0ueJFRXRtlolM6GuF2ZlBkL1DWn4
	IxNVIeZ5wXZ7xuJmwsOcInbcET/KFQw1yeSZLqmu9oM0+9OpqhJj2bLK6mfjNnL1h4OJBU
	2OVKye4fTfE2gTPmlKTbCEXcANC7QEFaRNKV6kiywM49hOGJ32LKBfHCms136A==
Message-ID: <e7c45c099f8981257866396e01a91df1afcfbf97.camel@mailbox.org>
Subject: Re: [PATCH] drm/cirrus: Use non-hybrid PCI devres API
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Javier Martinez Canillas <javierm@redhat.com>, Philipp Stanner
 <phasta@kernel.org>, Dave Airlie <airlied@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
  Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,  Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Arnd Bergmann
 <arnd@kernel.org>,  Jani Nikula <jani.nikula@intel.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 09 May 2025 10:36:45 +0200
In-Reply-To: <87a57ns7oh.fsf@minerva.mail-host-address-is-not-set>
References: <20250417094009.29297-2-phasta@kernel.org>
	 <87frhzc1a9.fsf@minerva.mail-host-address-is-not-set>
	 <6d46103afab9fc8e843e5681226f7db34a4ca57d.camel@mailbox.org>
	 <87a57ns7oh.fsf@minerva.mail-host-address-is-not-set>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: f4a829c0b291a1defb1
X-MBO-RS-META: 5exj8gn6cgaf58j51wyo13t5h4szd67n

On Thu, 2025-05-08 at 12:44 +0200, Javier Martinez Canillas wrote:
> Philipp Stanner <phasta@mailbox.org> writes:
>=20
> Hello Philipp,
>=20
> > On Tue, 2025-04-22 at 23:51 +0200, Javier Martinez Canillas wrote:
> > > Philipp Stanner <phasta@kernel.org> writes:
> > >=20
> > > Hello Philipp,
> > >=20
> > > > cirrus enables its PCI device with pcim_enable_device(). This,
> > > > implicitly, switches the function pci_request_regions() into
> > > > managed
> > > > mode, where it becomes a devres function.
> > > >=20
> > > > The PCI subsystem wants to remove this hybrid nature from its
> > > > interfaces. To do so, users of the aforementioned combination
> > > > of
> > > > functions must be ported to non-hybrid functions.
> > > >=20
> > > > Replace the call to sometimes-managed pci_request_regions()
> > > > with
> > > > one to
> > > > the always-managed pcim_request_all_regions().
> > > >=20
> > > > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > > > ---
> > >=20
> > > Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> > >=20
> >=20
> > Who's in charge of applying this? Any objections with me just
> > putting
> > it into drm-misc-next?
> >=20
>=20
> Sure, go ahead.

Applied, thx

>=20
> > P.
> >=20
>=20


