Return-Path: <linux-kernel+bounces-706909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 819C7AEBD9C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 18:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119761674B0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 16:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737BA2EA753;
	Fri, 27 Jun 2025 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7GvYWfC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD73D2EA47F;
	Fri, 27 Jun 2025 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751042183; cv=none; b=M2iOO/mWwD2nbOXCb5h3ogJIgC/NrLFwjgBy4d+MMPaU+Ju245CRqBq3wizAU1yr/j/8c/fdWhmIke5cSpHPjzbdsSZqMKcmcz5MWJvVegWQKFS/7Zjff+BxJ7fz9Zld5rItEwPWcTnub6KZVUByfEfKtZ1ibrBt3AtIG99IhEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751042183; c=relaxed/simple;
	bh=U36zvCdwxVpbXVC99b1oNGYhCohLlD3gx4t7Uaf0r+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0/UYT7fw1iQ3VuxDqpcE9Td1hTR+iaefk3MZkEGuFiR84U+EYBbzO9Tv8/t3zoTW7IrMZEN+cmXmKbuvsYYDntGtLpxziOu+oa7EgnXfOsDRSns563jXIixWpgCfvzTfsMOOPDrn50eA5hM33g0FxWDunALM6npwqDXz9159YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7GvYWfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DF7C4CEE3;
	Fri, 27 Jun 2025 16:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751042183;
	bh=U36zvCdwxVpbXVC99b1oNGYhCohLlD3gx4t7Uaf0r+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N7GvYWfCJAF6tR7ODY7v7AWWFlwxJDlPbXhF5erD91FVrNvI5Iky3uIJb5Q2vp93R
	 lHPWGcOwrNHsji67WzlTB9Gt8MREUm57zOf/b1ZVCKhgrr/eqC28uK8eDPBtGUjbxl
	 pboQLkuqEHyCRdfB6VPTCpHWQEsKNJN4ErsL/ZswNH1EYOwi9REzGKZd0b99xxjQeY
	 kCGZphrswQreUvquNPwpe2dN5EvzmRG1CRy9w7xuyFtEmHb2HqsHvButxdXLXxFDLj
	 jr3RTY1wZ4MeQqku/H8aeeBYCWHnVBGNjIONzcc+FNproAI3iuFMOTcCytvSXBpEg2
	 0emZRPrqi3B2A==
Date: Fri, 27 Jun 2025 09:36:23 -0700
From: Kees Cook <kees@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] fortify: add branch hints on unlikely
 fortify_panic paths
Message-ID: <202506270935.283087E22D@keescook>
References: <20250625161221.295575-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625161221.295575-1-colin.i.king@gmail.com>

On Wed, Jun 25, 2025 at 05:12:20PM +0100, Colin Ian King wrote:
> Analysis with gcov while running the stress-ng urandom stressor
> shows that there are a couple of fortify panic paths that are highly
> unlikely to be executed for well-behaving code. Adding appropriate
> branch hints improves the stress-ng urandom stressor my a small
> but statistically measureable amount. Ran 100 x 1 minute tests and
> measured the stressor bogo-op rates on a Debian based Intel(R)
> Core(TM) Ultra 9 285K with a 6.15 kernel with turbo disabled to
> reduce jitter.
> 
> Results based on a Geometic Mean of 100 tests:
> 
> Without patch: 50512.95 bogo-ops/sec
> With patch:    50819.58 bogo-ops/sec
> 
> %Std.Deviation of ~0.18%, so low jitter in results, improvement of ~0.6%
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Nice find! It seems some ftrace configs are unhappy with this change,
though?

-Kees

-- 
Kees Cook

