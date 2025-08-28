Return-Path: <linux-kernel+bounces-789959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B77DB39D54
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA02C982ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E10A30F539;
	Thu, 28 Aug 2025 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="CQhOGgqJ"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8C723A9A0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384268; cv=none; b=sDNMVFbf2NY9a+G10fim4Vc+1CDg0IAjgiw/j5DuOPHIMAUUtf5WEzpaExPcYJuCSbCNVxpIzK4wUkfKTcbhYOIquyhy+AhBKFCm6tXN6SOZ3Onvuh6qzFtPJrgOzlLmkJAz2MmRK2hzAunSc7CDf8O8jWwI9rXb61RcQThTk7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384268; c=relaxed/simple;
	bh=ktZY4+V8SynXNo0twDCpIYYzzgGQaR86yXtzWizEcDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggsapaYXO5hqH05eDmNSLIZWIgoM+H8DUwNnBFDdcxcU5dsnfTzFiOsSI7hyJHnVO/RW7smcA4rnjD5Qp5jCBnjHtOau1FHacpMS8xBbOJzzRJM90MiCh+GP7QPDefXZXOnZsgY/Pfe22ANpYDe0rEb4MvTUGBscpYS7rKLVLU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=CQhOGgqJ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=lKjx
	Us4HVUC8rhIRTwan/Wzl+T8nuzbBj0Fovx1vxPk=; b=CQhOGgqJRmQoz1JKBm+P
	yMbBC6Eq9h7m1/1IJfTEQY4SCl+W013qyjFDAuVSPlWShtu+dBBaLRc9I8d0Rs67
	DiTncLfw824S0PmlJiXzD3Oh7bapfl7psFRBKUWxc8CkjwoLOoqY7rvPi97VgN+x
	dz4lNWsnynjRFKp+yN2gvkV13JFY6m0CrrJYs0pFkOupmOCGAExhqAfLdydKUayB
	cOcFGLoVeCCMNOsmapRX1LXUjKbleXJRjuMav4e9mv+WErVcePrhgSXO5mrlh0ax
	izn1BvCYR9nG95vQP1vxH1azGwVZL9rLTPlngW1iyx/Wqw2zX1aStUM2C9rq6qNT
	NA==
Received: (qmail 1012272 invoked from network); 28 Aug 2025 14:31:01 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Aug 2025 14:31:01 +0200
X-UD-Smtp-Session: l3s3148p1@1/L+E2w9BqQujns8
Date: Thu, 28 Aug 2025 14:31:01 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	"open list:RENESAS USB PHY DRIVER" <linux-renesas-soc@vger.kernel.org>,
	"open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] phy: renesas: rcar-gen3-usb2: Remove redundant
 ternary operators
Message-ID: <aLBMBYqEsORQwv-8@ninjato>
References: <20250828122401.17441-1-liaoyuanhong@vivo.com>
 <20250828122401.17441-3-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828122401.17441-3-liaoyuanhong@vivo.com>

On Thu, Aug 28, 2025 at 08:23:56PM +0800, Liao Yuanhong wrote:
> Remove redundant ternary operators to clean up the code.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


