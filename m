Return-Path: <linux-kernel+bounces-783526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AE5B32EA5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1601B61B62
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AA325A2BB;
	Sun, 24 Aug 2025 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZkTQofv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC733632;
	Sun, 24 Aug 2025 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756027070; cv=none; b=dlfzFD7IVn0gx0pCZUStx90EhYjmVIKgfMxX8mqiDppndR8WKHnzaEI38uU1zfP8ta/3Cx20KUvaqJuwwSgpCalKLUK8HRG7/+w2Rl0kf6HZM+XLtCzl64kOng2pXVFp1bIsw7QaVSCeimhrb7sL2DUTX+IFgB+7fv5dPKbBIvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756027070; c=relaxed/simple;
	bh=jinKs9M9SsWSapSFLwNM1upSb/lbJZAvi3hz/+0HfSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XG2V8GUvydryAILPTH7Qkx3O4kxHk8qMArK2QKdjPRMUD/Wm4OSTtPkvqrFLLPHNkEPW4sp4OvyLWiotV0azECVM9LgJSdKaOZvC64/wnFFEPnxQA77mMaZgbwbZLKUprFzaGnuJgwOTZhF5A7OJ6HMSno4Z4QgYXSSNuIM+6tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZkTQofv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C486C4CEEB;
	Sun, 24 Aug 2025 09:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756027070;
	bh=jinKs9M9SsWSapSFLwNM1upSb/lbJZAvi3hz/+0HfSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PZkTQofv3Xm/b0rEz32aFoM9RmQKdLmYxSjGP/2nVfyF2lR/OI9VEKeW5oECKykDY
	 eOHuKczmfeMm6dmbAibez9Ury++n5XYn5et8w31pGzvPPGmeqTQnLMd0aXG3KcCxgt
	 N8nYAktjsJiUkaEDjbikikulrjFAxSuMqjs+fyWG1tlFV750wDjQVNvEuR5F5NwM6P
	 KuJjLXSc6qQVOgZrhStXvfdHk+kU22a4dCq1DpOQfTx9anm3SHmwe1X6inM6J50X1c
	 14X1Ia04UTggKLxug393Tz/W3f/V71r9oPB36UU2TT0OfQOfYReKEFm+IxTzO6rO8L
	 NV5WufU9AnnNw==
Date: Sun, 24 Aug 2025 11:17:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: robh@kernel.org, gregkh@linuxfoundation.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, peter.ujfalusi@gmail.com, devicetree@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v6 1/2] usb: dt-bindings: ti,twl4030-usb: convert to DT
 schema
Message-ID: <20250824-enthusiastic-primitive-bird-a5a605@kuoka>
References: <20250822201727.71593-1-jihed.chaibi.dev@gmail.com>
 <20250822201727.71593-2-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250822201727.71593-2-jihed.chaibi.dev@gmail.com>

On Fri, Aug 22, 2025 at 10:17:26PM +0200, Jihed Chaibi wrote:
> Convert the legacy TXT binding for the TWL4030 USB module
> to the modern YAML DT schema format. This adds formal validation
> and improves documentation using a conditional schema.
> 
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> 
> ---
> Changes in v6:
>  - Reworked 'interrupts' property to use a list of items with
>    descriptions instead of a single free-form text block.
> 
> Changes in v5:
>  - Split combined twlxxxx-usb binding into a dedicated file for
>    twl4030-usb per maintainer feedback.
>  - Used more accurate header for interrupt macros.
>  - Improved formatting in the examples.
> 
> Changes in v4:
>  - This patch is split from larger series per maintainer feedback.
>  - v3 link:
>     https://lore.kernel.org/all/20250816021523.167049-1-jihed.chaibi.dev@gmail.com/
>  - Removed i2c node as it wasn't required by the old binding file.
>  - Updated node names to 'usb' and 'usb-phy' in the examples to follow
>    generic naming conventions per the Device Tree specification.
>  - Replaced raw interrupt values with standard defines for clarity.
>  - Improved formatting in the examples for clarity and consistency.
> 
> Changes in v3:
>  - No changes.
> 
> Changes in v2:
>  - Added '#phy-cells' property to support PHY framework integration.
> ---
>  .../bindings/usb/ti,twl4030-usb.yaml          | 74 +++++++++++++++++++

I asked to drop here parts of converted binding.

Best regards,
Krzysztof


