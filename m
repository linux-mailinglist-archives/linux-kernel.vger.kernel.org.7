Return-Path: <linux-kernel+bounces-745021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEA9B113D0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821F5AC6B11
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E649246782;
	Thu, 24 Jul 2025 22:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIJ2pO1r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69901220698;
	Thu, 24 Jul 2025 22:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395373; cv=none; b=Zbr34xSPq78wF50nj9lTCyCjWveWxin9CQvcD6H809EwPbjUDvo+D6To7f6vZa2D1Cc7WVlN4Y7WMDzkPVNzkxr3+Bl5Ju3hQykroRKuKeceKpYH+gpWoHf4aiEh1UT54glqluYoj6HzSnEBb9jtVO06Cz5Odws2NHzggw0kYyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395373; c=relaxed/simple;
	bh=iqBZ/dBc3/jAic+RGlIRDOKcBSpRxqN9W1Esyu+vQQo=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=NqExCjKwSQ5eQYYTplJ5mV6LkS56eVCTQstl46OodP+OIzZ50ivEmHvXJtlqWPwFyv7qLxfqJ8SS0d4iSqXVtdzDYBOf41PhjhYBTMz+cOvONP/hKhazQNN4H5KbxsF3sN2OMc06S9JP7OWl0yxhAjTNSj7PtEXj3Ee90DaJNSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIJ2pO1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1DBC4CEED;
	Thu, 24 Jul 2025 22:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753395373;
	bh=iqBZ/dBc3/jAic+RGlIRDOKcBSpRxqN9W1Esyu+vQQo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=YIJ2pO1rjgh2MZEdpPDYwKHRPpMctJniFlt2F08cULZS8iKm4OX4+8M+d7xAJ6x9/
	 ADh2s/b9hN8RhXTZ5tjlnsilWYjQ90b0bQNR+3y3rHoUZge0ITkEGbgNWOMo1mBRnV
	 q5t/wnqiFIeqIskg/+y2rpsKx0fw6zEedLJYeGspp4LsBPeOO1sA87heH1qk/gYRJF
	 0bzwFAnRcf2N1iPdcx9pmQ4py4dvkXXAjC5Cq1NRBaMSaZAm/4h+raF8Rf9WHHmNj+
	 wd8x+pHcVrdOHUYiitqavRx+/ympB4pbgfS07IrJNuNCWl8Q1DUBsv7puKvIykPCos
	 l58SETOypKmsA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250710-clk-imx-round-rate-v1-2-5726f98e6d8d@redhat.com>
References: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com> <20250710-clk-imx-round-rate-v1-2-5726f98e6d8d@redhat.com>
Subject: Re: [PATCH 02/13] clk: imx: composite-93: remove round_rate() in favor of determine_rate()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
To: Abel Vesa <abelvesa@kernel.org>, Brian Masney <bmasney@redhat.com>, Fabio Estevam <festevam@gmail.com>, Maxime Ripard <mripard@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Date: Thu, 24 Jul 2025 15:16:11 -0700
Message-ID: <175339537191.3513.15784417576198098141@lazor>
User-Agent: alot/0.11

Quoting Brian Masney (2025-07-10 14:10:34)
> This driver implements both the determine_rate() and round_rate() clk
> ops, and the round_rate() clk ops is deprecated. When both are defined,
> clk_core_determine_round_nolock() from the clk core will only use the
> determine_rate() clk ops, so let's remove the round_rate() clk ops since
> it's unused.
>=20
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Applied to clk-next

