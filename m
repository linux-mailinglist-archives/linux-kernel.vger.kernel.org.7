Return-Path: <linux-kernel+bounces-838356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB2DBAF054
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B893A7BFA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BE3279DC6;
	Wed,  1 Oct 2025 02:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ZFBoXrmi"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F85A28E3F;
	Wed,  1 Oct 2025 02:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759286570; cv=none; b=X3Y7dBKLZvG084jAURlsGpEeh5QIL6uBR8HoNpipjx2qDFWYjtz9bO1+djUqJRB/53f9IoNPKrBqZ3h2/2Z5s0AjY6zMP9aEeJNhcyXux1TfqLgNGpa1caaLedDuemzVaA/IufZJm2w8CKzs9onImn0SnTazQyVz2uR+IH8rkc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759286570; c=relaxed/simple;
	bh=LKDu3Xku1VOHGL1/rP0ISGCcRasJyfPBl3DfDB9TcZM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q/+gb6KqWBLBh2y5h0Ooa76mMnVxAVFmw651nxaRQltgGU44TwizdPwHSVKb0SonDInMV3mef3StPoWqbWtOkdxxM3eoKoQjNTVx3vL+1Z9BMLZW+V4aOmTPoyD0TYilRRFcan0ByskysCHcYuoPNDI9dcQMeMS2wMCtIgRKD+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ZFBoXrmi; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1759286566;
	bh=ZQ4G1nhO4fJCrWWO4BgcxbqmE8wNI73Tj0t3GM2e72g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZFBoXrmi4x46zx5rkn/TXKgnk88GhqVOBNlE0vpAngnzuswBVqBCuD8fygmxvJUbq
	 Zd+NhpkbpYbsw6adph0vkSqbB4wP3LkN/1rL6phz7FwuzrYY0ylj1VjpPOk8VR1StZ
	 xP3O0WVuX7WF40WFj1P/gV+lXT0ANNRRJFZlvzwevEQbWEHtzzy2K1LFqIMEoKTqEU
	 ObcdH8i+LgN5pzIn2T2SC5XVx2CJZFCvHsS/59pa043yFHkVBM6smC61lymxgFeC2p
	 yTpjv7sG/u0LM4pfwqd3hOQ0S5iyc4bMd9KA8RudInwK6pqZDYEhWbh8WsbaUJ5AHE
	 uIZFyalX0Km6g==
Received: from [127.0.1.1] (unknown [120.20.48.42])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A743264785;
	Wed,  1 Oct 2025 10:42:44 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Leo Wang <leo.jt.wang@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
 leo.jt.wang@fii-foxconn.com
In-Reply-To: <20250930-leo-dts-add-shunt-resistor-v2-1-8712984f04c4@gmail.com>
References: <20250930-leo-dts-add-shunt-resistor-v2-1-8712984f04c4@gmail.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: clemente: Add HDD LED GPIO
Message-Id: <175928656396.3584264.16163298971652448955.b4-ty@codeconstruct.com.au>
Date: Wed, 01 Oct 2025 12:12:43 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 30 Sep 2025 10:49:23 +0800, Leo Wang wrote:
> Define a GPIO expander pin for the HDD LED and expose it via the
> LED subsystem. This allows the BMC to control the front panel
> HDD activity LED.
> 
> 

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


