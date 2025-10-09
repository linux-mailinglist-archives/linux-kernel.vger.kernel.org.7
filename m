Return-Path: <linux-kernel+bounces-846797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B45BC9105
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB5A3E2B38
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EDD2E62C6;
	Thu,  9 Oct 2025 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpVNI5GP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEB62E3373;
	Thu,  9 Oct 2025 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013459; cv=none; b=KwbKG+vFQVrGFfKxRpZkFevIcejxCykLqueobbGPn8PZWYJUHQscHR/I6L7bq2c73KlHm4mK0AJOTnPvwU1Av8fykbhMxbXS4XomPjrZha8bhVDOyYNHTKkqriNL2QCk5mnHstEv36Pns9LqdQcOEyugplx6+9xbb3Pc1YAypyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013459; c=relaxed/simple;
	bh=azd9FVCjk0aIj4ni+YQWAJAY9F/HKDjvW0AfWT0OlKo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=fONEjVtLiMuUu241sdF3pWQ17wyYYx8Y/jx/TYMWFQSB3XLycLonqvwdvYKufH4tdmVTGSrUaDRHjRCuhsmCFCh1UHW21OuZQKQcS23F2gbSHg94qBJnbL8LfiqZAPu1orTQdUXQ3QJRloQfPwisRe5q2EDBJH9taHrU8yqEV7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpVNI5GP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1255CC4CEF5;
	Thu,  9 Oct 2025 12:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760013458;
	bh=azd9FVCjk0aIj4ni+YQWAJAY9F/HKDjvW0AfWT0OlKo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=lpVNI5GPx3+9zLTr6fIc28Kr+bKLW7kKmT4TlSKdjdwNxM9DoPkWtk3j3BZaDgklH
	 YuNjCvc4VqSq1v7swX3OuldWGdI3Z41FcJkecOo4F8DzPxKtn7jEDfLKkdzvkE/dpt
	 +Qe9nPnM/1mfGXsVpxp02XOtenfCd/kFeiAHLM3E8txzqil3zs/jMdng85Yu8I0kmZ
	 JQZeYZuoKYR4EAogYd16fbuqFnMYr9hnFI9UTk7K7j+w3BdCfLPVm6YiRGPglFU6QK
	 36uc9cA6hmhJ5a9utKKm0LYMhgS/tDprx3Xfadx5tktACf7FGGgrCR2HHaaBR8E54q
	 cIkI4jy9nU+Gw==
Date: Thu, 09 Oct 2025 07:37:36 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Rob Herring <robh+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Alexandre Ghiti <alex@ghiti.fr>, Emil Renner Berthing <kernel@esmil.dk>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-riscv@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20251009015839.3460231-16-samuel.holland@sifive.com>
References: <20251009015839.3460231-1-samuel.holland@sifive.com>
 <20251009015839.3460231-16-samuel.holland@sifive.com>
Message-Id: <176001310599.1845440.13113067302880070823.robh@kernel.org>
Subject: Re: [PATCH v2 15/18] dt-bindings: riscv: Describe physical memory
 regions


On Wed, 08 Oct 2025 18:57:51 -0700, Samuel Holland wrote:
> Information about physical memory regions is needed by both the kernel
> and M-mode firmware. For example, the kernel needs to know about
> noncacheable aliases of cacheable memory in order to allocate coherent
> memory pages for DMA. M-mode firmware needs to know about those aliases
> so it can protect itself from lower-privileged software.
> 
> The RISC-V Privileged Architecture delegates the description of Physical
> Memory Attributes (PMAs) to the platform. On DT-based platforms, it
> makes sense to put this information in the devicetree.
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
> Changes in v2:
>  - Remove references to Physical Address Width (no longer part of Smmpt)
>  - Remove special first entry from the list of physical memory regions
>  - Fix compatible string in example
> 
>  .../bindings/riscv/physical-memory.yaml       | 91 +++++++++++++++++++
>  include/dt-bindings/riscv/physical-memory.h   | 44 +++++++++
>  2 files changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/physical-memory.yaml
>  create mode 100644 include/dt-bindings/riscv/physical-memory.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/physical-memory.example.dtb: / (beagle,beaglev-starlight-jh7100-r0): 'model' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251009015839.3460231-16-samuel.holland@sifive.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


