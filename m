Return-Path: <linux-kernel+bounces-871870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC876C0E8ED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3AAB19C168A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C9C286D72;
	Mon, 27 Oct 2025 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="jhJudjwO"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E820A5DD
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576450; cv=none; b=s14jL3YRC40P6Xh5Ax52v8+umAc0X7k0ApCgk5uuBHlK0n0m+FjFlVh9XrWNPylKkCb5gE6ji+aHiQ7fZyAVBF8aVgCT8Iy08Tlecj457C0evtSpDr0Z2sNmeqnRzgX49KDh/5Ujc98RUJNMqowMgTNkrngw7zD2xm02IlggiWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576450; c=relaxed/simple;
	bh=d54ymvisHzmXjFv4QDxxZTk7+5ENCqJM82ifdqOsFHs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=TzeoKHNuQgVLUv6BnPNzh6FTU+wGSlOHRPTEsPCyDFherM9mUUws9TxZat9vpkd42HqQWjTVIn4s/bwqwDoS9yTOk+INTRvZm8V/7pY3GtQa06WdfU6KdyokBjSlpNzLyBPdIkXwX2BV8LdXCWG5smpR2auHdyUpRkSMpgNNEvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=jhJudjwO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4710665e7deso24781015e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1761576446; x=1762181246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d54ymvisHzmXjFv4QDxxZTk7+5ENCqJM82ifdqOsFHs=;
        b=jhJudjwOCe3mDuQ2pvnYmi78BHWdihqB7gUWds0V/Ln+dksfVPNV2wh/Wg3rC5T3/s
         9UsYI/PeBXi+cImIs2727k4AhRPfDZTvUo7ZzU4rvQSdsv5DM6fTEWzfe7BC9xYlnV4C
         uKEgrDI5gswWosuA1eYOrD9PLvpsk2vuvDbwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761576446; x=1762181246;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d54ymvisHzmXjFv4QDxxZTk7+5ENCqJM82ifdqOsFHs=;
        b=m/z+IyrkUokVehSj42aKIIiiBn8nEJC7B2XnXLA3IpkIqXRsRg8zEu2aqjmi/OxeAz
         Tgq1PCteHikm43gKKjMiWSYOfL282znx84U+TyWfL8dmxJxesF43aXs1iyE15iJaEzko
         F9qGKEliWJpfVJ8ggWgDTKd0O5AtHuJxkoquGS1gGiHk9hn97TUyMScU/Noy6H97jfbl
         lQy99I8HioFPSIjr2aFsUAReE1oWARQegzi1TiETvsLPROQeXcBN6zeIxnLAeGeBFuO4
         BMgTz5zejQNX1LPP9yKsok9To0UQ/8QkZx+8zpBp2KMDgGRr7nYAf4UUico5ez77qPBz
         F2EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlILf2GPS03Whz38hHNECpkhwTV7HxQsP+lMBvfAi2KP4r3fIj0rWKxGPN2woma5m6ezzZ677Ws9lR22A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2+A+b8N4VS1tzGRsjcdmZ7Zg/mUZy7dH0Eo83Az0zPaEyJjQL
	tJsHTlFyU/AmM6ZCbDxFwnQqnDcXUsvflg0AHOBCqi4NRbfRiEv59iRGvM8qgAFZLNg=
X-Gm-Gg: ASbGncuqUT8OVtc+97s6VOZIkqOKWLca1y3Jihp4m/F/qGei6QK3OfByQgibrblbRHs
	CL2UBeQCvYLgIasZqd6o8ClqpLinvESkQf6uRbeFIkn/0H2v8QT6X62B6NLjlP3cM0hipc5T0/8
	QXVkypWntPp8nlhaNRuJh4F7Oa55cWXFp0rdywON0gjWQpGiP7EpVcMJxtn1apUIWM1dMyb8RXo
	ApyCVfzufW8YH4ZfdT2IHw7SMb/K6H2nDzHjLXVAoHqQeGN6eZS3xq7r98jYiH1szVKzOu7Sv7B
	Eq6EyOaxEFOcp9FNW6Fc7uAQ07DrB08iWwg5oEdAVX2ljoWvahlo3gCPIY16Hx2+XQNhs6kT2UR
	F30dmA40IhBIcGE/P2Uer/qwEjbr1BR1cBONNjGFH80kc4IAj5cTQjHphqF7cw07mJRuUU/hTks
	iFUayeVcHKQ9mggYs9x3lOSKMt1peixEBQuld5dHHRvtaL3pqwic8NLU3/AZcqdq8=
X-Google-Smtp-Source: AGHT+IFlojsMXeKm0Bc6cPj9ZesCvCJlt6jHjHCjtmuU0HyNAETVb0Jar1VIK79GnjKkCwOs5qJYFQ==
X-Received: by 2002:a05:600d:4382:b0:46f:b43a:aee1 with SMTP id 5b1f17b1804b1-475d21b04d7mr63331855e9.38.1761576446538;
        Mon, 27 Oct 2025 07:47:26 -0700 (PDT)
Received: from [192.168.1.32] (host-78-149-11-196.as13285.net. [78.149.11.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df3c7sm14446015f8f.40.2025.10.27.07.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 07:47:25 -0700 (PDT)
Message-ID: <d12bbb56-8ce4-477c-a7a6-600909374734@citrix.com>
Date: Mon, 27 Oct 2025 14:47:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bp@kernel.org
Cc: bp@alien8.de, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20251023124629.5385-1-bp@kernel.org>
Subject: Re: [PATCH] x86/microcode/AMD: Limit Entrysign signature checking to
 known generations
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20251023124629.5385-1-bp@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


> Limit Entrysign sha256 signature checking to CPUs in the range Zen1-Zen5.
>
> ...
> +static bool cpu_has_entrysign(void) +{ + unsigned int fam =
> x86_family(bsp_cpuid_1_eax); + unsigned int model =
> x86_model(bsp_cpuid_1_eax); + + if (fam == 0x17) + return true; + + if
> (fam == 0x19) { + if (model <= 0x2f || + (0x40 <= model && model <=
> 0x4f) || + (0x60 <= model && model <= 0x6f)) + return true; + } + +
> return false; +}

That's Zen1-3.  It's Fam 0x1a you need to split to separate Zen5 and 6.

~Andrew

