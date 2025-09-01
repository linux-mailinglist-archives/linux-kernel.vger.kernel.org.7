Return-Path: <linux-kernel+bounces-793671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671B2B3D6A4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49B93BA6A4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA8F170826;
	Mon,  1 Sep 2025 02:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="k4AXxQjd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rTYHesc/"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8838317A2F0;
	Mon,  1 Sep 2025 02:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756693422; cv=none; b=cTWMfUd6SQdApJ0V+TMXGyI+Le8nCrQqjKewFUKk4k7PzwcG2c5qzDV9eKRBCO0ySgEDd9/u3cPQSWZHDJrqqYSweNfnstl4I0CECiIOCYynYyh9YEOL2FZmTdj9sCMY61pGF9wJmcXkmJs1hrXU5/7vS+L+RiV4XkJ4qbDAjEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756693422; c=relaxed/simple;
	bh=cTlm40qAW1ER//EYBPrjKsDBqFJg70C/SweWZMMApj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMrNo+16ZI8QvdjCgaY8b9WQvQd+T0HWJ5O6yObomkbP11lDSv9I3hrt4kKtI0gAnMUjqMkfZ2wM9I4CQDK4lQ4178lGNRNpSY/2p5W6M6fGsOiw7TIxm9nwnZsJguv21QkehmjAdMQbjnzgAXzE1o0g1OM0Z+a1gqdVDrl9Ppc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=k4AXxQjd; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rTYHesc/; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cFXjc46qRz9txD;
	Mon,  1 Sep 2025 04:23:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756693412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KcWCEGr6qgfUpHyZ2bb6dMdRWns/kJMvA5VGMIiIy+k=;
	b=k4AXxQjd1HlPeiobIXEyCI/jPC7mEgm5egg8qPp/VjK6R86RjF6t8LNlyfh9ql1PpYLGtW
	mEkBFKEBM2iVUPUMTi/RdeLkxKky2dGzaccFTRAp0YV9d96tDyleefubHqiKPQKezIg+Wg
	yDiTo/hjW8RMC4wjqjLgCndkAl8nolvlLaDHatyjii6VN4HTaLbKs1ixShzJDI3Gwf1KKN
	numz88zOiVLTBt7KifaXQBkNdq5VjrLk1CcwXrcSDjtsnr05s2LDIDCFsbhYSOP7bKNclB
	EnzWVawgB99hDcjt5Zxsnyn9Ud+rrEAk177S+kaYXIH2mfjUORHeagQJdkm48w==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="rTYHesc/";
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <3a165d77-3e36-4c0d-a193-aa9b27e0d523@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756693410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KcWCEGr6qgfUpHyZ2bb6dMdRWns/kJMvA5VGMIiIy+k=;
	b=rTYHesc/kk5s8Qp5Pvw6sOAA8w/F4tmZAJR0CL+95Pek9MllTDu+g7oK1I4knmFJBA3wiZ
	RiS9S8Y3iUjfPlbm7Rt8KpHRXEgX7zWTW01iae98tu+vYzRScscMKHShrW/H3kG1LtH9Y+
	ZsRZIIZ2BQdqPWxOHYgHTr/iLvwxqrT/yZcLzz5pCfifQj9KoddK2wcz9OXVzWFGO7yNeu
	2eg+NK/qB41UlrZuDIW5zW9IH1sNJdr857AE5YwM9n8rnoM+acR+Sm0E/7zL1nH6CS/4QZ
	mCUoi3k11IUgHZLNCVMGmcv54KacCTXPVhLajiCOnbvnRZfajDuxrGDU0ZBZOw==
Date: Mon, 1 Sep 2025 04:22:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] dts: arm64: freescale: move imx9*-clock.h
 imx9*-power.h into dt-bindings
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 E Shattow <e@freeshell.de>
References: <20250831200516.522179-1-e@freeshell.de>
 <20250901032203.GA393@nxa18884-linux.ap.freescale.net>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250901032203.GA393@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 348a3e4ca199d13e5ef
X-MBO-RS-META: drwo57x9gf3fnmbxbskh9qyqt8zpddsz
X-Rspamd-Queue-Id: 4cFXjc46qRz9txD

On 9/1/25 5:22 AM, Peng Fan wrote:
> On Sun, Aug 31, 2025 at 01:04:45PM -0700, E Shattow wrote:
>> Move imx9*-{clock,power}.h headers into
>> include/dt-bindings/{clock,power}/ and fix up the DTs
> 
> No. The files should be under arch/arm64/boot/dts/freescale/
Why ? Linux already has include/dt-bindings/clock/ and 
include/dt-bindings/power directories for exactly those headers , why 
did iMX9 suddenly start conflating them into arch/arm64/boot/dts/freescale ?

