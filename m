Return-Path: <linux-kernel+bounces-783461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACB1B32DE5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83181200D6E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 07:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA032459F1;
	Sun, 24 Aug 2025 07:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Uez20UmU"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BC0393DC5;
	Sun, 24 Aug 2025 07:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756019284; cv=none; b=RgG6SGh/4i8CpscocVrADUlPYlsRdA8EYlWBTFGHMtlGI6iMcX7SZp19ie1eSGEkwQ++JgU03oU0Nm9suvobklMGhFPourZPpPmpa4E+DpayTqyW4kx8kmKsc2ZMo4cKSCJgfCIwB47ezwDKN64KVRTffHFO60bGx53Vi3DcnUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756019284; c=relaxed/simple;
	bh=DGbZL+pwFjQWTLfbK3DLzQA6CX3HU3QucBhW+xmwiDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYmF0pcCRvrP4dZ4+Iy3PghH+d9KX07Bv36+wbcqJ+P0BJaHA8FDZnIC0hDdsDQPIKqT6+9jcGHPNtSwtP5w25q/3F2wKhVu1yPimU70SOWPbMjLgE13a6/abDGeQeLoRT+F6aKQ3537L4xBF0LLBkcUXZDtawhh+cGYpHCRQJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Uez20UmU; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=ynMonaEdgTHZ5N5bILmpB4tAuADuKGxa9fL/MTeKXVg=; b=Uez20UmUI0sAa05rjqzqDt0CzQ
	8CKmOY35TVWUgZ3XEZq5XYmBWUeBO3nSAARscseuqupVvMC0kS5fiJIoJt25UEG31NUoPEp7A6n7k
	sp17p/26Ef+zUyoZPmvnq5t9EH4COzc0qhTg57xHl0Q0oWpX0n1kbXyA4DhvXW3S8Ri0zHbHp4EOV
	4WOs1VFde7QNtmWXRc0e7WQiTzGIMX6Fv+7C7hCgJgTyheCtONZLv7UVsZU28zmaKkRl2RvcYc+b+
	EP+X/+kvPpfqSS1ExO9i6Sx/HsqtbFDkj1A/KX9z4ED3kjT61KkVMFde+ZdCM9YfOyBiBXgSVk097
	O8XtqOdg==;
Received: from [212.111.254.164] (helo=phil.aerolan.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uq4pa-0002Oo-O5; Sun, 24 Aug 2025 09:07:58 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 1/2] ARM: dts: rockchip: Minor whitespace cleanup
Date: Sun, 24 Aug 2025 09:07:50 +0200
Message-ID: <175601920181.3425909.15494425933618614954.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250819131607.86338-3-krzysztof.kozlowski@linaro.org>
References: <20250819131607.86338-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 19 Aug 2025 15:16:08 +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space around '='
> character.
> 
> 

Applied, thanks!

[1/2] ARM: dts: rockchip: Minor whitespace cleanup
      commit: 106bdca970c1f66e2d4ee53675df1575b01c65ce
[2/2] arm64: dts: rockchip: Minor whitespace cleanup
      commit: 521b36e5a243d94e843c0f03285fc49ee88c37b6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

