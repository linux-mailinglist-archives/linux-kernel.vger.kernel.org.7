Return-Path: <linux-kernel+bounces-705668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE14AEAC0E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 02:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6CDF189ECF5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 01:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363E02BAF7;
	Fri, 27 Jun 2025 00:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="EVFoYbCp"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F3F171C9;
	Fri, 27 Jun 2025 00:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750985989; cv=none; b=BUIO3hDov7rRwwmZI+8GGeoJds0yelrbspXianAzwIkEd05XoGznanE9/QoF8yFsGd/A7rL1758QSIqdoEAAJkBHdiMvMdJVngXrX38C4k3ynWRLWFZgFix97UbEA+fn2TIcCFNn3gDalP7YFwJNH578L6fhlhsM15mGTDOPrIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750985989; c=relaxed/simple;
	bh=M3I23iRHSkJg0pRHnKfP9dWMJ3YdWtw59t60UAMoKE4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O5adGd5SD+WRWo5ukyU7ztu3U1J8srQ+5GYrogEbbhWwtAZxdnFou8Br29NUuwlktjrWU4NG7QeK262P0x7mFbYO8AkkAc3wzw5q/IePj3Rld7uY398mxU56E1xl0Z8b7ejeBJZhBSsVus3Uwtaq62pBnrFiF0nTjp473LuO0xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=EVFoYbCp; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750985978;
	bh=fbp9P2iizIVjHAFvaoJljb4kc256KKZrn7l4KhzZ0qY=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=EVFoYbCp9fUe9+bqYh1IGMMzlewoor+XFV/4eQA6KKsztO/mqFNQDq8Vm72regOfr
	 uz4gHpPrVQtZjJr6k+folNRmesr5AKosxwNRoY5qntWS/MLwL+JZeFjt57Q2+vyrhi
	 mdnf6Hw7GpZIdCiIosvO9KvWU6UWU2NsisqlUaSVyxrwxAXpKY5dVT2wD4EiUt0+rS
	 rXsemOn5pvFTp4iWWuz/AjSKkwDilBgR7a+n2t/qUx2YFNdct+vAd3dntB1wA2ht4f
	 9KBaQEwd3LN3HabjO/PvH+ewItNIQgXybrXUtzdD0EzZCnoMQqX4PyfB28FNYlcykV
	 645UbApT9U8qw==
Received: from [127.0.1.1] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3CCEB6443C;
	Fri, 27 Jun 2025 08:59:37 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Fred Chen <fredchen.openbmc@gmail.com>
In-Reply-To: <20250625073847.4054971-1-fredchen.openbmc@gmail.com>
References: <20250625073847.4054971-1-fredchen.openbmc@gmail.com>
Subject: Re: [PATCH v2 0/2] Add Meta (Facebook) Santabarbara BMC (AST2600)
Message-Id: <175098597713.150233.11475739280254945170.b4-ty@codeconstruct.com.au>
Date: Fri, 27 Jun 2025 10:29:37 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 25 Jun 2025 15:38:36 +0800, Fred Chen wrote:
> Summary:
> Add linux device tree entry related to Meta (Facebook) Santabarbara
> specific devices connected to BMC (AST2600) SoC.
> 
> Change log
> v1 -> v2:
>   - Enable mac3 node
>   - Add GPIO line-name FM_MUX1_SEL_R
>   - Remove 'pinctrl-names' from gpio0 node
>   - Reorder top-level nodes alphabetically
>   - Reorder device node properties per style
> v1:
>   - Create santabarbara dts file.
> 
> [...]

Thanks, I've applied this to be picked up through the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


