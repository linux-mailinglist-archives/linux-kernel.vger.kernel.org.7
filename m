Return-Path: <linux-kernel+bounces-606216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC0DA8AC9A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 02:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057B91900379
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 00:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AFF19DF40;
	Wed, 16 Apr 2025 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Tus3AVpu"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB6E199E9A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 00:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744762919; cv=none; b=Epa9LzMHKW7Xha5XSMO6aBYO5cxLTAj/R6E20eSHuQTf3EOUCM/HAamfZze4sBOC2GP2CS6dMaWpRyYTGQlhQDQmmavI10e226rBZTbnw98KVdLX91wgF96pGkxGlMg9gACnpZUnsopU5S0qtqDuaLeayGWVFIRQptl9k6o4OZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744762919; c=relaxed/simple;
	bh=pEcAvlgMDveQLVt1s66C/EGs9ZNANsyG4xv9UpvaSnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFkDdXdyhrTAVf9ePQyFK8PUOY5AcmJAZ6LyF8vVCovXElMknLc4Bz9+y/gd3TS5esC23t+jDhCt4SAA2jXBCNSYjUQPx9JQNspm5XTKp2uycSFUeeG1uyLG5uKJrRRHPlC+BXTCJe/+zt7WXKexq/un1E5qc9zAASvjAGIw8dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Tus3AVpu; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id 4nt9uyMBCVkcR4qVou2TbT; Wed, 16 Apr 2025 00:20:20 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 4qVnunYffJ4Pg4qVoukHVQ; Wed, 16 Apr 2025 00:20:20 +0000
X-Authority-Analysis: v=2.4 cv=ZaLWNdVA c=1 sm=1 tr=0 ts=67fef7c4
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=B3fuDwYyW55wTQKIj88FGw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=CpFGIHgWpZrg6UVlTl0A:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s1BeglVl5V4o/Bv4MNYA8HZfcp4/8kdwxBCW7kEmm38=; b=Tus3AVpuBOJzRWt/kY+9xi+3BS
	WhuaVT6hUU4KACDczFzoFwIJK44rC7YwdfOJbU9gCRQgBIeFCTvroZclz0p07WxBBUI1TFNKmoPFS
	bR16XKnSjc/ZkF6RzKcGjW1nBNgWFbeRxGlUNjMpicjR/rwBPqyAaJq5I7rA6LeXUdpsoiFoELjSy
	BMXW+8zHq0VtzNdeelXjytqQ6wasRoH8i6AQx9YpOWy4KMVm/mYvP++CQaGPCjcv+llWZVxHVK8G1
	6vKx3knYXo3D+tTBj0tr/dC4ShqcQ6DLIH8263qVeZcEvVIgRErNsEGPpQuQriS9mtp+M/NCoqk/z
	QnFbtNrg==;
Received: from [201.172.174.147] (port=56116 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1u4qVm-00000000nFf-2h71;
	Tue, 15 Apr 2025 19:20:19 -0500
Message-ID: <a1c6fd4e-69b4-4698-bc5d-ef02cf7312e4@embeddedor.com>
Date: Tue, 15 Apr 2025 18:20:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] nvme-loop: Avoid -Wflex-array-member-not-at-end
 warning
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <Z-axRObjXYjIHGQC@kspp>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <Z-axRObjXYjIHGQC@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.147
X-Source-L: No
X-Exim-ID: 1u4qVm-00000000nFf-2h71
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.174.147]:56116
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNPSJ6NRfkM9u4aQPeWbJ1/ZwjGDsz7mQsPjQmkPOCx9fMADlaM42egO8GV1oYE2Icajzxy0xoHx++sFCPEbuhHgA8reKZA2R2OPH7xaAKyniabmCfvu
 XtEnSMjAm7v0kNy2/lci8pL1MoGJTKZ943z3ssP9UXhdoZ0uixta7gIfWMjt68YuohuE9forhCQb2+8x5lgb027nipZhD/BKhh0tJsoFZjo7FRpDo/161jlz

Hi all,

Friendly ping: who can take this patch, please? :)

Thanks!
-Gustavo

On 28/03/25 08:25, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the structure. Notice
> that `struct nvme_loop_iod` is a flexible structure --a structure
> that contains a flexible-array member.
> 
> Fix the following warning:
> 
> drivers/nvme/target/loop.c:36:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   drivers/nvme/target/loop.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index a5c41144667c..d02b80803278 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -33,10 +33,12 @@ struct nvme_loop_ctrl {
>   
>   	struct list_head	list;
>   	struct blk_mq_tag_set	tag_set;
> -	struct nvme_loop_iod	async_event_iod;
>   	struct nvme_ctrl	ctrl;
>   
>   	struct nvmet_port	*port;
> +
> +	/* Must be last --ends in a flexible-array member. */
> +	struct nvme_loop_iod	async_event_iod;
>   };
>   
>   static inline struct nvme_loop_ctrl *to_loop_ctrl(struct nvme_ctrl *ctrl)


