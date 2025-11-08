Return-Path: <linux-kernel+bounces-891710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C066C434E3
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 22:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6703188CE88
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 21:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA67288535;
	Sat,  8 Nov 2025 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDwjdXqW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C992882B2
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762636785; cv=none; b=gFGx7S6KloSYrDME3paqSTVuGcSB8rI2L3vp494JUyHWdx1W2dFAD4C4NjWSEuRQCUrraEAX0rGhX/kMrovfZuOM0fs7SkPQ4xAgBm73lcX5+ThG6hQUYi/cMpZRI4MHm8qouiZagIlt69PFMVQDc0Cu6xHDgcPGinYWzJ0uTF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762636785; c=relaxed/simple;
	bh=xwtOyHhUhjUtQS7W2RceLVNraeqZaBqVnVbwNj4o/gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKynEzNE12qUo83nEXKCNDws7lmor4QoyH5ITAD4ofX5zl8HoZ2iO72R+nqfMslt+yiMYu6q4hvho0xuVGRQ7Vcen+qAPxMaYhOIH1i6DoeAUSaJa9TKKqTBuQarmEFN7S3UCvj9j89mOEELfloYG2xGE+3yJTZyAqE9rZvqsiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDwjdXqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4FAC19425;
	Sat,  8 Nov 2025 21:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762636784;
	bh=xwtOyHhUhjUtQS7W2RceLVNraeqZaBqVnVbwNj4o/gY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZDwjdXqW0uk/R0DFhRACQsFtHW0y3oSYLsNQHzoGf1orkq4mnD/KyY0VJomMupty5
	 YWUee0OgHX52VlLjsvdEYraS3mIWBfF65tsAGW4RTGlal90d2kRrKXFasl+X2LTRZH
	 V6renckqVcGJjpzjOiLfleGCCs9NSTmjF4Ll+7RL36P8W7GLCQCU08KGy/17jjiMgn
	 0R/4HkNk6n1sfQJ7BOmyoS/dAs/qX/7cBCB+584k/YPXc9QcZcI7uqMHIzbpuSNrlZ
	 kDzC6B/sQdvvqFTQna066tewF1w7xvmGJIQn38Gl8y4tk82KFDvW1W0wQ0y+y2GeyN
	 XTTbY446yDa4g==
Date: Sat, 8 Nov 2025 22:15:20 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	J =?iso-8859-1?Q?=2E_Neusch=E4fer?= <j.ne@posteo.net>,
	Tom Rini <trini@konsulko.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/7] scripts/make_fit: Support an initial ramdisk
Message-ID: <aQ-y6CCg06lg39oq@levanger>
References: <20251006230205.521341-1-sjg@chromium.org>
 <20251006230205.521341-3-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006230205.521341-3-sjg@chromium.org>

On Mon, Oct 06, 2025 at 05:01:53PM -0600, Simon Glass wrote:
> FIT (Flat Image Tree) allows a ramdisk to be included in each
> configuration. Add support for this to the script.
> 
> This feature is not available via 'make image.fit' since the ramdisk
> likely needs to be built separately anyway, e.g. using modules from
> the kernel build. A later patch in this series provides support for
> doing that.
> 
> Note that the uncompressed size is not correct when a ramdisk is use,

I think something is missing: "is in use" or "is used"?

> since it is too expensive to decompress the ramdisk.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 

Reviewed-by: Nicolas Schier <nsc@kernel.org>

-- 
Nicolas

