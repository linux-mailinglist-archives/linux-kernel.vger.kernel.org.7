Return-Path: <linux-kernel+bounces-737755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59249B0B028
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 15:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23AF3A80AD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 13:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AFA15278E;
	Sat, 19 Jul 2025 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZX/JGwO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633872629C;
	Sat, 19 Jul 2025 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752930316; cv=none; b=p83X2NN9NFvrIjQEAlg0DZlgN3vwFICPF4wHeL/jbrvF8YXha14kJ5Xx7AU+CbGrRVV+mLLpgRQWO2RmKZYRq3RKLRsIDuezbDrH5gBDKuPphqkSvJFtFBUrL6GBIWB3z48a+UZVFgMWnC+sXOf0IWTuGIbXFIQBrJK9Z0+/Y8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752930316; c=relaxed/simple;
	bh=v2lHPjZPKgeXJcLAgsu2mcNkm2hNRJJ4aWcXRC80BmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBreAwUxI5lmz/HRJ+tu+BzNcgYw4wd2wA7HQMsQD3363MVWVDgXD2qmdbpwGADgUpzr89lUedg2/ShARmRCzk3TiQNqi7KrReyLc7pNezp3b6Dr6mi1gjL9f31E0iG0epn1Ky6BDiZaieE+YqL0XUsASmRv+fKGnUAfrhLutak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZX/JGwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2D6C4CEE3;
	Sat, 19 Jul 2025 13:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752930315;
	bh=v2lHPjZPKgeXJcLAgsu2mcNkm2hNRJJ4aWcXRC80BmY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FZX/JGwOvv8QNFAy76R+hFqnrT4CLCu390CTjjAGnE4SNiR7oR/HWbx5csBUskcJW
	 EstRTwfIrB+9cfAsn9KDJHr4E+p9lTdpzzK9nAB71+B8EwUi0mB+OPyDnv4QJvcwKw
	 DjDri39K8ormqkcfjF+W2nh0Iejjwuk51zXvp/T0t6PuQlmfaHuz05J0PWKeQuVyfO
	 H0XTEwgEj0yZKACT0kzVjT+8Ybc9y70yg5nLUQgyLQ6Izgs6cqpbq02eY6m1/PAHwz
	 BXxXye3MyHgQhzq+kCNeKv29Q2NLLgi1ixw7kqy630zAj6Mat83tMPLwXjyTwpCEUe
	 IGd8CXVQ1BKwA==
Message-ID: <75db9390-273f-4277-8ef8-dab9f779418e@kernel.org>
Date: Sat, 19 Jul 2025 15:05:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: spmi: Add Apple A11 and T2 compatible
To: Nick Chan <towinchenmi@gmail.com>, Stephen Boyd <sboyd@kernel.org>
Cc: asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Janne Grunau <j@jannau.net>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Sasha Finkelstein <fnkl.kernel@gmail.com>,
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20250609-t8015-spmi-v1-0-b3c55ad01491@gmail.com>
 <20250609-t8015-spmi-v1-1-b3c55ad01491@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250609-t8015-spmi-v1-1-b3c55ad01491@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.06.25 16:59, Nick Chan wrote:
> The SPMI bus found on Apple A11 and T2 SoCs are compatible with the
> existing driver so add their compatibles.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>   Documentation/devicetree/bindings/spmi/apple,spmi.yaml | 2 ++
>   1 file changed, 2 insertions(+)
> 

Hi Stephen,

I think the dt-binding change adding the new compatibles should usually 
go through your tree.

I can also pick it up if you want to otherwise together with the rest of 
the dts changes.


Thanks,


Sven


