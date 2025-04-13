Return-Path: <linux-kernel+bounces-601791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A730EA87270
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Apr 2025 18:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35813188CA38
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Apr 2025 16:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6556B1DDA2D;
	Sun, 13 Apr 2025 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfAjKNan"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CB9E57D
	for <linux-kernel@vger.kernel.org>; Sun, 13 Apr 2025 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744560128; cv=none; b=gsKyMZN+mdooW+8CUX3gl4aF5lmpNbpKTXmXGAbPaICvtGH4kOLmVdkJdLp0voJltvk4i3jtoQZrTfQRxtFW2+0V6PJMj8eiiTw0hhcCpslWDGV9IbCRNcSyBKmP4L6v8zeIDAHb1dxDb5r1XqB0ioGbdgJBpB6NyrHSU5oTjiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744560128; c=relaxed/simple;
	bh=2NaVP5B5uP0EAUwCKZ0jYYq2HWAKil1PegTTkj/+Hlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5rOQvZMbWd15DfX2Ua8gPuakRuzLxMZsBAsobGMjuMRlJ7SLHCbti0E6AaW7AHjj9VywQ6RrfBBbaYutc2TaeyxyotMqaynVXam2h6gMnj8DNLVo3bbY/fj37saa2mO0vm85DYNozK+aBfXs8LFGDqYLq6i8yAptavxaNADGb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfAjKNan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E212C4CEDD;
	Sun, 13 Apr 2025 16:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744560128;
	bh=2NaVP5B5uP0EAUwCKZ0jYYq2HWAKil1PegTTkj/+Hlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZfAjKNanYVTorjzPc387K+BEqBIDf4jj4UKI4g25nEd8mZetP9Z0j9ecYeAVa1YFq
	 yxSTUug3pTqAOB365U41+Vvc+IktHIRLzlERi6qDSz79bUkaG5Au2G6N2ZUOiyuFaM
	 3oMfYAjYw8PKhxbV3mrZSw8qnpi44V/Pex55ZljClq7WmixOmDGB3QE9/v67F8seal
	 CRJ8scckKDe8Gr4Kw6F8C/Xv0x2Za1YWc/E+ayEfwygyfdl1jix4ZDgvE/kU43MZxy
	 AHZXaEdohwwKNbSOczVCBjCcaUrW0iZVKamneKK/bIdpsSbkeN1S3J0j6LXYwAbXmr
	 rFhQJOUl8tT9w==
Date: Mon, 14 Apr 2025 00:01:59 +0800
From: Gao Xiang <xiang@kernel.org>
To: Bingwu Zhang <xtex@envs.net>
Cc: Gao Xiang <xiang@kernel.org>, Bingwu Zhang <xtex@aosc.io>,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs-utils: add contrib/stress to .gitignore
Message-ID: <Z/vf90eBBLJ9zxH9@debian>
Mail-Followup-To: Bingwu Zhang <xtex@envs.net>,
	Gao Xiang <xiang@kernel.org>, Bingwu Zhang <xtex@aosc.io>,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250412140940.88303-1-xtex@envs.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250412140940.88303-1-xtex@envs.net>

On Sat, Apr 12, 2025 at 10:09:38PM +0800, Bingwu Zhang wrote:
> From: Bingwu Zhang <xtex@aosc.io>
> 
> Signed-off-by: Bingwu Zhang <xtex@aosc.io>

Thanks, applied.

Thanks,
Gao Xiang

