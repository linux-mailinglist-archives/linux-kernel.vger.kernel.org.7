Return-Path: <linux-kernel+bounces-741794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2004CB0E908
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D209189B4E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676E9242D76;
	Wed, 23 Jul 2025 03:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAPIaYeJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8602417F9;
	Wed, 23 Jul 2025 03:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753241090; cv=none; b=A5I6J2UURj76fxMKiEuyFruPlkjhyWEjrrdlf1b3wg42GOF8ISdUbK6U7o/WK71mFaXe8F+Y76DCHJSpq1tXVLNPIR/LutqdMXcX2VvURuH4YUJx+fiN1RtQvzRYtIzcgGNQofnSb8Ly+C8wZP2XLxz/y9BXpJZ1TYFrjfsHgP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753241090; c=relaxed/simple;
	bh=wI9zlrE5TCfg8M/RhW/0lHjAGfDjrIxLepTYD8ag2IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPc7qgVvtqE90C6I2H6odVOpwWdNDcJ+gMaxATJI0PlGu8tvoNNqn8VEAF9HJexj75X1h864uNVMv2c/Lllk8JdwUwM7X9ITvDO6VqXzCKrCdMgqBz+Fxcti8iLbEE2Fk+ZywaihSlSMnH/XwaSQmLQONkkzWdAsEvc8pw8UBfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAPIaYeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE78C4CEE7;
	Wed, 23 Jul 2025 03:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753241090;
	bh=wI9zlrE5TCfg8M/RhW/0lHjAGfDjrIxLepTYD8ag2IM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EAPIaYeJAHcEKkPsIfpLFp+Q6qtJ9jT1fcEuFBvFFmhSFWhK63Lpx3FvQJMhsPKoF
	 qgkuHbwcygIS9jG9t/ZG+iKAsJQX6UGSnt0oefR6Z9WIpk8EszUsuPl8bOoEndpxft
	 kGDieFy+fODGZdCBLsRTC1Y/2Cihx0SFfPexTvBwrbPOgTMXsR4PS/2KwAMqsfVqT3
	 21rF740PMaT6jJt8vIL8fHljWqI75t502v1lZgeRm4LHkby0nqpherU+K3gDifZoEH
	 Q3koAlJhaczJJ4zde3FFiP7oUK3JM4C578CV/94AGBk4IMuf0IY/3ncgM+q2Ne7Z57
	 Zd7VVI6Xeaqyw==
Date: Wed, 23 Jul 2025 03:24:46 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Tomasz Michalec <tmichalec@google.com>
Cc: Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Konrad Adamczyk <konrada@google.com>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	chromeos-krk-upstreaming@google.com
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Check ec platform device
 pointer
Message-ID: <aIBV_mKsV4Yn5XMY@google.com>
References: <20250722132826.707087-1-tmichalec@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722132826.707087-1-tmichalec@google.com>

On Tue, Jul 22, 2025 at 03:28:26PM +0200, Tomasz Michalec wrote:
> It is possible that parent device for cros_ec_typec device is already
> available, but ec pointer in parent driver data isn't populated yet. It
> may happen when cros_typec_probe is running in parallel with
> cros_ec_register. This leads to NULL pointer dereference when
> cros_typec_probe tries to get driver data from typec->ec->ec->dev.
> 
> Check if typec->ec->ec is set before using it in cros_typec_probe.
>
> [...]

Please use at least for-next branch as the commit base next time.  I have
fixed it this time.

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/1] platform/chrome: cros_ec_typec: Check ec platform device pointer
      commit: 731a4702b668ef28730e7d2414672b7085e757d6

Thanks!

