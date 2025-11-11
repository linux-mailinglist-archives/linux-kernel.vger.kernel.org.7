Return-Path: <linux-kernel+bounces-895156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4E2C4D116
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86379189CE33
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4A934D4D5;
	Tue, 11 Nov 2025 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGc4qocn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF82834CFBA;
	Tue, 11 Nov 2025 10:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857270; cv=none; b=RtBj9nOHPli/Zzlws1tVaZeMf7R0QB4Y1yZnH7kwQKnIGwC0vwHEABi0TLHSyjg2iuFZhtmTCikFIHZNOzwf0yJCNZ53DouHyrSyW9DGbVrYZOXtiLvEz6LhyFQ7S7/MxDJVBn+VjP/3gxsXU1oTQUKL7lNoL3WcjWtmTjGenvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857270; c=relaxed/simple;
	bh=Dzpt6Z0D/c6MEJOU+LNjhT4k0I4uQhWwRaQj5wYq5TA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ay8tL0v6ubZmwtrcxy2W1xK5B2VH7PLlmbYxC+fp1Jme9pcF1eEg1n0UJy090UA2dy8gkx+dcx/FN3CflnXsw9jLqML9lPZdlF+Bd6/kq11OljqOb5L5RqViRGnikbg/INuNgxnAzPmVB310NqWbnZUmDCcC846g6dqTQvTyFOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGc4qocn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC14C116B1;
	Tue, 11 Nov 2025 10:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762857269;
	bh=Dzpt6Z0D/c6MEJOU+LNjhT4k0I4uQhWwRaQj5wYq5TA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NGc4qocnrynRT01TB0/gRXEOoeA73ahdapiloQvkIbphHfZSwEWpQwKK7qncJzrRR
	 qbSlgwnwpY6IzYMLPtK8OsobU2oEqzB9QXDxM49w7sWJqYK67KFMxWa20eTexbcgZ8
	 JzAyVB8zdfH3xTlyYWwXP07bICtd7wa3ICCOyRpcWDVSI+xoCoNeMeLqlUo71i3VGw
	 PhzIaArHBHpl+G/dz6YiFDNa8yRVDy9iIrGhWgRxCGTIPw3sAul3+HriiTZNHcijP7
	 lS7O5T7EjSCHYORDCyMXOE0aghQyfDLhrWN+EHqFkJdAepoer0HZwACj7hBIWpsieT
	 UhJgN1Mz1kZSw==
Message-ID: <2eb5ea0b-d071-4e17-abc8-7db5c78919f2@kernel.org>
Date: Tue, 11 Nov 2025 11:34:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: riscv: spacemit: Add OrangePi R2S
 board
To: Michael Opdenacker <michael.opdenacker@rootcommit.com>,
 Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
References: <20251110220641.1751392-1-michael.opdenacker@rootcommit.com>
 <20251110220641.1751392-2-michael.opdenacker@rootcommit.com>
 <20251111-inquisitive-ambrosial-chicken-861542@kuoka>
 <20251111101149-GYE1651402@gentoo.org>
 <af7bd4ab-38dd-4a5a-93e5-f457ae3460db@kernel.org>
 <1d469324-84c8-4b5d-ae68-d77e3c822656@rootcommit.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <1d469324-84c8-4b5d-ae68-d77e3c822656@rootcommit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/2025 11:29, Michael Opdenacker wrote:
> Greetings
> 
> Thanks one more time for the reviews!
> 
> On 11/11/25 11:13, Krzysztof Kozlowski wrote:
>> On 11/11/2025 11:11, Yixun Lan wrote:
>>> Hi Krzysztof,
>>>
>>> On 08:43 Tue 11 Nov     , Krzysztof Kozlowski wrote:
>>>> On Mon, Nov 10, 2025 at 10:06:48PM +0000, michael.opdenacker@rootcommit.com wrote:
>>>>> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
>>>>>
>>>>> Document the compatible string for the OrangePi R2S board [1], which
>>>>> is marketed as using the Ky X1 SoC but is in fact identical to
>>> Maybe, just say it "same" to clarify the ambiguity?
>> What is exactly "same"? Same die? Or same blocks/pieces? Whichever you
>> choose please make it very explicit.
> 
> Maybe Troy Mitchell from Spacemit can shed light on this question.
> 
> Anyway, I could use the same wording as in this commit introducing 
> "OrangePi RV2":
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch?id=bab8dea259100a99e047fd11a48940b229d30031
> 
> "The board is described as using the Ky X1 SoC, which, based on 
> available downstream sources and testing, appears to be identical or 
> very closely related to the SpacemiT K1 SoC".
> 
> What do you think?

This clearly suggests they are not identical thus you should have also
dedicated compatible. Let me then precise, I thought it is obvious, that
except writing it more detailed in commit msg, you also need proper
binding expressing this. If this is not the same die and they look
compatible, then usually it means you need a compatible.

Best regards,
Krzysztof

