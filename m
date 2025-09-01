Return-Path: <linux-kernel+bounces-795136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B65BB3ED43
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 19:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05161481BE9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E1A30F7F9;
	Mon,  1 Sep 2025 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO+kCxmy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20A32F745;
	Mon,  1 Sep 2025 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756747179; cv=none; b=L5uMkkMDrGfr80VG1JyH3IF0pxcpvYLaZw72Y8F/R6QeRFELm43V+x4G8wO8qnygGAKRK9Fi5aRj7lJ8KdHIG39vAt/4xGRH7hXqNJ8kRUcJ3Fpe9g4ZEshxnXfTwhfhNVHxX817IoBoDYwn6ywvjyVoffYWoL/fL2Y3tLEXWwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756747179; c=relaxed/simple;
	bh=5oAVz7YVTsEQbDhZ95UF36XNC4DV/tr/WQmwsEnciRA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jxnlV624yvmTKUWT3EeLAjXwCm3tKXQ+okvryPZD9l5y0xayahMZJtIJafWkQtNkI6pcC1eG04pJEo/la2V4mFGQT4izJSa9aufZuET4HKegmsx0Eor88W6EzOkbA0qfStitlHsOzlMrMlfGWKDRY9zIDtYbtiuHeOnrv6aqlhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AO+kCxmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F39C4CEF0;
	Mon,  1 Sep 2025 17:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756747179;
	bh=5oAVz7YVTsEQbDhZ95UF36XNC4DV/tr/WQmwsEnciRA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AO+kCxmy++aRDix6yrrcdTVZ2IYdnwktJEUqmH62okkkbTSJIK2goDRTkEPi3ReTI
	 VTn+sBTdJ33GHW8aiwDFXQh+J5O/RX2bktHeN2Z/0rVG/WYVsiA9py3t3VP4HoOXqD
	 Vx9eIb2tpMNWi8shlUNoHwHlqTT6Jma9NiXCrbV6qxyTeuSag3VCymrsNnTwLD/clT
	 537p/SvVX2UetYJ9E9m74Jyhm1L4ctu5n2tpFN91wgGVZpb+O9drnbKhDh9lDaMhxI
	 KN1GyX8CTHwm+nwMy/Ign7exKGcla5zWAT0k/xnn+n0i7nMJrlPKjrhKgvrLKLLx7P
	 ELBeh8UO88suQ==
From: Vinod Koul <vkoul@kernel.org>
To: yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev, 
 ulf.hansson@linaro.org, rafael@kernel.org, 
 Claudiu <claudiu.beznea@tuxon.dev>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250827101506.927787-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250827101506.927787-1-claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH] soundwire: bus: Drop dev_pm_domain_detach() call
Message-Id: <175674717585.192919.9358743498136771076.b4-ty@kernel.org>
Date: Mon, 01 Sep 2025 22:49:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 27 Aug 2025 13:15:06 +0300, Claudiu wrote:
> Starting with commit f99508074e78 ("PM: domains: Detach on
> device_unbind_cleanup()"), there is no longer a need to call
> dev_pm_domain_detach() in the bus remove function. The
> device_unbind_cleanup() function now handles this to avoid
> invoking devres cleanup handlers while the PM domain is
> powered off, which could otherwise lead to failures as
> described in the above-mentioned commit.
> 
> [...]

Applied, thanks!

[1/1] soundwire: bus: Drop dev_pm_domain_detach() call
      commit: 969bf687c12cd9f64ed9368f0c7429445de7c10b

Best regards,
-- 
~Vinod



