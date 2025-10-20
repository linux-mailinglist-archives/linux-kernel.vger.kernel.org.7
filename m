Return-Path: <linux-kernel+bounces-861765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B340BF39DC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35FA1884FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C442EA729;
	Mon, 20 Oct 2025 21:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5yuW/b1"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96F42EACEE
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994041; cv=none; b=aAyXmOtOelb+3Gyk3GLbRCPML0OGpvDXkLf9Vbo9mV8esN6Sheo4BGgJt0hEEb7BRu7eIg/cIXgvdPk6r8KpJwXqjvCadTel9E7PY9YCtRDbogIn4z+QQJxw9GXpmb+/kOu0BEbdlY2PQilrGp/xlssU2kkyTeBRFmxOQ2R+tGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994041; c=relaxed/simple;
	bh=jqRNVk9JPPRXcEvQPe8IyfklN4EpKEZuwb6rk9nv4UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMBEdzERCW/Qr/xYPD3V4hanxEJcrA52C3+xZjgjQinQprbMJXDDd22m+OKt0laIdGPUzIKuAR8sDJzgynF9SPUWzl+9IqVc4iCpiFfjJxzuqSdvpekRd0W6FS2EoLM+euzHMCzqvM2TKSZuXozG165oeT+tYyHL/jiThFIThQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5yuW/b1; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3f8d2180feso75245966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760994038; x=1761598838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tI1RtufrnCfn5YC744MSI0dkUCZVt+o4Wi2kRqCU9cQ=;
        b=B5yuW/b1uwfqxoHrMbPnFKZjKakEvZtIR4rH3d2qmVDqiU8gofzN35Ke5Y8EGsfkTS
         QUUKETYyPl3bamn797m3zMln4I4PR7eIJunS6eQbue6w211ZrqdMZZ0s+FW2ZKXQ8gLG
         J3P9oY5KwUXhn0e0Mfd1HaMECnl6IF10wV6wSB14r0mMj+xE4bwnXTTIV8sIo4ArivoV
         AQNcPQiqeuKfGBhhxrK7l32F2s0UbFvACOZffzgvGDbWHL6oiZTUowBZ48QONBc8wlei
         cmShvpu4Dgax3l9cGIiUaPVlG5kMILBI+z0AFlP97hD/fkO+3nMRWYjgqBNrNZ1Z+zwF
         0Z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760994038; x=1761598838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tI1RtufrnCfn5YC744MSI0dkUCZVt+o4Wi2kRqCU9cQ=;
        b=cMoJ98mLdQ+ICblXy+OnEKhxkRwDsIoYsMdYrwILSyFjC/PO1Xrnu6OFgD+4p3A6Z3
         e1UHWrHL33sfkIX0LtyzgBT2lQ936OGU7NL+++QHgh+n1e3hNAAGA6AWZEfYfgcX7WCp
         k+ONF+kcN/3e5ljWlcikNemVRN+5bCrZIkpQ62dqWbRVX+sp92FTUkQAJB9iJfzO4ozB
         +uGEdLYN+DeOkwXx16oCmcUEeJTYoQKxm0RuVAGP0Grge7FBPhoF5cDPXaigtzRX0PhQ
         cBZaGMnbDLBnISwW+iyKZjBukyRo3booU5JI79hljIRVXjvJST73j+boYE+ndbijue6i
         MjAw==
X-Forwarded-Encrypted: i=1; AJvYcCX7us9T3/CTINTtujDxmB1ro5Yopd1zBuLVqr6iezHc1GYnJ4hoVG/N20fAO9aI+sF0XS/aOvKZvWFfkJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzixlT1myZSFu9cBUksQAiWBe2R6n61aNZWCOkkrq3r/k264wuy
	Gg6QfyYxSN/+j+7gs3POybCCVJPibc1z6ZReVE793KboG75Ko5Th2t7P
X-Gm-Gg: ASbGncu1xUVUMACP2bTuGQ88mMqfOMvtuOrYlI+Do1KR+RW369Y5qnNghXo8cC2fDsb
	7/CQu66VnsIWxwv94ySZIxkBW8v9BTXkJNHUjlBPL426kPJzUndqO2FXcHgXK011TMckuFou4b9
	lCmHrRctcsVvytRbTqs1AmA88JRD4/tTYaOUKMWgjP7wconVPM8IR+f1PmnFQE8iAbEs5HwwmLB
	szgjMu0ZD32e7BvSu1esZEB1kQLHvWHxf64niOluWHkORRqjBvbaLVK5OYcydFqUAM9om4z1esv
	q23DJO9b22Uy5XWJT+QD5f+S1VQsGZvsZYeMsLYAOxexOQzAxKS7OqkAZ0YYYiI1x9v4kDMJHuK
	bwUxpP5Wwf4SF0KLA805HBeognc8Z+mUSePuQhrTRzP5tUu5uclrfyUQk1p4ryZGzFMfPoctlF3
	y8vgSoyj+KIZ4VloVEQNwIXZYOCkxq
X-Google-Smtp-Source: AGHT+IEaUHrZm36TzujHB3atkHpPtOn7/1/PguhG61tVYMTx0+WCsxhMTWkx0TTDhC0ihbzPgU9YGg==
X-Received: by 2002:a17:907:2d29:b0:b50:891f:66ae with SMTP id a640c23a62f3a-b6c78839802mr77886466b.9.1760994037800;
        Mon, 20 Oct 2025 14:00:37 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.73.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e838b946sm872537866b.19.2025.10.20.14.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 14:00:37 -0700 (PDT)
Message-ID: <1a25af58-3504-4b98-9d1d-63974491ee95@gmail.com>
Date: Mon, 20 Oct 2025 23:00:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tiny: Use kmalloc_array() instead of kmalloc()
To: Shuah Khan <skhan@linuxfoundation.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Greg KH <gregkh@linuxfoundation.org>
Cc: lanzano.alex@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251019151247.171558-1-mehdi.benhadjkhelifa@gmail.com>
 <2025101910-dipper-suburb-1755@gregkh>
 <cb0f0a36-0593-4d4c-8450-d086b9c99d87@suse.de>
 <d072dfe7-e0e9-49f6-89ed-25d194035e3b@gmail.com>
 <02e617bec795d2ef371069f2d5fb954dfb31a450@intel.com>
 <ea12faad-1735-4a49-a70d-d4cac5629042@linuxfoundation.org>
 <b0b1c2e9-c367-4e9c-b931-d3e1b0ba7f5b@gmail.com>
 <21415b1d-17c0-42a0-961c-a4aee16d20d1@linuxfoundation.org>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <21415b1d-17c0-42a0-961c-a4aee16d20d1@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/20/25 9:22 PM, Shuah Khan wrote:
> On 10/20/25 15:11, Mehdi Ben Hadj Khelifa wrote:
>> On 10/20/25 9:06 PM, Shuah Khan wrote:
>>> On 10/20/25 03:50, Jani Nikula wrote:
>>>> On Sun, 19 Oct 2025, Mehdi Ben Hadj Khelifa 
>>>> <mehdi.benhadjkhelifa@gmail.com> wrote:
>>>>> On 10/19/25 3:47 PM, Thomas Zimmermann wrote:
>>>>>> Hi
>>>>>>
>>>>>> Am 19.10.25 um 16:34 schrieb Greg KH:
>>>>>>> On Sun, Oct 19, 2025 at 04:12:28PM +0100, Mehdi Ben Hadj Khelifa 
>>>>>>> wrote:
>>>>>>>> Replace kmalloc() with kmalloc_array() to correctly
>>>>>>>> handle array allocations and benefit from built-in overflow 
>>>>>>>> checking[1].
>>>>>>>>
>>>>>>>> [1]:https://docs.kernel.org/process/deprecated.html
>>>>>>>>
>>>>>>>> Signed-off-by: Mehdi Ben Hadj Khelifa 
>>>>>>>> <mehdi.benhadjkhelifa@gmail.com>
>>>>>>>> ---
>>>>>>>>    drivers/gpu/drm/tiny/repaper.c | 2 +-
>>>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/
>>>>>>>> repaper.c
>>>>>>>> index 4824f863fdba..290132c24ff9 100644
>>>>>>>> --- a/drivers/gpu/drm/tiny/repaper.c
>>>>>>>> +++ b/drivers/gpu/drm/tiny/repaper.c
>>>>>>>> @@ -534,7 +534,7 @@ static int repaper_fb_dirty(struct
>>>>>>>> drm_framebuffer *fb, const struct iosys_map *
>>>>>>>>        DRM_DEBUG("Flushing [FB:%d] st=%ums\n", fb->base.id,
>>>>>>>>              epd->factored_stage_time);
>>>>>>>> -    buf = kmalloc(fb->width * fb->height / 8, GFP_KERNEL);
>>>>>>>> +    buf = kmalloc_array(fb->height / 8, fb->width, GFP_KERNEL);
>>>>
>>>> Also worth emphasizing that this is wildly wrong for any height that is
>>>> not a multiple of 8.
>>>>
>>>> And I thought I shot down a similar patch not long ago.
>>>>
>>>> Is there some tool that suggests doing this? Fix the tool instead
>>>> please.
>>>>
>>>
>>> They are documented in https://docs.kernel.org/process/deprecated.html
>>> Mu understanding is that this document lists deprecates APIs so people
>>> don't keep adding new ones.
>>>
>>> I didn't get the impression that we are supposed to go delete them from
>>> the kernel and cause a churn.
>>>
>> I have sent an appropriate v2 specifically to suit the case that we 
>> have here. But the document[1] specifically quotes the following:"
>> Dynamic size calculations (especially multiplication) should not be 
>> performed in memory allocator (or similar) function arguments due to 
>> the risk of them overflowing. This could lead to values wrapping 
>> around and a smaller allocation being made than the caller was 
>> expecting. Using those allocations could lead to linear overflows of 
>> heap memory and other misbehaviors. (One exception to this is literal 
>> values where the compiler can warn if they might overflow. However, 
>> the preferred way in these cases is to refactor the code as suggested 
>> below to avoid the open-coded arithmetic.)"
>> Specifically mentionned the refactor of the code base in such cases 
>> which is why i'm doing the patches in the first place.Also i'm trying 
>> the best to send patches related to the issue where such issues of 
>> overflow are present or to be consistent with the same API used within 
>> the same subsystem.
>> [1]:https://docs.kernel.org/process/deprecated.html
>>
> 
> How are you testing these changes? Next time give more details on the
> where you found the problem - it is easy to miss the link unless you
> state that it is coming from the deprecated document.
> 
For my testing I have used a raspberry pi zero 2wh with an e-paper 
display to test. I have installed the custom kernel with my 
patch.Confirmed module loading in dmesg and ran modetest with no signs 
of regressions or errors in dmesg.
If further proof is needed I will be happy to provide it.
I will be mentionning the deprecated document more clearly next time.
> Even so you have to explain why the change is applicable to the code
> you are changing. How are you testing these changes. I have seen more
> patches from you in drm drivers and lib code.
> 
I have sent a v2 and it has the more suitable changes for this case as i 
said which was suggested by thomas. here is v2.
Important to note that my last testing was on v2 changes.
Link:https://lore.kernel.org/all/20251020115803.192572-1-mehdi.benhadjkhelifa@gmail.com/> 
thanks,
> -- Shuah


