Return-Path: <linux-kernel+bounces-848390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C88BCDA03
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC22E1A6202E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D1E2F7442;
	Fri, 10 Oct 2025 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="i60S+LRN"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0AA2F6569
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108091; cv=none; b=OfdnBrzM58xJAXMVLz0S5W/VCkphXzVKfYYu9e0wrM7jtr2QE6Sdi3MDjWA90QTjJLPg0PdSwlTDltauwe+UXvW3N5FyAytOKtrVxgq0cps4exb4Vcd4XvjtFIem6gL92R6B1JxROWj1mc9VMBtpal/IHnk+I9PcKY5xo022bVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108091; c=relaxed/simple;
	bh=JYLGO+aunzqaQyg233Rpqn3/BKIT15UHFzo9wZBhkqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MFcPB5eLLBmRaD9Ez8zo2tA5zByFV1WtgjjQmg83vy6mB4hCoegV2gYtGAc5t93AFdCFe3E5K84JAVLeSgy1rYAgRfJ4jHVWM9xFgc8vsZybmuI/9Bq38/3IxSRe0zQpKJvfsyg4TmIky7KoXnwU3xdgiPG3CXAeDQnOs7t6RO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=i60S+LRN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27d3540a43fso21457475ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1760108088; x=1760712888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vbofJ5TYVrlVEz+XdSpL9ID+J57K1M46jTnGkwllw9Q=;
        b=i60S+LRNyOfZ+5UyB7ryseoQPralCRNlYAOsYj95WJ+HoVTMeztSRdQ+u3wLpxZKI/
         Q9lrPIbOVar3yFFJdhcaZeDw3Nw5MVSmisnL+dHGt0qAPNx83i47jHef+330pQaAlp9T
         IvNYOoTzkX4ApN3uSSbo8PrHjncgr/Q7ekwrlc6B9EP+9sATkv2pcTWSjpP5PjDW7pmA
         CLXAuNY36wV1jQEi37r0W2ifyVIWWQSzmUp8jepRyC0BFpohpi4Knbr5xhM4kA2QA2vt
         FSYukuF9vZp5Ys2aHXCot/QC90JWODxuopAxMHTmizM2P/mTY1p0DoOu9si0iEcsPIvV
         fOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108088; x=1760712888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbofJ5TYVrlVEz+XdSpL9ID+J57K1M46jTnGkwllw9Q=;
        b=fKcFFzshNNfiuzTubWl3+I4OqmzUo81/BCLz0XBAr/+U9TxooOq2Q5k88Zh5onbY8Q
         jRDxEJrKJBOCevg9HNFcU+rGfSHf8cFzAxcje3xgIgiE52CjnlMzTahTzbecB0EQiMTL
         PuHMj4PeZQ/GM36VHOZIydVIfhgLEPvcaSBSiWu3aJwrwcFfAHCSAP0ENUXkaQWqlhSs
         u519hpZLWxsYqskHLJ52DnLuwVCCTHXydGHmoTWtEzwIXDgxB/QgG1zx61znvHDZPeUF
         w8JiDj7KUxz7ke6N+XXQpnSCHCkbZfL6B7ILQvznYedJS2hB/bP7QS9jBxFlNBfc4fpr
         QQSg==
X-Forwarded-Encrypted: i=1; AJvYcCWig03pYNks3o4Mv0jRa1o3X5Rlp4e0nYenTDXd1qxmLMhfWlT7AvhHUJXGAieCwbg5mt4QSZTU/lSELvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7GiBaGsTGnuvpSifjhUp0vXzNx8lpuU/9NeYnJ58JZEPifqLT
	AJWoQ2oW11YgbZuhJbZxyof8B4FBK4kRVRGtKEtpN+6wKn/Yh0XgNDIyk92j+rSF2r8=
X-Gm-Gg: ASbGncvHK75dqPrfBdy4XA5YVRDzqAzDUIR9+/biVcMbZbUL+/oQCjB/0NyDyYifIqD
	QsmPqIVi+u81f5eHUxFEk95//8rzfa7o0QbTfP3F82FGyNTL+DY/JZbEHSuoHS1+8C6lEPHv6j8
	Eb01ILumKjoGUOIfJG4r7pNER6cZUzIG4QlJ20CPFnSfGPn1GYr4ECh2TyAyd1qT+9AYSw+1/6C
	G+lD7e0O1SnIOBStNWg6IPpZM1SW0wyEAysH1pwYFKHuGS+GtmOE1rqR1Dw3QP67oXOtAPDwP9V
	vf8zXHWGopzRIpbWkZnYJbm1LjJqOBPo8l5LZZt853GGrt0r5GYoRNwTBtv959PKWa1d9yuoFYJ
	NELWJY3bAw9/2bK5VSKtfAa/W6k2IPearUn1hh5iJ/RRGUHwvJbvIT4RdwhrM
X-Google-Smtp-Source: AGHT+IE2ykU3JRpPiQHMUmIjNKSKo2rlX9PQObXBs1FO64lFOyXHQeDzHA7ctCDQl2YOXgiwg7ruvg==
X-Received: by 2002:a17:903:2292:b0:24c:bc02:788b with SMTP id d9443c01a7336-290272e3debmr174061055ad.44.1760108087677;
        Fri, 10 Oct 2025 07:54:47 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29040e02648sm26130335ad.116.2025.10.10.07.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 07:54:47 -0700 (PDT)
Message-ID: <cf4e88c6-0319-4084-8311-a7ca28a78c81@kernel.dk>
Date: Fri, 10 Oct 2025 08:54:46 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mainline boot fail nvme/block?
To: Genes Lists <lists@sapience.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <4b392af8847cc19720ffcd53865f60ab3edc56b3.camel@sapience.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4b392af8847cc19720ffcd53865f60ab3edc56b3.camel@sapience.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/10/25 8:29 AM, Genes Lists wrote:
> Mainline fails to boot - 6.17.1 works fine.
> Same kernel on an older laptop without any nvme works just fine.
> 
> It seems to get stuck enumerating disks within the initramfs created by
> dracut.
> 
> Subject to bisect verification, it may have started after commit
> 
>   e1b1d03ceec343362524318c076b110066ffe305
> 
>   Merge tag 'for-6.18/block-20250929' of 
>   git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux
> 
> Machine is dell xps 9320 laptop (firmware 2.23.0) with nvme
> partitioned:
> 
>     # lsblk -f
>     NAME        FSTYPE      FSVER LABEL FSAVAIL FSUSE% MOUNTPOINTS    
>     sr0
>     nvme0n1
>     ├─nvme0n1p1 vfat        FAT32 ESP   2.6G    12% /boot
>     ├─nvme0n1p2 ext4        1.0   root  77.7G    42% / 
>     └─nvme0n1p3 crypto_LUKS 2                          
>       └─home    btrfs             home  1.3T    26% /opt
>                                                     /home             
> 
> 
> 
> Will try do bisect over the weekend.

That'd be great, because there's really not much to glean from this bug
report.

-- 
Jens Axboe


