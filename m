Return-Path: <linux-kernel+bounces-834929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA40EBA5DAB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54683175ECB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 10:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179032DA776;
	Sat, 27 Sep 2025 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKAEamp3"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEB923A9BE
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 10:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758968605; cv=none; b=fMUBjRZdH4rjQDB3mFS9KhH/kon51hoef/Q/hy71S+VMo2O8GbkVBnIJO/CKa4EbwIlaqikIFutINAFTeG5CvQn63v5jCpcj0dEd6zuReTc3BUiDk/QnXFjFOfHohJOLpPxTxINw+Nr6/E5xYRse9hpkZAbjlrhMlwWcYNIkcSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758968605; c=relaxed/simple;
	bh=hSP0UkVo3smxyzxl5cC2FsaVSah/lhvXDVxNIWdha6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlBthk0F8Oy/M2up4VsAU3hcP2bXu2ye/2tCPSaWOnQ2Qc23vDtwMFdEzh4Fh/WBpLsU7BS1FBgxj+joWm/juhW5CwZkjKrScQFfddHlH6TgJ8ik5Nllue5J/SWPsh/9l0EG8fP50U6SA+aS5woySPMMn7V8mBTVyO22FN+nCoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKAEamp3; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso2155769f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 03:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758968602; x=1759573402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=in7+4Iwa+nIWx1yXee5icFLUsBp15xu7p/S27zHgbMc=;
        b=XKAEamp3XY3BMOZ7S0TVDFIrfcKWrfbWIfX26jXckQLGX4qnubucXJAegWgR5mZQhA
         RnFL4e3+2YxJfbxg88UMhp3CzRR3/l+wLRR1W6W9CkoG7HXUfsi0mY9IRDs58xGiafic
         6ZHj4ABdeDib1Y0Scj02vk6VcLpHRqpLEsrpji+7OfiUDWGeHb9N70JoVfj7oEmbOaEb
         pfpguJGVR4n/MC99oHXC4PGtf1Gt6P/b2vdF97l9F3Sv1KQpl2Bb05Z+ReUSyC+v7Bhz
         RXB94aGpExGjNY0JtQz8tL1XUB5Kc4V5ZpfA/cuVQB7eTdYD176xG28WsVFLJH7vnrrY
         r+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758968602; x=1759573402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=in7+4Iwa+nIWx1yXee5icFLUsBp15xu7p/S27zHgbMc=;
        b=N8wfqWPhzEoHzWIUp3wDtxpB99OHAf20YlUpfXyUkr5EZEtw6a9k8mHfOwT+CnfxaB
         halpj7+pMTbmBAm7lu3Z4gCF6YBFNW3jqfHgwyu3Xvw2puEej5tcOuqvyjspiuKeuzzv
         3LhceR7Wfp4ia1yIDEfoPAyYHhrzeRLAlqPg0AkbGww8pFuhl+BuuqgkPvdpGVRv0qXv
         MG7Ewf8CbK9rGd7uoHIYE2e2Ds8nBVS6OnBVTjh5D9XUvOF+50/6uh8MOJ3Mtb7gt0wr
         fJnZNUQN87n9GhzsIHTHmugwWZUXuKzfvJVoXSdtPNzoepCrvfDXFYbkg+oTkGONlWZH
         XsuA==
X-Forwarded-Encrypted: i=1; AJvYcCU13M1DP3QejNlG9bUdAodbTPZp4NFmGfwZwhy+KYwWBGzVScyV4d8zQQDDOL+ev3CDJelB6NWsSUREUnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpWBvC2Xd/lh5ae9PKWCJYUJGHdqE/EtEW50ZFo1p7tvzS59oQ
	YY5g+5C3SICZfajoXD+m8M9uvTCqZx90FRYSlONIdT2/nVqx+w6MOwyH
X-Gm-Gg: ASbGncvipcaZrHB/skw+uo8liFOY6vRyBwTUOKv5HkCmDS+6sl9AqXm5664mdrYAozd
	IyKWvyvLobYe7ai+OMEXsRnIqGxkFvD6QKo7nqG488M0Ia+TzkPjSE66ifAtzLYjWym93PIUmmJ
	zphhSI6Sb6ubdP7QEdN3YPJja5LPG4OsnRDAhYbJruat4l5DXo/76Ma9kIeMwQtaHfTRJry4dzG
	PuOyKxXX68pil9Zqolw8HHfuVo07fNw0rle0HQlFmxuZWb170Is3QFdPPc9F/qDGn10ZfHV5kOu
	K8A/SPMmEExaW6na1YR+z2Ew9lsoLn9Szuc9Aosd2bwB48PIq+yaGVRA7uzXBZ50r5aAMkTya7V
	qtKgoXFxMuycVydqkMDRywraAwfhCTM6T9tcq+DC7rWNFH6cJJFWx0rJVFbk3sDO4xJizfe610e
	IKRD2uns2ghU9LIF+1wqq8Wd/+mfGkzJLD
X-Google-Smtp-Source: AGHT+IGrFnvKHtAi4Y3nWafYrrOqgHxO338Bp1mW+r8fwkoAEnIvgFWt8NrSHcpvK5R1+smnt6PNXA==
X-Received: by 2002:a05:6000:2210:b0:3fd:271d:e2a5 with SMTP id ffacd0b85a97d-418005f506bmr2379315f8f.11.1758968601943;
        Sat, 27 Sep 2025 03:23:21 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f11a:4401:dd3b:2a2c:62a3:2127? ([2001:9e8:f11a:4401:dd3b:2a2c:62a3:2127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc56f7badsm10291549f8f.29.2025.09.27.03.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Sep 2025 03:23:21 -0700 (PDT)
Message-ID: <3203ee4c-b320-45cf-b63c-49f589909dfb@gmail.com>
Date: Sat, 27 Sep 2025 12:23:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i2c-host v6] i2c: rtl9300: Implement I2C block read and
 write
Content-Language: en-US
To: Sven Eckelmann <sven@narfation.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 Harshal Gohel <hg@simonwunderlich.de>,
 Simon Wunderlich <sw@simonwunderlich.de>, Andi Shyti
 <andi.shyti@kernel.org>, Chris Packham <chris.packham@alliedtelesis.co.nz>
References: <20250926-i2c-rtl9300-multi-byte-v6-1-a2d7d8926105@narfation.org>
 <1838669.VLH7GnMWUR@ripper> <aNZQnlUML0jIhXIM@shikoro>
 <13214546.O9o76ZdvQC@sven-desktop>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <13214546.O9o76ZdvQC@sven-desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27.09.25 11:55, Sven Eckelmann wrote:
> Understandable, there was a lot going on at the same time for this niche i2c 
> host driver. Please check the "Order" in 
> https://lore.kernel.org/r/20250927-i2c-rtl9300-multi-byte-v7-0-c0fd0e78b818@narfation.org

Sorry for bringing back some confusion but I had to fix one final thing in my patch series.
The order Sven mentioned is fine but please use v8 of my series [2].

To wrap it up:
[1] needs to come first
[2] then this can be merged

> Kind regards,
> 	Sven

Best regards,
Jonas Jelonek

[1] https://lore.kernel.org/linux-i2c/20250927-i2c-rtl9300-multi-byte-v7-0-c0fd0e78b818@narfation.org/
[2] https://lore.kernel.org/linux-i2c/20250927101931.71575-1-jelonek.jonas@gmail.com/

