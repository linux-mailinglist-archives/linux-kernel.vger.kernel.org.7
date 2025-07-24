Return-Path: <linux-kernel+bounces-744963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDFDB11303
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CEC25A212B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6421C2EE5ED;
	Thu, 24 Jul 2025 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEd9Zfdy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF0626C383;
	Thu, 24 Jul 2025 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753392158; cv=none; b=lXQ73gLT3gB91NE2wfGMPd3DulpcZ7mQ5s0q+PXi7k/e/19vxSrkd/mGLkAeXnbiZdcuxMaT4bz3XOzcV5BzCiIShCVUaV+uanlK8DKLaE3ElQMwY1bGCG4OS/cDbdnls4s5wXnbbn8y+/ILBwxIHBoBw/oNCRLmS1kPwDXwcRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753392158; c=relaxed/simple;
	bh=NV1hvyxJKKzHIHZJgLDzRN+VIKp6B6Xs0+8rC4DRIDE=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=hWSuO1Ug9dyoLtEXBAW0yT53ubQWjjNVAwF60gpVuSwmX//AuYWb6SSnxMkNtc4CPYLjPKg4glIgTBiQPCXUT7iOtsyp/yuWmYXnZCpKf7/e+VFD+b75e0qlIPyPZORxsZDCALnZzQ0haKxjkCMpmPxcYrwc/OF9NuiamQiXvss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEd9Zfdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC00C4CEED;
	Thu, 24 Jul 2025 21:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753392158;
	bh=NV1hvyxJKKzHIHZJgLDzRN+VIKp6B6Xs0+8rC4DRIDE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=sEd9ZfdyJQTyCzKPnuPMCpoxHqB5c9+FRjFP2oBBQpVfQYU0Bt6HM+EDyYQEaPmvK
	 rMcTRyDOXrjMRE1DUe5/JU7o2atRbIOLzuFZ14KoXEoit5S6hF5tgOv+taUhuLzLvw
	 hyQbOhQb7tkafsmqyNBnLl2EIM2CeQ3LLR5tbIojaL55eS0zkMv3jIpvq9vbXlOGid
	 EiJwofk81/NKmKqxIM9ZC/AlALe3dZALRpAqaVYxqB9J+FPCEoxFLAeILBOwE8+Psi
	 TW3Lk/7iLL05cN/g4avOf5AMUjyyR6F70t/P7IRSNAtPEH+DJJjeODGRlrBeTRlQf4
	 k3G1db2u0lSLA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250630232625.3700213-1-robh@kernel.org>
References: <20250630232625.3700213-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: Convert qca,ath79-pll to DT schema
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Alban Bedel <albeu@free.fr>, Antony Pavlov <antonynpavlov@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring (Arm) <robh@kernel.org>
Date: Thu, 24 Jul 2025 14:22:37 -0700
Message-ID: <175339215777.3513.3466941664741809283@lazor>
User-Agent: alot/0.11

Quoting Rob Herring (Arm) (2025-06-30 16:26:24)
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied to clk-next

