Return-Path: <linux-kernel+bounces-683187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CB0AD6A1C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 10:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C7A16FA86
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 08:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7523221FA4;
	Thu, 12 Jun 2025 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IS4jiy/q"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9F721B8F8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749716063; cv=none; b=ZUiHhB+G0T/5KsWdVx/9Hz898CoYugWqm1pPS6vtNWURbEmSpmYmJNBPjXU+D48Rxh1O7h0hSxdasRelpFT/iOgHWGpFYFs9eMJiiSD0LW6/BIhmnjXvzJxI2+d17Oa/arvj8moFta9ld0A/GhkA38CEhZRFBnXx7PTERcrYygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749716063; c=relaxed/simple;
	bh=t6OQBoKn4ugcADw2zlqfCSNZogwvqWRRtXHkaQJmL8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=FsDkgnZARxBEcPDRkmkZeq9R3bbeOpHrUOC5PhPhl6k5ykg1Uehea4VyfFH5WjceDqyYALj1F1S4sQoR3dKatLIE/7Wb0d8jApidK12veo5LjGf5wO2bcPEmHHAkSAHqPdRHDv+wPk1/WO/oKVNcoCsXgY2PWvMd8BsbyyW7KpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IS4jiy/q; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250612081416euoutp02209749aaae82344e9a0f2a1ac0139660~IPXuL35ka1188911889euoutp02N
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 08:14:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250612081416euoutp02209749aaae82344e9a0f2a1ac0139660~IPXuL35ka1188911889euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749716056;
	bh=/VOe1tEPEUiWf+yiC0MtudUMPxShLqsFiTfwLc2Ert0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=IS4jiy/qFsRCS3Gg9TZjyHnrCsU66P75Itwnb4oQ494v95PikpmcOTXnh/3YRDwCM
	 OXCBoeCvNH+FEbvDAWbQSbFq1PJ1PE/9cOww+3FgZocmukDVpD7OQCJkCltMsabXXt
	 TiHRv0LjcuyEr0jTLVE5OzEhqptX3yoqfhjGaQMo=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250612081415eucas1p229fc20aa3f3252e93349c606f4a8dbd2~IPXtmCWFa0599605996eucas1p2p;
	Thu, 12 Jun 2025 08:14:15 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250612081414eusmtip158dc80f809c9f48925cc69e56d3e5521~IPXsaMu1q2395823958eusmtip1O;
	Thu, 12 Jun 2025 08:14:14 +0000 (GMT)
Message-ID: <d1523586-82ca-4863-964f-331718bb1f0e@samsung.com>
Date: Thu, 12 Jun 2025 10:14:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] pwm: Add Rust driver for T-HEAD TH1520 SoC
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Drew Fustini
	<drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob
	Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
	Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Benno Lossin <lossin@kernel.org>, Michael
	Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <jbm3qvowi5vskhnjyqlp3xek36gzzqjt35m66eayxi6lmi525t@iefevopxjl53>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250612081415eucas1p229fc20aa3f3252e93349c606f4a8dbd2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250610125333eucas1p16126b64a0f447a5e9a5ad553d9d7d79d
X-EPHeader: CA
X-CMS-RootMailID: 20250610125333eucas1p16126b64a0f447a5e9a5ad553d9d7d79d
References: <20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com>
	<CGME20250610125333eucas1p16126b64a0f447a5e9a5ad553d9d7d79d@eucas1p1.samsung.com>
	<20250610-rust-next-pwm-working-fan-for-sending-v2-2-753e2955f110@samsung.com>
	<jbm3qvowi5vskhnjyqlp3xek36gzzqjt35m66eayxi6lmi525t@iefevopxjl53>



On 6/11/25 08:58, Uwe Kleine-König wrote:
> Hello,
> 
> Huh, if you do the newstyle stuff, .get_state() is wrong. It's either
> .round_waveform_tohw() + .round_waveform_fromhw() + .read_waveform() +
> .write_waveform() or .apply() + .get_state(), but don't mix these.

In the process of implementing the full "newstyle" waveform API as you
suggested, I discovered a hardware limitation. After writing new values
to the period and duty cycle registers, reading them back does not
return the programmed values, which makes it impossible to reliably
report the current hardware state.

This appears to be a known quirk of the hardware, as the reference C
driver from T-HEAD [1] also omits the .get_state callback, likely for
the same reason.

Given this, would it be acceptable to provide a write-only driver? My
proposed solution would be to omit the .read_waveform() and
.round_waveform_fromhw() implementations from my PwmOps trait. This
would mean the driver can correctly set the PWM state, but attempting to
read it back via sysfs would fail (e.g., with -EOPNOTSUPP), reflecting
the hardware's capability.

Does this sound like a reasonable approach to you?

[1] - https://github.com/revyos/thead-kernel/blob/lpi4a/drivers/pwm/pwm-light.c

> 
>> +        let data: &Self = chip.drvdata().ok_or(EINVAL)?;
>> +        let hwpwm = pwm.hwpwm();
>> +        let iomem_guard = data.iomem.access(parent_dev)?;
>> +        let iomap = iomem_guard.deref();
>> +        let ctrl = iomap.read32(th1520_pwm_ctrl(hwpwm));
>> +        let period_cycles = iomap.read32(th1520_pwm_per(hwpwm));
>> +        let duty_cycles = iomap.read32(th1520_pwm_fp(hwpwm));
>> +
>> +        state.set_enabled(duty_cycles != 0);
>> +
>> +        let rate_hz = data.clk.rate().as_hz();
>> +        let period_ns = (period_cycles as u64)
>> +            .mul_div(time::NSEC_PER_SEC as u64, rate_hz as u64)
>> +            .unwrap_or(0);

> Best regards
> Uwe

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

