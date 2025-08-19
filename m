Return-Path: <linux-kernel+bounces-776332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 973D1B2CC0A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3113C18830AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A1930F54F;
	Tue, 19 Aug 2025 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="geyuv1N+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0FB30F53E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628160; cv=none; b=HLOSIKl33AX7AI5PWtRLtqVFckeCgXnEA/7+6rmYIeIxKSRPyJ4+/nZTY/FVUOss0e6ExCEwHnBw3YDocJ7US/qVSFTSK+/xzFWYF5yR3e2+Y2fSHUKQXa1JPwcKBhcdchPRL3HwdCZk5QoOBbFa8v4hhv7d/FyG/UhZdYoSqJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628160; c=relaxed/simple;
	bh=xVXhlID6Cg1YnTlGY2sFhZ7UmXbIou3f/2jOlncixJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SilzMI63SnOMLknR0SQC13+MXgnMCmtQbwiOI+5k7AiEVeeTZpYtzvhrXU5UHVVGeuRTMmnGTZx526EjgFWb0oJ1Sq9ch1PessL4CrgtyWJoVpnZ7OSpZfnp6L2JwBf5xf9LZCSIuLZap+dKlgcMt8JtTq8ewCauVGuccNIs3Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=geyuv1N+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1080AC4CEF1;
	Tue, 19 Aug 2025 18:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755628156;
	bh=xVXhlID6Cg1YnTlGY2sFhZ7UmXbIou3f/2jOlncixJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=geyuv1N+wUd1L/msl/TgFqEQ8hkKwAnTiA8+AqcPAa+r2C9OTHEdk6kSvIPbKLhzr
	 q2ntQwK9cXfP2xW8eY/lJ24gDgCpGM/x1VGUnHT+88tFAunwsSvxkLimWHmzw+CpKY
	 o3RswP5um0dXF2vh/00O07uCcpXYqMaTZEV1iULI=
Date: Tue, 19 Aug 2025 20:29:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: zhoumin <teczm@foxmail.com>
Cc: rafael@kernel.org, dakr@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] kobject: fix uevent helper execution order issues
Message-ID: <2025081956-untie-elude-7880@gregkh>
References: <tencent_22B2504A61A3281D6A2590CB43ABCCEC790A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_22B2504A61A3281D6A2590CB43ABCCEC790A@qq.com>

On Wed, Aug 20, 2025 at 01:18:28AM +0800, zhoumin wrote:
> The current use of the UMH_NO_WAIT parameter does not guarantee the
> sequential execution of CONFIG_STATIC_USERMODEHELPER_PATH.

There is never any such guarantee.  Unless you are on a single processor
system.

> For example, when fdisk completes and issues a BLKRRPART ioctl command,
> kernel first sending remove events followed by an add events. However, 
> process CONFIG_STATIC_USERMODEHELPER_PATH may execute
> out-of-order—potentially handling the add before the remove. This can
> result in the new partition being unexpectedly unmounted instead of mounted
> as intended.

Why are you not looking at the SEQNUM value?  That should be what orders
the events, right?  Otherwise how would any of this work?  :)

Also, what usermode helper program are you using that requires a binary?
What is wrong with udev?

thanks,

greg k-h

