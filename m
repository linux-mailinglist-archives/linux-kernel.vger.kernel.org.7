Return-Path: <linux-kernel+bounces-693094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61620ADFAE8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 03:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094C34A0529
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 01:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CFB1D7989;
	Thu, 19 Jun 2025 01:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsSNMgMZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5613B1DF72C;
	Thu, 19 Jun 2025 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750297283; cv=none; b=SEZaWog0VFLAexMiON6E4jRkYhCYyHOWW1IaeI05l3T0nQ8320HjGvePl6UcRIVWA+OaR1ykMcQXPOMc1pWXzCWIV8X87ZzkftoquiBsWIe6wIQChE7v+XMwL+9vDiTMw2bTgS5JORsK/x6v59cYk6xYNHIad0WO7B2/C73HBuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750297283; c=relaxed/simple;
	bh=raqlE872j5ogpM+SPMHVzwOIq21E3K3C86eIzXTR37s=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=lYMU/0cwF03h7FjFMCSRc9bEW8vCfdioZWR4cH3+GMW6LkdPUK4YuOLaAxFMT/4PvVeX3YoUU45prrFta1yg7d/esPPMLOh0TiLXYjqmXCSEmbAxtioPei4CZGcIyVTWzw86b/Rmd6g8PHjO5+YD9sg3DXY8dseUjMlXBvOz7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsSNMgMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E13C4CEE7;
	Thu, 19 Jun 2025 01:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750297283;
	bh=raqlE872j5ogpM+SPMHVzwOIq21E3K3C86eIzXTR37s=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=nsSNMgMZ9zORpxuksQv8ZCTEatUumzEXGiiPCFohhKln/6w56r/g3GJIRYTPuDZb0
	 yprG6+vwSV/Fbqo3LDY7E0H0bF89TAmAHpmpuNaWEoecW8NgKAAw7ldKw6OsuLJXyc
	 9GKtwJmGCU4UZCCLcuxTBU2Hhp+Y8wAAdIHDRasTuWYEbu7t26XffcHhMjOArjbqiC
	 NPjZWv8qFvkb6WPg1Z2kqwyz1ixXHqi5eSN38FxoELbgPmtzM4/WUJJpkHg4UIYZMJ
	 YJvC/I7pnUb/kJp0AsL3T0gqbBXrBc2xrtQ2CyzDC1FrWcQlJNBTLX/HRPOz2+AUun
	 xSF/PGkVFji8Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250521210844.62613-1-robh@kernel.org>
References: <20250521210844.62613-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: Convert marvell,mvebu-core-clock to DT schema
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>, Gregory Clement <gregory.clement@bootlin.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring (Arm) <robh@kernel.org>
Date: Wed, 18 Jun 2025 18:41:22 -0700
Message-ID: <175029728234.4372.14624235123690489862@lazor>
User-Agent: alot/0.11

Quoting Rob Herring (Arm) (2025-05-21 14:08:43)
> Convert the Marvell SoC core clock binding to DT schema format. It's a
> straight forward conversion.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied to clk-next

