Return-Path: <linux-kernel+bounces-778622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9E1B2E81F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0527C1897867
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 22:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FA129B233;
	Wed, 20 Aug 2025 22:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaXF3bix"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8CC27E1D0;
	Wed, 20 Aug 2025 22:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755728686; cv=none; b=b/bmHldTx7gp8y//qRpv8HEQfjPjKi37y48Y2av1ez7CoY+kh0a/10ig+VhbJS8zS3I4sNggTRGCLwYbd6MVob/p/iX7dkbnECXuim0rfNVdLvHt0UzpW/FkKE1IDra2sbmUSteMnZCzndni4HEkNTicavC0b6QMYkNbtoOVFRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755728686; c=relaxed/simple;
	bh=r0FZZzrkYMRC61kJQyjIVLnotSFQk8CEf6SU3rv4psQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMIYYZnKmelRKAJSuDHaA9Nz9ajqLj+P12r8ZC9+jPO6B+4jGVfaErkQol8MU9B1goayNqcgu9GcSNknnQCTxo8FL/3gr2ZgXv0xEW+n2HbYCiRiGXmt87PSLVb4lGM8YTWfV57wOOGIkMc9x/XVRhyY8/MNsbjKqwXazNgVAXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaXF3bix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E21C4CEE7;
	Wed, 20 Aug 2025 22:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755728686;
	bh=r0FZZzrkYMRC61kJQyjIVLnotSFQk8CEf6SU3rv4psQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RaXF3bixgE8jHi2EtWyJBBAMqT6XJzFeNTwD4IOg8L5vgGZAMvYL5+aHpmSri5UFO
	 QdmgO+l6/XXroAbrhuixzZ1jQT9nodFkzhY/hlYtoby5KBCb/uzx6QTUU1taKhRJZ1
	 APCOFtPm75cqXCNedcn0A8fMuL3iLEU8ZynDf1yynIuTNc2hNntkSHjqSQiPKxYpmV
	 dCcPaQcUWhquDug1xk0kYOTZeXNtdRpjLNxxi1CKkN8gZm6b7I+ZYtSXdrB2gosZUk
	 kC3X8ZEuhr/+NJCX7+gQ/YDFPipZWDDNeOUt7n3CmntLyXM7wfWFrGZqOuBuw8O+2x
	 YNO20IPwYZgew==
Date: Wed, 20 Aug 2025 17:24:45 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: dt: writing-bindings: Document node name ABI and
 simple-mfd
Message-ID: <175572868343.1564032.6590237767039466297.robh@kernel.org>
References: <20250818132534.120217-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818132534.120217-2-krzysztof.kozlowski@linaro.org>


On Mon, 18 Aug 2025 15:25:35 +0200, Krzysztof Kozlowski wrote:
> Document established Devicetree bindings maintainers review practice:
> 
> 1. Device node names should not be treated as an ABI, unless for
>    children of a device when documented.
>    There were many patches posted using of_find_node_by_name() or
>    of_node_name_eq() for accessing siblings or completely different
>    nodes.  These cases were introducing undocumented ABI, so they are
>    discouraged.
> 
> 2. 'simple-mfd' means children do not depend on parent device resources.
>    'simple-bus' is so simple, that even 'reg' properties are not
>    applicable.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/writing-bindings.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Applied, thanks!


