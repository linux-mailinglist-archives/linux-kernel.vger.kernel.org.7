Return-Path: <linux-kernel+bounces-725455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E63DCAFFF54
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0C677BEFBE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125862DAFCF;
	Thu, 10 Jul 2025 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vCQX9qZV"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EA32DCC1A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143405; cv=none; b=ADTdhy87QMYjZ/Wo7qeuZ0TEZrD3H6znTuauYhe6EvaJeHEycm2kcYFpF3H2oRWxTpUr6VPHLvEo5WdBCxwVNehI4bycRQzDG7Ot1yUb6GSDFN39N+S8Nhl+o4+c1u1Pa0A9EfA1c1DgLJrAz4inO8v1tSK1tFIW01v3xZxpc/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143405; c=relaxed/simple;
	bh=/2KLH3eIwMscTHYdhYXwjWAYCyS7MjVCkIL8YKPwd1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=kq5flxUcBR69rLvwZQbec1B0XX/9gxPDnTnK07LUelpbi4+w4bGuNyfmDv7ekH8WUdA2vEfCBUOEw8f4rzoACmJwxaiXGfrRxpGWSazd5dScCIjV8jymbBLWaZNtW+ylC2QJJHZOD+U57g/FyLDiRCzUHZR4cj3ZnioeJL+ZefY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vCQX9qZV; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250710103001euoutp011d38a5d80a058b2d44d6acd8716f6139~Q3SP1_pCK1183811838euoutp01R
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:30:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250710103001euoutp011d38a5d80a058b2d44d6acd8716f6139~Q3SP1_pCK1183811838euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752143401;
	bh=+/0MKjzL7c7U+Y/b7GZa1f4mm6vUapHe0WApFCOt6lU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=vCQX9qZVyxoO/oV3tVz+ORmsXmG+4maHuY5G+RzuCIFmdspP7OXIbNKUzwDZlykVQ
	 H1Ro6v6pDrK5EJxwLhMuRnkskZZZ136j2mHACe1Y0nFYjHPmVjgiEMPemLroNzG4hv
	 qD5tK2lSz47Cb7ABksQgPvArvncTtY4t8uO5F4XA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250710103000eucas1p1132d31a624653704073732606b27d1bf~Q3SPNGgEj2817228172eucas1p15;
	Thu, 10 Jul 2025 10:30:00 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250710102959eusmtip12fb98f6fcecf28334cca8575b9476fca~Q3SOG0Nry0190601906eusmtip1u;
	Thu, 10 Jul 2025 10:29:59 +0000 (GMT)
Message-ID: <e494422b-b989-4dc3-9828-b080dbf4c34d@samsung.com>
Date: Thu, 10 Jul 2025 12:29:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
To: Danilo Krummrich <dakr@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
	Gross <tmgross@umich.edu>, Guo Ren <guoren@kernel.org>, Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Benno Lossin <lossin@kernel.org>, Michael
	Turquette <mturquette@baylibre.com>, Drew Fustini <fustini@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <DB8AQ15RTAJ2.3QXX8Q2FTFGCP@kernel.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250710103000eucas1p1132d31a624653704073732606b27d1bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250707094926eucas1p155bd967b6986c4a999776839b1aa1fc6
X-EPHeader: CA
X-CMS-RootMailID: 20250707094926eucas1p155bd967b6986c4a999776839b1aa1fc6
References: <CGME20250707094926eucas1p155bd967b6986c4a999776839b1aa1fc6@eucas1p1.samsung.com>
	<20250707-rust-next-pwm-working-fan-for-sending-v10-0-d0c5cf342004@samsung.com>
	<e8a4a821-e7e4-4bcd-a2ac-f6b684b6ceea@samsung.com>
	<DB8AQ15RTAJ2.3QXX8Q2FTFGCP@kernel.org>



On 7/10/25 12:17, Danilo Krummrich wrote:
> On Thu Jul 10, 2025 at 10:42 AM CEST, Michal Wilczynski wrote:
>> I was hoping you could clarify the intended merge path for this series,
>> as it introduces changes to both the Rust and PWM subsystems.
>>
>> Is the expectation that the Rust maintainers will take the abstraction
>> patches into the Rust tree first? Or would Uwe, as the PWM maintainer,
>> pull the entire series? Any guidance on the coordination would be very
>> helpful.
> 
> Except for the helpers I only see PWM code, so this is fully on Uwe's purview I
> think.
> 
> I see that there is a new MAINTAINERS entry:
> 
> 	PWM SUBSYSTEM BINDINGS [RUST]
> 	M:	Michal Wilczynski <m.wilczynski@samsung.com>
> 	S:	Maintained
> 	F:	rust/helpers/pwm.c
> 	F:	rust/kernel/pwm.rs
> 
> I assume this is agreed with Uwe?
> 
> In case there's no agreement yet, the typical options are:
> 
>   1) Maintain the Rust abstractions as part of the existing MAINTAINERS entry.
>      Optionally, the author can be added as another maintainer or reviewer.
> 
>   2) Add a separate MAINTAINERS entry; patches / PRs still go through the same
>      subsystem tree.
> 
>   3) Add a separate MAINTAINERS entry; patches don't go through the subsystem
>      tree (e.g. because the subsystem maintainers don't want to deal with it).
> 
> I don't recommend (3), since it's really just a fallback.
> 
> The above looks like (2). In this case I recommend to also add the C maintainers
> as reviewers, such that they can easily follow along and specifiy the tree (T:).
> 
> But, of course, that's up to you and Uwe.

Thanks, it is not agreed yet, I've included a MAINTAINERS entry, since I
would like to help with the maintenance of the code, so I would also
vote for the 2) option, but ultimately it's an Uwe decision so I would
be happy to follow on anything he decides.

> 
>> I understand that it may be too late in the development cycle to merge
>> the full series. If that's the case, perhaps patch 2 could be considered
>> on its own, as it hasn't received comments in the last couple of
>> revisions. As another possibility, patch 1 and patch 3 are dependent on
>> each other and could be applied as a pair, depending on your assessment.
>>
>> The RISC-V driver itself would need to wait for the IoMem series merge [1].
>>
>> [1] - https://lore.kernel.org/rust-for-linux/20250704-topics-tyr-platform_iomem-v12-0-1d3d4bd8207d@collabora.com/
>>
>> Best regards,
> 
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

