Return-Path: <linux-kernel+bounces-752327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A59B1741A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D94A80B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE6B189902;
	Thu, 31 Jul 2025 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="a583IQHj"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD6580B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753976801; cv=none; b=SQ+Oysquwk5rrjAuJrIMIDpMh3tjj4SoWSuEYDdLqNsCjMJ5wGpxRVswMbYykQKRnr34WcxbSChdEQ6vQiQ9tisGxmVjFKOTQyuiqGce28r9bP0+V8zNWCHcK3cY1i8L57j5yUWkgoJxFVLhVgfBCXaDd6aX1dP8cODfG+rXj4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753976801; c=relaxed/simple;
	bh=wO9VfTEhprydHILB3elGv6+ePAtiiEKjt8NPrsym67A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tI2nTNEiezo9MbYi54MPROQtDBsSHcaxDBlXCSJPmIEljXqfiPg+Vkmhd4iVOcI8g/pO4n9BLOxVMJQcQ7fQhlnnevfpBsJXenrKaA9IJUHqqS4pGvRXMZZH1NGN8x4ADMMrQGDh/qGVfdh9Il401iVCUYVQitXc7HdwYY9pfso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=a583IQHj; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4btD2w6vvyz9smJ;
	Thu, 31 Jul 2025 17:46:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1753976793; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqSqnIBT+SHJ9AizB7Ds7cjospfQYyj5MAaxXf/CUTI=;
	b=a583IQHj17TnZm2kYRSRkRL3d85eAIKkjqNmRxTxRUZfFGLRxhF3gvPv6ZdpCbljw/3ypw
	HkqMV3lZRm0BVyeHLCNgG5LTT1apwLVXu0nHjx+hWEB+QVaAP6uuojfVW39U6We8r087HD
	tlLclS74neeZagvkY/ltfUlkgwPMzQD/v5J9knfx/exibfkv2UyC3WGZ4ym3m8gj+msJ00
	PUdEVqHJ+BXs67jCm0iAxw9WLg6oVQaJxyY394LNSxpa/uxWeMt0Djxq9lS3tlMp98oG8F
	G5UwK5R8fh6Tdj/imwetG3Aatv9DqyUhyp3HhUAedVUbvVlhKLzUMo1b+6GUng==
Message-ID: <481a2808c235f95726d17803503b2b6dc2746dc3.camel@mailbox.org>
Subject: Re: [PATCH] drm/nouveau: Remove forgotten TODO
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Ben Skeggs <bskeggs@nvidia.com>, 
 Simona Vetter <simona@ffwll.ch>, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Date: Thu, 31 Jul 2025 17:46:30 +0200
In-Reply-To: <Z_ZTrZ-dcD5YiSm4@cassiopeiae>
References: <20250409091413.94102-2-phasta@kernel.org>
	 <Z_ZTrZ-dcD5YiSm4@cassiopeiae>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: p53bo8i5ur8wo1qck16c34ycr5h7kqgw
X-MBO-RS-ID: b29b12feb864e280c3e

On Wed, 2025-04-09 at 13:02 +0200, Danilo Krummrich wrote:
> (+ Ben)
>=20
> On Wed, Apr 09, 2025 at 11:14:14AM +0200, Philipp Stanner wrote:
> > commit ebb945a94bba ("drm/nouveau: port all engines to new engine modul=
e
> > format") introduced a TODO to nouveau_chan.h, stating that an
> > unspecified rework would take place in the "near future".
> >=20
> > Almost 13 years have passed since this "near future", so it can be
> > safely assumed that the TODO is not needed anymore. Besides, its conten=
t
> > is useless anyways since it does not specify *what* should have been
> > done.
> >=20
> > Remove the TODO.
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > =C2=A0drivers/gpu/drm/nouveau/nouveau_chan.h | 1 -
> > =C2=A01 file changed, 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.h b/drivers/gpu/drm/n=
ouveau/nouveau_chan.h
> > index 016f668c0bc1..3b73ec91c4ff 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_chan.h
> > +++ b/drivers/gpu/drm/nouveau/nouveau_chan.h
> > @@ -33,7 +33,6 @@ struct nouveau_channel {
> > =C2=A0		u64 addr;
> > =C2=A0	} push;
> > =C2=A0
> > -	/* TODO: this will be reworked in the near future */
> > =C2=A0	bool accel_done;
>=20
> After having a brief look, it seems that it may has actually been reworke=
d;
> there is only a single use of accel_done, which is in FIRE_RING(), where =
it is
> set to true. But it doesn't seem to be read from anywhere.
>=20
> So, I think we should remove both, the TODO and the accel_done field.
>=20
> @Ben: Maybe you remember the history of this.

Since we didn't get an answer =E2=80=93 how do we want to continue with tha=
t,
Danilo?


P.


>=20
> - Danilo


