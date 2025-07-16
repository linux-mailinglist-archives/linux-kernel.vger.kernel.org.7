Return-Path: <linux-kernel+bounces-733941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D45F5B07AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E0916FB2B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A8E18D65C;
	Wed, 16 Jul 2025 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RSSbQdYM"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675032F5333
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682645; cv=none; b=PVjX6jT6+6+JM7dCfusPiLn/EyDm+RVf0ZcycMCxOe71TK3+vEU3B3oCPAtDWGcDFzCxDo2QjsWOtlVBPdDXbdZkiqNqT//8qKMTUdAX0qNFzIQ01Qi3J0lClrTtZaTEbREgIXUBjQh/AIOANnCDRj+w/hIz8oTtTozmKaaEOeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682645; c=relaxed/simple;
	bh=2S29ztdoZu+lSUgDZARUDIlqmdD/4e2XN6yo3Ko0Ql0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9kXfx6eDzzVkJeU4JhU6bny5PtF/lG2j90cK3fLgUXW7LY+13hY0JtDUKI2aOhC/MtY919p8xEn6vh2+WhEVxPSXmW8jpHa8bJyRVxpW93Kzds0WcUO0hJEOZwbWrBGTgI96SFmWsl4sPby7kivD77DZKYw/oe3NHorYyRTdTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RSSbQdYM; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60dffae17f3so10672568a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752682642; x=1753287442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QjOQCdqS8qm4/VhAwfJZCG868dIz30V0TAdtgEhaExw=;
        b=RSSbQdYMO/iI6veaXAFcYRmlv8/RkBru6JY25ZHVxGVRhffTsPhMYQJwyjOSIb2+pV
         NZHz/T6J4zgS/Xfa/jqIUH3Rtr+vHS2rfhOOxqmC4Xza2Y2X52s+2ljRrrY2gUuVTxv8
         VjQs74SX4kdnZxdnIN/0tJPghctpGHHIhY10+4WG3/h/DwJsZDG7N1GzeJEx+xyNER8W
         96+RsuqpS9pJlZA+qWEaD/PCWuhrZjjXwsNI6ZL2RvGaKPfplpnUGsgEsqOzkcfmQPv9
         /7lNecwafYQnQyBhPm+Sz4mWTIUVshZtqftNyLujcYOaWMdoNskc+/QGp5zPerMcSQGf
         JWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682642; x=1753287442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QjOQCdqS8qm4/VhAwfJZCG868dIz30V0TAdtgEhaExw=;
        b=Jd37Za1fpbMRL8uJSPP+fD0fxGinAdcUnAPe02f14dAJKg84I8PCi1e1XXHmh0MPAq
         nB1unaBm44jGaiWO5oXZz3/dIW9CbgwyNVlOAiQfQgFrjARJ8w2ax6yNTw3VfGYB4vzq
         871D5LKGGDrVrzEDh+xeJROgAolLINUzc0zMWf+a6KIRVTjY/iCQz6EBsCExotKTRaBj
         d72I0dtMMnLAc/H3XUJBUUXl25GLy7wBRVFlA9uNz34nwM8pFhwSwrF6LDQzcZkVVpQU
         VbodlYtVzOWEijsC32YEq9RniJtutVF6k3Nxi5DlQERm+eMc/9AWDikx7J4oOhNHvO/y
         Z2TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcNAPgE/PIogr66c9oPSQV/LfCImZOvTWj0yEsCa8iNrB1bDUyjFwE2+60XMcMIZoSdO+Bx1JuN2njcmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsAjEpdRNnJkYd70lzLf6eaJKtcuRuacj5EPEZPJFblKK6Yb4O
	NFdqiC6iC6nl9+6S6ll0L0dhyEb579mgDXL9s65oeIELUpE7v4KMRmOjGuY1ujsRQlA=
X-Gm-Gg: ASbGnctCHtwTTLSY0RAA6mpMDLsc84igH2QrGfE6TvfZc9+h9Lv7ZxRdh2cmYi76qyg
	KyjJVtKfY4uR5veDPIXwJWmccl516p9I+iS8LvBnva8th1ClSU9fBMpmMWIxk18HELpuB+Vzfzt
	fj9YgaOV/No8ZtWBLEmxbhb0SQb8iX0fwO/KBunYoHEiwjOYPSckc0a/vlaSrprWfM3O0okYNsy
	VHwYjBIg5ltvfkNqJF96ONM3yNA6neK3CTGJscyK5Dtinbarm+5WQtGC/UsXDpTCWugcgtD9mcf
	LQDkBmhHTwXNT/kMgZ0CRRy38aqf3nAt6vSPfW9t21ZsJ3/3IHDCJVxvm4spuwMWOx/yFISlSAG
	VuSQJ6XmiOTu1mCvA6pmg3XSlGYSdgo2Dd2AALb0LqLc4F5G5IZ0QsXkGDNaSEbq6UpU=
X-Google-Smtp-Source: AGHT+IF5iXIUmrdCM8FhNB0jGX3DsNw6jrLVe+lQO/cwacf3GaTVn0cynfyX1i5HLYqqcIiwQr7RfA==
X-Received: by 2002:a17:906:f114:b0:ae0:da16:f550 with SMTP id a640c23a62f3a-ae9ce167b10mr288616566b.49.1752682641624;
        Wed, 16 Jul 2025 09:17:21 -0700 (PDT)
Received: from ?IPV6:2001:a61:133f:9e01:3f5f:8464:37ea:5571? ([2001:a61:133f:9e01:3f5f:8464:37ea:5571])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e91c81sm1224581066b.37.2025.07.16.09.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 09:17:21 -0700 (PDT)
Message-ID: <2c807a7e-d55d-4670-9a86-e3fcaa3e52ba@suse.com>
Date: Wed, 16 Jul 2025 18:17:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: USB cdc-acm driver: break and command
To: "H. Peter Anvin" <hpa@zytor.com>, Oliver Neukum <oneukum@suse.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, Jiri Slaby <jirislaby@kernel.org>,
 linux-serial@vger.kernel.org
References: <ce54ae11-72bb-4ac7-980b-c1cbc798a209@zytor.com>
 <fa20ab91-5ebf-427d-b938-31ea6fb945cf@suse.com>
 <83B89F79-D28B-4F2C-87EA-F5078BD7ED17@zytor.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <83B89F79-D28B-4F2C-87EA-F5078BD7ED17@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16.07.25 17:06, H. Peter Anvin wrote:

> SEND_ENCAPSULATED_COMMAND at least takes a command string – it was intended, I believe, to be able to send AT commands to a modem while online without using the +++ escape code and all the potential race conditions (and security issues, since it is trivial for a user to generate) associated with that.

Understood. It still seems dirty to me. If you want to send strings to a device
the proper way is to use a device node and write().
  
> As far as BREAK is concerned, there is also the option of locking out a second BREAK for the delay time; however, this probably should belong in the tty core.  What do other drivers supporting TTY_DRIVER_HARDWARE_BREAK do?

I know of no driver but n_gsm which uses it. That driver needs to use it,
because it cannot switch off a break.

If you really wanted to use that API as it is right now, you'd
have breaks racing with each other and, worse, with open()
and close().
Are you sure POSIX says nothing about how to handle such cases?

You'd probably have to start a timer in the driver in send_break().
That timer would need to be properly handled in disconnect(),
pre/post_reset() and suspend()
That API is really not nice to use.

	Regards
		Oliver



