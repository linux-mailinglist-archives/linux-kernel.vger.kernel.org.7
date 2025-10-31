Return-Path: <linux-kernel+bounces-880995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B16B3C2726E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 23:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8313B99EB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D61313E13;
	Fri, 31 Oct 2025 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="HU7EEj8q"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7562930E856;
	Fri, 31 Oct 2025 22:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761951238; cv=none; b=MpCjXNY9I50dy+Bvq1fFbkw3+3MCVssw4jZXK0B00WvfvLgZKipFX0/zzADAoD2x0nkc9vBO3+rRR/vyHlOe0XKCjGTiOZRxXkdFkxsuxY1uoDGBwbnLah5hEFhbD9rY6azqrKS4rAxfyVzb/xgZAhRex9fA49WstIqzC4217/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761951238; c=relaxed/simple;
	bh=lbOyQwCohWmxWSdWKvzvcIt14M7k0kxxrcMWKedSfJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pj0il9BVnA50wD4cEih7CnPKF5/tkrsD7YFdPnimVMpj/mV5xax1jpeW4iLPPub/u7UA1Hc8SdcWdGu32CvfUHqeWdwgIMZBYm0ZNybT1oaaMuETY8e8yOgYfN7uwUpn+bF07p5Lcj2I3Wpy6Y3OxYrut9MsAVn5HEZvuLGaE+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=HU7EEj8q; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=0vACZFnTE1bFSK6RsWKOJ3s4+2BvKyHRqatrbxMl81k=; b=HU7EEj8qL6B/gNydI3tA0ju5Cu
	X83feZ/yfAG2tn2ObEDKc1T85bWsn4a6rYnPpDFc6XT7o5QFTqvAMbASE3jjHi3cnTKrddRLN1Uv0
	ztoIpS8/t94sZfWx+IlXr2Jn0SUlg5Z6Zj75+MqGQeDoLGN5V5ZJj29cR0TL+czAwUWu6eyYDweRs
	eJzKmsW3mMVXpp/iK4ediMhKT/3mDbeUCcZm6MMYf5K8a0S153OcPEcr/e0U0gkz+jwyYsk3o2dM3
	1G10CKxm1Mc14q91acqkd7pZYVYAgCLq7cjGeUAJevgQw6Zs6PoctGoTgnkv/qWR3ehTKNzqA5Ls0
	AZVAEyZg==;
Received: from i53875bca.versanet.de ([83.135.91.202] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vExzr-0004vM-Vg; Fri, 31 Oct 2025 23:53:28 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm: dts: rockchip: rk3288: remove mshc aliases
Date: Fri, 31 Oct 2025 23:53:22 +0100
Message-ID: <176195118794.233084.14651345764669751687.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <3e461bce-e8e6-48f1-a296-34040447ff25@gmail.com>
References: <3e461bce-e8e6-48f1-a296-34040447ff25@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 30 Oct 2025 19:20:42 +0100, Johan Jonker wrote:
> The use of mshc aliases is deprecated for some while,
> so remove them from the rk3288.dtsi file.
> 
> 

Applied, thanks!

[1/1] arm: dts: rockchip: rk3288: remove mshc aliases
      commit: cafaf99e4a790f8492a034a3470f878779c8c535

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

