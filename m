Return-Path: <linux-kernel+bounces-850258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A74BD25D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 482F34EFAEA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67192FDC41;
	Mon, 13 Oct 2025 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kwCIXgDc"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E25142E83;
	Mon, 13 Oct 2025 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348905; cv=none; b=p4oPuRMoqVPBs9yWWqs6ocXj/9rsrpzt/Ipnp/AGDtNDPUaFNq1hqSQgNM3q62SVqVP6e/my7OpLub/t4KO+KMo097k+0OyQggHcGJrbLUNFKDL11dROEJCZaRRcqYaPANW82lb7y/5wLxyglTsf1ZZcgJ7a8OattKAS9tPTqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348905; c=relaxed/simple;
	bh=JOvjW/lfUeuYYIXnwJ056RTGV0z63bXinyG8mV+KbQo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dfMzIWTluhunCgEEQAnTeOF38Hv1gRki96qkPK0ZdDfA0JjFPU80ICWp7hWzuUhynXRoqvZPzB/noEsKiUXxxQaAX8JMA3SahaggGjpsP1Rr1+2qgJUC8QqH8zBJxljQjEfsuNatdWhP1ouSehrR6DQJymrKj6CqlosEdOJA8GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kwCIXgDc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760348900;
	bh=JOvjW/lfUeuYYIXnwJ056RTGV0z63bXinyG8mV+KbQo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kwCIXgDcdXFWuWbKgvg6bN9nqe7wcQ7VRVgqehMENXgkMlvPH7G2X0o/0+1sj0NUm
	 M5SFgxvflc5U+j1qQOvqoy8Edug48cq+zqx6HTpx+Zs9JUWFN/eAHiqnl74gj0r0Qw
	 HnwWNv4vYp9q5TX3YYJqA04ehxX/rQ/9QVXnKHOdPNKIOAv3Wp00hSr2y7sEwmPY15
	 3XTeldB0cROPEVdREos9J4lT7iDAT0xmq3bCPUmDjaWh6oFt/b8e2G+HU0mnvYm1u+
	 81hr6bgXvfIriNGXgq7Sqb2ESoyEoMpVt3MFrZ9PliG4ln33b7j9WGboV89muaNYsm
	 +S6Nx6ZU8mYAg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 027FD17E1292;
	Mon, 13 Oct 2025 11:48:19 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>, 
 Cristian Cozzolino <cristian_ci@protonmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 phone-devel@vger.kernel.org
In-Reply-To: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
References: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
Subject: Re: (subset) [PATCH 00/10] ARM: Add support for yarisxl mt6582
 board
Message-Id: <176034889996.23450.1397548842527992486.b4-ty@collabora.com>
Date: Mon, 13 Oct 2025 11:48:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Sat, 20 Sep 2025 20:23:25 +0200, Cristian Cozzolino wrote:
> This series adds support for Alcatel Pop C7 (OT-7041D) smartphone
> board, named yarisxl, based on MT6582 SoC. It also includes some
> preliminary patches. More in detail:
> - patches 1 and 2 add support for mt6582 to platform code
>   (verified by looking at generic mt6582 downstream source code)
> - patches 3-6 do some maintenance work to mt6582.dtsi
>   (I was unsure if squashing timer node patches into one)
> - patches 7 and 8 add devicetree and dt-bindings support for yarisxl
> 
> [...]

Applied to v6.18-next/dts32, thanks!

[03/10] ARM: dts: mediatek: mt6582: move MMIO devices under soc node
        commit: 1e955255a8eebcf93f0b399cb46c8947e648c0d6
[04/10] ARM: dts: mediatek: mt6582: sort nodes and properties
        commit: e898d7a2e2aa60c680227ef67a536f5a48d9776a
[05/10] ARM: dts: mediatek: mt6582: remove compatible property from root node
        commit: 5f3204e33a00fe7ab652c0eb57becc8ad58e7f29
[06/10] ARM: dts: mediatek: mt6582: add mt6582 compatible to timer
        commit: f6b85f1cec503aadc2b260c7648a09433897df1f
[07/10] ARM: dts: mediatek: mt6582: add clock-names property to uart nodes
        commit: a97a57c68d3d02510e826d41bf2e49c6f7e515b6
[08/10] ARM: dts: mediatek: mt6582: add enable-method property to cpus
        commit: 246475ee9ba806a4268cd2abb40cb63990b05a6d
[09/10] dt-bindings: arm: mediatek: Add MT6582 yarisxl
        commit: 10dee355bdc1a8409babc71e5aa36c7d7f995910
[10/10] ARM: dts: mediatek: add basic support for Alcatel yarisxl board
        commit: 12fd34e32d5d0b7c276eec83b575c21a5cc12485

Cheers,
Angelo



