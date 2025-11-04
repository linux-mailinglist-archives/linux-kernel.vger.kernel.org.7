Return-Path: <linux-kernel+bounces-884325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1612BC2FE77
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A44C1894292
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E68731813F;
	Tue,  4 Nov 2025 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7xPuPhq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E4A311596;
	Tue,  4 Nov 2025 08:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244633; cv=none; b=ncBIsv0JqJ4NtlwNhFVUjrD/LnGSy2/e1B1H5Vkcd6EwQA1Tz5XADPRV/CZPUYx+HLshTEN/348AhIZsOuJNMdAeO+SUsD/Xh2MwIzVMheZ/AAsg9HYn6oVkGF5XCkxClnNo8tevMyZ8ShEhB/R5v+NGUTbpAMDx569wGq+QEUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244633; c=relaxed/simple;
	bh=eKJUNYg3k9kAkrM1K2ms5vRzV9lqnBJj9YdqG9NsI/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IY+CqHXiQckS/6xDyAJA73+MKfRspQYmHjEOUKAofC4HvIiXXQWcUGDMnU/raTbxYZlCR2g5AbNAI2X3PvTbkjXTyXvf4iCSdt3+nmEaqLqJeVZq4wMDvwdKjTFYPRD72vaU2IIeTkXx2VtNo+vAPfhB2ZjlydxEBw/2h/vXhQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7xPuPhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53442C4CEF7;
	Tue,  4 Nov 2025 08:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762244631;
	bh=eKJUNYg3k9kAkrM1K2ms5vRzV9lqnBJj9YdqG9NsI/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7xPuPhqwQgc1yr+DO7h4WkCGNei9+hjF1Durdj40HMkGetEt2MlQf1UwAtmR/OdP
	 0Z0fed1MgnO0sqfaZ08FG5I9RpRfyLFByqVk4NhbwWOzDxC1xGCShg9d/2w67ynwTU
	 fAHfpCUZ7elvCf9gS9g9TdjZyrFSlydFrcMazhxmqu8wmNkLDpeta9BThCMfTJ9n+1
	 AP+FUi8Nwzm2+LjkB6M+oP7HjD78qo4TboLvFaYCxOboDq+g2gCVAgu0l5//MbMm68
	 OGIql1KTzpd5dBQ67isXeSb/vVcfQTdbnCmMNrghRIR51IZeBGrCKwiwsK5knMcSr7
	 XNoAtlHGa9dSw==
Date: Tue, 4 Nov 2025 09:23:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Peter Shen <sjg168@gmail.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	peter.shen@amd.com
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: Add Device Tree for Facebook
 Anacapa BMC
Message-ID: <20251104-fantastic-merciful-giraffe-0cbf87@kuoka>
References: <20251103093320.1392256-1-peter.shen@amd.com>
 <20251103093320.1392256-3-peter.shen@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103093320.1392256-3-peter.shen@amd.com>

On Mon, Nov 03, 2025 at 05:33:20PM +0800, Peter Shen wrote:
> Add the initial device tree source file for the Facebook Anacapa BMC
> platform, based on the Aspeed AST2600 SoC.
> 
> This device tree configures the platform-specific peripherals and
> aliases for OpenBMC usage.
> 
> Signed-off-by: Peter Shen <peter.shen@amd.com>

Broken DCO, see submitting patches and checkpatch.

Best regards,
Krzysztof


