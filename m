Return-Path: <linux-kernel+bounces-838897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D39BB060C
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E33F16E7AE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4172EBDC8;
	Wed,  1 Oct 2025 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQCxd/Y1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B5B3A8F7;
	Wed,  1 Oct 2025 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759322910; cv=none; b=pd5ZSSrCv12mOkKhWTZReYKSlX+/MDhnVJj1tR7hiTlziHTmF120BWXd8m9zky+3xc6CIaRGeCv/kRbs1PgnZln+3/qAGzPOkVTH+5QU6C0cdGNEHz71TPZmR+9UMe4QEUO4upldTPqXhgEj1AXQJDxtVlr81rZg44HYiYGjYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759322910; c=relaxed/simple;
	bh=kTs6Z6JUmuOjDeM8YvYF+Rgm2HCsCkkJEW8DnRFMBfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcZj7V1M2J5Cm5okzHaGfmwmrR1fwijk80COJGmtWtUGWEBqkMFuvLN9q5a+8deb0v0ler3Lyid3Aqg+iix6IeZNrUIGFBbAitV4ga2ivU6rvXTMMNliLtoiUOYp3Pr4lAqVd6C4mVKLQl4HHdMdcN1GPylvx5/0lJJ4ROWD4gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQCxd/Y1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F792C4CEF4;
	Wed,  1 Oct 2025 12:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759322910;
	bh=kTs6Z6JUmuOjDeM8YvYF+Rgm2HCsCkkJEW8DnRFMBfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eQCxd/Y1KPghQQf9s1Pk/uRQtOBdgFd+ddLRwVKQqTXmWl6lvSm1jzL55A9O6QFhK
	 DUB0/jaFSXWD/gu7tL4gcPaBVFFvp3uYYvXLaCv6Qf4kBTMhA7lgHWAbu14KTdUkjD
	 q12DBSXUDm1UXkUYZ1k1fkpIcjza+dUWGbF7CP/+S0kwpeaiRNpO6U18cNqFsIFLY/
	 yvmbaTVwqo+fHJWzrjs83JwyMjEiuADJJFEKupFLhKs2laavGHp9H9BKmaA8WDcg8W
	 xDnj5Zi49zmdek7QSZHQrlz3TkQ64s9LSNyz+wNtTJclUzX1pa+TpzW8qN8zTch65u
	 8umVk8PZPlIGA==
Date: Wed, 1 Oct 2025 13:48:25 +0100
From: Lee Jones <lee@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Janne Grunau <j@jannau.net>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>, Neal Gompa <neal@gompa.dev>,
	Sven Peter <sven@kernel.org>
Subject: Re: [PATCH] mfd: macsmc: Initialize mutex
Message-ID: <20251001124825.GR8757@google.com>
References: <20250925-macsmc-mutex_init-v1-1-416e9e644735@jannau.net>
 <1bc9a4b3-7a8d-4bcf-9481-36fdc76e066c@web.de>
 <20251001095505.GP8757@google.com>
 <0acf13d6-d63b-4079-93ba-d53910e624d7@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0acf13d6-d63b-4079-93ba-d53910e624d7@web.de>

On Wed, 01 Oct 2025, Markus Elfring wrote:

> >>> Struct apple_smc's mutex was not initialized before use. Surprisingly
> >>> this only resulted in occasional NULL pointer dereferences in
> >>> apple_smc_read() calls from the probe() functions of sub devices.
> >>
> >> See also:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17-rc7#n94
> > 
> > Provide some context in your own words.
> 
> Would contributors like to care more also for the usage of imperative mood
> in proposed commit messages?
> 
> 
> > Don't expect others to click random links.
> 
> Should the mentioned information source be better known since a while?

By all means, provide the link as well.

However, you must also provide your own context.

-- 
Lee Jones [李琼斯]

