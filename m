Return-Path: <linux-kernel+bounces-897181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 548B0C522F7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8D9F348D05
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CB3316185;
	Wed, 12 Nov 2025 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PWlsQ8EG"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822663148BE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762949355; cv=none; b=ADmmkX6PgKAoEJWD6TJawwhR+1dDY+pAUWvxC+KoTrP4dAmmAB+114KdcQKxAouWX2+E9q3vZLDZl8LNKz/KKzeDwf/fBbSb+N+WTUv9bMoryEVg70l6iZ0pgDS57OHEIQYyCFSBEolrZlwbsf202seOmHNE5ivEKEjog1Dt+ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762949355; c=relaxed/simple;
	bh=B/jfFxFkgvFtBhqkCW0fhyUg2VTjErZY3XEj/JeBLgU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A4TulUeaon907nkgCiN5MdrWaYOCUxCCRhmPRvcE1LggGadp3TMBuQcjytRReA0iZxQjh7eHHIuYUup2/rOfqwGyk7cLSjkzLGUOtOHHqkR8lw4rmsN5DSMRRu5vRHjc6YVQsk2Pa6Vh8qoe7JF/Qr9gqK+IJgq825GqKIFeSck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PWlsQ8EG; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d62J551r1z9tN2;
	Wed, 12 Nov 2025 13:09:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762949349; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/jfFxFkgvFtBhqkCW0fhyUg2VTjErZY3XEj/JeBLgU=;
	b=PWlsQ8EGGAtNXPJtAF2kfNYzULr3vPE4ZwB51K78dRTBXThWt02zpe1KTVzKvsrHfvoFT9
	zomBk47quzAwuVjOXlB2mDtdyW4/lhnB1Vrk/B1mSX/Q4Q2KcyuAwd/kPVsJZb3AUQNzHr
	9IQ6cNom9ymGqvPqwMxntSh9yrZCy9msq1MWt7ddlNH0YjI9vQvH98Ucy4F6crfDngfvFt
	N6leh5VOj46S6P5d8w55sOjq1TnPakuZfAdYUi2R4t9P4GeO5NvsAnXBwtCzWIKbo1KRaV
	WF6AaOphnEK7J+7twoYj1dT4+jiqQNwWT2vCUMEIYhV2CJ6y0DDKPRGjgbB+Fg==
Message-ID: <95c2ecd1b370d917cf84afbf3120134c0e2d85d3.camel@mailbox.org>
Subject: Re: [PATCH v2] drm/sched: Don't crash kernel on wrong params
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Tvrtko Ursulin <tursulin@ursulin.net>, Philipp Stanner
 <phasta@kernel.org>,  Matthew Brost <matthew.brost@intel.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,  Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 12 Nov 2025 13:09:05 +0100
In-Reply-To: <1e71b41d-38ba-425a-a370-1bb92a772014@ursulin.net>
References: <20251112091851.104443-3-phasta@kernel.org>
	 <1e71b41d-38ba-425a-a370-1bb92a772014@ursulin.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: o3e4d5qbzj16177hbgueg8k1mh7z8hd3
X-MBO-RS-ID: 58c656e39d8f9aec97f

On Wed, 2025-11-12 at 09:46 +0000, Tvrtko Ursulin wrote:
>=20
> On 12/11/2025 09:18, Philipp Stanner wrote:
> > drm_sched_job_arm() just panics the kernel with BUG_ON() in case of an
> > entity being NULL. If the entity is NULL, subsequent accesses will cras=
h
> > the particular CPU anyways with a NULL pointer exception backtrace.
> >=20
> > Remove the BUG_ON().
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > Changes in v2:
> > =C2=A0=C2=A0 - Drop BUG_ON() instead of replacing it. (Tvrtko)
>=20
> The option of removing the BUG_ON was conditional on brainstorming a bit=
=20
> whether we think the null pointer dereference is the worst that can=20
> happen or not.
>=20
> Other option was "WARN_ON_ONCE() return" in arm and push.
>=20

Maybe even WARN_ON() is OK to make it noticable.

I mostly care about getting rid of BUG_ON().


P.

