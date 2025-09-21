Return-Path: <linux-kernel+bounces-826348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BADB8E460
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F643B131C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40A027602A;
	Sun, 21 Sep 2025 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmvZS9P1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043AC1FE471;
	Sun, 21 Sep 2025 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758484240; cv=none; b=u1J3Ww5ND3ogkvzGA3A3jsFffTK7oFvGM84VA/SkWVQ0gwsjmvuErEaIWYxk6KTzRSc+2FKVdUAu6BdNQ84BVIC0U//mPznHcU0dAKuvE4Sbjqcd7fyhAFwnyd8VD2/iK4lqLpsZifcnb8wR5vz9dSYZ/qcH49fqYdR2ULNTXN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758484240; c=relaxed/simple;
	bh=bUKpAW03/ZpH700OY/Zdcrt1o4y2vStyG2rede9tbzQ=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=Uat7n8TWsydvVpba8Mbu1Hc4AzzFcSfh19beyMPiozxV8KbimUAehbu5FxHWiSMOAxPwx6PiKrKdqaZFgt0neZraDwDC2e3xFQ63RPKNLFn6xWLAw3uQ8jLH29np4FUUwqoLlQ2Ro74mYEFh07e1V1/n2iC/06++/9h9d/9UoIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmvZS9P1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C67C4CEE7;
	Sun, 21 Sep 2025 19:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758484239;
	bh=bUKpAW03/ZpH700OY/Zdcrt1o4y2vStyG2rede9tbzQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=tmvZS9P1XHV3EcRVHV9Nftr+JjCQaq89iX745sDRDXc/0ihtmjQhcM+Os9mtLzMhw
	 u33tc6DtdFgUCp/i1a3STstRLIzMM7OWTKAxsdbOyj7NxIOJ2FlrXzSUqGS7dSlVr4
	 Rpj1I4jdo8AyXOWS97N1EzNg+O1xeB44nZoAE1FbWpujkuEqR/gfDE2JhRauPLaUwJ
	 8uN3eh5TY70lfo9YC7SXsnjszaXqhNSuTMcXAbSVjIj2CUxxASpaEgFKWLwo96OT0M
	 BcnQV8GvjraSXxZ494ScmtQxVJ504dTYK2hZQ97uF4duiYU1Z2FYHYS51KGj4X2CIh
	 O3+AwtkTndQrw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250919142649.58859-3-ziyao@disroot.org>
References: <20250919142649.58859-1-ziyao@disroot.org> <20250919142649.58859-3-ziyao@disroot.org>
Subject: Re: [PATCH v4 2/8] clk: loongson2: Allow specifying clock flags for gate clock
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, Yao Zi <ziyao@disroot.org>
To: Conor Dooley <conor+dt@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Yao Zi <ziyao@disroot.org>, Yinbo Zhu <zhuyinbo@loongson.cn>
Date: Sun, 21 Sep 2025 12:50:38 -0700
Message-ID: <175848423801.4354.2685627863953518281@lazor>
User-Agent: alot/0.11

Quoting Yao Zi (2025-09-19 07:26:43)
> Some gate clocks need to be supplied with flags, e.g., it may be
> required to specify CLK_IS_CRTICAL for CPU clocks.
>=20
> Add a field to loongson2_clk_board_info for representing clock flags,
> and specify it when registering gate clocks. A new helper macro,
> CLK_GATE_FLAGS, is added to simplify definitions.
>=20
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---

Applied to clk-next

