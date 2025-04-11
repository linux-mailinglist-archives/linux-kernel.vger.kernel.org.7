Return-Path: <linux-kernel+bounces-600846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5356A8653A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 20:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07CA4E1F87
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 18:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DDA258CF9;
	Fri, 11 Apr 2025 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEZSzV+4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890EC23E359;
	Fri, 11 Apr 2025 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394748; cv=none; b=U2ovOYO4LC4i9TPFrHuZR+dkDur2JZZjSam3JbM+k3nshrdOLcqZnpbx/edZwdYFhopLQ43YRpSNyoEBJJqrd3rEenKl/cXANJIiloVfXApJue2q8JYoM1agkGLbyhGs78wQzT1WCAJexc6iVP5te0ZU9kyzuDYEBxIRb7CvWQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394748; c=relaxed/simple;
	bh=d0eTxp4UU3sSrwW/EB6XhwnIu0J5rklUPk4/9k0bVbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCxmhNprSo47K/ceeeZdxvoMgANPD7GWoJyGCaQMrCqRlg6HUFortmeFq0hL1eIEgF4pf0rtf8iYvmoXe3ECJ1ZfTr1VNil5a4tIXNN0VDuwpNM+wvFLhBqdKxdsNmEkMz4zSN27fKu9Y67wnBPDmbUWs5hbQ046PRTla/otUZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEZSzV+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40CBC4CEE2;
	Fri, 11 Apr 2025 18:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744394748;
	bh=d0eTxp4UU3sSrwW/EB6XhwnIu0J5rklUPk4/9k0bVbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEZSzV+4gTSd/n1O2uloRjarn9CguqUVtYzGWrHITtorkQ8PYEnnwvpVcnI7flg3I
	 ouP90nWieQZ3SaWV7rvJqvLAsWx0nwn6fmh4dYko2K2X/n8FnfmI7q4LhFmqC6ruA/
	 Y7UtF3nXDNhCPFxUc+7YDCC3IpAMOghksGmuqhJ1SUHcj678R+mkz6Tpatb+p9Bmkm
	 eVotFEwoMHJ1CvnJcRO2PMOjoLAnAfURDtV/d5Nr0MxrR0ZMeF1Ut5Ju1jMpy/1R2H
	 4DRVx8ju5BABNplhWsINA28dyruwXaDM2VW3BpuYlGduHjALF7hQWiql99W3DIUV6O
	 JXNOM06LI6tlQ==
Date: Fri, 11 Apr 2025 13:05:46 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michael Riesch <michael.riesch@collabora.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Collabora Kernel Team <kernel@collabora.com>, imx@lists.linux.dev,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-media@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 3/3] media: dt-bindings: sony,imx415: update maintainer
 e-mail address
Message-ID: <174439474605.3672762.16503161569954829590.robh@kernel.org>
References: <20250410-maintainer-mriesch-v1-0-cdc5c6c68238@collabora.com>
 <20250410-maintainer-mriesch-v1-3-cdc5c6c68238@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-maintainer-mriesch-v1-3-cdc5c6c68238@collabora.com>


On Thu, 10 Apr 2025 21:41:32 +0200, Michael Riesch wrote:
> I recently left WolfVision but would like to continue to maintain the
> Sony IMX415 image sensor driver. Update my e-mail address.
> 
> Signed-off-by: Michael Riesch <michael.riesch@collabora.com>
> ---
>  Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml | 2 +-
>  MAINTAINERS                                                  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


