Return-Path: <linux-kernel+bounces-825506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3517B8BFCF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 07:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B433565C6F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 05:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F82239E75;
	Sat, 20 Sep 2025 05:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1DQ2PFV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054D5238C0A;
	Sat, 20 Sep 2025 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758346215; cv=none; b=YjBRjRAtROstBu9nCUH4x/R0hCg+WEFnX5vnNBrd/l15PjIW38uXO2OE5OLcIvNvcvakEOZIr1ONEknkGCmUAeCskgrrAzDS8MR7b28L51cNuw8fb8lGKEwpVS3eBlp+pHRQWAU8xuXYG1O9G8uV4NkycqFUzHJvqKCiHA89hmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758346215; c=relaxed/simple;
	bh=weNzPfhC+Ey9+gNixVm2jHhaY33jbofcYhVPI53LRI0=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=UMZcNiDGhbWcSKCfbScFA7z+0+jz+mF8CoPHyVisY95IwUmkCv7HI55wC/jWNsm2pKClsyRCUul9V5pI8fOIk/1JRafBa3+fcKqQznqpUZokI5G2Fc1UW9XxasDgnqYH3qlBrHbfJZjp1c1BM1Fekl3LTsrBolnj++OSJ/5iC+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1DQ2PFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF68C4CEEB;
	Sat, 20 Sep 2025 05:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758346214;
	bh=weNzPfhC+Ey9+gNixVm2jHhaY33jbofcYhVPI53LRI0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=W1DQ2PFVySTWEL03wF4ZIVp8W6oYcw94CUV6mo+M21PmEOvlwSvqkQrpCatXFPH7d
	 ibd+sxg++iPcd0JsR/MtMEVwXarCFFDISEOd5egOwpbYRs+psQXfouNM/jEVSJ4hR2
	 Wteu7vb2kH/eD3Hl0ZOYSn0YLcqp5FVgr2mL6xkhEWxOw6HR58pQYdOJQAMpRj3xtb
	 KNWjH7XB9WTRucsgBmFkbUVtKtAAcMDqziXN6i73sbYvGqfLJDnwNZ20F5nvo1wPfc
	 W3DpeAiZUH5NJleXiKK3y01N5/7aj475ycMF6OeE8S6vbrI/YVDljPsxx5v3wlC5Q8
	 OlPVTAI3q9Qhg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250916124518.2857524-1-raag.jadav@intel.com>
References: <20250916124518.2857524-1-raag.jadav@intel.com>
Subject: Re: [PATCH v1] clk: keystone: sci-clk: use devm_kmemdup_array()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, andriy.shevchenko@linux.intel.com, Raag Jadav <raag.jadav@intel.com>
To: Raag Jadav <raag.jadav@intel.com>, kristo@kernel.org, mturquette@baylibre.com, nm@ti.com, ssantosh@kernel.org
Date: Fri, 19 Sep 2025 22:30:13 -0700
Message-ID: <175834621335.4354.5487830097403454508@lazor>
User-Agent: alot/0.11

Quoting Raag Jadav (2025-09-16 05:45:18)
> Convert to use devm_kmemdup_array() which is more robust.
>=20
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---

Applied to clk-next

