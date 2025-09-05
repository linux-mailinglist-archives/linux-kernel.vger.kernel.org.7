Return-Path: <linux-kernel+bounces-801999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9462CB44CA5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612DF1C27671
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A93326B2D2;
	Fri,  5 Sep 2025 04:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="NZElVJmd"
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EA5258ED7;
	Fri,  5 Sep 2025 04:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757045590; cv=pass; b=NOfAA6d71ASU2SdE4q5xpP1tZqIIw5jOpa1zL+lCMPWpPo7TyecD/AJ3hhNjKaWxqKsv739ChnHFjaPdPjEl8qY8jJHAQvFgBeto+E2VdmQBb023MQgl4khldqKYDTZ8l/g76IRQ9UWqKr4pNR6opS2XXcfzyayr5VlrcwbkYlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757045590; c=relaxed/simple;
	bh=8+kKazWjIzpOs5Dolw2JwxTR50n4ZUL4PclLiZ60jic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yoh3O3A9Zv86/OWr6EeOQcfNHCdZPKpXlFjKwL0gH6oJjtcXDe2FqMehROFE3vEO8ouKBRrhpRRB3R/0Yjp37XaPtKYcLpnA36Uw1oknaOTi+KIt1N8zpTad2wG+Wf9FYZKc6gRPrnYP4GMwOl+he/YvBoG/8iTcU7nJXJJWZ9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=NZElVJmd; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1757045567; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gM/Sls9VZ5T1dHf2Z1rAFKT1cspPYL35GR25pDh+8laJ42bY7UJ1J05cWvEL48knRhFcHTIfoD/96gWesM7VQZLXnM4lUgvXtq1bklTf+exzJkqZxW5jQUepiPZ1/NJQvincmXcjAhWsDPsZ9WRD9+DliciSKoTO6ymCUPwH1No=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757045567; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6j8WVHUzpjmtLTPxg0zlXLMcBS5g1yEiQQDtA+CKY3s=; 
	b=jVma1J2O5vrPhl0q1pbGJGQpMoWcV1sL9LwMP7Y+OEf0ftbvLfOnPn4+3M4HA+p5gg672FKY3GZoHAXHKe8WEG8w8iicdYDzIRwTWb7o9UnSNiDiCnrqKc9xMfFF1WtcvJqFUOW/ao+/5e7aXBfXk+4CxDase0pL/Ks7hSsuwac=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757045567;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=6j8WVHUzpjmtLTPxg0zlXLMcBS5g1yEiQQDtA+CKY3s=;
	b=NZElVJmd0ndkhsNVJtUQSDK85slBkQPcXeL78AZDCE62ojFznh07Twt7hjZab9f6
	iQjgHMOQIuxN3OPiIOs5x54Tusq6aWAOouc6ZqLRm+N6u+nxmW9agI4Ta6vnGv7tNBR
	S5gSlBFdCWuWWQyRLuIyAPlCUsT1QHJbng9fPNyw=
Received: by mx.zohomail.com with SMTPS id 1757045559172945.1322496024884;
	Thu, 4 Sep 2025 21:12:39 -0700 (PDT)
Message-ID: <c0775df8-f959-4c70-9f06-bfa22dd27d54@zohomail.com>
Date: Fri, 5 Sep 2025 12:12:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] clk: canaan: Add clock driver for Canaan K230
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Samuel Holland <samuel.holland@sifive.com>,
 Troy Mitchell <TroyMitchell988@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Michael Turquette <mturquette@baylibre.com>
References: <20250905-b4-k230-clk-v8-0-96caa02d5428@zohomail.com>
 <20250905-b4-k230-clk-v8-2-96caa02d5428@zohomail.com>
From: Xukai Wang <kingxukai@zohomail.com>
Content-Language: en-US
In-Reply-To: <20250905-b4-k230-clk-v8-2-96caa02d5428@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112276c7d67b73e77bdc8490d709c0000502e5d5094ca03801f33702c9bd07a306ca3328e5fa12003bc:zu080112277d54128bb0a004aa7d227705000049afec9605f2514ce51188b05b1ed005e393bf07381131e24f:rf0801122cd74f153e3036c567b85a7cd7000082ae154bd1fb4dfc1866f22e5df40d10ed18265ec4bb620f84aae37cb6ed:ZohoMail
X-ZohoMailClient: External

Hi Stephen Boyd,

Is the driver in this series satisfactory to you?

If you have any concerns or suggestions, I would appreciate your
feedback.Otherwise, I would like to know if it is ready for merging.

Thank you for your time and consideration.

On 2025/9/5 11:10, Xukai Wang wrote:
> This patch provides basic support for the K230 clock, which covers
> all clocks in K230 SoC.
>
> The clock tree of the K230 SoC consists of a 24MHZ external crystal
> oscillator, PLLs and an external pulse input for timerX, and their
> derived clocks.
>
> Co-developed-by: Troy Mitchell <TroyMitchell988@gmail.com>
> Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
> Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
> ---
>  drivers/clk/Kconfig    |    6 +
>  drivers/clk/Makefile   |    1 +
>  drivers/clk/clk-k230.c | 2456 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 2463 insertions(+)

