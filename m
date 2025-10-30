Return-Path: <linux-kernel+bounces-879228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5E9C2295C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 564A534A16A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20FB33BBD4;
	Thu, 30 Oct 2025 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="aA/7kD3s"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD4E33BBDD
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761864175; cv=none; b=iEDsAgyuytqwQKtksSyFt4MjDC7efT1zYCvNy5G+jp43DdbnWlKpK58FQeMfDGtSVdU72yfZMVhfUsgLhScA3xh5I1uupLRzkwBQTKzRHKAoR3Qs8hnlCyYtBy/3so0sdfQSoE2wFOyid+pm703q72OiPkz14O6cVa2B/ASdgkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761864175; c=relaxed/simple;
	bh=z2njpX6D5Int27MItAgsDd+pA3A1KT2t8hfGAPA8f0k=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Vqs2ML87z00xiXRj70fAGEAIzvOUa1s8lS4r/GXfKsMarTM03Ci+1tigZYlFqHQ4BYBbPT9BGj21G4BVshxhrrNpEM90WrkSqwMrAH9+JtiiPXhtw0OCXvkWPrMCvaD5h5U1qgti2sOZcbTRn84qnNvi3EgWGRf8P93KPoUvMuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=aA/7kD3s; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1761864163;
	bh=PGcZ609ASUkoNdD7qkyIUnsaVC30SmdUGzl2/Zy8Bug=;
	h=Subject:From:To:Cc:Date;
	b=aA/7kD3sm9oCzF5qsgyxJbyrX3wsi5wtluu6MaklvKPCKBJDIxqmCc0DX1EcJyHF+
	 gktPwE/58no3ApFkCtcNv8yEMM+ryE0mrK6TVBIcLLqvti4SoWrZcUl2JEE2nHW8dz
	 dXJ/5WdYgSH7S8llbvX1bThJCAtvrlMcEQEpkCLI/KGBEkcWogC7WFGKSdBdEoHMyL
	 UjxUukyTD+7ODEPJaXgXzuewd1V06yoaUG0FliGNne34xGI5vHFSUiqrO7MH2z2lpU
	 D3AM5UX1COUxnTkrqQWeHnBYjCM+4q54HE+kqjos4xxyiztlpCehukyddHWlCCjAKx
	 NDUh4IG5k008w==
Received: from [IPv6:2405:6e00:2421:7372:17cf:8b2f:ac7e:ac4d] (unknown [120.20.6.198])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E8E2C78C99;
	Fri, 31 Oct 2025 06:42:42 +0800 (AWST)
Message-ID: <d79a0c80cdd9e2c45e6a82fd8c78219b6d53f206.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: First batch of fixes for 6.18
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Date: Fri, 31 Oct 2025 09:12:40 +1030
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello SoC maintainers,

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787=
:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed=
-6.18-fixes-0

for you to fetch changes up to 85893094535cced32b33766e283240164a5b11f8:

  ARM: dts: aspeed: fuji-data64: Enable mac3 controller (2025-10-17 16:29:4=
0 +1030)

----------------------------------------------------------------
First batch of ASPEED fixes for 6.18

This time it's just the one fix addressing a PHY configuration regression i=
n the
Fuji (Meta) platform's mac3 devicetree node.

----------------------------------------------------------------
Tao Ren (1):
      ARM: dts: aspeed: fuji-data64: Enable mac3 controller

 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dts | 14 ++++++++=
++++++
 1 file changed, 14 insertions(+)

