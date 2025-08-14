Return-Path: <linux-kernel+bounces-769046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFB4B2694B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E74A052D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337C51339B1;
	Thu, 14 Aug 2025 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MHc/KVb3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918EF32142A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181203; cv=none; b=OFm+hr2dGq5cQCK6Y3X7Txl/L0QtOAE5VOjXc87mtMdqhT4p0NhZ0TX0qboSyICPWXJuITFu9sG6aj3fnAWQLn52GcmYu67Z30zFnbmtLAK8hC83SqKXwkOIe4fIeNWsRTVMlV8TAeNbk53KNMRtw4HmqGWVYzZB2XhV94lrpRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181203; c=relaxed/simple;
	bh=aRRAPB/rQfnjpnbdujFCAjl/010VmVnfZBZSaXXAIIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChbZG27WEksFPTY8ogUDI6tEZD3pG3zTmUxAB5qUGXgU3PETdsOtYuyfKvVQMridbrVqH9SlltVzgq69/MG46/5/sIbEe0cEeVtTL4G8xju6uEbT+syVRCFtjjLgUvIuVH+5/tgL9j9qkas6s76oWpLePZVDRRsU9UxmL3ylBfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MHc/KVb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15B3C4CEED;
	Thu, 14 Aug 2025 14:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755181203;
	bh=aRRAPB/rQfnjpnbdujFCAjl/010VmVnfZBZSaXXAIIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MHc/KVb30ZXUDnL5Y38A0NdYQ8lWjo76KMmhrJvYGOraugMLwF3pc8ro6iPYXglqF
	 pOnWo1ceFVCWx3T65Qy2dTGw9Uchh7jTXwgnZT2W/TxuCSonqwY6atlgFU2OmBc6ix
	 PYqmLid8H6eqsEy28jWQxXCqIKOutZXMvpOMH1hs=
Date: Thu, 14 Aug 2025 16:19:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wang Wensheng <wangwensheng4@huawei.com>
Cc: rafael@kernel.org, dakr@kernel.org, robh@kernel.org, broonie@kernel.org,
	saravanak@google.com, linux-kernel@vger.kernel.org,
	chenjun102@huawei.com
Subject: Re: [PATCH v2] driver core: Fix concurrent problem of
 deferred_probe_extend_timeout()
Message-ID: <2025081451-police-playlist-3f9b@gregkh>
References: <20250814122949.9024-1-wangwensheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814122949.9024-1-wangwensheng4@huawei.com>

On Thu, Aug 14, 2025 at 08:29:49PM +0800, Wang Wensheng wrote:
> The deferred_probe_timeout_work may be canceled forever unexpected when
> deferred_probe_extend_timeout() executes concurrently. Start with
> deferred_probe_timeout_work pending, and the problem would
> occur after the following sequence.
> 
>          CPU0                                 CPU1
> deferred_probe_extend_timeout
>   -> cancel_delayed_work => true
>                                      deferred_probe_extend_timeout
>                                        -> cancel_delayed_wrok
>                                          -> __cancel_work
>                                            -> try_grab_pending
>   -> schedule_delayed_work
>    -> queue_delayed_work_on
> since pending bit is grabbed,
> just return without doing anything
>                                         -> set_work_pool_and_clear_pending
>                                      this __cancel_work return false and
>                                      the work would never be queued again
> 
> The root cause is that the PENDING_BIT of the work_struct would be set
> temporaily in __cancel_work and this bit could prevent the work_struct
> to be queued in another CPU.
> 
> Use deferred_probe_mutex to protect the cancel and queue operations for
> the deferred_probe_timeout_work to fix this problem.
> 
> Fixes: 2b28a1a84a0e ("driver core: Extend deferred probe timeout on driver registration")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
> ---
>  drivers/base/dd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 13ab98e033ea..00419d2ee910 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -323,6 +323,7 @@ static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_
>  
>  void deferred_probe_extend_timeout(void)
>  {
> +	guard(mutex)(&deferred_probe_mutex);

But if you grab the lock here, in the probe timeout function, the lock
will be grabbed again, causing a deadlock, right?  If not, why not?

Have you run this patch with lockdep enabled?

This feels broken to me, what am I missing?

thanks,

greg k-h

