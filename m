Return-Path: <linux-kernel+bounces-853676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22932BDC4A7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370AD3B1864
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A87721FF49;
	Wed, 15 Oct 2025 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3Ml9HFD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9E41A275;
	Wed, 15 Oct 2025 03:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760498193; cv=none; b=uPW/QhUx3hsO1+GQWA1a790uHkeS9HRpk9crbuh0qt7Efl8uYMCxZtZsZPE+JdmiBFMFkycSLiuJVgewPiLlVkCd1qUHqOwowG/0f4FM2ldk2Lu+MWliE+hr6yd5sA9RScsbEXTeBodaJwq6QiVVT+W3Eukm1xOsN+2KTv5rLPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760498193; c=relaxed/simple;
	bh=1Z6u0zAfBh19heJJDRjMx0iEQGavaROyDfEam59PDT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LO2frs6Yc2szBpIN33KCWZYKQBVcxt3LYcvzy0NUhdWYS+qmr4ZWyqORmzMDMY0EucLGq+6gaurH96VtKLXfqN4NtHkUGZ+vKobbpm5GwLHLWJJc5eDsQGAme06Oii3dcXWhV1vFQhCpyTzwMa4dPC8b7PaSvtQwQ7r2zKeIhPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3Ml9HFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36D9C4CEE7;
	Wed, 15 Oct 2025 03:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760498191;
	bh=1Z6u0zAfBh19heJJDRjMx0iEQGavaROyDfEam59PDT4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Q3Ml9HFDmUygmKkbeV5adBuTkGlp6vwQt0UsJp3PT3Wmx1G+q0trXrLWUW8hvfYQe
	 pkYpzRujptCeClL6F72jlaQIBsiESgsc9FxsfRy4WCvNClrNsy8WxfAXPDRiE0kDDX
	 gIL5IjtwPnNjr6N2Mf8xyomZp0x7H71RzXnptBAmLd6RNxOM87cArj4NmfLQUzRlx+
	 593HiE2pozzrZ5T/PyoHF/nfAG06+ctGcK+VRXWzc2hl0jYHevKbHBMpQMUAI92vDD
	 HxyK+8ebOwByfT6DxhX7nIH6A2JipO1SA3JhmUuCDkh14YfJWZBpuAMeIJk1AzVV2Y
	 pZAqe6QooP4aw==
Message-ID: <f7fed8a4-8111-472e-906b-be02cc7c40a5@kernel.org>
Date: Tue, 14 Oct 2025 22:16:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: agilex5: Add GMAC0 node for NAND daughter
 card
To: Boon Khai Ng <boon.khai.ng@altera.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-drivers-review <linux-drivers-review@altera.com>
References: <20251014024805.25579-1-boon.khai.ng@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20251014024805.25579-1-boon.khai.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/13/25 21:48, Boon Khai Ng wrote:
> Enable the GMAC0 node for the Agilex5 device when using the NAND
> daughter card.
> 
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> ---
>   .../dts/intel/socfpga_agilex5_socdk_nand.dts   | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_nand.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_nand.dts
> index 38a582ef86b4..ec4541d44c9b 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_nand.dts
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_nand.dts
> @@ -10,6 +10,7 @@ / {

Applied!

Thanks,
Dinh

