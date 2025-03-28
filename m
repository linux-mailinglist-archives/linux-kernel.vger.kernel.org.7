Return-Path: <linux-kernel+bounces-580270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60373A74FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 18:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE361898146
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 17:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EE61E22FC;
	Fri, 28 Mar 2025 17:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CF058XN2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EEE1E1DF9;
	Fri, 28 Mar 2025 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184249; cv=none; b=ZqYGyNRUuoN9Z0Bvjg3VDdWlTNTqdN/BD+XGOlRfD9SDUV2KbqAYjKfPae+zgp9O2Vm6DXsHNgKgvEL+J47Abn/zuje6yN31alKn+AuAJHO/JhPAs6XctJh+MZ5zuDgSta9noD3OODvlyxaMEuXLP1dPhADuUEjkVWFZljb7tgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184249; c=relaxed/simple;
	bh=op3+AAIYXvlFsPil8RChqFwsSZhSrZvw+UsKo54/4IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oB7T0t2Vlwhtl+bBEv4QZwcByHAHUQIV367+egeIBVwInGH/4XdtFGQWyyEyxoOCzSXqw8H93chs6NEByGMhtDT9eyxXNEtYfeKz9omxIjjobtZGEpGUSAI2oJ0s78ghBc2ohJUhS+RCZvDX3h0hJMaYjQyi/cxjNf8zq1t2wSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CF058XN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38F9C19421;
	Fri, 28 Mar 2025 17:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743184248;
	bh=op3+AAIYXvlFsPil8RChqFwsSZhSrZvw+UsKo54/4IU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CF058XN2awHuVvXzRJZsGMXh+Ps6Cc7duoNCMsHRRznbRzkedacuit4fJSVz4Wq4I
	 SwsuXk9ZOrBMCe9Gc1LpAFuYDQLIiBUnz8JKEKCspzpit5u1UBAnYJiC3UnQCtpTyb
	 ALQ03fvmk2MUl0MzS7PyTKD0YpyytrXSB1f0YAy6/pF8bXEBHtjO5RvYzs8gqorK0m
	 my59Cqfx1f+WUVnEFDUDfqsFZW32bKUVQu9P1xjcaczd4D88ywGRcR2Zqo1xtDN9NP
	 k0r6IOpJr73rIzxcA9Wud+PkbAAf1Ee6/dEUpLIowd9Jd5wZm5BINCcezounEQxhm5
	 MW9PNU0rczmPQ==
Date: Fri, 28 Mar 2025 19:50:43 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Elena Reshetova <elena.reshetova@intel.com>
Cc: dave.hansen@intel.com, linux-sgx@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	asit.k.mallick@intel.com, vincent.r.scarlata@intel.com,
	chongc@google.com, erdemaktas@google.com, vannapurve@google.com,
	dionnaglaze@google.com, bondarn@google.com, scott.raynor@intel.com
Subject: Re: [PATCH v2 2/2] x86/sgx: Implement EUPDATESVN and
 opportunistically call it during first EPC page alloc
Message-ID: <Z-bhczXA6aHdCYHq@kernel.org>
References: <20250328125859.73803-1-elena.reshetova@intel.com>
 <20250328125859.73803-3-elena.reshetova@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328125859.73803-3-elena.reshetova@intel.com>

On Fri, Mar 28, 2025 at 02:57:41PM +0200, Elena Reshetova wrote:
> SGX architecture introduced a new instruction called EUPDATESVN
> to Ice Lake. It allows updating security SVN version, given that EPC
> is completely empty. The latter is required for security reasons
> in order to reason that enclave security posture is as secure as the
> security SVN version of the TCB that created it.
> 
> Additionally it is important to ensure that while ENCLS[EUPDATESVN]
> runs, no concurrent page creation happens in EPC, because it might
> result in #GP delivered to the creator. Legacy SW might not be prepared
> to handle such unexpected #GPs and therefore this patch introduces
> a locking mechanism to ensure no concurrent EPC allocations can happen.
> 
> It is also ensured that ENCLS[EUPDATESVN] is not called when running
> in a VM since it does not have a meaning in this context (microcode
> updates application is limited to the host OS) and will create
> unnecessary load.
> 
> This patch is based on previous submision by Cathy Zhang
> https://lore.kernel.org/all/20220520103904.1216-1-cathy.zhang@intel.com/
> 
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> ---
>  arch/x86/include/asm/sgx.h      | 41 +++++++++++++--------
>  arch/x86/kernel/cpu/sgx/encls.h |  6 ++++
>  arch/x86/kernel/cpu/sgx/main.c  | 63 ++++++++++++++++++++++++++++++++-
>  arch/x86/kernel/cpu/sgx/sgx.h   |  1 +
>  4 files changed, 95 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
> index 6a0069761508..5caf5c31ebc6 100644
> --- a/arch/x86/include/asm/sgx.h
> +++ b/arch/x86/include/asm/sgx.h
> @@ -26,23 +26,26 @@
>  #define SGX_CPUID_EPC_SECTION	0x1
>  /* The bitmask for the EPC section type. */
>  #define SGX_CPUID_EPC_MASK	GENMASK(3, 0)
> +/* EUPDATESVN presence indication */
> +#define SGX_CPUID_EUPDATESVN	BIT(10)
>  
>  enum sgx_encls_function {
> -	ECREATE	= 0x00,
> -	EADD	= 0x01,
> -	EINIT	= 0x02,
> -	EREMOVE	= 0x03,
> -	EDGBRD	= 0x04,
> -	EDGBWR	= 0x05,
> -	EEXTEND	= 0x06,
> -	ELDU	= 0x08,
> -	EBLOCK	= 0x09,
> -	EPA	= 0x0A,
> -	EWB	= 0x0B,
> -	ETRACK	= 0x0C,
> -	EAUG	= 0x0D,
> -	EMODPR	= 0x0E,
> -	EMODT	= 0x0F,
> +	ECREATE		= 0x00,
> +	EADD		= 0x01,
> +	EINIT		= 0x02,
> +	EREMOVE		= 0x03,
> +	EDGBRD		= 0x04,
> +	EDGBWR		= 0x05,
> +	EEXTEND		= 0x06,
> +	ELDU		= 0x08,
> +	EBLOCK		= 0x09,
> +	EPA		= 0x0A,
> +	EWB		= 0x0B,
> +	ETRACK		= 0x0C,
> +	EAUG		= 0x0D,
> +	EMODPR		= 0x0E,
> +	EMODT		= 0x0F,
> +	EUPDATESVN	= 0x18,
>  };
>  
>  /**
> @@ -73,6 +76,11 @@ enum sgx_encls_function {
>   *				public key does not match IA32_SGXLEPUBKEYHASH.
>   * %SGX_PAGE_NOT_MODIFIABLE:	The EPC page cannot be modified because it
>   *				is in the PENDING or MODIFIED state.
> + * %SGX_INSUFFICIENT_ENTROPY:	Insufficient entropy in RNG.
> + * %SGX_EPC_NOT_READY:		EPC is not ready for SVN update.
> + * %SGX_NO_UPDATE:		EUPDATESVN was successful, but CPUSVN was not
> + *				updated because current SVN was not newer than
> + *				CPUSVN.
>   * %SGX_UNMASKED_EVENT:		An unmasked event, e.g. INTR, was received
>   */
>  enum sgx_return_code {
> @@ -81,6 +89,9 @@ enum sgx_return_code {
>  	SGX_CHILD_PRESENT		= 13,
>  	SGX_INVALID_EINITTOKEN		= 16,
>  	SGX_PAGE_NOT_MODIFIABLE		= 20,
> +	SGX_INSUFFICIENT_ENTROPY	= 29,
> +	SGX_EPC_NOT_READY		= 30,
> +	SGX_NO_UPDATE			= 31,
>  	SGX_UNMASKED_EVENT		= 128,
>  };
>  
> diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
> index 99004b02e2ed..3d83c76dc91f 100644
> --- a/arch/x86/kernel/cpu/sgx/encls.h
> +++ b/arch/x86/kernel/cpu/sgx/encls.h
> @@ -233,4 +233,10 @@ static inline int __eaug(struct sgx_pageinfo *pginfo, void *addr)
>  	return __encls_2(EAUG, pginfo, addr);
>  }
>  
> +/* Update CPUSVN at runtime. */
> +static inline int __eupdatesvn(void)
> +{
> +	return __encls_ret_1(EUPDATESVN, "");
> +}
> +
>  #endif /* _X86_ENCLS_H */
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index b61d3bad0446..24563110811d 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -32,6 +32,11 @@ static DEFINE_XARRAY(sgx_epc_address_space);
>  static LIST_HEAD(sgx_active_page_list);
>  static DEFINE_SPINLOCK(sgx_reclaimer_lock);
>  
> +/* This lock is held to prevent new EPC pages from being created
> + * during the execution of ENCLS[EUPDATESVN].
> + */
> +static DEFINE_SPINLOCK(sgx_epc_eupdatesvn_lock);
> +
>  static atomic_long_t sgx_nr_used_pages = ATOMIC_LONG_INIT(0);
>  static unsigned long sgx_nr_total_pages;
>  
> @@ -457,7 +462,17 @@ static struct sgx_epc_page *__sgx_alloc_epc_page_from_node(int nid)
>  	page->flags = 0;
>  
>  	spin_unlock(&node->lock);
> -	atomic_long_inc(&sgx_nr_used_pages);
> +
> +	if (!atomic_long_inc_not_zero(&sgx_nr_used_pages)) {
> +		spin_lock(&sgx_epc_eupdatesvn_lock);
> +		/* Only call sgx_updatesvn() once the first enclave's
> +		 * page is allocated from EPC
> +		 */
> +		if (atomic_long_read(&sgx_nr_used_pages) == 0)
> +			sgx_updatesvn();
> +		atomic_long_inc(&sgx_nr_used_pages);
> +		spin_unlock(&sgx_epc_eupdatesvn_lock);
> +	}
>  
>  	return page;
>  }
> @@ -970,3 +985,49 @@ static int __init sgx_init(void)
>  }
>  
>  device_initcall(sgx_init);
> +
> +/**
> + * sgx_updatesvn() - Issue ENCLS[EUPDATESVN]
> + * If EPC is ready, this instruction will update CPUSVN to the currently
> + * loaded microcode update SVN and generate new cryptographic assets.
> + */
> +void sgx_updatesvn(void)
> +{
> +	int retry = 10;
> +	int ret;
> +
> +	lockdep_assert_held(&sgx_epc_eupdatesvn_lock);
> +
> +	if (!(cpuid_eax(SGX_CPUID) & SGX_CPUID_EUPDATESVN))
> +		return;
> +
> +	/* Do not execute ENCLS[EUPDATESVN] if running in a VM since
> +	 * microcode updates are only meaningful to be applied on the host.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +		return;
> +
> +	do {
> +		ret = __eupdatesvn();
> +		if (ret != SGX_INSUFFICIENT_ENTROPY)
> +			break;
> +
> +	} while (--retry);
> +
> +	switch (ret) {
> +	case 0:
> +		pr_info("EUPDATESVN: success\n");
> +		break;
> +	case SGX_EPC_NOT_READY:
> +	case SGX_INSUFFICIENT_ENTROPY:
> +	case SGX_EPC_PAGE_CONFLICT:
> +		pr_err("EUPDATESVN: error %d\n", ret);
> +		break;
> +	case SGX_NO_UPDATE:
> +		break;
> +	default:
> +		pr_err("EUPDATESVN: unknown error %d\n", ret);
> +		break;
> +	}

Overall, I think you're right in that "inversion" does make sense,
now that other stuff is better aligned.

At least when there is spurious error, I think ioctl's should stop
responding and driver should not do anything useful anymore. I.e.,
it should go out-of-service.

I don't think the driver should tear-down, just stop servicing
VM's and responding ioctl's.

Possibly thish should be also right action for other errors than
"insufficient entropy" but I'm open for comments for this.

BR, Jarkko

