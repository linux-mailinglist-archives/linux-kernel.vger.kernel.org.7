Return-Path: <linux-kernel+bounces-887617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171D6C38B84
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9385C3B6790
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20C12248B4;
	Thu,  6 Nov 2025 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krIjy9Wv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468E813B284;
	Thu,  6 Nov 2025 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762393226; cv=none; b=P2WtzzWZo0GYIDdFF9903AqGXkfhoixjqfIu23w7VQ7I8LtEk8CkwRGFoL+NBe9SurOh/AZWPRITzbNpP1NB/SG84Q6FSnzjCmK43vQ7ETrdZUX5gwM4l/hNBl+/KJ3swjqqOEi89JKjUL7+LnWycMb1LVe5XLRJhXBC5D6xqPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762393226; c=relaxed/simple;
	bh=g5omBayoXj0xMTtvazRwk6ECzmjGd0Eju7SQCw3betM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4SW2cbDhSIuC5sA0Pxp0kpTTYhGgJhaHJMUGe/pOrBBslf1fgaNl/lZ2MwHbv9ZDCjsxibZ8lRhtdTOVw7PW+sqm/yYa5PxK2KsY4TDLZ0GZaJI0tT/Z+ZGRhY3PLsNgmR2oZkdDCpm5TpdZOsJ67dwNrIWXLld9fq3n5fF0yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krIjy9Wv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A62AC4CEF5;
	Thu,  6 Nov 2025 01:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762393225;
	bh=g5omBayoXj0xMTtvazRwk6ECzmjGd0Eju7SQCw3betM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=krIjy9Wv8lx0Qvo0b8bZGLlfQUNe1kvSGpkIR9ccj+RxnYua2s+pHYyI/wH1mANjH
	 FLw5u6mQS+lH2WCS7qe+c7zrVW9pYj9nFPKD9hYAgPY/lpaEoME7SZyWqbwZ3O6Ixt
	 BO2Cko6m2RdWnoM1sJ4wGgDod8Zy9f+Lc7mlD4bJdB3TXFCPyIejUEXKYloB/hoDxi
	 8kx+g2Mh9S5s/8OrCLhyZRWRBUJPCW2FhvC7alzASaCgNsZ46zMMkTR8fZpdXLBU1K
	 FAR58rRLWWAzgk7yIicylBku3NbQGscsBvHE8beVW2gZaN90y420Uyon0++sHallSn
	 D1Tc6wvdF2Z6Q==
Message-ID: <cb0b090e-ce50-48d9-a90b-ffba3b22a49a@kernel.org>
Date: Thu, 6 Nov 2025 01:40:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] platform: arm64: thinkpad-t14s-ec: fix IRQ race
 condition
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251106-thinkpad-t14s-ec-improvements-v1-0-109548ae75c0@collabora.com>
 <20251106-thinkpad-t14s-ec-improvements-v1-1-109548ae75c0@collabora.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-US
In-Reply-To: <20251106-thinkpad-t14s-ec-improvements-v1-1-109548ae75c0@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/11/2025 23:22, Sebastian Reichel wrote:
> Fix a race condition, that an input key related interrupt might be
> triggered before the input handler has been registered, which results
> in a NULL pointer dereference. This can happen if the user enables
> the keyboard backlight shortly before the driver is being probed.
> 
> Fixes: 60b7ab6ce030 ("platform: arm64: thinkpad-t14s-ec: new driver")
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
Enabling interrupts late in probe seems like a bit of a no-brainer.

One thing though is the commit log might productively contain the 
backtrace so that people can match bug fixes to specific backtraces.

Reviewed-by: Bryan O'Donoghue <bod@kernel.org>

