Return-Path: <linux-kernel+bounces-815115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2179EB55FF0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 11:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49662AA054F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 09:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0777D2E8B90;
	Sat, 13 Sep 2025 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjvqPnzq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB353B186;
	Sat, 13 Sep 2025 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757755820; cv=none; b=F3Scj5xZEMTENqoi/oio0jnoEQV2lxdR3hiI2rap64n/sxyLDNfvTZuQA84uH3/g5GoJ6CLY3FGe6UwSpsxMAoH4/D6WjwzQu6PQtjC84lgclXFPMHV6xXwr+7lP3ibCA9yNPHmwmSqreolqIek9pd3lu/5pJn0FEFbUtlkDnJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757755820; c=relaxed/simple;
	bh=c12/xNUXslNQin2axApjPv7ljtSkh0GTCsEFL44BFio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZMX51F+BFoNOYGtPokYFCo2e5jvKi3v/OtpEBsDUE0/X8xWiH9PxI3sl2mTGPPA74zlyQQSGLLXurq6drttFHiZVkfoj8cVm6xCc5+u4XEmbqKrMiDP9kBlINcweXXib1BZpj6XixA6V8lhSgN+AEbKvy+OYmxerwMC1MGxxlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjvqPnzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3766C4CEEB;
	Sat, 13 Sep 2025 09:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757755820;
	bh=c12/xNUXslNQin2axApjPv7ljtSkh0GTCsEFL44BFio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjvqPnzqsYnWNxyxRDIBh+NQRy7Qf3VKRmVD4aWDVkjjK3X2qgB0ociCTcXT7rRE6
	 KfyVY9CT/R53w5AbTPrvFD6V+X7BNzx6nA8630xM3lyo8BOak1vIoZ7am0QF8RKhOs
	 YcRJqaB/bFH3UuSVFOUszO9gxEu6jkHslv5dqfv0khkLOnOaSQlAHXStkj0rNlV1wq
	 rA2ezBsW7mDqHW1IPxDgNFl9oqv6vAp+GhPcd+HnrE3KU/CpvrvJZjkj57WajF+u01
	 iA95YWsidRyYVZrbjeQ3EGCSG1VJKBgAdFMQJxUtrJQ+unTyhnye6JG0AaPKbqlKrF
	 b0eH7QGVeY3OA==
Received: by wens.tw (Postfix, from userid 1000)
	id 7C2145FC8D; Sat, 13 Sep 2025 17:30:17 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Maxime Ripard <mripard@kernel.org>,
	Lukas Schmid <lukas.schmid@netcube.li>
Cc: Chen-Yu Tsai <wens@csie.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 0/5] Add support for NetCube Systems Nagami SoM and its carrier boards
Date: Sat, 13 Sep 2025 17:30:16 +0800
Message-Id: <175775572870.3891284.1456456718289976149.b4-ty@csie.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250831162536.2380589-1-lukas.schmid@netcube.li>
References: <20250831162536.2380589-1-lukas.schmid@netcube.li>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

On Sun, 31 Aug 2025 18:25:29 +0200, Lukas Schmid wrote:
> This series adds support for the NetCube Systems Nagami SoM and its
> associated carrier boards, the Nagami Basic Carrier and the Nagami Keypad
> Carrier.
> 
> Changes in v8:
>   - Use a gpio-mux instead of the gpio-hog for the USB0_SEC_EN signal
>   - Fix the dt-schema issues
> 
> [...]

Applied to sunxi/dt-for-6.18 in local tree, thanks!

[1/5] dt-bindings: arm: sunxi: Add NetCube Systems Nagami SoM and carrier board bindings
      commit: db5796c5c5c6db72339e818b54e6a2e043f7032c
[2/5] riscv: dts: allwinner: d1s-t113: Add pinctrl's required by NetCube Systems Nagami SoM
      commit: cbce6d5326b116f55dc29f7fc0a7d56a9a03d9e5
[3/5] ARM: dts: sunxi: add support for NetCube Systems Nagami SoM
      commit: cba2febbd6465aabdff157fb95b1c07d090af1f0
[4/5] ARM: dts: sunxi: add support for NetCube Systems Nagami Basic Carrier
      commit: e36d4d54eefb60144666b27754007e1c0dd0a581
[5/5] ARM: dts: sunxi: add support for NetCube Systems Nagami Keypad Carrier
      commit: caffed0800ef4dd29cc29ee17a89d015e867e03a

Note that there were some cases in the device tree files where lines were
indented more than necessary, like for gpio-line-names and the board level
fallback compatible string. Wrapped lines for lists of items should align
with the first item on the first line.


Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>

