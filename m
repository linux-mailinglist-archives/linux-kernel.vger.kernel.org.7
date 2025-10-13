Return-Path: <linux-kernel+bounces-850240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 648F2BD253D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E073A4ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5DD2FE042;
	Mon, 13 Oct 2025 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="Ez1Pmdz9"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BBC26290;
	Mon, 13 Oct 2025 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348306; cv=none; b=fkMfa6fKynmz0Yh6Hm4LrTMZdTP/aZJN3TNJUvHvyc4q3BtGylTO9cVAJWDMBHfTFGtAlEAveyHU1KSRAvsgjPLt+XMbl58vOCwfyHZeiOPB97YI1Vi2EiuOuxGdcU4/U0VDGvC0Ml9OqJ7TQEHinb6tJOx9owmneeHm90duqzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348306; c=relaxed/simple;
	bh=TiXbg72QqgA4BnTEEMu0KGbCUDFtZ0Q5AlBXuwEH44o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKT6/1Iq9H+xYv6IAofxcDEzseUIxwEqjn6f9RdZKqpJUdrVewMztO5hZ3HpLyMQAFyq9ydszf8Ebguc99nxUIZOuxTZHWF4op4xHHWcUWiPeqQvVXBZChgA8bl6Srlg/BkhbQpeswqPVaWQVEkzUpZBOreRWiStaM8rmrSoWKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=Ez1Pmdz9; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760348293;
	bh=FKV5rcOU3NiQueOAKmsQZIMEQoY0gM/PgsfKPak6dIU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=Ez1Pmdz9PibsVWiivzwyns05u+G7nCeT6rukKIGBRfFGeSnnvqY9hhgDfPwztSvUq
	 E6Mb3Mtx9vqxJjpF1Ebp112LXXt3eE4yntA0+tRW51Wf4C5SukjEbx19aEQaQeyefa
	 4cjJbFvp/DbCHLXwogP7wfH/EnKNcIZ6nchH1d/E=
X-QQ-mid: zesmtpgz6t1760348287t76bc683d
X-QQ-Originating-IP: 0yrPrwLnm0gGgvkYYE+D/xX95XiUkzU9yKkuKrbC1Gw=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Oct 2025 17:38:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6530773640354334042
EX-QQ-RecipientCnt: 15
Date: Mon, 13 Oct 2025 17:38:05 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Ze Huang <huang.ze@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v8 0/2] Add SpacemiT K1 USB3.0 host controller support
Message-ID: <AB4F40590DDC4024+aOzIfRgZZpZc3HeH@kernel.org>
References: <20250913-dwc3_generic-v8-0-b50f81f05f95@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913-dwc3_generic-v8-0-b50f81f05f95@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OPdvjVtisQSKo8vxOfGiiSG20Casxmv55eFfK0nCExwGRBlUDLokVU63
	x6z55/5A/vrwgAcQ5nCgKDrhC7K+BeRhl1LA3pEG/cDe5tnZkP3iTjuZ9qbEj4bWm3OIMOW
	lMEJBpK8nb4fIVibYU2LA9cz3pRgbiClZScGDrH2G/a/qDQeECgTuFgLirNoGL19iPFk5mp
	mNltALaxu8eEgsMILxV7qYpL8l6XbrNxsRO0wQtmS59SfNMRej5WXgkw9HXz23/Xa8V09mu
	9KA1mn+/wV6Or1XbJD0CqyeYxrFm8xVNDqCQ9Y8TP6ckxlB4LVQBCHBN2Mi3+UbyFomGpd2
	rHzj2mD0qFSGz3NTa8cEBpobJJXu9UzCXwzgu+8Gt4kQBGwUI/+kCCRY0z/TYYs7Wkw4nXn
	5+5e8oh4b0HLC6mSGyymDJg7jv4Tj5AFMeDM6l4ZUCwxoZjhN+E60Rc3Es2pBRTO/drgccr
	TKLnIrorfORgOmbDW+XGnavdIrsQpM2S3gDVd+fn8ksWtqtHzK2cm9MbGuni0LeuosCF825
	Aamd2Yqw9e0MjSyIghNwJIYjlbXf/Pl8W1ov+YmUuXmOwLtJorVeT4Gj3Uh+Ki2rUYTAFDq
	+OdleMtdcPf3wGc76WfCBv2LdISvJ7xESw1cR+W0dgKVflMUYYdYLT0n0kSicTzygDaJqBs
	zg0mCxobMyrGXpdB609NUxTCPQpeWGAoA2NdZRa7iP42ojS+fLvxzl0izMS6QVJ9xyeWKLQ
	OlDXmxd9mXMeRRHqQGWLpPTSyK4jytIIR+WMkQ8tTmX38C4okkboO3j5+2ZpE/OeJH/6R2G
	QbMqfRroPkaKFtFXY/xveu6o6gowYS1CaAnwqlmVJi9q1HUWqfKjJun0ILxItWnKCtxbQGw
	VH3YuDBhzBF4zl6QbP5LkZ9vAoe2mmkhriz4bqrvdOvn4zMmm03kse5X43skkfjBR7Kq3Ns
	Thj0rafH7SGK0uq/eh7G1cECsZFSnYzWNZ7wz52JQv+7FOzZ+FtXHiKSC0CfzpqpJW81SHn
	jttRKzUFxqne2kyVW0at8z5GxVJtVZN716m0FxGTM0d58Ces/RvCELSGtzXmV0njYL8lSc1
	Xiwj2X7iGEz
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Sat, Sep 13, 2025 at 12:53:46AM +0800, Ze Huang wrote:
> The USB 3.0 controller found in the SpacemiT K1 SoC[1] supports both USB3.0
> Host and USB2.0 Dual-Role Device (DRD). 
> 
> This controller is compatible with DesignWare Core USB 3 (DWC3) driver.
> However, constraints in the `snps,dwc3` bindings limit the ability to describe
> hardware-specific features in a clean and maintainable way. While
> `dwc3-of-simple` still serves as a glue layer for many platforms, it requires a
> split device tree node structure, which is less desirable in newer platforms.
> 
> To promote a transition toward a flattened `dwc` node structure, this series
> introduces `dwc3-generic-plat`, building upon prior efforts that exposed the
> DWC3 core driver [2].
> 
> The device tree support for SpacemiT K1 will be submitted separately when the
> associated PHY driver is ready.
> 
> This series is based on 6.17-rc1 and has been tested on BananaPi development
> boards.
> 
> Link: https://developer.spacemit.com/documentation?token=AjHDwrW78igAAEkiHracBI9HnTb [1]
> Link: https://lore.kernel.org/all/20250414-dwc3-refactor-v7-3-f015b358722d@oss.qualcomm.com [2]
> 
> Signed-off-by: Ze Huang <huang.ze@linux.dev>
> ---
Tested-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

Thanks,
Troy

