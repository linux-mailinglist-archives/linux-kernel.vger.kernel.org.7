Return-Path: <linux-kernel+bounces-837330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75718BAC0CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8D01C1D10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1AF2F3C0F;
	Tue, 30 Sep 2025 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7I6h9//"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B606A2EC0A5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759220972; cv=none; b=Tz4bE3KE1kis3DuDrQ/lwTWkU7D8FL6fgRAWIz6ReCkgGSYG4CO9epiNJZK2ix+s5LBwrYo0VrXpXLA1YhS55pZ56CR5ORUtnk1JxM0vB8cj9FAE68zjs+V9m2jlIA2jg/WnBZQcHdYS8SZ54YhclZLzasYoPr0IHoLbhxbk84w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759220972; c=relaxed/simple;
	bh=Yig0DB5Nocvfmkfkz2eJd7bQ6VObcByu+V+o6O2P4D8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVAgSDoRD/HevLy/pBiKCstifWOoJhAqCt/1iPozACxntdyy9GWhTR/jmYNtdrCodvMedMWdgAwHpP50zi4YKFb5VJY8apfSeGiuUx8gOH5sh5pxMjBWZ91DtYSsy5tB6unv4j2fEwqU1d6buWoGbKGyVd4KxWjPgD3GW8dIPtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7I6h9//; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-856222505eeso613959585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759220969; x=1759825769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nHrm3N7DMKd3ASATv02U79FutuaO95JHuxa5lXRIjM0=;
        b=g7I6h9///hzM27L7FutTWtRZWNQuN//Ir9RgJ3PhAAuOfoxjPfXxkbrl1hK2EuCwC6
         V3Ul6EyAY4xeL6OQZ5IvAkMpX6M3SPIDcbMnZz1xgzFaQMRqUp+9zhSb/87LyA9mRa0i
         0bFkJ7qrkhnyIDb4QdKEiW/5zluzyWS+fARyEXRKnMvyQbOJBJ1RUWmOeq7ZrwxRx2BY
         kC6t42EZH5qSTb0lWCQPrPa/+EUQw3XqCXzbHqr9ssIGYmTHtGUb5T3vw4fySKAwCX1G
         BuHqf64A7fZlbVbpGHUpO271rZDjnS4R7+xS8pvBC3OAopyZFKl2jb68I1100eh0rkaG
         Pyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759220969; x=1759825769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nHrm3N7DMKd3ASATv02U79FutuaO95JHuxa5lXRIjM0=;
        b=Gmd4co6jhFSblK7XaTJ27r3e/D1cRhhSq7SOJC03/C04XSsBfo6gttVCL9athcZUme
         SM3i3fNrW/pbIDmLZUA5Rh/PjWViOctmBW+3JRduHEqdwQCgKxt5ajJZMFJQzpPxf8k9
         peu2fMlXHQh3ZUP7GiuZkEK22Zm9EhYcz+DRWtFCMYYZDfCKGYm+mW3iZ7uZ7blz9kej
         HOS1DKxCeuXmVTOwYzil1pmtCGLn3aoneVQG8M/p3EDlj48Iuxi4MwDszLlRN3gSzXTn
         HUbTz6K0WOlfmFViO5GFr+kLt+1nBS+zBtmnSQJxFq6D73N+1V9/6KUe5y6F+GZhrP2o
         r96w==
X-Forwarded-Encrypted: i=1; AJvYcCXwJkWWXX9a3k8Azls4oZoY/L0CKgOIDlsenK0sMVpKLHodGejCGzdnzXgOHGUDeNu/pyIa92MUuiPsCDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNGBadqKS3Kvafz0AoLOT7X9C/mGiq1+HStSBcqLu3dJ1EBTct
	NnM60Ri1iK5wuVaBlrF0Il6gcXoec70uWkPy3fvD/tjxTYVlNwMCakVz
X-Gm-Gg: ASbGncteUNo9E1/pKlXeA/AEV2qJSIcehJ7ZnTQtzq+9pCKW2jlsn7SlKnSlEJd9w7d
	3byC34ve6xiv+vhar+SD5qd5tsmvAwYu9Udyk5wKsQoLil4kAEuKWpqVoKsugvc37hyq5q4l6UP
	8G/u0nq8vgK4GI4sTvWrQMJo3A8bp762k+AJiD1fdyVGq/XpzDwaF3obP5WHJ0dXJexTuIbM7Fp
	JRs6un3i928E7SoJ8fISg4brvn9ZxDKx21SvleDEdfb1d3NlLjhEqSNH1EcUPNWUFfa0CUSDeYN
	PcSISmlNunrkL6NMWwzg2j2sBbU7Q/Fa5+aTouuEpoXBAl4R2O2M3KU+2++IfB1EgB+4X6B2AVJ
	vuqK/zGOzuv2nXiCRnzgllGPnapmZNR30Eg4gowUMD6Bv6vFAwtfVd/ouSl4G5AkagnxOFj7Wig
	==
X-Google-Smtp-Source: AGHT+IFJN/IMothj+b6Fuwyvmm73qXzhC42sWbV9OgNud2Dt4rw0sbX9+PQTd+HPuLn6qy4LdETXUg==
X-Received: by 2002:a05:620a:480c:b0:813:7fd7:8726 with SMTP id af79cd13be357-85ae94c6c3fmr2394125785a.67.1759220968674;
        Tue, 30 Sep 2025 01:29:28 -0700 (PDT)
Received: from [192.168.0.155] ([170.10.253.128])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c29ae247fsm979009585a.30.2025.09.30.01.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 01:29:28 -0700 (PDT)
Message-ID: <687549ed-7610-4bd8-ba30-854c99868cc1@gmail.com>
Date: Tue, 30 Sep 2025 04:29:26 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/15] staging: rtl8723bs: align asterisk in block
 comment to fix formatting
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250929065000.1010848-1-vivek.balachandhar@gmail.com>
 <20250929065000.1010848-5-vivek.balachandhar@gmail.com>
 <2025092953-depravity-oasis-93cb@gregkh>
Content-Language: en-CA
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
In-Reply-To: <2025092953-depravity-oasis-93cb@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for pointing it out. Ack. I’ll wait for more comments from the 
community for another three days and then will send the next version.

Best, Vivek

On 2025-09-29 2:58 a.m., Greg KH wrote:
> On Mon, Sep 29, 2025 at 06:49:49AM +0000, Vivek BalachandharTN wrote:
>> Align the leading asterisks in a multi-line block comment to maintain
>> consistent formatting and improve readability,in accordance with kernel
>> coding style guidelines. No functional changes.
>>
>> Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
>> ---
>>   drivers/staging/rtl8723bs/core/rtw_mlme.c | 40 +++++++++++------------
>>   1 file changed, 20 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
>> index 3eeea832dcb6..cd41f713a52e 100644
>> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
>> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
>> @@ -869,8 +869,8 @@ static void find_network(struct adapter *adapter)
>>   }
>>   
>>   /*
>> -*rtw_free_assoc_resources: the caller has to lock pmlmepriv->lock
>> -*/
>> + *rtw_free_assoc_resources: the caller has to lock pmlmepriv->lock
> Shouldn't you also have a space after the '*' and before the 'r'?
>
> thanks,
>
> greg k-h

