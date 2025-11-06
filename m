Return-Path: <linux-kernel+bounces-887955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F505C39705
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2A518C873A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1183B2D2481;
	Thu,  6 Nov 2025 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OR8ol9vU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B43274B48;
	Thu,  6 Nov 2025 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415174; cv=none; b=aOxF7w3LLYLchj6g6IxFKftsjjq0uuDOJCLbdle7jIX2MKso8O1H9BUzA45LdGBpbLDeywUO8muY6ZYHhTHc8S39k+hCF0MqR3rBC8UTEcqWJ3TeSYEIifKLesMuPcb1O8gHPBEnaUw+iwOSyCPozfsPxguMS9jgl0gsctmZB34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415174; c=relaxed/simple;
	bh=kylDKJIWWFfGSICGqrRM6ABFAF80sl+uAZFps0sdagM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTxrAKx0K5dQu84s864lO80fignFkgagZwKnq3gWCFh3AzmZsokeehSIiVEorbK1RHweNouXO6Ph+OIgd9q1ZB35TrAN8uBB5/DIUZuJacS2g52i0lLLki7hfKqTzT0Xrv/eQdLgljRddLwHgNZhA5cVkpg1PTNC9DeHO0Io85I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OR8ol9vU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5137DC16AAE;
	Thu,  6 Nov 2025 07:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762415173;
	bh=kylDKJIWWFfGSICGqrRM6ABFAF80sl+uAZFps0sdagM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OR8ol9vUBUiKhWxL9SJwixh2/h4SpEBLMh3eOgzmSPLZpD+L+g8Z2Vnd+9S9kFWsp
	 APAm4N6Tx6DTuXbGr7BjAgAifzfsLksFAvRDknjgUVPQxBi9s0ENHnX9uarefd5vVt
	 cOefnw0Nun0T1BmaKB45WqlHomPNAQKoD98XJGxmuRJMU3lpOwpMwsD9wsiIQPh0Gz
	 pY6f3s/Yv2vwFNYq3cg0i8cEwntCQhaj1GOxKfj51JOF2+EmQf6D1YTkqNDK10VGqG
	 k+7aNQPmkW/8ZXirLAGut6LKycQhXHLbyJuzMwD0wE36qO4z4OLLZMBnuWVLsXAP+G
	 fkBxv9k0IB9Tw==
Date: Thu, 6 Nov 2025 08:46:11 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Igor Reznichenko <igor@reznichenko.net>
Cc: linux@roeck-us.net, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, corbet@lwn.net, david.hunter.linux@gmail.com, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v4 1/2] dt-bindings: hwmon: ST TSC1641 power monitor
Message-ID: <20251106-carrot-agama-of-karma-1bc895@kuoka>
References: <20251105201406.1210856-1-igor@reznichenko.net>
 <20251105201406.1210856-2-igor@reznichenko.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105201406.1210856-2-igor@reznichenko.net>

On Wed, Nov 05, 2025 at 12:14:05PM -0800, Igor Reznichenko wrote:
> Add binding for the TSC1641 I2C power monitor.
> 
> Signed-off-by: Igor Reznichenko <igor@reznichenko.net>
> ---
>  .../devicetree/bindings/hwmon/st,tsc1641.yaml | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


