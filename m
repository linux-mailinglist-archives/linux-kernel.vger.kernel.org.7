Return-Path: <linux-kernel+bounces-865363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 743BABFCE38
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA1F456265C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F02834F24E;
	Wed, 22 Oct 2025 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SveC/HNh"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3330331A59
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146848; cv=none; b=H1jZrnEUuMYRpeAkB8Uu65pz5OI9PR/EHkTX4Ybn1o4UgTjF9kU3JN8pmxUyzvT2iwb9EqASAQfB7fAcqV27Sv0ODIcPZqu2ctNwlRrIo6Ig9HIoz+E9Pq1JSe9rXIMz6zvB7EQjC1jF1sbVUCz7RkUfHxbxkWpFSJRIXDTdMRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146848; c=relaxed/simple;
	bh=kNgL40BudYWuJuAsmdNvcDtZ0OwcI9RxNTByNbcVNcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lw94q/DMSzFncx2J9G+lbx0EAW43+qcQj5/RbGN8YtxEsbk0sMfFn3Hb6oAZVMLCtwHcd93PwIUBXZgfUvgNVcjjE3NR7h1rgsoTA9hsS9DdaH4H70sVC/GpzodX9o9z0oBLLOk7wkDrDc485TYvyKT/6F0LpVc1AkoQuS2h6IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SveC/HNh; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-430c97cbe0eso45347765ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761146845; x=1761751645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zoALVDG9RnT7BAOdsnJMe54/Tt3GRwf2SgNb0DV4KSQ=;
        b=SveC/HNh42OvRzv5MOYg+5Yqc5Ot+StYw/SM1sELFEHMOk0qF9C2YTFPQdirFHlfZ7
         Xfxeww8wvM+Nzmll4DCkWDne4961S9L8z28yGMhdGunyDdl0nnytO+L4wfpPfSeIWgPQ
         bdiJuLjPp4PtQJJzSKqPX8VjpXby3TV6j3fKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761146845; x=1761751645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zoALVDG9RnT7BAOdsnJMe54/Tt3GRwf2SgNb0DV4KSQ=;
        b=Z5zI+j/bG7vlMWxlE574QWODGqx6/ALs+p9Y4lBt/fzqRqZfpLulVQF94xw+hgn+RC
         p0Cw6XKY2zpP4WPGZ2xbdPdRI9AcZqsZIPPJtI6gb2bqRufba1BRPdsYeNswO8Ur/dtP
         Rioiao+DSPZqheUUq5IPPyx4030yFwLFYnGDJCiDbXDrjyTiGFoK/gKH5tnHODDWxqSX
         EmxXqaB5RPNk4WG+9vYd7qMp3bJiTER54T0GYTMYuVkaNH7PCV7rI8PU+uKPZXHOwVv9
         jkLtWRdd3n+btpRJp4raZGg7nfbWVdOjdYYCZ8e/FrK3lj3/H0qzjTZiuXoO7ewg1z7V
         AUmw==
X-Forwarded-Encrypted: i=1; AJvYcCVu7ov6HTmiYMfCE9P4b+Ha+Ln8Kl/+nMvpjitRFHqI3obcDIQo55p7qusymhYmMgW/4uvF+v1KzXwMyhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9taom5pelc6LBMosiBQbjTegY1SEZ0Ok/pK8+YgLXI2RiVpkt
	ts7HMAkKhqGEa8JNTizM8Y6rgZxjspVPYneA1NjLsHPNpyR0cuQCJfEfibBykrFAXHI=
X-Gm-Gg: ASbGncuFQJYVRjZiO6PEEmTbPSZkNYVM7qEx5V/b+JUSAkNdzCJx8XuMLC6bOxcJ8QM
	e1iRT7sDgTlYMikYSfKx18UVdS+8NeVrcyxFeauSI43eMzyHv0oxko+ThxJy82PH5V80WibFa5T
	j+O88JrvOtxTPHkMPXLQq0hOKgnjnmoATkpnd0F7E+Dmy8xmrjkZPmf0zpClOns4tMXGoopdmxB
	PHD1Hxb2EscH+6p0EYTo7T4YXW091ZBB2g2GJtf7AQXzo7M68h+ViFmmgJEKaHc0QT+RONvueB9
	715rtNClwmB0LFvft6wSeohjByoU1rwGT3v5ZO8kTerojQdnJoFPOUua+5Tuv2g8Sy1FHpliPLa
	o7KSlP3g1qD6AP8OgXPYCaaBZcl6w0OSwrC0cwK6GBl7J//OBjxPMsNKTOUa2d3y/1fGcz8KAko
	c3/KGmvZlZx5gL
X-Google-Smtp-Source: AGHT+IFHrNAgETUq7iHXWj4LaXPG7j1qD4lSrv4wnohCO6eo9eW67OevdQz1fzSz9sygsvW/JqehtA==
X-Received: by 2002:a05:6e02:3101:b0:431:d76b:d133 with SMTP id e9e14a558f8ab-431d76bd17cmr27048295ab.12.1761146845007;
        Wed, 22 Oct 2025 08:27:25 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a964a8a8sm5288976173.29.2025.10.22.08.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:27:24 -0700 (PDT)
Message-ID: <cb30af9e-c22b-485a-a83c-f395880cd799@linuxfoundation.org>
Date: Wed, 22 Oct 2025 09:27:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests: cachestat: Fix warning on declaration under
 label
To: Dev Jain <dev.jain@arm.com>, Sidharth Seela <sidharthseela@gmail.com>,
 nphamcs@gmail.com, hannes@cmpxchg.org, nathan@kernel.org, shuah@kernel.org,
 morbo@google.com, justinstitt@google.com, nick.desaulniers+lkml@gmail.com
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 david.hunter.linux@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20250929115405.25695-2-sidharthseela@gmail.com>
 <486e0d6b-799e-4fec-9e6d-3ddfdd64418c@arm.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <486e0d6b-799e-4fec-9e6d-3ddfdd64418c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/29/25 22:52, Dev Jain wrote:
> 
> On 29/09/25 5:24 pm, Sidharth Seela wrote:
>> Fix warning caused from declaration under a case label. The proper way
>> is to declare variable at the beginning of the function. The warning
>> came from running clang using LLVM=1; and is as follows:
>> -- 

Sidharth,

Make sure to not use "---" in your commit logs. Everything after
this line gets thrown away. I had to go fix it manually.

>> -test_cachestat.c:260:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
>>    260 |                 char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE,
>>        |
>>
>> Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
>> ---
>>
> 
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> 
Applied to linux-kselftest fixes branch for next rc.

thanks,
-- Shuah

