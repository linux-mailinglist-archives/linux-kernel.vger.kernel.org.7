Return-Path: <linux-kernel+bounces-827369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DFDB91906
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5B23AE9F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836F542AA6;
	Mon, 22 Sep 2025 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNQyyHpu"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFAD41C62
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758549697; cv=none; b=J3//L2FoxAveRDwHZudB02Bak/lWQbwOa9ajUeSKkm4GG7+m59VZEs+/ISFFeXmwML6Nq1E1Z01RJIPC3Uiz7+wOAicKen5dtif+HZGYs7JmGCcLwv+EnSoThVusfiXs55CwkzqFaiq0+qSG1MefoQU1B3ChNYLa9eBHMSoWFH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758549697; c=relaxed/simple;
	bh=UZjjThwwJZGVVrDbQVu3djnqq0f0cHLoax1dEyX8gx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t3N6wZGwPXkveC9crOw05Ahi2khPJ03yn3mfrQxij4QMRvvUSQiTHzlFAmk41vtyMeyrS28EYiMr41T1Ie4+Qf/SC6OE0/SV6lOoUVfban2RcitiPadCRSpcdTd+U2V61xl37Sfqa/qomhNzmZPN6CAmCMFmZ1UdkXpQt2QYQ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNQyyHpu; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso4026351b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758549696; x=1759154496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fKCwA09uzuhqOzWAVdE6ynBeU1Drahgo1zKeykBUIgA=;
        b=ZNQyyHpuEAmkQweemQ5+oZWcIw0D0Dg6LHu+wMpjNp6IidrSLYIV9prpKVXyIa2BWv
         0z1FJ1x+pn5Da6tdjEEF6Wa9nVOLSQN5pfhJfeX6mUH8+xCd1DlKnHrvbmiV7dSc8Mli
         69ECXNoKHReM7B84ke25VvzBu5GDmiamQ/+NgX4nKvTspEWrHG/sMdh8W0nqREwSKpGB
         CImZUSb3CbZHqcpsEXDPyUrNQ8b8WqD4rk76skYT1HuK5nRAHf20E9p5/3krz1WfJTOw
         kIcP2Rkn0PiKLhPAglqOgfnVsOsnbXmrCV7Z3i4DOKgKN955zkU85ZEfypvNOHLDFtJk
         OqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758549696; x=1759154496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKCwA09uzuhqOzWAVdE6ynBeU1Drahgo1zKeykBUIgA=;
        b=GPKOqh27sLrGOllahlEn0aYWa3HVfUJtniIka5zqCaM8rkmbn/n+mpUjKY0jlfribC
         UjzDioPcOtKABPotSbUYXwgoQFWcXIH4ZyySUaDava+dyEm3mpzOEW8bON3dASsXSOMu
         XBTtUwMtAUmD8OW/lW9ZitVnClGD2oPAgp8Jye9+Nxa8XWvsyvVwr2LUyNl3OO6nV79Q
         pfELua1HqdY4EHG/66Op2apss+oDPQ19oANZ1SPLvqDVLJkajLZjNejTS3Zf+a6NP/A2
         vdKI8m7d2/+LIe7TTfSWNDsilH+mZ5BB2BohcwTlf9GGlSkGxALDg00YD3TThNLOgDVb
         S33A==
X-Forwarded-Encrypted: i=1; AJvYcCUMGHB400DuAoiTdCdKZtTNbBFHL95Rsn1g+Pt6jYotsZZNYzL/7cBtWNzPt+ZW0MYOlOwgADPi0oW26Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZD+WhVdAxEnpkA5OrSCuCAGrCJQaY445qZL/n6JtVcbewWmf1
	eJDZEjE66uOjX/EDG+ytXO+cEXfR5WWiILFsh8jMgzikkFky8p+fjVdO
X-Gm-Gg: ASbGnctoSt34lw1YQsH2+mSgvgnv2vH7wUvSaRnmuzDjS4fq/OiEQl+Aw+htLF7Zbku
	OLnF1ufoGx1xzdmH2Ym9QxQWDgqtMyQ3LnSYv+7Xc0IfTaW+Go/gr2aGIqZIOVtz1ONBJ9tB1uB
	6EGJ+Kqdspw0xqAEKaG+SlR755e6FtAEVv88gMLy3xSRpw1TVAYnU4DQ8Mxu4XSKVLljD+dxvtN
	xyZbkHmAmu4sVa5kFiEkhY/QIMUixrXQNuonZpadC6+8NhYykLuQp5j8cfb9VfLQGCiO8dnp/LH
	VeJiVhHZEPTP1FRECpqNaxVooRDHqVvwUdGkNQKvdpDBqJdhLfR9ifpsVZqaIOVbjoILuXoJTdT
	+aGslqba57hHANpvwVR7RHPHD+8CWsQ==
X-Google-Smtp-Source: AGHT+IGrmrGvSmosds+W3wTUoh6DC44jNVPqPse8MKhb2Qiqm6JwSQCRflUH7JmR95N5n8TSktl7BQ==
X-Received: by 2002:a05:6a00:22d1:b0:77f:414d:3774 with SMTP id d2e1a72fcca58-77f414d38e0mr3142062b3a.4.1758549695190;
        Mon, 22 Sep 2025 07:01:35 -0700 (PDT)
Received: from [192.168.0.150] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f4d204aa7sm528770b3a.44.2025.09.22.07.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 07:01:26 -0700 (PDT)
Message-ID: <ff092ff5-8ee1-4e91-b7f7-e5beb1d6d759@gmail.com>
Date: Mon, 22 Sep 2025 21:01:18 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: process: Arbitrarily bump kernel major
 version number
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Kernel Workflows <workflows@vger.kernel.org>
Cc: Dante Strock <dantestrock@hotmail.com>,
 Randy Dunlap <rdunlap@infradead.org>
References: <20250922074219.26241-1-bagasdotme@gmail.com>
 <87h5wu8x7o.fsf@trenco.lwn.net>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87h5wu8x7o.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 19:53, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>> The big picture section of 2.Process.rst currently hardcodes major
>> version number to 5 since fb0e0ffe7fc8e0 ("Documentation: bring process
>> docs up to date"). As it can get outdated when it is actually
>> incremented (the recent is 6 and will be 7 in the near future),
>> arbitrarily bump it to 9, giving a headroom for a decade.
>>
>> Note that the version number examples are kept to illustrate the
>> numbering scheme.
>>
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> Just FYI, I've pretty much shut docs down for the upcoming merge window.
> I'm probably not the only one.
> 

So it is slated for 6.19 then?

-- 
An old man doll... just what I always wanted! - Clara

