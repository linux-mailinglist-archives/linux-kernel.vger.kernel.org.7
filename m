Return-Path: <linux-kernel+bounces-811517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE51B52A34
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BCDF165929
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0544271451;
	Thu, 11 Sep 2025 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MSMSVQ0v"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC1F1DBB13
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576289; cv=none; b=nxN8bMCWJOT5/KKvVZ647KpnI2Akt+Zqo0U/GxNVmNGlryu9JQN9CdXeO0dJkATpcNynOJxMPxzSJssJ2W6V+JJJFRWgloZo0WDYxLhM8GzP0aV3cV8w18fFrM8NsWttKL2q6gA36r6Lqh12lPvxKJzB8Fa3UfXPMVReqyFLpis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576289; c=relaxed/simple;
	bh=TNaDwTJZop2ddQ5UDh22YAz8ggmdQrz12HT+woTeAOQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kofBIbR+uBUsjvXHTg/jtZKY6CbmFhho63JtX4PwBV0lq2lJBsga9/gi3D6+2plhfwuay2N1H9ufwSye/FMCLiZ8qRKOoYfERrO4zwOcDtmBBFjX8yL4iicpgh2uYosMwxObV+0vjurCu4B09Estn8g9XgSUqaKtRJc68ZAqbUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MSMSVQ0v; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TNaDwTJZop2ddQ5UDh22YAz8ggmdQrz12HT+woTeAOQ=;
	t=1757576287; x=1758785887; b=MSMSVQ0v5o/2BOj9qCImydgiPbhYVAw4tJN7CL9Dvm3578P
	WFZtLFvhvcJ1cNpHfJzLuKYVi0nCNVqk8k+OF6yUOnVlwcp/KYZMedlMrw5JNNjYSFKv9PpGEdQ5b
	9hXAlEIyyYHSfNHFHAFzACzwa4MB9arVTgMxTmw0w0QEEsfuD70a67zzHhkFTHgHF6fb3tHchZ6IH
	5YfgbJNC5mgyUZ5F1bYdB/ZlkFkgY3m2TYVenDMA8R2YDN27bypinWa2SNuyYsVKIWKaFWHgfscD5
	HxCKpGYP9sBi9ntzaPbXTQSsDCYnIjEZkKIck+E5/aJ2bHZqQCJMNi48py5E64vQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uwbsX-0000000Er1b-0oKo;
	Thu, 11 Sep 2025 09:38:01 +0200
Message-ID: <3c4bc989c4f10609eab699b26e8331bc878c2a0a.camel@sipsolutions.net>
Subject: Re: [PATCH v2 04/10] um: Turn signals_* into thread-local variables
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>, johannes@sipsolutions.net
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tiwei.btw@antgroup.com
Date: Thu, 11 Sep 2025 09:37:58 +0200
In-Reply-To: <20250911043434.2897892-1-tiwei.bie@linux.dev>
References: 
	<f402a7b5ddfe92a8fbbc1460102cac7b5a5864b5.camel@sipsolutions.net>
	 <20250911043434.2897892-1-tiwei.bie@linux.dev>
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

Hi,

On Thu, 2025-09-11 at 12:34 +0800, Tiwei Bie wrote:
> On Wed, 10 Sep 2025 14:15:28 +0200, Johannes Berg wrote:
> > On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > >=20
> > > Turn signals_enabled, signals_pending and signals_active into
> > > thread-local variables. This enables us to control and track
> > > signals independently on each CPU thread. This is a preparation
> > > for adding SMP support.
> >=20
> > [...]
> >=20
> > > +static __thread int signals_enabled;
> >=20
> > How much glibc infrastructure does __thread rely on? More
> > specifically:
> > Some time ago we had a discussion about building UML as a nolibc
> > binary,
> > what would that mean for the __thread usage here?
>=20
> We would need to parse TLS data (PT_TLS) from the ELF file ourselves
> and properly set up TLS when creating threads using clone().

I guess right now we cannot use PER_CPU variables in these files.
However, my expectation that this is possible when using nolibc, and
then it should be simple enough to replace the __thread.

Benjamin=20

