Return-Path: <linux-kernel+bounces-775791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F837B2C4E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89FB189D3D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4176E33CEA0;
	Tue, 19 Aug 2025 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpTlbwPj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE12C2375
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608998; cv=none; b=Ib2N2iUKhD0Jhj3Bey+yUMUkqdxCaFew9fI4Does11E3KP3OG3qNDszhgyiXSGfql3k7XjVRuEXzPLpDIHYueLcYzY7MRorCwOgcCxWnKupeG5yZfoJHJ91wx+ShS+fojK4PVEV9k0ph74S1LkgiObTvnYXLbmbFubKZkRM/sSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608998; c=relaxed/simple;
	bh=E1BLflhyQ7I1LUYGycth1dtZtOlNawl3tkX+hNmK0Ds=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=dlzuUjfOBM8I5dVD2iHj7h0qsqu1YXddjoYCMG5UhNMLwv7rvlf8VDPgmAVEHV/gDkbX0sQhM9DZzOyXLYrDhWdMEkWNgmUNG+kO6m6YqwV5XVAMCEYAfhO/8VnIlD4FQfPx1Jb4gDzfHi7f/2QxCTaMLxhRW0wRG/7NqS8ApGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpTlbwPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE989C4CEF1;
	Tue, 19 Aug 2025 13:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755608998;
	bh=E1BLflhyQ7I1LUYGycth1dtZtOlNawl3tkX+hNmK0Ds=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=RpTlbwPjd2AfZzq1dNUXOkwVyn2rjFHjB++s9KXafqnqPBfrq22M9J8l8/Na6KF/H
	 Vkdz9HIqZY1VoNCv2dBIgEKPVDHFMQ4lBIb7MbD2nqomuEH22YgKYbnT9sciVwmqmc
	 6g5QnR+L9N/qdrT2hTgQ3ghkNDllfFDt38f9nhXMsiAU14pKYcdR/oFqZLEDIQZ+5l
	 DH675kdKYlFEKkbQ2BCEwGMxzgkjfYJYRWIO4X7iZ7GHwmaQGCF1FriTNiRoSjYwjI
	 WCYTcAHdrp+Al4v2eueHybxPnIkpQ9RCU50mP5tSfmdUzU4ABr5IEJp/eVZ9oslY8C
	 FcTgVEcfTiu/A==
Date: Tue, 19 Aug 2025 08:09:57 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org
To: Heiko Stuebner <heiko@sntech.de>
In-Reply-To: <20250818185337.2584590-1-heiko@sntech.de>
References: <20250818185337.2584590-1-heiko@sntech.de>
Message-Id: <175560761476.43549.1950103149360296253.robh@kernel.org>
Subject: Re: [PATCH 0/2] Describe the nvmem provided by the Qnap MCU


On Mon, 18 Aug 2025 20:53:35 +0200, Heiko Stuebner wrote:
> Describe the nvmem-cells found inside the MCU of Qnap RK3568-based NAS
> devices. And move the cpu thermal node to its correct position.
> 
> 
> Heiko Stuebner (2):
>   arm64: dts: rockchip: move cpu_thermal node to the correct position
>   arm64: dts: rockchip: describe mcu eeprom cells on rk3568-ts433
> 
>  .../boot/dts/rockchip/rk3568-qnap-ts433.dts   | 158 ++++++++++++------
>  1 file changed, 110 insertions(+), 48 deletions(-)
> 
> --
> 2.47.2
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/next-20250818 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for 20250818185337.2584590-1-heiko@sntech.de:

arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dtb: mcu (qnap,ts433-mcu): 'nvmem-layout' does not match any of the regexes: '^fan-[0-9]+$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/mfd/qnap,ts433-mcu.yaml#






