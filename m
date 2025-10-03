Return-Path: <linux-kernel+bounces-840929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C1FBB5C01
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 03:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 352A74E6A74
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 01:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B86283FEA;
	Fri,  3 Oct 2025 01:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGRXJSha"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F444283683;
	Fri,  3 Oct 2025 01:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759455369; cv=none; b=fc5Lm7CbAcENpC6nDZmphyqy17YTxQm2bYQ9qcV9KJ/he3hn9duCPXFS9iWhC0BiCWmlpQYsM6PV5MmDH8/cW73vvZxIRu+qupQe17zOMakzZKcKGwYSb2Gzp/O2oOOsRkC9lkx4XJSbiDFrS/kuGbg0MG8xSWSEUdsQhyTtG0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759455369; c=relaxed/simple;
	bh=o5ZrKPm3f5fdOQjrylL+m8t+7kJdXF7YP5CE6XUjsFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EU6OoP1WvueIjDthTWFuDS9F2KYt9Ew2xBVONDglbmPMJQDd+CAEHNNirzDhjvEirPswvkx9z9MEbOxCF8TLvcAJ3jerguiI69BKDjUqitENQ9Ydd6BihHPVSZ1KYdSnV2wv4HXSU2Sjs/4wzTKTKR7oqURwFkHDpRfj1Yd5FZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGRXJSha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE729C4CEF4;
	Fri,  3 Oct 2025 01:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759455368;
	bh=o5ZrKPm3f5fdOQjrylL+m8t+7kJdXF7YP5CE6XUjsFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGRXJShaP0zq8waSMcFmiO3ORn6oOMujk+o/qjQp92L5fJmWvMWLNy+ek76OZS7c7
	 Qf5fdzp4GQ37gnQGEfYwDo4zzy0DksHlcXdLDNg/aVFBg/S7BSOAfFHbboy5GF/xTq
	 tuhjy58Dtkdu7NzmD9vtWzu/u9YVlbx7pIXyNLPjbI4lqAUmyXqweuIs/AxGPQNmK5
	 9600+3yeC47cuCbdQXmFcwzkc+fHDPJ21vqK0zl+VLfmg1Q3EPi1zHHzfyGDKdpR7E
	 xIp639JLUiMxIRWcuAPnLEjRLJkJ4CbagXJJxekQOZCOKdg49QVv4uypxztOuvICfg
	 GqFFuKxLlXxeA==
Date: Thu, 2 Oct 2025 18:36:06 -0700
From: Drew Fustini <fustini@kernel.org>
To: Han Gao <rabenda.cn@gmail.com>
Cc: devicetree@vger.kernel.org, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] riscv: dts: thead: add zfh for th1520
Message-ID: <aN8ohrxMOCvFlBTk@x1>
References: <cover.1758228055.git.rabenda.cn@gmail.com>
 <38abc793c2fcb9dd26c89bab10dd4450d91ced4c.1758228055.git.rabenda.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38abc793c2fcb9dd26c89bab10dd4450d91ced4c.1758228055.git.rabenda.cn@gmail.com>

On Fri, Sep 19, 2025 at 04:44:49AM +0800, Han Gao wrote:
> th1520 support Zfh ISA extension.
> It supports the same RISC-V extensions as SG2042.
> 
> commit cb074bed1186 ("riscv: dts: sophgo: add zfh for sg2042")
> 
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>

Reviewed-by: Drew Fustini <fustini@kernel.org>

