Return-Path: <linux-kernel+bounces-873495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 056B9C140CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1164B189A690
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A96F2D739A;
	Tue, 28 Oct 2025 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gja65oT6"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C046825A62E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646709; cv=none; b=pPtVqd9qmEjMvZg8oNHf3rKCxPZp082d2ew3FOZGP19e0h5m5EkClMlkhICBecsth4jLKtN5+mCWn05RILvj0q6Qf2ylhedS+WpbKOC9wxmH1Pw+Nz2TeaYJ4ZZ7OloLQTlZGK57VXrQOisuPDaA5re76fEMQYp9F4CFiaXjMWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646709; c=relaxed/simple;
	bh=B/F1VSmXAUmujo9KnVWkQALAbfIpdSoEp05awJyWpAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhWOAtnoHMvyhWxZAOXS9UoIu5lvAqriq5StWdNxntfXk4WXoBnY39J4HNiDA1TvpmdBQRbkCkiwZc4fXnTitER6kyoSS7HWIR/1EG0/AmNTcGsRHbPKs1dfof1sGDXGkuLS0ZOwfOkWizq+QQlG0S2IXYwhekbXAM36hTii8Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gja65oT6; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761646700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIDM+dygb2BUa46zAb+3HHz7zZDAxImWZVxBS/LTMHU=;
	b=Gja65oT6Ej3kxXJIiBfObdJr37XT53qezfnH3LsJZAnwoVZKN2tpcLv8CNpvLYIhbaGQV8
	qYlG2OEB/ZGBARDnNezC6stE3g2U73DKDbmDaNKrbU6L5iLqWTVVzt7rwN1anw7vmoHTxH
	cTMZA6ZmB0/KnSUdsXeqX13lpSlfBPw=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: linux@weissschuh.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	johannes.berg@intel.com,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH] um: Avoid circular dependency on asm-offsets in pgtable.h
Date: Tue, 28 Oct 2025 18:17:50 +0800
Message-Id: <20251028101750.3263748-1-tiwei.bie@linux.dev>
In-Reply-To: <20251028-uml-offsets-circular-v1-1-601c363cfaaa@weissschuh.net>
References: <20251028-uml-offsets-circular-v1-1-601c363cfaaa@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Tue, 28 Oct 2025 10:02:55 +0100, Thomas Weißschuh wrote:
> Recent changes have added an include of as-layout.h to pgtable.h.
> However this introduces a circular dependency during asm-offsets
> generation as as-layout.h depends on asm-offsets and pgtable.h is an
> input for asm-offsets.
> 
> Building from a clean state results in the following error:
> 
>   CC      arch/um/kernel/asm-offsets.s
> In file included from arch/um/include/asm/pgtable.h:48,
>                  from include/linux/pgtable.h:6,
>                  from include/linux/mm.h:31,
>                  from include/linux/pid_namespace.h:7,
>                  from include/linux/ptrace.h:10,
>                  from include/linux/audit.h:13,
>                  from arch/um/kernel/asm-offsets.c:8:
> arch/um/include/shared/as-layout.h:9:10: fatal error: generated/asm-offsets.h: No such file or directory
>     9 | #include <generated/asm-offsets.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[4]: *** [scripts/Makefile.build:182: arch/um/kernel/asm-offsets.s] Error 1
> 
> As the inclusion of as-layout.h in pgtable.h is not yet needed while
> asm-offsets are generated, break the dependency here.
> 
> Fixes: a7f7dbae94a5 ("um: Remove file-based iomem emulation support")
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  arch/um/include/asm/pgtable.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
> index 1a0d7405e97c..3b42b0f45bf6 100644
> --- a/arch/um/include/asm/pgtable.h
> +++ b/arch/um/include/asm/pgtable.h
> @@ -45,7 +45,9 @@ extern unsigned long *empty_zero_page;
>   * area for the same reason. ;)
>   */
>  
> +#ifndef COMPILE_OFFSETS
>  #include <as-layout.h> /* for high_physmem */
> +#endif

Oops, my bad. Thanks for the fix!

Reviewed-by: Tiwei Bie <tiwei.btw@antgroup.com>

Regards,
Tiwei

