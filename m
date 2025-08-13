Return-Path: <linux-kernel+bounces-766584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C231B248AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F043F1A23CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD87C2F746F;
	Wed, 13 Aug 2025 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R+QtCxW9"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415502D94B0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085370; cv=none; b=J+5k8D0MmQqH54zutG1xdPLbrF3T/dTp7sG7U3htaUcibpO4+bCYbuwcgFRQqIN8+13VLW6rWEm1OjDwyE4N/H7NHecMZLk0UubB9/K5x32aOzjRDqecWmTNoS425h5qN4wnRgpKwS/KUHCJm0G2oDOtDX8B6UB02SxeF6AMbj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085370; c=relaxed/simple;
	bh=X7U+mjFH3gmS1vRftuxVLMIOTLTXZCBjm/MT4N3gEuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wmm28W5xjmzBlkA5LDVd4SXDtWmxBtik7pydZFsTj7c9ZzhzvHo2Dy5AdpqSg9ZqmX/nyZJ0HjOMAE74jtDoWF+bl3yPvpLZojY+IhzDG51H1bVb0sFbORWWoApzCyIHcwiXMwsXE7apl/x+J7lKrK5oGCZVoAiWWbBE4vSZMEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R+QtCxW9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b78294a233so5338734f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 04:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755085366; x=1755690166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aTo7s378Kcf6UuSFAtVXg7XgG7my/qL2nbdzH+wimf8=;
        b=R+QtCxW9o3ZQsYC16n0Q7pOU+pVjRG3iTLR+uK7myKq2Ze9NL1m12LRJbehwg24eXX
         7JTfJiVIl5C6GZK2Mb3Yl8OPyovg2yedICpBFfEHBNusWvb1JRA/6+qfrUcT0UX2zRmL
         smT2hs7k5eP3F9eDoBztBk7h+JeXaG5gKY5uRQYBqBMW9td62LULBXrodu331NNixT+p
         AkdGIbwzXIupQnI3M82ESbZNvWn3HmjP+wsCFKJDs6ZLfXq1PE7IyztcXRAel+fahSpi
         i+nXVYRoxrJ3UJyBIB73orVBqdsxVE13o4X3NZrU5I/Mzszb1puvcABU+SKzDAIJNYWf
         zLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755085366; x=1755690166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTo7s378Kcf6UuSFAtVXg7XgG7my/qL2nbdzH+wimf8=;
        b=arQqKnBpyQXPCDkpVQ0zR8uw/bbdHuTRt5YbS2lZBUST3o8X5nQDQLHLkNOHoJwjXM
         V6h56MaXHmEKOrLxQ+JVJO7c4hmBl4qdLsXH1Y4kYcemu6EWvfdnbzU9tHEWEGhCOod1
         xCxNVLGPcKIB0cn0L0z4Yp34vDChJLT6a9g3q31ivO16Dq0iO77ZQMTmTPQj2mhRlAVQ
         chtkRPQCJ4qrxVmTaOnaZsUZNnX2/dCsTizBFXjmr4U7FQB8pRye+ekN8K3M1SEXPYKh
         GAi2TFKI0a6eZthliGf6fW6qvwdd/wOIq+3r59B2H0TcXjfrQyIw0uuWloJ1em3uM9KF
         RebQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1BJG12DiWk8MQJzaXZ+IC+PUoy1tAst9LpsbYz/pK37P1eGoGCxSoNYbb2V6tNJYjiZ/T5S7LA9OYKQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOysJWIuD50IPvVlOR0ujyzemE6DOEGNa3/axOmS0W4iryPU34
	v+4Ad5c4xJTqk80JWTwU/Qt5M6kTw6zsa93W1qzrK4rD1fPV89SLgVJ3pCkiyCD/ifg=
X-Gm-Gg: ASbGncsfk1gevIhOcvhhFEo8Qq26FbhnXw59o/x318YRw4DoVFPMxt53ril6ruMpThI
	jj09s6i3jj81X10Rset1R0Nb1yqE+zzSezbM6BlKVM3jg0XffAECOKt5bOFXEqDcQrVavzAj2vS
	BKAYfOIar7NC3fQDivDLw5DB88jLrG+AWPNQU8UQCmjKFnkcGnb4O/GcFKTe5FF6Jyh6N7YAmfW
	Tw14k3RpZp1CRMNjHwleRnn1WjUsiIZH/F3eLOhILlJnEQXY+PMIr+2iDC1lmDf6dmI3vZAr09w
	Kaer09HRAApcftwJaev4A7Hlsno4M+kcufZANdTxU23Sk+f7WUdDPWKEnfSKiO1hNabShgaL6j7
	QZDR55kBpWyi5xgMx0SdWfPxyZn8/8i1Ovbh73cHYsGg=
X-Google-Smtp-Source: AGHT+IEEcwZO9dERKhXqxNNV3ptLVu6kRq96H/stbNfOwPybl4evUuT0V+47uqfXsIc4PEZUdJ7tdA==
X-Received: by 2002:a05:6000:4282:b0:3b7:8412:4540 with SMTP id ffacd0b85a97d-3b917eaebcdmr2106980f8f.27.1755085366500;
        Wed, 13 Aug 2025 04:42:46 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef8204sm324578415ad.34.2025.08.13.04.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 04:42:46 -0700 (PDT)
Message-ID: <f0a77c72-8fad-4fc5-9198-2a9c7c97a489@suse.com>
Date: Wed, 13 Aug 2025 13:42:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] params: Replace deprecated strcpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Shyam Saini <shyamsaini@linux.microsoft.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
References: <20250810214456.2236-1-thorsten.blum@linux.dev>
 <5d334a1f-0dbd-4e25-bbc5-b01aca369385@suse.com>
 <F640B308-C8C4-439B-8217-98FFC10BB76B@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <F640B308-C8C4-439B-8217-98FFC10BB76B@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 11:33 AM, Thorsten Blum wrote:
> Hi Petr,
> 
> On 13. Aug 2025, at 10:59, Petr Pavlu wrote:
>> Since the code already calculated the length of val and that it fits
>> into kps->string, is there any advantage (or disadvantage) to using
>> strscpy() over memcpy()?
> 
> strscpy() guarantees that the destination buffer 'kps->string' is always
> NUL-terminated, even if the source 'val' is not. memcpy() just copies
> the bytes as they are.
> 
> If it were guaranteed that 'val' is always NUL-terminated, memcpy()
> would be fine too, but since param_set_copystring() is exported, we
> probably can't make that assumption.

The function param_set_copystring() checks using
'strnlen(val, kps->maxlen) == kps->maxlen' if val contains NUL in the
first kps->maxlen bytes. It can use memcpy() instead of strscpy() to
avoid repeating this work.

-- Petr

