Return-Path: <linux-kernel+bounces-857403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6C0BE6B2A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190B51A6695B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC3330FC06;
	Fri, 17 Oct 2025 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="STF6XOpt"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D800C3090C7;
	Fri, 17 Oct 2025 06:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682811; cv=none; b=lV618Zd/Fso8XNBRDwaEk84wdkrzhbjswMeve/vZmH1EKCVWBDk/lSajdVL9TI2OmzB5LmxIfWJk9RGX2HjAwedYSFG+/jPUTEvXkf9MZy6unz9KuJWXFT+vEfLgLEnxwMjFxaX9/a+LtCJlL5B6jr/KFKy87esXnik3Dbw14NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682811; c=relaxed/simple;
	bh=l4zzfEVXv3kCRK1+tRhEDpGxTNtWTV7qUWhG7JQ8YIo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KwzcoWOU83qR6x2suZZsWmrBG5kJQhI2lAU2kAO6mYeXp0oYBCc77XXxwQCFsBrruCLCE/HpeySW54dV2ZH34fAFTFw+iIU4OUyJhN3fRKcT9wxw9FbKShJoexoFgjVnG/HInBj2Odryyen9maLvyQQJdyMegqiKi52KhLqbOAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=STF6XOpt; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1760682807;
	bh=l4zzfEVXv3kCRK1+tRhEDpGxTNtWTV7qUWhG7JQ8YIo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=STF6XOptFjEdvztYJZwPnC0JyF6vqPLgDYj+odIW6iC4xrMsgOUu1dfvk5Hggrdfk
	 Z1nlI8gOrbCAB5obJh5jS0l47Ed0gTddOrs8sXOSM2qvt+AL3pcz2x3BlrqSPptDfb
	 Ghzz7Tsp1a83YtdmlKCHDDndNwStg1z+lbxlhI893/kEk5sgabe9Wkj8J/p/xxp0PU
	 OItXpZqj7Z7cNUNnxhjvgAdyBiYYHEr7ORzntoPlKozXdtE+XbDi5HtEOU8Sv/VsdA
	 EslNzMXdoPc8kCH2pGRB4AF/2Jjx2sOGSgxLLWhqLltHKnc89xnqVBcK+rHgVO+dVf
	 O4+fKXtQSvVNw==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E420D7702D;
	Fri, 17 Oct 2025 14:33:26 +0800 (AWST)
Message-ID: <8bf232de1d4254afc408b415d3476c2c2183a4ac.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: bletchley: remove WDTRST1 assertion
 from wdt1
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Cosmo Chou <chou.cosmo@gmail.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	cosmo.chou@quantatw.com
Date: Fri, 17 Oct 2025 17:03:26 +1030
In-Reply-To: <20251016052727.881576-1-chou.cosmo@gmail.com>
References: <20251016052727.881576-1-chou.cosmo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-16 at 13:27 +0800, Cosmo Chou wrote:
> Remove the external signal configuration from wdt1 to prevent the
> WDTRST1 pin from being asserted during watchdog resets.

Yes, this is certainly the immediate impact of the patch.

But what's the motivation? And if asserting WDTRST1 was the wrong thing
to be doing, why was it done to start with?

Please address both questions in an update to the commit message.

Thanks,

Andrew

