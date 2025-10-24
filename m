Return-Path: <linux-kernel+bounces-869618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5324C08556
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BFEE4E6C17
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6EB30E82D;
	Fri, 24 Oct 2025 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm/awCpH"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFEC30DEBD
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761349237; cv=none; b=oheomXMhjPFaOpOHG5dno+TTGAu/q55BQ0yUIjH7RDJ9xUwK8gYBnnCabX3r8qU57KjYJXy3qJNlXep+KHABT+cJXTUfKfjE3RyM+yTjlFZqKE2NpaIsunl8gnwplQ+c5TCGLr4WDg4mJgqpK+ASdAC1lt1SfxvkQEgd8p470dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761349237; c=relaxed/simple;
	bh=jyo0+aHWbxH5klPLuZHnTIouT0P209eieKDP/+d030M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j87w05Wu8nbeNCsTd0uaKPgMyNovH913BJxdZLoxGcjE/vHSKynqTYvUyQO9IuOayYR+BmfMqff7rkRKWigHT+LPY1N4GnF8PSVyFf7VNBv+z4QaBjzfypkoIi7B9aDQ7i9ChC2a3q29wGf2Hd93XwFfWrtNIlMR2yiN68z59rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dm/awCpH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29470bc80ceso28933515ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761349235; x=1761954035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qqP5SuAkGaJ6RG6hOh0SZayfv/af2QObYCkolbIehz8=;
        b=dm/awCpHepfG+kqIBlW+tFv1cXm0LdexfcZC0zQ0tEeiOe+w9poVlcWrgoswbaap0E
         9mRndWpszwyPU0c6v3QVRBMLIy5KG6WQqgM2vKk8YURDstIqHk9T5QE2yGoQG6LuJNJO
         QlgJkhksTlEn6dGFm2/XvtNBRyplKGVNQXvjISHvgfwIXrhYdoZL/H8taGWpouIlaYRo
         q9/NZfPnnrJqc7og4il3Gc1Mo9/UR16hPL0s07MdVq2+7gfWQ9YB6RICNnftwngPuEqi
         esMYg5/qGLV3HLLOJtToSaJaxoV6t87Q0RvOqG253nvdOsQ9w8lT3iRUvLUCqYM7vxvy
         bmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761349235; x=1761954035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qqP5SuAkGaJ6RG6hOh0SZayfv/af2QObYCkolbIehz8=;
        b=Z8pxhJvvmo7ZcaS983DhlsNIrS5HqZL+JqCI7PG3UdcnOPf5Qkp7El+4Pov9EhouoJ
         dYHRBRau13QWsj2yPIlwg+HVVLY/HNHaMy1C7zO2z4ox+nn4WOcmyqtBT5qBgAlbuX9b
         DCfjgssuVc9jIBelxZljjxbhpLxOG1Gc2mJ6uqgoiRnfbm52ObMttYeDRW1yUh4RlQQH
         J+utlKq7KieQOwKCuZUUluiXq15oN9Qynx14myn3+4aX80/y0PBEKKdO6n5rAI7yvqVJ
         pnwmk4jKsMfxt5P9C//+GhBbBkm+lh+ra2q3nAWke15YXwDBjDM7Mmn/bxAW/YJDwbCU
         27gA==
X-Forwarded-Encrypted: i=1; AJvYcCUewDzeXKEXxMPToL4DMGSfw9aq056lijD9+udDO1CIKG8Alq4apqBECZ7QU3g4JtQyOiYhnkeLGVjMA7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrsNlM3u01+y5yol5KqvxdfIEM79Cqc1wSgTcv/UhDvnRXI6cC
	tpFL5qmrOTcMtIsLm5wmCT4sZR0LDrv1qKG21oeAGvizrwvJkQ/P+meh
X-Gm-Gg: ASbGnct6+WPI1o48dKB7g03iqh/BHAsg2BZkZNVrzhx61yZkxpF207UPZU7FUAIZFBm
	X0IAJ6FHUGFDdKXpdJXs8sndCsfSUJJXWYtphYec8ae6JgM9nJuSBAL91mzP14TuAIeq4fFcL0W
	zWFeAA3Vao5DJtEhnWFBpOZCdCg2qNV/PhAiAaQplzp2ZVpKWbsdh0QBxCBAK1/j4MkniO8ODrA
	uBjBWsVQM/AzNYnNx3auSMSvRjh6ZZJYDEpMAim39L0WJUs2Qo+189Dj2bfWUc1RnIBm9G5469u
	1+AQMNTDct0livHXAGt3XQVGCLJgGVgQb053M8taK7Ypa+boQpbAUWKQTKUiiyk3BFTxQges0jv
	Oo7Ee3Tc9naPNkp3f+FWLx5cXFHT3hCoy8mQkVOrHyzM52dkyXo6bHQMpTymD1qMMrA4+FP3evl
	3wUkN22LVrJVpLy1R323UPBGaccVuX3PQD+ktKs3qdiVnxPxlYmGO/kQIxm8ln
X-Google-Smtp-Source: AGHT+IGmljlFqxKaoLUBNWWhhLXqxmD/AGAuAbaOp3NrSOLjBnaDmgbR1ag9luX/A0wo93vsh9u7Mg==
X-Received: by 2002:a17:902:f705:b0:294:9132:75d2 with SMTP id d9443c01a7336-294913289fcmr28727695ad.25.1761349235081;
        Fri, 24 Oct 2025 16:40:35 -0700 (PDT)
Received: from ?IPV6:2601:1c0:5780:9200:47dc:e064:b621:fd5a? ([2601:1c0:5780:9200:47dc:e064:b621:fd5a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2789bsm4025335ad.62.2025.10.24.16.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 16:40:34 -0700 (PDT)
Message-ID: <f30cee98-1069-4f71-9aa9-613967f9922a@gmail.com>
Date: Fri, 24 Oct 2025 16:40:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/vblank: downgrade vblank wait timeout from WARN to
 error
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, maxime.ripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
References: <20251003032303.16518-1-chintanlike@gmail.com>
 <65f8a544-175a-4021-aa2a-9a9faf2f4254@suse.de>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <65f8a544-175a-4021-aa2a-9a9faf2f4254@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Thomas,

Thank you Thomas for suggestions!

On 10/24/25 06:58, Thomas Zimmermann wrote:
> Hi
> 
> Am 03.10.25 um 05:23 schrieb Chintan Patel:
>> When wait_event_timeout() in drm_wait_one_vblank() times out, the
>> current WARN can cause unnecessary kernel panics in environments
>> with panic_on_warn set (e.g. CI, fuzzing). These timeouts can happen
>> under heavy scheduling pressure or in rare cases of delayed vblank
>> handling, and are not always a kernel bug.
>>
>> Replace the WARN with drm_err() messages that report the timeout
>> without crashing the system. Developers can still enable drm.debug
>> to diagnose genuine problems.
>>
>> Reported-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
>> Tested-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
>> Signed-off-by: Chintan Patel <chintanlike@gmail.com>
>>
>> v2:
>>   - Drop unnecessary in-code comment (suggested by Thomas Zimmermann)
>>   - Remove else branch, only log timeout case
>>
>> v3:
>>   - Use drm_err() instead of drm_dbg_kms() (suggested by Ville Syrjälä)
>>   - Remove unnecessary curr = drm_vblank_count() (suggested by Thomas 
>> Zimmermann)
>>   - Fix commit message wording (“invalid userspace calls” → “delayed 
>> vblank handling”)
>> ---
>>   drivers/gpu/drm/drm_vblank.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
>> index 46f59883183d..0664aea1b924 100644
>> --- a/drivers/gpu/drm/drm_vblank.c
>> +++ b/drivers/gpu/drm/drm_vblank.c
>> @@ -1305,7 +1305,8 @@ void drm_wait_one_vblank(struct drm_device *dev, 
>> unsigned int pipe)
>>                    last != drm_vblank_count(dev, pipe),
>>                    msecs_to_jiffies(100));
> 
> Instead of replacing the drm_WARN(), could you please try to increase 
> the timeout? Let's say 1000 msec to be on the safe side.
> 

I tried it locally and also tested with syzbot after increasing the 
timeout to 1000 msec. The issue no longer reproduces with this change.

I’ll send v4 shortly with the updated timeout.



