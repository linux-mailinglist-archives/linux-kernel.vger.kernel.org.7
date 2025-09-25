Return-Path: <linux-kernel+bounces-833349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFCDBA1BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFD9620302
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCCC2EA491;
	Thu, 25 Sep 2025 22:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YSTdph7r"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E353722A7F1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758838202; cv=none; b=sH0uHsY84wKMy2HQF1B6kwXtpS6DNSnEcbS39TXYMVlMS6GgLm4h5I/134cvydJOns0f9BzLPf9S8lDl8725E/LJ/RoiO/0E8pfqLa/l2xHMUPeRKR3t7mMrt7v0ldbBYMwVfrbKl4nbjeusx/xdX4EiJw18CN3ANhPYucviEIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758838202; c=relaxed/simple;
	bh=0yiMOyNmQe9XLRJre198NoibIv0CW/7k2GZaTA4V0b0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CNQSl66QfgnLLAhcJNFCKJELWeZA167EfTfcZoLLX6y1TMnqVxPJoKCYqUwIjvKs/kfemwVZHgGcav0mJYjpzXrDg9Xix2iLY8AYmW2qhRIzDed5Dh1V5x6nZIdz0U1U6Iu6yGEh+EJifbaaPsFzfCrvEtsRFBtU8rc+YVp1Fco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YSTdph7r; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8cc0cb783ffso131066539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758838199; x=1759442999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5F931YZwkJbINas/BIVVF3jlbLDJKn6Y36UYXUc7+uA=;
        b=YSTdph7rRAfjv2gI3Zdpl7f7y9yZy7e4fmQCXKksGOw99vRS9Js4iikyVq3HLaPNO1
         7a3Py0kd7EiKdzfBoU/xHnhR6TyDhoxmWWrBGJwFwAAT6GcQjlTfmN2ULgDeJK22k5yz
         dTPl9LCQlOiplV5rC/9R2Evni/ZPLRuFMm+3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758838199; x=1759442999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5F931YZwkJbINas/BIVVF3jlbLDJKn6Y36UYXUc7+uA=;
        b=Rr/TTO7cu00xcW+ojgEkByxmSgm3BGmNv5oXUUUcHO6Z5kewFLE2qiq3nBbkNICYl7
         PGQsfFdvY5bXhcbY1yBPg65qku2ZL/rv56QtmT7zB3n0HKVzBDJqOvNyIifBxq+UgUnB
         CPwDHU5ECcrOEzrgB81G2nA0CB/yvKF514oXrk5I8iuhbREU+U8llScjAst3ayFw9LJg
         0hCGCy7E/cedCnfaqUuY7bBCUIWHWPnz9t+PQd5iF9J2MRPEX1hW89bno7JOCckslLXA
         ooyuKKciW1ybsNdM31hrG0FzT5dJfhXGmEe9kkx5/FMVd5FAhS4kySOjBq7Pj11cUIh+
         sO4A==
X-Forwarded-Encrypted: i=1; AJvYcCWNj3vPPAFpC3DvatKPW2Q06+Nc6HnDlCpuVV2jQC2Dg81Snw00+pSSD/kPJzcedzzebyvzsWYUn45Yveg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyokPxjH/1UfhEMig4/ys7OucSxnGJjyZ/ObEeApGq4hbraAias
	yKP7op0WWx8BXiGNVr7vyMmtJIgDY+fumqt7Y1F87cTwxuRtDZC1qhvcO7y7lbK4vHg=
X-Gm-Gg: ASbGncvg6len1o6QWfsw0cd43CqDbNEzggZ3rXe0EA6GqyxhbLjr+7wCdco47Xozetn
	Bn9F0S5H8nq1KrpQw0LeMVpVUmDDPIA+XMuwXRjPgG1hl16uaZiVnCX3eXErgt1EYGmxdbf1lDJ
	7aTcJ9H3B/qDoGuhus73PqLuKoz+ZU5h0rnXvrIaKOBEi2XW0BeJiB1E5rVkKjjptg3yjHrBFAi
	c1ARFjQAElM4hPck+k8iSXy5pg+7AYu+nlz0c9DNUu4oYjJKNzEucYagtVVmVXTLOl6GdBpXsVi
	OGfAkDhZR4zQeEG+YLkVtr3az0nGzh6p5oXhDfBAASei26uPgYripgZ/QNw/9oTuMyUnpVZK1jB
	AzuXnscj3w6zWiLjYDy8+VBl8hXuK+G/TtbM=
X-Google-Smtp-Source: AGHT+IElTH+idLEkMLWpYPJrsfBBebq4PFg6ym32/EYuVSfzQpng/Clqk1K1iCi/3y1Ps9TK7idaEg==
X-Received: by 2002:a05:6e02:18ca:b0:425:8d9b:c430 with SMTP id e9e14a558f8ab-425955bcfc6mr84049935ab.6.1758838198820;
        Thu, 25 Sep 2025 15:09:58 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-425bcb5f6e9sm14456345ab.19.2025.09.25.15.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 15:09:58 -0700 (PDT)
Message-ID: <5900de48-e4a4-45cc-be7d-c906a59ba04a@linuxfoundation.org>
Date: Thu, 25 Sep 2025 16:09:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add myself and Barry to dma_map_benchmark
 maintainers
To: Qinxin Xia <xiaqinxin@huawei.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Barry Song <21cnbao@gmail.com>,
 shuah@kernel.org
Cc: robin.murphy@arm.com, jonathan.cameron@huawei.com, prime.zeng@huawei.com,
 fanghao11@huawei.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 yangyicong@huawei.com, Shuah Khan <skhan@linuxfoundation.org>
References: <CGME20250917011807eucas1p2dc0c24ef4ad8effcc1a2174d54cf4161@eucas1p2.samsung.com>
 <20250917011759.2228019-1-xiaqinxin@huawei.com>
 <11183850-d6d6-46c9-8079-330bf4c541e3@samsung.com>
 <CAGsJ_4yno_a2vD9OHhruXbNOXuVKg97NcOdFHpe283FJ9hXL7Q@mail.gmail.com>
 <0c59d099-4844-4fb2-80e0-6d3fc0077985@samsung.com>
 <ae8a2c37-74db-4e53-99c1-fc7f86e80253@huawei.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ae8a2c37-74db-4e53-99c1-fc7f86e80253@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/25/25 07:11, Qinxin Xia wrote:
> 
> 
> On 2025/9/22 20:20:39, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> On 22.09.2025 01:50, Barry Song wrote:
>>> On Fri, Sep 19, 2025 at 2:17 AM Marek Szyprowski
>>> <m.szyprowski@samsung.com> wrote:
>>>> On 17.09.2025 03:17, Qinxin Xia wrote:
>>>>> Since Chenxiang has left HiSilicon, Barry and I will jointly
>>>>> maintain this module.
>>>>>
>>>>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>>>> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Thanks!
>>> Marek, would you rather merge this into the dma-mapping tree
>>> instead of ACKing it, or would you prefer it to go through
>>> a different tree?
>>
>> I expected it to be taken by Shuah, as she is responsible for the
>> tools/testing/selftests/ directory, where the dma tests are still placed.
>>
>>
>> Best regards
>>
> I'll send V2 in the next version to fix some of the review comments of V1, and maybe there's some discussion about V2, I think shuah can deal with the patches of MAINTAINERS first :）

I can take this patch through my tree. Are you sending v2?

thanks,
-- Shuah

