Return-Path: <linux-kernel+bounces-802135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FD1B44DF9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D86E1C80268
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A5E2BE027;
	Fri,  5 Sep 2025 06:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9DCwLdA"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4FB2BDC28
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 06:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757053885; cv=none; b=vBt7D81qLWioS3eKM/8hutQkZBFVDuPtY+YmwIc6X0w1pDdVB0Kwrwii6gWVi6hObsnmZP3yBAf0Tj+YJ6kXSodLwGWKI5YKWMIqPCCZ5E6SkwE8vvxzR0LphpttQhy2F/G6qzQBIQK5s4Cn0LhmbXmknXHgXPRdSSK1uUp5Y04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757053885; c=relaxed/simple;
	bh=Lj1NCAueVWdAkoX4S8LLnOQ3/stAEiD4Qf1ycv4L8eA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLxGpAceMwK+2MjRlmc63KqbKpEadPyc3X16IRRUYy9M1cjFfnSn77tOkHfu7YWlzEO67oeIui5ljRP021p6qWWsPEA15X4nwCKmmr7Gr46tD2iopvszgaueUwslNFxhhnhkXw/5tAlTA+YteeFKlMYED83+EOOys/PUPBa2+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9DCwLdA; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7f04816589bso193623185a.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 23:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757053882; x=1757658682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uHSvQN6UoDz+iHef94OYnP6vRyyEaJZRaiHOnjtu3yo=;
        b=g9DCwLdArQpmjOd7/2+pfnkKOx2zuCVm879GSY8H3PohtmshMvigIF6H632s/j6hQR
         2OZrfgrZpMlkfLS8EjWx4zUSP2ieuUbC1wRL/MPuAhIwlmorq4zFZi4HZx0WkvCOA6R9
         c2cnVVqBawatZIB5+g/rmVLSOHGtvi8bzNTCcG9+O6FfDqXl12Gve9LRCaXp2Klac60J
         oliIy607zj8mEVXg0Qv9XkSk7Uf3qh8cUAKkuQDciOC8mReMMxZqaOsrIr8+DdVfL8Le
         U2ku9Suvn/+MIwz+HF8+BK9B54gRdPtpDAbuadAlRikNtg+WkHWgoIpZnC3fsnwR1jJT
         mZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757053882; x=1757658682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHSvQN6UoDz+iHef94OYnP6vRyyEaJZRaiHOnjtu3yo=;
        b=czaoSN86ZYB0B61DV/Nmabf+mUl7A5Jk5GnPiF4/9uvoO4vOYsom5rhsYTR6xooUi+
         c6Id2KRGV3b58lNXVooxhD90O6wFs8xWMZ0OwBPYgTcnAdbwTU1TV367YKJfqV4ox1H1
         S9dQewNqEyt7sy+J224ocBxFnBr7IIIPMn7jMEPOXfNNlxO3wGO4nkE2RCtb6gL8XPyM
         PoxUASTeXetIxYqWmbGGw/bV0yxmFlczfJjnmhJ6IadsV09E6GehfOtWapDr02E6aSvM
         kIy1qS+GqqqcEfkHsPt4TrTaHv59TRBCH8v7UhbnjEUQLszaIwkPtp4kbnMo9bkFd0dX
         bkYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE2jMxA9cplvynCzBtLVC8i0xR2mR0nM8tOAH46ac1FRY7CgyTD1uxOL5/ZJT+1XnBSjhoYpyE9zjLObo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQeiwpqP/MuqdshGbTe4/bjGOsZjSL388O7f+239GlvfqkZF6s
	/zrn99OIDOzR4LUqK7Sk6IfMkP+G/Oe87wW3I+EnVJSxKd5hQ4/fpGXA
X-Gm-Gg: ASbGncshOXymSUSluXyQF53W9bau44cbhyT9apVjYqg8MYrrUh0Y3CDFeHkF/vOTZG1
	K/piUDnfN6XDQ3Qrf78CM/PSRE8uZCvTRjd9AnmROpnstJu1rkQXndAtFbnPQOB4ONipg5jMM0K
	O1EQB7teVJRHsB+VxqW/VEOg0opl5/cVoH5idsXwMbZ0sas72p2MkRNc5G8n03/MjfwEWpatGFJ
	Lz0rvVYYL3VKAFVy2VaVTpRL05acwD8wegv1GdUJCiN1qxflGdP5TJ+rRPrRGvZxfVU54WF+/3d
	QDEOm07Yg5ecBD5pVGmQNYBXMNMxCwiLHHxwbD/XrXgWu7wPIRUg4QMLWwnc4e9CyaPw8eTkbn/
	0gx7g1RimbcAz81nX5BFKQP51yBUUiY5hU5QAX+tA/E22BzTdnGlP/FgbKMB1
X-Google-Smtp-Source: AGHT+IHnE73tmpgUQukbfUoelnhjI7us3aOnbj2jVzEssSlexB8FYNdlMRj7VtGr6YBOmDPf88ldvw==
X-Received: by 2002:a05:620a:7105:b0:7f9:50da:915c with SMTP id af79cd13be357-7ff2b4b00f9mr2602434285a.50.1757053881846;
        Thu, 04 Sep 2025 23:31:21 -0700 (PDT)
Received: from [192.168.0.155] ([170.10.253.128])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aa712bc92sm423763485a.27.2025.09.04.23.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 23:31:21 -0700 (PDT)
Message-ID: <7f80045f-a8ec-46ae-ad83-4c93027a353e@gmail.com>
Date: Fri, 5 Sep 2025 02:31:20 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] staging: rtl8723bs: fix excessive indentation in
 nested if statement
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250904021448.216461-1-vivek.balachandhar@gmail.com>
 <20250904021448.216461-10-vivek.balachandhar@gmail.com>
 <aLlIEspZ2wLRnCru@stanley.mountain>
Content-Language: en-CA
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
In-Reply-To: <aLlIEspZ2wLRnCru@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ack. Will fix this.

Best,
Vivek

On 2025-09-04 4:04 a.m., Dan Carpenter wrote:
> On Thu, Sep 04, 2025 at 02:14:41AM +0000, Vivek BalachandharTN wrote:
>> Adjust indentation in a nested if-statement to match kernel coding
>> style and improve readability.
>>
>> No functional changes.
>>
>> Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
>> ---
>>   drivers/staging/rtl8723bs/core/rtw_mlme.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
>> index d05ff073af2d..a2b1e34765ac 100644
>> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
>> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
>> @@ -1254,8 +1254,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
>>   
>>   					ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, pnetwork->network.mac_address);
>>   					if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
>> -						if (ptarget_wlan)
>> -							ptarget_wlan->fixed = true;
>> +					    if (ptarget_wlan)
>> +						ptarget_wlan->fixed = true;
> Wait, what?  We're moving from tabs to 4 space indents?
>
> regards,
> dan carpenter
>

