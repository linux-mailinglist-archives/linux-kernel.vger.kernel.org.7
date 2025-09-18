Return-Path: <linux-kernel+bounces-823616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F0AB87038
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9148168F90
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFA82F4A0A;
	Thu, 18 Sep 2025 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Yt14HGzJ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE482DAFA5;
	Thu, 18 Sep 2025 21:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229785; cv=none; b=ir5tN+YC+lKJqGIs9rUMAXu89ZP1cu08nvMP6EbxLv6/T6x9Z/YwjwhdxuCIEX6zGX2nGdz6HmS4DXfYWRK3mcPWXALDpdYBpGhoRg6pKBfLJ5xBNp/Ju3S9TJYhEWj9tdT8bCU5T+gJ80Duaso2DrsI4UDtMMAJ1f7/ESqXH6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229785; c=relaxed/simple;
	bh=r+Zjwr7NaB8Tu7lm4OuKpaqkJtMOc8wpdiLZ0hrlHdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXp7mRHgqjxp+dIhrJ9qKqiYAq4xbOW+p3EIrGA34ElhKu/zHobdBPoFrShJc7hrk7al1hCaE/jTaICtBFIIb0jnZbzQkq12ZExjcMtEcP7BFxgKnJnAsDlv3ZkYmhIsssXzK8t+OKxpF4JISxbPnDcX41xgMdaG0xqn+12xbuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Yt14HGzJ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=k5SxY4eLV+XlJAjlLOtp7aA1VeVzrx+BBK+bjPWc6ug=; b=Yt14HGzJJaKjLaUYuqWpsmWAjd
	HNhfFwybW+Olkd1rOHpkqGvWLu+qkRmltdHX8xwSjFNen2ZeJqU9cdEkmFA4Zviq6IT/mH6YfeChX
	nLySIfNaH5XVEM1YRdvJMQ9zxd6EQIOuENNrlq4e8NbELhlmW4IjqWt+KTuN9yG0t7VR2TkRI1mYv
	9aG7fku5ICMC53+chkCHJxXomQxiM0qkpZsLhmOQQzxhnOa9WsbwNZjxAkY7l53OHvFFcrXaq8+8z
	ciuur/0buAqjpiktXFXYQ8hz/OQrO+D7669LOP5mTqc5+RxN8reDgthwUzjSnxbQWSJty3bRvBpwc
	9snIRUBg==;
Received: from i53875b0a.versanet.de ([83.135.91.10] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uzLsi-0003SC-GM; Thu, 18 Sep 2025 23:09:32 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/3] arm64: dts: rockchip: Update Radxa E52C support
Date: Thu, 18 Sep 2025 23:09:19 +0200
Message-ID: <175822973677.1568500.17167345518361865477.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901100027.164594-1-amadeus@jmu.edu.cn>
References: <20250901100027.164594-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 01 Sep 2025 18:00:24 +0800, Chukun Pan wrote:
> Changed from v3:
>   Add vcc_3v3_pmu label to vcc_3v3_s3
> 
> Changed from v2:
>   Remove merged patches
>   Remove VCC_3V3_PMU for Radxa E52C (new)
>   Update pinctrl names for Radxa E52C (new)
>   Update commit message for disabling display subsystem
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: rockchip: remove vcc_3v3_pmu regulator for Radxa E52C
      commit: 3edb9c95ffa60c029074804c39b35103a9fb4bfd
[3/3] arm64: dts: rockchip: update pinctrl names for Radxa E52C
      commit: cf311ff5e7b27c267c05279e26546fe74f46e5da

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

