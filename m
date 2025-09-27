Return-Path: <linux-kernel+bounces-835097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CD8BA6404
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 00:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB58317E953
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 22:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C097122A4E5;
	Sat, 27 Sep 2025 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Q+ZdEJYR"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB041A9B58
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 22:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759011543; cv=none; b=ZqBaGyhkBYxDID8AjXQP+eRmbTGtksgPM/Q8mmDiLImDgb7Q/bxvE+Q1sv6oN/N800enQfKsgUdMDgA7NfaX7DiI4n9sP8S3YMYQeHKvYAMti88FUpFFuyPQhkG6BAIMYy1hHx/RfBDb0FQqJK895OzayQGkC5m1ctTBr7eMxL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759011543; c=relaxed/simple;
	bh=qHXGmAuIePeCpH7LdHQnGMsCPlVDCdbX+gIVg17PLhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwmcGFSE8BInnhfDt9gJ5UckiYwcdzNc7Ebxh7b+Xpgm+pfPi5LQeKrbeYlBojTZ2Ths1WSvKivm0JM9zCyIFUb8eU3J3rEctT823Rwqy8ibeC/6hGAKTpnKbqNcGKD18WYUUOQZP1qby3Y4XrpQTuu14qKK0ddc3fmEQYZrUC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Q+ZdEJYR; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=QfbX
	j9fviVm/KFNwVC8Wb5YOEoZ878PUaOZEfMSIiHY=; b=Q+ZdEJYRpv71A5cbl19+
	RCU21hWfR6wYipSaz2V4xUo5R6tIfyxI4ec+PT1Qscr6twHp/+ms2mdTMr/Y3SpR
	gFkQU9Ngy08Y/1Adw4HkUNwoWeC+ZUcT6owDkV+zQ0XZhlC/Yrx9JCGh26P5nLZR
	1EiMIoYDbzHsmkKZb8EjAekQBi/sh2DhUoGRsh1nIZ7sL+OZvYdMTOaAD1HZCuyA
	blBd457OEJhBRJXiN4eK+pSnXRhZBqckYQR/chIZvnkVFk7WFO+Yo7yv4DB8zF+e
	UEEoT3ZmT6+/r6y6d9BMlHyVAWo2QwYC+wTUd31lRYgBSenW8MT1bverr1ze9syA
	4w==
Received: (qmail 2700857 invoked from network); 28 Sep 2025 00:18:59 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Sep 2025 00:18:59 +0200
X-UD-Smtp-Session: l3s3148p1@Fd/tyc8/rJYujnsw
Date: Sun, 28 Sep 2025 00:18:58 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS: add entry for SpacemiT K1 I2C driver
Message-ID: <aNhi0vWtFg2v0nl6@shikoro>
References: <20250926-k1-i2c-maintainer-v1-1-3643be945fac@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926-k1-i2c-maintainer-v1-1-3643be945fac@linux.spacemit.com>

On Fri, Sep 26, 2025 at 10:51:52PM +0800, Troy Mitchell wrote:
> Add a MAINTAINERS entry for the SpacemiT K1 I2C driver and its DT binding.
> (Suggsted by Wolfram[1])
> 
> Link:
> https://lore.kernel.org/all/aNW5KfIg-_4-Et1S@shikoro/ [1]
> 
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

Applied to for-current, thanks!


