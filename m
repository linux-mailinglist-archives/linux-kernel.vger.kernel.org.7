Return-Path: <linux-kernel+bounces-826297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A9DB8E20D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C203A7F7C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C98255F53;
	Sun, 21 Sep 2025 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koEmKzV1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4D235947;
	Sun, 21 Sep 2025 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758475936; cv=none; b=M15IaG+xKyoLwJ93UFfDrdilyukvx7WdmjUlnmz1Tc05CWQoVXTba7wn3zb0bNQtg+cqf8cEFZVmSc1Hy5v/XzxWE+BsyDTqWWidCVe7fjJcuoAATJ7t4PD8CoKfuMDZq/LZ45FfVHJqOkYhcrl6TNZgUTpEuo7zbzXs7/tJtNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758475936; c=relaxed/simple;
	bh=qepFOU8T20KaFaLq8hgY/wsf4nLF6or1PKzI4CKHSjo=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=usjPx4X9WmwTLP5+sUE3zTMr1UIAneDsiFTiO1+F774aq3xzpc9vJKswmgrdAV64uw0DpgsLkrpKqZ7MHSppfTGrtyQLHlHTg080HTfcOMZDWftHPSndn5+FZvHPnVCfgte6Q/pvaeYScQK/6dPosYibx9QAoF91JOk66COmv6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koEmKzV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EA0C4CEE7;
	Sun, 21 Sep 2025 17:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758475935;
	bh=qepFOU8T20KaFaLq8hgY/wsf4nLF6or1PKzI4CKHSjo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=koEmKzV1JfTshEqlFj/6c7QvIt4O4+AHiKmF7yCgAUnIyKNJIxq9QY9yReUExzRoo
	 RSvhAKRzWIrcDfEalNx1esu/opu2awkjrnj422ZaEVyM8UAiBR5Y1tlzXYyPQu1471
	 aLqmqmtZYDSsdLGvO1EOWFqtUD6CP+miBuTkvXhV0V8CZbZP9TFSkXVFAkPmy49Jhr
	 Svj0EkBVcIOOcxkobOQjkJGeKUgLFJprmv4hWdfvhZ8fsavVZ/kIrGFHsuzv8lHStU
	 h5wLbIr3AQrfTmrDxio/6aC84uqYlgnMEjSPV+BsvAsow1UtRBq124elLPoaPI8WGQ
	 mamP7+Lpb83rQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250625-upstream_rcc_mp21-v4-1-9368a86c8515@foss.st.com>
References: <20250625-upstream_rcc_mp21-v4-0-9368a86c8515@foss.st.com> <20250625-upstream_rcc_mp21-v4-1-9368a86c8515@foss.st.com>
Subject: Re: [PATCH RESEND v4 1/3] dt-bindings: stm32: add STM32MP21 clocks and reset bindings
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Nicolas Le Bayon <nicolas.le.bayon@foss.st.com>, Conor Dooley <conor.dooley@microchip.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor+dt@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>
Date: Sun, 21 Sep 2025 10:32:14 -0700
Message-ID: <175847593403.4354.864826415550352713@lazor>
User-Agent: alot/0.11

Quoting Gabriel Fernandez (2025-06-25 02:07:24)
> Adds clock and reset binding entries for STM32MP21 SoC family.
>=20
> Signed-off-by: Nicolas Le Bayon <nicolas.le.bayon@foss.st.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---

Applied to clk-next

