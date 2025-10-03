Return-Path: <linux-kernel+bounces-840966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F67CBB5D5F
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 04:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59CD04E6344
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 02:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFDF2DC797;
	Fri,  3 Oct 2025 02:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnIlQtUE"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA7F285075
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 02:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759460098; cv=none; b=TvW43HWjbOoQtlKh+AIwCX2tn1xlDHvabC1HspE3IuUsSycJol+JTB4I7stxk58T/il4ImjzthaYiO7jsyJAdds58XDItFfVbbSleg8ilOLjE7r8x8n/sJ/Ljm0wNrYNAt19id+MFsJIg7V8jUdVMCqz5hXgGx7xGtuPCiaiGMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759460098; c=relaxed/simple;
	bh=zNkHEuJVcSdpiI1MRp9r77yl75HJaLMzCEdVht9Va0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vk8haFosREDXYnaQWFhk/P/FELgtQ4d5hNOB7e9ZQHb6MkxyDvIRXDdYXRb2XGI5uNLEro2AjtYJ2Ov2V4FPf5wGIyIfySiJmM4OJsidbEk2+w/3nX+sbjFA6ALnZpc/MoH/5bPI3Fz8v8l0Yf7pwW2j7J2vjmwLPCTf2TFUViI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnIlQtUE; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so1475720a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 19:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759460096; x=1760064896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uj+HsnSbfmp0p/fW3brW5cAZgBwxJkwcNWmslQDo1G4=;
        b=UnIlQtUEJfeUJCsjdCS5ELp2T3pPZQ80QwaY/OxoHQhmiUjCUhxd34N0gGnI1SFzLD
         sY7LnTSvX7CSV8Y0eMnC9gT7NDUMMvs4Z9IaVnQBnrQRg1CGy+DsTAcaGN+KU6m5xokt
         2lgRWw+CtdEcAZodtorYYKVT99B3bMZmsG4gQf1aH7yb8gdzOhKpQUdq1DeYgAfrLuiK
         BQLbEWXs6kKvJcVP54VT+R0rmfqfToqvS54dWr3UfnUZKYKr4qLATWzQXOCNXtRJJsqc
         BBRPs3pE1avUvH2TuMyFPu5dKjHT6b3FmEfPCQU0TXGtbyflsRWg2pIYOm5+4ADfWtgs
         FUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759460096; x=1760064896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uj+HsnSbfmp0p/fW3brW5cAZgBwxJkwcNWmslQDo1G4=;
        b=iBMgf8yZkInW3Y460DvaniKJJECziVsE3VXZe5+XU6oFucp30j2EZIqCq/EE9YIAqS
         RvfjZ6eH86sph5DX0AKcRrNcOW7hef+v0xaFAJ1wEcNiZoi1RcAae06Eb0webqg4xydB
         uc2MRDe+sDzD4SoYm5Zsh6/A7DSMv682kEAe4EiK6eO7/EamJJegiluZ9TVb9RoOh1C5
         h/GPYbLVYf8VeWielBNSYVgC8oxSWWF4ZhV6Obm6LirzoN9OWyJ7JHmJXhqTJ74pn0wU
         nExJPitS7Y8lrksbyEGyaXnBuMXrIRlt3DSrkqp1ZQ8xV89CjR8xbVFqIve33SaY9BPi
         qkuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhjfCmR0w4kuZO0SFTKJJrScympH+soJCFPxjFjiCOd9b/FMHqyZ3f6SkqscCIPmW7uDgS/59Vq2eZMIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIMQCyxN1LtMSTOa8iDj7tMfv5kLu/y3Es7rt8X252FwH+wJk6
	H2CSFohR3okDgSvhVYTEdNRc9aU/GfmQsAdCsAQTcfPe6x+F/h9VHaRB
X-Gm-Gg: ASbGncuSSXZQzAB69vWizO3dGjBgcFuOpXJ2FBOHK33SUwXRU+INSUFFQGshj70CvrP
	E1IsoTFzUSCK7ilcwQLaH6gOnGneJYi+aDZ8NwJhuZSpLZIihxzIe2P+lBYwO9Cfj0InOmbGzDZ
	AVWt6lJMu8jSHA6pxmHKgRQC5pHpXzJyfpZXFAQVZfCyyUxjp/4gorA2/L/hmkefSg6IcPgK12a
	NYxB5drgwOg7slID2dWMHBA6BnwWU6Kmz0bH7ptjrII8fn/mS49twwGSwbfxIW/fWQxcVz0BzHs
	VYlfYCmVgIWmxdt8D9c0gUYTXDJP33kfTxDXhNnOg84F/YC5X78cuheDKGHOrgJrW6VLYzOSt52
	uloZNWX4x5xKNBMMJfv7V6+MnyE47PrgFw9Ipj31ZT1z9F9dkv3vmQKgUXtOfgkefYSVPjOipu1
	3k6onem0YidPYUqH+DlvzV
X-Google-Smtp-Source: AGHT+IEVKNL0o4ldDH2FRH6zfpnRFEkoscOaBC54PgbA7oSF06twsPqHvysrSkFLtlowFRvbJJ2E8w==
X-Received: by 2002:a17:90b:4b4f:b0:327:734a:ae7a with SMTP id 98e67ed59e1d1-339c2732dbbmr1531840a91.11.1759460096299;
        Thu, 02 Oct 2025 19:54:56 -0700 (PDT)
Received: from ?IPV6:2601:1c0:5780:9200:326a:8939:a05c:b9d5? ([2601:1c0:5780:9200:326a:8939:a05c:b9d5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a324ccsm516382a91.18.2025.10.02.19.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 19:54:55 -0700 (PDT)
Message-ID: <318392fd-9700-4570-bb39-31a4d08bd4a9@gmail.com>
Date: Thu, 2 Oct 2025 19:54:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/vblank: downgrade vblank wait timeout from WARN to
 debug
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: maarten.lankhorst@linux.intel.com, maxime.ripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
References: <20251002025723.9430-1-chintanlike@gmail.com>
 <aN5klZdl2MZdPSpU@intel.com>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <aN5klZdl2MZdPSpU@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/2/25 04:40, Ville Syrjälä wrote:
> On Wed, Oct 01, 2025 at 07:57:23PM -0700, Chintan Patel wrote:
>> When wait_event_timeout() in drm_wait_one_vblank() times out, the
>> current WARN can cause unnecessary kernel panics in environments
>> with panic_on_warn set (e.g. CI, fuzzing). These timeouts can happen
>> under scheduler pressure or from invalid userspace calls, so they are
>> not always a kernel bug.
> 
> "invalid userspace calls" should never reach this far.
> That would be a kernel bug.
> 
>>
>> Replace the WARN with drm_dbg_kms() messages that provide useful
>> context (last and current vblank counters) without crashing the
>> system. Developers can still enable drm.debug to diagnose genuine
>> problems.
>>
>> Reported-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
>> Tested-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
>>
>> Signed-off-by: Chintan Patel <chintanlike@gmail.com>
>>
>> v2:
>>   - Drop unnecessary in-code comment (suggested by Thomas Zimmermann)
>>   - Remove else branch, only log timeout case
>> ---
>>   drivers/gpu/drm/drm_vblank.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
>> index 46f59883183d..a94570668cba 100644
>> --- a/drivers/gpu/drm/drm_vblank.c
>> +++ b/drivers/gpu/drm/drm_vblank.c
>> @@ -1289,7 +1289,7 @@ void drm_wait_one_vblank(struct drm_device *dev, unsigned int pipe)
>>   {
>>   	struct drm_vblank_crtc *vblank = drm_vblank_crtc(dev, pipe);
>>   	int ret;
>> -	u64 last;
>> +	u64 last, curr;
>>   
>>   	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
>>   		return;
>> @@ -1305,7 +1305,12 @@ void drm_wait_one_vblank(struct drm_device *dev, unsigned int pipe)
>>   				 last != drm_vblank_count(dev, pipe),
>>   				 msecs_to_jiffies(100));
>>   
>> -	drm_WARN(dev, ret == 0, "vblank wait timed out on crtc %i\n", pipe);
>> +	curr = drm_vblank_count(dev, pipe);
>> +
>> +	if (ret == 0) {
>> +		drm_dbg_kms(dev, "WAIT_VBLANK: timeout crtc=%d, last=%llu, curr=%llu\n",
>> +			pipe, last, curr);
> 
> It should at the very least be a drm_err(). Though the backtrace can
> be useful in figuring out where the problem is coming from, so not
> too happy about this change.


Thanks Ville for the feedback.I am still learning as I am new here!

You’re right, “invalid userspace calls” was a poor choice of wording —
I’ll drop that from the commit message. The main goal is to avoid
unnecessary panics in fuzzing/CI with panic_on_warn, while still
reporting the error clearly.

I’ll update the patch to use drm_err() instead of drm_dbg_kms(), and
drop the extra drm_vblank_count() call per Thomas’ earlier comment.

Best regards,
Chintan

