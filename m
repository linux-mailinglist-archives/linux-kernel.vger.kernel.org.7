Return-Path: <linux-kernel+bounces-876944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 151FEC1CD33
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DADC44E5244
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB883570D3;
	Wed, 29 Oct 2025 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZSaB6st"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE8A3563F3
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761763670; cv=none; b=axYV/MDRTpJVYItvjYLNl7XmGUUiMMuzVHLk+x/adozWITOnPwBOmBKX5o45p6rF3o2vnusCU/tAjFmQb5CGKo/ZcqcLZ1H90OQLK39FKfKn7hyiSkJgqWYlXSPAvaA27tD6c/t70sOL2SqvEZs9PsqxnpZS/Clcbl2tMJSqOKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761763670; c=relaxed/simple;
	bh=0Tr3LCSHb84ftOumUd9propiyWY/G1DK/xvBH3c4z0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4c4VhGIG7wFxo9Anj5BVXQsG8B5JXTuZm8rkhEPymI1eCh0zOHgnJUlQLG9Caks2WqxgUdHNr3yTe0DNI94+cSOHPUbuFbAkIwHGaQaOeTtdhkoDHX0aMH9n1nuoI54oh0WTLMgfW/qD3ZRnLHSklAqKq34UaCi0G3vxCmOD+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hZSaB6st; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47719ad0c7dso1802865e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761763666; x=1762368466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7UlL3GKzUDEprO6nc/X4PQZdsoNuJnhVXYl9pMuUgU=;
        b=hZSaB6stfLACJmEqNsUdwjSf2xtOI5p6B3TGS/c5ftCfg7bSAZ6/pTAloV+Cwgxl/t
         Bh2YMigTgCP3OfdV31YYEMKAdOoKj5hgVHMv/pMpFtJ6as6GdbSu8R27zJoLBI5S7fOn
         xn9UWzWrK1orsjyrfi+0oo3e4MhBxvQ7znYr7cdFedmj+rF27Y4USBbK2t+M7iJhxg6C
         EKIQCWOsxGvLOIY1urX8aAOEQCdqq0mqYGLnCj6KFUmOBML8/nftx5THwq2utv+lqbiS
         PeLeRNI24xFY5zFec19VrJEUSLqbLyzbMJND7suffct6Ll1SbcwiAJjtBtNdEaWevh/q
         9hOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761763666; x=1762368466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7UlL3GKzUDEprO6nc/X4PQZdsoNuJnhVXYl9pMuUgU=;
        b=dpsmESjK+5IfH/63VgrNOtaJAdlvwSpyyIbb9uMfxYbYLIZRuy6ZghLAP8jbwMIMdE
         DJWWmKtrRL5Jdn+XTg4cVnOvlLqaESC32ixgaLaWddRlfel8a4tF4oa0q0OQOQbuSg09
         S2jccOYFhdKjUw2dP571wIYg4hc9DodFbDBrEqKC3QySvjiv+sj9S8KfW1K+TeYquWAM
         SkbNEJ03GYGwd4IsIhFsaJcBXEpsWb9N4Pwcs9qOpa+fuJa8wq4ZfOS/3bYCjVqr/JXa
         jT2fFDoB9I5r+aVhZEXjUS24CDNAb2F0GfwePwH1ZZJD2wonm3kU4HDzV0p8A9M8yn/d
         Jp4A==
X-Forwarded-Encrypted: i=1; AJvYcCUOSRiGuTFD8uaAyA9B/litVWqZl+JBiVwXH2Y9E/ci7ADOwyOI0DkIBUCXAb89oncePAtRc9Tc967yyPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx29OwlVlb/GhJ+MnAbr1KOKln7EW+xuPte6NAT7CIIh49/HlU0
	T7FmgxBhA0AUTHZWoz/fKWlxegPZ+zwBT1fYayeCVYV6l4NN+LIxIw6T1nExwY2A704=
X-Gm-Gg: ASbGncsokUTLSgYQ9/rwwD6UirsE7jLqU8P/0cQUCzdRjjL64yR6H6g3hEeQo7Yn9yQ
	wFOBZEC3fyAqjMG82U/IhvbSMpfCHqbFOrcDeOUmQm2TQmEMRauTbFF6fAKK6dZjlQftYR5yuef
	XI4pTleafKlgETd5z6ul9Yxws9lwjS/U+qFVwKjj9G/tlg6axnNT2PLmgLwb3Lzb10gEDhg/7ru
	OUUmdv/cQMpgm6/KMALXhupE3zAHMNcNVVa/uCxhILvpxahqfZ7UneBkRo+UM4b+8fD+AAWCE2t
	I0GTxcaE8Xn1bAxM8H3ypKqPMhzQg42dKV7YXJIqc1ASWdrKSJyrxWoCGKrKouUuSL9oy0RJvUa
	PeLF+/RLeQTIDLPwFjQnwjQEA41Ppzjwlt4+PsUdS7jZkedd03vWrF82ZxDdjBfeMCE3PPyubpC
	rVAhlWbVlpea1dtk0+
X-Google-Smtp-Source: AGHT+IGpoPX9hNhKmRBMmW2j12M72FSxxCuC4T9cB82GM76vjMbsT/vObteBlRgx4MZwjCJgYtHIEw==
X-Received: by 2002:a05:6000:26c3:b0:427:45f:ee1a with SMTP id ffacd0b85a97d-429b4c8748cmr573409f8f.25.1761763666459;
        Wed, 29 Oct 2025 11:47:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952d5773sm29704529f8f.27.2025.10.29.11.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 11:47:45 -0700 (PDT)
Date: Wed, 29 Oct 2025 21:47:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Conor Dooley <conor@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: syscon: introduce no-auto-mmio
 property for syscons
Message-ID: <aQJhTbNJkezeipoc@stanley.mountain>
References: <cover.1761753288.git.dan.carpenter@linaro.org>
 <230cf12861a4f0b9effc72522444d3e28c1de2c9.1761753288.git.dan.carpenter@linaro.org>
 <20251029-ambiance-snooper-43dc00dcee68@spud>
 <aQJR36s0cY34cLrr@stanley.mountain>
 <20251029-embroider-plunging-6356f50c7acd@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-embroider-plunging-6356f50c7acd@spud>

On Wed, Oct 29, 2025 at 06:37:26PM +0000, Conor Dooley wrote:
> On Wed, Oct 29, 2025 at 08:41:51PM +0300, Dan Carpenter wrote:
> > On Wed, Oct 29, 2025 at 05:33:48PM +0000, Conor Dooley wrote:
> > > On Wed, Oct 29, 2025 at 08:27:05PM +0300, Dan Carpenter wrote:
> > > > Generally, syscons are created automatically and accessed direclty via
> > > > MMIO however sometimes syscons might only be accessible from the secure
> > > > partition or through SCMI etc.  Introduce the no-auto-mmio property to
> > > > tell the operating system that the syscon needs to be handled manually.
> > > 
> > > "System controller node represents a register region containing a set
> > > of miscellaneous registers."
> > > 
> > > If this isn't actually a register region, but is instead an interface
> > > provided by SCMI or whatever "secure partition" is (optee?), why is the
> > > syscon compatible being used for the device in the first place?
> > 
> > In the case that I'm looking at, it really is a syscon.  So right now
> > we're upstreaming it and it's an MMIO syscon.  Very straight forward.
> > But later, I guess, they want to have a new firmware which will only let
> > you access the same registers through SCMI.
> 
> When the programming model changes, the compatible should too, no?
> 

I wasn't planning on it.  I haven't been asked to upstream the SCMI
module but once my thinking was the transition would work like this.

Step 1: It would work as is with an MMIO syscon.
Step 2: We would upstream the SCMI driver which would provide an
        MMIO syscon as a fallback.  At that stage you would still get an
        MMIO yscon regardless of whether the phandle was parsed before
        or after the driver loaded.
Step 3: We would set the no-auto-mmio property so you have to use the
        driver and update the firmware so only the SCMI interface can
        be used.

regards,
dan carpenter

