Return-Path: <linux-kernel+bounces-773885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3DEB2ABA4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820E9A02D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A5335A2B3;
	Mon, 18 Aug 2025 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CWUCt99W"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0C135A2A8;
	Mon, 18 Aug 2025 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755528367; cv=none; b=uZ5sow1frH48OZYxphf87Cqnn4hagJ+Y+MGcs+djgsYscwNQjFTplQ17lUoyXBtOCqxhW2LvaKIVLvATNwOGVV1KIcvYXw07VABt8Zzv1SfB85ZQiFCFqAkLduM/+/HDUSaMsQM1QJ5+2HceaTdSRNx7jNskeL1wNoizUg9VW6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755528367; c=relaxed/simple;
	bh=7rQ3D14RTk6pxe/RhLA11y9SCI/DEYZCqlJPnFIrRSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xm5KXmeVJGmu9PfpDj6sU5gOelOsLu0i6rlAI0LTO2dzsBGEMm1meh9doFFcsNlz8/31WsisYhzBaP3BQWtYFt38ZhfIpScsqH6KZW+nAwojCpsAzaco4gXNd0+UEHTRXwz93fWD5jSRPcEcITRfWKnjSCD7V7Fq7lLkpNaxUv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=CWUCt99W; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c5Frn1Pqlz9sbW;
	Mon, 18 Aug 2025 16:46:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1755528361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=prisHkZFsumBlISEjbp86v+p5Me4Xe1CO3z5hU1zoUg=;
	b=CWUCt99WERkMWk6G4EDiKPbKhhUHoWRRiDS6bNYPIA48IbBh7ljN7V+MRXGONqDOmm8iWs
	va+rGc/LuOiHIKMkLLdfC/GC/tPGrqihjB+S8IIUGfk+pbzQ8l99vHzXmXsBDz+LpGtr1o
	4t417sis4XnbF+XsS6JyespaleWdP1K6U96upKz60zufD21H0/S5J+Ztg+Ox6XxnCv/ewk
	YKK5EluLM1TqY3eHojWBsXUW9dqOC5+EB4OvAx3aoOnJ5fj2RIHOvYT+TPVZmkvI0Khi8v
	bl4YSjppcx+xz+l5OtXLlodJ9nfi5JeuHtAN1mDS+hOGNH3/AhxZ9tMNd69Pig==
Message-ID: <388e6f81-383b-4b39-9b75-8d2cdbf95d37@mailbox.org>
Date: Mon, 18 Aug 2025 16:45:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] arm: dts: stm32: Drop redundant status=okay
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@dh-electronics.com
References: <20250818143730.244379-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250818143730.244379-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: coqxxm9yzunxshdnea793g9zi1nidobq
X-MBO-RS-ID: 7fe8b2a187d2927442a

On 8/18/25 4:37 PM, Krzysztof Kozlowski wrote:
> Device nodes are enabled by default, so remove confusing or duplicated
> enabling of few nodes.  No practical impact, verified with dtx_diff.
I assume the "no practical impact" means DTs are identical before/after 
this patch ? If yes,

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Thanks !

