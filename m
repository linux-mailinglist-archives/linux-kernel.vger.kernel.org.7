Return-Path: <linux-kernel+bounces-739832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 085EBB0CBA6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDA43B0880
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F216523B63A;
	Mon, 21 Jul 2025 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYAHn4qa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57546221DAE;
	Mon, 21 Jul 2025 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129089; cv=none; b=XrKVgOND9Vf29W2v2egSmHdp4pbvVp6MOJD1OYEzY1uoaCIPW24deinbuve2kUG7YX0NKn+rG/dInpi7THApVgLAh8P9IoUZsUWswG/iNrQFQZjrlA0UhAVl6rSIz7XFATv978YhwkVMzGYrj3i/aYDZpgrGu+Ibd/hcN5bWzNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129089; c=relaxed/simple;
	bh=83ZLAP62K0xcVnKf6gLrarym58CcSurlQ0JoVc198Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIlQ/CppEyNX1QLeMK6NhDrNFs0GsNJLCCwhUS/O/58j7ilnlfg2POx/mE8sSIKlOYXW+5ajUxVwYmKjqQy/uuiCeM/u9Xjy7et7CJ9dcFYiwR4jjgyfgFiCmAzaHEveAOzVIpB7xMAdRwCOqtcjJiI8VDHvMvzmnInGO+9o5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYAHn4qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A68C4CEF4;
	Mon, 21 Jul 2025 20:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753129088;
	bh=83ZLAP62K0xcVnKf6gLrarym58CcSurlQ0JoVc198Vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gYAHn4qaQR1psQaqpVe2xlR/Z48xfkS5JoGlVdsgKkrUSFcxQ89rXB1mOlKN4W1bE
	 xqtcP2K4oGXznx+XyUe6NNVi410yCxTdLTB7mZXkWE64T+YBX4m0wNcjjD5MrFxE+R
	 FOPHa0p2Nv9+iSXpr68g22U3uPO1oOnNTBMwKCE9PHjmuIcpMNQevLyPDLNCuDLFEH
	 KuNWWu4+B4QrnGEwdQKq6XDhO7v6Wgz3Hg5WgcMHNCkdZPLMiVl1ebDkSe9da5IuZf
	 flF/RXa5cd3IYCxNgVZhqC/D8MpNIYIigRPm8uXFDauBIIX/XzQIqhZltwZ6QswwhN
	 l++WEPtanouDw==
Date: Mon, 21 Jul 2025 15:18:08 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: nvmem: airoha: add SMC eFuses schema
Message-ID: <175312908728.1269914.10346607252640747468.robh@kernel.org>
References: <20250721184640.2885-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721184640.2885-1-ansuelsmth@gmail.com>


On Mon, 21 Jul 2025 20:46:33 +0200, Christian Marangi wrote:
> Add Airoha SMC eFuses schema to document new Airoha SoC AN7581/AN7583
> way of accessing the 2 eFuse bank via the SMC command.
> 
> Each eFuse bank expose 64 eFuse cells of 32 bit used to give information
> on HW Revision, PHY Calibration,  Device Model, Private Key and
> all kind of other info specific to the SoC or the running system.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v2:
> - Drop redundant description for reg
> - Improve example node name
> 
>  .../bindings/nvmem/airoha,smc-efuses.yaml     | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/airoha,smc-efuses.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


