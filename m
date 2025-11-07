Return-Path: <linux-kernel+bounces-890438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9298DC400DC
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62D314EF6C6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D482D3732;
	Fri,  7 Nov 2025 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTfQN3ra"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB222C3258;
	Fri,  7 Nov 2025 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521089; cv=none; b=HSZnRvgsqMZP1Ef6GvJCIvt9SybKUBEVFxSj6WCvXRHnWm5xtvfSLCI0OdYarXZwnmfJyN+cxIUvB5JEgB0orniPN0fBrgeRBK9PjMHHry4aYETTm7zGdA4ATU8HKdiUayDPPcQ4He+n6XA+xUZThIZeFsGH8g7RJxlyKyJa6rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521089; c=relaxed/simple;
	bh=bESDk50hB8xBxbUglcsOY17iOBjiS3C5kAiDoqg9JDI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TC8zWZMrtJ0h5yFv/39A3bsPiGmTifIqvLd2tgT+ZaW8k6VP5OLNXC87b6ozueKcAixqp6wJot0fvEodQl1VPLl/7sQ/erk/oBjsHasMEBKM6zl5/Dn416seXHsK9IJh663IVAYSBakL7UgL1/paUZfHqLbpwSxs9e5qCJxOBzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XTfQN3ra; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762521088; x=1794057088;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=bESDk50hB8xBxbUglcsOY17iOBjiS3C5kAiDoqg9JDI=;
  b=XTfQN3ra+6Hag3olngYxv+h6IpevGagCojXD5Y9fBadq5mUTRAlVKEvI
   tzv9vuT2bITio3CGLLn4e5tteUPBb+u0J9vJM/L8sjgI2HsjFd57n8B0b
   S7LhP7KE8HGJG9kSUwvxnWcrF83M1Bshs4FFWEGNqkiwiGESSQIobBKRC
   hkltzzUcSui87MpdIxJd72JqmtcGnoKwT9s8kGkw+eq3Nt0BaDgP8LxuM
   SesvO2KaQti4xVFHalEUvZtYafjCcEzLEndqCEzFxYBZNosbB2ipSRKuQ
   +Atw7zM2ZL2Byip4SJNK2OOV/1dt1pdPueaPQn4UIMFmUvB3epg559Kel
   g==;
X-CSE-ConnectionGUID: kgWIMU+JR/K6JDqH4p15vg==
X-CSE-MsgGUID: Ak3SwRErTFmgVVDTSFKP5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="90139730"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="90139730"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 05:11:27 -0800
X-CSE-ConnectionGUID: fIZ8RIs1TZauhlhzFuq9AA==
X-CSE-MsgGUID: T+4aFa6nREOJjyV1qNYJPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="192128043"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.61]) ([10.245.245.61])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 05:11:26 -0800
Message-ID: <057b5fcb-1393-481c-9bac-a9c299c61f8b@linux.intel.com>
Date: Fri, 7 Nov 2025 15:11:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] usb: host: xhci: Release spinlock before
 xhci_handshake in command ring abort
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 wesley.cheng@oss.qualcomm.com
References: <20251022100029.14189-1-uttkarsh.aggarwal@oss.qualcomm.com>
 <8750e1e4-41fb-4fe7-b97e-9d2a26db45c6@linux.intel.com>
 <93a08563-a8f2-4004-bf91-884611b7cc7d@oss.qualcomm.com>
 <5e55d9ba-6b4f-4d92-bb47-04b4a68328d2@linux.intel.com>
Content-Language: en-US
In-Reply-To: <5e55d9ba-6b4f-4d92-bb47-04b4a68328d2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


> 
> A suspended host could also return 0xffffffff on register read, which in turn would cause
> xhci_handshake(reg, CMD_RING_RUNNING, 0, 5sec) to run for full five seconds unsuccessfully
> waiting for the  "command ring running" bit to clear.
> 

Forgot that xhci_handshake() does check for 0xffffffff, and will return -ENODEV,
so this is not part of the issue

-Mathias


