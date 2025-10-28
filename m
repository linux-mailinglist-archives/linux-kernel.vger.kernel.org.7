Return-Path: <linux-kernel+bounces-873732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ED450C148CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A19DD352B38
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE87532B9A2;
	Tue, 28 Oct 2025 12:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="nXdbxDQ2"
Received: from sg-1-18.ptr.blmpb.com (sg-1-18.ptr.blmpb.com [118.26.132.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEAA328636
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653563; cv=none; b=oeFWFZw5Gi87mapQU7FiubXvZC+DlK4aP/59LjRQKFCRVK5GwclRr/I+sH8RxK+1jCGvpwgKZh+nVLwrl6WupcWaXB5wiaopxPciMtS3GaLO000FO4VxHuVl9q2QJACJtGahL0cY2zZbOcJetS7yItDLumqESwBeYFbMOESHQlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653563; c=relaxed/simple;
	bh=VHWMyh+dNeS7BtojdmRX1nPfTRSvy/CcULphApk7kp4=;
	h=Message-Id:To:Date:Mime-Version:References:From:Cc:Subject:
	 Content-Type:In-Reply-To; b=Z686ndhyyr64nTflzE9y44+1QKSVPZeAKWE3kfu3zeUMYzkUw0fEYxeOhlgYZdQ4jbMK5eOli81HiLWuBzkr456vqP3TkEhYvFlt/nAkQgJMlB3gey0n2JWfo0s1HxBLLDdkh8KWRPTzgCk3aweqsUZj4I5NBkxIDHZNPnKOsq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=nXdbxDQ2; arc=none smtp.client-ip=118.26.132.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1761653553;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=giOIBPqQRzHEKUfrCcJhqjbXIb2PCt2QXcLYfGYvyaE=;
 b=nXdbxDQ2ijSWjtZ/OzbojwXkQnhFrq1Ekia2LIzdq6CMavaFI3RZ/QQM2BV3oBZfHfy/Pm
 yLceT7D1UA3B/lsGSVV6CxfN2/5/ZpCmhCRvKzzP76B13TVnlMNwNJG+x5fJXdBj9Pn5g8
 uRm2KjlSitEgwIVZQJ9zvgyYruMTe+MVPoLexrJIGUdGsEBZPB9nhNTDu4uZ4dnBdSDo04
 72klgAValLCyAXQT5mzt/rI0rT6RWY/Dgz4ioegur8Dvm2xkE5yU/1e8Kk2xopCTOLMQva
 yWMCuVcz7PraruoaiibES25yQKlETGuewiJAwPRdcmiGCF00AnAVe+dFSkrMnw==
Message-Id: <effbcb62-9bf7-45ff-ad39-1e3be1e63650@fnnas.com>
X-Lms-Return-Path: <lba+26900b32f+d46e72+vger.kernel.org+yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
To: <linan122@huawei.com>, <corbet@lwn.net>, <song@kernel.org>, 
	<hare@suse.de>, <xni@redhat.com>
Date: Tue, 28 Oct 2025 20:12:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251027072915.3014463-1-linan122@huawei.com> <20251027072915.3014463-4-linan122@huawei.com>
User-Agent: Mozilla Thunderbird
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.168]) by smtp.feishu.cn with ESMTPS; Tue, 28 Oct 2025 20:12:30 +0800
From: "Yu Kuai" <yukuai@fnnas.com>
Cc: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-raid@vger.kernel.org>, <linan666@huaweicloud.com>, 
	<yangerkun@huawei.com>, <yi.zhang@huawei.com>, <yukuai@fnnas.com>
Subject: Re: [PATCH v7 3/4] md/raid0: Move queue limit setup before r0conf initialization
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20251027072915.3014463-4-linan122@huawei.com>
Reply-To: yukuai@fnnas.com

Hi,

=E5=9C=A8 2025/10/27 15:29, linan122@huawei.com =E5=86=99=E9=81=93:
> From: Li Nan <linan122@huawei.com>
>
> Prepare for making logical blocksize configurable.
>
> Move raid0_set_limits() before create_strip_zones(). It is safe as fields
> modified in create_strip_zones() do not involve mddev configuration, and
> rdev modifications there are not used in raid0_set_limits().
>
> 'blksize' in create_strip_zones() fetches mddev's logical block size. Thi=
s
> change has no impact until logical block size becomes configurable.
>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/raid0.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index e443e478645a..49477b560cc9 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -68,7 +68,7 @@ static int create_strip_zones(struct mddev *mddev, stru=
ct r0conf **private_conf)
>   	struct strip_zone *zone;
>   	int cnt;
>   	struct r0conf *conf =3D kzalloc(sizeof(*conf), GFP_KERNEL);
> -	unsigned blksize =3D 512;
> +	unsigned int blksize =3D queue_logical_block_size(mddev->gendisk->queue=
);
>  =20
>   	*private_conf =3D ERR_PTR(-ENOMEM);
>   	if (!conf)

I think the following setting of blksize can be removed as well.

blksize =3D max(blksize, ...)

Thanks,
Kuai

> @@ -405,6 +405,12 @@ static int raid0_run(struct mddev *mddev)
>   	if (md_check_no_bitmap(mddev))
>   		return -EINVAL;
>  =20
> +	if (!mddev_is_dm(mddev)) {
> +		ret =3D raid0_set_limits(mddev);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	/* if private is not null, we are here after takeover */
>   	if (mddev->private =3D=3D NULL) {
>   		ret =3D create_strip_zones(mddev, &conf);
> @@ -413,11 +419,6 @@ static int raid0_run(struct mddev *mddev)
>   		mddev->private =3D conf;
>   	}
>   	conf =3D mddev->private;
> -	if (!mddev_is_dm(mddev)) {
> -		ret =3D raid0_set_limits(mddev);
> -		if (ret)
> -			return ret;
> -	}
>  =20
>   	/* calculate array device size */
>   	md_set_array_sectors(mddev, raid0_size(mddev, 0, 0));

