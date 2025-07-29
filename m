Return-Path: <linux-kernel+bounces-749674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 302A9B15160
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD2F3B6944
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D732264D3;
	Tue, 29 Jul 2025 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSDzJN4q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497BA2264B7;
	Tue, 29 Jul 2025 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806769; cv=none; b=L3xdGx0YPDyT1NQCoqeJ7Aj19njLyIpFe9HhuvflUJtEqU2AI0VgA8q+C5UhAqpHCYOcK1gxOOlJV51ql2ZRRXyYeX292RlrDIqYZnbC7JLMmzo3+7sNxTcipuC8MW1CtVz8ZqfF3seRLJyr0c3OSZM0ltbXbDP0X79XAsvglFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806769; c=relaxed/simple;
	bh=4Q/A4r8d1ZQG3FbhyPguPVRCWfgSCwtAKYlECW9aL8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/kgQ/gwZXhlA7x9eexhKZcgvzXIWv8314cPmaeVpNDMtbWr/BSZ72H3zJNCASbyFCvoD6iJTvPZftyNnasgMhOMh8nXVb3EtuBtGlhonDWxCjsjxMr5FUw2pH0pE/sBvjxk1PuKbQO/YILi9JumKb0J0YYIDW/6XHRLnfSr4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSDzJN4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3A9C4CEF4;
	Tue, 29 Jul 2025 16:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753806769;
	bh=4Q/A4r8d1ZQG3FbhyPguPVRCWfgSCwtAKYlECW9aL8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSDzJN4qfDySDa3inQAme1/5ohrxBxAW/m6YDS4aZWvssxOisP/Qrif3iXkCfvyVq
	 gE1dlFv2TJ2qocOnrCdmyhnChms0rISSR/pkTd9pVUb+mJcQ5LJI4hsdauM4CsJc4T
	 OGglGeFVQjf8GmrSN/16Bue5Jjap/Xm3SsersBB4klsxCfFjQcVBL4MWVqMyX4HxqR
	 KOYNUkLjKrlIJ1y83HloS3aPL+q2T0xEbeDtfsjzrLKLC65OsF8LgsVhNwliWhFbRf
	 EWD2G78Gs0vzKVg4B7mybseNtKrOtw5WdRdDTNSUaHKXVoixG0zu0p6kkiAsCdHyXX
	 XBlae83qbcz+Q==
Date: Tue, 29 Jul 2025 11:32:48 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	Philippe Cornu <philippe.cornu@foss.st.com>,
	Simona Vetter <simona@ffwll.ch>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Yannick Fertre <yannick.fertre@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 05/12] dt-bindings: arm: stm32: add required #clock-cells
 property
Message-ID: <175380676749.513254.17364402562772205374.robh@kernel.org>
References: <20250725-drm-misc-next-v1-0-a59848e62cf9@foss.st.com>
 <20250725-drm-misc-next-v1-5-a59848e62cf9@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725-drm-misc-next-v1-5-a59848e62cf9@foss.st.com>


On Fri, 25 Jul 2025 12:03:57 +0200, Raphael Gallais-Pou wrote:
> On STM32MP25 SoC, the syscfg peripheral provides a clock to the display
> subsystem through a multiplexer.  Since it only provides a single clock,
> the cell value is 0.
> 
> Doing so allows the clock consumers to reach the peripheral and gate the
> clock accordingly.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>  .../bindings/arm/stm32/st,stm32-syscon.yaml        | 31 +++++++++++++++-------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


