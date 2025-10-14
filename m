Return-Path: <linux-kernel+bounces-852265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E0ABD88DD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425DB1923DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229CE2E5D2A;
	Tue, 14 Oct 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxjgUQYY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B016C2D949F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435240; cv=none; b=orlCvx1JFm/RinV83ScijGZ0vvvQx0PWFlumN8+8/JvXLQ9XoUg70ZWipAymfwvnd+XFbbDmWWBgxaOACzVbeRuAqtLSMKRd96TO735TNb0dnh1Uw7Ac/7XlGABxIL0CTE9LQA1sW5948mm6swtXi4PxCe8yJvSlN/TmS8srvhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435240; c=relaxed/simple;
	bh=so4LHqIHw3CFGt8OZscMcsX45wmcCRUdVqsTf7gb+EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rB5b+t5VV76bp1Ln7D7OCeQvlfWHWosPG6ze6q9NRCZtTgSImKBlI5OsZ8me7Mm1FPjcY+xpAMDdqNSn+U5bZHOsYkBEVFPKXNMHbx3nII+5dZ+iKu3Hs4PLfTk6odHplTdJh+p4HBii6QhF/jwxilJazMzJG7EBMZ9Y03ju2vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KxjgUQYY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760435237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5N6OEeG5CmV81eCe6A/4zE10OVgeRQaahrUEjZTGJf8=;
	b=KxjgUQYYUlmlCYMlMUTgp35dsn7TTxu87mpgJS+YZMyKBfmdE5gcBN1GVUGLhQtmkU5fe4
	EurcWjxP/GLEW50vC4F58wNBMv/x26DfnqGLRSQ1TYHkntl7VKmDMvD/Q5hi3Ndiue2fi5
	L2XfeZWPPldMSMmnCpyPqqG37EJh1Dk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-iqT31rclO0agDgwid1FUEQ-1; Tue, 14 Oct 2025 05:47:15 -0400
X-MC-Unique: iqT31rclO0agDgwid1FUEQ-1
X-Mimecast-MFC-AGG-ID: iqT31rclO0agDgwid1FUEQ_1760435234
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e32eb4798so26383015e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760435234; x=1761040034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5N6OEeG5CmV81eCe6A/4zE10OVgeRQaahrUEjZTGJf8=;
        b=a74u7vkcTJe8yVBLWwwWB23leKWn+VYcBD1gBFvhdWjmfvpeOJN6V22cwYtqpVzw1g
         ZDfb2Qc/cbPMUBR0Fq00EMzqsYzUGpP0baFowSg71lj+34EiXeZVitJf9bAFsvAvA6qX
         ALCfIJDPT6tCk3U0AArF56zSGKJUdgtQSdWGaebn+sggz9eKeikqxCgZvEkcUvc9Ldss
         anqdTZ2Z9Z9Fn9Ami/7rKOypGn7c7XvXJaSm88cz3xLqMiz1uNTBn4M2uXM1lRwHtcTF
         jgLeF+DhNCe6pUJzWitGCC7eVXy++w3UtguvVgwlV0V+Ilw6G//kDsqauf5StCx5uuI+
         ktkw==
X-Forwarded-Encrypted: i=1; AJvYcCUqUBeDv1/1GEBWZui1uHqxRIcFudBl9a9jQFue3CdbmRDZfkfnLw3sbF5ZpF6SDYWRx3elWHDUsLhHhF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGoaS/ItlOPO38b0RKPV1Xt7ALAuh4NZhBdM5jcvYKh7XGuzWm
	oRN08XzjSqs1Z3lMPfMYnrJlb0Mr7vbp4uHB2UugxSk5lg51BIOdXPuyO5v+sS+3JK5RjQklO6J
	RM77itdqkqLxGY9WiR2cOGXc+kM1IS0vAjM54srtJOaR78iGvjOYUyw2iHVrsYsF/9w==
X-Gm-Gg: ASbGncuxnHi21vtejMdFbnKFzC+W3fj3o028ZsT/tIdKFFEa5pqOIEIca8JUH/XJknr
	uG0NmuGEkT3xSZSUNQTOfSDSRKV/4VLT+iq8RxAulcl43UnPPdgkxhvYvCLlXHbpr/3HDrlrBCg
	7ZojbmMaR5M3kYy/IZ8LaB556Y/MLaQzHHp0eerq4r7uwaM8Iak2K6KBTVnBqisS0PlvllZj/3Y
	8ZEdwH0r8OnXBXtIcfNPZZFkP89DaL+L0WMyotlPSJcoy+MWpkJzMX7pDKMKO8vIK86AuDwliv3
	9szNXNOEZlHmkbGGlCBOEZR0VrFuOZJAQ9gYYdGwn1/CQnMRx3vtgrr5ejOJJmGbQq4wiU6dw3F
	rOJAXiZjwnOBG
X-Received: by 2002:a05:600c:4690:b0:46e:3dc2:ebac with SMTP id 5b1f17b1804b1-46fa9afbb62mr156259695e9.27.1760435233747;
        Tue, 14 Oct 2025 02:47:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCHYgG+2qltz9vAWbpxtZa9W5FNzHR/pFUCq82szUc8pklfr6PSxnc4vOKKExKos7pXzHLrg==
X-Received: by 2002:a05:600c:4690:b0:46e:3dc2:ebac with SMTP id 5b1f17b1804b1-46fa9afbb62mr156259465e9.27.1760435233351;
        Tue, 14 Oct 2025 02:47:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb479c171sm230297745e9.0.2025.10.14.02.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 02:47:12 -0700 (PDT)
Message-ID: <2b9e0f15-6e4f-4510-91b6-8e4586e5f665@redhat.com>
Date: Tue, 14 Oct 2025 11:47:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Octeontx2-af: Fix missing error code in cgx_probe()
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
 error27@gmail.com
References: <20251010204239.94237-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251010204239.94237-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/10/25 10:42 PM, Harshit Mogalapalli wrote:
> When CGX fails mapping to NIX, set the error code to -ENODEV, currently
> err is zero and that is treated as success path.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/aLAdlCg2_Yv7Y-3h@stanley.mountain/
> Fixes: d280233fc866 ("Octeontx2-af: Fix NIX X2P calibration failures")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is based on static analysis with smatch and only compile tested.
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> index d374a4454836..ec0e11c77cbf 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> @@ -1981,6 +1981,7 @@ static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	    !is_cgx_mapped_to_nix(pdev->subsystem_device, cgx->cgx_id)) {
>  		dev_notice(dev, "CGX %d not mapped to NIX, skipping probe\n",
>  			   cgx->cgx_id);
> +		err = -ENODEV;
>  		goto err_release_regions;
>  	}
>  

Side note, a few lines below there is this check:

	err = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_MSIX);
	if (err < 0 || err != nvec) {
		dev_err(dev, "Request for %d msix vectors failed, err %d\n",
			nvec, err);
		goto err_release_regions;
	}

AFAICS err can never be a positive value in that error path, but the

	if (err < 0 || err != nvec)

check is confusing and should possibly be changed to:

	if (err < 0)

/P


