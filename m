Return-Path: <linux-kernel+bounces-783687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37944B3313C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 17:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C89677A2A30
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A76A2D6E43;
	Sun, 24 Aug 2025 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSnUMQ4t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1B9749C;
	Sun, 24 Aug 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756049628; cv=none; b=fQ88aEA1iY7v3uuxQpRnMCDiQ/VEVHFbSLZp5yisywlmkdStITkPcQgSm+h4PiRza7Dc0b0MbT/sahpU5/NDKcuDarYK7Z0p6fivTEqDG0cwzfqZXBjIwtT8RJtiQ1oTGmFEb2tLFvlJGGf5ETP0/+H03BZjlhiLGYsqNaCB1hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756049628; c=relaxed/simple;
	bh=oQzQEC/j+B5UVSDuvC80FiJ+MKY+IFlYoW/dIszqcuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ewva8S1sj20RxwPyTgrjh5Do1aJwK5dLnGioTQkIr3TzV+tjYQ+w5dXPanzfHadRq/Q9/h5uDnDP4jiblZ7ZXD7N7HDy42/50RTtN+uVbRgl4e/NO6T4S/dfk5mC506Ts0V3cSCVdmMe8KIpADU3KDQqJbVshRRumlL3VYu9fxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSnUMQ4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC7BC4CEEB;
	Sun, 24 Aug 2025 15:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756049627;
	bh=oQzQEC/j+B5UVSDuvC80FiJ+MKY+IFlYoW/dIszqcuU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HSnUMQ4tlsLUIC9Waj7DTcg0C+4Q5PkV2X/ONEbyFx2fbKxd/S3t4gW3/5YBlJ6M2
	 UaiOBj+2tBwtGm2siDG6q0+wzYRi3f3ljnCA6Ug/37/MUj3lx04md6wZrKTgskj8JN
	 2O3YacNREIgXwcqlJKRKDMipgyBFG/eMHKD7C52ICZxZ8rnP5elIAr9uFNxDWfHHlD
	 oGLqLFzninpwNUMcMkW16ZlHBmO2mOCihjqPZUbNShr1voctFsQ8WbBjhAc/s9+eUO
	 qfcKyYqC5XAq1miXvOvqzDlxverCrf9L0Qc1AOU1RdfVhqbfQd6mlU1MvgKTY/80CN
	 HhLAeT1kmlVsw==
Message-ID: <96409a43-b3f7-4b9e-a1e8-fd0ac6503cd9@kernel.org>
Date: Sun, 24 Aug 2025 17:33:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/22] dt-bindings: phy: Add Apple Type-C PHY
To: Rob Herring <robh@kernel.org>, Janne Grunau <j@jannau.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-phy@lists.infradead.org
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-3-172beda182b8@kernel.org>
 <20250821163320.GE1270980@robin.jannau.net>
 <CAL_JsqL=y2OT4YrzT8z0O0T2hpM5X1k2pFEb8XjBRPoNMdO5kw@mail.gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <CAL_JsqL=y2OT4YrzT8z0O0T2hpM5X1k2pFEb8XjBRPoNMdO5kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.08.25 01:00, Rob Herring wrote:
> On Thu, Aug 21, 2025 at 11:33 AM Janne Grunau <j@jannau.net> wrote:
>>
>> On Thu, Aug 21, 2025 at 03:38:55PM +0000, Sven Peter wrote:

[...]

>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - apple,t6000-atcphy
>>> +      - apple,t6000-atcphy-dp-only # PHY hardwired to DP-to-HDMI converter on M2 Pro MacBook
>>
>> The comment is misleading, "t6000-atcphy-dp-only" would be for M1
>> Pro/Max Macbooks. M2 Pro/Max Macbooks use the same design so the
>> corresponding "apple,t6020-atcphy-dp-only" compatible is missing.
>> I'm not sure this is the correct design though as the HW block is
>> identical to "apple,t6000-atcphy".
>> I think it might be better to have either the DRM KMS driver or a
>> custom DP->HDMI drm_bridge switch the mode to DP-only.
>> Or atcphy could initialize itself to DP-only based on the available
>> ports.
> 
> Doesn't sound like this should be a different compatible. There's a
> 'phy-mode' property or you can define the mode in the 'phys' cells for
> the DP controller.

Okay, makes sense. I'll drop the compatible.

I've only found "intel,phy-mode" inside bindings/phy but we can figure 
this out later once we actually get to upstreaming what's required for 
DisplayPort and mostly focus on USB3 for this series.


Thanks


Sven



