Return-Path: <linux-kernel+bounces-824307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C7DB889FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2801C86805
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E67C2F7AA1;
	Fri, 19 Sep 2025 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="igQj7NKl"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7281C2D0274
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275008; cv=none; b=ZXt4NyFwHLGV4pV+U8AI8uBUXmWmMKUf4kMG3Bho6b7NPcOBf6ktVMmrwLAEb494CxCTlR0RjPLnWieNj202iMSSG1BbMGw0+odMirZUk5Ra9akrrNJ+elkCYpvp1TpG9t/Wh4wC4ZWXuGZOEn/LDk6qPolj3DsLfyOy7DCK1A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275008; c=relaxed/simple;
	bh=ko5AkknG3Ii2DJQfIqOZTszM7x9Fr2zaNmiIAC+x8lU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uj5fnmMQuPNVfxfLRIKQMle5gY6GIVWCu4icckxC23yO6Ibz5cX8hDWuEnjN/PgouMrtYoGqhqZmC3ixp2iIT1JJyoi7PHNtGiuV4+q5e3qmMqcMBcL9QR7SVg5mLh3rbti8TwRaexoIPJPB8jPfJSQch+gotUN9Z9J2W7Igwqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=igQj7NKl; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ko5AkknG3Ii2DJQfIqOZTszM7x9Fr2zaNmiIAC+x8lU=;
	t=1758275007; x=1759484607; b=igQj7NKllHZkfbDvnfM6ABJpyyFB300ZZ22cRBtHsROYFVC
	C8VGlVdAeMixbKisH5eAI8hPCrL1rVFBh81BcdK8zXP47hzNZuHMcx3KYZU7GLDuj3edvECueaEI9
	OXTLvc6wmfdkFRvqMFnPDfy9V4XZzpgVAV//YPkefB+1W4mbW/6NjpVI+c9TIvnlH73A+xebT4UFw
	gZcFEOC2gE1TbUwNFHNJagptg9pCWOc24LiPzvlyW+fEmuVzgVeiW+psXMQpfHZ3brILvE/kZA1hR
	lWmcthVc7ipsXBN15hIlz1GJGf9dW3ZDpDnjpMPSSWagQwmxZ8Y1X7GWW34LPu6g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uzXeE-0000000Fe5z-2pNA;
	Fri, 19 Sep 2025 11:43:23 +0200
Message-ID: <ae655664adfad625928311cdb48afa080e0f6c4d.camel@sipsolutions.net>
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU
 dependency to PCI driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com, 	linux-kernel@vger.kernel.org
Date: Fri, 19 Sep 2025 11:43:21 +0200
In-Reply-To: <da39f51b76cca54e5304064f7e34a8863442605d.camel@sipsolutions.net>
References: <cover.1758181109.git.thehajime@gmail.com>
			<4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
			<a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
			<m28qib8g1r.wl-thehajime@gmail.com>
			<6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
		 <m27bxu949d.wl-thehajime@gmail.com>
	 (sfid-20250919_113237_926194_6AC3D71B) <da39f51b76cca54e5304064f7e34a8863442605d.camel@sipsolutions.net>
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

On Fri, 2025-09-19 at 11:38 +0200, Johannes Berg wrote:
>=20
> My gut feeling is that UML_PCI_OVER_VIRTIO should depend on PCI but I
> don't know if that then doesn't end up in some kind of circular
> dependency.

No, that _is_ wrong, and it will end up in a circular dependency,
because for UML_PCI we currently do FORCE_PCI and then we have PCI and
HAVE_PCI and it all messes up ... Which is all correct right now.

That still seems reasonable (why give the choice of selecting PCI after
having selected VFIO/virtio PCI), but then with !MMU it can't work, so
the pieces there just need to depend on MMU.

johannes

