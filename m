Return-Path: <linux-kernel+bounces-876856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE4FC1C880
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F1C1888B50
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C0535029D;
	Wed, 29 Oct 2025 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oRR8M48E"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE6E350D53
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759719; cv=none; b=pQGPAtrJ6sFKn02IoZ8kBlElpjiI0v+vuqBi7dPn8g5iLn9Ae/PveiQVnmiZguPF6JlHFh3QnBBuHhATDMub0AyqOjjS1RzppK8QkY/B6DDy4SbURjsMJe/kNAPDZ6yvr76eonn405jqXG0vDNptmyTK/ozOz+4eAPVMi+5lNms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759719; c=relaxed/simple;
	bh=3YsoQHmMdhSXkiQ1YQiOuYE5Gt+FiJZEoWF8rG2zas8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFvSDLGVcSEAhy0bJXYgwQ01kwF6N6X8ZOWgjsWzBha1+FnBc+7B2ClEIALjy+WJFEVr5Rau0sAfjZ1+FWLFap8dseICURCN0ERC02NubMcsQLLKx5ewk8Urodmh+kT1rgqpIZtkBHasSkgMhzG4ThW5lmkdsmB7ITl8mZyVtwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oRR8M48E; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-426fc536b5dso70074f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761759715; x=1762364515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bp5MmzyV0I+sEQzAW+1cSELcdu4xFiFHcWgfaHLwobM=;
        b=oRR8M48EzF0bBMxmKfrYlhKQ6cq1z3gB7xZmadcVbFJewXmvZvuMBOX20IQ9YXrE7q
         P2b4aF/xJ86qZdt4PYfUVtDhaptNQ0Htw6U+tcU2bWY+kzrFi7LIYOWCvONe5m/bwFaE
         9NuwtAk36KzLzX+O5fjzRZtnUA1ExbPS9J+aLqVIyPV5rbCgbrmuhgzh5voFK14EHlMC
         y+qfDKTwJla2tk5YBNFTZeHRD/r/Ns5uni8dSSHromkjIQqkMsNuaCM78Q/63yAfL449
         hoclN4zbWSB+Qg9UxM+86YcI/cWVEgcnn+khGK7o4U0QeDR+kV51NpXswvkOLc2ll+BP
         WZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759715; x=1762364515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bp5MmzyV0I+sEQzAW+1cSELcdu4xFiFHcWgfaHLwobM=;
        b=iZmuJsbwvkyq+dVGuYfWc8ozNrTGFu42rVtjumzl9QuT4O+WkBWAvYtAE9pt4u191m
         TK0/uX2+pvUnPdLwgbSh0mWbBJ37FBej6RHQPipvGooLUG2Tg4mcpjXyzQelxhjjIZC4
         YSnYjtgez7jvDVGKjSUfunMi0jQ0Q4WjZJhT2kb21zasuTuEpL3tZohECT/L2WZM5yr+
         0wmX+qW4ItCdjP1h3HnKKfxV3kn2tbvbss/iM2m5eStpQs9iwN/AHPbUVTTcr+HW/eU2
         t+1WI6qkjpSi0Gg0gw1iMrWw6Lm/NdbwqZLnKRIcLfbIJ+D/hrEpolCrF7WIc4C/1ptf
         FN8w==
X-Forwarded-Encrypted: i=1; AJvYcCXoKADQ6fb9sMIZkDeG6pkq8RRfp7fSH6EE9gevTtL/mC7wgCE8tj/VqEZJz220xbUyJ9XC8ePgvaUqYHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT9UCSZ6Lr6FMGecAV3IYl9MRpsHR0xYg8RR663iB3iAq28pnx
	6jvZHdyfZNRvYYDdniMZ7hsJnR5TqoVid46rNMIMFHuoPkYn/Z3VjBwWAheNUsUEMIM=
X-Gm-Gg: ASbGncv+zSqE6w1+ODk1YrqJYrT7utap//T+YBWHsqhGLlxSZ63dMLXZatMAHrOgx6T
	316Zp5YJ16sd/2iIGsTxYR7+2P3/hD8Vq/nWdZ88w/3VyzbpQeuGRS/Jb48PwhzBM3MWu3K04vw
	f4jODh+s53YGy1sDrIsXrx2yuByLPmc5oVWpiSZzZbmwyTpR4RAlbMELmLDysUxwJLthvGhbyXW
	iX0RXblJSsAJhz82i7YrrHp2pxQsv4flN8+Ku5UNWs3dFtKM/CkyhzseVE6bIHE0z8KSODOgVhK
	Puvvxj0CMpxKPK1FbND1NpCxWNd49UcmhhRd7jLKlx3jeLDcProdG+fGMW7xE7FK2JxGTdGph36
	iHg2F8z5Vqt9DmbuxhDrIrwMLvo14mv8nzWZIniP3VJpwtNTjicFh0qHhE21bLB80RRmF0Xb6XS
	7O22u1YQ==
X-Google-Smtp-Source: AGHT+IEvnE5AI/oHuamFCmDgJIugCBHLrTL3fV9Zgnw1uKtQsvpcxCNbv0qgJbuzWMppKbsKMCH2fA==
X-Received: by 2002:a05:6000:144c:b0:427:606:b220 with SMTP id ffacd0b85a97d-429aeff141amr3274433f8f.51.1761759715371;
        Wed, 29 Oct 2025 10:41:55 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952db99asm27580927f8f.32.2025.10.29.10.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:41:54 -0700 (PDT)
Date: Wed, 29 Oct 2025 20:41:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Conor Dooley <conor@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: syscon: introduce no-auto-mmio
 property for syscons
Message-ID: <aQJR36s0cY34cLrr@stanley.mountain>
References: <cover.1761753288.git.dan.carpenter@linaro.org>
 <230cf12861a4f0b9effc72522444d3e28c1de2c9.1761753288.git.dan.carpenter@linaro.org>
 <20251029-ambiance-snooper-43dc00dcee68@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-ambiance-snooper-43dc00dcee68@spud>

On Wed, Oct 29, 2025 at 05:33:48PM +0000, Conor Dooley wrote:
> On Wed, Oct 29, 2025 at 08:27:05PM +0300, Dan Carpenter wrote:
> > Generally, syscons are created automatically and accessed direclty via
> > MMIO however sometimes syscons might only be accessible from the secure
> > partition or through SCMI etc.  Introduce the no-auto-mmio property to
> > tell the operating system that the syscon needs to be handled manually.
> 
> "System controller node represents a register region containing a set
> of miscellaneous registers."
> 
> If this isn't actually a register region, but is instead an interface
> provided by SCMI or whatever "secure partition" is (optee?), why is the
> syscon compatible being used for the device in the first place?

In the case that I'm looking at, it really is a syscon.  So right now
we're upstreaming it and it's an MMIO syscon.  Very straight forward.
But later, I guess, they want to have a new firmware which will only let
you access the same registers through SCMI.

regards,
dan carpenter

