Return-Path: <linux-kernel+bounces-877726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C46D9C1EDDD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 77E1734BCB1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AA2338911;
	Thu, 30 Oct 2025 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMZrFydo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1453370E8;
	Thu, 30 Oct 2025 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761811014; cv=none; b=N7pS0QKwVLEs0fDxUK3ecVD2A4xQnaWDFaDaxn3g5Gr6DqrMXXOoOfXwaPJRNNEzEH38BBjpetX0VpUWwa/fRGCEpvpcI4H0eGlgX3Ud6z95F7Z/Pc/K5hjojgFg7ywFX6Ife5zwdD85aEFXYRjT+CPNpcW6YYSuT4sSTtIr+7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761811014; c=relaxed/simple;
	bh=zjYbPecjjnmHzNsJou3TxkfUOdtr4RaVDpxS/ktQUPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IADbz3Ljf69TuYqJDLqZwBEtACc8XXd4aTPdhQ4B1W8xM9BN8p1xphuv0nUHBAbZSSoKG55wY/W9CgTTla8JmQl6NawMkB7Fc5NWvhCWDbB/RhZWdryGvAfe0lDDkdfkmwIlFEYZWmEo1eICfBX0tpytiF+Aey2qBbAantyVvaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMZrFydo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6C0C4CEF1;
	Thu, 30 Oct 2025 07:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761811012;
	bh=zjYbPecjjnmHzNsJou3TxkfUOdtr4RaVDpxS/ktQUPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HMZrFydoWFCzeeBoZYYyrbQuU/ZwnPFlZo1prFAU+rnGmfne8GEFQlSKmdNGWFfVz
	 d14HZ4JVCXa6fkFvKlJyRYGlYi4+U6NZFh006V8SgokNBubwoGInucX/IwNAoJiMqQ
	 VloIHNpywAwQabJH3ZTHpzjqr+fr+fn0C2kBSpuMFGTKyWShVfV0tV5FhwLFYx/ku6
	 o3rpS9eD9OF11MccEjL54AQIi6WqSl/8v6u0STM2hZhiSQEuEq/+Ye55KNniPa81xf
	 xZDun5ru20PvNS4mZeDMfeYaFaE0U4CkfnuJ4ViXCafy3VzUP8iN1KPPu4CBsfxk2T
	 RFINC1L9RmHsg==
Date: Thu, 30 Oct 2025 08:56:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mahesh Rao <mahesh.rao@altera.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: firmware: Add Agilex5 SVC compatible
 string
Message-ID: <20251030-poetic-ant-of-bloom-0ee7fb@kuoka>
References: <cover.1761648711.git.khairul.anuar.romli@altera.com>
 <71503d442d66054c023ec25ae21838c0939c72b4.1761648711.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71503d442d66054c023ec25ae21838c0939c72b4.1761648711.git.khairul.anuar.romli@altera.com>

On Thu, Oct 30, 2025 at 11:30:07AM +0800, Khairul Anuar Romli wrote:
> Enable support for the Agilex5 SoC in the Stratix10 Service Layer (SVC) by
> adding the new compatible string "intel,agilex5-svc" to the device tree
> bindings.
> 
> This allows distinguishing Agilex5 from earlier SoC generations, as it
> uses a different mechanism for handling reserved memory regions.
> 
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---
> Changes in v2:
> 	- Reprase commit message to exclude iommu

Last time you said there is a iommu, so please post complete bindings.
See also writing-bindings doc.

Best regards,
Krzysztof


