Return-Path: <linux-kernel+bounces-826365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D411BB8E52E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFDAD1897D1D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3452829346F;
	Sun, 21 Sep 2025 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCqlKDEA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0792206A7;
	Sun, 21 Sep 2025 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758486264; cv=none; b=X3t3KvxMErN5HypGzPU0p0Z/ELqbWARe2FdLBGZ0kYVdNFHGhnvxltxN4FKFD+PuNTXjuZmLB6HaexNl/TEqH6PcDINsENNtYWAbSBf6Oyvpt13gOYWT6NpQ95pXAL2Fuf310+EbqCPB+DhlBSD6x3OrSTAiOm9eLkzozEX5DiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758486264; c=relaxed/simple;
	bh=cl4D9hUZUtyBRnsjCdqkFO48i3UvAPyAgu61Fe1pMqA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:To:
	 Date:Message-ID; b=Ysp4TMrPIR7CE0beyr0eHjHhAzBcoNSKNEDesW1q37fUFUnyjm1SUIlmwenm4LlVCV55/js8s+nX+dP5fgayuYZW81YFNpnH5ONplflLPpnDc9FUIOT2Kls6+9669pYVTVyVpATNVs18sTGjOsp4b3sdWhZu638dLOHBYL7BQLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCqlKDEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD09AC4CEE7;
	Sun, 21 Sep 2025 20:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758486264;
	bh=cl4D9hUZUtyBRnsjCdqkFO48i3UvAPyAgu61Fe1pMqA=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=CCqlKDEA4r7GqOWG5skVOB2Iu9N+uR094A7LnesewCQ9G6PLo3r6MZNzIkizZzUbv
	 vx/qQqgMVH9qdLM+tYZ54/PM+hv3QS6ayJeF+fzfv7D8s+9AAUj/LeRL+dP14YmdDe
	 kKgLk2m/q7qwHEf/ddIIWuYwHNXNA+T1RWC1Ugg9hP3KLQVX8sAoRfSBPeGWMeXqQV
	 G3dbddeLo5KKPyNcC8XggcfzghwNN88vuiPfQPAbYl6+RsKpkbrGHv7S7sOgEb4GUP
	 iZBToyo1Byafali3QESd/Lq7M2jZV1GjuioJ3ZOjXMxbJIXhYNQ4kY1/MGc93tI6aW
	 yth9FRqyKQ7dA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250917020539.3690324-3-ryan_chen@aspeedtech.com>
References: <20250917020539.3690324-1-ryan_chen@aspeedtech.com> <20250917020539.3690324-3-ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v14 2/3] reset: aspeed: register AST2700 reset auxiliary bus device
From: Stephen Boyd <sboyd@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Mo Elbadry <elbadrym@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, William Kennington <wak@google.com>, Yuxiao Zhang <yuxiaozhang@google.com>, devicetree@vger.kernel.org, dkodihalli@nvidia.com, leohu@nvidia.com, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, ryan_chen <ryan_chen@aspeedtech.com>, spuranik@nvidia.com, wthai@nvidia.com
Date: Sun, 21 Sep 2025 13:24:22 -0700
Message-ID: <175848626231.4354.7465068928065485494@lazor>
User-Agent: alot/0.11

Quoting Ryan Chen (2025-09-16 19:05:38)
> The AST2700 reset driver is registered as an auxiliary device
> due to reset and clock controller share the same register region.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---

Applied to clk-next

