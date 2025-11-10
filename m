Return-Path: <linux-kernel+bounces-892513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E54C45408
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4593B2D56
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5274B2E9EB9;
	Mon, 10 Nov 2025 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMNpbAEF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A259C218AB0;
	Mon, 10 Nov 2025 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762760923; cv=none; b=V5cindqZvnIdNNHyOoFuqrUnMjv3zZsaFpBaC8UlRXSfGJBIhx5Cuvev1XA7rUg3uJjXr60HxHuOwQPYwcZO5kKHtVemrMQvvzgWBooFs41zKxEoKkCdBybnQjJwsu7NFWUMYpAYQEwDmnnmhHhdN6dR7XqqAKmIWtrdOb9HUFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762760923; c=relaxed/simple;
	bh=BzHOFsDMJBp7C7OzOH9Q8RWPWW0zUaINqu9SN7m2AM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3HIaGCKWj/dHZEFxuuYBGClCRRlY/iTgHnsnFQS3zhtXmCVU4CmtVZ0eerVj+PEKlwHivRCshEuBrqPJZJyaItcqzQRFf0/2oVVqf7fU2oRlilspczPOGAh194qQSovi7RLVUCTqn4ZjFz3eDYkUEa9QCkIaCetGQMLriybiwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMNpbAEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AD8C16AAE;
	Mon, 10 Nov 2025 07:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762760923;
	bh=BzHOFsDMJBp7C7OzOH9Q8RWPWW0zUaINqu9SN7m2AM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DMNpbAEFVtH95qn/QNEiLu+vQT8sV6AtRlKVul3A8HIJxdYaGgxlGjVCiHKfm55xn
	 jP/5Y5R6V1huY5ynsqGtb5F/pWUKlH6HqGly5WdrHh8w/JQjWPnTVpPBX27CX1WT6k
	 PbGZUIPuKu1GgrdVvBm8tplLkc/nsGqXa7GMSah2+cGr9KeyaRq8gbOEGwqTv+p4AN
	 o/bWNHwcgPshE5fuBCd67u6B9391aVzMQGlGdGg+XaUd+SOC7CkVFhR7mEuQlwgjDc
	 mho5a2lM9DxVEnZnUZnW+Jz3kTzwCDxNnLn3Kk5T6kxx13yNvKXVusqF3WQyTYPX5x
	 BCl9QxhVqdXjQ==
Date: Mon, 10 Nov 2025 08:48:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: display/msm: gpu: Document A612 GPU
Message-ID: <20251110-wise-lurking-roadrunner-f0cec3@kuoka>
References: <20251107-qcs615-spin-2-v2-0-a2d7c4fbf6e6@oss.qualcomm.com>
 <20251107-qcs615-spin-2-v2-2-a2d7c4fbf6e6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251107-qcs615-spin-2-v2-2-a2d7c4fbf6e6@oss.qualcomm.com>

On Fri, Nov 07, 2025 at 02:20:07AM +0530, Akhil P Oommen wrote:
> A612 GPU has a new IP called RGMU (Reduced Graphics Management Unit)
> which replaces GMU. But it doesn't do clock or voltage scaling. So we
> need the gpu core clock in the GPU node along with the power domain to
> do clock and voltage scaling from the kernel. Update the bindings to
> describe this GPU.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/display/msm/gpu.yaml       | 32 ++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
> index 826aafdcc20b..a6bbc88e6a24 100644
> --- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
> @@ -45,11 +45,11 @@ properties:
>            - const: amd,imageon
>  
>    clocks:
> -    minItems: 2
> +    minItems: 1
>      maxItems: 7
>  
>    clock-names:
> -    minItems: 2
> +    minItems: 1
>      maxItems: 7
>  
>    reg:
> @@ -387,6 +387,34 @@ allOf:
>        required:
>          - clocks
>          - clock-names
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,adreno-612.0
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: GPU Core clock
> +
> +        clock-names:
> +          items:
> +            - const: core
> +
> +        reg:
> +          items:
> +            - description: GPU Reg memory
> +
> +        reg-names:
> +          items:
> +            - const: kgsl_3d0_reg_memory

What happened with the second entry? Please describe the hardware
COMPLETELY (see writing bindings doc).

Best regards,
Krzysztof


