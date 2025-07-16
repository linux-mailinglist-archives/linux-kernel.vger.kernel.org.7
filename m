Return-Path: <linux-kernel+bounces-733318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3981AB07324
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF2417AF5D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0672F2C5A;
	Wed, 16 Jul 2025 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McWX6sSF"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17952F272B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661036; cv=none; b=erG5s8Qg/Pu0Z4fhpfKPZcFUBgnDHwTc3uTr+HRwjD9bKhYDbWq91LmPXeO4SjF9S9GzzPddgbwHpsM2g+rGqUGOFn8R5gi3OneUJx5kj6ZcdJ0MBYetjUHQxoFs+Js0M8UfeIKazSDDRZaxbN+fvvLJg1ypg8dpwbvCmdLL+GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661036; c=relaxed/simple;
	bh=1A8o6kRiuW8vyC3o1Wr9Kb7XB1aNcDzaBk0lVQcSk2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNeQF/JMe7MYEx6GebNTPL0dPjT7UubH13FGmkAd81s9zrKDTyMog2chUnGZkrHhuPQsEVFQ2uzTGUs7n9fc0RGwo4iFkUZ4PrjFId2NHRWTM2XFHM8E3FWWTNMgcfi2EZ7EqSZerSrEbLOWlrc2yPLtA4U8uayEr1RN2dGswJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McWX6sSF; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-553ba7f11cbso6448016e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752661033; x=1753265833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/rjLstk9J7bxXZhoSGr3W2khQJ7prtVRovXZQWjOE4=;
        b=McWX6sSFKsScnf6RV2B6zI5Y/9+BQ5nyiOsvRDPHBvq9uiJJXn4tGV2ULbMueX1Lt7
         Msie76iy0L3q2HGWmXYeFzR5vzM94yawqRJUvaylWARNVBeAFMfZ3UmUel1kzOWzqd13
         8kRwKQG+d36S/Fg/dY3Sk/Wf4RmX2KyjXgjG9tOnX2WwpK+A3P+VHLjqasafoMwGHiEa
         5Msl5wPJRcS5mJu3Ds65wXZcnUJFgvIhBPqlHIx3BzHh/Ap0payY6SdgxhCnQhxpKZOI
         ZSx72c0Thg7lTkyAOF9izId8ncpqDc2bq4we/FPwRRDXGTSqlflvDOQUIM1cbFqo/4FN
         J0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752661033; x=1753265833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/rjLstk9J7bxXZhoSGr3W2khQJ7prtVRovXZQWjOE4=;
        b=MOSXEHmeq6EmanNIUA+B6DL/a432YqJduddWJmDyJxCaW2cHIdxJuiTPLmYhfNyRZu
         DZOrxHvumIe9d9AVDb69AFknTk3qDma5LrggPsZRHq6febRNDFkOqflALND6jGBdN9Wq
         r9HeUCAWe7VBUqq5o3ens2DVPqmo/jTldGJNxzfSdMXgWqSSKLZ34dr6AEK8S474uFJx
         0uayANGV20+O30e2RIEzJJKxg0erTRLQ8/Yl7H4cRRAnY4DTNpRW13CK78IpEr3Gr+Wl
         nZa3q3pRa2Wffcize2A6nu8u3HXWEVq8BZEIayK/FiInSoON3/Xnpz5FZpzeSxTwvjUF
         6R+w==
X-Gm-Message-State: AOJu0YzbBEwqE7ayiUkQGzpPZGoaonNu+xuMUKQQL5nXVS+vIDvb4MJ1
	GqQRuzkfahAu8OMUdD7S+S/ohl8lbpS4dFgn+6/YomDGjW2ee6inuobZKTPvEw==
X-Gm-Gg: ASbGncvuDKaJJYeKVkEeNZniVhaLYXad7+3r0ePfKaW/mNt8Wgw14UL8m2kusNgUr9o
	jp04VunrGBdOK+NzOQhl10fwopdE3O5yKnp8D9DidFEpXiRx6YrALLNguoRrCaJF4HiRXb0PfQP
	8ip5CfynmQaC6QCGoKUCp+0vEVjbJq8R1Sw8mvRhru6OPlL7JcrOlfCf5FgJySK7CxZhPebHizw
	eA7Pa9UJOJuBCKJOoXeLBRFb1MyonwVP/SB+0GkPlchG+q2drC+X39cdcEFD2RqjoBt3xE/T53c
	XOsMz8nL0QI2wElpJeBzUVCwV/ewbzD9rZWViSPGnOAaJ2T4nSOUHMRvXNKoab8TnNefzyJ7zmn
	fZWpqQlR2GRvBiI90NWz1dQkjJM2A62DAt5k=
X-Google-Smtp-Source: AGHT+IH+nzz6UA6RHD59VDllRdFf1NJTE7sdxALnNy3mT1iRo7gb7xE8BLzehOi9TxmlSqReQwaXXg==
X-Received: by 2002:ac2:5d47:0:b0:553:25e4:274b with SMTP id 2adb3069b0e04-55a2339d5e5mr676354e87.41.1752661032532;
        Wed, 16 Jul 2025 03:17:12 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d0b42sm2605220e87.136.2025.07.16.03.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 03:17:11 -0700 (PDT)
Message-ID: <531a8d30-3cfb-4803-ba46-16c13d7694f4@gmail.com>
Date: Wed, 16 Jul 2025 12:17:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Are LED functions strings or uint32 in
 Documentation/devicetree/bindings/leds/common.yaml
To: E Shattow <e@freeshell.de>, Pavel Machek <pavel@ucw.cz>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <91d71a35-bb22-4482-8b49-398899ee37ae@freeshell.de>
Content-Language: en-US
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <91d71a35-bb22-4482-8b49-398899ee37ae@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 7/16/25 05:19, E Shattow wrote:
> Hello,
> 
> Documentation/devicetree/bindings/leds/common.yaml [1] describes a
> uint32 but the $ref is for a string, for "function". What's going on

In which line function is described as uint32?

> there? Also what is the reasoning for that sort ordering [2] in the
> examples, are we saying that gpios is like a register and function or
> default-state is a kind of status?
> 
> 1:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/leds/common.yaml
> 
> 2:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/leds/leds-gpio.yaml
> 
> -E Shattow
> 
> 

-- 
Best regards,
Jacek Anaszewski


