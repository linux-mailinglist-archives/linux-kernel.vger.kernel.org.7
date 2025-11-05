Return-Path: <linux-kernel+bounces-885987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B1AC3473C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1A846580B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEE128000F;
	Wed,  5 Nov 2025 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViFuhQpt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20838285CB6;
	Wed,  5 Nov 2025 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331026; cv=none; b=lTuziI8hZw3LSytuZtIRfDrvj+/Y5bd06dFifBT/+Sj4DgNlZfRdJdZMmZ85AXUzCdMJbfgMKeVey7AqwNGOt72OiG+JjiQQ9J5bIu4Hit6og8Xx/12tu0+FRiCmkU3cX2S+m0L0uogVQMyCjNt4fJuZr31cDRQh3fwc4vzvsIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331026; c=relaxed/simple;
	bh=AioJosxb7dysACHaZG7jwTiGBv1pHFdPHY/yN7O7kJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4imjHypoSJaHrPoa2L4MdtvG0hNx3KbpycSOvJA3Fes8unv8oaTn2Dts11YTbQf06+uQ/xOGOETawDwNMgIrSZxec6vckbEzfeJKIOB8WMojoUlohCgq9x2Ucg5yNnsd8NvkSMx7YI3dX1o3msaZUfDtw9YyQXdD14jFxYbEZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViFuhQpt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B96C4CEF8;
	Wed,  5 Nov 2025 08:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762331025;
	bh=AioJosxb7dysACHaZG7jwTiGBv1pHFdPHY/yN7O7kJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ViFuhQptEv7t1nzZ9G+JuK8aO5/fB8qb0/NT9Vfm7uGPGIVjqc2D01uZ0hjmXwuX2
	 ObUS/h3cgQ2oLlOjIenLeIDhARuKzimkHUAH2yOxNJfCHjnXI+BIJy4aQpRfpVfzRF
	 LMpf+9+xW7sGVXoGGyi+AINAKwlVuc0FmFszaqJtZsT8gFJs6yhMGnEF209laFDJ6a
	 F2vs4XQeulK5Nq96Fb2Yvs1Tjj4+06yotc5xQZzstwIj+Sk8z9s2MwrcdnQhTm7sKV
	 oXWRzg6/Frhv5c1ehvWz4EonxlMamfYg6zYiofHUIE/TaJ1URnMmjlaJhFjtZ5Tyx9
	 +xc5tWGJvnf3g==
Date: Wed, 5 Nov 2025 09:23:43 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mahesh Rao <mahesh.rao@altera.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>, Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: firmware: svc: Add IOMMU support for
 Agilex5
Message-ID: <20251105-giga-ostrich-of-prosperity-410d1c@kuoka>
References: <cover.1762308672.git.khairul.anuar.romli@altera.com>
 <97c7c260544f2e2f1615e494408a608d6c731eea.1762308672.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97c7c260544f2e2f1615e494408a608d6c731eea.1762308672.git.khairul.anuar.romli@altera.com>

On Wed, Nov 05, 2025 at 10:28:01AM +0800, Khairul Anuar Romli wrote:
> In Agilex5, the TBU (Translation Buffer Unit) can now operate in non-secure
> mode, enabling Linux to utilize it through the IOMMU framework. This allows
> improved memory management capabilities in non-secure environments. With
> Agilex5 lifting this restriction, we are now extending the device tree
> bindings to support IOMMU for the Agilex5 SVC.
> 
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---
> Changes in v5:
> 	- Use contains enum instead of const
> Changes in v4:
> 	- Fix syntax / style error.
> 	- Refactor code not to use AllOf but instead use if directly.

Why? I would expect there allOf, so you won't re-indent when next
if:then: clause comes.

Anyway, slow down with your patches - one posting per 24h. That's like
three versions within that timeframe...


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


