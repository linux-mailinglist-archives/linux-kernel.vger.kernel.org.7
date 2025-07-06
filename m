Return-Path: <linux-kernel+bounces-711822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4E3AF0006
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 18:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142571883635
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 16:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7D0279DD8;
	Tue,  1 Jul 2025 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2uH7cHf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7771E1A8401;
	Tue,  1 Jul 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387920; cv=none; b=pHL70MeVrmkGdTtMcn8s1CwFvqvduNcwyTju2tt7N5aaFS/0a6eaWH4orXOhatFg7ZXJwC/vnXWxBHkxqCU4V/Tvdc/uKNBjpS93gqz6yp8CQ9fhwdv2pZS9sgb71tCwkHK8hj43sSIhMeLI/MMwzeQetJMtv/LhPqD/7+KBcpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387920; c=relaxed/simple;
	bh=4z/Fq5xO7/oOY0pBWsyMxZ96iISrUCQepYFM3hvTOvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2xgi0xMV3lPZgpNqCNO7y0YQF/1CxeJGn1Gw3c6iNDWN8LWtretd+p8XXxrCuonzCOQpauY9FXg1ldTxHpUtrK0ZCoAsqk3t/QQpsNdbK8tQVfeIGTelghgDVT0IFkHww8edWlPUYlqVuIArb0jWhoxcY2grkVwy/kFqhgYTM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2uH7cHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6589DC4CEEB;
	Tue,  1 Jul 2025 16:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751387920;
	bh=4z/Fq5xO7/oOY0pBWsyMxZ96iISrUCQepYFM3hvTOvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L2uH7cHfMSvl8HSTyLXtxMZv1E+ph/Ji+EOfme4NeNcxublBKDdz0nNePf6LwfMRb
	 FBNDVks/DTKoPktmwdkmTSturMwjc5zueJiCLkpvcGvI6uLgx40ir5oc+ev9sVZ5cO
	 8TNrv9FgARg+4LnK7owfHwgxNEpwNKrvqi5bbZvVdv1+bmuPQuqVAuW0QT8NeoVkSo
	 ry80q4+/CcbLhDrNh2LfvUKKzir9YwYIEcAvqGDaN7kB0q/zHOzYqG4H1f+J9WFC3J
	 yoIC9o1z9802RuGDWg1LNF8b4F7RgZUTLTgC2eOW4LeY9vak22FF+wEuVFa5JoA8ag
	 nsXBoE2AEYAUg==
Date: Tue, 1 Jul 2025 18:38:35 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-i2c@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] i2c: microchip-core: re-fix fake detections w/
 i2cdetect
Message-ID: <qmuqhle6z5xc7kz5c3ofqstb4couphqy57ff5w2lsupcdye7mq@rtkdzztxcx6z>
References: <20250630-shopper-proven-500f4075e7d6@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630-shopper-proven-500f4075e7d6@spud>

Hi Conor,

On Mon, Jun 30, 2025 at 04:18:17PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Introducing support for smbus re-broke i2cdetect, causing it to detect
> devices at every i2c address, just as it did prior to being fixed in
> commit 49e1f0fd0d4cb ("i2c: microchip-core: fix "ghost" detections").
> This was caused by an oversight, where the new smbus code failed to
> check the return value of mchp_corei2c_xfer(). Check it, and propagate
> any errors.
> 
> Fixes: d6ceb40538263 ("i2c: microchip-corei2c: add smbus support")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

merged to i2c/i2c-host-fixes.

Thanks,
Andi

