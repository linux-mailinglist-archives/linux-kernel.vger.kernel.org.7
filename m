Return-Path: <linux-kernel+bounces-862879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4F1BF6733
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB673B4D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5205432E692;
	Tue, 21 Oct 2025 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GnZHyuuU"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489FC1624DF
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049487; cv=none; b=Cmnwyurx+/zO052881+3rllf/WYR6csUgIcGfyRDHStsdNfG1NRZPvz7TTvdTZNxDuXYgtu61cz+a/oK4M4H4CGOac5TzPpVnHHKI+F25U31uxdak4mv1zHfTBvHB86fENofHER2UyfYmeKvMS8lSBx2dp7ZJtWzdXvUbMPwiBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049487; c=relaxed/simple;
	bh=apfs3jGqIFxCHgU50JgWLy7WLTks0C3kWsu95Vdwek0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ww04VDW27viAPkWvyrylJ68Y0BNxJu5eKZvxiZe+bAL0yw6tpO2W7wGbXgDnxpZlgW8wqtPoR3pn6Zyua+KOrYwK4BqbNGH2c6krWwznBSI775wbiT48N/3V6/o4hsyNgSV2oYhoLuCPbCOYi1kgGVGW/NSv2R72Q2z4GT/gkgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GnZHyuuU; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C2947C0B88D;
	Tue, 21 Oct 2025 12:24:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 56B4D60680;
	Tue, 21 Oct 2025 12:24:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 09F20102F23F4;
	Tue, 21 Oct 2025 14:24:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761049481; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=sgxViTPHld+molapvS+fsvHPLEsN15Txlvwm8TOMC00=;
	b=GnZHyuuU+cnbMGMDw8AprTyTJ/jYDTvcVjDmbTNU4VfjuNf6kLSQLqG9QzJ348m7Ue8xAV
	AyAGvXDClrSlpbZ0wV36Q58E1PoTyZPz9EZmcinIsMLRtE4OQf6bouXdkEGxBBrav5Q0Jm
	KA5Iqr4xSCIoWF40hgxpErcyzAyA30lcSeHeOqz0LkOsnrt8R2x3IdWbSuxYgA6HbJ5KQ1
	Lbu6iGNXvzLCjQ0TQINxz3hpaVuudOX9TwQ+wThFGlhaUL63/7qUi+ucR+7yS3BS9iu4WK
	zGaZjYZhOKm2jL7/9k9lIObv2OotrMQQ4JAaqiYDitJyclslj14Aq/GIFeMRmw==
Message-ID: <bd5f5dae-ec26-4b45-8b7c-2062bdaeb6a5@bootlin.com>
Date: Tue, 21 Oct 2025 14:24:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/7] net: dsa: lantiq_gswip: convert accessors
 to use regmap
To: Daniel Golle <daniel@makrotopia.org>, Hauke Mehrtens <hauke@hauke-m.de>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
 Lukas Stockmann <lukas.stockmann@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Peter Christen <peter.christen@siemens.com>,
 Avinash Jayaraman <ajayaraman@maxlinear.com>, Bing tao Xu
 <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
 Juraj Povazanec <jpovazanec@maxlinear.com>,
 "Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
 "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
 "Livia M. Rosu" <lrosu@maxlinear.com>, John Crispin <john@phrozen.org>
References: <cover.1761045000.git.daniel@makrotopia.org>
 <535d968bc6319a74bdf76166ef19364ee659285f.1761045000.git.daniel@makrotopia.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <535d968bc6319a74bdf76166ef19364ee659285f.1761045000.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 21/10/2025 13:16, Daniel Golle wrote:
> Use regmap for register access in preparation for supporting the MaxLinear
> GSW1xx family of switches connected via MDIO or SPI.
> Rewrite the existing accessor read-poll-timeout functions to use calls to
> the regmap API for now.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks !

Maxime


