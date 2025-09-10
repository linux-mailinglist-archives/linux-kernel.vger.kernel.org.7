Return-Path: <linux-kernel+bounces-810828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACF6B52047
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0AA1B204C8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15342C21D1;
	Wed, 10 Sep 2025 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LDEgRbnB"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C643D2BE7A1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757529233; cv=none; b=i1aByIa/zCp5MJCqkGKtp+ivhaeEMxtxXyLDrXf94v5Lspgink/axz4NilPMpeLe7HzMOOuzGNiBffyHAghCG0DjSTnviGivt6mkndzv46AmQF4lLlg66dOENx8gW5LieLN5clVjFJAD1tQ6JMT5C0Co+vcm182SE5jW2hnG1O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757529233; c=relaxed/simple;
	bh=X2RbXFH5YEPSGkTs7PJWN+OP2HqHg+EfOnYQM6P+F3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cztZ7RoPVtaPMkIY+ueXMEt5MlG7A2UV7Ry0xxgRNXftGs72tdkVtq9Sk5lVkahhnIqZnMEQ0EHJu9JFJGfgfPuxr856xA13/law8yj3G3+FmgjjtzP96s9v1yazl4CLSnYztEy/9jRFBTJVK4MRUpcuYousCeL6b0lepbd6h6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LDEgRbnB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 50BED40E01D6;
	Wed, 10 Sep 2025 18:33:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id T3iolGMNhWew; Wed, 10 Sep 2025 18:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757529225; bh=RAgq1Yfc8xXU8VG0dc4g8YKiB8b48JkD9J6HIEfB/Rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LDEgRbnBI6Qs/zj9bj815PHYsH9MxATtOvhk1eA4H8FJYB64uhE6m5sLzp0OTJVAS
	 +MLT7+Wbq6En1I+LbYpglxigveQMFsDyLwRZrLzo6GIEF8vwSGmOlHQ8gS8duk4kJU
	 iySZg3638GvG1nhSbcCPvypGUl7RlQDzHbjlNSKHP8HzY7+K0SEDGTjtSdDsa0uNj8
	 AX6LugYYyxWxutmhezEaRbCuhuuAj4RblwNEqaPRlp8RIiUwSa+pNzaz5D4UPv2cw9
	 3FAA88SzDPwHdLgW1p74I/lBx75B4NfFq5QhzXbr+fvwnQB6C7spB3K0xgR6Rr1xKV
	 lX9Pv8qySiV0jiqGbuYrgc2p0pcV9LbEpmenGMlIXTQoRHE7GQ7gHIDfQt48abquT/
	 lmoecFLFT08RcNsFMx5YLoVQUc2ygAi89Bvruz/JQtrcI1E3CbsnA6kxXrxs9bLcsN
	 NB1JiyVS6IQuQhrYR4ffPgh8q9Ila5gGnqocsawKsZb1/MqNQLBHJ80OVaqjYPmA0O
	 D2w0UjKaIwQwjLCmr2d9UOijJMA57tjpBOb+YqUJZXg7rWpF5jmMqxSYhn2yR2T6uT
	 7pb0oOECvJnt0BxGwJePwDoqA4zeZB6KRbLantDKVmzTrUAiwpAaRJpS/BqT92OJ3R
	 1Xc+uRKOd77UrqrJbIdqVd2w=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 52E1540E01CD;
	Wed, 10 Sep 2025 18:33:37 +0000 (UTC)
Date: Wed, 10 Sep 2025 20:33:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, chao.gao@intel.com,
	abusse@amazon.de
Subject: Re: [PATCH v5 5/7] x86/microcode/intel: Implement staging handler
Message-ID: <20250910183325.GEaMHEdavbE56NiDUF@fat_crate.local>
References: <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250823155214.17465-1-chang.seok.bae@intel.com>
 <20250823155214.17465-6-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250823155214.17465-6-chang.seok.bae@intel.com>

On Sat, Aug 23, 2025 at 08:52:08AM -0700, Chang S. Bae wrote:
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 3ca22457d839..a1b13202330d 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -20,6 +20,8 @@
>  #include <linux/cpu.h>
>  #include <linux/uio.h>
>  #include <linux/mm.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>

You do see those are sorted by header name length in a reverse order, right?

>  
>  #include <asm/cpu_device_id.h>
>  #include <asm/processor.h>
> @@ -33,6 +35,16 @@ static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
>  
>  #define UCODE_BSP_LOADED	((struct microcode_intel *)0x1UL)
>  
> +/* Defines for the microcode staging mailbox interface */
> +

^ Superfluous newline.

> +#define MBOX_REG_NUM		4
> +#define MBOX_REG_SIZE		sizeof(u32)
> +
> +#define MBOX_CONTROL_OFFSET	0x0
> +#define MBOX_STATUS_OFFSET	0x4
> +
> +#define MASK_MBOX_CTRL_ABORT	BIT(0)
> +
>  /* Current microcode patch used in early patching on the APs. */
>  static struct microcode_intel *ucode_patch_va __read_mostly;
>  static struct microcode_intel *ucode_patch_late __read_mostly;

...

> +/*
> + * Return PAGE_SIZE, or remaining bytes if this is the final chunk
> + */
> +static inline unsigned int calc_next_chunk_size(unsigned int ucode_len, unsigned int offset)
> +{
> +	return min(PAGE_SIZE, ucode_len - offset);
> +}

That oneliner looks useless - sticking a comment over tne min() and putting it
at the single callsite below is good enough.

> +
> +/*
> + * Update the chunk size and decide whether another chunk can be sent.
> + * This accounts for remaining data and retry limits.
> + */
> +static bool can_send_next_chunk(struct staging_state *ss)
> +{
> +	ss->chunk_size = calc_next_chunk_size(ss->ucode_len, ss->offset);
> +	/*
> +	 * Each microcode image is divided into chunks, each at most
> +	 * one page size. A 10-chunk  image would typically require 10
				   ^^^^

> +	 * transactions.
> +	 *
> +	 * However, the hardware managing the mailbox has limited
> +	 * resources and may not cache the entire image, potentially
> +	 * requesting the same chunk multiple times.
> +	 *
> +	 * To tolerate this behavior, allow up to twice the expected
> +	 * number of transactions (i.e., a 10-chunk image can take up to
> +	 * 20 attempts).

Looks quirky but ok, let's try it in practice first...

> +	 *
> +	 * If the number of attempts exceeds this limit, the hardware is
> +	 * likely stuck and mark the state as timeout.
> +	 */
> +	if (ss->bytes_sent + ss->chunk_size > ss->ucode_len * 2) {
> +		ss->state = UCODE_TIMEOUT;
> +		return false;
> +	}
> +
> +	return true;
> +}

...

>  static enum ucode_state do_stage(u64 mmio_pa)
>  {
> -	pr_debug_once("Staging implementation is pending.\n");
> -	return UCODE_ERROR;
> +	struct staging_state ss = {};
> +	int err;
> +
> +	ss.mmio_base = ioremap(mmio_pa, MBOX_REG_NUM * MBOX_REG_SIZE);
> +	if (WARN_ON_ONCE(!ss.mmio_base))
> +		return UCODE_ERROR;
> +
> +	init_stage(&ss);
> +
> +	/* Perform the staging process while within the retry limit */
> +	while (!staging_is_complete(&ss)) {
> +		/* Send a chunk of microcode each time: */
> +		err = send_data_chunk(&ss, ucode_patch_late);
> +		if (err)
> +			break;
> +		/*
> +		 * Then, ask the hardware which piece of the image it
> +		 * needs next. The same piece may be sent more than once.

If this is part of normal operation, your send-max-2x-the-size heuristic might
fail quickly here. I'd track the number of chunks it wants you to send and
then set a per-chunk limit and when it reaches that limit, then cancel the
transaction. Dunno, let's try the simple scheme first...

> +		 */
> +		err = fetch_next_offset(&ss);
> +		if (err)
> +			break;
> +	}
> +
> +	iounmap(ss.mmio_base);
> +
> +	/*
> +	 * The helpers update ss.state on error. The final state is
> +	 * returned to the caller.
> +	 */
> +	return ss.state;
>  }
>  
>  static void stage_microcode(void)
> -- 
> 2.48.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

