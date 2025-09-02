Return-Path: <linux-kernel+bounces-797220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9687DB40D93
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70C3189652F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C051B35083F;
	Tue,  2 Sep 2025 19:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLM/TaB6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183F32D594D;
	Tue,  2 Sep 2025 19:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839930; cv=none; b=UduL+sTIGVN35GzQBz0dx7+wpCoNUVbRitdNsvrA4EZLPuRcOC29gUfNaL9Zbl986BI7agQ1T97GhzDjOamljOTFX3vm4qzRb2N3kRt/WwlYoX2Vok8tY97RWuN2DY1+Mz/uhNj3fyu7NfqHTV6OhFxT3q5LyJ/2SHmFs8i6NXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839930; c=relaxed/simple;
	bh=DU0OyUb7I7RTRTwXwyAUJLAhUSJ5805df8bx9kWFgJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uo88JX1Pz0/pY8sU+0JJhy6vMAqg8WqNPyKEMs2fHPZiq2Pe29+hNYBRDDx7t//grXeWJvos8fbPpwj7pP9nL6bGUQQVnWZSZXAooQyKcuKuA3HIoz2MLneO0RtVusRvH2pztuCKRqWEdL8DMEfR8SD6hg4lfZdu/2nmoRj//YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLM/TaB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D703C4CEF6;
	Tue,  2 Sep 2025 19:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756839929;
	bh=DU0OyUb7I7RTRTwXwyAUJLAhUSJ5805df8bx9kWFgJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XLM/TaB6P2h8OF1AXwClGcBZlGaDOn7NpMrnYHF7dyXtrNVx+k8UXrs+sKeIYyRXG
	 jPde/bVy/Ch6M5JELAkjkSzOpRnVQqX2ThKCoHgErI/zZx56JYfLrhnSOUOk8WRtd4
	 tpTYpbkkvn7JbBoHKPxD1EsX3v4rsExN7M7hjlOK8+krgXcRGqk8h+4MkUm2RHrO6S
	 LbkyrP8nqbj/NkZ+Y2wKL7paI4Z3zPOOHSJVxQHmQGvp8NaPJju5xYsEnpRj4uUmQZ
	 0TlJnsFCuIX1RvVM0tlwsmM/IVlmBsl01ccG+87u20kKi5Xr3xufI7/yJYWiR4KZti
	 4N1EZOHx/D5cA==
Date: Tue, 2 Sep 2025 12:05:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Colin Foster <colin.foster@in-advantage.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Steve Glendinning
 <steve.glendinning@shawell.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v1] smsc911x: add second read of EEPROM mac when
 possible corruption seen
Message-ID: <20250902120528.5adc9fb7@kernel.org>
In-Reply-To: <aLbjkQF8mA5HGDfx@colin-ia-desktop>
References: <20250828214452.11683-1-colin.foster@in-advantage.com>
	<20250901135712.272f72a9@kernel.org>
	<aLbjkQF8mA5HGDfx@colin-ia-desktop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Sep 2025 07:31:13 -0500 Colin Foster wrote:
> > > +	 * The first mac_read always returns 0. Re-read it to get the
> > > +	 * full MAC  
> > 
> > Always? Strange, why did nobody notice until now?  
> 
> For me it is 100% reproduceable. The first read is always 0. I've added
> delays in case timing was the issue. I've swapped ADDRH and ADDRL and
> the opposite effect happened (where the first four MAC octets were
> zero). Re-reads always succeed.
> 
> Without the patch, the last two MAC octets are always zero.
> 
> We didn't notice it until we started hooking multiple devices on the
> same network.
> 
> If there is anyone else running this hardware, I'd love verification.
> Its an SMSC9221.
> 
> That's a long way of saying "I don't know" unfortunately.

Right, I think we should avoid saying "always" in the comment then.
Let's weasel word it a little bit given the uncertainty..

