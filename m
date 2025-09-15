Return-Path: <linux-kernel+bounces-816892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E67CB57A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DEB01A22394
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2527F305E2B;
	Mon, 15 Sep 2025 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="toZ28Nr4"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AFB21CC47
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938388; cv=none; b=gbmuAhvIwJPf+dfStuMMcZccuP++k4oJNyZP4mCuorzG0GNQfkOv3mWxggMsJSDuV2np4Z9CSksAzJpP76oweHWVEhLc4THwf09Z8NcZCeYiP74kQT8RjCSnLuKNflG9QIucWg95DWenTnjDHfvfXhK262W52fjoc/qdNoqjX1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938388; c=relaxed/simple;
	bh=SUuqkTQJ7a8CARIOQ64Hd3nkujx+80cxXNbJn6GQRqQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tKe8W5cE63OivC8xXrHZJGxsXFn/zxk3FboDp+iYWS0Faw3Oh5G+9MNR9VsHpD/oDr1CjvdhFV/8DjjxCe/Hdrn+bqhwdR+MXXdO2F6LsUlDGD8+Q9gDjj5t9cQdm1BojKkk8PPJDQaKG25B7w/Ku6SM56/DWestJMsm3aONBgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=toZ28Nr4; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cQP7F21Kpz9spB;
	Mon, 15 Sep 2025 14:12:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757938377; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUuqkTQJ7a8CARIOQ64Hd3nkujx+80cxXNbJn6GQRqQ=;
	b=toZ28Nr4Owemh0E+myUp82bUAmOC0CojumoABgJq9N4eishwF7a7uEQbBOavyFn7HctkXz
	EZS9Rde4ZVrUdFE3R2gvNvCDE8lN/mq/5RyZNSCm6Cb+qbTtfMLG8hI4kNt5wpWBO9sZwP
	IOj51CErPu/gkY4MiiNl4aU4RQXiLtpqGrNUDSKj+nX+ef+AtVTAnCdNV6F2EC9dM0aCKb
	K5guZdfIRImLvJffDs9AF1/Jp82XPjm3b1ERpYWqP4g/NjUwnx7tiOOicBAC8EIZzdP7Po
	Cs1XfuKSf7jptK1oCKwUZc8hyveUkkE1WHEAXilcM088xWj7COIQE95Ff2VZcQ==
Message-ID: <62842992a3f18ca7c11e4887d3eced69644793ae.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: struct member doc fix
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Luc Ma <onion0709@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich
 <dakr@kernel.org>,  Philipp Stanner <phasta@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,  David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Date: Mon, 15 Sep 2025 14:12:53 +0200
In-Reply-To: <20250912134406.221443-1-onion0709@gmail.com>
References: <20250912134406.221443-1-onion0709@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: ymb8xhzxx939tti45p6pfxj66jiwtawp
X-MBO-RS-ID: e1ac6099f8206fd3e5b

On Fri, 2025-09-12 at 21:44 +0800, Luc Ma wrote:
> The mentioned function has been renamed since commit 180fc134d712
> ("drm/scheduler: Rename cleanup functions v2."), so let it refer to
> the current one.
>=20
> Signed-off-by: Luc Ma <onion0709@gmail.com>

Thx for the patch.

> ---
> =C2=A0include/drm/gpu_scheduler.h | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 323a505e6e6a..6c4d0563e3d7 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -546,7 +546,7 @@ struct drm_sched_backend_ops {
> =C2=A0 * @num_rqs: Number of run-queues. This is at most DRM_SCHED_PRIORI=
TY_COUNT,
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as t=
here's usually one run-queue per priority, but could be less.
> =C2=A0 * @sched_rq: An allocated array of run-queues of size @num_rqs;
> - * @job_scheduled: once @drm_sched_entity_do_release is called the sched=
uler
> + * @job_scheduled: once @drm_sched_entity_flush is called the scheduler

The change itself looks correct to me; however, a function must be
cross-referenced with parenthesis: "once drm_sched_entity_flush() =E2=80=A6=
"

'@' is used for function parameters.

https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#highlights=
-and-cross-references

Please provide that change in a v2.

Thank you,
P.


> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 waits on this wait queue until all the sc=
heduled jobs are
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 finished.
> =C2=A0 * @job_id_count: used to assign unique id to the each job.


