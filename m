Return-Path: <linux-kernel+bounces-850485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAFABD2F35
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166B5189C7D4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580DD26FD84;
	Mon, 13 Oct 2025 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck/fTjQA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B368826F2AD
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358115; cv=none; b=Vg8MsNd9mhSLui9ZAuXyMfGTshcEF1MoMO1iOXMrIKBUuXSKGVseOfyPJu/OSCtwJeijJGQEYafM72DQd4JjqpSdmtZyNeSPUrUGJbd0gOmbwU3/ht5GSqfgWp4Dj5+tvmCQYwAqvQpubb0JptB/SKgGah8ruyNsqLjgKaUP0tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358115; c=relaxed/simple;
	bh=8ayZzsM7Tg8a4hHEL+CcWLmAF179tgFq9958rKBp3So=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QR3ww0hW/71eAp1Vli0gq2QZEYcsykAmIHiqYSsy56npiRbOBxR5PmyuTY1YkqWH9iFCj5q0tObIrtbSWrmP5nFqmM0tjxH6N/tWTVi4LiCAr568Aj/TUJQNd3A4yaOKqrRYjtY2hqJ49iTNY/fsql8+21Eb+toiPX0WV8NAQnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ck/fTjQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8079FC4CEFE;
	Mon, 13 Oct 2025 12:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760358114;
	bh=8ayZzsM7Tg8a4hHEL+CcWLmAF179tgFq9958rKBp3So=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ck/fTjQAuQ+K19R4lL88ECj/0Dyc4YPuuLzIxdGII9aY0b0oAfOapTL9ra3jPMwB0
	 5GutdlxKErtiv++SiF3f3P37du5dp0CmWfuZ01iSPpWGD6WHfnnKohye80p4l7LPgS
	 vKcpab6vl7FI3vR2UpDz0/3qSUxanHBybWUAfMMWCGgONnyOeT46qbB8HIvFO7Oj5A
	 TVRSniPUmM8nAZXEki4z7Uc5CiBf39hBlWyrTOpvIAzuswgWFKLhtPIy+VB26FhawF
	 TgtEiCVUsK8bacETgqDgUBAzCvXU7ex/NNuvkQbAd03pu7R08H1NWr65CrXRTKFC5s
	 LXcgciLEfD/9g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: graf@amazon.com,  rppt@kernel.org,  changyuanl@google.com,
  pasha.tatashin@soleen.com,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  Abaci Robot
 <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] liveupdate: kho: remove unneeded semicolon
In-Reply-To: <20251013021836.944898-1-jiapeng.chong@linux.alibaba.com>
	(Jiapeng Chong's message of "Mon, 13 Oct 2025 10:18:36 +0800")
References: <20251013021836.944898-1-jiapeng.chong@linux.alibaba.com>
Date: Mon, 13 Oct 2025 14:21:50 +0200
Message-ID: <mafs05xcjm1pd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 13 2025, Jiapeng Chong wrote:

> No functional modification involved.
>
> ./kernel/liveupdate/kexec_handover.c:1155:2-3: Unneeded semicolon.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=26158
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Looks like it comes from Pasha's series
https://lore.kernel.org/lkml/20251007033100.836886-4-pasha.tatashin@soleen.com/

I think this fix can be folded into the patch since it isn't merged yet.

> ---
>  kernel/liveupdate/kexec_handover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 5da21f1510cc..c87d00c40c82 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1152,7 +1152,7 @@ static int __kho_finalize(void)
>  		err |= fdt_begin_node(root, fdt->name);
>  		err |= fdt_property(root, PROP_SUB_FDT, &phys, sizeof(phys));
>  		err |= fdt_end_node(root);
> -	};
> +	}
>  	mutex_unlock(&kho_out.fdts_lock);
>  
>  	err |= fdt_end_node(root);

-- 
Regards,
Pratyush Yadav

