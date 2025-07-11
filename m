Return-Path: <linux-kernel+bounces-728059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACC2B02331
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B4A3B0191
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EF42F1FDE;
	Fri, 11 Jul 2025 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9winEvl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1193519E82A;
	Fri, 11 Jul 2025 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256449; cv=none; b=AEH1WELoXaxVlh4aahqjjXg7zbM03UIMAh2Qx5oWdQrcjAoURHgmE75GRAIS02cnOl2zlqAxBnfqIdnudaXu/ADrRJgDsDNd4VdYL5+wRtROCiG3unlgu5nWxz8yABTBmilV007qT4RQV+oyjy4VKPuljuUsHLEyf70IhX19cLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256449; c=relaxed/simple;
	bh=Cwq3VS5UcN2KUaIuuIlaQLGuBtY3oR5HVw6k0JEMv/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEoB4vGURyfcjthZgHtUxlterVvNA++uYlDpKf/Sv5z3Wucr38xYnHQkSBgxGPo3Rudj893i9pV+ILbL4ID1ag7YUvLhm0ebNL/ZBtb2Z81wNS2RAaCin1xl3JS6yd2in+e+4lt7GNgXkPiVBkJmoLfRoGTh7E67IaJlxdTfUvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9winEvl; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752256448; x=1783792448;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Cwq3VS5UcN2KUaIuuIlaQLGuBtY3oR5HVw6k0JEMv/k=;
  b=f9winEvlPySFqEotjHrwJCqWa0KUi4qdzRUaEhDCDoedPBAO15kFd50I
   QJjY4yWOky33FeRdkmHWH/TWOEy31GLEbEDawP1DIWdh5TYS5OM2yAazy
   lkfTXQtUxh1D6bb4Qbe94Ld3vsjAJ9JJwaJF2lsWnYuIeolLboJsiyrka
   4amLePtn4toDZIoUKEuXP+uri6ZCRzVQi/Qd2frXB/NYa+X7Icndc2tO2
   dp6vO0s5TFmvVQLW4p8j8HuZh7rj2Eqo4liE/gwB85F4BkW1EqPu/JuPp
   NaddmcxDocLp5GBQvxXmSAn2arrLfncqqBG5xlAwMIOY/2P3cK2OVNr1+
   Q==;
X-CSE-ConnectionGUID: 8iU+d7pJS+GzfIsceoOXvw==
X-CSE-MsgGUID: FA3au3edSMaf6nGzvtoMnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58367593"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="58367593"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 10:54:07 -0700
X-CSE-ConnectionGUID: qj+onFWGSruvJttldkNTHw==
X-CSE-MsgGUID: ACVIvgoaSp2UW5ySgWYfhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="187402341"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.111.20]) ([10.125.111.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 10:54:07 -0700
Message-ID: <461a33d3-f91a-4dd3-bb97-048670530b25@intel.com>
Date: Fri, 11 Jul 2025 10:54:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] x86/sgx: Enable automatic SVN updates for SGX
 enclaves
To: Elena Reshetova <elena.reshetova@intel.com>
Cc: jarkko@kernel.org, seanjc@google.com, kai.huang@intel.com,
 mingo@kernel.org, linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, asit.k.mallick@intel.com, vincent.r.scarlata@intel.com,
 chongc@google.com, erdemaktas@google.com, vannapurve@google.com,
 dionnaglaze@google.com, bondarn@google.com, scott.raynor@intel.com
References: <20250711165212.1354943-1-elena.reshetova@intel.com>
 <20250711165212.1354943-6-elena.reshetova@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250711165212.1354943-6-elena.reshetova@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/11/25 09:50, Elena Reshetova wrote:
> == Background ==
> 
> ENCLS[EUPDATESVN] is a new SGX instruction [1] which allows enclave
> attestation to include information about updated microcode SVN without a
> reboot. Before an EUPDATESVN operation can be successful, all SGX memory
> (aka. EPC) must be marked as “unused” in the SGX hardware metadata
> (aka.EPCM). This requirement ensures that no compromised enclave can
> survive the EUPDATESVN procedure and provides an opportunity to generate
> new cryptographic assets.
> 
> == Patch Contents ==
> 
> Attempt to execute ENCLS[EUPDATESVN] every time the first file descriptor
> is obtained via sgx_(vepc_)open(). In the most common case the microcode
> SVN is already up-to-date, and the operation succeeds without updating SVN.
> If it fails with any other error code than SGX_INSUFFICIENT_ENTROPY, this
> is considered unexpected and the *open() returns an error. This should not
> happen in practice. On contrary, SGX_INSUFFICIENT_ENTROPY might happen due
> to a pressure on the system's DRNG (RDSEED) and therefore the *open() can
> be safely retried to allow normal enclave operation.

The effort to add paragraphs would be appreciated.

>  int sgx_inc_usage_count(void)
>  {
> -	atomic64_inc(&sgx_usage_count);
> -	return 0;
> +	int ret;
...

For what it does sgx_inc_usage_count() is seriously hard to parse and
complicated. Three logical atomic ops *and* a spinlock? Wouldn't this
suffice?

Just make 'sgx_usage_count' a normal integer and always guard it with a
the existing lock:

int sgx_inc_usage_count(void)
{
	int ret;

	guard(mutex)(&sgx_svn_lock);

	if (sgx_usage_count++ == 0)
		return sgx_update_svn();

	return 0;
}

Yeah, it makes the fast path a spinlock instead of an atomic_inc, but
it's still the same number of atomic ops in the end.

Isn't that a billion times more readable? It barely even needs commenting.

What am I missing?

