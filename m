Return-Path: <linux-kernel+bounces-897290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EE5C527EF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E46188A2E2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641E43396E4;
	Wed, 12 Nov 2025 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzvYZUG6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3551338F26
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954466; cv=none; b=c0XwPsdm81kxu9nwGZ1F0myuOu/ay+WkSsymBsN/qq9aNiMK4U4j+hkIcvhFHCVi5eyrNoIulnXMw5yVYxVU16xHQiCypBJij0SyfERCHf5O+YhfJV4SfBNhiPLCwm01+lrPKGflM2aHakjJO3OeyNTYtJeJxC56A6BZ/AydBKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954466; c=relaxed/simple;
	bh=ja9YXOVmyXlMo8gAt1oJeN4Ik/humKwGB2i5IT6pF7k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=I8xzVIbtv8HTFBKcc7s60FIdNNuIVYQEvmzajrlD/NIhH/rIkMQAYxmFVKQmRIKzhgTOHJRNBHE+Msd6Q5a4bVfCnvBTcoFr8MmjrncUVmJuCPOrROKICjxf9uOY3l4m91U40UWuGa4GNkf99tvO6oYqmKlSqkeDGZSEJdypFaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzvYZUG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C48C2BC9E;
	Wed, 12 Nov 2025 13:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762954466;
	bh=ja9YXOVmyXlMo8gAt1oJeN4Ik/humKwGB2i5IT6pF7k=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=AzvYZUG6T8ljAlwx1rplNvgQ4lkJEDYHfStzRM+6DSuUNNnWBZuYQLQ7ZFxxq+KKA
	 C0DYGqACpBHEOACZbejmcB5WeVp/WaapOocY4aSxhskVK6HKvsyhlIsLX4BesEkYiO
	 dTAMwxhxS0rKzyB0kIl63pOjTc4wmZ15yZMIkoUvyXvk3gxx83k7QZjo3znDyhMsGa
	 M/UjJrG7l2NUkN8kR5V/jurO038WXBLmj5BuxfI6LERX4Alllwjx04LHVksvGeV4FC
	 fIArB8duY3Pj2mbBz01UrR8RZ0su3eUOiLssvYhjtT47jbF0Mytd6Wbwo/+qIqQxH3
	 /kRmkQd69OLMg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=b3637e902dd604fe5ec42f6df36a18ffc2ee0a23019ae188bc6a3714ab41;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 12 Nov 2025 14:34:20 +0100
Message-Id: <DE6R76H9N8H0.NKHN0YUTE8LL@kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Enable locking for n25q00a
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <linux-mtd@lists.infradead.org>, "Richard
 Weinberger" <richard@nod.at>, <linux-kernel@vger.kernel.org>, "Vignesh
 Raghavendra" <vigneshr@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Sean Anderson"
 <sean.anderson@linux.dev>
X-Mailer: aerc 0.20.0
References: <20251006223409.3475001-1-sean.anderson@linux.dev>
 <mafs0ecreontu.fsf@kernel.org>
 <4888cefa-e8be-4f0d-9d4a-c82f9ff6cda0@linux.dev>
 <mafs05xcpo9sz.fsf@kernel.org>
 <26a795ac-e6ff-4363-a8b9-38793a9be794@linux.dev>
 <mafs0ikgnn07u.fsf@kernel.org>
 <d00d42ce-4262-4736-8c73-5d2544e86d33@linux.dev>
 <33cbbac1-c247-4644-b555-998eea6e8305@linaro.org>
 <92e99a96-5582-48a5-a4f9-e9b33fcff171@linux.dev>
 <871pm3iegf.fsf@bootlin.com> <87v7jfgzfw.fsf@bootlin.com>
In-Reply-To: <87v7jfgzfw.fsf@bootlin.com>

--b3637e902dd604fe5ec42f6df36a18ffc2ee0a23019ae188bc6a3714ab41
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Nov 12, 2025 at 2:20 PM CET, Miquel Raynal wrote:
> I forgot to mention: I don't like this interface because it is not very
> user friendly, but this is uAPI, so set in stone. As part of my journey
> in the SPI NOR swp.c file, I wrote a debugfs interface to help
> visualizing what is actually locked. It is absolutely trivial to do and
> helps a lot. We might want to use that for writing some kind of testing
> procedure =E2=80=94 I will share it soon.

Yes please, that sounds very good. We might also want to just raw
dump the SR (and maybe CR/SR2 if we somehow can infer it's
existence).

-michael

--b3637e902dd604fe5ec42f6df36a18ffc2ee0a23019ae188bc6a3714ab41
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaRSM3RIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gDAgF+Kz34DlIHnAjAN8Fa3lW/a4pKAyexadrS
oTrkVV2UCSiwsAWS4Rrmu138+YuX/MkQAYDnGzUABONiUOXmmah/J2PV6Bq2Xd85
WPMYdF8aVjXrfja0/0yRr0nM0hjPp4Q1HrY=
=Tl0m
-----END PGP SIGNATURE-----

--b3637e902dd604fe5ec42f6df36a18ffc2ee0a23019ae188bc6a3714ab41--

