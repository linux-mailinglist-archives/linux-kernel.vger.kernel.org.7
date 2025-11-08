Return-Path: <linux-kernel+bounces-891709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE52C434E0
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 22:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94BA93B192D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 21:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248EA283C83;
	Sat,  8 Nov 2025 21:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDMlrKid"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC8D26ACB
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 21:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762636782; cv=none; b=Bd7B2A0y40e8OUUV7sblMU3KNw5nSDOewXvo89JV0cybX0bXSh0PaOpl1B9mFEaS28M6QyueaQJfXIM+7rVJVpJV7tzbF0T93vkQX+cR/lEn27y9b5FnLFLRiC2z93vg2BEiLdytUV0lPQ2kDxjOvL9qrHKUQdY61T14TdBGSLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762636782; c=relaxed/simple;
	bh=mZBsIKRxZAfCP/AlJVftP7beNGOQUluIE3BGP9P1dw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwRYgp/SXlB+2FMnNzYtJz8MSAzmHrU/3gfTQCwosah0VoMJNbTT2JumlTDulfoOVPNTEdnBjnT+NR8A2LxON5S8/WwXJkQGpv55FNP392lLO3G1burU1gqctehzDVnAJG8v1nXtJBcrNlz0sGLms/wJcmRVz92u1VYAnh8uzRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDMlrKid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE8AC19421;
	Sat,  8 Nov 2025 21:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762636782;
	bh=mZBsIKRxZAfCP/AlJVftP7beNGOQUluIE3BGP9P1dw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vDMlrKidahpBtOn2ZlZEV2PBA/P88eO5JznXyzI1JZdTtFycjYBsB5VNduiV2cqAD
	 qXyDl+1ttAL9sBfgG0peDfmavGmVvXr7LYnxUEjXEgqFNG9f+YK4sa+lFIbxFC4QO6
	 0HvTEKyoMZa9FQlfGeXa35IHUNqaJLG2up8TPg5GjbvtjlbOzL2cUv23roWzK94EuH
	 AbATx/ci6IaKz1tNR0tdfrEXGcLljVMNQgNqMjDaEWoHU6H5BaqhnoUwhwkbPIfw6j
	 pXT83X0x1Kp6qiKfG7kRtBUsKXsXKPtq66I1J8mHPqS6vD+Gtwnt5JfGb/txAhrZR6
	 Q4mGAJ3aG0yRg==
Date: Sat, 8 Nov 2025 22:14:49 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	J =?iso-8859-1?Q?=2E_Neusch=E4fer?= <j.ne@posteo.net>,
	Tom Rini <trini@konsulko.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/7] scripts/make_fit: Speed up operation
Message-ID: <aQ-yyfwbGJNTS6N5@levanger>
References: <20251006230205.521341-1-sjg@chromium.org>
 <20251006230205.521341-2-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006230205.521341-2-sjg@chromium.org>

On Mon, Oct 06, 2025 at 05:01:52PM -0600, Simon Glass wrote:
> The kernel is likely at least 16MB so we may as well use that as a step
> size when reallocating space for the FIT in memory. Pack the FIT at the
> end, so there is no wasted space.
> 
> This reduces the time to pack by an order of magnitude, or so.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 

Reviewed-by: Nicolas Schier <nsc@kernel.org>


-- 
Nicolas

