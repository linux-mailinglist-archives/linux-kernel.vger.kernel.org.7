Return-Path: <linux-kernel+bounces-725176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CADAFFBA7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E88E547917
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D84528B7E5;
	Thu, 10 Jul 2025 08:03:24 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9D028853C;
	Thu, 10 Jul 2025 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134604; cv=none; b=o3lNS7DxI6WkycXfe/GpbmLYS7c9KaOgRH5bYKoAcspD6G2RIGFlB+NgIXzOumIMOjHHVEAjqh8OJzKaPM6ZIAYq+N2n1erTNym1kYgcCU6nYHddvApBP8B0OtEMhzArFVJSniB9MZQ7giNRO89f12SUC//IrJw1aKpLWaHld5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134604; c=relaxed/simple;
	bh=vwkFwjpE+Upplw8PdIDh5qpFIDC+P4YWqyGX/LC2JuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXARtzT+qe+9L+R3LQq7D8ssSTFhWDAh3Zm4tikDakUyZQCFaf6aEk7lc1N5iQay43RhiVFrjcQbJ3E9SUowo8/C++oVwyswqXBbsH3RUqfSyAHHsU8kmKk8cbz7Y59+yW/+YOAeDBOlzURe88VvosFlycW6NaV6ZHF9gfK9Oos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: esmtpgz15t1752134553t6f595ebe
X-QQ-Originating-IP: TMeCWw3VhbtL055KbbMrtfQNlR6MVhF9cJq+MR8ibLs=
Received: from localhost ( [183.17.231.23])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Jul 2025 16:02:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7094107306005909391
EX-QQ-RecipientCnt: 14
Date: Thu, 10 Jul 2025 16:02:31 +0800
From: Nick Li <nick.li@foursemi.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, perex@perex.cz,
	tiwai@suse.com, xiaoming.yang@foursemi.com,
	danyang.zheng@foursemi.com, like.xy@foxmail.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ASoC: dt-bindings: Add schema for FS2104/5S audio
 amplifiers
Message-ID: <1817574C54F0A79C+aG9zl_ERp5hbxwer@foursemi.com>
References: <20250703035639.7252-1-nick.li@foursemi.com>
 <20250708112901.25228-1-nick.li@foursemi.com>
 <20250708112901.25228-3-nick.li@foursemi.com>
 <20250709-hypersonic-piculet-of-fertility-7c4a82@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250709-hypersonic-piculet-of-fertility-7c4a82@krzk-bin>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OXWhkXa0b/rw1OFVl7E7ZyFXVlAH4+lvGcEbYK7YmS6UbHTWTG50MlhE
	gEwmPk/RA2OfIl85y5IV2dCUKUNzn2bUaK0Wx3yhBVrrv8khUHgZuA4QO1aCgYSUhTzt9qr
	0riALQR+yfmRjbdRynC9Nstvk+pjgtUlWUofU/AdJzNiib8eRsedzjFqyvdgN0zh9OhORUq
	Kxxo/OiMInhm/vhmcpAUgbdI5WL4nNY0V3GXZI2jXxuw1dHOaGHiQRZ3Te83ng3IUw4U3fg
	0FU5ZuGe1Km5EWiyxk5lHaDfzqC3NTRQP8PbPxGPV2K8OAmkw0jnw4K1gMZaHflI8X+WlxT
	PhSTUBmGKIG7GoH1xferwAgQxPLxBp2RiI5EzZ6Zsr5sWRRDWEuqZFuhz00+S3laTPh6io9
	kOmHLsXtdgPLixkMpSs8jP6FvgvLjlEH7D8WYhmeGi6qzvr0AE7FPzgfn9wGLKEVZ9DQxPv
	leWL/ZRvbv/ySDjMYcyqqXMniRn7EouP0olIfvpTqNNuVFnPlr2TOSK2HSGCvdGk5bZ+5SU
	x2rh97wxKcsavCXWNBX2252LdF8n7k4JFfAVCWch3HQB20q3X7oOG5W3jW4Ep9iYRcsnCy/
	zccoVKR2aXnXUo/E7dAZH+dAokss02v0wcKBZjose0One8BCI6bYUquobCpnfN6xshroSsZ
	RpLhMOGbuw8DfWAgDfEFNAmTpbCR/CvINb9jLNU3CBunFI22orWaMfqz5NW2ra41bTh9M3+
	IMMGM8ci1MmTx7wxVaoTTgibL1ZaIlkmqw2cC3Fz0JBTnRaslzo8Tuh0fvHIZ9lZQH3lfO0
	YJZDP6Qzrmu4IaAKJVFpoH75A1H1sQy38xJjXh6kG9kd6Z8YBCAv4uGM3zuUsUzkPAPJ/tt
	nDWN0FTFoyAMQILum036pTxQLyGecqTMxwR/lv3YOS+W2FQx/15Dv1SEebL/zGQ/beuXrnM
	l8IdYYZXM6my1harzJu5e5BXxbzVSCbTXhwwYkHKf6Jq/lviASSMLu5SfEh5MDQvnYvpegS
	gzdFWeky3UFboNYVJo03rKF8XrWQsG9b69rh1wwJDIZwpUUS2W
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Wed, Jul 09, 2025 at 12:42:35PM +0200, Krzysztof Kozlowski wrote:
> On Tue, Jul 08, 2025 at 07:28:59PM +0800, Nick Li wrote:
> > Add a DT schema for describing FourSemi FS2104/5S
> > audio amplifiers which support both I2S and I2C interface.
> > 
> 
> Another unexpected change from v1: subject: why did you add "schema"?
> 
> I asked to drop it and gave you reference explaining this. Did you read
> it?
> 
> So again, same template:
> 
> A nit, subject: drop second/last, redundant "schema for". The
> "dt-bindings" prefix is already stating that these are bindings in
> schema format, because they cannot be anything else.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 

Sorry, I misunderstood, I will fix it by dropping "schema for ".

Best regards,
Nick

> Best regards,
> Krzysztof
> 
> 

