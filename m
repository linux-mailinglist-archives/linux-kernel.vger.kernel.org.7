Return-Path: <linux-kernel+bounces-862495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DD3BF575D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF1918A6265
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431BD2E1C6F;
	Tue, 21 Oct 2025 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPzqLSp1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75E4324B21
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038205; cv=none; b=Dt1/oVQLRHnFKOJTUpXIAR5mM6u/UOXaJDvtaLjfohoeYXZhBY+vm095VqyrgeAerixCbSjr2KrK90ehXchGm3g6d4XL1DrLmAUzYiuDx3UHqlpRj4sK9A3OBJE6F8eYTAajtXJh+JmjbyX85iyazifNxYuyDbMUtO2qHZiiZJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038205; c=relaxed/simple;
	bh=8LQ/nb9TyND2NxmnDu4kFEGAHzYL+AlzQNRURq4dY1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dshOXiTL/tU/fOZhLQrUIhFf88oXp+YD6eC/LjBs5hw+izmM5327ME9oM2pOFWv3NmVOZFSAG0ksH3C4lLrMdNGXB3jmgv9Z1Hf4biyZjDIvJ2Cf8Rk7Vabrvlr/Fdud8VP8eOaLGkm6GrgPu1pVWijJ4E3/Az30fl2RqF+dROw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bPzqLSp1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761038202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JwhZk0idClOTokwdt1kB9ie+33phkwv0ROh+5vx+wgc=;
	b=bPzqLSp1yWuIm91GAVViKb95lw1FRwOtja3UySW039vmeRVPzmyRUGD44YAjnuV73thRdR
	gvVl0X25Y71NVOHJcttVlPvC4zKu/rFQ004izzNf1lfpzemUjaYE5C0GVeIlffTk4UlGP4
	F+JH6Tni/MesrsnBgSUONyW+mE25gwU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-GphpKuhbNVOj4fspcdUvIA-1; Tue, 21 Oct 2025 05:16:41 -0400
X-MC-Unique: GphpKuhbNVOj4fspcdUvIA-1
X-Mimecast-MFC-AGG-ID: GphpKuhbNVOj4fspcdUvIA_1761038200
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f7b5c27d41so3200354f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038200; x=1761643000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwhZk0idClOTokwdt1kB9ie+33phkwv0ROh+5vx+wgc=;
        b=pFd4mIjOZ9FKQ+hW0/e2lNb6Sv+SJ9jilGD3if/r7wIi4kPzorPi2CNhAYkt+i5cFi
         ED/Bnzn981z7rZIiqPSo1HB2pDR5rzcWxmL1gZUO0+dCpMJeKa8dx26njSC+BhzHuafr
         O53XUKMK4yfA6lS4pRXVSzc3uEB+wupf5/eJmv7tZ0dNnhg/y3vrj/YjcJsA2sVvQOVp
         sgmjXmgeljhrcKWvF3vw+rlT7pj0M6xtaQEH9N6jcyzdtu2P0kYTRfAsOL2Ibd2XKk1L
         GJCfba2FaBcVVYjtt8eC1PsvcHI2oHKRI7k98SoH6VjBI6sPIF1WCdqy5RCMSGUJ77Ms
         Dq5w==
X-Gm-Message-State: AOJu0Yzv6tQVPsVDaH1Z0cCJzR0u8Z3Xn6IiWTi+ShdYOo9Ct7LMQ+Oi
	b6JYfapX2Wjt6W9nrrDsxyzYtrSf6Gwk9DX8ArPrZH+rUpL7tdvNnzskVmINBJlbRGJjjGT7smW
	XN30h2QiBDcC1q0YiJ2sQb4qJYygxveC81qvS3PsXTTmh3Aivlh+ShZHfJsddINtdjQ==
X-Gm-Gg: ASbGncskmC22lMkGOZ7EiBrAj8/AxciiJxW4paA4xToOiiezS/q2XFElZcPfmL4b7U3
	a1PT5BIT2P1JAzcjij3m5UM5xVu7VklVCipZpSfq4BKxS52yOqUjauV1nvccY1C3NZkFfBe0lWy
	QXilXFC9aWodLRdNMl8cuS9VWSb6+asG+qGnyor8Gdo2QWZnorWUBJDdQ5fqxhDpk9/ueGYS16v
	+pBJMjnsmxjupzrhkQCxtbO+f6mkF6WWkcvvp830jM+wmbe3xLL1BEsEt2A6PJWJFKuQfw/gSZG
	gHSYXt9ZfVrVEuRc7djYab1+ddG2m4il1d0r0Q+F5T9RUDmnTowGKJhF7/NRni3A5gxuamWd7lA
	v+7Lw+iR1hAp5+ZulSxosF2uafCahF6rIwL5MGN/heQX6qnY=
X-Received: by 2002:a05:6000:4b08:b0:427:55e:9a50 with SMTP id ffacd0b85a97d-427055e9a5fmr14239056f8f.22.1761038199791;
        Tue, 21 Oct 2025 02:16:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7KVV1+IVlCnxGJa+IEfd9KjImXec2CvlmcZyIJuKYZXgdCm3LfUWHQiFa8o4QTz6lM+WKlA==
X-Received: by 2002:a05:6000:4b08:b0:427:55e:9a50 with SMTP id ffacd0b85a97d-427055e9a5fmr14239037f8f.22.1761038199343;
        Tue, 21 Oct 2025 02:16:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4283e7804f4sm17338241f8f.10.2025.10.21.02.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:16:38 -0700 (PDT)
Message-ID: <1674cec4-4270-43e9-ba32-07d058a79b56@redhat.com>
Date: Tue, 21 Oct 2025 11:16:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v02 1/6] hinic3: Add PF framework
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Markus.Elfring@web.de, pavan.chebbi@broadcom.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>,
 Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>
References: <cover.1760685059.git.zhuyikai1@h-partners.com>
 <beb30a91e7d26245e3736285fe4ceb52d4f9c418.1760685059.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <beb30a91e7d26245e3736285fe4ceb52d4f9c418.1760685059.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 10:30 AM, Fan Gong wrote:
> @@ -431,11 +436,40 @@ static int hinic3_init_comm_ch(struct hinic3_hwdev *hwdev)
>  
>  static void hinic3_uninit_comm_ch(struct hinic3_hwdev *hwdev)
>  {
> +	hinic3_set_pf_status(hwdev->hwif, HINIC3_PF_STATUS_INIT);
>  	hinic3_free_cmdqs_channel(hwdev);
>  	hinic3_set_func_svc_used_state(hwdev, COMM_FUNC_SVC_T_COMM, 0);
>  	free_base_mgmt_channel(hwdev);
>  }
>  
> +static void hinic3_auto_sync_time_work(struct work_struct *work)
> +{
> +	struct delayed_work *delay = to_delayed_work(work);
> +	struct hinic3_hwdev *hwdev;
> +
> +	hwdev = container_of(delay, struct hinic3_hwdev, sync_time_task);
> +	queue_delayed_work(hwdev->workq, &hwdev->sync_time_task,
> +			   msecs_to_jiffies(HINIC3_SYNFW_TIME_PERIOD));

It looks like the above unconditionally reschedule itself (also
apparently it's not sync-ing anything?!?)...

> +}
> +
> +static void hinic3_init_ppf_work(struct hinic3_hwdev *hwdev)
> +{
> +	if (hinic3_ppf_idx(hwdev) != hinic3_global_func_id(hwdev))
> +		return;
> +
> +	INIT_DELAYED_WORK(&hwdev->sync_time_task, hinic3_auto_sync_time_work);
> +	queue_delayed_work(hwdev->workq, &hwdev->sync_time_task,
> +			   msecs_to_jiffies(HINIC3_SYNFW_TIME_PERIOD));
> +}
> +
> +static void hinic3_free_ppf_work(struct hinic3_hwdev *hwdev)
> +{
> +	if (hinic3_ppf_idx(hwdev) != hinic3_global_func_id(hwdev))
> +		return;
> +
> +	cancel_delayed_work_sync(&hwdev->sync_time_task);

So here disable_delayed_work_sync() should be used.

> +}
> +
>  static DEFINE_IDA(hinic3_adev_ida);
>  
>  static int hinic3_adev_idx_alloc(void)
> @@ -498,15 +532,19 @@ int hinic3_init_hwdev(struct pci_dev *pdev)
>  		goto err_uninit_comm_ch;
>  	}
>  
> +	hinic3_init_ppf_work(hwdev);
> +
>  	err = hinic3_set_comm_features(hwdev, hwdev->features,
>  				       COMM_MAX_FEATURE_QWORD);
>  	if (err) {
>  		dev_err(hwdev->dev, "Failed to set comm features\n");
> -		goto err_uninit_comm_ch;
> +		goto err_free_ppf_work;
>  	}
>  
>  	return 0;
>  
> +err_free_ppf_work:
> +	hinic3_free_ppf_work(hwdev);

I don't see a similar call in the device cleanup?!?

/P


