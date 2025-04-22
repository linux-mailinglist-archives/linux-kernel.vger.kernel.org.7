Return-Path: <linux-kernel+bounces-615096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00C0A977D2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 22:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C3447AA86B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 20:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F6424469D;
	Tue, 22 Apr 2025 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmY1PoTc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BC6244694;
	Tue, 22 Apr 2025 20:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745354393; cv=none; b=h8rg4f5h4r5a/6vAFxy5gCW7scKQnLb6WY0m/LP3WK+5XT6BgvgJF06Mr/BgZmscs/7Ka94T6aPgwZyLUGA2pliwr4VGTakWPRGHjQzII/AcmjWJ8bIaVpSITmAPlSMq4a8v1tN4CrV10n12SFvmrtNbIDaATnj90IyM+v4GZmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745354393; c=relaxed/simple;
	bh=JNWsVyc9bX3LnwbxI09z2JXN+ctPg6cmZiRRwn5+gk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzM/tkBAGM0poU/WafZ52d9+1DlrzKy2AP0ywePAPZQ9EBjN0jPU/M4nNMOairaTgrPP/HfgwX51i/7oXjcroWJWSfRkxBHsQpUDzTfyb720whEweYMKcJ65mn59FPbZ2WTzHhKOUcam01cJp8CA6xo9E1WfLxxV0tNU4Zl4pco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmY1PoTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86969C4CEE9;
	Tue, 22 Apr 2025 20:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745354392;
	bh=JNWsVyc9bX3LnwbxI09z2JXN+ctPg6cmZiRRwn5+gk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QmY1PoTcametLJfvbkJ3+5WlPLU8HiPrMvL6wNP01fuY/0QChwIv+lQDLhyDB2JZA
	 xtK0WcwUS+qyPwxg76tG/nmVThUplTgHB80l5mMGvzxCwgX1wMaP+9Ha4ydtwz06cx
	 BpW8aHf45y4KPB9YnjETrc7ng6qnGTLAgaGjL4Qc32BBdOIc5yOYI5trqxIrD+v6Kv
	 q8icziJNKKF+CdddsxGZ75MUElixTbSuMvCGGaFSdyOutzb2leLbGEm2Wu/tMDSeMl
	 7nkYQWQfmMC88DaoIXwyra+6dDPNccJdb+QTTxQuOcFCiX+FKa6syOC0tj9OwHROoO
	 TM0gsMmwad+OQ==
Date: Tue, 22 Apr 2025 13:39:49 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2][next] kunit/overflow: Add tests for
 STACK_FLEX_ARRAY_SIZE() helper
Message-ID: <202504221339.65ED2943C@keescook>
References: <cover.1745342381.git.gustavoars@kernel.org>
 <8cf48c3f9d8ef9b999d87cc0a822ffe539bf7a64.1745342381.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cf48c3f9d8ef9b999d87cc0a822ffe539bf7a64.1745342381.git.gustavoars@kernel.org>

On Tue, Apr 22, 2025 at 11:22:08AM -0600, Gustavo A. R. Silva wrote:
> Add a couple of tests for new STACK_FLEX_ARRAY_SIZE() helper.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  lib/tests/overflow_kunit.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/tests/overflow_kunit.c b/lib/tests/overflow_kunit.c
> index 894691b4411a..3beb497a44be 100644
> --- a/lib/tests/overflow_kunit.c
> +++ b/lib/tests/overflow_kunit.c
> @@ -1210,6 +1210,9 @@ static void DEFINE_FLEX_test(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, __struct_size(empty->array), 0);
>  	KUNIT_EXPECT_EQ(test, __member_size(empty->array), 0);
>  
> +	KUNIT_EXPECT_EQ(test, STACK_FLEX_ARRAY_SIZE(two, array), 2);
> +	KUNIT_EXPECT_EQ(test, STACK_FLEX_ARRAY_SIZE(eight, array), 8);

Nice! Can you add a 0 test for "empty" as well?

> +
>  	/* If __counted_by is not being used, array size will have the on-stack size. */
>  	if (!IS_ENABLED(CONFIG_CC_HAS_COUNTED_BY))
>  		array_size_override = 2 * sizeof(s16);
> -- 
> 2.43.0
> 

-- 
Kees Cook

