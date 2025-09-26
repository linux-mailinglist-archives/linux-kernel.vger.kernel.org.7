Return-Path: <linux-kernel+bounces-834582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BDFBA4FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CD9D7A924D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5D228312F;
	Fri, 26 Sep 2025 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J75Ie/dG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FADB1C28E;
	Fri, 26 Sep 2025 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758916257; cv=none; b=dvC8MUQyxIgwF2cHDWkQVXhiHdmOLo5bICwOe2lROBUU2CpA0Dk19B+4zpVkbyNS4g1N/3K5Dj5vQZM4Sx1ZHTp+sZXHAy/CCkas+fFv8KMQpKzCVP36z6Tqr2WqAMSnYrMn5O2kj+Ym0TnGxRJO0Yz/ayfotHrsP/KdAPop6J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758916257; c=relaxed/simple;
	bh=oLAw+aM0Zfbc2RkYp9/llnjhZkG2b1+XLWFwVdtfyLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pr22sLsN2rgLOA1pAIwi15foh4HExPeN746fFNZBULxh5YDkkRAnD2T4Mp7c3Mv6+HeNwly8nPzrEwp7ceD8YkWEpDWhMRWi39XpQkCRizDx7Btz9jcp+5Q20YwYsw9BtfDi1feYsl99O1a7jtq2P68mtIZvuccYttGVcjPXLUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J75Ie/dG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2ECC4CEF4;
	Fri, 26 Sep 2025 19:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758916256;
	bh=oLAw+aM0Zfbc2RkYp9/llnjhZkG2b1+XLWFwVdtfyLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J75Ie/dGDUlVUfKlAgQ5BiG63oB4J9hIN1IN2tWeeX7uNKuLckcAaFudDtQsyl++S
	 2YHF1QhfgKh44ybMkUd9209DsWhAJZokL8I5I8JfoqJ3Ugl2fa2UGZ53rEb92AkeTq
	 q3oWxsBDH9290+/R1in5hfW7HgQhRwb9ilm9LJbWX909N4zI39AruhEYt59jF8WFaA
	 hwRu6rnPMLomBVpDkCUb/iQDppOyOXVIQVi+EPYcyXmqrCdJEIeBUb21SPk9+Yb9G9
	 DhkNHlJG8QftXBw8XEE4GTIKK0V/9GeYU/h9GTID4pvkTzciUOj+TTf3ds+E8xBpqW
	 Zj1M/ugVZ+okg==
Date: Fri, 26 Sep 2025 14:50:55 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Saravana Kannan <saravanak@google.com>,
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] of: base: Add of_get_next_child_with_prefix() stub
Message-ID: <175891625400.1384351.13626014737146181126.robh@kernel.org>
References: <20250925195720.2200088-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925195720.2200088-1-helgaas@kernel.org>


On Thu, 25 Sep 2025 14:56:30 -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 1fcc67e3a354 ("of: base: Add for_each_child_of_node_with_prefix()") added
> of_get_next_child_with_prefix() but did not add a stub for the !CONFIG_OF
> case.
> 
> Add a of_get_next_child_with_prefix() stub so users of
> for_each_child_of_node_with_prefix() can be built for compile testing even
> when !CONFIG_OF.
> 
> Fixes: 1fcc67e3a354 ("of: base: Add for_each_child_of_node_with_prefix()")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  include/linux/of.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Applied, thanks!


