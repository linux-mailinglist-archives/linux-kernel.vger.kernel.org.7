Return-Path: <linux-kernel+bounces-862940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB475BF6946
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128034206EE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09368333750;
	Tue, 21 Oct 2025 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ennZVufz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02D1333430
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051483; cv=none; b=Hp4IBHcZ0E3F//12lGd/RtHkq8NdtB2soG4dVgDMWNPBOW3voYM+FXF4DIc4V0Qud39Gy7Z0K6ftIL7MFZvxhmF9QXnaG4iyUXwXEHyb0BL+szAYWx1PBUlQX3U8VGDQgWjJQehg2Hc2KnX71yiZ736+SjRspiivksRrx1p+54Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051483; c=relaxed/simple;
	bh=FfcoUUoPUpOsa0VkWk/Dk1Pdl70TqifwXFfjdZWH8QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Osbv0XrEmWodNWQ45CCXTrvqwmm0GUqAQp9iBzgckVCJXPzWkfRafTzt+Nw5AgM0Bn6NY/A5jWGl8W20VMe7K4THvOEoqxh+QTVNiMcLbUBVD/F9MV68m0eWhBEf7yxAryVtPTt2J2OKahoBP/Eo/YctjfzUiMvfMUf7UPipdP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ennZVufz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DvdJq2dPLugSFjjKOvXm1LBOxtEu3BmwSDlhR75aYWo=;
	b=ennZVufzTaw4IacO4sd2yFL39GW1ECc6v0+O8cOerzUWmQGa7TB1r5QQEtVtGswz8+j9or
	JVymNwLGut3CDYEKLJa5Rp510D+0sss8U10jiH7eN4NuWrwQsUU9bDwJDbf1Bqm1Tysuiz
	2zazBzDO2lIX1OldnHHndtM4/ZifV6k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-fdwnUsLfOBmTA5JrgmE66w-1; Tue, 21 Oct 2025 08:57:58 -0400
X-MC-Unique: fdwnUsLfOBmTA5JrgmE66w-1
X-Mimecast-MFC-AGG-ID: fdwnUsLfOBmTA5JrgmE66w_1761051477
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47114018621so27816145e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051477; x=1761656277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvdJq2dPLugSFjjKOvXm1LBOxtEu3BmwSDlhR75aYWo=;
        b=cAugL6p9V/DlrRCUy09XQ6tobbe+QOP0M6jXQDq1koAnwsLIiC3GvDIOZ579/73u1p
         Rc4iNC901EOVdnKpCgib0AY7hDoMVXHKpZ4dUaxzCF28pZG/ikvYVtgKYOW2wJp2DjG4
         XpsMRiZ2h0PbmZNnFCCzMZMvsjDyFYlBQ0NXMUvBVgGkxsiZsUQEYuMcHSYDEcQx/Ium
         aMP+zNWrxLLt7utH9VbMl9nOg195OsVNY68Y/kNK3xYuVc5KfuhMpxD7J3opSNSrawBn
         LRCnHpkOc0MpmIBK3XQ8WQi6ME49Ebayi/0gn2ZjSMpi8HiDoO9DNIHBOFzukZXr307B
         Livg==
X-Forwarded-Encrypted: i=1; AJvYcCXDr9gs9m333gEMhLm8XIs/zQzFxFJBqnOTuJSYfGIiVHWcbG1ZTzvMNjrBySbxYUEStCo6Zh8CC6/YXSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE5KiBKRFbae5KxECLGR3+73/I6zQMfW+m5MAW/EnxktBStZsa
	k1zdhNQLALRSYrUF99Akx0zkX7FW52d9RABZHflGDYwUodWkG/iVJYRp4hFVrrcu7WbIWe2TZLt
	vv6DrU+CGz7mUxaxJ6y5GFM3v80rU2OD0e4jLFe6D7E9ewf101MDet00duCmdQaSS5w==
X-Gm-Gg: ASbGnctSjzwVtHJGu1LrHmMIZej3yXj8lQIOAq+b3yVyFM62ayLmXElPAN61NZL5aTW
	eA6AL8frc6fTlby2z8vYGHrtuBRzztawq1QLApCv+3vWEWjKzMhUUzaslXmG7u+RxIeKxJ3gLNn
	UF2h68Qbl6ASb5oOPdQ4q/echaEFv35zmcXxTYLd0uK+DGJpqMJNmkonVP/lw80tWWVPjVDJnSB
	08dcABjjzPckVZUh3L5jZBOQDYkMbIUye74BLtLiBTM6Z+1NQDYeEqsx2dFsNCAHv/Efw+3feiB
	KPsVDa+aLC2h7dtkoDF3oqoeYUDPMvgvuxSQJqka+lodT9rjA7oSj3OFk4ChwilgwQQy
X-Received: by 2002:a05:600c:198d:b0:46e:3c29:ce9d with SMTP id 5b1f17b1804b1-4711791c57bmr139775065e9.32.1761051476908;
        Tue, 21 Oct 2025 05:57:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMQOVxMDKEqgOB4aV0YZaSaGuRZMfduYN5i5pIKMunnPmVy9cLSdbbEF1RTdTSlw3qu+1DNA==
X-Received: by 2002:a05:600c:198d:b0:46e:3c29:ce9d with SMTP id 5b1f17b1804b1-4711791c57bmr139774785e9.32.1761051476400;
        Tue, 21 Oct 2025 05:57:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d3843csm195088345e9.11.2025.10.21.05.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:57:55 -0700 (PDT)
Date: Tue, 21 Oct 2025 08:57:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cong Zhang <cong.zhang@oss.qualcomm.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	pavan.kondeti@oss.qualcomm.com
Subject: Re: [PATCH] virtio_blk: NULL out vqs to avoid double free on failed
 resume
Message-ID: <20251021085030-mutt-send-email-mst@kernel.org>
References: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com>

On Tue, Oct 21, 2025 at 07:07:56PM +0800, Cong Zhang wrote:
> The vblk->vqs releases during freeze. If resume fails before vblk->vqs
> is allocated, later freeze/remove may attempt to free vqs again.
> Set vblk->vqs to NULL after freeing to avoid double free.
> 
> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> ---
> The patch fixes a double free issue that occurs in virtio_blk during
> freeze/resume.
> The issue is caused by:
> 1. During the first freeze, vblk->vqs is freed but pointer is not set to
>    NULL.
> 2. Virtio block device fails before vblk->vqs is allocated during resume.
> 3. During the next freeze, vblk->vqs gets freed again, causing the
>    double free crash.

this part I don't get. if restore fails, how can freeze be called
again?

> ---
>  drivers/block/virtio_blk.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index f061420dfb10c40b21765b173fab7046aa447506..746795066d7f56a01c9a9c0344d24f9fa06841eb 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1026,8 +1026,13 @@ static int init_vq(struct virtio_blk *vblk)
>  out:
>  	kfree(vqs);
>  	kfree(vqs_info);
> -	if (err)
> +	if (err) {
>  		kfree(vblk->vqs);
> +		/*
> +		 * Set to NULL to prevent freeing vqs again during freezing.
> +		 */
> +		vblk->vqs = NULL;
> +	}
>  	return err;
>  }
>  

> @@ -1598,6 +1603,12 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
>  
>  	vdev->config->del_vqs(vdev);
>  	kfree(vblk->vqs);
> +	/*
> +	 * Set to NULL to prevent freeing vqs again after a failed vqs
> +	 * allocation during resume. Note that kfree() already handles NULL
> +	 * pointers safely.
> +	 */
> +	vblk->vqs = NULL;
>  
>  	return 0;
>  }
> 
> ---
> base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
> change-id: 20250926-virtio_double_free-7ab880d82a17
> 
> Best regards,
> -- 
> Cong Zhang <cong.zhang@oss.qualcomm.com>


