Return-Path: <linux-kernel+bounces-814492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A45B554BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1F37C6965
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D014731B13A;
	Fri, 12 Sep 2025 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="URGI23hw"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA7A221FCA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757694884; cv=none; b=fraJ8FpULIuUrg/fzCpeQ7qHL46I72InO0SejADat1rr0QKWPBbDxfchAJWH4E55mFOZazkiDqhTm5UFGxk2oVLl80OUEueyVlrB8wkL98LtAwLii8jPd37wsgvDpvDOa9fmHiw9mkrMbCiusOhBSfxc+jRYr/TrrZXOXwU+PgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757694884; c=relaxed/simple;
	bh=WoG5mkTkUIPUDR6MlnodlN2QuV1wC6adv6airOXzmic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dzm9J3y28tJnD2uhwA8kOCB2riJtmpxRSFfp129u1j5g7ueIMsZtEDXM7RB4C2VOLOHEyHWYEh5Xc3ReXtd7tyGx3n9MDGPW6pn/LcMfQgEhMdvIIhflNkQaRR/48AzOL4E+102qp14jiOJZkSyfwZjX+WH6FrAvt6MiD788KhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=URGI23hw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2B63F40E00DD;
	Fri, 12 Sep 2025 16:34:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id M9sxct4lU9Rn; Fri, 12 Sep 2025 16:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757694876; bh=+hWVcd/GQ1bpeZteqLii5hJLPI5G1xqFPg9EamvQ6EQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=URGI23hwnwwC7RsoG59mTLxQJ3kE3p5IpFRUvSMZGmT8/0QJ9/gUhKRE5LZpu91bp
	 pdNnmGgx1fNE8flADE8MlMDG4SDLvCrru6FRpHwoa/BAbo40Lz1HVDjYWJxjEJLPy9
	 0iZCfRINYXUDSra2DHNLS6Lh1vQP9d5PG7aTxE4Prx6IYTpRSUdvo1+o9DZfPUZuth
	 uSsAGa4BBdMDOwPtJKJPlyCLv2QIx+nseTvnN9JsoEfgAwWEpIW0+YJNq9xlFUUpHR
	 C/i+vd5eAryQ6hNeT9kx0geo5o0P00kreTy7UoBFAVPI0P7W39t6mtHBqCA/yq+ojC
	 pKJ3NDbPAIvSSNs3I36rJvhq1BP3xhnyYQC8K+F0auvDh0rOemac3e6lGWHY5xEvOb
	 /aOyWL7hw/HbRPThm3kWyuKYm5DnY7+oZRbCuJWtjs9Ho34zg+W0ZCcXGyafS9qCbj
	 R4Tra1MibJN3DHTdm4vIzSImj9YNsFhsc/Od2njk04N5H62/MAsNb3HF49Nh4dWUH3
	 xuY8o10mJ+GShM7O8nEjokDmcE8STfkOmhJho9tCw+JM9mmP1XX5NCdEVx1JuHb0HX
	 Cwq3kfe4xYNeWXZ0cQiECJqNt6VWoyGcbVsFHtbghzaMJnp/lpxfKQg+z5LMnGg5w7
	 pbQAa7tvVBdjzkrBRENWiesw=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7A6ED40E0163;
	Fri, 12 Sep 2025 16:34:28 +0000 (UTC)
Date: Fri, 12 Sep 2025 18:34:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, chao.gao@intel.com,
	abusse@amazon.de
Subject: Re: [PATCH v5 6/7] x86/microcode/intel: Support mailbox transfer
Message-ID: <20250912163421.GBaMRLjTUr3bcG5fvJ@fat_crate.local>
References: <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250823155214.17465-1-chang.seok.bae@intel.com>
 <20250823155214.17465-7-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250823155214.17465-7-chang.seok.bae@intel.com>

On Sat, Aug 23, 2025 at 08:52:09AM -0700, Chang S. Bae wrote:
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
						      ^
						      |

abrupt sentence end. Looks like the idea was to not have a fullstop there but
continue...

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

I don't understand what the point of this explanation is if all you end up
doing is writing to "io_addr". Why introduce the unnecessary confusion?

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
> Both hardware error states and implicit errors -- invalid header or
> offset -- result in UCODE_ERROR. Emit a clear message for the latter.a

Can we pu-lease stop explaining what the code does?!

Do not talk about *what* the patch is doing in the commit message - that
should be obvious from the diff itself. Rather, concentrate on the *why*
it needs to be done.
 
> Note: The kernel has support for similar mailboxes. But none of them are
> compatible with this one. Trying to share code resulted in a bloated
> mess, so this code is standalone.

Now that belongs in a commit message. Stuff which is non-obvious etc.

> +static void write_mbox_data(void __iomem *mmio_base, u32 *chunk, unsigned int chunk_bytes)
> +{
> +	int i;
> +
> +	/*
> +	 * The MMIO space is mapped as Uncached (UC). Each write arrives
> +	 * at the device as an individual transaction in program order.
> +	 * The device can then resemble the sequence accordingly.

reassemble?

> +	 */
> +	for (i = 0; i < chunk_bytes / sizeof(u32); i++)
> +		write_mbox_dword(mmio_base, chunk[i]);
> +}
> +
>  /*
>   * Prepare for a new microcode transfer: reset hardware and record the
>   * image size.

...

> +static int wait_for_transaction(struct staging_state *ss)
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
> +	/* Check for explicit error response */
> +	if (status & MASK_MBOX_STATUS_ERROR) {
> +		ss->state = UCODE_ERROR;
> +		return -EPROTO;
> +	}
> +
> +	/*
> +	 * Hardware is neither responded to the action nor signaled any

s/is/has/

> +	 * error. Treat this as timeout.
> +	 */
> +	if (!(status & MASK_MBOX_STATUS_READY)) {
> +		ss->state = UCODE_TIMEOUT;
> +		return -ETIMEDOUT;
> +	}
> +
> +	ss->state = UCODE_OK;
> +	return 0;
>  }

...

> @@ -412,9 +542,51 @@ static int send_data_chunk(struct staging_state *ss, void *ucode_ptr __maybe_unu
>   */
>  static int fetch_next_offset(struct staging_state *ss)
>  {
> -	pr_debug_once("Staging mailbox response handling code needs to be implemented.\n\n");
> +	const u64 expected_header = MBOX_HEADER(MBOX_HEADER_SIZE + MBOX_RESPONSE_SIZE);
> +	u32 offset, status;
> +	u64 header;
> +	int err;
> +
> +	/*
> +	 * The 'response' mailbox returns three fields, in order:
> +	 *  1. Header
> +	 *  2. Next offset in the microcode image
> +	 *  3. Status flags
> +	 */
> +	header = read_mbox_header(ss->mmio_base);
> +	offset = read_mbox_dword(ss->mmio_base);
> +	status = read_mbox_dword(ss->mmio_base);
> +
> +	/* All valid responses must start with the expected header. */
> +	if (header != expected_header) {
> +		pr_err_once("staging: invalid response header\n");
> +		err = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	/*
> +	 * Verify the offset: If not at the end marker, it must not
> +	 * exceed the microcode image length
> +	 */
> +	if (!is_end_offset(offset) && offset > ss->ucode_len) {
> +		pr_err_once("staging: invalid response offset\n");

You might want to dump some of the actual values in those pr_* statements so
that it dumps more breadcrumbs and those prints are more useful when debugging
issues.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

