Return-Path: <linux-kernel+bounces-766833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A66B24BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4297F6837AB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FFC2ECD2D;
	Wed, 13 Aug 2025 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e/679PPM"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7296C19D88F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755094494; cv=none; b=iSE4ju+HZAnl+WwZZaHeJGbwA8sYwzD1xhEiRJS1lM6iBDNoAMdyVi/kq0rOi8L1/GJiqdCUD4Gl1FG0qw43c54HLwCoaNT8Q2g3nClYVjzcc9U/lweZS3gTC+Kw9HA9x12cbX6IJ/AbWPGceJcIuq3vsb6MeD8aVRTZ2VzFe08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755094494; c=relaxed/simple;
	bh=QCMLg4dsgOa1eEM81Z73fL6vTE/mmW2kreT6QN5Otjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MH0mX7+XzXnkZ0ncyIyraUBGpi+mIq8QxpOTN6XTQUfE1YBMDf1JZcjKz8Y0kGDiUtLKYLzItT8S44utbel2UoQg/KejmmIu75pM3/KW57mZdZdlfCYl1ap0pnoLkIJQTImDyvjo64X92yNQDYSO32zUJYn14gJcOjZHj9gzHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e/679PPM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b7910123a0so5901382f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755094490; x=1755699290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KVpG8bVI3r2CBlCksy8TqW11iXXZZJG0tvWEcZ4LZn8=;
        b=e/679PPM/O3RuSDpuOdIzXjmQ4pM55ed+j+0m5nXOnR0bfq+vnOG7VC5+BmqF4zVSB
         ZhYW0VTKuN4pxXUaf0PC47SPmpN4iMfeMN4nEDueXScPk1ZHV2KGgKVnzY4OInWuBzgh
         1JNYcorolGbwOxROP7X4CHEgix5ZVQ6exdZ6znGQQxzig4QscBCttnYC6dWey6C95OV8
         PiDMTX4ggucA8SiSf8RtjLKKO3G9bWV5rcibM3P//mDZwok4rSdGK6dlbwaQENTVQyp1
         Ev3hB6VOy/AKTPB2JuTTsCEAwxog05ivo1BTxFBLqJT/Mub8xbhXMelJWWXaUlRUgaXJ
         pHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755094490; x=1755699290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVpG8bVI3r2CBlCksy8TqW11iXXZZJG0tvWEcZ4LZn8=;
        b=CvMEVj6sJWFvcWK5IRaAzpl3wNOsa6WjWnMyI4wocP6pCbGd7Z0gXsDMV/JYCZPCge
         iaEQY15omH+X+s++xAfloixnOwDvONH/xDZMAXpkoQMdEmnbVnMXnvR26PYPU1y4VXFG
         efI5WNTe80YodbiCnfASZNaX3d+1x//OdNaOXjwkeIqGJnrOcz0Q5MRkCaz1BEzRn57Q
         e/QzZpn2ol2eIS10I7fQMcRW7yZQLA8Kj6edn5/VTQAGHAT78AANRrDtu2d4/txDhH/G
         K0m9iE2NktT4ntXptVPw4ZEv9M6UAIpj7VwarP6n+74Hxiy8hJ6gMqR5hlLr7XjZHBQn
         I80A==
X-Forwarded-Encrypted: i=1; AJvYcCUQ8x/7Oc3orWfAQ3vuxsv1pAPKkuFd88u6Q9fbehLxBz6rg123BfkOA7G0m3yNymdPrwEuJnk7H8r1IqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7hMySQF339A418xkRuCnk5wVcDOYutzIFdOf99jt1CTvfFz8F
	VAE4L7sRyygHM0Me6UQsv5k6c6yPRRT9ERjWXhs9Se3Cbkw8gdk9kL8vGDxr+HYp39Q=
X-Gm-Gg: ASbGncvljTWUYofoSKHlex9Khe5yyyL7H//CJcC79QT8CEX4FGzXEwqac1A3rnMM//C
	RTk8b40rx7PdHi05bJjeM/PLqW1xLU4OY8GZhRzm5gxzCR/JZYb7X4bHpwpMuQtPij7fAf7WiX+
	pfT3ivNl1FecYcB6/PXEwH9MLgRjkUla14MAXnvGsGdSkyBKPLQBCHQ0YeAT8pxNEoQ04/c58Ay
	eY1h+JceIVYxu+6Q4oyE2849kX/zuqBVhXgjLr6gq1WSvWLDm2z1u+G/UwUKd7wReVToS07FTtY
	SSzUWZxovG1CncNuRSZnb/s+6YKMV7veH7eWH1WV2DC1IXNRUXI3Cso6nEewA5ATpfnvfXZyLIt
	9kCKFxzM97ajMrVma/wsO60vkJcPX79D4MjxKZEoalNA=
X-Google-Smtp-Source: AGHT+IFm35SgYBxWt9VgUbIXjFlBOfuZ7PxWsBQOS5oI4umuCBzJ8zHC2Ue8SdOP5RfWHEQF78zD1Q==
X-Received: by 2002:a05:6000:2dc8:b0:3b8:f863:672c with SMTP id ffacd0b85a97d-3b917ea0f3bmr2554936f8f.33.1755094489545;
        Wed, 13 Aug 2025 07:14:49 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e1b99ff8asm3084354b3a.57.2025.08.13.07.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 07:14:49 -0700 (PDT)
Message-ID: <f60327bb-6546-4d15-8bd2-a05e85d96b4f@suse.com>
Date: Wed, 13 Aug 2025 16:14:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] params: Replace deprecated strcpy() with strscpy() and
 memcpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Shyam Saini <shyamsaini@linux.microsoft.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 Daniel Gomez <da.gomez@kernel.org>
References: <20250813132200.184064-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250813132200.184064-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 3:21 PM, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() and memcpy() instead.
> 
> In param_set_copystring(), we can safely use memcpy() because we already
> know the length of the source string 'val' and that it is guaranteed to
> be NUL-terminated within the first 'kps->maxlen' bytes.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Use memcpy() in param_set_copystring() as suggested by Petr Pavlu
> - Link to v1: https://lore.kernel.org/lkml/20250810214456.2236-1-thorsten.blum@linux.dev/
> ---
>  kernel/params.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index b92d64161b75..b96cfd693c99 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -513,13 +513,14 @@ EXPORT_SYMBOL(param_array_ops);
>  int param_set_copystring(const char *val, const struct kernel_param *kp)
>  {
>  	const struct kparam_string *kps = kp->str;
> +	const size_t len = strnlen(val, kps->maxlen);
>  
> -	if (strnlen(val, kps->maxlen) == kps->maxlen) {
> +	if (len == kps->maxlen) {
>  		pr_err("%s: string doesn't fit in %u chars.\n",
>  		       kp->name, kps->maxlen-1);
>  		return -ENOSPC;
>  	}
> -	strcpy(kps->string, val);
> +	memcpy(kps->string, val, len + 1);
>  	return 0;
>  }
>  EXPORT_SYMBOL(param_set_copystring);
> @@ -841,7 +842,7 @@ static void __init param_sysfs_builtin(void)
>  		dot = strchr(kp->name, '.');
>  		if (!dot) {
>  			/* This happens for core_param() */
> -			strcpy(modname, "kernel");
> +			strscpy(modname, "kernel");
>  			name_len = 0;
>  		} else {
>  			name_len = dot - kp->name + 1;

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr

