Return-Path: <linux-kernel+bounces-731139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A93B04FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FBF23BD5AD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FB52D1F72;
	Tue, 15 Jul 2025 04:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/jWNrds"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37E8946A;
	Tue, 15 Jul 2025 04:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552187; cv=none; b=lflw9FRudCas1dhGZZbfWSqqikRpLmxC1ul3zsBKgIppw9bREpQpESMwPvHzH40Skh82iEuQw0Qy/E5pJz4PyvuL90KZb+9qtugYFBdyJAM2m04f2nUigieUngb9TWuHA1cDvDIj6FtY4VIA1v4fDIxAfiwPHFGf4znOJNWzqyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552187; c=relaxed/simple;
	bh=RzbwxuJaFCbrVE5Vc09Rl3dqeW9ci/Csn6XWWJ2T4Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9ub25AAaq/3opGJBNY4M74VUdCf0TopP6j1q1DGTCPibOFIllOPVk9lrfyQrF6KPIENV1GGXu7g/VD2NDy9JJtngIagfRzYuZTp0TrMUQS4pTEG6FgxjQNckV4JWGD4IkvfQsKUBWhJOuIxqojkWfejAksSAjkzJ7oLQitARNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/jWNrds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F034C4CEE3;
	Tue, 15 Jul 2025 04:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752552187;
	bh=RzbwxuJaFCbrVE5Vc09Rl3dqeW9ci/Csn6XWWJ2T4Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k/jWNrdsUMdUNl6ZgaF3LGtr96yCcXOg7fBUu2BE0/25G+A+dRPSL9jR/Afj0SaAT
	 RuA7/unR9MPxCSebKQhTv6AOv8KBK6F0tQxDhd31pCA1JQT5rUhFEDJbSotfmgPvpG
	 YtO0wnjW4FkgoTc8aTV15ff3U7PKhbg73TX+RMunzYKx18E7yP31JmaJjwTE6wvq/U
	 l22xRdvrc52lVpgbvt6H8Upm0z33WHD/G84RMAq54Xd4JIEVZtoIAR+/v/Apf2N20D
	 +o+Da3spgbaQW7/81hJ6O6XjEPzPh10hbwP67+q6/kIL/rmxdYp3bAqpm+ZtC29aFa
	 cRBD3HIG94RJg==
Date: Mon, 14 Jul 2025 23:03:06 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Richard Yao <richard@scandent.com>
Cc: devicetree@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>, Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Akshay Athalye <akshay@scandent.com>
Subject: Re: [PATCH 2/3] dt-bindings: ilitek-ili9881c: Add Tianxinwei
 TWX700100S0 support
Message-ID: <175255218541.29438.10753274216810305494.robh@kernel.org>
References: <20250714191729.2416-1-richard@scandent.com>
 <20250714191729.2416-3-richard@scandent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714191729.2416-3-richard@scandent.com>


On Mon, 14 Jul 2025 15:17:22 -0400, Richard Yao wrote:
> Document the compatible value for Tianxinwei TWX700100S0 panel.
> 
> Signed-off-by: Richard Yao <richard@scandent.com>
> ---
>  .../devicetree/bindings/display/panel/ilitek,ili9881c.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


