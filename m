Return-Path: <linux-kernel+bounces-783347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AC3B32C01
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 22:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2CF9E2A5F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 20:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E19A2EBDE6;
	Sat, 23 Aug 2025 20:41:37 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD1620ADD6;
	Sat, 23 Aug 2025 20:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755981696; cv=none; b=Llo6OWlTK5pViS3xfgeE2OJwXFKABzmK5RsnBjf+7HWFExHMZ6TrjAYURFqAwyWI0qy0HZLELuM4fQzts4eGLedBhWUS1Cxz7Ern0stwK1xSSccnGIHTF1W9+bH/OSlZjqhgiEAn6sVEaTj7zJY437lDD/6BSeuqTf5xonpU4jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755981696; c=relaxed/simple;
	bh=BVh05A9sHwio3fQQi58XUpcajdKH5UmEGOAAms5X0eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gn7+yqCaNBCcDvnUSFs04/LHbQiLebo1iEGcBXK1Ge4FbFQzIniGTdfFxzooBMJzYjbnscWSrjuV4rgaQmcQ3j9bttryQLbzaSQaa/HmUSzam3oL7rfoHUbmDiq7Dmw71IHE7OaP6lDRWxmoIIAOBL87zwGwMG2XH7Ej9yes6cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [192.168.2.54] (unknown [98.97.26.216])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 4DDFBB4E0012;
	Sat, 23 Aug 2025 22:41:30 +0200 (CEST)
Message-ID: <a30e894b-cd23-46d7-9621-2fe039123466@freeshell.de>
Date: Sat, 23 Aug 2025 13:41:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: memory-controllers: add StarFive
 JH7110 SoC DMC
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
References: <20250823100159.203925-1-e@freeshell.de>
 <20250823100159.203925-2-e@freeshell.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250823100159.203925-2-e@freeshell.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/23/25 08:20, Krzysztof Kozlowski wrote:
> On 23/08/2025 10:58, E Shattow wrote:
>> Describe JH7110 SoC DDR external memory interface.
>>
>> Signed-off-by: E Shattow <e@freeshell.de>
>
> Don't send the same patch multiple times. To which one people should
> respond?
>
> Best regards,
> Krzysztof

Respond to v3 RESEND (this thread), or I may collect responses from
either thread they are the same content. I'd missed a linux-riscv list
CC line on a patch and that confused patchwork, and then I missed
'RESEND' in subject for the re-send series after the cover letter.
Patchwork sees the RESEND series now, and sorry for the added noise. -E

