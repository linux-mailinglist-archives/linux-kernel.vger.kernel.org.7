Return-Path: <linux-kernel+bounces-891711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C005C434E9
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 22:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44EF84E8217
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 21:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3902F28C5AA;
	Sat,  8 Nov 2025 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPDhFwLC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BA128A72B
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762636787; cv=none; b=aKqmQK70BelGBk3Aw/oY2/YLWTjTfQNKr52hna4Plk6sESMbywTm0YjJmYqQiRwLzPNl/70n5ZoCHB0yRu5+CAZgWGImro9dwstfeabO0EvasC3PhXzZ4Sfh8X7k6XHxXEOkSq4pNAmS8MHh/1SWJC0CkBIOgmRYtsDq14RzSsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762636787; c=relaxed/simple;
	bh=jCZQZvHhcMirptJpnvRkq9bH40aTwahZMO8Q0GKOqg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPCqbK8epKfwhXTRk1vu+T/yXD3epGfQbNCWf2OHzjt+3q012iAKsenF7DE36E8llAT0eB+MJIbL+bln6vzuv+ViKI2iEbnE1gmEVQXvCyWuWj89Z3J9nRsfgYjjymI1uwW+VOme5DpcacxuNrXBNQmNuIi6HeES83MO/8MAw8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPDhFwLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6F3C19424;
	Sat,  8 Nov 2025 21:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762636787;
	bh=jCZQZvHhcMirptJpnvRkq9bH40aTwahZMO8Q0GKOqg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPDhFwLC2W0sd4IUXzNGgASWzHtinEBoRcHRQckl6o3vJUFnssylAvYpTdwEZ2Bna
	 KAuQkk5riDP4ZM5rKsWJvM3W94856vFSyfkOHtY3zQWmMVviQJ9PnukfqIXU9PnKIe
	 hRYzNWu6/o67vtrD2w47u8QHTwKHsLMGvoWIBcek+HNN24lLuC7WngDPcKuXooLw9f
	 EM8QDcUGpqwzmfilyxsQNT62xiMZsqNO1PeJ2idXR5gKASG32N9zTNlQkou9rIAQ4z
	 AwnRk1Qjq7jnRhaw+UGMamJ5KPyhRHiZirz9N+MHTilNtjh4rayeR7D9PZWKV+UyII
	 UmnZg/XmxHZXg==
Date: Sat, 8 Nov 2025 22:15:50 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	J =?iso-8859-1?Q?=2E_Neusch=E4fer?= <j.ne@posteo.net>,
	Tom Rini <trini@konsulko.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/7] scripts/make_fit: Move dtb processing into a
 function
Message-ID: <aQ-zBvQ9obaWRMYG@levanger>
References: <20251006230205.521341-1-sjg@chromium.org>
 <20251006230205.521341-4-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006230205.521341-4-sjg@chromium.org>

On Mon, Oct 06, 2025 at 05:01:54PM -0600, Simon Glass wrote:
> Since build_fit() is getting quite long, move the dtb processing into a
> separate function.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 

Reviewed-by: Nicolas Schier <nsc@kernel.org>

-- 
Nicolas

