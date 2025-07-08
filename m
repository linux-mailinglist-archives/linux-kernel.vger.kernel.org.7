Return-Path: <linux-kernel+bounces-721604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB48AFCB8D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F575802E3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D6122FDFF;
	Tue,  8 Jul 2025 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7o/2fjh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C651E492
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980176; cv=none; b=FekctmXNQq4zFHFiQX8Wd0gUHVhQAHixkz7NHdRiYjVM5+Xglu0xKFM2by8MJRyWnafNS1Tuwpbpkf3EDVMV6FQL/N40OmuhA0QXOPT0b9+QkfeVZZxyVtTj2k2i7pslU3FuCmpv9TtuasMcFgZ7IHS+0NiLMCLAG047kyR3mLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980176; c=relaxed/simple;
	bh=i5ac9SChtjYkBpXeaatwHMA+NmCyW2sXFAgtd2zGcUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnq5TP6W+ewB8loGNoEMt9WfwH53fzbXSXHGku3U1JsWF/+xFElifHP3yCuXoHfXF1B06Vf0GwZhxZfCuvB+ZdIj8KG62gIyw7W4ZqkoHZgyPgLPTJJsViWMCks1k7+FdacLxxampxVRxkGFEXFDkuRJLH3AIgS+JraZvaHNork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7o/2fjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C85FC4CEF0;
	Tue,  8 Jul 2025 13:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751980175;
	bh=i5ac9SChtjYkBpXeaatwHMA+NmCyW2sXFAgtd2zGcUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N7o/2fjhz3surBgptJZ8IyeOiv/khPg3mb5gcPOv1WTbX1EO1DpQljuOxuo3tNtpM
	 RJCMjp1saMRV0LOXlp9LzOFOEtsB8BdIJsEXDHF/8Wxk6ZNaGWhWQUR4EMZD0ritIp
	 mRz7UVDDbOF3JBgrJiGzzdUFVGxv77hYC0ysVbYea3XP2egK71fFrtNmN/+4EHVz9y
	 SQY5KshavR8U+YxM0zQ7qSXjUT/IDROn8ujWrovAlwnRoOpMKuulCuYJsnTefVxEg0
	 4Rzl+uJw9WUd6USITKzkp+x7sszSUiDLIMOqqd/jCP7PmwRgkyr3JtsOnX9xqZ977a
	 HWzZG8Gq88F5g==
Date: Tue, 8 Jul 2025 14:09:31 +0100
From: Will Deacon <will@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/gcs: Don't call gcs_free() when releasing
 task_struct
Message-ID: <aG0YizySqTc475JW@willie-the-truck>
References: <20250625-arm64-gcs-release-task-v1-1-54cbdc2db416@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-arm64-gcs-release-task-v1-1-54cbdc2db416@kernel.org>

On Wed, Jun 25, 2025 at 07:56:34PM +0100, Mark Brown wrote:
> Currently we call gcs_free() when releasing task_struct but this is
> redundant, it attempts to deallocate any kernel managed userspace GCS
> which should no longer be relevant and resets values in the struct we're
> in the process of freeing.
> 
> By the time arch_release_task_struct() is called the mm will have been
> disassociated from the task so the check for a mm in gcs_free() will
> always be false, for threads that are exiting leaving the mm active
> deactivate_mm() will have been called previously and freed any kernel
> managed GCS.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kernel/process.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks, but please can you also update/remove the stale comment in
gcs_free() which refers to exit_thread() for some reason?

Cheers,

Will

