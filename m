Return-Path: <linux-kernel+bounces-880993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B010C27253
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 23:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7C5434D722
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E436C31195F;
	Fri, 31 Oct 2025 22:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="D2XOHXU1"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABF12F7AAC;
	Fri, 31 Oct 2025 22:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761951230; cv=none; b=rpj5cONblnAIRkJS3z/DItZX7/1Qi7vB1rZFCcD2Fm8OiT18Fn9XcLMfn4j9QbSh3A5sM6uoLFQ44Rz/Scez3SMqm4KJAGgEbSB/4tQecDTvfOejOAitj7lIOLJYMT41vcTeCAgZXB+jcmC4A4xOf4zXgNPevqLULdkNxYyEvmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761951230; c=relaxed/simple;
	bh=weMjSYLaeGKOwl0fiK4lffoRRdY+Q9GdXWPbxcItYec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3xvESRAdQyZ466BhHO3YfEq3dKwP6NRzUe66o+PXE7BWi9QEHk0TJW3HrUf4zomC63lBst+7shMvCHzYUIk6I9+zL0mkDTMi2gl7WOYL4v+kKTpPAYTkN+rZLRvWVVcVsqo3u2vy+A7eadkexPxBhwyWKtNx5x+cDVJ9d5Z23Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=D2XOHXU1; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=G9LGDsHV0V8er8+9rWb89z8ch8m1YHIGXEqcvL59oSw=; b=D2XOHXU1ctlN9GuNS4+JTrmhXE
	gQYlE+EJgQ+hxbvY23kAmJJc/otiv/+R6PXm0f5k3oFMUebBrYat2wQUfaYZFpJhySqgBtuw4fnbU
	UYpTm/We3nMkfb0Mp/g9goXZv7pBOfUvl1w+ZYmGn75qjUkcvmH9NN9dkuqurSJj9n+WZKmd/TrBL
	62v/jUC75sAh4dvR8lwCDDOmRm/4vHc4vd9Zd4Xygz65TO1+5n//aU3ee2YDhmHg+JUtLnR7ucf9B
	kCi6MxEcs9N1YBRL2WKaWP1mNO3m7b4rBhqrUCXMj6twzHvFZ0u6IpG0pYg1VjDBtbPL0iJYjk8S2
	TY08Ix1w==;
Received: from i53875bca.versanet.de ([83.135.91.202] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vExzr-0004vM-IJ; Fri, 31 Oct 2025 23:53:27 +0100
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
Subject: Re: [PATCH v1] arm: dts: rockchip: fix tps65910 nodes
Date: Fri, 31 Oct 2025 23:53:21 +0100
Message-ID: <176195118793.233084.1466070272333250662.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <b3d05df4-a916-48e1-8d9e-590782806bd5@gmail.com>
References: <b3d05df4-a916-48e1-8d9e-590782806bd5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 31 Oct 2025 00:38:55 +0100, Johan Jonker wrote:
> The binding for tps65910 is converted to yaml and they have
> changed the regulator nodename layout and added some required
> properties. Fix the tps65910 nodes on Rockchip boards.
> 
> 

Applied, thanks!

[1/1] arm: dts: rockchip: fix tps65910 nodes
      commit: 130daaaf1088d1686dbc4c9a2763132c43a4d980

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

