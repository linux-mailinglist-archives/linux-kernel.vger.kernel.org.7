Return-Path: <linux-kernel+bounces-738991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287C9B0C054
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5585F3BEB75
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904E128D857;
	Mon, 21 Jul 2025 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1uxGS41"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F240028B400
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753090166; cv=none; b=afiBw0cIeOkhVVqNm+gy1Im9u8yFgRB7ec3uII3rc+Kme+eWEnTMpDzhW81y2SRqNOXDlZZLWOyW/52nWbxpOUUtcVMVouLAIqX0Dd6N7EvZSIi8s15Wlidd2QkQdVYUwwnWiqCzTRiZhJIFpjKosn7Jvl5Or/1uI+yMGYdZRl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753090166; c=relaxed/simple;
	bh=dSHvmJ7mbIS5KasPwwUPeZlFBFSMCYHiOvHBW84+ptE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RpTJgma8M/pSWsTdwsNv5pvmGHuiTfjv6SqliD3ZlIfJhJhzy8+x10fe6aB/IN6kGglrQXSHdh7pI7wBY8WowbLZf/CdZoYm9cczISOldDuHi1+bym+BfzSNfT2J5VFp92WbpiKqDrQNflPh0Ac/BheonDi2Z9Bb9HEnzxBNB28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1uxGS41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F210C4CEF1;
	Mon, 21 Jul 2025 09:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753090165;
	bh=dSHvmJ7mbIS5KasPwwUPeZlFBFSMCYHiOvHBW84+ptE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=g1uxGS410mdQwGvjQTs4rGmq/G1SuyJTRQyjAbyZUz6e88K62W1ra8PVSR8Kfaci/
	 uf+9qO+vNOtZTHQqClufBXJq9orgXSsXyRA/FYN8A+gBiOS3A1s4zdHJHB4pY54k9c
	 nm1fyjj/GW+Zozyj80ReKoejBC73/3unLcLILrSQ1JT2wc3kFmYTF6hqkgzZ+I9JYo
	 Tk1bQaGJ5kPyEgR5OQ5XSLjjjytlH9G9wEw/ySBogoWCLbs0duYLuzMsGy9PUbpfSJ
	 qaRDTzjhqyzPBci7Yubu/PKn8I+dZQPutNyQH54XxmJI3PBpg5An0fpXRBfoAx2s8z
	 MGwhJCXvqTRRQ==
Message-ID: <fadcc64f-d95d-4902-ae4f-981c91babed6@kernel.org>
Date: Mon, 21 Jul 2025 17:29:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Bo Liu <liubo03@inspur.com>
Subject: Re: [PATCH v6 2/2] erofs: implement metadata compression
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250717070804.1446345-3-hsiangkao@linux.alibaba.com>
 <20250718031942.3052585-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250718031942.3052585-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/18/25 11:19, Gao Xiang wrote:
> From: Bo Liu <liubo03@inspur.com>
> 
> Thanks to the meta buffer infrastructure, metadata-compressed inodes are
> just read from the metabox inode instead of the blockdevice (or backing
> file) inode.
> 
> The same is true for shared extended attributes.
> 
> When metadata compression is enabled, inode numbers are divided from
> on-disk NIDs because of non-LTS 32-bit application compatibility.
> 
> Co-developed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

