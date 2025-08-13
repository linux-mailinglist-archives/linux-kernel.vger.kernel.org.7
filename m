Return-Path: <linux-kernel+bounces-767351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 928ECB25331
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB518845B4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6672E92A6;
	Wed, 13 Aug 2025 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7ElGGFV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FFC28B3F3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755110654; cv=none; b=Mqg1aK35ALjuKhVbJxRCpxAhhWuDyBQtBia1DCUHBkncd5nAF7EYQLWfAbp8dk8TRjIOo5k/uzlqqYy29WSI+LqP7OsibWT0aFXbx0FS8WpPTp0DTNLrjxORCFu0H6L0j/Y5aLOCJjT5+fGLR1VCwJ3y/e0oqAhfYhPaiojmKRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755110654; c=relaxed/simple;
	bh=mJD2BkbvjxgDrwFljlBtr6w24VM0830IIP3Zd1UGqAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QoyAwtwCh8+DSgB9Enm0gQEewvVMCLeYB9KzuSylA2FMFmassJ+zqGfmH2aJ0V+TuLUlGmQj26pKy+MMiztDSGPzF9hafm1fsdKAckNDm/jqWxVvqmoZP1YrHxkFPM2nwIqnKSw6lR3AzNZFTjm/+YujLOQ9AYMf/CRpE8lFZKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m7ElGGFV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755110653; x=1786646653;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mJD2BkbvjxgDrwFljlBtr6w24VM0830IIP3Zd1UGqAk=;
  b=m7ElGGFV6EMoQib6fix1cxVySMlPl+icIa8OdG8TbxYBMUGCb32uYWC9
   BpXagqyrB0iabEPxjsPLaEbMgGHnfEbhrEI0H+SIe0pr3WF+EWVhQhI/o
   b5uAs7tCiY9wAeMsiD7HzMUSYlbDjK2JuS6zipXUfJxTYZwJUSmbo2KEw
   xrrR6IqWiItVZr/x3lsSFSOh41Sd+V9hTXLU17d5VqROxUyrY73XMWhIb
   us4kSwiqaG+VqzBEQ5x86PZX87CXZZdrOPEXVPaEozj3D11x0uT062AgT
   LkMDmCieEtK7z6ndy7sc6ZyDV9msiPkVI+IhfnWyrK7IeK6tUnhXBlYqq
   g==;
X-CSE-ConnectionGUID: FiwJMMAwTcSBub73OET8rA==
X-CSE-MsgGUID: grKCm1HbRcmlbdXLIxLXiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="61036321"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="61036321"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 11:44:12 -0700
X-CSE-ConnectionGUID: nPlv+xR0QyeNLDSIv7VDtA==
X-CSE-MsgGUID: pwdLbm0tR/uzvY8p6z/jIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="171880376"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.131]) ([10.125.111.131])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 11:44:12 -0700
Message-ID: <002f259d-2f20-4428-add3-a02650bc728b@intel.com>
Date: Wed, 13 Aug 2025 11:44:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] x86/microcode/intel: Implement staging handler
To: "Chang S. Bae" <chang.seok.bae@intel.com>, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, colinmitchell@google.com, chao.gao@intel.com,
 abusse@amazon.de, linux-kernel@vger.kernel.org
References: <20250409232713.4536-1-chang.seok.bae@intel.com>
 <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250813172649.15474-5-chang.seok.bae@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250813172649.15474-5-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> +/*
> + * Determine if the next data chunk can be sent. Each chunk is typically
> + * one page unless the remaining data is smaller. If the total
> + * transmitted data exceeds the defined limit, a timeout occurs.
> + */

This comment isn't really telling the whole story. It's not just
determining if the chunk can be sent, it's calculating it and filling it in.

> +static bool can_send_next_chunk(struct staging_state *ss)
> +{
> +	WARN_ON_ONCE(ss->ucode_len < ss->offset);

Please don't WARN_ON() they can be fatal because of panic_on_warn. Also
I think this is the wrong spot for this. We should enforce this at the
time ss->offset is _established_ which is oddly enough in the next patch.

	ss->offset = read_mbox_dword(ss->mmio_base);
	if (ss->offset > ss->ucode_len)
		// error out


> +	ss->chunk_size = min(MBOX_XACTION_SIZE, ss->ucode_len - ss->offset);

It's a _little_ non-obvious that "can_send_next_chunk()" is also setting
->chunk_size. It would be easier to grok if it was something like:

	ok = calc_next_chunk_size(&ss);
	if (!ok)
		// error out

> +	if (ss->bytes_sent + ss->chunk_size > MBOX_XACTION_MAX(ss->ucode_len)) {
> +		ss->state = UCODE_TIMEOUT;
> +		return false;
> +	}

"TIMEOUT" seems like an odd thing to call this failure. Can you explain
the choice of this error code a bit, please?

> +/*
> + * Handle the staging process using the mailbox MMIO interface. The
> + * microcode image is transferred in chunks until completion. Return the
> + * result state.
>   */
>  static enum ucode_state do_stage(u64 mmio_pa)
>  {
> -	pr_debug_once("Staging implementation is pending.\n");
> -	return UCODE_ERROR;
> +	struct staging_state ss = {};
> +
> +	ss.mmio_base = ioremap(mmio_pa, MBOX_REG_NUM * MBOX_REG_SIZE);
> +	if (WARN_ON_ONCE(!ss.mmio_base))
> +		return UCODE_ERROR;
> +
> +	init_stage(&ss);
> +
> +	/* Perform the staging process while within the retry limit */
> +	while (!is_stage_complete(ss.offset) && can_send_next_chunk(&ss)) {
> +		/* Send a chunk of microcode each time: */
> +		if (!send_data_chunk(&ss))
> +			break;
> +		/*
> +		 * Then, ask the hardware which piece of the image it
> +		 * needs next. The same piece may be sent more than once.
> +		 */
> +		if (!fetch_next_offset(&ss))
> +			break;
> +	}

The return types here are a _bit_ wonky. The 'bool' returns make sense
for things like is_stage_complete(). But they don't look right for:

	if (!send_data_chunk(&ss))
		break;

where we'd typically use an -ERRNO and where 0 mean success. It would
look something like this:

	while (!staging_is_complete(&ss)) {
		err = send_data_chunk(&ss);
		if (err)
			break;

		err = fetch_next_offset(&ss);
		if (err)
			break;
	}

That's utterly unambiguous about the intent and what types the send and
fetch function _must_ have.

Note I also moved the can_send_next_chunk() call into
staging_is_complete(). I think that makes sense as well for the
top-level loop.

