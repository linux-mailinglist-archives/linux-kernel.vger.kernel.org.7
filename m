Return-Path: <linux-kernel+bounces-814739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA2BB557FD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38AE67A7CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB71A305940;
	Fri, 12 Sep 2025 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GgYY+K7+"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1AF242D9E;
	Fri, 12 Sep 2025 20:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757710719; cv=none; b=rs+zxA/nNqQJwoPa2CCWw+Hb9tUven3fQZ10ZFmjzxGOizqWF0a9q//RlNYSOrvd4nZ02g1IcgExHHf6EiVR2QwMalogi+BCOP0BQGq+aMSDB/MJKUEhFq2maiw5/pozWYeAw6FXJ9UsGn+oX15FCJZ1zWHHCJ8pJtHE85rTMmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757710719; c=relaxed/simple;
	bh=hkPf4NG18cr+svLukm92kqXa86JRyXzWrX2yDcyUf2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiJG+Gh0KgHqtEIYUU79wo70Zmw0nAyshej81Ku6aA6g7GYoEsaTL7P9q03nQ5QuXYWlyg34YLPN32LHEO7fCXlbzbjq7iJT9AFsIwwfxBexVrkdSeVn0sRu4z4TeUnfP17fzryDA3Gt20KjeBMysygjS+euVMhBzfFMAs+t4KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GgYY+K7+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=LJHK7dsTB/ThO7Z2EP/SeNUzVk4mffiuK9Sa9a/39e4=; b=GgYY+K7+wiV+MpG4kO15w5qH+k
	2WDSXuAg5k3G6ic4OnsA5tqxqUWWIkTVHHvl/OF3XUy4DakgAE6fiiA985ifFXW6TT5faR1uLIXG8
	B6ciUprU+MM+N892Ut5ku3Ln9p15qVGYJX54q5e1j2xxS0sOVSnCx0q5FyYxZFu0RIvJlbPzW4oKL
	SGU6xNfcRf8rc9vwKjxOUOEgPgVyfma6HNa9LbmE3Dom08imHl4z3AD8eeQr4BnijnnkZZXToFOBH
	2EgfzN80emdvF98CXoiOicwkmvywStj1NrGJRChqiwg88Fgz9WtqGjF0SYkPl2H70sRRkmCr7NGrG
	OFTEQkgw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxAqp-0000000BXIW-2wyb;
	Fri, 12 Sep 2025 20:58:35 +0000
Message-ID: <de409ffc-100a-4120-b6b1-f89c59a97530@infradead.org>
Date: Fri, 12 Sep 2025 13:58:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm: Add directive to format code in comment"
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Javier Garcia <rampxxxx@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250912130649.27623-2-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250912130649.27623-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/12/25 6:06 AM, Bagas Sanjaya wrote:
> Commit 6cc44e9618f03f ("drm: Add directive to format code in comment")
> fixes original Sphinx indentation warning as introduced in
> 471920ce25d50b ("drm/gpuvm: Add locking helpers"), by means of using
> code-block:: directive. It semantically conflicts with earlier
> bb324f85f72284 ("drm/gpuvm: Wrap drm_gpuvm_sm_map_exec_lock() expected
> usage in literal code block") that did the same using double colon
> syntax instead. These duplicated literal code block directives causes
> the original warnings not being fixed.
> 
> Revert 6cc44e9618f03f to keep things rolling without these warnings.
> 
> Fixes: 6cc44e9618f0 ("drm: Add directive to format code in comment")
> Fixes: 471920ce25d5 ("drm/gpuvm: Add locking helpers")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks!

> ---
>  drivers/gpu/drm/drm_gpuvm.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
> index db9b089ef62c85..86853535fb7bd7 100644
> --- a/drivers/gpu/drm/drm_gpuvm.c
> +++ b/drivers/gpu/drm/drm_gpuvm.c
> @@ -2432,8 +2432,6 @@ static const struct drm_gpuvm_ops lock_ops = {
>   *
>   * The expected usage is::
>   *
> - * .. code-block:: c
> - *
>   *    vm_bind {
>   *        struct drm_exec exec;
>   *
> 
> base-commit: 9a3f210737e958c3f45a4ce0d7f1ff330af3965f

-- 
~Randy

