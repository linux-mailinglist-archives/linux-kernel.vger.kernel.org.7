Return-Path: <linux-kernel+bounces-725683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA87B00269
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CAB1646C47
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0C825A354;
	Thu, 10 Jul 2025 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYYeAb3P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690F911CA0;
	Thu, 10 Jul 2025 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151834; cv=none; b=MtMzG7brV2rjLnFyXNw0KQkGbXQbpCqDKq5SeaHfJm3GdOYb6LnEaq57MLm7+ZRgZ6bn1uY3s6JMZ1pW1AzmbbnMgQKwjap/6NGY8imdmEc99SnKh9s82UchnPlJuK/5X385Z3fwdqIpP+EwCZ0IS6iTfo2apfXLTwziRsF3WFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151834; c=relaxed/simple;
	bh=2TDESeBmj8ZJ5qvbzYaQ20isU9G7kUENZ7AieXYlqvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0aMZCaQ2CEsH8Q0Ty+le+uvKOuUHS95mpNRwFByyK3Sd0AowwTBQI+MdQNEeS2g39Y3sbNXVgp1ABJkQvZY/BkYwIiLnjhs9q7pT+X5sVVAYW4dUc8+QVgKYUclXN/smOTQcXFFeVyCq3tDUumwADZIviprg8lG29YQ2RLKgbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYYeAb3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C015BC4CEE3;
	Thu, 10 Jul 2025 12:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752151834;
	bh=2TDESeBmj8ZJ5qvbzYaQ20isU9G7kUENZ7AieXYlqvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WYYeAb3PTI26Tnh4UHHhxbsU7k/3a6bBKiWzRgxsqTtoslOXMJSXkqKQJtGc/bI/X
	 uGwSzV5khuWRa9Apdg+sxJ9h5fxB+YUmlsZJwDnEalu4y5GpHTll5IufVH24Gnb3sZ
	 TII31HM8Oo6ikI7315aUdT+rMgghvl1JWwJQx0pPtFnXXmYKWLT5Lt4+LMc+aGpStJ
	 OuSH6Hc2wdYbJn6trhOsG0Qe09UxyuMs7X7tdxryiDrmoI9hUL0mp2HhJPYh1t+c4k
	 Ex4+xllaLKXcsGrq3UQAygIPX/bwZ1raVfDd4KWCVnSDsdwrVdPZbvHrY73W07kr/S
	 kn9JDWgTlONwA==
Date: Thu, 10 Jul 2025 07:50:32 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: kernel-janitors@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	linux-kernel@vger.kernel.org, Mahesh Rao <mahesh.rao@intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in INTEL STRATIX10
 FIRMWARE DRIVERS
Message-ID: <175215181754.1888615.380537618920336438.robh@kernel.org>
References: <20250512134332.36366-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512134332.36366-1-lukas.bulwahn@redhat.com>


On Mon, 12 May 2025 15:43:32 +0200, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit fbfb64987062 ("dt-bindings: firmware: stratix10: Convert to
> json-schema") renames intel,stratix10-svc.txt to intel,stratix10-svc.yaml
> in Documentation/devicetree/bindings/firmware/ as part of this dt-binding
> conversion, but misses to adjust the file entry in INTEL STRATIX10 FIRMWARE
> DRIVERS.
> 
> Adjust the file entry after the conversion.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


