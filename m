Return-Path: <linux-kernel+bounces-838401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2D9BAF18A
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 06:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5141C7ADCAD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 04:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E375B2D7DCB;
	Wed,  1 Oct 2025 04:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvrd7fu8"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F7323D7D3
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 04:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759293450; cv=none; b=JMGFeB1mHbzmw1cGAZ/KK3w/AHPSu706pDjGXVhu8zEl0xw4+/Zmi7REUVnF0jN0/ubpHhYr5MLB7l1CIQOBuUc2BjNoAX/Tfu5/ahH4LfTZAuuIAyGVxLMT4mWLpQoYyT5UC4qt2pRCyVDtiq2WVxT8VCUwJQK3i+h2nd/3x3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759293450; c=relaxed/simple;
	bh=dCaRnTDskwqEI8sV8rq+5asgm+ypdm2aisI3BH6Ws4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gynJZ9qVQmi86gP4rI954w5WqP+zibdQlgLMYkxzdN3iQWEgMfVEVvHP+F+UQL0MPCRrRHsuLb45T5ICiVt6fjQWkdOfDZhZ0anWsZoKnqOW3duVK8fx2w9oTtSx4bIKKnW9/DrHkY9yUTbBSuNLTWDqlfVa69XBl/4vHZOtO9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cvrd7fu8; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b593def09e3so3288518a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759293448; x=1759898248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MPq6uQImOLbVbQ5YyRJgD3fiIsAq1mSu/jIrrDsClYI=;
        b=Cvrd7fu8b7mqS5IM3RUXwPXn7V9QtEHTglZJ3IixPd9nveV3KsMjd5nD/VXJWTRfrx
         78Mv76BDDawn0HsLm9vznnZZY3xBdQnawgz7PYtc3VNbJmtBOynCdRVbdsNsQyvyJQnI
         1AjMXTXGB43A98GJmdiNw/0bM2Pv9V8itAg4JEv0r1VlMQGjuSclL69aIGweMVteX8n5
         ZoheVGieAXabYH2/kfDMVctZWUdqXY5Sa7E6f/0MynjHhzO9/C38gmibkN/qc/AUvX5n
         RbEIMl2j1CGosDyEiv7SMW0W6pAb+5ros9QnSxSzZJLOUVWO+y6h3fDQ66VldH0kh9NO
         5r1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759293448; x=1759898248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPq6uQImOLbVbQ5YyRJgD3fiIsAq1mSu/jIrrDsClYI=;
        b=hhUTY4sHkKtye22X/e6uwO4A5xnapPx81G7Nb1cmtXAvC2MwL6F3QSRbW8pDRkKPVb
         HG06yEnkVwXFL5Q6ILJ8dGpOxCpPHfHDDCyHzUtuuFAX9yzXpdgGuM7wPLV/tYcWwZRB
         NTNw8ACQ8c/eusxFho+Ad5rTPhfXjvX1pS4OxRNfp3rAHo0OIebYyKhcAtvLRKQ+zgFk
         T6Yhs5At3DzmPDwdwXYfE0qdNbY6/0/rCs9ZGpaOu6qkvKgwBNpG1/vgtsd3pMIC8Hvb
         /rL7rVCEU+oj9IC4Ij1370z4T+LTACDl3Bxi8aS6AmkEc6fKOks2rUD/vMZCM36gPYiV
         G2Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVtH16q0OUSeaInbHKiQy4wDkq4yByLLJY5ZeVLbA+RFVu2fCq6s+jk4HBHYDJwsenWBKnafCsBWXxEImI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Vvvd+swIbYMWYHlSPettff+iSxZJ6wKV9IUGHt0aY5LePr0q
	WEoQyJxK5g0SEZP1bGbp73fm1tDWSnW8xiyUT6EIucjBWdA2mukeC5EP
X-Gm-Gg: ASbGnctIkzKpWkFHUPDbYnVpfloaVlVS6Zj/0qdb61fAVWCCWDQcqeNlKQnPT8yDgsL
	+U0O0E+lLOh/6R13T6b5NcBnjg79yoEyr11RX4gSoApFP0m+F1gEuIckkY7xrKBxsaX2VJmoXcu
	tUBcbrUzvnlmGd9+DB0DE35DkBZAXfoFNT7k7TJZu6VDuH2XsqDgd9PPzAOY5ZnWKKbD+uUGtSs
	6cDioJCYv5VZtGDGGAtSJCpkqgEix+gedhIhKp0OgXY+rEB81XcSznmnWOAsf3FjDgDvBdLcx9U
	V9/bleHSETWP3O+8WPzF4fg7X9Y260rtzOM92c/7FA9GHwz/L/nBhOgU29FOgo0sycucI6Idpda
	1O9yt0RiYwlQO+x4ZdL10c3JmjH9g6/hzRwIVHmoABNPLRCfJU+TgX4AskXBkCkE4Cf69Pg==
X-Google-Smtp-Source: AGHT+IFmNzfgvEEahVwLkACMZNqW0KUgxiZlN4x/uBqreI8OJr+lyeHZmUQ14H4cjQuSd5m1Lge6CA==
X-Received: by 2002:a17:902:f546:b0:264:70e9:dcb1 with SMTP id d9443c01a7336-28e7f440582mr28584725ad.56.1759293448001;
        Tue, 30 Sep 2025 21:37:28 -0700 (PDT)
Received: from [10.0.2.15] ([157.50.97.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882210sm173000665ad.79.2025.09.30.21.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 21:37:27 -0700 (PDT)
Message-ID: <5f936182-6a69-4d9a-9cec-96ec93aab82a@gmail.com>
Date: Wed, 1 Oct 2025 10:07:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: lan78xx: Fix lost EEPROM read timeout
 error(-ETIMEDOUT) in lan78xx_read_raw_eeprom
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, o.rempel@pengutronix.de,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+62ec8226f01cb4ca19d9@syzkaller.appspotmail.com
References: <20250930084902.19062-1-bhanuseshukumar@gmail.com>
 <20250930173950.5d7636e2@kernel.org>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <20250930173950.5d7636e2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/25 06:09, Jakub Kicinski wrote:
> On Tue, 30 Sep 2025 14:19:02 +0530 Bhanu Seshu Kumar Valluri wrote:
>> +	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
>> +		int rc = lan78xx_write_reg(dev, HW_CFG, saved);
>> +		/* If USB fails, there is nothing to do */
>> +		if (rc < 0)
>> +			return rc;
>> +	}
>> +	return ret;
> 
> I don't think you need to add and handle rc here separately?
> rc can only be <= so save the answer to ret and "fall thru"?

The fall thru path might have been reached with ret holding EEPROM read timeout
error status. So if ret is used instead of rc it might over write the ret with 0 when 
lan78xx_write_reg returns success and timeout error status would be lost.

Thank you.

