Return-Path: <linux-kernel+bounces-775167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA59FB2BC1E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0175620A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26C0311970;
	Tue, 19 Aug 2025 08:44:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9508C31076E;
	Tue, 19 Aug 2025 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593051; cv=none; b=bBbcR9uOI9AnDlkOEcQE1xU6uowR6s/tasfAQ9ldK8u+YZrq1+4JT4qCaNmmdUxAsBG2dCUEatVqJTandnAnQ3T6uOp9jcFzenLFT2WiY+WP49kZwfEGLms+wY2IPdlX/6lm5m2UAjquyupbw8JFGUXsu5VmrXAB7jdEW07cTiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593051; c=relaxed/simple;
	bh=itEin/IS3TvghTDl9BoFjp/1pLUR8ohmvrFyeI+tsAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6EZOPj1m4w1YsTTQcZ/YCEbJ80UfMQVahF/o4Cf7YO16OdD1b7sYmMi10IJH3ngJWvHqsQ1FiiiknaxwB9guQtK7lqP/r9UACqi5hKwxOUSDLsTLKJg+5sBtIsOxCkA9QkyPlKYsrJzzoUA5iKj8T+mjfGHHWsXaPuyUM1xuEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BF8C4CEF1;
	Tue, 19 Aug 2025 08:44:09 +0000 (UTC)
Date: Tue, 19 Aug 2025 09:44:07 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Arnd Bergmann <arnd@arndb.de>, soc@lists.linux.dev,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH] MAINTAINERS: exclude defconfig from ARM64 PORT
Message-ID: <aKQ5V8iWQ7tqSnq9@arm.com>
References: <20250818-arm64-defconfig-v1-1-f589553c3d72@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250818-arm64-defconfig-v1-1-f589553c3d72@collabora.com>

On Mon, Aug 18, 2025 at 11:08:04PM +0200, Sebastian Reichel wrote:
> Patches for the arm64 defconfig are supposed to be sent to the
> SoC maintainers (e.g. a change in the generic arm64 defconfig
> required for Rockchip devices should be send to Heiko Stübner
> as he is listed as maintainer for "ARM/Rockchip SoC support")
> and not the ARM64 PORT maintainers.
> 
> While we cannot easily describe this in MAINTAINERS, we can at
> least stop it from giving false information and make it behave
> the same way as for the MAINTAINERS file itself (which basically
> has the same rules), so that it just outputs the LKML for the
> ARM64 defconfig.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

