Return-Path: <linux-kernel+bounces-745008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4F4B113A9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2030E17C778
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5851F242D7B;
	Thu, 24 Jul 2025 22:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DY7//GDA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18C623BCFD;
	Thu, 24 Jul 2025 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395196; cv=none; b=sM/GhAJrp9Mwtd1xSBzZR+M117EWInj+r8utVv7UhI+PBtmK3hyEs8VS5Cmiic1gqlaWLj8aiTcXrI4w7pu5b2RdjDBVPZmsQJ/kwlh37OEpRG8eP3k9rLmSERzy4fv5AT1QJD+aSeYDS9mOpoVDQhHRpFC91mcdME522EYi7LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395196; c=relaxed/simple;
	bh=+6PqI7wk8F+44CmUhhhxedAyzpbRRvtFWn62OQCLp1w=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=GXvPfXLDI7rya2v2xb1ugt57VcqeU2gKwzVH5BZw806mJC4UEUAuJadeqb/YxamTdkO5ASc6FEjdbfWN5cjZ7tMVT0iSuwkVROtPGqIO3icIo7UdCEC7hPQ3buq5T37ROii1pz43OEc7BVSI9N67otFQrJCcvEBlUdsKsFy43yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY7//GDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B84C4CEED;
	Thu, 24 Jul 2025 22:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753395196;
	bh=+6PqI7wk8F+44CmUhhhxedAyzpbRRvtFWn62OQCLp1w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=DY7//GDAoJpj2q4lePqWYrSLlldprUf9tIydinsX4uqwx73bzmlS0cV1xbN0hexUs
	 IvynkqCBPFhApYmOSbovmvcEAoQycfDjN4O8YrGLVzA0f03hLWQXO9z1kA6wPm1LEj
	 GT7yXWMFxZ//rGYBIhqa6URfEiN4P3eyqmszAVIknnAcD6cxKr4a+XajFjoysUf/sj
	 BPrw4NAnnHpu9G8NEUCQ4/8f8SjP3QpokNsgljANb/M0i2FGWvTfY/AmWz6tFQjaVk
	 lVS0XcnrZabaZTJJLEdqvYEUOwQZN7su3T8oIHZo2jQKl6Tr4+RLrp9qdzgQ9zMbE4
	 hFA7vU/PbEyVQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <776638cc-cbd9-4747-82eb-e11bcc6c8bdd@zohomail.com>
References: <20250415-b4-k230-clk-v6-0-7fd89f427250@zohomail.com> <776638cc-cbd9-4747-82eb-e11bcc6c8bdd@zohomail.com>
Subject: Re: [PATCH v6 0/3] riscv: canaan: Add support for K230-Canmv clock
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Samuel Holland <samuel.holland@sifive.com>, Troy Mitchell <TroyMitchell988@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>, Xukai Wang <kingxukai@zohomail.com>
Date: Thu, 24 Jul 2025 15:13:15 -0700
Message-ID: <175339519523.3513.2798631977806639092@lazor>
User-Agent: alot/0.11

Quoting Xukai Wang (2025-07-13 09:48:44)
>=20
> I'm working on a Linux clock driver and have encountered a question
> regarding how to properly represent a particular type of clock source.
>=20
> In K230 SoC, there's a mux clock whose parent can optionally be an
> external pulse signal, which is counted via a pin (the input is not
> generated internally but comes from an external source). I=E2=80=99m wond=
ering:
>=20
> Should this external pulse signal be modeled as a clock within the
> Common Clock Framework (CCF)?

Likely, yes.

>=20
> If so, what would be the correct way to register or describe such a
> clock in the driver?

If it is a fixed rate pulse signal I would use a fixed rate clk node at
the root of the DT tree:

	clock-50000 {
		compatible =3D "fixed-clock";
		#clock-cells =3D <0>;
		clock-frequency =3D <50000>;
	}

If you need pinctrl settings to make that clk work you can assign them
in that node, although I don't know if I've ever seen such a case
before. If the external parent clk needs to be gated you'll need to
write a more featured driver, unless it can be controlled with a gpio or
something like that.

