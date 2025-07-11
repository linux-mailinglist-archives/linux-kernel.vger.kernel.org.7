Return-Path: <linux-kernel+bounces-727770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBD5B01F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71351A422C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49862E9EB0;
	Fri, 11 Jul 2025 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VXYxD055"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D1A2E974A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245257; cv=none; b=gQDb1K43Sxvx5Af4DDHB/oMEunQ7zWQ0tU1Ckxg0otv/xBQK+TobFvxpjCmiN6zIDVmAG4RnpNkTPOczDdmPHN9XxzUSalrZqt5Go4WvkrpCozhm2oc01Jpw4BelXWW7tp4+NVAjXSunL0W6042yqFSHB+9ue5HDWjrpTtOaytY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245257; c=relaxed/simple;
	bh=40YLiJGtlMV75vim5GTwj8WRKEQtxPlQPilZVhGD5Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGm1xUwwt4G+n8iB3hgVPTdG5Ww0GanbTsjW167jmOmMGA9b7WR7tIbzf15cBH5/NF7GRjdBlyBo33RLGckpd7600SRjxTWaZTBaz348vUN2HSQF8gXXeVnQLPbZlOtpCaivPR6X4Sk+zLuaEa3jcBCMfp9ta6Upl4+5bBaJSsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VXYxD055; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3de18fde9cfso13491515ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752245253; x=1752850053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zcd/YQds+2VAgDHHik/Mx+4kMgTfoFA0V9ZGlHTyX8Y=;
        b=VXYxD055b4Dyv5c6uiHkCkNBXbe6OtAH85SXrXCDidViW8PJw1ynj+f/Y7o76Tm+Lc
         kB4F4DuxiECjGttJ0GmwZXYLLxXGDDG0Wds47/R08zTjMExObmsYv7hORVmJQB2Ezp5I
         dbaJ1zZ52Do65Jd+AkO9pUI+YYnQee9xKigdfQSv+h4xxK88een8swj3rgSl4lXrWTqz
         tB/aPE6gnhakf2lUJNg9SaJd8a/JhMOk6GG+LbK2YtqUPAF98WlsuKAdaMZ4+RhXZEDh
         QQ0XTD3r1TAH8ebQJ7+UUPUjTE1K9TI4FocmPWsoQO8Uc+jeHU9JHwVbwl1691QvxIg6
         ljAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752245253; x=1752850053;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zcd/YQds+2VAgDHHik/Mx+4kMgTfoFA0V9ZGlHTyX8Y=;
        b=cTrbCZxGnl3JYIktABDQ2lkUw/iYM8Ky5rGoUn0/lN8ul5ruE8xDJZ06Ba1BgSlFCc
         k3Kabu461AATfXxzf7YJv7+VJkbBzqiBdaiRtqgKE4iTQonlKY63zDFmQI6tcAthTBq0
         v44oRunrDNzw0ETtd3yvM+PDe0sfminDO79pN62zNG2zuQYds/pb16GW+cwedFS3M1pU
         UsDiCEpEPEWlSUPDhzh8pptmm16bq2uRdwjQ36VFHlEu+fljQmtRZHHK7eYC4tbL4z1/
         24zj7KWjtn8PQuWIKDOkH2U1W1XRH8JdMCnX4695TDNbhI7ZfofRQ6DZxKtGFm+AeRhF
         GjHA==
X-Forwarded-Encrypted: i=1; AJvYcCXEUqV+TgvaJ2uvyRDQZHs7bm+SbTC/lPzSJWHBJ/deXGz3SqcS0h8QXejOiKU1ukxa6izVMAUlZJAQP2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YysPGcD6646bzUCgAfMx2gm1GzWvMlRPhZAIETBn6b40u6jGGgt
	HHcXw7mecpH4mj/AiCPp2BZ5D7t4yyvJAECrO73oo6fkZorVrjj/uIehF71V9BRZAoA=
X-Gm-Gg: ASbGncuUydmWnt4C6ggSRH1KmTino5fJT6Ppk0smsbL6XBKtosriZPSovvumPAKuRCx
	oox0JFzItGr9ZPpWf8bwaNYofsy8eiSDR7ERvkcCofltv6d0AE2GcFVfVBYQiDfAY9qKznvUrIi
	Jt4aIhTtpbxO4pNtyxlZ8uMoAEMcWYGSXIL9if+O5VKKh0HdzU41BLPUfbVXlpKzpGe5rpnMJEl
	Ip5k4HPcOLtskzmoGvqU3g7Zwc5Nkv9FsZ0c1HWqi2ATYm0scnVs7YhraBnHf9aNcA4/NA0bhqG
	1Ey2aXXomI/zU+IsNoWl4SgVemyEDqvykLY4VM24UNCZSo3yYFw88iYTt/7mNsuqWwWgePFBeOr
	fcpbyQ9oia9/WGIs/p44=
X-Google-Smtp-Source: AGHT+IFHa21P15JH0dsJFMLE6O6OM/qUMychTO2XSL+yzRmWrNM0AfUhxkqN0w44VxXhBk955nhVuw==
X-Received: by 2002:a92:cda8:0:b0:3df:2cd5:80c1 with SMTP id e9e14a558f8ab-3e2541dc704mr32741355ab.4.1752245252959;
        Fri, 11 Jul 2025 07:47:32 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e24613447asm12376765ab.17.2025.07.11.07.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 07:47:32 -0700 (PDT)
Message-ID: <e3450519-dbeb-4741-9772-7e33462155f9@kernel.dk>
Date: Fri, 11 Jul 2025 08:47:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] block: fix FS_IOC_GETLBMD_CAP parsing in
 blkdev_common_ioctl()
To: Arnd Bergmann <arnd@kernel.org>, Anuj Gupta <anuj20.g@samsung.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Keith Busch <kbusch@kernel.org>,
 Caleb Sander Mateos <csander@purestorage.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Alexey Dobriyan <adobriyan@gmail.com>, "Darrick J. Wong"
 <djwong@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250711084708.2714436-1-arnd@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250711084708.2714436-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/25 2:46 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Anders and Naresh found that the addition of the FS_IOC_GETLBMD_CAP
> handling in the blockdev ioctl handler breaks all ioctls with
> _IOC_NR==2, as the new command is not added to the switch but only
> a few of the command bits are check.
> 
> Move the check into the blk_get_meta_cap() function itself and make
> it return -ENOIOCTLCMD for any unsupported command code, including
> those with a smaller size that previously returned -EINVAL.
> 
> For consistency this also drops the check for NULL 'arg' that
> is really useless, as any invalid pointer should return -EFAULT.
> 
> Fixes: 9eb22f7fedfc ("fs: add ioctl to query metadata and protection info capabilities")

Since this isn't from my tree:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

