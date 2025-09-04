Return-Path: <linux-kernel+bounces-800897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D70B43D75
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538AD7C2A8F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B166E304971;
	Thu,  4 Sep 2025 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="CNiHXeS1";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="CNiHXeS1"
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830B614AA9;
	Thu,  4 Sep 2025 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993361; cv=none; b=hkvEb4DIIRLxUIfrGCqLaJYMfDHJI/w2GjYCatWBCXBFXQeWX4t1iNardBbCKAS32ZQReYqo59wsEdK+fNXY2/J067CBc4/PEuj9SwUm6KxqSe6/LhY3f+fUGJLRIEdTZv6Bdh5kYA0TWhh0sHLMM0si5MIT4+BlDtxwQf6j3yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993361; c=relaxed/simple;
	bh=B9a9wo6oepcTyW30agfxF4Sjx593rtVckWJYfpXHpeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=J+asyRJN+Los+MLi8Zi7cfir2/Rn3hDHd1FS0zLfksQu1Pq2v+5BdsMmrLq4j6fh99WqkTgLzqy0f80WChGwwoOaY6GYHCGKKvs9XimhsQ9YW/9AOweGKZrHkhHz5Nu2H4acFN5PR4wTydqG+UiTvR738SQRB5YE2uNzAqFktI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=CNiHXeS1; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=CNiHXeS1; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1756992944; bh=B9a9wo6oepcTyW30agfxF4Sjx593rtVckWJYfpXHpeM=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=CNiHXeS1qxRRhlrs8yZoC91F4n7vsZoBpZ+lnsIqhOFY9EQk9moNVZdk54TeX0ykK
	 bTLWTailgirVuzqNrjb8tudlxHEiS2OHREugW1qu404UZLuUWeX+ihjwMPIIV82WiC
	 QMAL/OUkVUtox08lYutlio7Hy72yr6Hf4eebMp11Lw1GJTSpAUlQWt0Gp6vYxhmHav
	 GpB8uzBX+TPocpviT24cdXfIzFAheeUS9f2bF+F13d/5mSYtr9jM5IWEJ/KqFRvQKw
	 J+XamfD/EypOtNGQqydP06oS1judL9LGGZumOyUX64h7XjK0Pi/xG3db7Wc9i8XHhr
	 /eWGHfgphSEeg==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 974D23D1F86;
	Thu,  4 Sep 2025 13:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1756992944; bh=B9a9wo6oepcTyW30agfxF4Sjx593rtVckWJYfpXHpeM=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=CNiHXeS1qxRRhlrs8yZoC91F4n7vsZoBpZ+lnsIqhOFY9EQk9moNVZdk54TeX0ykK
	 bTLWTailgirVuzqNrjb8tudlxHEiS2OHREugW1qu404UZLuUWeX+ihjwMPIIV82WiC
	 QMAL/OUkVUtox08lYutlio7Hy72yr6Hf4eebMp11Lw1GJTSpAUlQWt0Gp6vYxhmHav
	 GpB8uzBX+TPocpviT24cdXfIzFAheeUS9f2bF+F13d/5mSYtr9jM5IWEJ/KqFRvQKw
	 J+XamfD/EypOtNGQqydP06oS1judL9LGGZumOyUX64h7XjK0Pi/xG3db7Wc9i8XHhr
	 /eWGHfgphSEeg==
Message-ID: <147ba109-684e-4490-887a-54f7efae1d03@mleia.com>
Date: Thu, 4 Sep 2025 16:35:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] ARM: dts: nxp: clean lpc18xx DTB check warning
To: Frank Li <Frank.li@nxp.com>, Arnd Bergmann <arnd@arndb.de>
References: <20250706-lpc18xxx_dts-v1-0-7ae8cdfe8d7d@nxp.com>
 <aKiCIZf0eG2F0nvr@lizhi-Precision-Tower-5810>
Cc: Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <aKiCIZf0eG2F0nvr@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20250904_133544_638941_E41EFE75 
X-CRM114-Status: UNSURE (   8.42  )
X-CRM114-Notice: Please train this message. 

Hi Frank,

On 8/22/25 17:43, Frank Li wrote:
> On Sun, Jul 06, 2025 at 02:46:56PM -0400, Frank Li via B4 Relay wrote:
>> There are 3 dt-binding patch wait for pick.
>> [1] https://lore.kernel.org/imx/20250617-hound-of-improbable-intensity-e7c3c9@kuoka/
>> [2] https://lore.kernel.org/imx/174916907717.3619367.3745642154654809311.robh@kernel.org/
>> [3] https://lore.kernel.org/imx/175087864578.2055525.4510390315154712025.robh@kernel.org/
>>
>> lpc18xx related DTB warnings reduce to 0.
> 
> Vladimir Zapolskiy and arnd:
> 
> 	I asked shawn, these are not owned by him.
> 
> 	who will pickup these patches?

I'll do it.

I'm preparing a few more changes for LPC32xx also, and I will send a PR for v6.18.

-- 
Best wishes,
Vladimir

