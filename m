Return-Path: <linux-kernel+bounces-864823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E445BFB9ED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95BA3B3F02
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0210336EE8;
	Wed, 22 Oct 2025 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="J41xu8Kl"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B62B32861C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132210; cv=none; b=k8RDnF8nvqfNzDfTVarTqgAEFgwfdGOpZTOTBPhf9PmIV4lep8F3e8dVgZ0sKT4VR2+JyJeKHf3i3lxrUUbXadmJnxbY48Kk4+enrvP34eHwZwnCT6bxsOwgg+/mbh3ayZU6y2FwJIcU+1fBF3gpbz99eF9vwhPoqYk2n2R81TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132210; c=relaxed/simple;
	bh=pux7Gftl3kdbJdsfJg60JElS64sO0dvQBi7V8W+jdLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fs8mnvr/Oiuhh74B7ZoskH4it9jJG7UOEMMBrYtgye3CZNIgA01vfdQjUbuCggXFPcNuUvMS+3CODaWEnj4j1h42rih31NaVdIBwdz1g9XlF2Oj6h0lxRUncpKRXXZpuuQO2YvfXPox1vWH0T58Ov6fWH1lR62iZhdc/I+uINUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=J41xu8Kl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-471bde1e8f8so17267625e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761132207; x=1761737007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kjPYwjUGUBLIRYRVo/Xv8w6fNKMNsLf3PLH0iArVM50=;
        b=J41xu8Kl60uirrCh1ZYuDzQzNGyHUSVkM/zsLgpEAe7Zy6P5P+dSIUprk7Pe16aTZg
         +V6Z5F1BFC0fCcNUhJ1kGR4ZaME6wROMJzQdY3y83SjVlIaFwYpNft0LARWy4Z/ntyBD
         5wsumEnNH5JyjTF+QJ6HG8jNtbcS4Xm80M/h81aDEo5fRoipsf4zNQouKtx+fiDp+BMD
         0AGk6rHkR3HYXgA+nXdTNrOdXKhT+LRQSFoVHsoznVTMkCX+xNjQ9J1WWLcIIqe9V7oI
         s++Jk6veK5Yk8vO3ruyL1EKWsHr9SlB4f4RWhgnCCSvZWP50zOAUk9at8489kZM207J2
         6qqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761132207; x=1761737007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjPYwjUGUBLIRYRVo/Xv8w6fNKMNsLf3PLH0iArVM50=;
        b=bZBL8O4uXV25tK1bSp0L+0k7b97WUPAXC3V4t3iLZzZBirY28EsucW6Dr3EujdBo2O
         aWZ910AR/OHuLX2mz3YrBCOqVJ1t9iMIbIkyq9UMgwuhXmRCDDRvCIPcoXev9uYaL+O3
         f1WtKf6AaKFPSszaXVaqulkL9fB7eXc0ux/2mjxMsl1snB72fSklW+7Rr3xCnGJciwWh
         W2SBc838A+599IDhf83nuh9LV7xh7joxHlCXhofT6xaOeufGVv4yIxgaUyWXpF7F6lKX
         8YMScswiZpardg/CHEcPJvU/QtraJDWXXYs/oGO3JZ3qNvzeEyArqXYqegRLfHsSeNLa
         3f3w==
X-Forwarded-Encrypted: i=1; AJvYcCVuMbNEMU43gv1dxeTMPKU/UfpPEa6yQAx9kPZTce7420AXI9BuMykikAiLmY8hSHMlUmkqW/L4GUzlME4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeEe+yltme9hcbImpT35/ynGL2+XuX2L3dWOw7+KS2fg6VoI9g
	4cbloaoxY7aLcqAfOeOclDKqscVN2shbcWCata5vx+0gVna8hiEtlPE=
X-Gm-Gg: ASbGncswx9PM2El1BAm09XRCsU5q+dWe7HKkZ+OSW0zh+fgvHd4Hf2DjufdhPTs6Cfm
	dljGHDQTol3Vb3EcvfK2UBn1IAuzowgCMWsWUrvACE1TN7gDQIrPam53tNpjTi5d4Dm661OgqNW
	daoMoOHI0x28vBFpHlU4NUNJzIeOgUuZdJ+J3JpUVeaQ03bIXkNjmI2fqtpa9JcwcgzA+lT5npq
	4G7Eipp2INN0aW05Kzrsb+mx9NdV4upeknhf8iUlYnvZYlumXqJC/xZ/A3psLc9ced46O2D0mmH
	agQbSHHPqJNOxW87WylpZOcCX+MaZia3vRx575V0G8DLcSNbNCezy0b3LlzfLZ4ejhx9K83Jubx
	lk8jycLi9RqIRfwwfLOAZO8xoRVm7+vL+k9UOP3L/tixpWdko1JsQateFx3Pu5WJuhSlDfcXEJn
	cmeACNGVIWubtTRFiJpdvkliI8PbRKvCOmEs1riOJ+Tnu2zGdqqvC8NrsXGKyQwQ==
X-Google-Smtp-Source: AGHT+IHvaWk6lF5t+4jkEZNj4fCR2v2SPRQO7ACJdqn9xWJPRqdmrWzxShh0nYRVjV+WCcz+aSXGQA==
X-Received: by 2002:a05:600c:6291:b0:470:fcdf:418 with SMTP id 5b1f17b1804b1-47117911694mr151571175e9.27.1761132206345;
        Wed, 22 Oct 2025 04:23:26 -0700 (PDT)
Received: from [192.168.1.3] (p5b057850.dip0.t-ipconnect.de. [91.5.120.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496afd459sm36880475e9.1.2025.10.22.04.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 04:23:25 -0700 (PDT)
Message-ID: <3ca10b2e-fb9c-4495-9219-5e8537314751@googlemail.com>
Date: Wed, 22 Oct 2025 13:23:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [REGRESSION][BISECTED] Screen goes blank with ASpeed AST2300 in
 6.18-rc2
Content-Language: de-DE
To: Thomas Zimmermann <tzimmermann@suse.de>, regressions@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 jfalempe@redhat.com, airlied@redhat.com, dianders@chromium.org,
 nbowler@draconx.ca, Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>
References: <20251014084743.18242-1-tzimmermann@suse.de>
 <a40caf8e-58ad-4f9c-af7f-54f6f69c29bb@googlemail.com>
 <43992c88-3a3a-4855-9f46-27a7e5fdec2e@suse.de>
 <798ba37a-41d0-4953-b8f5-8fe6c00f8dd3@googlemail.com>
 <bf827c5c-c4dd-46f1-962d-3a8e2a0a7fdf@suse.de>
 <5f8fba3b-2ee1-4a02-9b41-e6e1de1a507a@googlemail.com>
 <e2462c92-4049-486b-92d7-e78aaec4b05d@suse.de>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <e2462c92-4049-486b-92d7-e78aaec4b05d@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.10.2025 um 12:20 schrieb Thomas Zimmermann:
> Hi
> 
> Am 22.10.25 um 11:16 schrieb Peter Schneider:
>> Am 22.10.2025 um 11:11 schrieb Thomas Zimmermann:
>>> Hi
>>>
>>> Am 22.10.25 um 10:08 schrieb Peter Schneider:
>>>>
>>>> Your patch applied cleanly against 6.18-rc2 and the kernel built fine, but unfortunately it did not solve the issue: 
>>>> my console screen stays blank after booting. This is regardless whether I do a soft reboot, press the reset button 
>>>> or power cycle and do a cold boot. They are all the same.
>>>
>>> Just to be sure: you do see output at the early boot stages (BIOS, boot loader). It's at some later point during 
>>> boot, the driver loads and the display blanks out?
>>
>> Yes, that's correct.
>>
>>> There's another patch attached. does this make a difference?
>>
>> Do I have to apply that against base 6.18-rc2 or against 6.18-rc2 + your previous patch?
> 
> Base 6.18-rc2. All the patches are against this.

So with this new patch against 6.18-rc2, I first got this build error:

   CC [M]  drivers/gpu/drm/ast/ast_mode.o
drivers/gpu/drm/ast/ast_mode.c: In function ‘ast_crtc_helper_atomic_disable’:
drivers/gpu/drm/ast/ast_mode.c:857:12: error: unused variable ‘vgacr17’ [-Werror=unused-variable]
   857 |         u8 vgacr17 = 0xff;
       |            ^~~~~~~
cc1: all warnings being treated as errors


because I always do my kernel builds with CONFIG_WERROR=y. So then I commented out the now superfluous declaration in 
line 857 and the build succeeded. However, unfortunately the issue still persists. The screen still gets blanked on 
reboot (as clarified before, after BIOS/POST messages, Grub boot menu, initial boot messages).

Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

