Return-Path: <linux-kernel+bounces-824300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B283B889C6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3D5188887E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E13E2F5498;
	Fri, 19 Sep 2025 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OSvt7BKO"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C1B2F291B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758274696; cv=none; b=Y5lQcEg8OQvGJC9Il9XRad02d6pGYdZenb/CNMubTkrTF1rTh77mv7iVXh4+UiYXdlQxA4EISLdi16QOPT08IuW5Rfa0pPdxSZRCf9NKEc/HUXL8aJxY/FpnCYWWnoBoRZTBp7vrIDfBTfShUI+VH/9pgPYOuvYXyU2hvSjrOho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758274696; c=relaxed/simple;
	bh=wfmZMbb6T1vMoMnm8XodxCBtLdhZBUIdYoCz9DQLhG4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ALIO0r55jsG6irhMq0qpTkJ1PcbK5PAz5ajdR2Ny6Vz0n2DiiFTx/qNtpn2o1kCejPCkjL0wDjA4o3EnlZ/TnbEVPqNw0afjMSfk87aoFXbr/lMzrfwd0WYGm2oLrJgxJba/Qklhff0nyagCB2u/PRQvmMLPTDalMmnN3+pB5yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OSvt7BKO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UsEHoqpr4EKQ1m7trAZcJJ5OYUIK1jdUsKRYb7ptqtU=;
	t=1758274694; x=1759484294; b=OSvt7BKO6C7leT2QXiZtRY0DM3QUMl8wlih7v5+1FX3Ps77
	wtaN3CUhvh2fr8VJR073FLdQbkXFAlSDxH30qNzWjJV4S/yELc/WTS+50I16MKZ+J7JFfud/xJigV
	V8U54MO8M4Wdzr6xrFJtFFH0ZASwwq2y+GrNMetc1wZgOQw30nBinYGJBu0Rv4hFrEtykhOnAnP8K
	DNrwchVfbEQXCcFX1rvaZRzMpR2NvQdzTf76LD4h830/Sh0gMi+bL7vcsXei3kqkKHANjELiQdQa3
	GRD3AzjsjvNLcLkYt0Njki/unpRMSXkrE93S+JI7ik8iyP6ii0PPHHyuW2CsUB3w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uzXZ6-0000000Fde2-33vj;
	Fri, 19 Sep 2025 11:38:04 +0200
Message-ID: <da39f51b76cca54e5304064f7e34a8863442605d.camel@sipsolutions.net>
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU
 dependency to PCI driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com, 	linux-kernel@vger.kernel.org
Date: Fri, 19 Sep 2025 11:38:03 +0200
In-Reply-To: <m27bxu949d.wl-thehajime@gmail.com> (sfid-20250919_113237_926194_6AC3D71B)
References: <cover.1758181109.git.thehajime@gmail.com>
		<4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
		<a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
		<m28qib8g1r.wl-thehajime@gmail.com>
		<6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
	 <m27bxu949d.wl-thehajime@gmail.com> (sfid-20250919_113237_926194_6AC3D71B)
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

On Fri, 2025-09-19 at 18:32 +0900, Hajime Tazaki wrote:
> currently, drivers/pci/Kconfig (CONFIG_PCI) marks as depends on MMU,

Right.

> so we cannot select it when CONFIG_MMU=3Dn.

Actually, I believe that's not true, I think it *can* select something
even if you override the 'depends on' it has, it just causes a warning
in Kconfig.

But I don't think PCI is even selected, UML_PCI is selected, and then
that selects PCI_MSI which should really only be reachable when PCI is
enabled, so this perhaps does nothing? Not sure ...

> but it's different with kunit when using them via kunit.py config,

It really isn't, you just don't see everything because kunit.py hides
the build from you.

> it first adds
>=20
>  CONFIG_VIRTIO_UML=3Dy
>  CONFIG_UML_PCI_OVER_VIRTIO=3Dy
>=20
> via tools/testing/kunit/configs/arch_uml.config, and then add
>=20
>  CONIFG_MMU=3Dn
>=20
> via --kconfig_add CONFIG_MMU=3Dn.

Sure. But that should disable CONFIG_UML_PCI_OVER_VIRTIO, and it doesn't
now.

> and then execute make ARCH=3Dum olddefconfig, which in turn enables
> CONFIG_UML_PCI_OVER_VIRTIO.

Keeps it, let's say.

> if we append "--kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=3Dn" to kunit.py,
> it will overwrite the arch_uml.config.

Yeah but that being required doesn't make sense - the Kconfig should
express the correct dependencies.

> # I don't know how kunit handles those appended CONFIG entries, though..

It just puts them into the file and runs oldconfig, I guess?

> my goal is simple; to test !MMU code via kunit.

Sure.

> my original patch or the additional kconfig argument (--kconfig_add)
> satisfies this goal.

Sure. But both are the wrong solution, as I said, the Kconfig should
express the correct dependencies.

> > The problem is probably UML_PCI_OVER_VIRTIO selecting UML_PCI selecting
> > various PCI code, but nothing depends on PCI in the first place. Which
> > it should, then?
>=20
> I don't understand the 'nothing depends on PCI...' part.  care to
> elaborate ?

See above, I think?

My gut feeling is that UML_PCI_OVER_VIRTIO should depend on PCI but I
don't know if that then doesn't end up in some kind of circular
dependency.

johannes

