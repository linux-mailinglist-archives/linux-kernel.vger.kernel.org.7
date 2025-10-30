Return-Path: <linux-kernel+bounces-877760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99F1C1EF4F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CE33AD06C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D8E328B64;
	Thu, 30 Oct 2025 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lom8C+Kt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5458937A3DF;
	Thu, 30 Oct 2025 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812439; cv=none; b=QErs7K8QhVM8w/mRgneCWNqHaz/onSyofiuqZuhDpq3KQZW+5mFXZE7XAwie/ZbrEH7eyQd65ugO/IBcoxvpAWc6u6pEOd3wevlX3BgIOxrQmwm7t7IqbCYY1CPgkCsmAM1wBlPx2LyG3H5SAe8ucEG3MM1TYptA9RG9H3WNH/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812439; c=relaxed/simple;
	bh=zcrAfi9S+QHc4DexOb0H+VSKqGKbxFdOqarI8kmeRuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoLLohT4MomnykVI38KjOIVA0XPlagfzSwsVSO4fJ59annTsFdncJFcGC3N8yhF0xibwltmKM/n2WGy7XR4Yzi3h7WY99Z4k+s7DKVwYSnyf8dKggRonB4MKYkZLiT7rtmwIGJuauPVoYaMvrUnkWHVBgJyGBLGkVQyIQyfKN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lom8C+Kt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D799C4CEF1;
	Thu, 30 Oct 2025 08:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761812439;
	bh=zcrAfi9S+QHc4DexOb0H+VSKqGKbxFdOqarI8kmeRuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lom8C+KtepNxbw9FN3lLlPu97MlGjWEsZoU8oE40J7i6nCrA9sq8+5lMwR5Xn6TRd
	 LigT3U6darE19rx56NrxprY3Xlrn4E1QgEa8bkqe0ySoVpv18Is/LVNjitnPZV4+NB
	 Bd9uaYPI/asXmvVTPHazMq2dkPRtuQHKnDRBD8LeNXwXUuGvKCJWXj85Q1JYt3wzxO
	 WWZ6xjSs6MvyYw+YSMl5gRwUjPgA1OxqR1iM+93kZi8eZTI6sstb0seH626+rtSJpC
	 LzflXs8YHhD66Bb6wbn3xXzRFr5lTnbcBET+GhfxPbBjafQJNxGfD0Fo+V6gDenLrt
	 xOFoRtALtrpIw==
Date: Thu, 30 Oct 2025 09:20:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Conor Dooley <conor@kernel.org>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: syscon: introduce no-auto-mmio
 property for syscons
Message-ID: <20251030-terrier-of-improbable-destiny-32ccb2@kuoka>
References: <cover.1761753288.git.dan.carpenter@linaro.org>
 <230cf12861a4f0b9effc72522444d3e28c1de2c9.1761753288.git.dan.carpenter@linaro.org>
 <20251029-ambiance-snooper-43dc00dcee68@spud>
 <aQJR36s0cY34cLrr@stanley.mountain>
 <20251029-embroider-plunging-6356f50c7acd@spud>
 <aQJhTbNJkezeipoc@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQJhTbNJkezeipoc@stanley.mountain>

On Wed, Oct 29, 2025 at 09:47:41PM +0300, Dan Carpenter wrote:
> > > > "System controller node represents a register region containing a set
> > > > of miscellaneous registers."
> > > > 
> > > > If this isn't actually a register region, but is instead an interface
> > > > provided by SCMI or whatever "secure partition" is (optee?), why is the
> > > > syscon compatible being used for the device in the first place?
> > > 
> > > In the case that I'm looking at, it really is a syscon.  So right now
> > > we're upstreaming it and it's an MMIO syscon.  Very straight forward.
> > > But later, I guess, they want to have a new firmware which will only let
> > > you access the same registers through SCMI.
> > 
> > When the programming model changes, the compatible should too, no?
> > 
> 
> I wasn't planning on it.  I haven't been asked to upstream the SCMI
> module but once my thinking was the transition would work like this.
> 
> Step 1: It would work as is with an MMIO syscon.
> Step 2: We would upstream the SCMI driver which would provide an
>         MMIO syscon as a fallback.  At that stage you would still get an
>         MMIO yscon regardless of whether the phandle was parsed before
>         or after the driver loaded.
> Step 3: We would set the no-auto-mmio property so you have to use the
>         driver and update the firmware so only the SCMI interface can
>         be used.

And how would it work with old DTB without that property... Sorry, but
DTS, just like hardware, is supposed to be fixed meaning it is static,
unchangeable, except bugs.

Existing DTS does not have bug in this part. You cannot change it and
keep adding properties just because you decided to do something
differently in the software.

Best regards,
Krzysztof


