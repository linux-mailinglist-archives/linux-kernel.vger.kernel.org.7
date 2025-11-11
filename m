Return-Path: <linux-kernel+bounces-895565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A55C4E4A9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428093B533A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460D9308F14;
	Tue, 11 Nov 2025 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="E9q1R7m6"
Received: from sg-1-11.ptr.blmpb.com (sg-1-11.ptr.blmpb.com [118.26.132.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E8131283F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869680; cv=none; b=dvBKRiI7x4ca0rQlMLSkTrYPZreZvzyaokPEl9QzqTKEdIx6SbjtA8qzydctVTd0qqm0OeMLt9SdSrbTmX3jMhy5AcZCyx64OvBjMYfInjGxABqTLa5dOnng7kyaFDSufccsxFeSNJCCyz0W+YK/IEF1jUYjrozsTINDaarUInc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869680; c=relaxed/simple;
	bh=fYekhjUgmwCWq96nzBDP/OPSUfruHRfrdWzsn3FWX4E=;
	h=From:Date:In-Reply-To:References:Content-Type:Cc:Subject:
	 Message-Id:Mime-Version:To; b=u3Ua613E0a6gVGHC/QeiA7QCNJOHpY0UiMowq0R2Vzyp6ypSe4SFW5c1r3MIcN+yLMMzULJRgWFw+CzsdtKjOwqGPaWXslkwzdXOgf/8lCZ9SIFxP4Z6ngUoHtJaXYdSYph98ofRlSIXVInNwRnI4Q+weE4wut2+X5gquu8kcXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=E9q1R7m6; arc=none smtp.client-ip=118.26.132.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1762869671;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=HeiFAq8m+pszRxKRkfLlU5b+dRr3M5cAVbg7a9AKRAQ=;
 b=E9q1R7m6aC5YtNLfiZz3FSZOPhdCjXkg1NmduFrYFrhpM2aU3friK460i1qCoQHl5ZrQFT
 B0HlnbwKFGC897fig330b31fmXu1ZjTn4I2h2CbEnzJifNBoSM1j+Oe5CsbwP6siZd8Y9L
 k9DIxo4j1OY0YBmtoxK38M/R3S3odgSRaptr4+uFuI+rUXkWuABSxqMDZM05lG8R26LLG0
 3gvUTHLjtI/fy2oSRMOFY688I0oyvPyIhJeV739/r2ynEL1MDaFTZRO1ggSr3jR29CF2lU
 XtzJ0ROeKXicG3PXPvpvCqogCuI3/eWn5dreUQv1AUqktYGQ5e7ZgF2S8sSNfA==
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Tue, 11 Nov 2025 22:01:05 +0800
In-Reply-To: <20251110124920.1333561-1-zhengqixing@huaweicloud.com>
References: <20251110124920.1333561-1-zhengqixing@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: yukuai@fnnas.com
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.168]) by smtp.feishu.cn with ESMTPS; Tue, 11 Nov 2025 22:01:09 +0800
Organization: fnnas
X-Lms-Return-Path: <lba+2691341a5+3a356f+vger.kernel.org+yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
Cc: <linux-block@vger.kernel.org>, <nbd@other.debian.org>, 
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>, 
	<yangerkun@huawei.com>, <houtao1@huawei.com>, <zhengqixing@huawei.com>
Subject: Re: [PATCH] nbd: defer config unlock in nbd_genl_connect
Message-Id: <49872d86-3867-41eb-916e-4debf463cc60@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: "Zheng Qixing" <zhengqixing@huaweicloud.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>
Content-Transfer-Encoding: quoted-printable

=E5=9C=A8 2025/11/10 20:49, Zheng Qixing =E5=86=99=E9=81=93:

> There is one use-after-free warning when running NBD_CMD_CONNECT and
> NBD_CLEAR_SOCK:
>
> nbd_genl_connect
>    nbd_alloc_and_init_config // config_refs=3D1
>    nbd_start_device // config_refs=3D2
>    set NBD_RT_HAS_CONFIG_REF			open nbd // config_refs=3D3
>    recv_work done // config_refs=3D2
> 						NBD_CLEAR_SOCK // config_refs=3D1
> 						close nbd // config_refs=3D0
>    refcount_inc -> uaf
>
> ------------[ cut here ]------------
> refcount_t: addition on 0; use-after-free.
> WARNING: CPU: 24 PID: 1014 at lib/refcount.c:25 refcount_warn_saturate+0x=
12e/0x290
>   nbd_genl_connect+0x16d0/0x1ab0
>   genl_family_rcv_msg_doit+0x1f3/0x310
>   genl_rcv_msg+0x44a/0x790
>
> The issue can be easily reproduced by adding a small delay before
> refcount_inc(&nbd->config_refs) in nbd_genl_connect():
>
>          mutex_unlock(&nbd->config_lock);
>          if (!ret) {
>                  set_bit(NBD_RT_HAS_CONFIG_REF, &config->runtime_flags);
> +               printk("before sleep\n");
> +               mdelay(5 * 1000);
> +               printk("after sleep\n");
>                  refcount_inc(&nbd->config_refs);
>                  nbd_connect_reply(info, nbd->index);
>          }
>
> Fixes: e46c7287b1c2 ("nbd: add a basic netlink interface")
> Signed-off-by: Zheng Qixing<zhengqixing@huawei.com>
> ---
>   drivers/block/nbd.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

LGTM
Reviewed-by: Yu Kuai <yukuai@fnnas.com>

