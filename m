Return-Path: <linux-kernel+bounces-826347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3948FB8E457
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D85417A568
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D6526E71C;
	Sun, 21 Sep 2025 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYW7zuv8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C55E1FE471;
	Sun, 21 Sep 2025 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758484235; cv=none; b=A0sXUVQ9OfZ6KCd07EWeqve/ecZ0sn9WzhllbL2P/JcL+fd+rDAQdJxWzlSLqsdeR4d4U+W2A4xFc/JPVC96Y9SXQD34szs6TZrCK2GEHkr01MICw5ZfOhhi7hlnF1/DkVYBOKWgTwBQkE3e0nTJMfbIGo/K7IufnfUVt39UW7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758484235; c=relaxed/simple;
	bh=bSF2+Hk1yy6ag80W+9NMMTrN6gDfZ0Cv2kfuaUaqDiQ=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=nHksN3M0EfV/0XfHJBd5b69FiU4XRT8mWfiR/1HlYRbP6aKMsJJB9IM3EcqRU2bNwAmqFEgNR7p6fZR77ILaVmYVkymbHEy2aC/JU1HNafSeuBBM3XWi/E1k4GjlAppTAGZ/y6Bzb7IYILz7VB3YWC05oRFiytVis/qpnWqcnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYW7zuv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD818C4CEE7;
	Sun, 21 Sep 2025 19:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758484234;
	bh=bSF2+Hk1yy6ag80W+9NMMTrN6gDfZ0Cv2kfuaUaqDiQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=YYW7zuv8jnypq8Uzjk94jDSPamztLzg9cS317/WBJsq/97enhnhQGRQv03Uz+Li4N
	 sNWH0vbXVA5tq7iNr2LTcbIIdgolVeGSlsLN4vg6zxH7uc2ehUmcX7xgz7OuHO7MRg
	 Jqz/9f/AL4Z0LSe9UjKkJ11a97nGAqT5ArGaXylV+Y/tp15jEWhpAukbrDQ0EDqgEK
	 38rdBB4bjDS6Fgs1/O8DKe0+hhqj/BM/V2umZVWbKkKr3SKKkVxccEi4AKnoq+iyZQ
	 nWAAMkNZts2A7V+CaHzZOvqzOOoDbT5e3HFW1iIok7BcjrKIQ28/U1vQh5/nrBhAxA
	 e8WIQXWs4WqDA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250919142649.58859-2-ziyao@disroot.org>
References: <20250919142649.58859-1-ziyao@disroot.org> <20250919142649.58859-2-ziyao@disroot.org>
Subject: Re: [PATCH v4 1/8] dt-bindings: clock: loongson2: Add Loongson-2K0300 compatible
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, Yao Zi <ziyao@disroot.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Yanteng Si <siyanteng@cqsoftware.com.cn>
To: Conor Dooley <conor+dt@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Yao Zi <ziyao@disroot.org>, Yinbo Zhu <zhuyinbo@loongson.cn>
Date: Sun, 21 Sep 2025 12:50:33 -0700
Message-ID: <175848423305.4354.12821111451867845330@lazor>
User-Agent: alot/0.11

Quoting Yao Zi (2025-09-19 07:26:42)
> Document the clock controller shipped in Loongson-2K0300 SoC, which
> generates various clock signals for SoC peripherals. Differing from
> previous generations of SoCs, LS2K0300 requires a 120MHz external clock
> input.
>=20
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Yanteng Si <siyanteng@cqsoftware.com.cn>
> ---

Applied to clk-next

