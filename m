Return-Path: <linux-kernel+bounces-766438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 881DCB24679
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4022816367A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2512F49ED;
	Wed, 13 Aug 2025 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rPxck3uV"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC432F3C25;
	Wed, 13 Aug 2025 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079032; cv=none; b=pNvrTLzcemuggN9L2BKkPBSVT9rmTMKhwdcSAWM7/lmDCVZvpdpuwsg2KYa6JCN7A8WdvSFE4gsPJDcVvRbM3WWTMtoPHl3mt+JO1sRPIXGRt5lltrekvDq4T1cISrs90GtJA5TErBf1xq/Y1lBHrIZKvySevja+sstGEheTLJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079032; c=relaxed/simple;
	bh=3I/mDqpQX9jkLpLoehB+o2RmLvW1cxiRLz6+Er4xFOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mV65qllHhtbN8J7kkdx/0S5jhHe/1+C8qi6BcTgirjGTdgt+l0KOIt6vl0IOR+j8LMYLr66JRFpK5tpLwKF1E55Zx0/fQ3PfdQ3f3dZ3PhRwsjvrnAlu5mgMJtTQ7nJ9NbaqF7LGzbhi4JllfNgWVfZzbxmbi7Bk1/MwOSrMzDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rPxck3uV; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c23gc147Gz9tHg;
	Wed, 13 Aug 2025 11:57:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1755079020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3I/mDqpQX9jkLpLoehB+o2RmLvW1cxiRLz6+Er4xFOE=;
	b=rPxck3uVjGwVbjegnyQf978gzo+AChZ920JmecucA/mfRWGtJP/WQrT4CZ4rISo0Z5SfTb
	7xbZL8h7b+hIab2dIR7MXaDX6HpxJCouTG2Q0ACtD0/XYRCewrARcji9s7L64Ke7qTWDPt
	INm9fhWFk18EwwsxU9o53TNNEG5E4mAyRlC6tohqirDigkOtmYQpbsLWEpmPnIT8NjLcPm
	mcnfTTl0qZLpmmcQj5+eYBnAPiBoSsBsvNCFP0qzQw40jogFJz7GeluVyJ/lHg489NnlQ7
	iLlcRYa9uDRtK+NB62kdSCLvam2gG6Fi+UqF7HLlXbc55DXrMHY3joUawW/Teg==
Date: Wed, 13 Aug 2025 11:56:55 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukasz.majewski@mailbox.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?UTF-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6-display5: Replace license text comment
 with SPDX identifier
Message-ID: <20250813115646.29a08c1c@wsk>
In-Reply-To: <eac01571-13cb-44a8-b724-76e1b2af4c0b@kernel.org>
References: <20250709-display5-dts-lic-v1-1-81e46a650d3d@prolan.hu>
	<d9e81ff2-5621-49db-92a1-acf304b225f8@prolan.hu>
	<eac01571-13cb-44a8-b724-76e1b2af4c0b@kernel.org>
Organization: mailbox.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-ID: c13e5f5f6dd64ce9ace
X-MBO-RS-META: sowtjo94ijj8df1d4gp6ww9koodhgx4h

On Wed, 13 Aug 2025 10:33:32 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 13/08/2025 10:29, Cs=C3=B3k=C3=A1s Bence wrote:
> > Hi,
> >=20
> > On 2025. 07. 09. 9:32, Bence Cs=C3=B3k=C3=A1s wrote: =20
> >> Replace verbatim license text with a `SPDX-License-Identifier`.
> >>
> >> The comment header mis-attributes this license to be "X11", but the
> >> license text does not include the last line "Except as contained
> >> in this notice, the name of the X Consortium shall not be used in
> >> advertising or otherwise to promote the sale, use or other
> >> dealings in this Software without prior written authorization from
> >> the X Consortium.". Therefore, this license is actually equivalent
> >> to the SPDX "MIT" license (confirmed by text diffing).
> >>
> >> Cc: Lukasz Majewski <lukma@denx.de>
> >> Signed-off-by: Bence Cs=C3=B3k=C3=A1s <csokas.bence@prolan.hu> =20
> >=20
> > So, what do you all think, is this patch acceptable? =20
>=20
> Yes, you just need Acks from all contributors there.
>=20

Acked-by: Lukasz Majewski <lukma@denx.de>

> Best regards,
> Krzysztof



--=20
Best regards,

=C5=81ukasz Majewski


