Return-Path: <linux-kernel+bounces-761904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF661B1FFCD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B2867A06D9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A40C2D949F;
	Mon, 11 Aug 2025 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3HNTFHT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4332727F0;
	Mon, 11 Aug 2025 07:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895718; cv=none; b=VPkqLzif/V60CcOvnTHDE0dwwSN031lFSP2Zcc280AW424i0iSxCNiJ2XyLPHUvc47Mk2smEwBNkjSCFUxV4VsIGltC/4RE6FHevD2Bxo2QoLWWfBzgiUFsnCTsK6hYpctAnXgH5gAeoH9An6cPWuVNKSGOtDU2F98gbJDUSPUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895718; c=relaxed/simple;
	bh=6dqeJkISmTgPXUlwm9dVSp9RFaKYadSShyA4W7vDHrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+LdguzqJRdHb8oGpF08eBq9LuMdLf9tuDxs36y2HECRB8QQGBYWhIDjCC6aNB0Ci8oWzCYHSphY1DkpLtzTldUddhynSHNUAyrEpH47nH3TpiwrDMlrokIYBx/Xszv0wo9OpdqPFTR11kLYE9MquH+C25FhIynMOZ1AjIU94Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3HNTFHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AD9C4CEED;
	Mon, 11 Aug 2025 07:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754895716;
	bh=6dqeJkISmTgPXUlwm9dVSp9RFaKYadSShyA4W7vDHrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n3HNTFHT9zCFOeF7qiZ78tbSN6HJlbJaNc1Obm7WXSohw13ukL+rwtRaK/VIb9IlN
	 AnONkR5Uwq7LICq4egfqe6avx20hYmxZ4Xx29SYOHezfMUhH7zzb+7yUzU4hy7ethH
	 kPysCsbjMEbDXeNOJF1nMrB81dWmMEhwgZWeZbkdWhR5REsRJKaxNuuLhGX79oaXpg
	 Hr5g3Ii5qvbbmr370nZWFqK8sZxhyRdWYNGcGCw0GbGWhk2P3X3Y4ghET04lKCcVre
	 Ipm8wj4EBrsF8PCypLiRlDldfJWX6IJS/gCf52sC1yvGpv8OBYH12enY7S6k2i+oaG
	 l+5N/lMCEOymA==
Date: Mon, 11 Aug 2025 09:01:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aman Kumar Pandey <aman.kumarpandey@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org, 
	alexandre.belloni@bootlin.com, krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, broonie@kernel.org, lee@kernel.org, vikash.bansal@nxp.com, 
	priyanka.jain@nxp.com, shashank.rebbapragada@nxp.com, Frank.Li@nxp.com
Subject: Re: [PATCH v3 2/2] mfd: i3c: Add driver for NXP P3H2x4x i3c-hub
 device
Message-ID: <20250811-peculiar-kind-condor-ce8cd6@kuoka>
References: <20250808132033.3996614-1-aman.kumarpandey@nxp.com>
 <20250808132033.3996614-2-aman.kumarpandey@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250808132033.3996614-2-aman.kumarpandey@nxp.com>

On Fri, Aug 08, 2025 at 04:20:33PM +0300, Aman Kumar Pandey wrote:
> +static int p3h2x4x_device_probe_i3c(struct i3c_device *i3cdev)
> +{
> +	struct p3h2x4x_dev *p3h2x4x;
> +	int ret;
> +
> +	p3h2x4x = devm_kzalloc(&i3cdev->dev, sizeof(*p3h2x4x), GFP_KERNEL);
> +	if (!p3h2x4x)
> +		return -ENOMEM;
> +
> +	i3cdev_set_drvdata(i3cdev, p3h2x4x);
> +
> +	p3h2x4x->regmap = devm_regmap_init_i3c(i3cdev, &p3h2x4x_regmap_config);
> +	if (IS_ERR(p3h2x4x->regmap)) {
> +		ret = PTR_ERR(p3h2x4x->regmap);

Drop, don't create useless assignments.

> +		return dev_err_probe(&i3cdev->dev, ret, "Failed to register I3C HUB regmap\n");

Best regards,
Krzysztof


