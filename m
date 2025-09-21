Return-Path: <linux-kernel+bounces-826352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4107B8E481
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BAB189B84F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324C526E708;
	Sun, 21 Sep 2025 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyX2XELJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799EB26E710;
	Sun, 21 Sep 2025 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758484261; cv=none; b=BeNXFAQqS4YDqwkE/IcGaIUNNl+wjI7h4rZr5FWBXUQpc59DD/aWmLuIje9Jb0rRZdsklvlXv0WqJ6P1yAEWHHdTiB2FeC9GkUXiW5j931zeSHO+pZCre5c3/4EmkWtG4lIMddfIPPe+YYDpMUnvG4CO29XcLl3UGnMekLNqo3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758484261; c=relaxed/simple;
	bh=Ktbhbbw6P7I40jvmJGm8sst1UUSzjrMoDRrHXi/7018=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=I5rJTm3UOZSrwm5uThQ1CPr8n1T6+dQ3Qkgs0ZnGOkleqjhlHp1J346zpZMOz7/bWyl8y9LMmP/1m3epLsaVn+UuQLZgwNUuRQrAtxbGQd4xq3BwUo+TasNGe6Q7uU09TWtJv77w+hBvGdkxTWIj/DUTwvBwPvDyz+FBKs2gV8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyX2XELJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E47C4CEE7;
	Sun, 21 Sep 2025 19:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758484261;
	bh=Ktbhbbw6P7I40jvmJGm8sst1UUSzjrMoDRrHXi/7018=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=gyX2XELJOdYKhlx82RNTbTthXB+UbykXNeI2+rVg0CICyDmitGUDp5D1ePNGv2zvE
	 kVNMvSvmDWtCdErruCW7OVye6NBd4cxg4HU9f7xCF1cxWUNDwaWHyugqCTXjOpabrq
	 S79y+ioXPW3xOnaayJJSOwMLKI5Zc6L3dDsWuXC1crMZ/W1dYWV97DJI4eCzvSp3m7
	 r7cIQ9F6lpbbigcIIIyzrheAsm5qiaRYYEhf/qUXLfwL4rFupLrvVfOLmO9SuEANNp
	 9lDlDhNEdGQc0lt965AMtFTNxRq3+0uvyTW9k86eI2V4flE4du70HCgq1xR+t/s48c
	 7KppWOC9XBFxw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250919142649.58859-7-ziyao@disroot.org>
References: <20250919142649.58859-1-ziyao@disroot.org> <20250919142649.58859-7-ziyao@disroot.org>
Subject: Re: [PATCH v4 6/8] clk: loongson2: Add clock definitions for Loongson-2K0300 SoC
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, Yao Zi <ziyao@disroot.org>
To: Conor Dooley <conor+dt@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Yao Zi <ziyao@disroot.org>, Yinbo Zhu <zhuyinbo@loongson.cn>
Date: Sun, 21 Sep 2025 12:50:59 -0700
Message-ID: <175848425977.4354.17680776767445912980@lazor>
User-Agent: alot/0.11

Quoting Yao Zi (2025-09-19 07:26:47)
> The clock controller of Loongson-2K0300 consists of three PLLs, requires
> an 120MHz external reference clock to function, and generates clocks in
> various frequencies for SoC peripherals.
>=20
> Clock definitions for previous SoC generations could be reused for most
> clock hardwares. There're two gates marked as critical, clk_node_gate
> and clk_boot_gate, which supply the CPU cores and the system
> configuration bus. Disabling them leads to a SoC hang.
>=20
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---

Applied to clk-next

