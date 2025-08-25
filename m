Return-Path: <linux-kernel+bounces-783992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87234B3351B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375AC3A4EF1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC1724A05D;
	Mon, 25 Aug 2025 04:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="migGjffZ"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA762367D3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 04:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096509; cv=none; b=oacUeSUhQFkJcckdfWhtfu51lkOKFC0PpdwJ+wZnOqGu2ZNnD2ILtqkeC8pmOUaKwwvhQzC9DnMARNuIa20YJorSvgovW4VWWwXKOIdhIF6QSPZ+D8+Uw9ZYOgm7Rf9pvg+OoEjSnBYFRqVdX5WXDen45EJOXCZKPGiiJ4rj53k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096509; c=relaxed/simple;
	bh=JAqJ6khWb3E1YjDk3jiUxTFsZIZ44UhIJxCJQRSWPBc=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=EsWTjjV8uGBgdZxt6Co/ivOVsv0UrW9T7XZG51di8CrsqxeegMSd67xLQHLcWIPkNceirvHjFC100z4TRlEpDE1mtxbLzxQZPIZ0GTv39dgqfbyKSErSEVFYCok3FeHrihLAagToeVD8lXYW2JZFj5iWvT/16GgelJ6RJLFeN4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=migGjffZ; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756096505;
	bh=KRq/IwotzLLYuVj7PpxaygrL44sgkinwI3pjoy5upqE=;
	h=Subject:From:To:Cc:Date;
	b=migGjffZRA8dfDHH3+sAjmK/q1cv6bIL74ULtRDFN4fleamO+S7VfU1iVs73cw2eG
	 Hhad4DV03Lc3c3k3DdISvGbgygzgVJXRkD9w34lcbiQEaGqAvzj4rw5tRG42P8neKq
	 B96gwzXu3tu7TlesGJafzo3oPV4LZKB2IzzMh1869QVs6TDbjTi45UMpSQ0sOaSrFJ
	 8R3tJ4wQyfp1Y8cnm2vhaI4LkfIqqT5Gq1jiy6O9iKz98HV5xaFxRej5Rc0M9NZPFV
	 Radu8EiQmbWWrVgj2YX1O0Q3HBvzQ8lwu0U82giBbxbMnPzh45GBmqSnd6p+1wBvAc
	 3B4G9FiNf2JNw==
Received: from [192.168.68.112] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 179C0640BB;
	Mon, 25 Aug 2025 12:35:03 +0800 (AWST)
Message-ID: <bf3734aab62a5fcc8959261551bb4b1fa636efbd.camel@codeconstruct.com.au>
Subject: [GIT PULL] nuvoton arm64: early devicetree changes for 6.18
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Date: Mon, 25 Aug 2025 14:05:03 +0930
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello SoC maintainers,

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585=
:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/nuvoto=
n-arm64-6.18-devicetree-0

for you to fetch changes up to 13587befb34ffa5d605196494c243420e045f28e:

  arm64: dts: nuvoton: add refclk and update peripheral clocks for NPCM845 =
(2025-08-11 09:38:08 +0930)

----------------------------------------------------------------
Early Nuvoton arm64 devicetree updates for 6.18

Integrate changes from Tomer reworking devicetree pinctrl, reset, and clk n=
odes
for NPCM845-based platforms.

----------------------------------------------------------------
Tomer Maimon (3):
      arm64: dts: nuvoton: npcm845: Add pinctrl groups
      arm64: dts: nuvoton: combine NPCM845 reset and clk nodes
      arm64: dts: nuvoton: add refclk and update peripheral clocks for NPCM=
845

 arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi | 669 ++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts     |   6 +
 2 files changed, 663 insertions(+), 12 deletions(-)


