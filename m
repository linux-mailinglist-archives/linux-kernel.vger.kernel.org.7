Return-Path: <linux-kernel+bounces-795280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEAAB3EF4D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1539F3AB426
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1075E269CE1;
	Mon,  1 Sep 2025 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uon/TbGi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683062AE8E;
	Mon,  1 Sep 2025 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756757717; cv=none; b=TRI0STQyXUw5DAn8f1FCz0s5qpQyAOBZnZMUzjnGRnW8lxjcE6viUZbwx6D1ITn8Yi+b4sYUy7NI1hcXgZEIT+mIqlQQrf7wQZ5WPQ/ezWG1jck4HxoxetG54UrsZdUP01tjeuaIBPLByUUPaYJVCrcxLDnesVXQZilUA8gI/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756757717; c=relaxed/simple;
	bh=BpISnuXRoHphs/Si22tmOlulH/h93vcmCraxoKcBxDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opkwxRP5ix9zWue766n3kiua+6AfUgIT0AXxN0fhANEUtivq0eU0h3ucubHxmb55vNGNoVZ3ULG9umX1PtjfukSqravvDwfhzn9lOb7YFNpJ3uFSFNBUJqgEony8Jvm0holEzvxHMxEZGgWCfhdx9vHWx4r3eOn0ZN9GJ6o7qtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uon/TbGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51ACC4CEF0;
	Mon,  1 Sep 2025 20:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756757716;
	bh=BpISnuXRoHphs/Si22tmOlulH/h93vcmCraxoKcBxDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uon/TbGiR6w+jJNwSY43krnqps/BBLfncX3UJkyev1ebLt/j/xOmrTM4HR90oq/+t
	 9WthS+gpKVYgzO892d9eoUUaxQDWVprZmHNi/KEQM/6Jt7sa3a91Xp1t9j0BeYotv2
	 qu22qxxAs3AFhfH5Wt927x1BabhH3Y3A7Vxf/uieSibMSQsGSAPp8uFi8W+9XpTc+s
	 qW7nJeuwEFtmu0N66pazO+jh3Ftti901FOd9IWoIfw4984LBzTFVkSDnG6HJvvv244
	 NEH7GzvCpvjo0mRVNm+SLZfeHo6uCrVrYhsNWkIdyrXzw1Wr35Ed9tUuuXDF8aX2qu
	 KhP8y8OsQ/hlg==
Date: Mon, 1 Sep 2025 15:15:16 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: samsung: Drop S3C2410
Message-ID: <175675771483.268527.16420389338163835596.robh@kernel.org>
References: <20250830113238.131006-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830113238.131006-2-krzysztof.kozlowski@linaro.org>


On Sat, 30 Aug 2025 13:32:39 +0200, Krzysztof Kozlowski wrote:
> Samsung S3C24xx family of SoCs was removed from Linux kernel in the
> commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support"), in January
> 2023.  There are no in-kernel users of remaining S3C24xx compatibles.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/display/samsung/samsung,fimd.yaml        | 1 -
>  1 file changed, 1 deletion(-)
> 

Applied, thanks!


