Return-Path: <linux-kernel+bounces-895697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6770CC4EB1B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C70B4FD910
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07BE352949;
	Tue, 11 Nov 2025 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OfHYRqCK"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945E62FB99D;
	Tue, 11 Nov 2025 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873248; cv=none; b=kGMqLfZrPBd050xFMra/awKXoYW1qqageLkmP8f8q1qYr7ZEMCY0JrJWSmfGr4AzVXIvTEv6dE8yo4tzAVu8rJkgDY4b2G51MhibUXL6CYSdT7jmqDrOlA0c6xVURW50zopBh6ipYvKn0jP/wYQpm2EwLAM/sdylrAzIJQJR0qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873248; c=relaxed/simple;
	bh=7su5IR618T+6rB3+tm0nX6yBmX9TKD+pFOQprW34oyM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c0vi7G7hzB+zgiRh0KAyDSlGzTCNzcBAnX+7LBcRvGxfzsf0m3v8gq9irdTFt2h/XXkahLjeGlh7HcT5dipSy4BHrJm4fqGg2SBn9O7LerEZ4rWTfvg82f8hNVwT2kRb2CeUGRAXPvA2Ec1KIuvAibC/vcFtDZzWtVZk5megP/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=OfHYRqCK; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d5V8J5LjWz9tWx;
	Tue, 11 Nov 2025 16:00:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762873232; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7su5IR618T+6rB3+tm0nX6yBmX9TKD+pFOQprW34oyM=;
	b=OfHYRqCK5EDREY/xaT93WdXiQCQ/RfKmRda2W05ASJhPvovKRjGcionrYgPrMlgojf3YN1
	Tu0Y6qkFxmBWudI/92ycQeu5TG5tR81fS3sX/DdqyPANHHzNqTyVWURW9aJWiawQHr1zPl
	apk0WES5+VOokxrKW6cvvvhIhtvEYWO2UdFXqLZJo0aikppooYBj24UABIDcVKpQBxQELw
	06xdALXtVZVf9XYZ+0btSP5uwS91lz+5rudAlrysWxMAmQ5t95bystBN+b85cioAzelQ5g
	Qap7MvLJno+m23xYy90ILnH3hl83djCIS+7Oh+6vdrpFYdJrC5CmrnDAroSrHw==
Message-ID: <ad28f8e0788399251c13619d05da5953dad3fa85.camel@mailbox.org>
Subject: Re: [PATCH v2 0/2] devres: clean up and move percpu allocator
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Philipp Stanner
	 <phasta@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  Danilo Krummrich <dakr@kernel.org>
Date: Tue, 11 Nov 2025 16:00:28 +0100
In-Reply-To: <20251111145046.997309-1-andriy.shevchenko@linux.intel.com>
References: <20251111145046.997309-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 396f3ceacb799434fde
X-MBO-RS-META: anctidr5zs68hpo85x4sizx741gymkeo

On Tue, 2025-11-11 at 15:49 +0100, Andy Shevchenko wrote:
> Clean up and move managed percpu allocator to devres.h.
>=20
> Changelog v2:
> - fixed build error by adding a missed inclusion

OK, didn't see v2. Documentation/ still missing, though.

But we only send new versions after waiting for >24h, don't we? :]

Greetings,
Philipp

>=20
> v1: <20251111144104.910241-1-andriy.shevchenko@linux.intel.com>
>=20
> Andy Shevchenko (2):
> =C2=A0 devres: Remove unused devm_free_percpu()
> =C2=A0 devres: Move devm_alloc_percpu() and related to devres.h
>=20
> =C2=A0.../driver-api/driver-model/devres.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 -
> =C2=A0drivers/base/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 25 -------------------
> =C2=A0include/linux/device.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 19 --------------
> =C2=A0include/linux/device/devres.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 17 +++++++++=
++++
> =C2=A04 files changed, 17 insertions(+), 45 deletions(-)
>=20


