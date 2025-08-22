Return-Path: <linux-kernel+bounces-781322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EE5B3110B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB23616921F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF832EAB62;
	Fri, 22 Aug 2025 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHsW+l5l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314F2269D18;
	Fri, 22 Aug 2025 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849625; cv=none; b=X1T+I5N0/qNAO0fsVYsxcyUey18cTNvTRf1Q+UbZSKMtklD+pFvXEOArpILbk0zqkmLzfg7bg75zFQczawouByptV+cFZKu69xsW5+ldjAW5ucIS5Dguf8SET5LOPYQVMItsDrddl/D+nyOR5/Q9bsgELag3JlZKA3568MJGrUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849625; c=relaxed/simple;
	bh=3LSBrlgPclPcn4MCgtRigx2+6I/Y0aDUi3B5dRZXgJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XddnWDfe2sRYj8Pbx4op2KrxSbM9SA33KjmboM8ttRB/sgIHmsOKvixMPWw7+F5yiOk1nRIKL6itSw2TEYMqFNey8GCt5Ujl8HlRBaa3bDBAUU6zKKIjOqe9AffVW+DE9f58cSlhxXupAutO3Le1No64yiOI+W/A81SE+AJAdug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHsW+l5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED615C4CEF1;
	Fri, 22 Aug 2025 08:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755849624;
	bh=3LSBrlgPclPcn4MCgtRigx2+6I/Y0aDUi3B5dRZXgJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EHsW+l5lBzW6kIrQPVMAzO+pLHcaO9NHZlYPxnKMkHMJ4t0v1jWgeqNJeriGCTOXy
	 4mj7Yj0W1lhPZncT1Q1rcwbsRxk1frpx6p7fK521064HLZoSTKOaSv50jbwGhAff/R
	 IGcREZsoQUt7Fy2BogPc0NRiig+ip1MyOv3g5ntKq2/8rWKboO7f4bhSaFhujEu5CZ
	 PSfI/bxD8EFetgLxg7/grV6GwCEP0bCMmDdQfUc/FVg9Ha6gKVnLj846fyyFWodWhN
	 B02F0I1VKT99cWB6hfO4VHiOUqLVdHXNy+xBcWZ0KRY78b6KttQ2Z+JJfMSCAYO9Kh
	 018gCc3WKLGrw==
Date: Fri, 22 Aug 2025 10:00:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>, 
	Philippe Cornu <philippe.cornu@foss.st.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Christophe Roullier <christophe.roullier@foss.st.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/13] dt-bindings: display: st: add two new
 compatibles to LTDC device
Message-ID: <20250822-gifted-messy-fulmar-1eab63@kuoka>
References: <20250821-drm-misc-next-v4-0-7060500f8fd3@foss.st.com>
 <20250821-drm-misc-next-v4-1-7060500f8fd3@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821-drm-misc-next-v4-1-7060500f8fd3@foss.st.com>

On Thu, Aug 21, 2025 at 01:08:51PM +0200, Raphael Gallais-Pou wrote:
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +        clock-names:
> +          maxItems: 1
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - st,stm32mp251-ltdc
> +    then:
> +      properties:
> +        clocks:

minItems: 2

> +          maxItems: 2
> +        clock-names:

minItems: 2

Best regards,
Krzysztof


