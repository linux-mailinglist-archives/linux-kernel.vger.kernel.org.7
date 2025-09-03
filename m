Return-Path: <linux-kernel+bounces-798733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39BFB42237
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B523BBC84
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B994630ACEA;
	Wed,  3 Sep 2025 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gz0blh36"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1473330100A;
	Wed,  3 Sep 2025 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906990; cv=none; b=SjKB/Fu9XdbUkpvk03/G8kX+t8lOYME5BZKdupOVAsZhOf5uuZuCyClVIChfnFLW34uPrpftu+GvkJx6NpRR1hw708LBg8gKM3CYxXzhJdIXLgKSYHyeeRvLASBKLx0ck3uIdsNj2ePOZVUOotyfkcDcQw76RQtSY/T04Cmk4Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906990; c=relaxed/simple;
	bh=Zl9aF/Ct2qFA/NKyj7N5rpmCvHrFRs/6EB8eMqIA9FY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J2VLRj2A12ofA0A8uSSOudJ6pHXTHcJ54BenzOxRM8EDZFEwVDPTkXHygO1GeTpZqbkcq9GtP+UZ3VOzyTUZpQqNLNRuwN7unLTPdlBm4VlTaoIEQXQLbdTWg2ZxH6Riv9zGHHy9yKYASKE9UGR8EzBqyMqgQxNtB7fX1wc1bis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gz0blh36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401A6C4CEF0;
	Wed,  3 Sep 2025 13:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756906989;
	bh=Zl9aF/Ct2qFA/NKyj7N5rpmCvHrFRs/6EB8eMqIA9FY=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=gz0blh36ZMSMFPILOKEeHvdP7VeW3k+uMhZOHm7AhBpagE0Nt08Toc95cra9nfUHU
	 AVE1Noi8sLJ1Gag8cU/CmdaVasCrlYbznUrr3MWdzhU8wVv3KIB44auILOZFvQ4wwt
	 szauOF9O8bghfWKSdj6onuwWfvdpubZerXrVYu+poh4Yokgu9VKWI1uvModx4K89u5
	 2aV8UguhOhWo1kRkqiTRI0PFIy9FFnAmMvM4mx910ea89SF6clvGWwMo1rerw4keD7
	 /pUQo8Fa+PN6Hm526K7NL4Hnh4w6uGx2UY8GAtWWvQmtjayxhfqCeInWKdvB5AX8Dx
	 tnkaLMBj4zWtg==
From: Lee Jones <lee@kernel.org>
To: Eddie James <eajames@linux.ibm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ryan Chen <ryan_chen@aspeedtech.com>
In-Reply-To: <20250831021438.976893-3-ryan_chen@aspeedtech.com>
References: <20250831021438.976893-3-ryan_chen@aspeedtech.com>
Subject: Re: (subset) [PATCH v2 2/4] dt-bindings: mfd: aspeed: Add AST2700
 SCU compatibles
Message-Id: <175690698699.2776130.17067429199023206102.b4-ty@kernel.org>
Date: Wed, 03 Sep 2025 14:43:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Sun, 31 Aug 2025 10:14:36 +0800, Ryan Chen wrote:
> Add SCU interrupt controller compatible strings for the AST2700 SoC:
> scu-ic0 to 3. This extends the MFD binding to support AST2700-based
> platforms.
> 
> 

Applied, thanks!

[2/4] dt-bindings: mfd: aspeed: Add AST2700 SCU compatibles
      commit: ef7d90dccee683bae63d6637cdb6c04fa1d7a8a8

--
Lee Jones [李琼斯]


