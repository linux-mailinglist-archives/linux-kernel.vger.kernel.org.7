Return-Path: <linux-kernel+bounces-826978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA183B8FC87
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19BB17FAA0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2560A287254;
	Mon, 22 Sep 2025 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tpLbvgwX"
Received: from out199-7.us.a.mail.aliyun.com (out199-7.us.a.mail.aliyun.com [47.90.199.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582D24BBFD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758533965; cv=none; b=msmovC1qS5bLerS/L2ho/yHey8TSheeCLS7d9V4E5Uz4lelPsDttzMcGjJOjI2wPGxb9ys+PuKRxap/uAbT78Z+AsMb9wqkDYYID3PVVVXhVhJJHkVvC0fCfLoxlSktfZ5siAsrW2rUY0ZdG0aBjrl06Yrlq1bpaB+EYS5twl0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758533965; c=relaxed/simple;
	bh=r/ocKBTmkuofXAFwgHzgAEe95SdukP1y4I2xGYWe31c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzdIbxUOrkrkvLwJLWZkziW7oAgxRzKgwEY/7LzYzHKxh4+WGMWODrBG0crF/OVyVgums1a4N42/NqgqadiJ3iiAPveaSVer1tHeC3i7c2oaVYMVxR2iZjnBYj54zK8edZxMXa3/xlxAKFKBkDhIxVSdsYcMuLZbfj1+MsVHJN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tpLbvgwX; arc=none smtp.client-ip=47.90.199.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758533946; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VMTFYI9vtwS1lrOKpDkvU2sRpGsH6MvSV4MjItMsv0g=;
	b=tpLbvgwXvHTIC4aweetVd9v8Dq5J9ZVE0Vxjj2+yEkpPQy43IyIWauO0NQPkD8cNDMf72iVfW1jn/mfeAo0qXTFZSP+sKEYjEuAK0dwi3K16KSRr/HNoi8vgL1wZOOyFPuj/g3YzIHKJ8RFLRLrcznsV1RgQSv7KKKLzCR+URh0=
Received: from 30.221.131.10(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WoVFgT1_1758533944 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Sep 2025 17:39:05 +0800
Message-ID: <f8d9a52f-0e06-4ed2-9729-db4658992fae@linux.alibaba.com>
Date: Mon, 22 Sep 2025 17:39:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] erofs: Add support for FS_IOC_GETFSLABEL
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250922092937.2055-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250922092937.2055-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/22 17:29, Bo Liu wrote:
> From: Bo Liu (OpenAnolis) <liubo03@inspur.com>
> 
> Add support for reading to the erofs volume label from the
> FS_IOC_GETFSLABEL ioctls.
> 
> Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

