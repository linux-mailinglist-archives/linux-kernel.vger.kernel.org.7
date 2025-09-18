Return-Path: <linux-kernel+bounces-821984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2EEB82C4A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C92E168019
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2D7221F1A;
	Thu, 18 Sep 2025 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyjaCCFM"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1591B2186
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758166630; cv=none; b=NyiapdjldyMh+IdGI0lD+aUwBbrh2KFBnSsCaWAi3lWVkeHD6LE25G2LzeqTBwNWj8i0rF51vQxsnyaFyXczY/Nr7dybEKcNMEVyRohnG0d2MUk5IGVXbZ8QlKMhg0dZzKnGFWFWSpkmn/kzoz/M39nk6f4GjZrfdOknbhg+pF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758166630; c=relaxed/simple;
	bh=9C03DLqVam0PMQ5zQvKRtpPgWSCbOXBvesI9otPqIac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYtwlZjf8fIXz/unM5KXWGBmRuV9Nzi+kx9B7LdcT/S9XDRBPmgrBu+lJPdaNbT8owuj+qM6uA8UD2A2+1P/wEmfZHTI+n2JLy+z7s8+HwBND8rh1rzAP8kxLgagDP2yMaygT4lAWItebhTiw1AzpgA/c0edRegV/x0LT6zV9pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyjaCCFM; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77459bc5d18so432508b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758166629; x=1758771429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TF674HGcYaIoheg5UicmzGQj1rC1+tAHApzvaBkmnHM=;
        b=CyjaCCFMsSJQmxy/dvAow5LCxNX0QHDQWHwnhas9bpGq0V7QLitd4KUuYcRhMNBciD
         1Yu6ZKVsRHbORzRWl4hpJ0y23ZhC80kG1w3t32EAZ+023KjvoiCyarOpjGDdq9q98mCt
         hrxQN+DmlbXmIm3LAu3e+IilSgCi2jJQEPNgSOaWLLYR5w7F113r0Rryfu2TOwWv5oTO
         3eUQp7e0GqD3GxEdj6vRxulMbYFZrEpUxwyw92uwZ6+JmUjceFzfXrcW6L85y3z/qmSU
         EshjnhiCr7vPjEpsYwwcb5R7syTMVDMjqWPYcxK7lXCmfe24J64jlfCaGpRoovMMQVXi
         Hcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758166629; x=1758771429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TF674HGcYaIoheg5UicmzGQj1rC1+tAHApzvaBkmnHM=;
        b=CIBcv/a9vpl6M8uHWZbA8ZYKXlqXEB8ji5iuvIr09LhEkXmZgz66j63xUCfHHcYSDS
         Pc/kqBQlFFpCB44gWutaRXScwC9mw1LstVBDVGel/gK5YswGpOS2iEaqP4GJz2NYDNCD
         2qIeZTdYnbsLK7Yhsc0/Lcrubie6TF/Epn328crH7u0U+KkdmAPhaG19qY5wSyI51JAu
         glVTa+Uk7e71x8ca3C6CWJpdrD9TJuCxGWmFTbilJrCuL2/gxI94D7EtN+AN0aEWzlpq
         UEZ7qefp/ANWDhxydxOV9wgIazG0PiWblwAWtxsXoihbd0uHtiOnej8bE220KJtvEoDd
         AXuw==
X-Forwarded-Encrypted: i=1; AJvYcCUu02YhlcCpuIvXtpQ2hksc7KQIPq4WXpDtI8v9mXhQ1Dmkd+FfljH7zfzK+8gtaIyExHdi6jqgSFJdE80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc3uvBlL7SVDGUD06Oh8cuWqewBPJUVoMmrSfYN9T/2OA5OI5f
	pnSu8gjpfo9nJpwygaLpHJgN5mgIFccwss0T1BY0foHod3xGqsGHllDg
X-Gm-Gg: ASbGnctk6jJO3vGRerAundt38s7RLPvXpm/jcMSqgaCFmjg226NaH/hK2A6NdnGYcz1
	z+GQcJ7+cJafFtgCDcEgsxopKo0x+pLTAgYp2yKpBhsVfZBToUVxtNTijHWhSy5QEN88Yi+fQCn
	XZDsZOOCfuM5h//vDO2hh8K0ScsHdcnUfKDVuOW+AmaBIx/MUAEOoPNim4AFK1wbEQumzUx/SHt
	WU/6hnuj4EDcwcBY5lZnbkQH+6irr7ae8DFhW18IQJn4qIe+gyNCebU0zH42H07G+rVr19jkqv9
	fga4JKDiOhTdZDDo9gykhfyVDCbinbdVWTkJ93NK2zPXlnENVhPfij40ag7YqGP4kVdlLeCOe8D
	nTa4RSuZ/5HnrQkBMK2KUoysivkRB554W+WpW5gDUg6datRPY
X-Google-Smtp-Source: AGHT+IFwCt9Dk2w/Kc41woD7GbmfS0MNDCknMwgPCNYn1sxPeLrZNLvTpZDQKV7/BLybgiTCHSJJ1g==
X-Received: by 2002:a05:6a00:2d9b:b0:772:6493:7e67 with SMTP id d2e1a72fcca58-77bf75ba331mr4842784b3a.3.1758166628542;
        Wed, 17 Sep 2025 20:37:08 -0700 (PDT)
Received: from [192.168.0.150] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfe75ef24sm873845b3a.55.2025.09.17.20.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 20:37:07 -0700 (PDT)
Message-ID: <2b00ff29-fd35-42fe-83d9-73811356b73e@gmail.com>
Date: Thu, 18 Sep 2025 10:37:05 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: process: Do not hardcode kernel major
 version number
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Kernel Workflows <workflows@vger.kernel.org>
Cc: Dante Strock <dantestrock@hotmail.com>,
 Randy Dunlap <rdunlap@infradead.org>
References: <20250913015147.9544-1-bagasdotme@gmail.com>
 <87tt12e5zf.fsf@trenco.lwn.net>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87tt12e5zf.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/25 23:07, Jonathan Corbet wrote:
> I have to admit that I'm not at all convinced that this change brings
> clarity to the document; using real numbers grounds the text in a way
> that "a.x" does not.
> 
> If we really think it's embarrassing to still say "5.whatever" here,
> perhaps we should just change it to "9.whatever" and be good for a long
> time?
> 

I think that's a good alternative idea.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

