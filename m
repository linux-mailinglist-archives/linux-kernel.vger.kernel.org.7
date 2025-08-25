Return-Path: <linux-kernel+bounces-784862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22562B342B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39ACF5E3BA3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B275B2F0C7E;
	Mon, 25 Aug 2025 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Z0ejFYse"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6290D2F1FED
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130166; cv=none; b=nLIo50ZHlQLlmAPYOdGBYdgrBjGRBnH2Vnes5cVDR3dPhvOtjmnAm5hlwltBLnmW8ilsBAjSAj2VP8PF35GX1KyQJ6dSTfv1z7MqwXlNZ6c+TWYBKgTVNKhEeC5/AufkLfkKrAAHKseMWRFLbecpSEBEjD5ax5DbRS6BHItkW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130166; c=relaxed/simple;
	bh=uTCLex4r+CcOhhp0Jw1xbazf6aFLqhbTTS7XiB9UMvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qc1H84RnOVDNN7bOzB7VvHCtInnlptYmodJ4nG9GbRK1tGIGKGHcXtLTh+ufS95qqmabh8hNvJxYDgiSx15VVovpEZ8PQhtS7x5FoNpKM7ilQcR+xuC+TbZKM8H0OAnA19h0iV+A3SpE1lStTtvL8JRgHrWQr84Y0HYkwSaeaBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Z0ejFYse; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3e668360ec7so26253005ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756130163; x=1756734963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+bj16z3bAVbIZz7VeQgjGNlWSy6Fqh6GjG5p/aTnAY0=;
        b=Z0ejFYsePerMbR0np2UCURp6B5gR2IU8MemNn/750ldCjktwcIj+TQ+eOpFyxNZX+I
         EFJ7/MK0LigcIp0tmXqqmeAsSlrZKn/O2XrU6prlpzdTbDr66jYI83uMYNb3l1OlE5hb
         mOZJfnYYQSG5PsOlpQP1AldLBhGqxmDYp6n1KKRWq6e+JOhryXM9rPyk9tsnT6ydx1oS
         4bmE2rJcDR8CMTX3Cr703ifBMy8jYtBsr1mhgKnyO56g9WP3qfQhi23qZH+KCKpew9Kg
         rXTbzKD91M4Cvyl7lsK9gwoSCLyfRM2ifi5PfZu+N0T3358Q94Qk1AFBJIaBw76Ahas1
         Xqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756130163; x=1756734963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bj16z3bAVbIZz7VeQgjGNlWSy6Fqh6GjG5p/aTnAY0=;
        b=s+u6Jvyz4bVDy51zENZXEFJB0fmJjaJ5jBkAc/CiMiKQ+5HGbgZRJuqgwlD4G6sak2
         7vSNsti63QOX6/d/UKWxJq3QurmMlTGAYddvpLRszlxaGVwUvpwDmol1RS9Sr15xvh4s
         7vpO6sSMb5LLs9RLc+ZcJSfmNMRJQtbWQz9jr8KTnGuuFJBDoS+G1eMnbL6YocmmT5wJ
         T2lKZMpGlnRnJoQM6m2pEhW4Vem3wGBTTC4eQF0gT7t765YOWZ12Pz5kne1r6YlmGF4p
         aXbWY8urwbbqCqMVIx2Sm6GgRTHd6KEvMNZLqdbCywdiEilJ00jkgQC4jZp8+uyQgctX
         SlTA==
X-Forwarded-Encrypted: i=1; AJvYcCV/YyzmXv2daUR2FECmK1rc8J7zhqdDJQb6nO3GNt39BA2azAuyBt69hDJ+toireRTyFs06eY2vWoNWr7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrwz8fXSIq9TMI8aqba9b+8VZ65XwORz0Ih16kV9HcyZmXbqf2
	96wTmiiihX87ut1GKF6Ri3Oh1gDHIzz8bZpHo1FQ4/f1EGNwgYG9kQEtekhG4rbzfMo=
X-Gm-Gg: ASbGncsKnpB4ZOgBPWsTRLRTBRgrZoVccSr65vwxhM3SQCSqqT9myB/Ts/TmYZT8hCx
	PZE+CN9dB1LT7BP627VN7oPzWvJDZ15nWaiuCBKxobz4kba/FvoE4L/0LiBcpn8FhI/p7QnP7Ny
	i6AUdMUNFqcdcjKxGZ/K4/FN2X65+xz2Lnh2I2lG63w/vCkvWHf2yKJiSyeZe3RufT1Xmwmq9p5
	FcBcVFWMwA2x++f0PPSTvG6o9pp8qLqLffM/n1+t0aXfRNuanexlrBspgujOrbBfh0EzJ7GiFZy
	GZQWWEBDU0+U8Rq315bUA9dm/iMpmMnuEzKmPSclEQV9zh1aZtngb/01uC3UdJciSjnM8MIpe8A
	lWq7p9FZ1P6uv8bnynAASyCfpuAYuZg==
X-Google-Smtp-Source: AGHT+IEiq20Lr6w+nHnroyq/OSDP6bjRqBGwYdseaIsmpNKgrJv38nh2DaKDNtgxmvXhu4eboRHU1Q==
X-Received: by 2002:a05:6e02:170d:b0:3ec:4b19:1cff with SMTP id e9e14a558f8ab-3ec4b1927b2mr76913505ab.7.1756130163389;
        Mon, 25 Aug 2025 06:56:03 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4e45a717sm50317145ab.31.2025.08.25.06.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 06:56:02 -0700 (PDT)
Message-ID: <36f30d8d-02fb-4579-b527-16da24cdc856@kernel.dk>
Date: Mon, 25 Aug 2025 07:56:02 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] loop: fix zero sized loop for block special file
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com,
 hch@infradead.org, yukuai3@huawei.com, rajeevm@hpe.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250825093205.3684121-1-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250825093205.3684121-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/25 3:32 AM, Yu Kuai wrote:
>  static loff_t lo_calculate_size(struct loop_device *lo, struct file *file)
>  {
> -	struct kstat stat;
>  	loff_t loopsize;
>  	int ret;
>  
> -	/*
> -	 * Get the accurate file size. This provides better results than
> -	 * cached inode data, particularly for network filesystems where
> -	 * metadata may be stale.
> -	 */
> -	ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);
> -	if (ret)
> -		return 0;
> +	if (S_ISBLK(file_inode(file)->i_mode)) {
> +		loopsize = i_size_read(file->f_mapping->host);
> +	} else {
> +		struct kstat stat;
> +
> +		/*
> +		 * Get the accurate file size. This provides better results than
> +		 * cached inode data, particularly for network filesystems where
> +		 * metadata may be stale.
> +		 */
> +		ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);
> +		if (ret)
> +			return 0;
> +
> +		loopsize = stat.size;
> +	}

Gah, that was pretty silly...

-- 
Jens Axboe

