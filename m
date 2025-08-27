Return-Path: <linux-kernel+bounces-788790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722E4B38A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C679818BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9572ECEA6;
	Wed, 27 Aug 2025 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Xdl3XLkt"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C882EC561
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323503; cv=none; b=G9n2jUcP80ZhZfRgxKJJZlu9ORWwuoUqvypaJZs2BWxfWKVxDLvTHGzv/f0WVdVArHl/Fa9HTbXlcmIyiH5aVD0WW1kKBQUEW3THR71lhNnj558IT9XHVBYVcRq/U6Jd0GKNTiRu7giynCOrYucyB+hCTcGe1OIJaseD4eCZAqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323503; c=relaxed/simple;
	bh=bmGI/NEfAfgDB/a+dal7o7pLk2x1XlSfdfQurPmEfKc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DwnzSK3/P8tM32nbw9NpH1eQQtWFcC21aZM62qP6pIEGg+iwYPpFXl/HpyeKqn09hP7XYlgNeBG/zKeo/TpmjHDI4S+o89SbbNDCUZu5tslnzpkXcCe4cKwM6HIyIHjqcqfNTP0u1+j1CxUrSphroZX8ilCXPdLTNOmtt9ob4S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Xdl3XLkt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bmGI/NEfAfgDB/a+dal7o7pLk2x1XlSfdfQurPmEfKc=;
	t=1756323501; x=1757533101; b=Xdl3XLktkfjgfr5e5qmOWkGyZW4oR43T+PpinuC82MHOPKl
	nFsyk06KqGOjq7mJzfOqS6VnlPw58YrJrP1sndPcdGt2KR2Pefvg6OXiQ6nEOIxE0jQCQGPyWvLrU
	+qSwqQlklAvt9lbJf0W0J9Nu3ckMLKZg4uNvgnumvP4CUvs0Lo9y9Tk9JKxVtOcrK/iSbC2rDt48U
	13cCd6aoW1RUcHKKK8M9liUYJmb9UK2tqSWKufJ9l5C9EVYPtGCkyErmV+1+2Io3kJI8ZjXkOVDQF
	/q8xprVw424gzchit50X8q4QI99pbzdsh5wOWTmc5T6UwppeX2d4aRE4EcVfaazQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1urLyM-000000060vA-04ur;
	Wed, 27 Aug 2025 21:38:18 +0200
Message-ID: <155ce30d5fad5a444f72b681eb096418384542b3.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Support SPARSE_IRQ
From: Johannes Berg <johannes@sipsolutions.net>
To: Brian Norris <briannorris@chromium.org>, Richard Weinberger
 <richard@nod.at>,  Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, David Gow
	 <davidgow@google.com>, Sinan Nalkaya <sardok@gmail.com>
Date: Wed, 27 Aug 2025 21:38:17 +0200
In-Reply-To: <20250825212031.111027-1-briannorris@chromium.org>
References: <20250825212031.111027-1-briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-08-25 at 14:19 -0700, Brian Norris wrote:
>=20
> +#ifdef CONFIG_SPARSE_IRQ
> +int __init arch_probe_nr_irqs(void)
>=20

Is there much point in the ifdef if it's anyway always going to be
enabled due to the 'select'?

johannes

