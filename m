Return-Path: <linux-kernel+bounces-857377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88470BE6A28
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35986344A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EA530FF21;
	Fri, 17 Oct 2025 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="GrJehQx+"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F30E245028;
	Fri, 17 Oct 2025 06:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682004; cv=none; b=QRVhiXJwYcwk0zy+VPHUpI8sir7kYeEDVUJtfmUwsCFVyv30BzvLavpm3SR0/gcLMHmElV/zTNloCDXBrcFkLlV2aZ6DJIo8Zcu+F9tan7jZeHNyWAJj/dhyfH1LYGAFn0lmvEjBtJzfb1tE0KC2MMpad6lihKh1XuGN3lKs+SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682004; c=relaxed/simple;
	bh=w8QQNXribYX5HcY6iJuQ08ixXWz62G6VTbiT55NFYU8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g+KwshD8008vBB6JeoKxWB1Cs3QKK+jB4QYSGsM/bFsMZmtWVxOD1Dye4FrOQsZSxKZ2s0cCPts2kIQRZH0AciZMxmkWpdZKOsePfQ5YKpklwfiqneydO7G2jE7oXKPkLUAY7SdoQnEZ/UJ2D/pYu1gAXIHdXw5GBt1Ou0gb6bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=GrJehQx+; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1760682000;
	bh=LuLa4eedzbUwTpnlaZPmlkTyolIBXjzmkHFoMfgfTB4=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=GrJehQx+sir5LqSm5whp4UV/1rcumxx6hSvrVCa2Fp8sbksHf12BtcyNy+RUFWzxj
	 yNMZ+60tOqqyITTdKfE8bCVdac927tJyq4PwkPjScJxb8d9eEjgKATv9vR9XdRw2zS
	 jRFAqy+gF/k0j3WxY4sSgIM+01MQz9yHeCH1aH1TOUl1bmmnM4s8YCwzXOrk/lGA1T
	 pSvsjeKNKtleawZWuq/0ASt3gbcs7JUA/pQhRpUqr4nzAkYiyaU8kVFIxAmoq0OX0R
	 WDo6zNhPN5+mli9NeEkORugtSF6d3zaX+qEzhExf/aHJAcJNak0n/dQTimSQQ8zFCh
	 yvAs4Q1Ycl84g==
Received: from [127.0.1.1] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 12B3A6477A;
	Fri, 17 Oct 2025 14:19:59 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Fred Chen <fredchen.openbmc@gmail.com>
In-Reply-To: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
References: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
Subject: Re: [PATCH v4 0/7] Revise Meta Santabarbara devicetree
Message-Id: <176068199902.287212.1469611481983268246.b4-ty@codeconstruct.com.au>
Date: Fri, 17 Oct 2025 16:49:59 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cfd50

On Wed, 15 Oct 2025 22:38:56 +0800, Fred Chen wrote:
> Summary:
> Revise linux device tree entry related to Meta (Facebook) Santabarbara.
> 
> Change log
> v3 -> v4:
>   - add blank lines between nodes for readability
>   - drop changes to already defined LEDs
>   - add gpio name debug-card-mux and FM_MAIN_PWREN_RMC_EN_ISO_R
>   - enable amd apml interface
>   - add eeprom for prot module
> v2 -> v3:
>   - remove mctp node label
> v1 -> v2:
>   - add 'bmc_ready_noled' LED and update commit message
>   - add sgpio line name for leak detection
> v1:
>   - add sensor nodes for extension board
>   - add mctp node for NIC
>   - adjust LED configuration
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


