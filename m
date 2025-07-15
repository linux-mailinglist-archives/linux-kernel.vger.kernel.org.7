Return-Path: <linux-kernel+bounces-731426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183DFB05413
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501CE7AC05B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628CB72615;
	Tue, 15 Jul 2025 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqsVcERw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7E126D4D9;
	Tue, 15 Jul 2025 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752566764; cv=none; b=nYCWtCCCh8FI/nzZTmW+okFCiG8a0lo8yG+qKsRN9LhWkXkL1+arSQzcPgirAxmUj4sHuGAa1yhR6SUhw6kOv5Ay0+GrMLC5tW53qC9oJsjEDO8rfsG6oQMr7Q2qPVQFvFfMH2XqyAmCAM3PRmkyJycoHBE2OSy2Qzk4B6dMvXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752566764; c=relaxed/simple;
	bh=cfdWdUaJGHBSxvMNf4+GHY7FQh+o9KAWC4PmhNHItSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSi/gL6P+qsKtuDGKtmCixqI6zOK6PwVni0cLjYj1SSu6WBMl3CNvnzhOgGZIJZITrzerNGmVtP8aqej2yUsT08ZHDN5Ww9RYJ66dKh4FtE2MYrLuh9j8XgBXCqwypmhxvWq+E7zpXVsAZ9mFUU+PHlCkt2YcgUA8lh4k27Ds1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqsVcERw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A0BC4CEF5;
	Tue, 15 Jul 2025 08:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752566764;
	bh=cfdWdUaJGHBSxvMNf4+GHY7FQh+o9KAWC4PmhNHItSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sqsVcERw7ZCCz0bxFem1T+GneGBvPUPpfMFxqQTOWHIHaTBBYqbsOPY3owCPix1ml
	 /IXqf97zYSPyT9d8LPbFq5JIidmPu5/FNtgFR8cFgWA0PHLgeOIWE59hJ8j8n0fjPV
	 bhUSznMiKWnt7AsQ0OhaJMy6h20y9KHbMJwTld/S5bj7YZfcnqJ1ZDn6uFEpV37LKz
	 mF3/4XRkpxh86OjeT8lM6jH8ZSWII4CeUHzBcSW9SJGXxM3WBtlJ0F8kzdqXSM1P+f
	 SpEdOFNPfNZKQ0QsCpbwXkvrru6Gz++Nc0MPsn5q8/UrzoEGniJQnjlntXEopdLymu
	 haBKtV7bDFksQ==
Date: Tue, 15 Jul 2025 10:06:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Yao <richard@scandent.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Akshay Athalye <akshay@scandent.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Andre Przywara <andre.przywara@arm.com>, 
	Junhao Xie <bigfoot@classfun.cn>, Caleb James DeLisle <cjd@cjdns.fr>, 
	Kever Yang <kever.yang@rock-chips.com>, Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add Tianxianwei name
Message-ID: <20250715-prehistoric-chicken-of-genius-5c66b9@krzk-bin>
References: <20250714221804.25691-1-richard@scandent.com>
 <20250714221804.25691-2-richard@scandent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250714221804.25691-2-richard@scandent.com>

On Mon, Jul 14, 2025 at 06:17:59PM -0400, Richard Yao wrote:
> Tianxianwei is a company based in Shenzhen, China, making LCD screens.
> 
> Add their name to the list of vendors.
> 
> Signed-off-by: Richard Yao <richard@scandent.com>

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here. However, there's no
need to repost patches *only* to add the tags. The upstream maintainer
will do that for tags received on the version they apply.

Please read:
https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


