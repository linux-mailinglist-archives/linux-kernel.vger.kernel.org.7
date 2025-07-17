Return-Path: <linux-kernel+bounces-734411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D097B08145
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 02:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0261895DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 00:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D734423CB;
	Thu, 17 Jul 2025 00:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u6/ihc39"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011B6BE46
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 00:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752710716; cv=none; b=pk6wnHTl+QfVtIrZkwQMDNW+UCJOtuzpvUdMQXI8klMTiw/5gvys8YYj9Ow8u1NDMKdYcz5mbAwWve2O9coI2EGh76/LvAZ/NIKf2cLOZmPH+i0/NP74ayOMgABZ3fTlfZ0/E/aTf5chx9fP735ILLg5+yIVpE8ZiuxZLS5///Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752710716; c=relaxed/simple;
	bh=XrI11OlKqo0GkcT2iRh9J4cAMdxAm0O0OQCxALpyLVI=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=nSLJ/VCT9gmZY/ixenyrvJB0Pp7gtz8m3HPOPBTEaiX0Ft2lS0bTRGEBjuxqkZx6ZopxRLuGF6haf48tXYGccT0AdT0JmtFWfY5Q5y7j6jZrxtd872QMcGJaiYF6LXvAZn/OY3mqQIOZi4F3Hm3m6MLt6wvJLzg3wIbkxc8FfUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u6/ihc39; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752710700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3LeNNXWYtT9+vzmGvN+VVuby8HV4u2TAQmNVg+niNk=;
	b=u6/ihc39xZlsUfUvt4uOD4TdtHlmBg6TWearERWsq+0mr5qbWySV8F+T7V6UySwkiNryls
	a0Gqb5DSGugrVXX/Jj5egO3r4zu6y7p85cf730fLLJLWtv4xlQN+QzDDQXmXPgCdU9495E
	BtgHk/BJUaMsJFjKpUK/+74YbDwd+ps=
Date: Thu, 17 Jul 2025 00:04:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: qiang.zhang@linux.dev
Message-ID: <62666ecc6ac9c5217cf5e376424e512a511791fe@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] net: usb: Make init_satus() return -ENOMEM if alloc
 failed
To: "Simon Horman" <horms@kernel.org>
Cc: oneukum@suse.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250716091839.GM721198@horms.kernel.org>
References: <20250716001524.168110-1-qiang.zhang@linux.dev>
 <20250716091839.GM721198@horms.kernel.org>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Wed, Jul 16, 2025 at 08:15:23AM +0800, Zqiang wrote:
>=20
>=20>=20
>=20> This commit make init_status() return -ENOMEM, if invoke
> >=20
>=20>  kmalloc() return failed.
> >=20
>=20>=20=20
>=20>=20
>=20>  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >=20
>=20
> Hi,
>=20
>=20It seems to me that the code has been structured so that
>=20
>=20this case is not treated as an error, and rather initialisation
>=20
>=20that depends on it is skipped.

Yes, your point is also correct, but in theory,
if usb_alloc_urb() allocation fails, we should
also return a value of 0, should we keep the
two behaviors consistent?

>=20
>=20Are you sure this change is correct?


For drivers that have a driver_info->status method, it is generally
needto allocate an interrupt urb and fill it to obtain some
status information, but if kmalloc() faild and return 0 in init_status(),
and some dirvers directly call usbnet_status_start(),
the WARN_ONCE(dev->interrupt =3D=3D NULL) will be trigger.

Thanks
Zqiang


>

