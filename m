Return-Path: <linux-kernel+bounces-826593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F85DB8EE03
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 05:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230711899A24
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCAF1991CA;
	Mon, 22 Sep 2025 03:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="aOu6QaNw"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710C420E6;
	Mon, 22 Sep 2025 03:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758512815; cv=none; b=Ra+lMPxs7Ux+8p9sXublkN+/FKweAQawkbbyhn/Dvs8oLfFFptEIHEVzH2uiiQdkNIn1/zqf73V4dlmd6rpXiz6t2Sza0S8C+NKf0RtMvMOaX/lFeAchFfvxpL2z+2NmhI1tEbxqfz4I6tKdGpUQChwlnee2p4+rJ8LU5E3jVqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758512815; c=relaxed/simple;
	bh=8UBW0TG33ph1+Utocz4npWbwVd5NjwPsFKLy0B35yoY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PjSAVZ/pq/nrhBMNSRHQao6mZ++EX5toMZun6soX8rXhgGssBDKBgNc2BjzwDr9DaaxpFq7i6lyVdUjg9DbguHezAgeJfeMY2E/Gh4fKldPnOCOIj5/WNzM8dBQZiu70vZYH1oyxWH7AYqi6fMISOc/gV8PpsJqxWaaNpruvsmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=aOu6QaNw; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1758512812;
	bh=EtXkXi5o13UjPW6UOARCjRJLe7zqlxFB0MGqVZLUWZ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aOu6QaNwOL26odufxNXWWzUx+1ysq8xlrCO4dzH1tkRNHX79EvWd28MgI8Z/o+Y1e
	 /wwVGYpCbWMZYELCuYWNo00YsjW0i+2TUcePSx1jW7VLc3485Izzj7YjBFHaQqw3lD
	 3wYsdfjdBgu2mwyIZbOSUTvOBbVV2duFivCLLXG64abcq9KuVwfMQ5E03+W8U2sptR
	 m5q5crdGqQu9xYn0T5TnG28j55mhq6aROjFW6C6r1OdBwe0sMNmxWMjypaPtRPL1dj
	 SvymFSAFCaM5V1EB4a2ELmvdbnUKdxdMvh1v25UTbTROM3EHS7s6BihIlD9wpSklTI
	 Z8h4yrArcVPQA==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D3FFD64755;
	Mon, 22 Sep 2025 11:46:49 +0800 (AWST)
Message-ID: <16281e86d3cf5c97fcb59e73472dc8edca50c484.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: clemente: add MCTP over I2C support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Leo Wang <leo.jt.wang@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
	leo.jt.wang@fii-foxconn.com
Date: Mon, 22 Sep 2025 13:16:48 +0930
In-Reply-To: <20250918-leo-dts-transceiver-v1-1-3e2580325edc@gmail.com>
References: <20250918-leo-dts-transceiver-v1-1-3e2580325edc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Leo,

On Thu, 2025-09-18 at 17:43 +0800, Leo Wang wrote:
> Enable MCTP communication on the Meta Clemente BMC board:
>=20
> - Add an MCTP I2C controller node at address 0x10 on I2C0
> - Mark selected I2C mux channels as MCTP controllers
> - Remove unused "i2c-mux-idle-disconnect" properties

>=20
> This allows MCTP devices to be discovered and used for
> management communication on the Clemente platform.

This description covers details we can see in the patch itself. Can you
please rather describe the motivation and any related considerations,
e.g. answer:

 * What devices will you be managing via MCTP?
 * How do they affect the function of the platform?
    - Alternatively, how does _not_ having the MCTP capability to manage
      them impact the function of the platform?

The general advice provided here might be helpful:

https://docs.kernel.org/process/submitting-patches.html#describe-your-chang=
es

Andrew

