Return-Path: <linux-kernel+bounces-784515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71291B33CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9BD91B261FF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5772B2D12EB;
	Mon, 25 Aug 2025 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rZ6GOAv6"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFE02D7DD4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117527; cv=none; b=ZMEj14wqjrcLlF7eaSDf/M/0kbzFGVOVWepO6itGap4cVcuI16z40KPVaSUXvgbxrgzsFIgFFPtj+wQVz73U/TcjbxwQqpL13gQmOdzt5G5ILOjjhVDriofpataCq6Vim8ZEGotnzIa0emBhIn84fj8zMjVbykIxiSSLO9dBUgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117527; c=relaxed/simple;
	bh=KaOLmHjViwkxoihfBvJijmb+AB4Bem7L4iWvQKuY0Ac=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y3GkYdTSc3Cs3eVVXuDw9Yh2QCzb4YdQeNHecB0GcT1tUKran/32CH3dg2WiNTRGtFc+2xSt9ytw5VB5dkszQ0yqqFH+1H1Js/byvZ/Q6KSLu3YjZSYS0vCNTY+x3/EQDHew9xYAuSxPLMD65rIn9zSHaXe0r8PY/FcZt9pG+g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rZ6GOAv6; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c9Rkn68K9z9sXk;
	Mon, 25 Aug 2025 12:25:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756117522; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KaOLmHjViwkxoihfBvJijmb+AB4Bem7L4iWvQKuY0Ac=;
	b=rZ6GOAv6aAOu5wR1f2bNtYPctYxa+S5yZavg9XjYHkFxw1kIMlJKecMV+d2I2MfSfUUuPf
	zRksQmq3TbjEmRQeSwbxI//6gL7kAVks1tLqrpaunCWjJqHMghlykx9ScJcfU6SEwcdtA0
	s2+e8uZThG+uGozzKG9c3SPn99fNWZ1r0rBQgfgt90WiqlTMS7s6Pn9P8Ky78T+3+uGD2d
	/IpZ0pdiRKfWkLscBawRKNSB8N8Ng0IkHZISx8s291X5VX0fjdyL8fcdeKwRkoh9p4Qc6o
	OLN2+PeqFs09vRl7Eae4//rIJJO0yMzYP3IEKpdLRagu7k5FlZoenZNQZbK+Tg==
Message-ID: <119cb44579d745ad3e47d649e6ee6fea9fd9d146.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched/tests: Remove redundant header files
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Markus Elfring <Markus.Elfring@web.de>, Liao Yuanhong
	 <liaoyuanhong@vivo.com>, dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  =?ISO-8859-1?Q?Ma=EDra?= Canal
 <mcanal@igalia.com>, Matthew Brost <matthew.brost@intel.com>, Maxime Ripard
 <mripard@kernel.org>, Philipp Stanner <phasta@kernel.org>, Simona Vetter
 <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>
Date: Mon, 25 Aug 2025 12:25:14 +0200
In-Reply-To: <acb4e709-a42f-4591-a406-7745bcd0422f@web.de>
References: <20250819142630.368796-1-liaoyuanhong@vivo.com>
	 <acb4e709-a42f-4591-a406-7745bcd0422f@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 2f8a2bff1c7e893a0bc
X-MBO-RS-META: ajj4b1uysb5akw61sk99hyzimx7fd98c

On Tue, 2025-08-19 at 18:15 +0200, Markus Elfring wrote:
> > The header file <linux/atomic.h> is already included on line 8. Remove =
the
> > redundant include.
>=20
> You would like to omit a duplicate #include directive, don't you?
> Will a corresponding refinement become helpful for the summary phrase
> and change description?

I don't understand what you mean. Can you elaborate?

Both patch content and description are completely fine as far as I'm
concerned.

P.

>=20
> Regards,
> Markus


