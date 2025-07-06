Return-Path: <linux-kernel+bounces-714407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDC3AF6797
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 03:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A541C4750F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 01:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF7C1A01B9;
	Thu,  3 Jul 2025 01:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4CUAzoK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3D718EB0;
	Thu,  3 Jul 2025 01:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507906; cv=none; b=HfT2L8cEIFU2shA4/7TqKLcNZob6TPMw7DGTCSV6yOTqIK/1KFBn7aa3hFdEjHL0A1sA96WRHIYW9JBgOZhGgG5C4wXv7Y1AA6EvAJPMhkMhlh9VKZkqaxJM5dnoNkjn1Bu8OxI9wgnGTUlGN4Fhzw41AHPPKc31+C15MJp3f3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507906; c=relaxed/simple;
	bh=7Hpe6+g9neiO06qoDeiCKclM8bjOOZDe8xp26GAfY4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckG8Q4mx2AB0TubEWR2Cdcoz1tvluCjfZcX7Kp9RsUUkkxKIPj+AD3nNLESi3Hbq//g327X8zHwcWRzU7avBf2fQGAUUauvlYwbk/le0hBDZIDfE+1iqpeq7OopvTxp4LG8TjIYVq6u7YwvA/yrwVYMQnyCua9532Aqg1gk2hHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4CUAzoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13924C4CEE7;
	Thu,  3 Jul 2025 01:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751507906;
	bh=7Hpe6+g9neiO06qoDeiCKclM8bjOOZDe8xp26GAfY4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S4CUAzoKlNapQl0bKg6i8JUWBmpnx/+l5iypcYeCassfhJ0DiiMQEVgXdbK3PBlJK
	 GdBqwW9xZCr+SAVL8yuGq1RTPR5eGzFEq/ZHy+345ZI2lF45Dsed8iNBJXGbON7Z0G
	 J2p8n1AqY+OQieJLQPBd2Yw2KqO3i/CfIrPF8+HEtldJuXDCzfEQ5SmjPO7AgMsy3t
	 h0SRW1dC1wlK+HPabYQNVeUr+4uJ6TdVyFL77uVCqDt8lPZGTLvspxGnKlf8lPPhOk
	 QrB9VIsjUoXlTydHIkbOeL4j7lXQYWz6Zd0kC81H3kuBgwYu9mLkfGVcKMxB/lrVxN
	 wFjVpp5xj4MxQ==
Date: Wed, 2 Jul 2025 18:58:24 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the perf tree
Message-ID: <aGXjwJaa-FQ1TnPl@google.com>
References: <20250703080035.52470f9c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250703080035.52470f9c@canb.auug.org.au>

Hello,

On Thu, Jul 03, 2025 at 08:00:35AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   7063002abb0c ("perf tools: Fix use-after-free in help_unknown_cmd()")
> 
> Fixes tag
> 
>   Fixes: 657a3efee43a ("libsubcmd: Avoid SEGV/use-after-free when commands aren't excluded")
> 
> has these problem(s):
> 
>   - Subject does not match target commit subject
>     Just use
>         git log -1 --format='Fixes: %h ("%s")'
> 
> maybe you meant
> 
> Fixes: 657a3efee43a ("lib subcmd: Avoid memory leak in exclude_cmds")
> 
> or
> 
> Fixes: 4b96679170c6 ("libsubcmd: Avoid SEGV/use-after-free when commands aren't excluded")

Sorry for the trouble, it should be the latter.  Will fix and update.

Thanks,
Namhyung


