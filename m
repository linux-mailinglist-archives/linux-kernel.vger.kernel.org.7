Return-Path: <linux-kernel+bounces-819717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2788B80800
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7979F7A916C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2412E9EA0;
	Tue, 16 Sep 2025 22:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fL2sRE+5"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B22F2E8B81
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758063432; cv=none; b=tT6rq9W8r4wHcFXO3O9dV11LEPVGqmaiWQqPE/csPeGWbWsrjnTdMGYtTDrLgHt0EaFLyRfnOvvflyIWTLviTTRqpb5zokTu100CcNzBLFM9IvXyOG6CG4QMpaw+RN3k/OOYuHwyo0kNpGCb2MaExr81P4kx89SPIohd/JLWqmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758063432; c=relaxed/simple;
	bh=j7MO7dLZVJC1bDFPwVC2phRhydPY8BC9zOt+xN2/ZYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHAB1TJixvIg3X/t2MV/RZzEyd7qyfdi76kitm8QSKPFAfxIIs+AG1mZ/BuitwqlzKYxsLoHtZNWLupUrEoJC9KO58bBhra+AtUJMQuOLOMTfsTF5JU33giQSH/ebA5ZvbFeHbASZz74E0mFcE7buztX9c0qgckr/EBLShJk9yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fL2sRE+5; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-829243c1164so303033085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758063428; x=1758668228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NNVTeFW6hMsZUiSc2Y7TZ5+CQhQCRJybyead8MewVGg=;
        b=fL2sRE+5iQdYqK+ERWT4GG/C/X5tiPWrKtUkRlzQA+C+tb6MzNi8sr7UxR87T/Zp/T
         6Sp/GZAmKxuO/wkXTMSONmUtEW9X5F5ZKkn4XPw/cOc5fX2wXFQ74nRdGOF2P89dl5BD
         WYr+fgZDwvCfyWi3P5Ef1TdR0/hlyqq+GvxU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758063428; x=1758668228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NNVTeFW6hMsZUiSc2Y7TZ5+CQhQCRJybyead8MewVGg=;
        b=wfIE/8Vwsh3zpSrFOjkm0om49J8+d/9/DCyfX+z5FDWIOzmObt7sygrTDQ0B3mLbIR
         8OVstnN6kR7AGCaHarqUJE7rvk3Xy+8El8FGUotGxs4rY4HiU25IBTFVYssn82xF8Biz
         Npjmy9OQ5l5MrcHgEFFP9mBEorMWmx3hEm3wSLLefMILg8egi0hgSOoQIdL2FwTU0hdA
         ITdR4o+jTyZGOZk9q/jyc7z8Y2Sk1ZJEXCf9bZnMPitNFN95qSnUTG/qa2QkiHHFi7Je
         BD4MbwCJ4q4zbHps+lTKYY6GDdIBmafnHecAQUp9DPJy0G7Y0+dlpQ9+TSSkqNEN6aJb
         +6Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWkHXmtl+mD8ZPjL675+ZxFBk4o2D6Q2HBy5Q8xkmdP+Lo/xGhPPC7VEvoGiZlvhYzVtCdHgPNIo2KVc5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhd2sgB3NNDPR7YAaK5UEFaLNLrnV6kXoaIxvFvxT4y2VipOvk
	Uti8IjoViqkocWnYt2jEhS5Eecb9wiZm0pm/ykHzgQyiWBNkwdW0SyqLD+L41DOzMbY=
X-Gm-Gg: ASbGnctB382depSvYX9A0Z3U4XuDSdtDCiiV3yYQ/ZZMZ3A5KJTBEOSwEk1kwndlXw9
	TQgu8JVcsfLmcpeuBQ8UXgeq9G5/xdBkIUL8mEvsZM/STi9pSK1jB6nZJ3XHPqqDIVIx4jbYju2
	DXUcv5qB77TsJEtGGcYKoJy1VwnU30SsPvqbY8mCIfR4vyA89Ro+LyKMXV3iQQQikAlSSNf8K8t
	gVs8neK3EFzJW5so0QzHrwjq4qfNAEhtnYwzYcsikkXcQNSL4vkgEV7oVunKp8qpBXNtKxl6Bfh
	3b07eekipPDFIB+T6rXafY7u6CVFA6J7JV7jQPW4wOT9JNP4b69ISb+LiYbGYpPTIGxYgX2/zOt
	t2G44Tg5Fc3E3A2PiaBeRdswRHvW6fWjwsrQqzgm20MPSlHCrLojPUsje06wgXhlRVujF7Kio+s
	ByLB6kA4X3HkBfZ5g5Q2dOjUjp00/4Hlg5FW+KnKFua9w=
X-Google-Smtp-Source: AGHT+IFAqOA3hC4ras1yzzTG6/QAgWBIgns8ywXCJ+Yp/o6jmfU6v1kF3w8KmpVF05+P8dD8SLIKUQ==
X-Received: by 2002:a05:620a:172b:b0:82a:5c45:c5ef with SMTP id af79cd13be357-830fded0290mr10034885a.0.1758063428125;
        Tue, 16 Sep 2025 15:57:08 -0700 (PDT)
Received: from [192.168.226.35] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c974c848sm1033440385a.23.2025.09.16.15.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 15:57:07 -0700 (PDT)
Message-ID: <2a4a101b-fd39-4d0e-a967-ee671fbd9313@linuxfoundation.org>
Date: Tue, 16 Sep 2025 16:57:06 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: watchdog: skip ping loop if
 WDIOF_KEEPALIVEPING not supported
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>, shuah@kernel.org,
 lizhijian@fujitsu.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 akhileshpatilvnit@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20250914152840.GA3047348@bhairav-test.ee.iitb.ac.in>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250914152840.GA3047348@bhairav-test.ee.iitb.ac.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/25 09:28, Akhilesh Patil wrote:
> Check if watchdog device supports WDIOF_KEEPALIVEPING option before
> entering keep_alive() ping test loop. Fix watchdog-test silently looping
> if ioctl based ping is not supported by the device. Exit from test in
> such case instead of stucking in loop executing failing keep_alive()
> 
> Fixes: d89d08ffd2c5 ("selftests: watchdog: Fix ioctl SET* error paths to take oneshot exit path")
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---
> 
>

Applied to linux-kselftest next branch for Linux 6.18-rc1

thanks,
-- Shuah

