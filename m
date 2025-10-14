Return-Path: <linux-kernel+bounces-853203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C63BDAE7B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14CC2343917
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9143730E824;
	Tue, 14 Oct 2025 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="S0qvk2R2"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B67230DD0C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760465230; cv=none; b=c80FoOdjjWVXoXzEu1WwanArI62ETG6e9WrcnAhQpBl9uK2SmVCz3iDBNKLi4V3dmARdtHmbLHo18TuP+xQjFFRIIqdqQ5ZBypo654DCCIJnT+EPA/pigxaORKtfJQXFYjWvtvLcwHojLEsJ8J6j6SrygDXNo4XPUyCcPtdjgaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760465230; c=relaxed/simple;
	bh=EljfEEnOJssFopcsr1sZpomrtqIfOCKfb54XGc4G5b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dyovkKkl4wLJbVK7jqBnpSyFN4Q2z4qfXLCSfmJQJxAqbdaIItBco58bxdnfZ88o9fkmiTKipwexfzqgJ1Uy5W3Yj/4O8ds5f6JMYNMt+EIUwv5jHMVhJLWUd++cB5l8FXBdmcdNHcnKPg4Fi9jsED13qI58Vk4hcWsjY1XrR7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=S0qvk2R2; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=DgS+NBRZ5meprDicmbCbMq8Y1cdxTX/xG2+nCSlVa7Q=; b=S0qvk2R2u1KZkuHrcvuzi4k3N7
	hOi/qvW4YSP6FTZrfLLPexxOvNW6npYimuZ0gXjzaCzXvzdhKc1/yP9DS9KkVodHIIdMzvvzmmmWx
	SHMhRrguSkM28KL1bLp/BXCx1PabyLlcaJ4KoAiHMUvi3TE7D1+cjBHv5PR+1AAFlFLvLVGAiIFTu
	uuABaFUhh9dGXzM+5lzaUbl38mSCbBgmmD0BMPoqpoBpkfUX3NL7rdCV133WjwEJQ7tf7rXMJqUdU
	1itUs1sWZxxgZtHFaFghwM/13uwwXfGbJhNXWa8VhMlYzJ++Jh3dSyIL3SPuapIMqhTlbEFv2Zjmp
	mt/uUS2w==;
Received: from i53875b75.versanet.de ([83.135.91.117] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v8jQ9-0001Gj-BO; Tue, 14 Oct 2025 20:06:49 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	arnd@arndb.de,
	bjorn.andersson@oss.qualcomm.com,
	ebiggers@kernel.org,
	geert+renesas@glider.be,
	krzysztof.kozlowski@linaro.org,
	kuninori.morimoto.gx@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	nm@ti.com,
	nfraprado@collabora.com,
	quic_tdas@quicinc.com,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: defconfig: Enable Rockchip extensions for Synopsys DW DP
Date: Tue, 14 Oct 2025 20:06:32 +0200
Message-ID: <176046473171.1662867.17938708004609069998.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251013090955.48832-1-andyshrk@163.com>
References: <20251013090955.48832-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 13 Oct 2025 17:09:33 +0800, Andy Yan wrote:
> Enable Rockchip specific extensions for Synopsys DesignWare DisplayPort
> driver. This is used to provide DisplayPort output support for many boards
> based on RK3588 SoC.
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: Enable Rockchip extensions for Synopsys DW DP
      commit: 642f2879816801ce3e9b00e90c5ee8ec6265c0a2

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

