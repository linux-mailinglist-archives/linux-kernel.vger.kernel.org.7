Return-Path: <linux-kernel+bounces-896825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F5AC514E0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34DDB4EA5FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E854D2FE050;
	Wed, 12 Nov 2025 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rhy68KDR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D1A2FD7A8;
	Wed, 12 Nov 2025 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938876; cv=none; b=N1jY1L7PuUpm7yXcLD4sEZRflhB259DErVlCQ+zxTy226nxvXOng9fKGM6cH7tz/6ZDqQt1xoLuJ5GP2y2p0UhOPFhISSv6pWC/rw++48SXGH62wjjVb9RbZPYvwZ+2yHCS+Hm32pzoVkJ9p16nOYqksCRfYcEhGB8J+hD5dj8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938876; c=relaxed/simple;
	bh=2i1LfyT640thS7F7ew7xBnFfNcy2pvnpIiWcAPcGZho=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=B3poShBkTc3tVvhiV1Jl75NVmAcPEMBGwm7mXxiBKMiV5nm1NuahpKRcJwn/ho3xyOWBoH4suTTj0crKs6vWRzcMK7aI0pL39LsdP0MvRCk4XshBTUytqlsNYqFf0T7Qiq3eNmpeuLF/3xK+ftDuM45NkOKO4tzCWdxN8FO3Bvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rhy68KDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5C6C116B1;
	Wed, 12 Nov 2025 09:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762938875;
	bh=2i1LfyT640thS7F7ew7xBnFfNcy2pvnpIiWcAPcGZho=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Rhy68KDR6MRc5rlFYC286NVKAeXskr76Rz+7hyFwdulAlSNgs8dyT2AclJSNU9z1b
	 32sLHUqpuhxXR0/tmKxi7GD64IZMOM18NBb6jt/IEC00E1YhfX1M520T0ooOdqYSn/
	 U4/rIZN3HMARWlGSIhG6iVurPl8BPHGnqBCXzy6kwkyh+g6sijHK+UNz127wDvO8ad
	 fU/gImHWZhulyhrM6jE2oCV1yOJne55VW/UXV6TpeQ1NEPG/UzfUq+HyGohsdYLwCU
	 GTvaDVX0uWLoSiquet+zXCC1VXpy/0UkjJVijWCNa5+emxqdTtXdNdptAKO1+4clQL
	 kaa1Alf2StpXg==
Message-ID: <2e160fe1-bcb2-41cf-817e-ac2a36959b16@kernel.org>
Date: Wed, 12 Nov 2025 10:14:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: add support for NXP i.MX8MP FRDM board
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Baluta <daniel.baluta@gmail.com>,
 Fabio Estevam <festevam@gmail.com>
Cc: Rogerio Pimentel <rpimentel.silva@gmail.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de,
 alexander.stein@ew.tq-group.com, dario.binacchi@amarulasolutions.com,
 marex@denx.de, Markus.Niebel@tq-group.com, y.moog@phytec.de,
 joao.goncalves@toradex.com, frieder.schrempf@kontron.de,
 josua@solid-run.com, francesco.dolcini@toradex.com, primoz.fiser@norik.com,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xiaofeng Wei <xiaofeng.wei@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>,
 Joseph Guo <qijian.guo@nxp.com>
References: <20251109214515.121742-1-rpimentel.silva@gmail.com>
 <20251109214515.121742-2-rpimentel.silva@gmail.com>
 <9d48a54c-0585-4524-b9d5-30696f5ecc8b@kernel.org>
 <CAEnQRZCvpXzGt=7NGv7-s+y0gvOg7Jx4OqbfbW3uv8jDp-jroQ@mail.gmail.com>
 <CAOMZO5CU09fcBB8oUOO=qC=Du3Q9gnJOQacK=6v+pnSQViex3g@mail.gmail.com>
 <CAEnQRZCHKemw2YVT=WVJvUMr9CCWoZ3MORt_mU1V-62C53n-3w@mail.gmail.com>
 <CAEnQRZBBJ4PGDOk7hBP_qsk7bBiec8pHb0DYKs2mhOAahNyKww@mail.gmail.com>
 <baafb460-fb65-4cd2-9911-89d828199d9b@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <baafb460-fb65-4cd2-9911-89d828199d9b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/11/2025 10:08, Krzysztof Kozlowski wrote:
> On 12/11/2025 09:15, Daniel Baluta wrote:
>> On Tue, Nov 11, 2025 at 2:49 PM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>>>
>>> On Tue, Nov 11, 2025 at 1:50 PM Fabio Estevam <festevam@gmail.com> wrote:
>>>>
>>>> Hi Daniel,
>>>>
>>>> On Tue, Nov 11, 2025 at 5:45 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>>>>
>>>>> In addition to that, Rogerio please read:
>>>>>
>>>>> https://docs.kernel.org/process/submitting-patches.html
>>>>>
>>>>> At this moment I think you should keep the original author of the
>>>>> patch.
>>>>
>>>> Right, but NXP makes a total mess with authorship.
>>>
>>> I cannot disagree with you on this, let me clarify it internally with
>>> NXP colleagues
>>> and sort everything out.
>>
>> Hi Fabio & Rogerio,
>>
>> Checked internally and to track the correct authorship and development work
>> here is how NXP would prefer to get credit.
> 
> Sorry, but individual contributors do not need to give any credits to
> NXP. If NXP wanted to sent the patches to have credit, they would do it.
> 
> Did sending happened?
> 
> If not, then any contributor is rightful to take the patches from
> downstream and send them only, ONLY with their authorship. That's what
> DCO allows and that's what established practice as well.
> 
> NXP had a chance to upstream. When they decided not to, they forfeit any
> rights to claim they want any authorship.
> 
> 
>>
>> #Use git commit --amend --author="Xiaofeng Wei <xiaofeng.wei@nxp.com>"
> 
> NAK, there is no single patch like that from above author:
> 
> https://lore.kernel.org/all/?q=f%3Axiaofeng.wei%40nxp.com
> 
> Remember, downstream code does not matter. Does not exist.
> 
> 


... and because last two months there were two or three cases where
vendor companies bullied individual contributors, I will be quite strict
about that. Vendor company does not receive any authorship on patches
sent by independent contributors which the vendor NEVER submitted,
unless author really wants that. But I will treat any such insisting on
authorship by vendor like NXP as bullying and working AGAINST the community.

Best regards,
Krzysztof

