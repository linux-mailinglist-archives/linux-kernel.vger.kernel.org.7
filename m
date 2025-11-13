Return-Path: <linux-kernel+bounces-899631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D565AC58734
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C918C35B38F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B072F8BCB;
	Thu, 13 Nov 2025 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCYVtHuS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499AC2F83B3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047372; cv=none; b=aPn/9P4mitG12J5sGCOMotn6BThUA2NSrJblcA04kEnDRfvFWkkHvW96FPMvFpqE1yieQjb2AdLiaRQndU0C1UeIt+MhDhV5dnayM1L5uOG0sNNhkNP+kiPEDh1j7br3lDbynX85CSb6+mlfccm8fCwack3zA0VsXaE5Llgm9EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047372; c=relaxed/simple;
	bh=1S/lEwwEIAoQIgeK0eXkfIk1Dc14TBtOKqQwEW2+8TM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q27OhyZVEEJ+nqW71J14sbcjeIOxUXxDoOOnGbKLz6ZKtzg8JzgZXNQ+OTSnP+OW6ZAI8HCzsQNvDb2vy8yC9+Wymc1t8agA6ITE8tjkJnaKbqCoBy6DALTtbFDc+GvH8mxXofRnOsX/o4jNdyp7Zdf+bK8RQbHgl7bq4AkiiZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCYVtHuS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763047370; x=1794583370;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1S/lEwwEIAoQIgeK0eXkfIk1Dc14TBtOKqQwEW2+8TM=;
  b=dCYVtHuSrYDrMblHUJ/qy4P3qfA407m+w/vAMrR43gWRq5wn/sz+Ufa8
   8NwbnpmiI0DEpat1jiQGY6aQchI94qEHtdL/6EFD8GCiRSQjfPmVWPQll
   Y2B+xdDhOr8wUJr66dlDkdvYlp4dq2jc9Rv8WAX0KX9XLDHd0aOE1ibTx
   whkkuOETh+Ef/IOop+37yKWxRx4Hl6pD1/s3u58LoNyvaABoqzQHGKGrn
   dr9PcVqsMj7/mloN+m00bIyP4IV3HLqo4jWhCJq6ccy+hkDeJYwTZVC+m
   9VJxsgMrJrcZx0HRmtCamXo0VrVOP8nd/pAISViCkO/4MPIkBOnwhX+/h
   A==;
X-CSE-ConnectionGUID: DUPV/2LmTki4tR1t5QryDQ==
X-CSE-MsgGUID: i16vKemqQkezL2Ut/2fVuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65169086"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="65169086"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:22:49 -0800
X-CSE-ConnectionGUID: knFBjVgZSa62bHP2w4ADJA==
X-CSE-MsgGUID: a61Gpr/lQdu4hnM0S+m4Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="193964618"
Received: from mfalkows-mobl.ger.corp.intel.com (HELO [10.246.18.39]) ([10.246.18.39])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:22:48 -0800
Message-ID: <3ee3c7a6-65cc-4d67-9a4d-5b9b09e7908e@linux.intel.com>
Date: Thu, 13 Nov 2025 16:22:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/amdxdna: Clear mailbox interrupt register during
 channel creation
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com,
 mario.limonciello@amd.com
References: <20251107181115.1293158-1-lizhi.hou@amd.com>
Content-Language: en-US
From: "Falkowski, Maciej" <maciej.falkowski@linux.intel.com>
In-Reply-To: <20251107181115.1293158-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>

On 11/7/2025 7:11 PM, Lizhi Hou wrote:
> The mailbox interrupt register is not always cleared when a mailbox channel
> is created. This can leave stale interrupt states from previous operations.
>
> Fix this by explicitly clearing the interrupt register in the mailbox
> channel creation function.
>
> Fixes: b87f920b9344 ("accel/amdxdna: Support hardware mailbox")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_mailbox.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
> index 24258dcc18eb..858df97cd3fb 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
> @@ -516,6 +516,7 @@ xdna_mailbox_create_channel(struct mailbox *mb,
>   	}
>   
>   	mb_chann->bad_state = false;
> +	mailbox_reg_write(mb_chann, mb_chann->iohub_int_addr, 0);
>   
>   	MB_DBG(mb_chann, "Mailbox channel created (irq: %d)", mb_chann->msix_irq);
>   	return mb_chann;

