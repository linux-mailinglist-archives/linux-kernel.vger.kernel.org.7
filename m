Return-Path: <linux-kernel+bounces-885990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7CEC34751
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ECA9834B26B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015A92AE89;
	Wed,  5 Nov 2025 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeJ76ljx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EDC28C862;
	Wed,  5 Nov 2025 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331158; cv=none; b=BxKJ6uqq6rDI7DcLUbVkQSU0quOGq2bxnGUARqyT8wkDlvlL/Gy1loAhUDLKkYqE8eCq3OGYMySdfMC6GMW52srEUr42iU6AiEHTqm1EiGr9/YBgfHV9/ubmOaZOdHN1Zc/ZQYiXdd4c1VrJY0zQME324u0zAN+GoCVg3VtORy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331158; c=relaxed/simple;
	bh=nlPjpaz78z3emvBWlpz8P0lii6HwBSqHyYjhMp7EIEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrKfB/CYDMrQkw3yAdW9m+FrmpdnsNDpIxO/qvQRt6Ofe5xOyKDFcRhmEKjXtnFWbzedp6CBsGgrFcQKVNMy0YAEnu8AbFF1G4XaBIWmlO2yJFgCe2z9fnp5V2RkxiTTSBYYguXBmtA3Iz3XVdsmPWLn+V2zMZGaoLCB4gyY+oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeJ76ljx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3D9C4CEF8;
	Wed,  5 Nov 2025 08:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762331157;
	bh=nlPjpaz78z3emvBWlpz8P0lii6HwBSqHyYjhMp7EIEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MeJ76ljxbLe8mcc84GzKuMVkTzOkfUbXDl6nJxzREknMN2w3V8/2IOBpFDzcZF4JD
	 1+Gy//XLgeOW3KZNRmkWVB5pPw4n6OFHEfy0HUFjN/q+CAQbrxhzP/3b1g1X/QHeSK
	 iygTDYdVdBzpTlDPpV3fsUfY3LC+sQTJK28xqnknv0ZojNzOXG0ax0cfviGoPg8imR
	 4jOxjidlKeMVUi9oIwuM7ObMJjMDwRMvaV4XyRdvSg1ywOfwU5dQv5eBbizcVTXLEa
	 Lo7J7uUS1uqccZl5DnCuXEmJo0fK0WFvh0jZaW5Dwr3cB4YbvAV2tkB35ORLjlgjPc
	 y4x/A+aDE7TKg==
Date: Wed, 5 Nov 2025 09:25:55 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mahesh Rao <mahesh.rao@altera.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>, Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: Re: [PATCH v5 2/2] arm64: dts: intel: Add Agilex5 SVC node with
 memory region
Message-ID: <20251105-flying-asp-of-poetry-cd9d2e@kuoka>
References: <cover.1762308672.git.khairul.anuar.romli@altera.com>
 <bfd2d5999306c019dab8a157f122bf842a43fc6b.1762308672.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfd2d5999306c019dab8a157f122bf842a43fc6b.1762308672.git.khairul.anuar.romli@altera.com>

On Wed, Nov 05, 2025 at 10:28:02AM +0800, Khairul Anuar Romli wrote:
> Introduce the Stratix10 SoC Service Layer (SVC) node for Agilex5 SoCs. This
> node includes the compatible string "intel,agilex5-svc" and references a
> reserved memory region used for communication with the Secure Device
> Manager (SDM).
> 
> Agilex5 introduces changes in how reserved memory is mapped and accessed
> compared to previous SoC generations, particularly with the addition of
> IOMMU support. Unlike earlier platforms, Agilex5 enables the use of the
> Translation Buffer Unit (TBU) in non-secure mode, allowing Linux to access
> it through the IOMMU framework. This commit updates the device tree
> structure to support Agilex5-specific handling of the SVC interface,
> including the necessary bindings for IOMMU integration.
> 
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---
> Changes in v5:
> 	- No change.
> Changes in v4:
> 	- Exclude peers reviewers in the sign off.
> Changes in v3:
> 	- include iommu property in svc node.
> 	- Rephrase git commit message to describe iommu presence
> 	  in Agilex5
> Changes in v2:
> 	- Rephrase commit message to exclude mentioning iommu
> ---
>  arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> index a13ccee3c4c3..15284092897e 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> @@ -841,5 +841,14 @@ queue7 {
>  				};
>  			};
>  		};
> +
> +		firmware {

Did you just add node to the end of the file? No. Place it somewhere
after cpus, see DTS coding style.

Another problem that you have here warnings, which tools would tell you.
Please use tools instead of humans, see maintainer soc profiles (both)
for more explanation.

Best regards,
Krzysztof


