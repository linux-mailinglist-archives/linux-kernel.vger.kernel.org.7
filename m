Return-Path: <linux-kernel+bounces-782692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C06B323B9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5C44B636E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF34F2D836D;
	Fri, 22 Aug 2025 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kydeRBtb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F01E2C3257;
	Fri, 22 Aug 2025 20:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755895328; cv=none; b=VrzhCPcu85g1IF+Lw9GdHhmyp36eLJZhYiOqGiiLGnn5qJjGf92kCRMCRRFztNYT/9BsHs55ncJQ3iRufBQErxrfscSB1J3HQkbQs5AvuQFRcRaIflHLsQnkMqLQy4B5TeLjVpyaTm5gBQcruSpRghPobFm8n3Ir/MhqTCQEqmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755895328; c=relaxed/simple;
	bh=6jXONWG2krqCX3GZHWzz+qVsRxP7y8udyIW1JdhuaHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxTfzxU5bDdrn5WLgNKOAA5MFuln22o4MWZ0tGzwKf008LBnBTnBFOS7np51pu3dCuYv77gl2X4poJC9Cg9Q3vKR8ZMcshNgXUcdzkWMNxkSLXGAS4dsy5JqVl8Mnbi4td/8uUhRzteMNXxcRSF4aK6jRIb4eN5YELs6snKua8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kydeRBtb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A595CC4CEED;
	Fri, 22 Aug 2025 20:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755895327;
	bh=6jXONWG2krqCX3GZHWzz+qVsRxP7y8udyIW1JdhuaHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kydeRBtbK3tTb7xdheibN9E6KN6VB72VcMKzmRbiywCMcQVFw5yA3P8URTKU+QNfb
	 +qWESeOPFIBh7yDXYyVSklmtdF24IOBxchNuUZgzk/v0qORBWYfLD3s7P1RkLQ2Sp8
	 Cd/xdjQpg8wEEJ/x2J4WlDxtQ//lqwg54rJm6XrI73yaZSZnm/GTPfVARlOBCkX/7b
	 BV4+QmB759/JD12BAcmTVMEx7GS4LHiK5YB0DEgiUMOOO1H+8HK+Db8KGu5QOuoFGU
	 zZdA0biMkopB7gN42mGZ2u7RpZndioixd9DQ+Fck864UFYU7C0oV9P2wZJtHoY8wrn
	 Aw6B8YNymWa2A==
Date: Fri, 22 Aug 2025 15:42:06 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: devicetree@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
	Lizhi Hou <lizhi.hou@amd.com>, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] of: dynamic: Fix use after free in
 of_changeset_add_prop_helper()
Message-ID: <175589532447.468618.6588165651393821613.robh@kernel.org>
References: <aKgljjhnpa4lVpdx@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKgljjhnpa4lVpdx@stanley.mountain>


On Fri, 22 Aug 2025 11:08:46 +0300, Dan Carpenter wrote:
> If the of_changeset_add_property() function call fails, then this code
> frees "new_pp" and then dereference it on the next line.  Return the
> error code directly instead.
> 
> Fixes: c81f6ce16785 ("of: dynamic: Fix memleak when of_pci_add_properties() failed")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/of/dynamic.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Applied, thanks!


