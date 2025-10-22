Return-Path: <linux-kernel+bounces-865365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFA4BFCE20
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D7C1A05AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6559F3446C3;
	Wed, 22 Oct 2025 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qzi2YjJf"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EE434E746
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146890; cv=none; b=sL08qxcre+JlkCRmI0dlyAi8zaLW7DeiaOsU9Vrxvn2lFzcC4Gp5k08Z0UfvYLhNbQkAfh9FsdZ/pRd43BkiJxw7f3zlmk0xP0csc/2jc03sWjjbxzJc7rV01apMk+PC3LoyDxGAu9sfdggkvxAs91SNX+91QAvo//ZmgA9hxbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146890; c=relaxed/simple;
	bh=EI9+X88n4io6JI5x6JGStAPF9hZmzDq+AZMPDkKogZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWIEso6qSRyQ/tZNEKeBAMVtTIhEVXxOtZ588wzFwTAxGtmnd9+MEwW09esxPBrmfrIyleodFEcVWaDh6+vRpXNgwq6fTZqidxkHrmPyyodFwmn4d5aVD8N+pjCRybhNkwieAzZRcWXU9J/Eao6wJbkiHXJ9TWynN3IdIWjlqyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qzi2YjJf; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-431d2ca8323so7336195ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761146885; x=1761751685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UCyGNn9DqYHAJPTYEfOdDyskGHQO9IZaMQjWReSYYrU=;
        b=Qzi2YjJfCauUDDuPyGgc3Y63USylEs88+PtkMYWZ8lSbFlSwgKCBsWmf8izE/zAmaH
         zMqhVE7l3TN0x049wFFVnTDDPFxesNUXJPeEQtpB9w41age4htODr1IREIA0Y4PHifR3
         e9pcprKbu+BrSlg/cwz33hh0HbCxDn1y6jWpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761146885; x=1761751685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCyGNn9DqYHAJPTYEfOdDyskGHQO9IZaMQjWReSYYrU=;
        b=HvCssk0D0qhnRcy8vSUCEwG8mb+amXacdrYCXFlLPdyzjnWrLrC0SrtFa7KdKEOG2g
         gvaq6jcYjGR2vRtAlKvhwmxWV3fPZi3q/2TEgbZBOOy5nyx5AEyQ3eSSNoDybr7P+yNK
         ikxROK0jfnxetttDcSq+ypD8wmirC+dT8Gxgfq1iDZx2Ko2guLl2+L2GgekPQ4emSCQk
         1WNgBimV4l9M+B5Iul8q6/hKLa18LV1XcX1x7HGVoZssHxGEgmmEGWtusZeUpN4C+fVw
         uIXD2d+HUgD6vJgXyGkZJfx9wMGNNqYctYyY/+R3sc6oAtmG714U1+9btW03PR6n5Gon
         TWnA==
X-Forwarded-Encrypted: i=1; AJvYcCVVEdgExNzX2HT4bQIxwBVY/zUTXYxoH8FdZiF3TbPQkCkyFF/walREai3dfm3tVjeLBgf6+jRSwhXOrjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa3yaDsD/ob2jK44UQKlaixYHjBl7bb2dQCiJRJ2sa8nGOG4uW
	KrWnSoRT9YXDbbFf4tOHJ1wvtXBTKYIpbxeHYG4aj5PWSl8yBVucmuTea2/qcGpOc6c=
X-Gm-Gg: ASbGncs5Uq/EWkUfNFxWkIQk/ugolXaB3lhV0V4j2g+zyuYh0UJFb6kfLxexnvzMJOn
	d6fqB59qNlAGK6ULevbo+yksr2UjK+KAyHGy4uTIHIEsfYNHEMTExYPWwq3qjkPWsykW2oM6gNO
	avZSxSSeuzk0aE380XXdLuOdGy6J4ZibXAgEEg2dvai82N9abJDnIgHJxxt0xIRCzNS4yyMhDHX
	JREswfOpY86yVadnacpd/sNb34MCw6Busly3kGYm9FjchS/tEnsJyH0J81mYYg3Srgm0zmZcJgx
	N8y0KDQ3Jg172bULaNpqHncWslA7K+n0kdVYn0WYsHHRDVY79i6CwQH7O1PC4nSpHTO4UmrqRro
	TeqA5DQXaRIHBIpPdR3b4pRpCLoAE5OnRW2R9CpPzM5u5K7+aiNv5dDbeKqPlp0Os2+spy1GZoA
	24f8f/Ql2GQ8EiJJeoqb2TR3w=
X-Google-Smtp-Source: AGHT+IH0tUAY1DZnnn4LLpJ2tMQ7048bBL0pCZcMZSbVpsE+cqMSObTeG3mKxAlP47l/VeOFctL1aA==
X-Received: by 2002:a92:cd82:0:b0:426:39a:90f1 with SMTP id e9e14a558f8ab-430c527dc54mr290786465ab.18.1761146884652;
        Wed, 22 Oct 2025 08:28:04 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a961da08sm5303034173.16.2025.10.22.08.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:28:04 -0700 (PDT)
Message-ID: <d18f46d8-9f42-46a0-b5bb-4f1d16c868cb@linuxfoundation.org>
Date: Wed, 22 Oct 2025 09:28:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] selftests/cachestat: add tmpshmcstat file to
 .gitignore
To: Madhur Kumar <madhurkumar004@gmail.com>, nphamcs@gmail.com,
 hannes@cmpxchg.org, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251013095149.1386628-1-madhurkumar004@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251013095149.1386628-1-madhurkumar004@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 03:51, Madhur Kumar wrote:
> Add the tmpshmcstat file to .gitignore to avoid
> accidentally staging the build artifact
> 
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---
>   tools/testing/selftests/cachestat/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/cachestat/.gitignore b/tools/testing/selftests/cachestat/.gitignore
> index d6c30b43a4bb..abbb13b6e96b 100644
> --- a/tools/testing/selftests/cachestat/.gitignore
> +++ b/tools/testing/selftests/cachestat/.gitignore
> @@ -1,2 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   test_cachestat
> +tmpshmcstat

Applied to linux-ksefltest fixes branch for next rc.

thanks,
-- Shuah

