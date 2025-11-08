Return-Path: <linux-kernel+bounces-891448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7156FC42AFA
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 11:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F97188DBF8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 10:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE810262FD1;
	Sat,  8 Nov 2025 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="BpmDX+tv"
Received: from sg-1-23.ptr.blmpb.com (sg-1-23.ptr.blmpb.com [118.26.132.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290422AD04
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762596489; cv=none; b=sMmvttoP54wmrwtW/U2vh6UZ3ZGX+Rdz6TtXyn6AJCkRZXz2r5Bc9ejMedNTxsKL03z4eUZ4QkyhS47e6uCmEJnf16fRGaV9wXau/ai78GQMCCSMhQac+43Hn0hQW93V46U/cbeNaZpGpmdIlvqicHr8JsCXuFel2QQ3KFS4/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762596489; c=relaxed/simple;
	bh=Lw5ILlvTxG2CK+YSgKzP1fA1X2y6TE3oxqasFMfUSW8=;
	h=Date:Message-Id:From:Subject:Mime-Version:In-Reply-To:References:
	 Content-Type:To:Cc; b=WBQobJwhIR1UVbEyDeOWYOp8skf8dQcivTkWPKMLCRSInWinde5ZIWOB+G2Z450FpB6bRyTehVWD/sVKuh3pVyHJpLpzrWKddNilfuCPAFDE4RXe6yBOkqHzBmwvCAFqHi2SiiUpLtZfHhyfQ48jQYYmuYrXCHVxzaw8Edx0VM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=BpmDX+tv; arc=none smtp.client-ip=118.26.132.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1762596474;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=BWnF/6Egu2STjvjZkL3IKBB7xYSgVAvXJ6zLtjB8WYw=;
 b=BpmDX+tvdI5OP4zEU8ZdL85X2b7peGuSb/y4yx4FqG+UNZ0V9NYJMsfSfeIWSkOQ/00Gdp
 UpROGTCWY581wzIYIQfgDy6rAbbPqgbpvmm8jM6M+Kqsp7BIVms6X3KKtAnSRmODTlFF5g
 uHc24Uw5CjzoviM3PEKcYm+RVlxuXcjejGNjXY6kal+1UmzX0Kho652BWsTPtSCIot0R97
 JjZIyOl9M3bripLqIjt+mEXjzNUyuNVnR17tIL+LHqVloc9gVvxEPBhhQF+grCBDwxSiqy
 xlr1beMZBi8oMtfuigEs1HU77JdelT5djfzrfrepvHmrholEyxN2AdtEYWX4iA==
Date: Sat, 8 Nov 2025 18:07:50 +0800
X-Lms-Return-Path: <lba+2690f1678+b16bc7+vger.kernel.org+yukuai@fnnas.com>
Message-Id: <63857ce2-0521-4f38-b3d4-d95c8eafc175@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCH v2 03/11] md/raid1,raid10: return actual write status in narrow_write_error
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20251106115935.2148714-4-linan666@huaweicloud.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
References: <20251106115935.2148714-1-linan666@huaweicloud.com> <20251106115935.2148714-4-linan666@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: yukuai@fnnas.com
To: <linan666@huaweicloud.com>, <song@kernel.org>, <neil@brown.name>, 
	<namhyung@gmail.com>
Cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<xni@redhat.com>, <k@mgml.me>, <yangerkun@huawei.com>, 
	<yi.zhang@huawei.com>, <yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
Received: from [192.168.1.104] ([39.182.0.168]) by smtp.feishu.cn with ESMTPS; Sat, 08 Nov 2025 18:07:51 +0800
Content-Transfer-Encoding: quoted-printable

Hi,

=E5=9C=A8 2025/11/6 19:59, linan666@huaweicloud.com =E5=86=99=E9=81=93:
> From: Li Nan <linan122@huawei.com>
>
> narrow_write_error() currently returns true when setting badblocks fails.
> Instead, return actual status of all retried writes, succeeding only when
> all retried writes complete successfully. This gives upper layers accurat=
e
> information about write outcomes.
>
> When setting badblocks fails, mark the device as faulty and return at onc=
e.
> No need to continue processing remaining sections in such cases.
>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/raid1.c  | 17 +++++++++--------
>   drivers/md/raid10.c | 15 +++++++++------
>   2 files changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index e65d104cb9c5..090fe8f71224 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -2541,11 +2541,15 @@ static bool narrow_write_error(struct r1bio *r1_b=
io, int i)
>   		bio_trim(wbio, sector - r1_bio->sector, sectors);
>   		wbio->bi_iter.bi_sector +=3D rdev->data_offset;
>  =20
> -		if (submit_bio_wait(wbio) < 0)
> +		if (submit_bio_wait(wbio)) {
>   			/* failure! */
> -			ok =3D rdev_set_badblocks(rdev, sector,
> -						sectors, 0)
> -				&& ok;
> +			ok =3D false;
> +			if (!rdev_set_badblocks(rdev, sector, sectors, 0)) {
> +				md_error(mddev, rdev);
> +				bio_put(wbio);
> +				break;
> +			}
> +		}
>  =20
>   		bio_put(wbio);
>   		sect_to_write -=3D sectors;
> @@ -2596,10 +2600,7 @@ static void handle_write_finished(struct r1conf *c=
onf, struct r1bio *r1_bio)
>   			 * errors.
>   			 */
>   			fail =3D true;
> -			if (!narrow_write_error(r1_bio, m))
> -				md_error(conf->mddev,
> -					 conf->mirrors[m].rdev);
> -				/* an I/O failed, we can't clear the bitmap */
> +			narrow_write_error(r1_bio, m);

Now that return value is not used, you can make this helper void.

Thanks,
Kuai

>   			rdev_dec_pending(conf->mirrors[m].rdev,
>   					 conf->mddev);
>   		}
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 231177cee928..9c43c380d7e8 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -2820,11 +2820,15 @@ static bool narrow_write_error(struct r10bio *r10=
_bio, int i)
>   				   choose_data_offset(r10_bio, rdev);
>   		wbio->bi_opf =3D REQ_OP_WRITE;
>  =20
> -		if (submit_bio_wait(wbio) < 0)
> +		if (submit_bio_wait(wbio)) {
>   			/* Failure! */
> -			ok =3D rdev_set_badblocks(rdev, wsector,
> -						sectors, 0)
> -				&& ok;
> +			ok =3D false;
> +			if (!rdev_set_badblocks(rdev, wsector, sectors, 0)) {
> +				md_error(mddev, rdev);
> +				bio_put(wbio);
> +				break;
> +			}
> +		}
>  =20
>   		bio_put(wbio);
>   		sect_to_write -=3D sectors;
> @@ -2936,8 +2940,7 @@ static void handle_write_completed(struct r10conf *=
conf, struct r10bio *r10_bio)
>   				rdev_dec_pending(rdev, conf->mddev);
>   			} else if (bio !=3D NULL && bio->bi_status) {
>   				fail =3D true;
> -				if (!narrow_write_error(r10_bio, m))
> -					md_error(conf->mddev, rdev);
> +				narrow_write_error(r10_bio, m);
>   				rdev_dec_pending(rdev, conf->mddev);
>   			}
>   			bio =3D r10_bio->devs[m].repl_bio;

