Return-Path: <linux-kernel+bounces-833331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A9EBA1AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC6C16F5E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36286275106;
	Thu, 25 Sep 2025 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="K4rKGIUZ"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E35525EF81
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758837039; cv=none; b=bq2rzKcHUXHtLuOEThuhyQx8klXJz+plkoZWvm7A355D6Vs42iVJiFNZsSCRX4e2PpfsSns7YqB7AogXLuKFf0WeT8Qjcax9899sOzIkySdusA3g6Um0czXa7sIGf9Dg5Maj2BHqLx3/bFluQ0VEdy7yc9oMTJCDQkxxLR6AfsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758837039; c=relaxed/simple;
	bh=HR7hwetkz0c1EUFPcN8G6uamvejgsOJWri6jDhJgftw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n11rywSbjeYqMvZghEGKxXcyhd8W0H863Rxekznalu6C6U2D+9pyNcwKHU00J8Fv/uxon998w1MV6B98lN5D/DEG++jFIXkF85belb4JxTxiduIE7I3PI8cyjMWvsy8tVAvZGQaoFzGdIwwBHixo9O2ERA8xElxr9IuH2vKv49Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=K4rKGIUZ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Ai2u
	ZshFLzPCn4qE1mOlvZEOK2ArYuQo3ep7ThaPWcY=; b=K4rKGIUZEBre9RgdW2Y2
	c+/PC+w9UKQ5bPz1xSY2SfGsQCOLqa6TTkVf5LB3wmLlHDxWT8nK6mmlxsKKmouG
	JusFHRCS6dWfwdKtsTC66jM0JaN0QRAe67emZigp2WSucV0oNQfZccjiPtjpu517
	kkHLdX0vs+53rGjouUOQumR+o2kzJW6hsGqlPYDLPjlDZ7DY1j92iKyt3qahZTja
	qEOYYFg0U/5f3kF6lcS4I8CUfye/5BRo0N+GVkimYQfeTCuePlrRNG7HM0JA+etD
	1VtrSjsBez7nNSbQzqHvbedP1f9aPmHeyIpAiysOuQLl2Z1wBGZrFABINjORQXAL
	4w==
Received: (qmail 2024078 invoked from network); 25 Sep 2025 23:50:34 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Sep 2025 23:50:34 +0200
X-UD-Smtp-Session: l3s3148p1@TMKiKKc/BtYujntx
Date: Thu, 25 Sep 2025 23:50:33 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Alex Elder <elder@riscstar.com>,
	Troy Mitchell <troymitchell988@gmail.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH v2 0/6] i2c: spacemit: fix and introduce pio
Message-ID: <aNW5KfIg-_4-Et1S@shikoro>
References: <20250925-k1-i2c-atomic-v2-0-46dc13311cda@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-k1-i2c-atomic-v2-0-46dc13311cda@linux.spacemit.com>

On Thu, Sep 25, 2025 at 10:02:24AM +0800, Troy Mitchell wrote:
> Previously, there were a few latent issues in the I2C driver.
> 
> These did not manifest under interrupt mode, but they were
> still present and could be triggered when running in PIO mode.
> 
> This series addresses those issues and adds support for PIO
> mode transfers.
> 
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

Applied patches 1-5 to for-mergewindow, thanks!

Waiting for a possible review for patch 6.

Troy, maybe you want to add yourself as a maintainer for this driver?


