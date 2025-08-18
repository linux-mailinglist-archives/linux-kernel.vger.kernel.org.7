Return-Path: <linux-kernel+bounces-774490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AABB2B2F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8951B22C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F1C20A5E5;
	Mon, 18 Aug 2025 20:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gKq9Pmf6"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CC8274B31
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550162; cv=none; b=hleajr6xyksJQ3w+sTkgp72eb2lnLW4s9wlTn2SSGcg3gpjlYzDOIkb7G1D1EIzFjQPF6qQiWJJ42F8nhgNK8BKo1O8DyQB4I7MuJRYXThr9iMRZrWpU1ox6Ila4eWNsNEJMIegy1xqTLn9KqxLbnjSJPihqQYuiHNJuvWEYEwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550162; c=relaxed/simple;
	bh=r/tlFuEp24RY7LW1HU003dO2ILYoTGwJZsLmDtFGX/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9gDusc7aWEK9rBGDSpyHmQXyo2S/oDFS/EM89DiYsCxmLkS1a+dANEK7hYs+6deKdtU+iWp/AliXp28ce0PWvVSPJB6cJ1ihe7NKUQYUs8CjzMILjMpVoTJXQFLIBvfly1wwXGE4JEXeKCmtpdukV8mNV8i2r0cLl8rhN0xMzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gKq9Pmf6; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3e56fe7a3d6so43152405ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755550160; x=1756154960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yTx0AGgPrDbS3KcN6ga5NW90Vwf9DBfaoRIUpUUDTXY=;
        b=gKq9Pmf6bc026odWyjA8oa2uHAwlkeuX8nz8Vc5gX71wfDlBxMCicnWGl24Os8raWA
         C8e3H77OQyY9VMrP6OSYX1sYsQOpySph0Ire4kdjx6PhSImZBmZGKT2g0X5hPM8FtDB2
         sHxBvyV6luwDJwuYiMejeBe4POxSngVIS+8+tz3JFgeYu4ZLmgGR2AzVf2KkEx0OKKkg
         u1HG7NvsPegxs+9duAXZuSIbi1OqEE25xFI/HgumMMMNkT7/JByDZBvVLLBPy7BsV6Tp
         t/y+AJ//4E6MVXJuyBUDIvdCaWDmMZaACyoqtDj4D+qhZlS1p3EF2aMNCaeUKunId+lZ
         ZvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755550160; x=1756154960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTx0AGgPrDbS3KcN6ga5NW90Vwf9DBfaoRIUpUUDTXY=;
        b=RPRujKe/eplmPG8yb6UBf7kH4OLlQYSerofdT+u7tqDO5qs8EgKVsK6ETp62/7hS03
         mL+uc699OZQdGi7fsI/HYIF5WQg7zSp/2F1k4N6jgg+otitew9A6/Czd658gIy5snWJD
         R3fmdoSDHOtzp9xPOMKFX3m+ihUV9HSeWqNuTDDdRZjx4m0dX5kv408wfetZgH2aUGDX
         HNF0eStrPev37dsyQlGE5OLpoLe3IbCzcx2xvlI9nStsoVadVr5O/eQAdUApP418WPna
         YyAwhz3WAUuoyCENERQDvk7NsZ23aGu+c13DKAu7iRvCVum/tE/KPnXzP0LbBxvze+TJ
         msTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3itRg0vgtmN5dMr/rVHCaOwkJ5zgNQbYQGX0ARbzySCQ47pR5vKHzc0LRv4GBa/dh1gBtizGenaSzuUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwmCDJU9+b6nlOx8VnXeKYDf9iVm55pMIEp+9zvXuctNshnBDk
	l2rqJPLmy7aae6voNHGFZlD04ToHaf1jp0+PwhvDKTZSdDzdFu7IS0UIVq1aqE/pzf4=
X-Gm-Gg: ASbGncucZxXWq30OzFUsXxw41oZu52OeX9LbuyMWwmUnxaw5VAgqCfAhTYzv1cijkjW
	BAarc+wvAgNlIbM4OUF0SyuBpGgweuFLcsckykdPfB7YOgezaz2VRUvo5e85hYo/lTWMFYLjw/s
	wthLLxEHtR21h9Du5dp6V7B72mDwXSroH4Wpw4n99Eui2YGBeJVV/7W6+iZMomHJjwLaUcy9eyk
	1sSFgo79N1cf/uEOZABftzDIgITzHEVvYe5W2dpfGH4Uce1HMAOgtWGZpw9loVSrhr8jVFMXk2c
	8npLL1/N4CXUxlHR/pxUss5b55wkJQMf6g7DsjRAPCOHbPt0txPcI+KJnnRuS7XufBiA4Mk2q0j
	vAL7YeTVxtQCbmtHMpiz0mqWoXIKPZRirGUw=
X-Google-Smtp-Source: AGHT+IHxcwWqm3fjBflzgEs6NvcilbQYpbaH0XAlN7Sox/42b5vyAZqiL/BamV9P4rahkCtx7tHI7Q==
X-Received: by 2002:a05:6e02:18ce:b0:3e5:6696:202d with SMTP id e9e14a558f8ab-3e67665caeemr2588935ab.20.1755550159855;
        Mon, 18 Aug 2025 13:49:19 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c949f68eesm2778428173.77.2025.08.18.13.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 13:49:19 -0700 (PDT)
Date: Mon, 18 Aug 2025 15:49:18 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: dayss1224@gmail.com
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atish.patra@linux.dev>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>
Subject: Re: [PATCH v2 2/3] KVM: riscv: selftests: Use the existing
 RISCV_FENCE macro in `rseq-riscv.h`
Message-ID: <20250818-617bdc4613bfa02c291a6b47@orel>
References: <cover.1754308799.git.dayss1224@gmail.com>
 <7de4aedb44be3166a6568c28da70c0d2d4850571.1754308799.git.dayss1224@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7de4aedb44be3166a6568c28da70c0d2d4850571.1754308799.git.dayss1224@gmail.com>

On Thu, Aug 07, 2025 at 10:59:29PM +0800, dayss1224@gmail.com wrote:
> From: Quan Zhou <zhouquan@iscas.ac.cn>
> 
> To avoid redefinition issues with RISCV_FENCE,
>  directly reference the existing macro in `rseq-riscv.h`.
> 
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Dong Yang <dayss1224@gmail.com>
> ---
>  tools/testing/selftests/rseq/rseq-riscv.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/selftests/rseq/rseq-riscv.h
> index 67d544aaa..06c840e81 100644
> --- a/tools/testing/selftests/rseq/rseq-riscv.h
> +++ b/tools/testing/selftests/rseq/rseq-riscv.h
> @@ -8,6 +8,7 @@
>   * exception when executed in all modes.
>   */
>  #include <endian.h>
> +#include <asm/fence.h>
>  
>  #if defined(__BYTE_ORDER) ? (__BYTE_ORDER == __LITTLE_ENDIAN) : defined(__LITTLE_ENDIAN)
>  #define RSEQ_SIG   0xf1401073  /* csrr mhartid, x0 */
> @@ -24,8 +25,6 @@
>  #define REG_L	__REG_SEL("ld ", "lw ")
>  #define REG_S	__REG_SEL("sd ", "sw ")
>  
> -#define RISCV_FENCE(p, s) \
> -	__asm__ __volatile__ ("fence " #p "," #s : : : "memory")
>  #define rseq_smp_mb()	RISCV_FENCE(rw, rw)
>  #define rseq_smp_rmb()	RISCV_FENCE(r, r)
>  #define rseq_smp_wmb()	RISCV_FENCE(w, w)
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

