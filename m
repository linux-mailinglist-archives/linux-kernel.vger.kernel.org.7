Return-Path: <linux-kernel+bounces-765484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C23B238F3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46D41BC227C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9C829BD9D;
	Tue, 12 Aug 2025 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MKw5MZi3"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4507D27FB35
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026879; cv=none; b=aZIif6ysW6LzvYrhMK7NCKxVbd/p1axl5wydojzPHqv/4BbRcasoSACIbCs/Wpl/3bN5wJZcO/CK1K67f/P4H3KIQCC5zBdA1otP5vHIegfg6GzorTsgSb+njCluONprhEYvy+AUXYYddzXLzZ0mgbkCzJqanxGCKdwpxeb6cMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026879; c=relaxed/simple;
	bh=y0y2N5LIeyP8xsy0Qa63fgrKE/mH0tt08exbUT5h0jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s9wATamclzkZ/F54gyXkYViDFe4xCAL3nXMFA8rM0VLzntq9e8yVtSVo6so0vIjcm9ZDUNR8ISqcwdUkhGiUusg1nQ41/gKEXUkOyocO4YDsiPAsiFIKzmdNIOpehx9Jl5PjEqTo2HtqU9v9l0WVAdrK+W5j22OGIxNqHhqzFYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MKw5MZi3; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e51dc20af6so56009595ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755026876; x=1755631676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1RNO+JaaEkY/OEdHDihqn21pputuGs/yjSpDhvuKLeI=;
        b=MKw5MZi3KtfJao50CyvdDDxaC1iTr9aQBbAxreZa5wqvXsnrufo+0bv785xkygUEKK
         MvxfAMbgbqRc6dKLUkOQCzN8cwqn3DJ2/4XwfqbhBLHaiJDsvEw1iF07CgXn0gAoBXdU
         cJRVZKvScZtLLZ/+moSJAQ1/ZTY7z17FUw7i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755026876; x=1755631676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RNO+JaaEkY/OEdHDihqn21pputuGs/yjSpDhvuKLeI=;
        b=kLcwpAVH/3sXmvwMOvtgGDiIiTFGEQWSEzy2VC/y6F9Vmd9ktlYB0M1WciyFF3At5+
         0DJXcjRekkALookhLkWiYzWRoSfsj8CoLgqcTNEnv/7aJl87Bo97FaY1loGDpdWQkM69
         qUuMhnqexpT9a9DP8G0YNWBpVaTR6m0//qs9e6TwmH68Id/+Sz20asJqTPdPSx7HZ3cm
         GeuMGn2zG+KfBIAyYBVpEGEGE6NkuDF3YEALDW1hZPrDZABwawHs3GZplceon7jjCCad
         Bs2jtFdLWstAkLRST4DvyyP07Y0IlHtbagvzjhPNuKfdz+2b4XobyyjNHdDdstVBXs8n
         ckRA==
X-Forwarded-Encrypted: i=1; AJvYcCU2g/imQ8xFBirrT1Kdy1Kr9mwkd0DGk/udbXIymU279m88+YRtdG4qeikfG2Jk/kDHMiaKrlTHYcOHku0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2wbs6yoKjjcrt/4d65td6kk9BxqArONIOG2LO10KadD14rfBe
	Qh9rWC2wPrXyyTdvkNeuCNEeLCnsvzv53niqSeiBk4APP37QXjrDCWPbmBFNPG235fk=
X-Gm-Gg: ASbGncvG7ox8F1YsIA5Y17zsn2KFLzc6dICKWoA9Fb4pj1jw3RvXgioiUYy+Ocf6DQD
	KfUaYBbDvitpCLPqWD2HOhPxw2DVHMDtiQozbWHDbTsPzBaE5n+JlEyCv5NTL9lrWYTskdIQlUB
	XuQ3REp1iFtaVfFWff1xJCI7ZlBsD3DPax5XKb90JSq4R60+n1tXhZuDmez7F4mipGhH9VA4CDG
	9Kq/hOyDh1yOPtgyIF/+4cW8S/QzBpSv/iupfXNvsuIR5ernPbfEFSOSJh+qD4XU635fQWHrK0N
	A6hb33PsYtGAWl9AILbWmApePZsAcCoi+bCzmZP6d6Z7eBz31quLSGh+SDp4dLkW1oKjDKC1cHV
	gUjGkHhs3Ou8W9maO4X04tU4pBiBQz6z6YQ==
X-Google-Smtp-Source: AGHT+IEUCGZnLw63tW0KNVTQOiNtoNzl7gbeEHojoAK0DgCBv29G2cLC+KWOONDi4CrPrrCxgtRIBw==
X-Received: by 2002:a05:6e02:2147:b0:3e5:3520:4a76 with SMTP id e9e14a558f8ab-3e5674e77f6mr4612365ab.24.1755026876188;
        Tue, 12 Aug 2025 12:27:56 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e546358251sm31477615ab.54.2025.08.12.12.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 12:27:55 -0700 (PDT)
Message-ID: <ba9f7752-ceb2-4fcd-acaa-b5afa77eecda@linuxfoundation.org>
Date: Tue, 12 Aug 2025 13:27:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog-test.c: Remove unused variable in main
To: bajing <bajing@cmss.chinamobile.com>, shuah@kernel.org
Cc: lizhijian@fujitsu.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250812075345.872-1-bajing@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250812075345.872-1-bajing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 01:53, bajing wrote:
> Since $optind is not used in the subsequent code, the variable
> should be removed.
> 
> Signed-off-by: bajing <bajing@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/watchdog/watchdog-test.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> index a1f506ba5578..837001a9e3a0 100644
> --- a/tools/testing/selftests/watchdog/watchdog-test.c
> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
> @@ -209,8 +209,6 @@ int main(int argc, char *argv[])
>   		exit(ret);
>   	}
>   
> -	optind = 0;

Removing the assignment soles based on looking at the subsequent
is incorrect.

Explain why this needs to be removed? Did you happen to check
getopt_long() and how it uses optind before making this change?

> -
>   	while ((c = getopt_long(argc, argv, sopts, lopts, NULL)) != -1) {
>   		switch (c) {
>   		case 'b':

thanks,
-- Shuah

