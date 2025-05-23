Return-Path: <linux-kernel+bounces-660267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9308AC1ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 05:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBCD4E33F8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 03:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741F2221F0E;
	Fri, 23 May 2025 03:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="IY2U+qYQ"
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C0D2DCBE7;
	Fri, 23 May 2025 03:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747972789; cv=none; b=r5UwI1fcWlvETG7/5fvLJz443HBjvVetf42j0E2Cpsk6vN30dRHIyqB1XpaN9f1hzrS2dxH5hlygSRlN9kF0JuTu3d9hpv93zNyQUcjX/joD2NprOz0GcqZT77Rxy7nyO8T7irZS157GRrumDXNBVSTyr5n8n+gcdXihYMeHTWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747972789; c=relaxed/simple;
	bh=Xs3rciip3/QwToPd2I/zW+LQISuJ1+/fQ4kqCEMCjns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuI/uNSz4sKkG8NMF2rfd5fJEb06pMBN66LWGlVxBZF6eMF6Zv45jTtL2Vd8ulkMP8MjKRJoGMvTBmXlKz+ujuQoCjw79RwbmOq7wrgS7eXqKaiQgYSXFeirnYh1AHXeAFlpNewdXzQcABFa1Ub3dIQMG+ajRQvKAuIG11Ugwqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=IY2U+qYQ; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MXZR828o5qZP9AxMXAMfCBjRO8UYgzLKwvAcmZi3aUg=; b=IY2U+qYQoaBOS4qRlR+YfASdh4
	d7GUeIb6PNd7a4686vEFfUsP42AWD55gkWQSUXejcuNLtM9rhScop6vlq39LZ1SvrPqYZa93qO/Jw
	SsbyCaW6KJG9IQcnirAJ9kCKahZBEJhrc399h7pXK3BZKe111JgllghYUwMHzvXoBRBxVbkgZiTzF
	Az7ABkzPNolm36iFOl8q6xsD0YWvvfkCFEsvbQ1JInIYGd9Ll4L5pTX8Sdp+qA4g2TDS1Kr/2PKKo
	+AHwWWWvt8UTSbWWWegWYxanBdXuucL1pv/8mfJOxZvLB/RMW/6+EiLkjgQv5kgwiRsMLpzux6ZsU
	v315SN7w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uIJZB-008GFT-1t;
	Fri, 23 May 2025 11:59:30 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 23 May 2025 11:59:29 +0800
Date: Fri, 23 May 2025 11:59:29 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: steffen.klassert@secunet.com, daniel.m.jordan@oracle.com,
	nstange@suse.de, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH v2 3/3] padata: avoid UAF for reorder_work
Message-ID: <aC_yoWXJcsLxfLR4@gondor.apana.org.au>
References: <20250110061639.1280907-1-chenridong@huaweicloud.com>
 <20250110061639.1280907-4-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110061639.1280907-4-chenridong@huaweicloud.com>

On Fri, Jan 10, 2025 at 06:16:39AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Although the previous patch can avoid ps and ps UAF for _do_serial, it
> can not avoid potential UAF issue for reorder_work. This issue can
> happen just as below:
> 
> crypto_request			crypto_request		crypto_del_alg
> padata_do_serial
>   ...
>   padata_reorder
>     // processes all remaining
>     // requests then breaks
>     while (1) {
>       if (!padata)
>         break;
>       ...
>     }
> 
> 				padata_do_serial
> 				  // new request added
> 				  list_add
>     // sees the new request
>     queue_work(reorder_work)
> 				  padata_reorder
> 				    queue_work_on(squeue->work)
> ...
> 
> 				<kworker context>
> 				padata_serial_worker
> 				// completes new request,
> 				// no more outstanding
> 				// requests
> 
> 							crypto_del_alg
> 							  // free pd
> 
> <kworker context>
> invoke_padata_reorder
>   // UAF of pd

Looking back this explanation is actually broken.  The call
crypto_del_alg does not free anything immediately.  It can only
start freeing things once the final tfm user goes away.  Any crypto
request of that tfm must have completed before that happens.

If not there is a serious bug in the Crypto API.

So if crypto_del_alg is leading to a freeing of the pd while there
are still outstanding users of that tfm, then this points to a bug
in the Crypto API and not padata.

Can you still reproduce this bug easily if you revert the patches
in this series? If so we should be able to track down the real bug.

To recap, every tfm holds a ref count on the underlying crypto_alg.
All crypto requests must complete before a tfm can be freed, which
then leads to a drop of the refcount on crypto_alg.

A crypto_alg can only be freed when its ref count hits zero.  Only
then will the associated pd be freed.

So what's missing in the above picture is the entity that is freeing
the tfm, thus leading to the actual freeing of the alg and pd.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

