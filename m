Return-Path: <linux-kernel+bounces-835706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C10BA7DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB66217A5A4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 03:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89307208961;
	Mon, 29 Sep 2025 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Kmlp1YXX"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A31F34CDD;
	Mon, 29 Sep 2025 03:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759115252; cv=none; b=Isv9T928Fk4v5oM2key3TDxWG7L+nVbF96pxA2mZJGBlyzsVIF01dwsTOFfaf/5JdSoARj4yxQuwJMI14ZpksrjFsiOLGqKl8r20vcKJPybhL97YYVm90umrPF3ia2HLBk1PWp2UlzKhjUryOTMJgifs/j+3aHsISTsHFbZtNZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759115252; c=relaxed/simple;
	bh=LF1I+ivTLvq2SbfFQgbMVU+AZFjetGAlqpCycb84/7k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Sc4uLPJ8A+IEQXrZJxeuY3J21eJ6jCAqfhQ3YrekrO9pJ25XXLlWQd+SmGgdA1IqulEywass6gaztXjsCga2nmC/knZk9oNTLNvbv2xl8HOggkxk+6xQVRyLAoeB+f3AryCQ74AxBNa8V0l9DFcsxTIwfWpdfBNkG9uEU4NXIAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Kmlp1YXX; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1759115248;
	bh=koAfHQgZNFwz/G/RE/7xAxl1N8KZz53PEKfz4qKLMuY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Kmlp1YXXAOz/7ZGIW9e0lQD8xPI5hP+N/TxvRozjHOWeSUmUdTz1SFujfPG4e12q5
	 pxh9Krxelay0STWxI5Xn88h4nZHknyAI8gfvWeUl7Qbs9JSrKTLHPcWm6aDnqel7mA
	 aiEA7ln5lGE3IWDvBdK1K+NNiWoebrRmLK36jebtxEd9Tick2WcVIJxGdpS7dN34V+
	 mHL9MClCiqRN7rTxu6c/OmJo2JeSL8OBF0mx9NRXhUa17BrUtUnfkULtKWAXwygyfq
	 gCrcBGBCahkJXCl/Yq3C0pUHQFm1NU+4/DfG+EgX9DcmwXXzwlypcMFM+PN2UVjSzd
	 VJyqbGWPHVSdA==
Received: from [127.0.1.1] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 88D5164782;
	Mon, 29 Sep 2025 11:07:27 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 joel@jms.id.au, Daniel Hsu <d486250@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Daniel Hsu <Daniel-Hsu@quantatw.com>
In-Reply-To: <20250926025952.3098933-1-Daniel-Hsu@quantatw.com>
References: <20250926025952.3098933-1-Daniel-Hsu@quantatw.com>
Subject: Re: [PATCH v1] ARM: dts: aspeed: harma: Add MCTP I2C controller
 node
Message-Id: <175911524746.2942521.16055072946484139660.b4-ty@codeconstruct.com.au>
Date: Mon, 29 Sep 2025 12:37:27 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 26 Sep 2025 10:59:52 +0800, Daniel Hsu wrote:
> The Facebook Harma BMC uses I2C1 as an MCTP (Management Component
> Transport Protocol) bus. This patch enables the controller by
> adding the `mctp-i2c-controller` node under I2C1, with multi-master
> support.
> 
> 

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


