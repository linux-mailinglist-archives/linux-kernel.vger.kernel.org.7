Return-Path: <linux-kernel+bounces-767385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A286B2539F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A9727B701B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FE02FFDCA;
	Wed, 13 Aug 2025 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5xmaUrf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC072BD5BC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 19:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755112039; cv=none; b=ocmd3xL8CiG2zBNMAoB54SE1/3MMwEP8dvmedGyeo43p/X8ZI6UeBoWcYMcSrcbLp3akm8HG4Gnz2B5UphsR1xFrGFPzbS9YcD8Pob5ckVs08iAx5bkycTXvn9dMl72bv5cd9eXaZZDmlSzhpnfkHVkmCCmYmOsGdY+YTGlF/qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755112039; c=relaxed/simple;
	bh=Im00wm0ThM6lP5VMoTZhpgkW6ZLkX+JOqjeChHV0Al4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfeD8Po3qT+dzhCrGC/wRVjznIAI7+bVVHL7uPbA5hhgnj8ahCA5a9fwB/Cl1sX2gUCj+VPxmclKoDpmQdAz4iCB2nBRlmJ7tCvmxQYzEKmyE4dzQ/Ox4Znbdd8JsxOxH1IRGCVqk7jrGZ0HH/lbruCrjlbam2hxQhIngo8g4i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C5xmaUrf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755112038; x=1786648038;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Im00wm0ThM6lP5VMoTZhpgkW6ZLkX+JOqjeChHV0Al4=;
  b=C5xmaUrfJr/hxLvXYoOAq8rHJE539t3Nh358Ops0hG2jeytVwyIoKXFX
   SyZHFpBv82h5kigl+UOBVHFmjs5moju5fejDpXZTPgCssDjj3pAhGn72L
   GpRI/RQH0ZxrnfK5ChNqtN/OXgYRpLTQ6+k9QIpqPlY78ODLVXAQFaAOA
   NUSgZhqucHLB7mM/FzSIZJcvfDqe6E04YVwnVuJJ2el8UxpQXNkjARjvp
   CNplIdQlEFYuAzvNKQ3bmCKPKla64YlvPHrdafuy1wFmGiQeW46aEp9fB
   jxVs0gc3GIyMy968UzbsaC01HBP6ddviMH64YuiUYJ+nmiGdI3FKRuG72
   w==;
X-CSE-ConnectionGUID: /Y1jIgzAQ6qmsvTqqEdtYQ==
X-CSE-MsgGUID: dVrhFuu+RZiNlUjpMzohRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68499230"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="68499230"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 12:07:16 -0700
X-CSE-ConnectionGUID: rq9CwR/jSbm2DQH7gxSuTw==
X-CSE-MsgGUID: gY+yX63VScKWuVQT8076xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="166810948"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.131]) ([10.125.111.131])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 12:07:16 -0700
Message-ID: <62c0e88e-88b3-4c4f-a403-310f838ceaf4@intel.com>
Date: Wed, 13 Aug 2025 12:07:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] x86/microcode/intel: Support mailbox transfer
To: "Chang S. Bae" <chang.seok.bae@intel.com>, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, colinmitchell@google.com, chao.gao@intel.com,
 abusse@amazon.de, linux-kernel@vger.kernel.org
References: <20250409232713.4536-1-chang.seok.bae@intel.com>
 <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250813172649.15474-6-chang.seok.bae@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250813172649.15474-6-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 10:26, Chang S. Bae wrote:
> Previously, the functions for sending microcode data and retrieving the
> next offset were placeholders, as they required handling the specific
> mailbox format. Implement them as following:
> 
> == Mailbox Format ==
> 
> The staging mailbox consists of two primary sections: 'header' and
> 'data'. While the microcode must be transferred following this format,
> the actual data transfer mechanism involves reading and writing to
> specific MMIO registers.
> 
> == Mailbox Data Registers ==
> 
> Unlike conventional interfaces that allocate MMIO space for each data
> chunk, the staging interface features a "narrow" interface, using only
> two dword-sized registers for read and write operations.
> 
> For example, if writing 2 dwords of data to a device. Typically, the
> device would expose 2 dwords of "wide" MMIO space. To send the data to
> the device:
> 
> 	writel(buf[0], io_addr + 0);
> 	writel(buf[1], io_addr + 1);
> 
> But, this interface is a bit different. Instead of having a "wide"
> interface where there is separate MMIO space for each word in a
> transaction, it has a "narrow" interface where several words are written
> to the same spot in MMIO space:
> 
> 	writel(buf[0], io_addr);
> 	writel(buf[1], io_addr);
> 
> The same goes for the read side.
> 
> == Implementation Summary ==
> 
> Given that, introduce two layers of helper functions at first:
> 
>   * Low-level helpers for reading and writing to data registers directly.
>   * Wrapper functions for handling mailbox header and data sections.
> 
> Using them, implement send_data_chunk() and fetch_next_offset()
> functions. Add explicit error and timeout handling routine in
> wait_for_transaction(), finishing up the transfer.
> 
> Note: The kernel has support for similar mailboxes. But none of them are
> compatible with this one. Trying to share code resulted in a bloated
> mess, so this code is standalone.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Tested-by: Anselm Busse <abusse@amazon.de>
> ---
> V2 -> V3:
> * Update code to reflect the removal of a global variable (Dave).
> 
> V1 -> V2:
> * Add lots of code comments and edit the changelog (Dave).
> * Encapsulate register read/write operations for processing header and
>   data sections.
> ---
>  arch/x86/kernel/cpu/microcode/intel.c | 150 ++++++++++++++++++++++++--
>  1 file changed, 144 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 3eb3331c5012..5402bcb96f47 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -22,6 +22,7 @@
>  #include <linux/mm.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/pci_ids.h>
>  
>  #include <asm/cpu_device_id.h>
>  #include <asm/processor.h>
> @@ -42,8 +43,30 @@ static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
>  
>  #define MBOX_CONTROL_OFFSET	0x0
>  #define MBOX_STATUS_OFFSET	0x4
> +#define MBOX_WRDATA_OFFSET	0x8
> +#define MBOX_RDDATA_OFFSET	0xc
>  
>  #define MASK_MBOX_CTRL_ABORT	BIT(0)
> +#define MASK_MBOX_CTRL_GO	BIT(31)
> +
> +#define MASK_MBOX_STATUS_ERROR	BIT(2)
> +#define MASK_MBOX_STATUS_READY	BIT(31)
> +
> +#define MASK_MBOX_RESP_SUCCESS	BIT(0)
> +#define MASK_MBOX_RESP_PROGRESS	BIT(1)
> +#define MASK_MBOX_RESP_ERROR	BIT(2)
> +
> +#define MBOX_CMD_LOAD		0x3
> +#define MBOX_OBJ_STAGING	0xb
> +#define DWORD_ALIGN(size)	((size) / sizeof(u32))
> +#define MBOX_HEADER(mbox_size)	(PCI_VENDOR_ID_INTEL | \
> +				 (MBOX_OBJ_STAGING << 16) | \
> +				 ((u64)DWORD_ALIGN(mbox_size) << 32))
> +
> +/* The size of each mailbox header */
> +#define MBOX_HEADER_SIZE	sizeof(u64)
> +/* The size of staging hardware response */
> +#define MBOX_RESPONSE_SIZE	sizeof(u64)
>  
>  /*
>   * Each microcode image is divided into chunks, each at most
> @@ -57,6 +80,7 @@ static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
>   */
>  #define MBOX_XACTION_SIZE	PAGE_SIZE
>  #define MBOX_XACTION_MAX(imgsz)	((imgsz) * 2)
> +#define MBOX_XACTION_TIMEOUT_MS	(10 * MSEC_PER_SEC)
>  
>  /* Current microcode patch used in early patching on the APs. */
>  static struct microcode_intel *ucode_patch_va __read_mostly;
> @@ -345,6 +369,49 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
>  	return size ? NULL : patch;
>  }
>  
> +static inline u32 read_mbox_dword(void __iomem *mmio_base)
> +{
> +	u32 dword = readl(mmio_base + MBOX_RDDATA_OFFSET);
> +
> +	/* Acknowledge read completion to the staging hardware */
> +	writel(0, mmio_base + MBOX_RDDATA_OFFSET);
> +	return dword;
> +}
> +
> +static inline void write_mbox_dword(void __iomem *mmio_base, u32 dword)
> +{
> +	writel(dword, mmio_base + MBOX_WRDATA_OFFSET);
> +}
> +
> +static inline u64 read_mbox_header(void __iomem *mmio_base)
> +{
> +	u32 high, low;
> +
> +	low  = read_mbox_dword(mmio_base);
> +	high = read_mbox_dword(mmio_base);
> +
> +	return ((u64)high << 32) | low;
> +}
> +
> +static inline void write_mbox_header(void __iomem *mmio_base, u64 value)
> +{
> +	write_mbox_dword(mmio_base, value);
> +	write_mbox_dword(mmio_base, value >> 32);
> +}
> +
> +static void write_mbox_data(void __iomem *mmio_base, u32 *chunk, unsigned int chunk_size)
> +{
> +	int i;
> +
> +	/*
> +	 * The MMIO space is mapped as Uncached (UC). Each write arrives
> +	 * at the device as an individual transaction in program order.
> +	 * The device can then resemble the sequence accordingly.
> +	 */
> +	for (i = 0; i < DWORD_ALIGN(chunk_size); i++)

I don't really like the DWORD_ALIGN(). To me, this is much more clear:

	for (i = 0; i < chunk_size / sizeof(u32); i++)

> +		write_mbox_dword(mmio_base, chunk[i]);
> +}

I'd _maybe_ make it "chunk_bytes" instead of "chunk_size", but that's
just a naming nit.

>  /*
>   * Prepare for a new microcode transfer by resetting hardware and
>   * configuring microcode image info.
> @@ -388,15 +455,71 @@ static bool can_send_next_chunk(struct staging_state *ss)
>  	return true;
>  }
>  
> +/*
> + * Wait for the hardware to complete a transaction.
> + * Return true on success, false on failure.
> + */
> +static bool wait_for_transaction(struct staging_state *ss)
> +{
> +	u32 timeout, status;
> +
> +	/* Allow time for hardware to complete the operation: */
> +	for (timeout = 0; timeout < MBOX_XACTION_TIMEOUT_MS; timeout++) {
> +		msleep(1);
> +
> +		status = readl(ss->mmio_base + MBOX_STATUS_OFFSET);
> +		/* Break out early if the hardware is ready: */
> +		if (status & MASK_MBOX_STATUS_READY)
> +			break;
> +	}
> +
> +	status = readl(ss->mmio_base + MBOX_STATUS_OFFSET);

Why is another read needed here? It had to go through the loop above at
_least_ once, right?


>  /*
>   * Transmit a chunk of the microcode image to the hardware.
>   * Return true if the chunk is processed successfully.
>   */
>  static bool send_data_chunk(struct staging_state *ss)
>  {
> -	pr_debug_once("Staging mailbox loading code needs to be implemented.\n");
> -	ss->state = UCODE_ERROR;
> -	return false;
> +	u16 mbox_size = MBOX_HEADER_SIZE * 2 + ss->chunk_size;

The "* 2" needs to be explained.

> +	u32 *chunk = ss->ucode_ptr + ss->offset;

I think calling this "src_chunk" would make a lot of sense.

> +	/*
> +	 * Write 'request' mailbox object in the following order:
> +	 * - Mailbox header includes total size
> +	 * - Command header specifies the load operation
> +	 * - Data section contains a microcode chunk
> +	 */
> +	write_mbox_header(ss->mmio_base, MBOX_HEADER(mbox_size));
> +	write_mbox_header(ss->mmio_base, MBOX_CMD_LOAD);
> +	write_mbox_data(ss->mmio_base, chunk, ss->chunk_size);
> +	ss->bytes_sent += ss->chunk_size;
> +
> +	/*
> +	 * Notify the hardware that the mailbox is ready for processing.
> +	 * The staging hardware will process the request asynchronously.
> +	 */
> +	writel(MASK_MBOX_CTRL_GO, ss->mmio_base + MBOX_CONTROL_OFFSET);
> +	return wait_for_transaction(ss);
>  }

Why is it important that "The staging hardware will process the request
asynchronously."? We *could* go off and do other things, but we don't.
We sit here and poll. So what does it matter?

>  
>  /*
> @@ -405,9 +528,24 @@ static bool send_data_chunk(struct staging_state *ss)
>   */
>  static bool fetch_next_offset(struct staging_state *ss)
>  {
> -	pr_debug_once("Staging mailbox response handling code needs to be implemented.\n\n");
> -	ss->state = UCODE_ERROR;
> -	return false;
> +	const u16 mbox_size = MBOX_HEADER_SIZE + MBOX_RESPONSE_SIZE;
> +
> +	/* All responses begin with the same header value: */
> +	WARN_ON_ONCE(read_mbox_header(ss->mmio_base) != MBOX_HEADER(mbox_size));

Again, this seems like a pr_warn() and then 'return false', not a "panic
the system" kind of error.

We should not be panic'ing the system in code that's purely an
optimization at this point.

It's also, IMNHO, bad form to do important actions inside of a WARN_ON()
condition. I'd much rather it be:

/*
 * All responses start with the same mailbox header. Consume
 * it and ensure that it has the expected contents.
 */
static inline int consume_mbox_header(ss)
{
	u32 header = read_mbox_header(ss->mmio_base);
	u32 expected_header = MBOX_HEADER(mbox_size));

	if (header != expected_header) {
		pr_warn_once(...);
		return -EINVAL;
	}

	return 0;
}	

The other way to do it is to do the three reads next to each other and
make it obvious that there are 3 dwords coming out of the device:

	u32 header    = read_mbox_dword(ss->mmio_base);
	u32 offset    = read_mbox_dword(ss->mmio_base);
	u32 err_word  = read_mbox_dword(ss->mmio_base);

... then go do all the checking after that.




