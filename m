Return-Path: <linux-kernel+bounces-891457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA811C42B37
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 11:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D05B3A7ED4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 10:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFAF2FCC02;
	Sat,  8 Nov 2025 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="yNCLu1WE"
Received: from sg-1-35.ptr.blmpb.com (sg-1-35.ptr.blmpb.com [118.26.132.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCB72FC892
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762597370; cv=none; b=VrrhzYDb3BdGcxr0icCd5NuDMkv3wO9fxUHQRBa3J9tvwHEzTn8O6hX1TDkV6cIulzUhgzTmnapsDeJ3vxE9rk/FdQFKD8Sp3jBTtmsNvwW0/Bva18P/rk8Bs1/erVtiLpYgNFif2QfNc7pbLpqwCSV+4snPnM2mxFPn4vp/P2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762597370; c=relaxed/simple;
	bh=JoBZavFCCxTvlrMZTQP/hAhs21WN1Kpt51V/EodQKHQ=;
	h=Content-Type:References:Subject:Date:Mime-Version:In-Reply-To:To:
	 Cc:Message-Id:From; b=VafnKaVtDoA0zAO75NEIPoRp3pH3iMrPPOBjTqdjs43/o9NExsVkMZnACJFW4RuAKszrR4OPZQqdhVtRqePrWWUHIJKIGkMkQwSNytN73S6AkC1DQbNsXtX30GYQjN3U/+iWDrvaW7rrY3Ml/B4v6zpypawbczQzCBSIzSgCvao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=yNCLu1WE; arc=none smtp.client-ip=118.26.132.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1762597356;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=9a61HwnNpu5hLvKfMcH90SGw2/7Tq55lO1G4LP3sqm4=;
 b=yNCLu1WEitB8ArVuhhNm4Udw7QBig3/fIdIxo4EcVSTKjn/MFmYpoP7LGvYMsMSvFPLYiD
 j5VXHaNDbbWRae6FI/Cbt5fb2L1gngqpV+5ZJVMg3MKoncr9eXDzcJs4E407TO0rSSJvtI
 7qARcOFepnwwdRNapZKE5ZT+jd1CnPIbwFbMLu3ibofE2mrdvMBRLkO+ooPnjePVpthrvy
 d2Po/gr4SRMaAu/ZSJpObeAjFDPcgsMHL7dQ1nJR6xyV0xNaKQUn71g4B95ZhaqukDEpme
 zKottDy4esTVT9c9MKZp8hjrAXj56dlygtKcCYSzV7rjsUQw127BO59syIL7fw==
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: quoted-printable
References: <20251106115935.2148714-1-linan666@huaweicloud.com> <20251106115935.2148714-7-linan666@huaweicloud.com>
Subject: Re: [PATCH v2 06/11] md: remove MD_RECOVERY_ERROR handling and simplify resync_offset update
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Date: Sat, 8 Nov 2025 18:22:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+2690f19ea+db4e83+vger.kernel.org+yukuai@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.168]) by smtp.feishu.cn with ESMTPS; Sat, 08 Nov 2025 18:22:33 +0800
In-Reply-To: <20251106115935.2148714-7-linan666@huaweicloud.com>
To: <linan666@huaweicloud.com>, <song@kernel.org>, <neil@brown.name>, 
	<namhyung@gmail.com>
Cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<xni@redhat.com>, <k@mgml.me>, <yangerkun@huawei.com>, 
	<yi.zhang@huawei.com>, <yukuai@fnnas.com>
Message-Id: <c4b15e44-bb02-415e-8f7f-75db2ae2edca@fnnas.com>
Reply-To: yukuai@fnnas.com
From: "Yu Kuai" <yukuai@fnnas.com>

Hi,

=E5=9C=A8 2025/11/6 19:59, linan666@huaweicloud.com =E5=86=99=E9=81=93:
> From: Li Nan <linan122@huawei.com>
>
> When sync IO failed and setting badblock also failed, unsynced disk
> might be kicked via setting 'recovery_disable' without Faulty flag.
> MD_RECOVERY_ERROR was set in md_sync_error() to prevent updating
> 'resync_offset', avoiding reading the failed sync sectors.
>
> Previous patch ensures disk is marked Faulty when badblock setting fails.
> Remove MD_RECOVERY_ERROR handling as it's no longer needed - failed sync
> sectors are unreadable either via badblock or Faulty disk.
>
> Simplify resync_offset update logic.
>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/md.h |  2 --
>   drivers/md/md.c | 23 +++++------------------
>   2 files changed, 5 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 18621dba09a9..c5b5377e9049 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -644,8 +644,6 @@ enum recovery_flags {
>   	MD_RECOVERY_FROZEN,
>   	/* waiting for pers->start() to finish */
>   	MD_RECOVERY_WAIT,
> -	/* interrupted because io-error */
> -	MD_RECOVERY_ERROR,
>  =20
>   	/* flags determines sync action, see details in enum sync_action */
>  =20
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 2bdbb5b0e9e1..71988d8f5154 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8949,7 +8949,6 @@ void md_sync_error(struct mddev *mddev)
>   {
>   	// stop recovery, signal do_sync ....
>   	set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> -	set_bit(MD_RECOVERY_ERROR, &mddev->recovery);
>   	md_wakeup_thread(mddev->thread);
>   }
>   EXPORT_SYMBOL(md_sync_error);
> @@ -9603,8 +9602,8 @@ void md_do_sync(struct md_thread *thread)
>   	wait_event(mddev->recovery_wait, !atomic_read(&mddev->recovery_active)=
);
>  =20
>   	if (!test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
> -	    !test_bit(MD_RECOVERY_INTR, &mddev->recovery) &&

Why the above checking is removed?

Thanks,
Kuai

>   	    mddev->curr_resync >=3D MD_RESYNC_ACTIVE) {
> +		/* All sync IO completes after recovery_active becomes 0 */
>   		mddev->curr_resync_completed =3D mddev->curr_resync;
>   		sysfs_notify_dirent_safe(mddev->sysfs_completed);
>   	}
> @@ -9612,24 +9611,12 @@ void md_do_sync(struct md_thread *thread)
>  =20
>   	if (!test_bit(MD_RECOVERY_CHECK, &mddev->recovery) &&
>   	    mddev->curr_resync > MD_RESYNC_ACTIVE) {
> +		if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery))
> +			mddev->curr_resync =3D MaxSector;
> +
>   		if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery)) {
> -			if (test_bit(MD_RECOVERY_INTR, &mddev->recovery)) {
> -				if (mddev->curr_resync >=3D mddev->resync_offset) {
> -					pr_debug("md: checkpointing %s of %s.\n",
> -						 desc, mdname(mddev));
> -					if (test_bit(MD_RECOVERY_ERROR,
> -						&mddev->recovery))
> -						mddev->resync_offset =3D
> -							mddev->curr_resync_completed;
> -					else
> -						mddev->resync_offset =3D
> -							mddev->curr_resync;
> -				}
> -			} else
> -				mddev->resync_offset =3D MaxSector;
> +			mddev->resync_offset =3D mddev->curr_resync;
>   		} else {
> -			if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery))
> -				mddev->curr_resync =3D MaxSector;
>   			if (!test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
>   			    test_bit(MD_RECOVERY_RECOVER, &mddev->recovery)) {
>   				rcu_read_lock();

