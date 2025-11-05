Return-Path: <linux-kernel+bounces-886063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5752EC34A06
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADD4561FE8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFFB2EC56F;
	Wed,  5 Nov 2025 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYQsUvuF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9572E7BA0;
	Wed,  5 Nov 2025 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332923; cv=none; b=R/8U2Gsa2wQn8VwUK0ACQlP1n5TzcWArd/m+9BAqhIRh7HFci7ckuF7JRBVfFIRbeRe0ZOFA5CaDrYKxbK+3SlY+t7EJJoPNP+93szCzcWj669HfWgRkY+3LnIrAeI5/Xr3/KoYCwesd2dsRSQZUuzwS8MtcNdlLpmZcgaZk0Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332923; c=relaxed/simple;
	bh=q2HC6BJNcGczMQ4oM0u2Hv/pTJcPtCPZlJD79dhiWOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pn94moHGFp/ldnz5Undv4s+/xq1n2YZJVYXFlVPelnusx6rHD5J+1fdPXsojZP4ycZ+c52BBbcIzqwVaF6BH8D8hqeO17vrIIjqJbmPOgmsESv6+fOKFnGo3IEqbMyb5Gqn0uCEJ2+lHP/rHuC82F6QcdeaDTF/Eruwv5pjxnsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYQsUvuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644C5C4CEF8;
	Wed,  5 Nov 2025 08:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762332922;
	bh=q2HC6BJNcGczMQ4oM0u2Hv/pTJcPtCPZlJD79dhiWOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gYQsUvuFU7j6zma2SH7ae6HUyFpK2svx5uMUr2Ek79kxlgEHMA04WfdZL7BGa8Mja
	 IJM2vMMgSq1MRGlUiv4VxZzEUgkiN6dlH69DPvDhoEG8nzqFZeJIBE5a45CJqPjcvh
	 TKJbqUkiI0/L5E8Ye4Ecny5fRPy/6NuvHon6Vr/fUhsVb6kdSvk4c/xMuvxmUlbel3
	 bGmzjB9NJyGbl7M6Stc1AP2QmhMZBXCll7aMFci0Yq/YJ9ctaH1fFvxlUf3AiWSuof
	 sl4BXH+wZOt6HZD6AS8PXANkZ/pWTsAHjGOyshy7wg/myyovBbN5SiM6G/ONZI9/Cg
	 ZAzBTMwwQQQJQ==
Date: Wed, 5 Nov 2025 09:55:20 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dan.carpenter@linaro.org, kernel-team@android.com, willmcvicker@google.com, arnd@arndb.de
Subject: Re: [PATCH 1/2] dt-bindings: soc: samsung: exynos-pmu: remove syscon
 for google,gs101-pmu
Message-ID: <20251105-guillemot-of-demonic-courtesy-6127ac@kuoka>
References: <20251103-remove-pmu-syscon-compat-v1-0-f2cb7f9ade6f@linaro.org>
 <20251103-remove-pmu-syscon-compat-v1-1-f2cb7f9ade6f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103-remove-pmu-syscon-compat-v1-1-f2cb7f9ade6f@linaro.org>

On Mon, Nov 03, 2025 at 08:03:10AM +0000, Peter Griffin wrote:
> Since commit ba5095ebbc7a ("mfd: syscon: Allow syscon nodes without a
> "syscon" compatible") it is possible to register a regmap without the
> syscon compatible in the node.
> 
> Update the bindings for google,gs101-pmu so that the syscon compatible is

That's an ABI break...

> no longer required. As it isn't really correct to claim we are compatible with
> syscon (as a mmio regmap created by syscon will not work on gs101).

... with kind of a reason, but then the question I have: was the
standard MMIO regmap exposed via syscon ever working for any part of
this PMU?

Original posting here:
https://lore.kernel.org/all/20231209233106.147416-2-peter.griffin@linaro.org/
did not change PMU driver and did not express that the syscon is broken.

Best regards,
Krzysztof


