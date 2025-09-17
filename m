Return-Path: <linux-kernel+bounces-820672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7705B7D9C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF7316AD88
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D06E31A81D;
	Wed, 17 Sep 2025 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HkvugRbS"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C8C2FBE03
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111928; cv=none; b=s2FyowoUaCrtHyw2gkIVEWhYa/P99SZ574WV2cCDYemaYskJnmm+94aOvvakCSIQI0hEQ8uuR3Aox0eFgG4FcNE6hp/jChVubQcQ4pmjLebAMkDVJwEJs0dNOykgYRlYpyNiIGKyL2jkH2UZKYzOmy0CLM6n+D33YiRfvkSSnQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111928; c=relaxed/simple;
	bh=hfGHEKj+Li5C+SsyBXQ5+0EUnOsVD4wRyx9sD6DmIzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/i269W103g8ADbYSSkIIh0BzCQWdSkbHRDDnqTtks7XknrKtUF3/HjtR3qY6k4WmeHdoGaDlu1co9CjDzDrnzGH/XYndeylwJBJkFyvLV5eTPhjfbt2a8LYSBBnrpyJbopLalO0QhPgcsRsim0+YDLxkVbUSgefuAKDUjZtp3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HkvugRbS; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b04b55d5a2cso1133410566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758111925; x=1758716725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RGupZmSqqolDV3fFqfn3WPsHK/Y+Gx2I+5ncY0SDOWM=;
        b=HkvugRbSmQmsWNuWVrAIphvTAX3krdROP5+PXI5WRJcjaLKIqKeq11+pC8XtbO+A6t
         V+1clxw0GB+epCvnHcel8Lc4rw2OJouRl/biHaZJ8D4WIlzbZbKvNiGNWU7Qmcz3UwOu
         dQh4lAmSfzYWwB40jY2LsMtGsfN+YME+lR4VuzjezFYN1VbQ5XUbPs4n+XCwDqPoNSJk
         BEl6bLpDtpaqOKpuYSUktVkk+PdUZZCQMRtAe4TZ7fddhBYwl6klQQD8GnRNii5LzmoC
         zK+w2rbylUl3m63IR4lNSV+g75AiwgsON8A+OJHv6VNFXeP4vkwMKAEipZePkgOmx7od
         dg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758111925; x=1758716725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RGupZmSqqolDV3fFqfn3WPsHK/Y+Gx2I+5ncY0SDOWM=;
        b=B3bBwmZWO2ZWk3KWbSyCJxdyqgEj5DZwowFWYNnP5AfydGVDkRvhnqFJMMNuNVDw5o
         Lot9ob6FGHU8TrGCVDB6ulSEdXXygSfnxAoVPtYtnoXcaf4V308DvBQkyNJAO0swEww6
         NpN3m7vhjt6XHC/MlbbqZpsLseANdnHr7Mg2xbvrg1qVNbV3cgPyKhON7PanW+/+GroV
         cr8fFrnB7+/aFvjKcDGsRtOStZVS36te/xYrkfi3bceCwA6pMI6odc0kEJdVBrxTjDgw
         ezf0/Jzuaye6PE8XJIUc68lpfYMsMFjrsifsw8rRc2zp1svcXvwgjngXPUxg8MPwNWid
         DQUw==
X-Forwarded-Encrypted: i=1; AJvYcCUh3mQRw8a0CulNwwkYunCYSHuvitwyGxzFR96RDZBD+jfqp/TYZLtA/oPmQFbBpwPe63JLfku+nDT+soU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqk8/pPDeSBerP0xSqpa9YwTI2lfRpyu9tGUAEzo5lTP9bK2AB
	6SsigD/R+6KwZG+70/Wb3y9VeilPRSxGGAun4cmX0TBfB8UEWy6IzhnYyyHEXg5XA04=
X-Gm-Gg: ASbGnctJQSDJ/Err9s1EPnlD9TdwwHywwL/9vGHaPJzzHOaCIe6zxl4mro/ykEaA4Qw
	XyuvkHYEwrP8Uu4tJ5B9b6/94Kq/Xgd5vpjM1rdnp7YHpKg5Jm7ne+z+jmC8IhKDWO6vDKAffsU
	S6kB6Fl3VDDLXCehA885wPJebTujYaB0cHJirWgAV0Bq2UHu6tLnvPGl1+gb2q5rIlyT9lWLF60
	wnOJyt7+QlmARZhoSn1bUMp5w/gqd+Om/Qj1R2aemgM214fFPk/xkPQImT6vRf+FrCWAn/14Glf
	TP909smPhkKp72UfdMYSKKMuhgmeBokSO0qu+i5y92V436zYyxSQgYSZs8PDIWtmKoyOVmk7TcA
	dbWqz3Q8T7ZDGNG7OI2uMHpeMjNRHT6QuNtedJKXSUIcpRzzTItgWCG6Dwfei9KTQ
X-Google-Smtp-Source: AGHT+IEMHO2+mrGwehsjHQd9adkafh7FOklixGAh9piZ10AcM2OldRJUtx+VWHX506OwdEOot1gHeQ==
X-Received: by 2002:a17:907:3da0:b0:b07:b645:e5b8 with SMTP id a640c23a62f3a-b1bbfa2bb35mr217910766b.30.1758111924771;
        Wed, 17 Sep 2025 05:25:24 -0700 (PDT)
Received: from ?IPV6:2001:a61:133d:ff01:f29d:4e4:f043:caa2? ([2001:a61:133d:ff01:f29d:4e4:f043:caa2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f1989123fsm8515308a12.37.2025.09.17.05.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 05:25:24 -0700 (PDT)
Message-ID: <cae31224-95f2-4c62-bdb5-1e1e81f2b726@suse.com>
Date: Wed, 17 Sep 2025 14:25:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/1] net: usb: asix: forbid runtime PM to avoid
 PM/MDIO + RTNL deadlock
To: Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Neukum <oneukum@suse.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Hubert_Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>, Russell King <linux@armlinux.org.uk>,
 Xu Yang <xu.yang_2@nxp.com>, linux-usb@vger.kernel.org
References: <20250917095457.2103318-1-o.rempel@pengutronix.de>
 <0f2fe17b-89bb-4464-890d-0b73ed1cf117@suse.com>
 <aMqhBsH-zaDdO3q8@pengutronix.de>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <aMqhBsH-zaDdO3q8@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17.09.25 13:52, Oleksij Rempel wrote:
> Hi Oliver,
> 
> On Wed, Sep 17, 2025 at 12:10:48PM +0200, Oliver Neukum wrote:
>> Hi,
>>
>> On 17.09.25 11:54, Oleksij Rempel wrote:
>>
>>> With autosuspend active, resume paths may require calling phylink/phylib
>>> (caller must hold RTNL) and doing MDIO I/O. Taking RTNL from a USB PM

This very strongly suggested that the conditional call is the issue.

>>> resume can deadlock (RTNL may already be held), and MDIO can attempt a
>>> runtime-wake while the USB PM lock is held. Given the lack of benefit
>>> and poor test coverage (autosuspend is usually disabled by default in
>>> distros), forbid runtime PM here to avoid these hazards.
>>
>> This reasoning depends on netif_running() returning false during system resume.
>> Is that guaranteed?
> 
> You’re right - there is no guarantee that netif_running() is false
> during system resume. This change does not rely on that. If my wording
> suggested otherwise, I’ll reword the commit message to make it explicit.
> 
> 1) Runtime PM (autosuspend/autoresume)
> 
> Typical chain when user does ip link set dev <if> up while autosuspended:
> rtnl_newlink (RTNL held)
>    -> __dev_open -> usbnet_open
>       -> usb_autopm_get_interface -> __pm_runtime_resume
>          -> usb_resume_interface -> asix_resume
> 
> Here resume happens synchronously under RTNL (and with USB PM locking). If the
> driver then calls phylink/phylib from resume (caller must hold RTNL; MDIO I/O),
> we can deadlock or hit PM-lock vs MDIO wake issues.
> 
> Patch effect:
> I forbid runtime PM per-interface in ax88772_bind(). This removes the
> synchronous autoresume path.
> 
> 2) System suspend/resume
> 
> Typical chain:
> ... dpm_run_callback (workqueue)
>   -> usb_resume_interface -> asix_resume
> 
> This is not under RTNL, and no pm_runtime locking is involved. The patch does
> not change this path and makes no assumption about netif_running() here.
> 
> If helpful, I can rework the commit message.

It would maybe good to include a wording like:

With runtime PM, the driver is forced to resume its device while
holding RTNL, if it happens to be suspended. The methods needed
to resume the device take RTNL themselves. Thus runtime PM will deadlock.


	Regards
		Oliver



