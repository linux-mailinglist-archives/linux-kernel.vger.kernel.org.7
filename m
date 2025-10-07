Return-Path: <linux-kernel+bounces-844001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AADBDBC0CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B2F64E818E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AB22248A4;
	Tue,  7 Oct 2025 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE2u6By2"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158F2EACE
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759827645; cv=none; b=q42nKq4RrKgdZLYsWqLOciMScBHSnWEfSl1Jrg9C3giafbHNecyUx54JFOebi+2ddri5KMLDftnMhPAXnEpjI8FwovCZr7h5oFj09elScmmTxQPxTz6SPLJqtxPExv2gx3npGEe/wTYKwJAzESde/MDYrwH8K/b0TQZ7ispFMV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759827645; c=relaxed/simple;
	bh=z/GtfcwCMRIYf28FfY/V57DZjTDHU5TCWA1AXextCVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8R+yhE8Bj5S9UWqHNiEH5DB183lFEpCGikCZQEUgmMTl3j0rvlMiiIHKk++xsafFlHEQ9k9Z6kde/CYR+6vvf0mrz38uwQ+NFDX+fck7oMAujnrbxs2MUPXxxDDU2kEMP4f+dOxG+2xDZxYVMHe7sTNuHiB7/fM218vT5e7eV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LE2u6By2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3edaa784f6dso288708f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759827642; x=1760432442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Xa6ifE/xlQHISGLdoOjoC3GElKqUAHWHKf7zodIGK0=;
        b=LE2u6By2KQ3KmynwTAldZ+1U6voP5RVZjTVHjoSybQpUz0HTfbBIKyp4reMygKmtFJ
         ZqfUCW3apGttiL5yaGbw/wk6GWbxdGopA9au8L037qf8OkPBLhFBXS/rrNOxKLr5LiOz
         BVXz8/5ddARn+PTtfcitmQ9GDm8AZ6fnjWcttNoqgE9X5frRKCGf2YoEwahNKOsU6Y4V
         QBRLn3sW6zKoae7rNkcceTTwz3Rlgwj4FCMUC18Rwjxo49oFu1IVTRPkIy5Dy9I41+Ny
         oXTst3nMrNQ4eIQKKpo0U80Uk1ePsaLG5H96TAFSqcLckyOE0wO5wPv/pL0276FoSJOa
         cMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759827642; x=1760432442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Xa6ifE/xlQHISGLdoOjoC3GElKqUAHWHKf7zodIGK0=;
        b=G7wjV+UIXxhDHekv74CGD+NYL6YGW8eBmoOuTpC3gnn9mzeorBJPQYOpzVtYLU+NEq
         VVKTRyE3rrvQMy8ArqmKhWrEA1sRdh2NVAMaseKBOm/a3xQ0evx5AZ10fqTiYM1C5gKb
         gDcsAzMHx9rhSyraEeHWRQno74RrDpnGpZvrjZs1dooHYZ4MqoOJqQQm+AQStr4yrOdl
         87mXhsyC7aCYq2+Hf5nu7QDZbL/QHkwhzpAgz8O4USASAUf8Qjt9IYc9tQZDauz4Nneq
         TBABW6Gifs+C0MVxDRYqrIv7uQ0wZxq95JsYufIBa0Nkqdf/+ExllNFeTOBdE0V13cmc
         kTVA==
X-Forwarded-Encrypted: i=1; AJvYcCUAtRFebaHTzG0AOHobCc4tWau4aRUr8978Tczk+ICOFafMOQpwyQtlxgWT0X29lqPEXSW8TgfOMS82QnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx052Q+U4Ft02Zv0eAoV1dgFq0ebtogWtOqMIBa9EbAhHfgmyTO
	HwNqtvHOI2j3e+5gzQK9zOWS6m+vCDzmDl1tPQdw2Y1jCX8wD4WigBhl0doylGUw
X-Gm-Gg: ASbGnctXcRh9KuXIm0GX9LakSyNTztMW4oyyHxQqunUWvtTPu05bzz5DOHdKzh/Z89U
	/AQXTmw48hswNk66ftzUJtCTYxNRcTSNBp/XYl88NR6SR7SEhA7gS6RF3WG4eZU9t1e+LMfOpkn
	L92Iniu2ckXY+391+Pr8eaBkS4hOktFWxNhcfRpy9l5+Q+IGRIpfX7XHmB/507YubX+DXzA+aBo
	RHsWE7YkIS6bFHazrCCc9rC+czJGvIKhcs4zhL02ZCy/RWMKhR87Wk53UxFuMaIDk5eYg6DXIBX
	oCGOyrdDwRXZbEDwxJAjOQmetpl5lVQOGMc/8Fhw0Yc8PjjZVVa4ocWUUlru3hOT7hPi0xYGhGa
	yBmlVDLcUPEQUaOpLr84qyX0bWozvJz6deGCKmbvnrepVBNoJ+H6PGqGSJR+NZTyWAr49Gw==
X-Google-Smtp-Source: AGHT+IHdxxupVPmhNAdLsdEEwrhmyDrL1qTVyuXmX4U9HVJoLYW50xyIBDHuslFTZC4TvnRMs+w1nw==
X-Received: by 2002:a5d:584b:0:b0:3ec:7ff4:23bf with SMTP id ffacd0b85a97d-425671c195amr4899519f8f.9.1759827642182;
        Tue, 07 Oct 2025 02:00:42 -0700 (PDT)
Received: from [172.16.134.209] ([41.229.125.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8abe9bsm24792358f8f.22.2025.10.07.02.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 02:00:41 -0700 (PDT)
Message-ID: <d087a2c8-05f6-4fc1-924a-c3a84eae119c@gmail.com>
Date: Tue, 7 Oct 2025 10:00:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/gud: Use kmalloc_array() instead of kmalloc()
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, mingo@kernel.org, tglx@linutronix.de, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org,
 rubenru09@aol.com, linux-kernel-mentees@lists.linuxfoundation.org
References: <20251007083320.29018-1-mehdi.benhadjkhelifa@gmail.com>
 <bef19ef2-b22d-4adb-9513-b267d0e53330@suse.de>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <bef19ef2-b22d-4adb-9513-b267d0e53330@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/7/25 9:58 AM, Thomas Zimmermann wrote:
> Hi
> 
> Am 07.10.25 um 10:32 schrieb Mehdi Ben Hadj Khelifa:
>> Replace kmalloc with kmalloc array in drm/gud/gud_pipe.c since the
>> calculation inside kmalloc is dynamic 'width * height'
>>
>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> As Ruben already acked the previous patch, you should add such acks to 
> any later patches. But no need to resend a new iteration now. I'll add 
> Ruben's a-b when I merge the patch.

ack,I forgot about that. Thanks for the heads-up.We'll do next time!

> Best regards
> Thomas

Best Regards,
Mehdi Ben Hadj Khelifa

>> ---
>> Changelog:
>>
>> Changes since v2:
>> -Reversed width and height in parameter order.
>> Link:https://lore.kernel.org/all/20250923085144.22582-1- 
>> mehdi.benhadjkhelifa@gmail.com/
>> Changes since v1:
>> - Use of width as element count and height as size of element to
>> eliminate the mentionned calculation and overflow issues.
>> Link:https://lore.kernel.org/all/20250922174416.226203-1- 
>> mehdi.benhadjkhelifa@gmail.com/
>>   drivers/gpu/drm/gud/gud_pipe.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/ 
>> gud_pipe.c
>> index 8d548d08f127..c32a798ccadf 100644
>> --- a/drivers/gpu/drm/gud/gud_pipe.c
>> +++ b/drivers/gpu/drm/gud/gud_pipe.c
>> @@ -70,7 +70,7 @@ static size_t gud_xrgb8888_to_r124(u8 *dst, const 
>> struct drm_format_info *format
>>       height = drm_rect_height(rect);
>>       len = drm_format_info_min_pitch(format, 0, width) * height;
>> -    buf = kmalloc(width * height, GFP_KERNEL);
>> +    buf = kmalloc_array(height, width, GFP_KERNEL);
>>       if (!buf)
>>           return 0;
> 


