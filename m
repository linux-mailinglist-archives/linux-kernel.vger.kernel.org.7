Return-Path: <linux-kernel+bounces-809133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA719B50903
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9436C4649D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F242741A0;
	Tue,  9 Sep 2025 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G90SVAff"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51A726AEC;
	Tue,  9 Sep 2025 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757458663; cv=none; b=iP2Sjkzzz61zCyg0gn8yfeCLxuAJHv3fEn2kVDt1n03z+P1A4CsSGqRyweUrDlgBstVQ3gkC7qsia0QqMcUqGsx6r5jauAmTBoVvwcbrhYCMJQ38sWU23mNKuq1lcL3z2H6S0qT5V+f4COUCkWVZfWPe1Sx+yACN/gxocXSSq54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757458663; c=relaxed/simple;
	bh=1qrMDdgRVUTxlcehEiCAg8EBNYG4zIVOPgE34DWrMyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHQf/XmZwHo4m0Visvl55IMaY5SG05B0n1CIdTq6UsDuIvheqJhe1L0+44K5dW1GGr9AyYPMXXlLUDIxTBvnkjvP73coBA9jDETxWbCeMpo/xG4HQuie8J1ZRQ+FoPE1OZknoHY0MNcPR71k2vxPkJj5Mor3BAzqGBvkrIFrkpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G90SVAff; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757458662; x=1788994662;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1qrMDdgRVUTxlcehEiCAg8EBNYG4zIVOPgE34DWrMyk=;
  b=G90SVAffrHxWRXLymomgzNzukzi98cUNp5J1Jhh9tuTNO/EQsK2QQAnd
   EwdGtlSJ9iIcFrcMsbsvtz9HesxJiDJX9bOC5TNREXcpK0ZASSdFdi4XA
   hsKA5IYakHDV8haRF1PliM8Bit0U/5dmSofmByYN70IuKMDcpS7IO+Uio
   VZlvkwXGxrfmQ4UW4mLaAVtSS3j0N/QD/96xoRjLGO8de0frbD2Jw3u4H
   YL/Sj/lmUrsdYvDJhK9PBMYVsGquHc93ek2HnNVhLtfqgKQ4YN4cfjGvA
   pVB+bvbk0hZiWGaAbj8IoOzu1m/Xh6GYqBsm46rMoXPXg/3T5F05fdfeB
   A==;
X-CSE-ConnectionGUID: zEUdadQ9SVq2kHaanT33cQ==
X-CSE-MsgGUID: h4X09MMJRle87KF1eBtG5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59699528"
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="59699528"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 15:57:41 -0700
X-CSE-ConnectionGUID: ixjKb18jT5GYZr3kVdO0XQ==
X-CSE-MsgGUID: VoglGF7sQFWJVbMp24c6Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="173131049"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.244.230]) ([10.245.244.230])
  by fmviesa006.fm.intel.com with ESMTP; 09 Sep 2025 15:57:40 -0700
Message-ID: <e29fa12b-55e4-4ab1-b623-11feb447bdf7@linux.intel.com>
Date: Wed, 10 Sep 2025 01:57:39 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] usb: xhci: Queue URB_ZERO_PACKET as one TD
To: Michal Pecio <michal.pecio@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250908130128.7ed81912.michal.pecio@gmail.com>
 <6ca18b05-80d4-4988-bb08-3cad003e10f4@linux.intel.com>
 <20250909193859.73127f85.michal.pecio@gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250909193859.73127f85.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9.9.2025 20.38, Michal Pecio wrote:
> On Tue, 9 Sep 2025 16:04:33 +0300, Mathias Nyman wrote:
>> Adding the zero-length TRB to the original TD when we need to send a
>> zero-length packet would simplify things, and I would otherwise fully
>> support this, but the xHCI spec is pretty clear that it requires a
>> dedicated TD for zero-length transactions.
> 
> You are right of course, an empty TRB in a TD would simply send no
> data, or maybe it's a TRB Error, I'm not sure.
> 
> But this is not what this patch is about - the trick is to use an
> *unchained* TRB, which is a separate TD from HW's perspective, and
> to count it as part of the same TD from the driver's perspective.

Ok, I see.
The whole TD without completion flag does worry me a bit.

We need to make sure stop/stald mid TD cases work, and  urb length is
set correctly.

> 
> Control URBs are like that and they work fine. They can halt on any
> TRB (which are all unchained, per spec) and the whole URB goes out.
> 
> This bug is (probably?) low impact, but it bothers me because it's
> a design flaw: either non-isoc multi-TD URBs are supported, or they
> are not. One or another part of the driver needs to adapt.

There is a risk that this is one of those "cure is worse than the
disease" cases.

Thanks
Mathias

