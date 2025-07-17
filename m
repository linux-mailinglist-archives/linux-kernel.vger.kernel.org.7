Return-Path: <linux-kernel+bounces-734940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D589B0888C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9271640E2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8511D287269;
	Thu, 17 Jul 2025 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="tT/ZC83o"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E141D7E42;
	Thu, 17 Jul 2025 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742570; cv=none; b=a9bnJfJVDB3e82uwyukaODrYOFZKE5uXV94Mrbo7WXvQ7+v4QvMjvuuNk+MTffW3IAKY6jRgyouu/zYdUWdw/fUP/+pO6Sk3v5DJs98yOKrpdp3dhQmdGgE7QICCyzL+Iezzv2WrMvzBa5zzgUvUwrZ4IYeoiGnKOyk9MPZx+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742570; c=relaxed/simple;
	bh=wDjQPMKJX0LfmbNdBRZ1OBogs0OKw4CpCIC/t1TB3cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fmlt7WtoTrcrvKSTMhOtVSX1dn0y/ByGdKAp/JCWEUV/BrIzKqUVvm5HcfiKta3tskdQj3sw2Um44EXX63wPv5P6QUHeNk3oe/OkVs+GHe3wYQek7mcli73gxI30/4OMV9aBSONPZGglafbmz7jcwsnjhGYYC7caQFuiwNH9CmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=tT/ZC83o; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Fm+vi59i9irqfaRjqlbyWIfZXnbSE0lm3Voox3qjKyc=; b=tT/ZC83oK9pfqOUtNYaMWeLtR9
	4szPu82OhfnmbqTHM02mJ5HA+uo9DzoAIfJhUBNp9qbHlQTvtdKRmptLURXy5yEY8duFhCcHP3l93
	mgOhwHq9q0caPlboimPajD2p9ha55k1Rtmocr3g8Xogqmf6q495s3UjUcTF5v6PgqYsLBsXBU6h2M
	YHe2i1jotnsNjdYLWX9resJmajYUo8rrogd9b3TqTs9/3r/4OW5iRL4Ej0d05JYYRqDOR18FftJ1v
	If9vm7shhUe6lW0T42nn1tMKHI3Uygjuct/vzCzsKlr6uMzjaD7W4z3KsfJ+chR224ZYRlBB9u7C+
	53CNTb6g==;
Received: from i53875bf7.versanet.de ([83.135.91.247] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ucKOx-0001jZ-P7; Thu, 17 Jul 2025 10:55:39 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Diederik de Haas <didi.debian@cknow.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add maskrom button to R5S + R5C
Date: Thu, 17 Jul 2025 10:55:37 +0200
Message-ID: <175274250488.2883196.9223067039415566893.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250716083355.327451-1-didi.debian@cknow.org>
References: <20250716083355.327451-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 16 Jul 2025 10:33:35 +0200, Diederik de Haas wrote:
> Both the R5S and R5C have a MASKROM button connected via saradc.
> For both the R5S as the R5C it's described on page 9 of their
> respective schematic, identified as 'Recovery'.
> 
> 

Applied, thanks!

And added a NanoPi before the "R5S + R5C"

[1/1] arm64: dts: rockchip: Add maskrom button to R5S + R5C
      commit: 07e04c071a35abe12957b575cd1453ccafc02eb6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

