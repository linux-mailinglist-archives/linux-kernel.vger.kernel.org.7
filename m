Return-Path: <linux-kernel+bounces-826298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B19B8E21B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91F517DA6F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC64B25C70D;
	Sun, 21 Sep 2025 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXm8WaH7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF2A35947;
	Sun, 21 Sep 2025 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758476013; cv=none; b=cH6O+VCnXt+VWIk/pgCr6jUzwcsn97VVYC0t3JNp1ls1WIuFEVXMo7Yc5jNZH24+/QMToox7u+Z06ASlpU8+C6KQI2TUNazEO+9wj8HNGYpFniA7Dou8b6mASQyG66/9L+cz0460ouU/fFzqX4F6a0wEHS5e6UjD25oRC7XvHoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758476013; c=relaxed/simple;
	bh=ffJbmNoMdn7kDBTm1E/CHINJQhEqcbYTDeeSi9wci2Y=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=e/kxtiwARL1853KR4rrXrlf+9abnV4zAYCbhBEHhJRwWyXg8qVYbSbNqa1vHvK/EB59ipDo3vs94fia8lCNBfiXMSsZGO18MUk5jPLKsexy0JdwnSVm4RPnBcuiCS2CWaZitTCSYGAd4RZJn9SMo03z+xAtabczKXK5bhQjvpTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXm8WaH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C40C113D0;
	Sun, 21 Sep 2025 17:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758476012;
	bh=ffJbmNoMdn7kDBTm1E/CHINJQhEqcbYTDeeSi9wci2Y=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=SXm8WaH7EWzPNzDqjISh5EFEZHSrGHVTpAT7LTO1FNxPKe9N4QyRlvnd70odZqCFw
	 IyN7rIoruLgjunml+0UHmvWiJ44eKhrBrhhO9v0Lln6yPOEOljbZ6ihcQKkcLxPZVy
	 gwDcYRoSLbOtBUCsWMBW84NI0ELl9w+OxwCypQ3bXw4yHf96HE9iPombWNWufmO1vc
	 7vP4ea2it3ZBzbeCypzfEnQjW2svS8pNW+bqnDKuV5vbWfZt5tkAPK+1ow7gDu/t3d
	 xMdtG9LU/hrNO7CQaVbxHl5yUHvbDsFB1ENMeIfz03sxNq3PDMGRWA1/Pzx3A4YC4K
	 JMVdA/jlVfoXQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250625-upstream_rcc_mp21-v4-2-9368a86c8515@foss.st.com>
References: <20250625-upstream_rcc_mp21-v4-0-9368a86c8515@foss.st.com> <20250625-upstream_rcc_mp21-v4-2-9368a86c8515@foss.st.com>
Subject: Re: [PATCH RESEND v4 2/3] clk: stm32: introduce clocks for STM32MP21 platform
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Nicolas Le Bayon <nicolas.le.bayon@foss.st.com>, Alok Tiwari <alok.a.tiwari@oracle.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor+dt@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>
Date: Sun, 21 Sep 2025 10:33:31 -0700
Message-ID: <175847601134.4354.18300374897376083425@lazor>
User-Agent: alot/0.11

Quoting Gabriel Fernandez (2025-06-25 02:07:25)
> This driver is intended for the STM32MP21 clock family.
>=20
> Signed-off-by: Nicolas Le Bayon <nicolas.le.bayon@foss.st.com>
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---

Applied to clk-next

