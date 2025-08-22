Return-Path: <linux-kernel+bounces-780900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 247DBB30AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D95AA2C72
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 01:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160A61A9F90;
	Fri, 22 Aug 2025 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRvtGpar"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7033019CC27;
	Fri, 22 Aug 2025 01:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755825601; cv=none; b=nCVzc9hAeyTjN0FlaD8KcSnwqJMF8p20CfNYP0CEY4LFSX3GAlZpQxhirK9S6A0Mchznq4lJjscuK0khviF9DRYn4Uy1OoPpPS1A2ux1KvKCujWD3octx7zeXHRRrF/lKhD2A0upuEoWh7KJdzpL32JhVmiYAiVnDJI9bbAqUQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755825601; c=relaxed/simple;
	bh=NMmngW6kEuVZFBGp33Fk+XgPx3vkCKpVM44b3gDSQ8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrkZ0gcrIg7wHeAbE9GzIx5F8M9ndJsuKkFq07F9qxbqPQNzuauXvMnW9uyYNcRzMTrtkfsnCOCdF9Et8HReI9+SRvIoJeHBKuJwncECWGOvKsH+RDtVHO7VlTfF4Jbro5yzpZDZryZunrCjVCmZyEFTCIrAgY/zK/tYyhOTUAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRvtGpar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967E8C116C6;
	Fri, 22 Aug 2025 01:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755825601;
	bh=NMmngW6kEuVZFBGp33Fk+XgPx3vkCKpVM44b3gDSQ8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pRvtGparTWrZCdRuisfghUaDWWmZi0q1nVWPr1THu5nu9Fe10Nbo94fI3isr9DEEF
	 jmSQNOfyxhqErb7G8ddgAFvwFtHwjP4ecOopSg00m2o/WGJ/RpTBUoccsugjbJf2RU
	 wWcbciaDokbP5NBZn4xhXrSX1biOzo3Ec+Py3k7x/BPmZzjLBCgw+fHQNgyKCb+nQq
	 f9cCZXNL0YuES1RE5IQK9SNHDana4J2/PLlrAjnQzfkWJRtXaoxfJSXsmzX0w/PVNX
	 MlhWYyFbyCnkXCA+aZvT93uL8Ig0J698H9I7rHJA4mIibzEpQCIA89XLQk5K8jJFXa
	 MOdY8EpLSHozw==
Date: Thu, 21 Aug 2025 18:19:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] net: phy: introduce
 phy_id_compare_vendor() PHY ID helper
Message-ID: <20250821181959.15e04c50@kernel.org>
In-Reply-To: <20250819164146.1675395-1-ansuelsmth@gmail.com>
References: <20250819164146.1675395-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 18:41:40 +0200 Christian Marangi wrote:
> + * Return true if the bits from @id match @vendor using the
            ^
  missing colon, Return:, to make kdoc happy

> + * generic PHY Vendor mask.
-- 
pw-bot: cr

