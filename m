Return-Path: <linux-kernel+bounces-721880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BDDAFCF11
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7E016A1E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A040B2E3378;
	Tue,  8 Jul 2025 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BtTmOYGA"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B66D2E0B7C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988071; cv=none; b=FZfD5YyyaTXR/KmcLHFBnxZFlRGUFbMRQYPjMmKoF7Ob95pGEYAE1r8zgkMg+h5iRR0I1IvQHXSYfeor4jSJpKZDtHslUzJZw2L0btWXFkxskvi7j1ATd8r/n4ZBB/XR2CHBKnvwOmjBXm8E8epyWoan0kX2zHk4nD9KAp7s0UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988071; c=relaxed/simple;
	bh=XfIWD2YbkKVLmaVnOSBG72FDzCnZCFgp2xh/MP0JKlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwbxuUgvTxQX0xN96wcZpBkuE5OpfaNJ8pboFsZcrMR/+LATM5kBdwbC8Fr+MPClbrhgWr5UUkbY9Fp5QbCvDcmh7GCYAq56Xsgtaf2gPUuVNK5QnjeZHPOmie/rEP5oX98xTyRJjTqlyWM8rjcWVgIpqN5ZdkFcRfgFd+NtrMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BtTmOYGA; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751988065; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+WoqLLLoCcM1gSeayj0eMKjgqDNXR/FG0MlfB9nFK6M=;
	b=BtTmOYGAQsMzKmUbY8iVxMWKmd/g+qB1J2qwL5O+qLISwIimle/tquNKRx7QC+C6P3XH202ncA/JUT794CiDE73SixlxxHrtmxWcBLNYM2kM5IQNB1Xwl4uV3YFR0SdfZWHPSJQOq6ipj+IO5nVoRBAXweX45E1RO9XJGTwckNM=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiQCvYs_1751988064 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 23:21:04 +0800
Message-ID: <9865fdbe-12bf-44ff-badd-f0bd0fc6aca6@linux.alibaba.com>
Date: Tue, 8 Jul 2025 23:21:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix to add missing tracepoint in
 erofs_read_folio()
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20250708111942.3120926-1-chao@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250708111942.3120926-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/8 19:19, Chao Yu wrote:
> Commit 771c994ea51f ("erofs: convert all uncompressed cases to iomap")
> converts to use iomap interface, it removed trace_erofs_readpage()
> tracepoint in the meantime, let's add it back.
> 
> Fixes: 771c994ea51f ("erofs: convert all uncompressed cases to iomap")
> Signed-off-by: Chao Yu <chao@kernel.org>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

