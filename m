Return-Path: <linux-kernel+bounces-792203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AD6B3C16B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2AC23BE691
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4D9338F56;
	Fri, 29 Aug 2025 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvsn2Qco"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0C21E3769;
	Fri, 29 Aug 2025 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486701; cv=none; b=IhIYq7djOzKnSbyLuqT7IBNkiZciRDLvywmKTjof5DjO9iPg90sZLDVuoLG6eV+mofpuR2tEzsl5y3K8LfmHoA4xNpxnalUj8/pjUGwgsZhJp9iDOkvzrYKbd6rxUNkQlkaf7N4AglcjqBf2z1zFJfa0TRc1+/nODJjJFCciYzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486701; c=relaxed/simple;
	bh=JYmJwogPycI2eDwU4MCvRxDzTmigXC0hffGa0/ENy8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvDkUleyDqhvcDdOLag+l1i16OGLlUGpzpr/4IhxZVd33yXJ095+NfgSzqt35whS7UVuh0M762Wenhm6nRzAWhlbXlGTwKOFC8qWkKirysVF4oKOQQyeiFRa2fYisL073pFwMczDzo5MHSFx9ilg1Yej3h4IYryOshngwK0ujvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvsn2Qco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AD6C4CEF5;
	Fri, 29 Aug 2025 16:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756486701;
	bh=JYmJwogPycI2eDwU4MCvRxDzTmigXC0hffGa0/ENy8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvsn2Qcoc7kwgqLRJlNWUmvBN2LvpmHHbaYum4F5uGTWjgPLPWCfBplbljBc3H3GM
	 uZGZmPhEvtoFdW2nFrGoq9oTHREPLVAw4v3ul4AOc5G2ZeaiDShxsdekfmYiYt6Djz
	 HHMK7CLBI5nU+TFjwS351AoCW7biWv8EfWaD/E/Ss1EAfSyn66TV484mTA1r/JSgxX
	 bMpZ6A98B4f4+nDmyt2W5kGdMYVIdhy7pf1WdO/QHCumXKVPvwcmW4tMNFSTrX77pz
	 Uu4YrLD1SINkwNCPnypVuln08OEEOJSXL7dN7tEGNBBM4lNoF+OUD+NkpXAf3tu8jf
	 yhUMeSOXGk6yA==
Date: Fri, 29 Aug 2025 11:58:18 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Igor Belwon <igor.belwon@mentallysanemainliners.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: arm: cpus: Allow
 fsl,soc-operating-points for i.MX6
Message-ID: <20250829165818.GA1009731-robh@kernel.org>
References: <20250827210912.92029-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827210912.92029-1-Frank.Li@nxp.com>

On Wed, Aug 27, 2025 at 05:09:11PM -0400, Frank Li wrote:
> The old i.MX6 (over 10 years) chip use fsl,soc-operating-points to get
> SoC's voltage and frequency information when cpu change frequency.
> 
> Set fsl,soc-operating-points deprecated.
> 
> Allow soc-supply property and set it deprecated.
> 
> Fix bunch of CHECK_DTBS warnings:
>   arch/arm/boot/dts/nxp/imx/imx6ul-prti6g.dtb: cpu@0 (arm,cortex-a7): Unevaluated properties are not allowed ('fsl,soc-operating-points', 'soc-supply' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/arm/cpus.yaml#
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied, thanks.

