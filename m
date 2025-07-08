Return-Path: <linux-kernel+bounces-722065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 317D6AFD4C7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658AD162596
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829202E5B19;
	Tue,  8 Jul 2025 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGg12qPF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F73BE46;
	Tue,  8 Jul 2025 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994494; cv=none; b=kskhSZ9FbvuZulwm6C+GQFnNnaVWMDHuyLEq72AWMeITT5hGmFohewg++GhCoVzeWtjTI8JypK8AP8zin5MaA+fewWaBFEmIyuQ0q58B1c7CWNpSI2RslCAzxkwvGcczBr7mAB97W/t/C7Qqr2HLMgAmYzKMDJ9nPv8mR4JU0xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994494; c=relaxed/simple;
	bh=kIfjTg5LWXVTDttNhk5OvreN6YGzkggbjxzFHKAfhV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVU6crRmiX4Z/R/m0fv6FqmWvJI8xBRIgeCON+v0tv/MDJOCSQnL7wcfbSIQdkP+Q/p/AoQro4DpZPKTeQb/ZxOnpfvAoZ4SzrBzlUVyVFnClG66dS1kAbp0j6gV/7+uITH/H+vLNEDbFJyoi4TJ3YJywcYdG/+O7DdWcr00SrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGg12qPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F08EC4CEED;
	Tue,  8 Jul 2025 17:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751994493;
	bh=kIfjTg5LWXVTDttNhk5OvreN6YGzkggbjxzFHKAfhV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGg12qPFoH2eBehoY8Xxvnpz2e32pDK9NGOxqyR5bl/B3HQjMnUzk6O86XbysgWTG
	 o9QtE1p3TQuwWwl3o5uYYPlJW6BOu9SebDQ7I7lgVnacdZSAvAbzJRPujeT1vUUgOw
	 zcHkSav5iYAOJbBkGjVmEbsmT82c0z+bd2gODCdpTunXtK+BoZeDn3H+g9G5Hn+eZQ
	 Z/u78fcGj7w1+1aOZ3Me+BEeNNfqtmxrsTumc0a8oE8Bgxc5BzXfD6d8e6a0CchhCp
	 6zyZopWZii8LogBVTNomzZYczQhaCTTve4BY9jVKKIkvQ90vKQuR4kVcH9n350CR+G
	 j3YRIJ49Jt8zA==
Date: Tue, 8 Jul 2025 12:08:12 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	linux-arm-msm@vger.kernel.org,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Stefan Schmidt <stefan.schmidt@linaro.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: Re: [PATCH] dt-bindings: media: qcom,sm8550-iris: Add X1E80100
 compatible
Message-ID: <175199449206.639410.14178643503954926234.robh@kernel.org>
References: <20250704-x1e-iris-v1-1-c3137d979e43@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704-x1e-iris-v1-1-c3137d979e43@linaro.org>


On Fri, 04 Jul 2025 15:38:41 +0200, Stephan Gerhold wrote:
> Iris in X1E80100 is pretty much identical to SM8550. We can use the same
> firmware image and the same definitions in the driver, so just add
> qcom,x1e80100-iris to the existing list with qcom,sm8550-iris as fallback
> compatible.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>  Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


