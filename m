Return-Path: <linux-kernel+bounces-847323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E491BCA85C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4ACD482EC7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D354723B63F;
	Thu,  9 Oct 2025 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drtpIj6X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320F686331;
	Thu,  9 Oct 2025 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760033229; cv=none; b=Qu9rBeg601IgOtDqrOzkg729d6igyy556WFOiWSX6w/Wr4k3k6WleXYjof8OwIxT7BLltew1fUdIEh0xh4gOUGmwGkQ6ToKUkpFpIsO07Lg68OBuTEbV8dUiGyCtsBgS3sUbuscLSnjWUtWe2/8xxGPa2qXTM3UIPznDH1xcS6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760033229; c=relaxed/simple;
	bh=5NkPRLVl9HXuFsHMbdyDfRgNelN4F/MsHO6v49XOt8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgA7loZMeyIQMryKxYpyOAiOT6PgE7+ROmsXgeK18N58SHt1KASGFU2aLeF5lO002jcR7gHiaefbtABkdp+/3yhhhH9rk1ptvfbjVe9/6cpIMR2KTKWtQRtkXUYtSLRdYF54ZTKsrHqcUH29UTteuzCcygeBz5ttIA/iPGXv4CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drtpIj6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CBBC4CEE7;
	Thu,  9 Oct 2025 18:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760033225;
	bh=5NkPRLVl9HXuFsHMbdyDfRgNelN4F/MsHO6v49XOt8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=drtpIj6X0q8pLe3CIfr6wdcGlSPou8q2gcPpvd1SHEfKYSU+AAkddIHUJjTrIv807
	 TGHGoPlv9WrWb25e7c3UUTfQghQmdmhQp3ceZeRiG8fqwhNRnWaNFqZ8rqq2ChzmIE
	 fA5v3m2PYEKJ8h9pN4CW9BYrXNPiFBAkOGflzu20sV5aRN0j6Zilt3Qu0x7Ahc/f4r
	 LmNWWZphaZS1/lmXgLQcDfvfyz1hPeuAx/rW0Uk0m24tueCmPB+oQOxBqDjWFftZLw
	 gzwFrSQEnfBoiAkkWTS9s+ElXAJRb2u1klQQ9iRaQolP261L5O7JVlA85DeWRoOGmV
	 VsVzDtsR76a9w==
Date: Thu, 9 Oct 2025 13:07:04 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: linux-clk@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-amlogic@lists.infradead.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 01/19] dt-bindings: clock: Add Amlogic A4 SCMI clock
 controller
Message-ID: <176003322350.2944342.8960430626570483433.robh@kernel.org>
References: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
 <20250930-a4_a5_add_clock_driver-v1-1-a9acf7951589@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-a4_a5_add_clock_driver-v1-1-a9acf7951589@amlogic.com>


On Tue, 30 Sep 2025 17:37:14 +0800, Chuan Liu wrote:
> Add the SCMI clock controller dt-bindings for Amlogic A4 SoC family.
> 
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
>  include/dt-bindings/clock/amlogic,a4-scmi-clkc.h | 42 ++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


