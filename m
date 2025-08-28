Return-Path: <linux-kernel+bounces-789517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF07B3969A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7DC188035B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E338779DA;
	Thu, 28 Aug 2025 08:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Br6pP9j+"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B122D94AE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756368956; cv=none; b=YCl09DWvD03l6a00eX8HMzDWkEJeGFfQ/Jk1bwB39Zj2QQRdymK7IPUv6a2zxsb7eCbQzoI2TKp29P7qtg/e5QVkrPKwSNiTW1Bzvxs5jh2OSHguHJKTAScMzJ1frQFTTveGRWyT6kZtEYE469yj4jTNWPOHjcDQytaD04VF3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756368956; c=relaxed/simple;
	bh=g6BFsh8A6GJ9PUMZxt3nxah5ekgd0ZK8W1eentIhHKI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FVWMZz+27qC3M3pbGnrjcvlrz4baVR06DaYw8OBz0p+WyeYw9N4kj8iR/Qy+XGP2oybrZIC70d2A7h7AM2duIudi93qYweoh2hgN3Db09wqB6UAT2IWg7wCupg9MVqV5qTIMQZ2sbqEQ2ehNgnItHIhKRK5FHhsOM95+9nfUZPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Br6pP9j+; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cCDjx5c4cz9syn;
	Thu, 28 Aug 2025 10:15:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756368949; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6BFsh8A6GJ9PUMZxt3nxah5ekgd0ZK8W1eentIhHKI=;
	b=Br6pP9j+HVeHhjZtjfHowQnOU6GxI1VUQGxLdeSaRyvO1wj452x8vZXOmFZobjey9yYyje
	x9/PclajEwk6t9OQ7s+ozevwV1r6zJ42kNhkLfsoPQvZMnM2bQqyPaImEVx6jJewf1zo5g
	l1b66KLhJOCjbUoZMw4MeUPHBBTXDkZOy8fFRL0DWxNL0AeNJLVi9Pn1OAHld9hrK9Rr+d
	1CfMU83HD51KjFL2d2wsbuwUOlwDPG0kQf7m3GiMPFfgZJffBIW0PA7P+fdSKCznGNTI2r
	h9LZqe0TBhRHECkqD21yfC2vWIr9fhFzYg+nCPjI9yOgbVHfxai7rFBerMX0vA==
Message-ID: <698ebb7319fbdb405dd7f9ddf96d82a7fdd5e023.camel@mailbox.org>
Subject: Re: drm/sched/tests: Remove redundant header files
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Markus Elfring <Markus.Elfring@web.de>, Philipp Stanner
 <phasta@kernel.org>,  Liao Yuanhong <liaoyuanhong@vivo.com>,
 dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  =?ISO-8859-1?Q?Ma=EDra?= Canal
 <mcanal@igalia.com>, Matthew Brost <matthew.brost@intel.com>, Maxime Ripard
 <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann
 <tzimmermann@suse.de>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Date: Thu, 28 Aug 2025 10:15:44 +0200
In-Reply-To: <697bb91b-24ea-4830-8794-373f709aa37e@web.de>
References: <20250819142630.368796-1-liaoyuanhong@vivo.com>
	 <acb4e709-a42f-4591-a406-7745bcd0422f@web.de>
	 <119cb44579d745ad3e47d649e6ee6fea9fd9d146.camel@mailbox.org>
	 <697bb91b-24ea-4830-8794-373f709aa37e@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: hma6xr6w5t7dfcyo4unzmohy6gz1s15w
X-MBO-RS-ID: dc140174502893cec38

On Mon, 2025-08-25 at 12:48 +0200, Markus Elfring wrote:
> > > > The header file <linux/atomic.h> is already included on line 8. Rem=
ove the
> > > > redundant include.
> > >=20
> > > You would like to omit a duplicate #include directive, don't you?
>=20
> The change intention is probably clear.
>=20
>=20
> > > Will a corresponding refinement become helpful for the summary phrase
> > > and change description?
> >=20
> > I don't understand what you mean. Can you elaborate?
> >=20
> > Both patch content and description are completely fine as far as I'm co=
ncerned.
>=20
> How do you think about to distinguish better between the deletion of head=
er files
> and an adjustment for a repeated preprocessor directive?

The patch is very trivial and the commit message is perfectly fine.


Applied it to drm-misc-next

Thx
P.


>=20
> Regards,
> Markus


