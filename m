Return-Path: <linux-kernel+bounces-877441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D387CC1E1ED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0600A189A24F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE8A303C9A;
	Thu, 30 Oct 2025 02:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="FaTThvYE"
Received: from sg-1-14.ptr.blmpb.com (sg-1-14.ptr.blmpb.com [118.26.132.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398C617A2F6
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761791061; cv=none; b=Tk1oxbvccgv8t7ob7OdUO71HhUeY2nsW7qpMtx1QOt6TxpYOEuFRu9v6mELZvFJCXp9Upci4f9tm9BJ0VL3tEEYdG9q+VzLfGL1rEeeFK+H2Nojq4SKcRCJ0DZorSEmzmLKxFRHcQgf0Lj/wblgoGwzVE0lDE57nM2MqbPsyXkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761791061; c=relaxed/simple;
	bh=8T1NZtdERi3glLVs0OfkU5E5R9xt8iw3yd4AmOM7q+s=;
	h=Mime-Version:Content-Type:Message-Id:Date:In-Reply-To:References:
	 To:Cc:From:Subject; b=EoQt9BuKHFJs7D6y5ptoIgMmZnE+521XJ2B13V/H4QAHzIYt2hKj0lfJeLlcs9NtJYGjePVFNb3vRdcQ7d5bSYyW35cmT/7OMk5KD0Pxr4LKUXKy/uEeZFeEcDqodap0lZiJlinRLiPAbVpGHD9qL3wlyd0zbrrH+Z3jb2QVikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=FaTThvYE; arc=none smtp.client-ip=118.26.132.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1761791049;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=AEZ2trUioNfgZa8wwN5unpFskfe2YlsQ3FyT5CgCRG0=;
 b=FaTThvYEXLNNDapjMQ2w3fiKds/NfbCKI1iFCm1rUYW0CmKtRJPREMCdp/krmLNs5FUfwn
 a4kxDrcUBftcDAg6YbdVqpiiP6Bus4CWEy6mVTZfQIn6qc8mbZv1bwWZoNTSpyydiV6/dY
 a1KqIwOB/76PjWXL/m75teMlNygX1HPDKdtgi848rn2k6/3a0vCfeyBEpziNAFGItffUkF
 7O1dxaE/sMhDBUUbK38rq+w/Lm9EP6BFQs3kRJWTrqGuF3YyRGfPb2qLxi0E1V3wrnNDGW
 G23EBQzHkQTjQPSHs1bZz2cuF7MhKhurLar7KJXTXFWm8GMMVkbfINQXqvV1TQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <177e7ee6-69c7-4809-86bc-e0a4094a6672@fnnas.com>
Date: Thu, 30 Oct 2025 10:24:05 +0800
In-Reply-To: <20251027150433.18193-4-k@mgml.me>
References: <20251027150433.18193-1-k@mgml.me> <20251027150433.18193-4-k@mgml.me>
To: "Kenta Akagi" <k@mgml.me>, "Song Liu" <song@kernel.org>, 
	"Shaohua Li" <shli@fb.com>, "Mariusz Tkaczyk" <mtkaczyk@kernel.org>, 
	"Guoqing Jiang" <jgq516@gmail.com>
Cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCH v5 03/16] md: add pers->should_error() callback
Received: from [192.168.1.104] ([39.182.0.168]) by smtp.feishu.cn with ESMTPS; Thu, 30 Oct 2025 10:24:07 +0800
X-Lms-Return-Path: <lba+26902cc48+503080+vger.kernel.org+yukuai@fnnas.com>
Reply-To: yukuai@fnnas.com
Content-Transfer-Encoding: quoted-printable
X-Original-From: Yu Kuai <yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird

Hi,

=E5=9C=A8 2025/10/27 23:04, Kenta Akagi =E5=86=99=E9=81=93:
> The failfast feature in RAID1 and RAID10 assumes that when md_error() is
> called, the array remains functional because the last rdev neither fails
> nor sets MD_BROKEN.
>
> However, the current implementation can cause the array to lose
> its last in-sync device or be marked as MD_BROKEN, which breaks the
> assumption and can lead to array failure.
>
> To address this issue, a new handler md_cond_error() will be introduced
> to ensure that failfast I/O does not mark the array as broken.
>
> As preparation, this commit adds a helper pers->should_error() to determi=
ne
> from outside the personality whether an rdev can fail safely, which is
> needed by md_cond_error().
>
> Signed-off-by: Kenta Akagi <k@mgml.me>
> ---
>   drivers/md/md.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index c982598cbf97..01c8182431d1 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -763,6 +763,7 @@ struct md_personality
>   	 * if appropriate, and should abort recovery if needed
>   	 */
>   	void (*error_handler)(struct mddev *mddev, struct md_rdev *rdev);
> +	bool (*should_error)(struct mddev *mddev, struct md_rdev *rdev, struct =
bio *bio);

I think the name is not quite accurate, perhaps error_handler_check()?

Thanks,
Kuai

>   	int (*hot_add_disk) (struct mddev *mddev, struct md_rdev *rdev);
>   	int (*hot_remove_disk) (struct mddev *mddev, struct md_rdev *rdev);
>   	int (*spare_active) (struct mddev *mddev);

