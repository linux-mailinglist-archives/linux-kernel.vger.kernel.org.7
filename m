Return-Path: <linux-kernel+bounces-870827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 47782C0BC57
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41E914ED78D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 04:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8659B2264A7;
	Mon, 27 Oct 2025 04:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rPtBzuXi"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5333B78F29
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761537598; cv=none; b=jEWtqzV6gTFYQvqnqi1JLOLgThN2mybqwtqzpANiYeG/myTk/6CJpBvMAiFGXbOu39JJPXKdz7yuORk4Y/fYnoRAJ0idVRsVA1vfBWFg/3vR2MRfFgbXDhzASGnwlWczVbmN/re22U7hSWvQdCSJWc9aCcvAQiWXISUhFdVCU2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761537598; c=relaxed/simple;
	bh=bmVbyEReaDv8EMndV/1PiyXmYwzxZJhCFZLlMVYfURU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJC44p5UuUOL35o+jwGmAuiJR5Np2j/bLW+e7WqA+pw+kuLT6yeV5RZ/WD8Z+qE95Ah7/ed+o/eJOymyQbdJq+XvJSsIkKR/3w5zEft7pPo54CLyn1fzk/pm3SNdGOhy3mQN0HuBk+LPMpVFVIDyhvCPzzfK3WDlRBRRue+sMJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rPtBzuXi; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761537593; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DQc31bFTrrVKy16VImjwIlP/bVKFQ1gKD56/5QESdXw=;
	b=rPtBzuXi2s2JdvognITzZwYAwE8AS8CJUhBbv5M3qKmI5LzPzr/PveE0RG0iTlAehC9eJqaDw4ssfxnoX/jLGvTBxRaw19xkhag8yuS1w01ZTACL38fypi+6R87BG3vzlFKke5nffPfz8dxY0RxY84odUTp9jut7z/+Oaa2umKA=
Received: from 30.221.131.236(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wr-t3iK_1761537591 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 27 Oct 2025 11:59:52 +0800
Message-ID: <162c9d5b-b959-41b6-9951-cd0d6d4f065b@linux.alibaba.com>
Date: Mon, 27 Oct 2025 11:59:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: erofs: add myself as reviewer
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org, chao@kernel.org,
 zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 lihongbo22@huawei.com
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20251027025206.56082-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251027025206.56082-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/10/27 10:52, Chunhai Guo wrote:
> In the past two years, I have focused on EROFS and contributed features
> including the reserved buffer pool, configurable global buffer pool, and
> the ongoing direct I/O support for compressed data.
> 
> I would like to continue contributing to EROFS and help with code
> reviews. Please CC me on EROFS-related changes.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>

I’m perfectly fine with having more eyes on EROFS development
if you have any extra time to review the future work.

Thanks,
Gao Xiang


