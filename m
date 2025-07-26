Return-Path: <linux-kernel+bounces-746628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C22AAB12910
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 07:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF301C874F5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 05:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342EB20110B;
	Sat, 26 Jul 2025 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="Sd2GZqii"
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A34EED8;
	Sat, 26 Jul 2025 05:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753507398; cv=pass; b=UbVk49XdwbxohuIPtHyB4hLpVjxGflm039KKhnXlly+51Q2C0UyqAmIt6i37/g6kKiv7pdHzqaKq0CPWv7Yw9xzA/j1ya8csk55k/eVMYHQIGuFNfyHdDBpFC/AV5A9CwWqbo4fAR6qgyuleRb2fQI5Hm7ag7w+6Dik5VAirDOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753507398; c=relaxed/simple;
	bh=8L0TsRqECk8oxKkh0p8Lf7rHLY7w0aiGtCeNjsLF7ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGUj2KvfplGXjvV5ZQZbyTPMswJwA+v8dLt8MWgBPxJMwz9eNyzQPaEraUWzWPlgV9miokt2srREFhGtd8G1w2Ps7s0cLfwmvdABIIZG+l8BnYNImqR3X+n9MIqvzTgHvbo6+orSttg2luDXp6XBIywZZFBYEscn9o8hnRCM6HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=Sd2GZqii; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1753507380; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i0agtowXXKYFSAlOsS8xUPqmzYDHud40K5NHwrE6N3YvftVmEA954C5rlJnFEh9SvBg3ReCxTB1RQtFEsXuNV3ZBWqH8YB7zt3NlgBAccpYFxMFxyykWzBJMWYhBbPPxRYm111gebhWyO4teJM3ludtbicZN0y938k9mdMC6oys=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753507380; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mmNwg6ueXxCadafwT4lips5HbPEdPE1RcKAk/DHerao=; 
	b=eW6XxyGu8A3WtuK70zypZPduHdACYu8WrZQZLprZzG711jC7CSRxU87efrDZ/kst3xkhQc9mWxHVA7THIE6uRMAVJDmk65zNdPmUiYXmAblAXuF3Y3p8wdUFc4lS5ZvfcQIZ8hiWSMvaazIxNOhRooaZOKNKMK41w22fGxcI1Xg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753507380;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=mmNwg6ueXxCadafwT4lips5HbPEdPE1RcKAk/DHerao=;
	b=Sd2GZqii9J7K2i+4KyFQrPpU0ReER2s6hMO3c+oxxsUjJZfw0uHu+VUdbXbY7aG7
	vw0S6Vqe14ImXHpfWMSH1OhwzyIMGj8O1JlyBKKLUNuooQ9adQ0dioQqxT6uP0EYvYl
	Oe/vfGeF3qKlIe2AxaEVkDIoqB7uJqE1dWgYUI6Y=
Received: by mx.zohomail.com with SMTPS id 1753507373478583.4224143944394;
	Fri, 25 Jul 2025 22:22:53 -0700 (PDT)
Message-ID: <cde19d45-fbd6-4b8c-b04f-e34811d62ae8@zohomail.com>
Date: Sat, 26 Jul 2025 13:22:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] riscv: canaan: Add support for K230-Canmv clock
To: Stephen Boyd <sboyd@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Samuel Holland <samuel.holland@sifive.com>,
 Troy Mitchell <TroyMitchell988@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250415-b4-k230-clk-v6-0-7fd89f427250@zohomail.com>
 <776638cc-cbd9-4747-82eb-e11bcc6c8bdd@zohomail.com>
 <175339519523.3513.2798631977806639092@lazor>
From: Xukai Wang <kingxukai@zohomail.com>
Content-Language: en-US
In-Reply-To: <175339519523.3513.2798631977806639092@lazor>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112270c568dcf46d7bd9a6ca9bde60000df18909873772a153d341f279040e2ef74d0e9fe6602cd0fae:zu080112272084c8b289bc0c5b040e9e3500009ab072e80699b0abcbefb7032cae82cc441631b6531d467a59:rf0801122c2d91ede877ecf69152271edf0000f5f0466ce28d08f638bbfd1d1d3c2ccd19fe675d2edb74cde1f734449b92:ZohoMail
X-ZohoMailClient: External


On 2025/7/25 06:13, Stephen Boyd wrote:
> Quoting Xukai Wang (2025-07-13 09:48:44)
>> I'm working on a Linux clock driver and have encountered a question
>> regarding how to properly represent a particular type of clock source.
>>
>> In K230 SoC, there's a mux clock whose parent can optionally be an
>> external pulse signal, which is counted via a pin (the input is not
>> generated internally but comes from an external source). I’m wondering:
>>
>> Should this external pulse signal be modeled as a clock within the
>> Common Clock Framework (CCF)?
> Likely, yes.
>
>> If so, what would be the correct way to register or describe such a
>> clock in the driver?
> If it is a fixed rate pulse signal I would use a fixed rate clk node at
> the root of the DT tree:
>
> 	clock-50000 {
> 		compatible = "fixed-clock";
> 		#clock-cells = <0>;
> 		clock-frequency = <50000>;
> 	}
>
> If you need pinctrl settings to make that clk work you can assign them
> in that node, although I don't know if I've ever seen such a case
> before. 
Thanks for your reply and helpful explanation!

Regarding the timer-pulse-in, the documentation describes it as:

"can be used to count external input signal with frequency less than
1MHz and duty cycle from 0~100%"

So the input frequency is not fixed in practice.

Given that, modeling it as a fixed-rate clock might not be accurate.

And I'm considering whether a more feature-rich driver is needed to
handle the dynamically changing external clock, or if there's a better
way to describe such a clock in the CCF.

> If the external parent clk needs to be gated you'll need to
> write a more featured driver, unless it can be controlled with a gpio or
> something like that.
and I think it doesn't need to be gated.

