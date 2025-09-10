Return-Path: <linux-kernel+bounces-809925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48609B5138A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD811888C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E4D30F932;
	Wed, 10 Sep 2025 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="Il9Cu9HN"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7253148D2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498967; cv=none; b=nYda2R82I0+UiixiKyGy/dIdJ6Uxzfu2YWONuNUxCC/Bq5VOQbUmVnrswXaQ2dNMKV/ztrag668tme2zrIXlHOBO0e89GzRzAmBtVuOiHFSFucGRpP8B7FT8zchEUVLH53eyrll/ptlxMCC+0S4dCDYzIOJW+pAzE+mvMJDSKlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498967; c=relaxed/simple;
	bh=+xjNiU1Q4Y/HmwrJgObchqMM+uTqwFUp0WcocpfeA4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LE3zj6001m+dZ5RQTop1lwYH82liYcM4Ju6Y65eETLNL50s2LZcIX19XMNU/npnF9ad1T5V+O/3EScIMpyf3XGgy1mg3dXjbOP6Hn5MgKBaWYBAUD8NbBKn3VGegJ5I4kFOvqGgZWxxxMbzQAd6Us3jpoWnedY3wG5Dxx4P5MUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=Il9Cu9HN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45df09c7128so4387965e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1757498963; x=1758103763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uOTuzZysV5kQ+YDTuaTugOko0DCUNkdlz/KqCUlCKRw=;
        b=Il9Cu9HNrI29p/shmEOTTyJdFcrK2Eab5s9eAtpeK6opSWYuYDBbQLZn+FMjo23Avd
         TGpSCPX2nS7G8qTu3mPTOreKktva3t0GJxnooirobAPh80lITQ0KkcUvZIDZbgQYM6ml
         BO5GVfjqTCn40se8CmKdFrgLvxoqThPres0GyvyrWjLjSfGq7xqK58tA3T+ELf08lQE1
         byUkuiSuH9126XJcuU+VXBHzOzCnOvworwzcPrG0ayjAg1mndKYlbzBW81Cb8i1OiH6d
         F1odKszovQaooX+Vkz0NaRFFcgCNdxQTF6M2NJY57Ae8NKOFAGKe9Fkp4lp8lv0bJedX
         Pxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757498963; x=1758103763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOTuzZysV5kQ+YDTuaTugOko0DCUNkdlz/KqCUlCKRw=;
        b=kVcibxkMRlgPI9MNnwKDQFyOX8r7441v2oFSjXMQxalCJyy+KoVdHFRJmmVZDHFuyZ
         NZP05a77qJzkv+9/y12f5h7hqIzqi+WwhLGfKNWazm8OHEWiyS83gCWimkp8j20e5gif
         L+b4Bc2U9ct+GNMkklbPcATsnAcMLg/mQaHZlvncqx0/v2jeAd2RooxDEEK1xADoE9oo
         XKtTrT5XX6grrJY1YCNlIJ1i83TaDMt7CEHbRPTh3lu7QLVbN8DiVXbG3fHohz+Pjhl3
         FYqze9miCpY2Oi7h+HCo1bLmtrpTBPeSxMUXfG8Sc5m0Tqgf+z0ff0HzAFbh23vRsOQM
         m19A==
X-Forwarded-Encrypted: i=1; AJvYcCU+U1UeZrvknEMFpyrr7VzDZe26oABSrcdommeDyMdWvq80UbRPzOr/ldTSxomVBilzsdD64XhVR2Rp3qU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVEhRMNf9LRNQoVs7H3vBeimpDQCHtsm50NIf8IDZ7q4UdLSAN
	hVgMmR2VN55UzxeaLI/xy1OtRTB2MXbdJ/VtCObRmfTiAlYAxfgmAIO/vx7qGH+l3E0=
X-Gm-Gg: ASbGnctnsl6xozu1s9lVfGp6qld4BBqGHuhU1gaKhioHBUqlVgE9+vZw+xw47Z0CA8o
	OILeXHHb9X1vWOh615s/uhCpLtkPnvGovI9Hu3lLgdMNYMXR84vRgMH6cjONd4bGe/MTE3keDdA
	9X2YewGOuj8WoeZfRFQz+cGKwh1IbaJE9nvHIGXjUQsVwIDAWx5ikCuvCp8EzaOR5JcSNkYLkhe
	Q/2tgDsZXV+if18zrGBan5B+PFWTO3Mx8PsINGLYVNrIxMPd0A+XyPTnDk7zXHpWNX4VeeXJxEA
	C5Ps6DRwq/pBjDWtt80kAqEJQav4ETaryTb2JGTQXiB0XXFkuNO96LgveMXiZ/5TsjC6w+Tjs+0
	Yc/vl/kLom14ibYoYNwcCQV7UTugxwhIrG1M=
X-Google-Smtp-Source: AGHT+IEPG+lyxFIlIpxH80LQ7aYbGd+s/txpQcAp+CxqWZwvUkzOGr9U4ZUXp3PY2MRxFE9ROgpc0w==
X-Received: by 2002:a05:600c:c0c5:b0:45d:e531:99df with SMTP id 5b1f17b1804b1-45de64869d9mr77361225e9.3.1757498962954;
        Wed, 10 Sep 2025 03:09:22 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df82037c1sm22413075e9.9.2025.09.10.03.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 03:09:22 -0700 (PDT)
Message-ID: <d51e11fa-54b0-41f4-9b06-95b46094de39@ursulin.net>
Date: Wed, 10 Sep 2025 11:09:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Replace kzalloc + copy_from_user with
 memdup_user
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250908211559.519892-1-thorsten.blum@linux.dev>
 <4005498b-d866-4e41-a8a4-d8228b2062e7@ursulin.net>
 <CADnq5_NDrq_S7rcpr6_MY-USfVGr8-QcJ2hqnai7VEm5D_OyxQ@mail.gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <CADnq5_NDrq_S7rcpr6_MY-USfVGr8-QcJ2hqnai7VEm5D_OyxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 09/09/2025 14:36, Alex Deucher wrote:
> On Tue, Sep 9, 2025 at 4:17 AM Tvrtko Ursulin <tursulin@ursulin.net> wrote:
>>
>>
>> On 08/09/2025 22:15, Thorsten Blum wrote:
>>> Replace kzalloc() followed by copy_from_user() with memdup_user() to
>>> improve and simplify ta_if_load_debugfs_write() and
>>> ta_if_invoke_debugfs_write().
>>>
>>> No functional changes intended.
>>>
>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 20 ++++++--------------
>>>    1 file changed, 6 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
>>> index 38face981c3e..6e8aad91bcd3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
>>> @@ -171,13 +171,9 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t
>>>
>>>        copy_pos += sizeof(uint32_t);
>>>
>>> -     ta_bin = kzalloc(ta_bin_len, GFP_KERNEL);
>>> -     if (!ta_bin)
>>> -             return -ENOMEM;
>>> -     if (copy_from_user((void *)ta_bin, &buf[copy_pos], ta_bin_len)) {
>>> -             ret = -EFAULT;
>>> -             goto err_free_bin;
>>> -     }
>>> +     ta_bin = memdup_user(&buf[copy_pos], ta_bin_len);
>>> +     if (IS_ERR(ta_bin))
>>> +             return PTR_ERR(ta_bin);
>>>
>>>        /* Set TA context and functions */
>>>        set_ta_context_funcs(psp, ta_type, &context);
>>> @@ -327,13 +323,9 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
>>>                return -EFAULT;
>>>        copy_pos += sizeof(uint32_t);
>>>
>>> -     shared_buf = kzalloc(shared_buf_len, GFP_KERNEL);
>>> -     if (!shared_buf)
>>> -             return -ENOMEM;
>>> -     if (copy_from_user((void *)shared_buf, &buf[copy_pos], shared_buf_len)) {
>>> -             ret = -EFAULT;
>>> -             goto err_free_shared_buf;
>>> -     }
>>> +     shared_buf = memdup_user(&buf[copy_pos], shared_buf_len);
>>> +     if (IS_ERR(shared_buf))
>>> +             return PTR_ERR(shared_buf);
>>>
>>>        set_ta_context_funcs(psp, ta_type, &context);
>>>
>>
>> More complete than the one I sent in June^1.
> 
> I never received this series.  I didn't see it in patchwork either.
> Seems it never made it to amd-gfx.  Sorry I missed it. I've applied
> the applicable patches now.

Thank you and no worries, it wasn't anything urgent.

Regards,

Tvrtko

