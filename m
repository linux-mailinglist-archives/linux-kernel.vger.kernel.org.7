Return-Path: <linux-kernel+bounces-862500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD70BF5782
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E839D34DB8D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E23328B69;
	Tue, 21 Oct 2025 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="QJ2mTk/s"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240848F48
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038465; cv=none; b=MXO6BEDu+gx1La5ZsaiRwF3k0ED9BY9Dy1+CZu2OKkivoY0Je+ZQH6oHx79ewEfu//3MpO70/L8a23+Bo6WuWxvTA74VFGtuyKfGEep3sL4Ju1teI/xVfIBD2sRBkF2PiIkNIrdbveXKV+qMawe/nRTnpiqtIv6pr0sxCIMa61c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038465; c=relaxed/simple;
	bh=P5k0IBnAe0ml2tNt8FSEmViccyeFQVUAb73oOBP4O4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l6Z/iMdvFrVoHtoaHx7fqUz4vkL8cX6pwbTmKxpTR/XzyStYqE7tIXRJNQtIHpgvOVeghXBwi5/A3ArRRzQrolCfxDiG4eIR6bWKFSTDbgW3QD45oLy4B/KC9kwV79WDrhPlwCVQnqtpyFL60gGxh6NGcB6F+Lq4F2MqZSi05J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=QJ2mTk/s; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=PWQL1JLu99aUScGTl3BlK8hhjZ5L6bf92gYoRK4SM6g=; b=QJ2mTk/s2xEy7yC+Fx+lSwDvMI
	O/QiJ/tHF/+pDGH4pZeJwHhtq8/fREjwOFW3szKRzqnPwk13ns38zcmX0V3yYTpQ4SRmr8JpEPfbC
	NhEJKZVMMf3UadSo78WdDeKuyuC0ujKQaR+bgc5RL9UGkLEIKIYzW5RXtrmh5lBKN8HtopTzrH2nT
	Fo94U4rHsNwupvuOMlttre6IOCXOE+wSOwLUaXSYhnkw3ekDvQDh8Fi/9ntKEE6NDC2l4swF1GiD0
	99RtjZT8W0Qcz5xNzurmqhxAUxT/csZ+V0c9Pubrdis9wGXdbwVK0XlZm/Ik74lMAj5wY/Gx2dQxM
	QjSgMQTA==;
Received: from [212.111.240.218] (helo=phil.guestnet.ukdd.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vB8Y7-0001mu-Ct; Tue, 21 Oct 2025 11:20:59 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: WeiHao Li <cn.liweihao@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] soc: rockchip: grf: Set pwm2/xin32k pad default to xin32k for rk3368
Date: Tue, 21 Oct 2025 11:20:57 +0200
Message-ID: <176103845188.96519.2904538243540608377.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250906142125.7602-1-cn.liweihao@gmail.com>
References: <20250906142125.7602-1-cn.liweihao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 06 Sep 2025 22:21:25 +0800, WeiHao Li wrote:
> PWM2 and xin32k share the same pad, but some peripheral need to xin32k
> clock to run properly, such as tsadc. I have observed that this pad is
> used as xin32k by default on some existing board [1], so it maybe more
> appropriate to set it to xin32k by default.
> 
> I also tested it on another rk3368 based board [2], without this adjust,
> tsadc does not work properly.
> 
> [...]

Applied, thanks!

[1/1] soc: rockchip: grf: Set pwm2/xin32k pad default to xin32k for rk3368
      commit: fc3d701f0d75ffbd788991cbf84f4937435e504e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

