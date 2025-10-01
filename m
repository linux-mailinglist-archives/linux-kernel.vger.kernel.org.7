Return-Path: <linux-kernel+bounces-838600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88517BAFB68
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB3D17D579
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48265284695;
	Wed,  1 Oct 2025 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JY6wGH1b"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8F11DB122
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759308351; cv=none; b=e0WXGGmYEB344hAlsVgAwqH5XpeFJYXRyS2sk14bM/QkEzj1ccjxXVrwpy2HfGHtnxyt/dR6hNpndNF9xU7Z5LvcQjRfkobxwMpJ5U7tmCCCHc2xbVaoVwpQjcJ9xuuB0BxyPwk5G+g4QBWdIf/oZtMGgJYxYrFmc4h3wcz2eB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759308351; c=relaxed/simple;
	bh=z7PAbCaadIqI01F2PvsLYHH78DlOLBgL/BlFH5vP4u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKP74BY/B7D9RZoPBbYiIcwEXpAzrYFZhKS/oeFt31pobP8jZ6QDjkZ3TJinjzIZRfWnY5RqyeNAb/LEBWyCjBdUKMcKBrWZRpg2ZsBI4m+RXtBGZ69siJwB9U8YfPX6KIX7+IZXXW6qiv2CuSZwf5Eb+rXWg28XtKsJGLmzxV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JY6wGH1b; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3304a57d842so5688889a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759308349; x=1759913149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eo9F75MDR0Y0UIOkUFMpCwB73Wdw9obsMbsxTQ/B1yg=;
        b=JY6wGH1bqc+KjzPZR9YPHEhJLihiwczRLTa82onj4eSxZ6Geq2SpSrUCTPyBA6CtU/
         LLtw9UNhBbECpZfH2vdKVuF7SjKHupY/M9yMzNrbHoA15K5xxr+MlRdx9YvTyISrX3HS
         oil90PqR8V93NmYfNQheGNNhYU4v80rh5m8pJLGb1olYakyHPT4KbY2fZkxC26IfJ1sb
         XaC7nlQGNCam2zzOUKc/rP28L9NOJaAFz9aH5MwfnNce2irMCq3dT8MzujJY7fb+3kbp
         W1LDJfn0vaEm3lH6otWqFISCzaY4rGSGf7/zXyIGw/LytLJ+/wEGUjtWNsaotoxX16Ry
         2zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759308349; x=1759913149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eo9F75MDR0Y0UIOkUFMpCwB73Wdw9obsMbsxTQ/B1yg=;
        b=vHYs8EpGqseaWl+TfE4Vj68k1clGb/Ve6PXQF34V5T7YDiO4/szWR7aC2V8uhIGWXo
         Sa8sxSDhoJixqQ6WkaF4M/1l7eqUhzEPXKz8Q3rm8YybGwPfcD/vmXHVYEMeoxSwJaBG
         I4fY0Rzz0/204LlaM9/9bMqA65m+7RlFJzW+piwWvnIPQlaVN5M5Ady97pJhIX84NJtP
         CSOWnUViZvWCwfUUCGxwjbqIe5PS1eVPCMPyGlGtuawvphi2/hHBEGhlLOvliTYjrQFJ
         ium0YAP1TOI9TRkCKb+MgHk+bStkihAE0XTGzIuXipbc+u+qILu5jxW8TsjydO2028tL
         sMGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGOFjOlCWL4xZV84Nm0KlyXimnULoktyTQlkGg0A6mid3ccxpFoizzYo260dxTAT4BeCf8j3Xt73TGCQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiD2t8SDH67USVng4ElWZAqRn+Qjf8f0UDAIlazBV1GDxvTM4H
	krbKTmJ4rBNeNNl7+86DM38EMdX6w0PffWExGCRYTCL8R12QKmBnFaoE
X-Gm-Gg: ASbGncvAXJazGCdRTA/Y8hEfUZ1ZoyaBG7KT/El1M+KiauKBh3rX7V1/M1oBbV2j36L
	Sb89OydjzBv0Wzf1Rloxy6Hd94nkgHfDLxThpx7mUQXwtpqQ19qNRiZ89mgM5MgZ0G1wHXenVWV
	StdrWEI1dpk4Xqf95N1xQ2xWmVaypkgZlVvyir2cls0gxDBOsWcdr5v41WhUwCuhb2L5hwzUUfb
	VE8CB7jT+2ZVikQKRZ5ptWzOCZy89kfcLY4So3LqH9ccioEGEN9lKsxd+GhPFeNXDwhiZPMR+R+
	OX83CuLQuy76M9x1r9dLbBk6WqrRi0FRlmuGMq35eY4aK+S3dzByegBV27bgd9v8vruxFoJY+Wf
	0Rkn5ufsN/McqHA2gOAvXqDzMxqDLKH6f8e9AzwfnbzHdxWOIqD2kkHztB03x7HBPfCOPGg==
X-Google-Smtp-Source: AGHT+IFfy0fiNNqMKqoY4HSuTSBvTKdNKF7dGc3N2UWsorO4J+7pzOSweKSFh0q95xUD8Ljh3i35aQ==
X-Received: by 2002:a17:90b:1802:b0:332:8491:ec2 with SMTP id 98e67ed59e1d1-339a6e96373mr2984063a91.16.1759308349404;
        Wed, 01 Oct 2025 01:45:49 -0700 (PDT)
Received: from [10.0.2.15] ([157.50.93.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c557418csm15514320a12.30.2025.10.01.01.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 01:45:49 -0700 (PDT)
Message-ID: <dc51b6a1-83ce-4f23-879b-3e103c4a14a0@gmail.com>
Date: Wed, 1 Oct 2025 14:15:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: lan78xx: Fix lost EEPROM read timeout
 error(-ETIMEDOUT) in lan78xx_read_raw_eeprom
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Thangaraj.S@microchip.com,
 Rengarajan.S@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+62ec8226f01cb4ca19d9@syzkaller.appspotmail.com
References: <20250930084902.19062-1-bhanuseshukumar@gmail.com>
 <20250930173950.5d7636e2@kernel.org>
 <5f936182-6a69-4d9a-9cec-96ec93aab82a@gmail.com>
 <aNzbgjlz_J_GwQSt@pengutronix.de>
 <e956c670-a6f5-474c-bed5-2891bb04d7d5@gmail.com>
 <aNzlNkUKEFs0GFdL@pengutronix.de>
 <7cc900dd-a49a-4f37-88e9-6794e92fc7d4@gmail.com>
 <aNzojoXK-m1Tn6Lc@pengutronix.de>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <aNzojoXK-m1Tn6Lc@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/25 14:08, Oleksij Rempel wrote:
> On Wed, Oct 01, 2025 at 02:01:24PM +0530, Bhanu Seshu Kumar Valluri wrote:
>> On 01/10/25 13:54, Oleksij Rempel wrote:
>>> On Wed, Oct 01, 2025 at 01:40:56PM +0530, Bhanu Seshu Kumar Valluri wrote:
>>>> On 01/10/25 13:12, Oleksij Rempel wrote:
>>>>> Hi,
>>>>>
>>>>> On Wed, Oct 01, 2025 at 10:07:21AM +0530, Bhanu Seshu Kumar Valluri wrote:
>>>>>> On 01/10/25 06:09, Jakub Kicinski wrote:
>>>>>>> On Tue, 30 Sep 2025 14:19:02 +0530 Bhanu Seshu Kumar Valluri wrote:
>>>>>>>> +	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
>>>>>>>> +		int rc = lan78xx_write_reg(dev, HW_CFG, saved);
>>>>>>>> +		/* If USB fails, there is nothing to do */
>>>>>>>> +		if (rc < 0)
>>>>>>>> +			return rc;
>>>>>>>> +	}
>>>>>>>> +	return ret;
>>>>>>>
>>>>>>> I don't think you need to add and handle rc here separately?
>>>>>>> rc can only be <= so save the answer to ret and "fall thru"?
>>>>>>
>>>>>> The fall thru path might have been reached with ret holding EEPROM read timeout
>>>>>> error status. So if ret is used instead of rc it might over write the ret with 0 when 
>>>>>> lan78xx_write_reg returns success and timeout error status would be lost.
>>>>>
>>>>> Ack, I see. It may happen if communication with EEPROM will fail. The same
>>>>> would happen on write path too. Is it happened with real HW or it is
>>>>> some USB emulation test? For me it is interesting why EEPROM is timed
>>>>> out.
>>>>
>>>> The sysbot's log with message "EEPROM read operation timeout" confirms that EEPROM read
>>>> timeout occurring. I tested the same condition on EVB-LAN7800LC by simulating 
>>>> timeout during probe.
>>>
>>> Do you simulating timeout during probe by modifying the code, or it is
>>> real HW issue?
>>>
>>
>> On my real hardware timeout didn't occur. So I simulated it once by modifying the code
>> to confirm the BUG. The BUG has occurred confirming syzbot finding.
> 
> Ok, thank you!
> 
> Can you please add similar change to lan78xx_write_raw_eeprom. syzbot
> will find it soon or later.
> 

Ok. I will try to send a separate patch for that.

Thank you.

