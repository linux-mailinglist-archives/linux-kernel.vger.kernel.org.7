Return-Path: <linux-kernel+bounces-651453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB87AAB9EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 16:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91E31BC2B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 14:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEF2192B84;
	Fri, 16 May 2025 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWTIhTi1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445CF14884C;
	Fri, 16 May 2025 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747405940; cv=none; b=ggz01h3s3ZyK53uH0455OfyEVOhEe7ELjSdnZqCP1HfJsDY1POkyJ8juQpHhnlitluDBSYU8AFHVSuWx5HNVLNnLyVWHjS/2FEpr9mGhxebG2LTrQONMAqUDOs0GcYv1OaajbNH1sgr5OJGjTKBNyy9UIKOGKcZgXbbbBFkTnls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747405940; c=relaxed/simple;
	bh=E61O55q6UktoNqtIVZI86pVw7KFKbc5kPfAwhVWnqpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myJBxwqOYCh9y4X58gmIoz4eoi1mP4LMEgY6iIGr+l7eXweMIp4/p4mRlW6w75rhTFrxcTLXeO8bQA4l+YIChpgnCn9s8/kNTzn9QxTy/1GArJKgBQnPWtplAwPk9K53cfNGASdLTpkjWR8qrd+4lMYKtiFwF2fbHl/9AzPGn9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWTIhTi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DFCC4CEE4;
	Fri, 16 May 2025 14:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747405938;
	bh=E61O55q6UktoNqtIVZI86pVw7KFKbc5kPfAwhVWnqpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RWTIhTi1MNaNFwp7zWk7ELiRpUFWnDwGbP29IoJF3McVx/FS5/ZPlas/gGFEKluBU
	 CvrWyZP6eKDTR0gzdXgeLxRs7fPRuLdXv7VrKiCDLKzenjgC5RbU5BAnGxt2MnhVvS
	 zagHmUmi82y54v+FZAySqjsgcXXf8EYExOXj/LCt6CAShrbnlhU/bq6Xb4IpO2N8tE
	 V+FC/C+rzgKaNIoYEaQ/Bpb98yJRfW1QSzYCbtQaATLp2E6iKtTcDu346He/bBknju
	 ANuLxdYuiPFXlq3EgX2lB2myUyjll+2FebCSr2WaMpfitg59e0eb2HiVYiDzxm7tOI
	 d1nRfNd/tAYlA==
Date: Fri, 16 May 2025 07:32:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: weishangjuan@eswincomputing.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 p.zabel@pengutronix.de, yong.liang.choong@linux.intel.com,
 rmk+kernel@armlinux.org.uk, jszhang@kernel.org, inochiama@gmail.com,
 jan.petrous@oss.nxp.com, dfustini@tenstorrent.com, 0x1207@gmail.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
 linmin@eswincomputing.com, lizhi2@eswincomputing.com
Subject: Re: [PATCH v1 2/2] ethernet: eswin: Add eic7700 ethernet driver
Message-ID: <20250516073217.115fc170@kernel.org>
In-Reply-To: <20250516011130.818-1-weishangjuan@eswincomputing.com>
References: <20250516010849.784-1-weishangjuan@eswincomputing.com>
	<20250516011130.818-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 09:11:28 +0800 weishangjuan@eswincomputing.com
wrote:
> +	dwc_priv->clk_tx = devm_clk_get(&pdev->dev, "tx");
> +	if (IS_ERR(plat_dat->pclk)) {

you're checking the wrong pointer here

> +		dev_err(&pdev->dev, "tx clock not found.\n");
> +		return PTR_ERR(dwc_priv->clk_tx);
-- 
pw-bot: cr

