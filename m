Return-Path: <linux-kernel+bounces-880870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 291C0C26C23
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0902C1B21EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A3425FA29;
	Fri, 31 Oct 2025 19:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2ug1YuP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C40217F29;
	Fri, 31 Oct 2025 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939013; cv=none; b=mjvBL6VEy1YL75Bb8UvXhqmgkIzHTSA39qoH9YMx2dMwTdwYAJT9lFrRxPdX/kmcWv3tT6qT2hrCNHA0qqJSU0s+DSV9X0UMi0JBWxQ2GBMl+SG/QUcum9YuBtGizmCgau8MaQOU5lFKgkVUfs4eVTYekTI8oqzFwXxc6837w4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939013; c=relaxed/simple;
	bh=vDC8voIK3kAfvmRjhY+sjC+HS2822mbKCzHoiJMeMac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thfolLNyrDZQLM3CQgj0Ka3UjTimZ1wvnMNqFoV2y+U7DkoQdwdtsRQ4/N7QWKyFzSSHL8ZaDjDpiha7685t2HmWh6eMctOpn5gn4r+TQt52xgd6fyu/EvbuJ5NY3sDiUflObna8ZFBKOkU4GYFIRgQSmX79Qb8kRD/5Iz+W52Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2ug1YuP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761939011; x=1793475011;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vDC8voIK3kAfvmRjhY+sjC+HS2822mbKCzHoiJMeMac=;
  b=N2ug1YuPaNmui7/T/hIuDeq0vpJNneXfiWWIy2dzZnByi//4QtSbQUcr
   nPtDoNYAHFHyAOR7nxI78qKff5RTWedK/ODqYXKoBvdvSs86Zpd056tdt
   bwiDiQd/mfYMr9Pscyd1SrRVRE9BUj35dyjyEV3X5wz2+aLLJCQPgfmMS
   Y++EHcJzSolbO7bcLzCD5XQN0F1cQgbYFbPetJ398nVcLPPFwc3hKK6dL
   yRrRd/R7gTto1UtlC2pigGUvrFralK3LI+hlMUALv3pUQubo5Ady3xn/j
   ftzGl7xtAUL2i1hjlchpXKjFnee2xOSsycUxaJZM3Wrg4WNJTK7ptCtMS
   Q==;
X-CSE-ConnectionGUID: K+Gp3MBKSAq8/Qto0aFMuA==
X-CSE-MsgGUID: YYwMgcS0Q9KDWM/yjXRVcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="64025355"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="64025355"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 12:29:48 -0700
X-CSE-ConnectionGUID: JlFjmC9fTTidNtdqSzQ7kw==
X-CSE-MsgGUID: NNm7J2i/R1y69SaiOONC4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="187052353"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.245.244.92]) ([10.245.244.92])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 12:29:46 -0700
Message-ID: <7ae2e133-7058-415c-99aa-55ccf8714b2b@linux.intel.com>
Date: Fri, 31 Oct 2025 21:29:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] usb: xhci: limit run_graceperiod for only usb 3.0
 devices
To: Hongyu Xie <xiehongyu1@kylinos.cn>, mathias.nyman@intel.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20251017121254.2887283-1-xiehongyu1@kylinos.cn>
 <7d19444c-930e-4f43-b7bc-00c746d38cc0@linux.intel.com>
 <b8ac5a69-22e0-4581-85cb-e8a8130e005e@kylinos.cn>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <b8ac5a69-22e0-4581-85cb-e8a8130e005e@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/31/25 10:31, Hongyu Xie wrote:
> Hello,
>    Anything new about this patch?
> 

It's now in my for-usb-next branch targeted for 6.19

Thanks
Mathias

