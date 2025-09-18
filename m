Return-Path: <linux-kernel+bounces-823495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EF0B86A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396CD1C878AD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FDB2D7814;
	Thu, 18 Sep 2025 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAzz5vCz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EE92571BE;
	Thu, 18 Sep 2025 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223099; cv=none; b=a7nn+PQucbWsQmQWa+lwOt0a57v3bsVVZ1UYA+OUci84dvmN/OfYkhK/Ajyn0dOzgdgQr3xHW/ZexXeEvf5v4LksXsuIQNFKfywYdaj30HV+0w+4XHkuH6kbQPacQgaMreiyhIQ7vr6DnJqLYZUw2v6ETPa5+Pa065kxx/8VbKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223099; c=relaxed/simple;
	bh=MUpffNQtTuMogr/Z0Ui88SDz5hy4fxKiznghbUNZqy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXmEwTswzkntU5CHcEUMJQULT2crmUO0499xHIBx3icvru/NrxQNBNveZOi6HujTyfY8VYjiLjLpQzffqZv+1I0t2rNCbHbHm2gh38KqF7Ay3Gm124og2R6dY+tqPaqF425xwwIUeErYldPsXVpaKUPi/VNsJnxQg1tfY1P0pqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAzz5vCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F19C4CEE7;
	Thu, 18 Sep 2025 19:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758223099;
	bh=MUpffNQtTuMogr/Z0Ui88SDz5hy4fxKiznghbUNZqy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lAzz5vCzn+2fe5ZhpKvi4G3vWsd5j9LSjYgh4ajOqVJZHJ360/AkSEHr0un0YwkgV
	 2QjosqpmjgPauPghNP3QE0pBpijuUx0KrIgtG8Anns0O6fF/Iag0N6EwFK/0X3S4Y8
	 lbBlQNgjY5y2+XkzaXhe+fP5CgNNlRSTm8MOd1VGLjRCouNzRhXxZelmCb4diq+hke
	 nMCpCspQb5bR+cT0D5ilPryp4l6zGd4JuTsBb6BHYdbUlSnzi/pheWXD8lNNsmUGH8
	 CS5eC+bQjXZwmHNLNSL9kqQgsoPChMfWcF+aj8m0kSZmEz+f3Drx6otOg4zZ6mqKkn
	 HgnUKu2P78Tkg==
From: Sven Peter <sven@kernel.org>
To: linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev,
	j@jannau.net,
	maz@kernel.org,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Sven Peter <sven@kernel.org>,
	Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v2] MAINTAINERS: remove Alyssa Rosenzweig
Date: Thu, 18 Sep 2025 21:18:14 +0200
Message-Id: <175822308081.28767.18396895381445166904.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250908-kernel-retirement-v2-1-85c9d4d49f26@rosenzweig.io>
References: <20250908-kernel-retirement-v2-1-85c9d4d49f26@rosenzweig.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 08 Sep 2025 09:04:19 -0400, Alyssa Rosenzweig wrote:
> I'm moving on to other projects [1] and no longer wish to be copied on
> kernel patches. Remove my MAINTAINERS entries: both related to Apple
> driver support. So long and thanks for all the fish.
> 
> [1] https://rosenzweig.io/blog/asahi-gpu-part-n.html
> 
> 
> [...]

Applied to git@github.com:AsahiLinux/linux.git (apple-soc/fixes-6.17), thanks!

[1/1] MAINTAINERS: remove Alyssa Rosenzweig
      https://github.com/AsahiLinux/linux/commit/07db1def8f0a

Best regards,
-- 
Sven Peter <sven@kernel.org>


