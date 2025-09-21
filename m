Return-Path: <linux-kernel+bounces-826362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB4FB8E4FD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22B63BE665
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C5F287510;
	Sun, 21 Sep 2025 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+FCO1T8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D342144C7;
	Sun, 21 Sep 2025 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758485679; cv=none; b=O7l+euGaLTOBJlZNOxYs2c276ypdBZJhik+XlwbbMorxioP27z+1wP+EjA8pySs5Mil8z/OCrdg9EPXgUfTjtR6HmQXYCkx10blgznEIKbbsxhQ1qkv9tqDeFZT3SRVPsNlAyqHXkk7br9Atz5mfwKqiwl5Vs7WizZXhstvzP/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758485679; c=relaxed/simple;
	bh=sxNUxatlX2j8pSiDe8L67uJzf4cC07GJgtefdwBeAOc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=p5RKVRUE8WreRVHBNpF3P5hfF/gq2y0nET2Vvfa02los8WqSlNuOLOk563mU+WhNT/R9SKvnbp73zQWnmjlSCOqejrFglLCrgR5itxrr6OT7JjwoDrLWERjBKhxe8Yw323kWHeEld/HE1YFUJmFAmx+GNnm1uCVXe40TMchMPsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+FCO1T8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E845C4CEE7;
	Sun, 21 Sep 2025 20:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758485678;
	bh=sxNUxatlX2j8pSiDe8L67uJzf4cC07GJgtefdwBeAOc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=l+FCO1T8tvENOND7RAa71AtzmmxkWP0XSoMcte7v/zC16QH0QouPQbhef+DT+YfSa
	 K25SW5z7RnbyTDpqldoshrGCtlTmD0w2nl5PsoheUsr40aPn0Qy5seXFb34w7FdsPJ
	 Hvq0HbGQzLh8kY//BA/+P/Q75Qh3/utaO+HhgSnjhlqJsbPNLxhemWqdSK8mr7ENz0
	 DD02q+ocPjpivFx1nI4PfFCmf6Q7nbRuKLa2rgk8AttUQCs0mooX0eQrNMmxzehQt/
	 vihxFlBUWkMxzWtaea8Nca3O9vX/GXg+RpDQ8fB3+BasCLoYwQyohIO3QT1bxaiHuv
	 mABM/E7M+CwLA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250917020539.3690324-4-ryan_chen@aspeedtech.com>
References: <20250917020539.3690324-1-ryan_chen@aspeedtech.com> <20250917020539.3690324-4-ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v14 3/3] clk: aspeed: add AST2700 clock driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: Brian Masney <bmasney@redhat.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Mo Elbadry <elbadrym@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, William Kennington <wak@google.com>, Yuxiao Zhang <yuxiaozhang@google.com>, devicetree@vger.kernel.org, dkodihalli@nvidia.com, leohu@nvidia.com, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, ryan_chen <ryan_chen@aspeedtech.com>, spuranik@nvidia.com, wthai@nvidia.com
Date: Sun, 21 Sep 2025 13:14:37 -0700
Message-ID: <175848567705.4354.18321442549280624891@lazor>
User-Agent: alot/0.11

Quoting Ryan Chen (2025-09-16 19:05:39)
> Add AST2700 clock controller driver and also use axiliary
> device framework register the reset controller driver.
> Due to clock and reset using the same register region.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> ---

Applied to clk-next

