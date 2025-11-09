Return-Path: <linux-kernel+bounces-891933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6198FC43D84
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 13:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120033A970A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 12:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FF22EC09B;
	Sun,  9 Nov 2025 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4XHjkXy"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7682E7BDE
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762691347; cv=none; b=kVC8eWIThN2bWcOZjfaaKHUjPyxrAoexuiSZcFdpSMFXcqHsanoMctGSdG9C0t0ZLsiqGgbcJI6j/7zOoVCCu2q8QzaJpYB5zIlFh110GuSEmqLsO85UnxM6GeIg5LY/B9GMlfuVTAyy2vJLe7NO6ykted1tUDsBA9kPqkG8/P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762691347; c=relaxed/simple;
	bh=+Fj8UCA6PFYAVUdnQDCZ7U9phZKfSbyakTHFESM1D7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZJjubG3BlFLUVIuzM5G84nhOqibouIQYt0kkD7seNzQJ7FrP+dliaWsVvTYnL4GaQqgLa5BtWUu5riiTup1Uor3JZCq3wle2lVpATwEU8T2tfyDkc4gp0q9oT1oX33Uwx+qVo5X9SWrUFrEtv7N85Kx1nA6CRclLwaOUKwuK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4XHjkXy; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso1536192b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 04:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762691345; x=1763296145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Sfh23gMPuSgFh9wP8m+RA7LgOjNZR3fljD+XVnQlZc=;
        b=K4XHjkXyWwOD1LN3ttrU8mst/IAcGQcqk2M9yWKv7e64+MzXp8wpEXrcMDoAwTqUnb
         ZiL//Etns/PYZb7FkedKuwlCAlRp37sFby0uLvMW0ZYkzL019tAUWAlURcaG99c+TZZ3
         X7YdOxvxy6qZfavELowgl64T9VUBJrowrbs1jAmE8vl8EA5i0aP5Vty21a4ivZn3JvUO
         4Mey0Y3jBNM51ACA/AUhPc1J0wetkLw5ZqmuwzHiGGJuVOxJsr/LCmO/pNiJB9f587bz
         +WH31G/7h45teVibVEq7/GNhhd/qSYcsuQD003aKE/+7wznOTIx6w4bFV1EgsJHcfT96
         w+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762691345; x=1763296145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Sfh23gMPuSgFh9wP8m+RA7LgOjNZR3fljD+XVnQlZc=;
        b=H2+18/o0YVgGj+IHfV65h4J5nTJFUuHh18eOTfFwdxddHOvVekC+52nYfCvZsEeOdv
         U7vvCk7H2YOGqNJqsuzrCif/cBv3+jA4C+cyzP3VJOYlq5ZoMOEZ07HDLOed2davi7LI
         xumFM0zHGsf6HeT5tP/znT8LOFr5Mrzg9iZWBdLadY7tuvXJc/5zD/jLZkRDyM1XSVS2
         +nH4Og3CrR0NdMzzvP1/Fpc3w5HMY6G/4DRoJSH6sYbaZ6CbTdazk8pA3DlmK9EI0Coz
         vIljPor9moQ8oZqLMZ1Cb9KospDjey0MMjA1oCFj+P76TTgiyDc4A2lz9kq2yuepUc8u
         Tzyw==
X-Gm-Message-State: AOJu0YyfdJks2U8FEObSIV1NHmbw3k1YoBCocicmKKQIJEsW6u5xSnnD
	GuPU4euKhQnZaP3InePIfwJVDBfoIFRJ6yOn5xyaOqjiP/g2WHX6gw+FE65Fs8EuiN8=
X-Gm-Gg: ASbGnctVbxBhjLPTHd+gVabavhaaLKDe+e6fvElQXh/SnaJuh++cBTeLBqIAKTbJ/5j
	Q2mTdtuKClO48qCX53WNVT7qRpeWgK/p9PPsDT7Y7g23wZj6Z2IRvllB90ERGVBsIPu7osZKPtB
	MV6/ynsKY3w8yUQ2rzX6y1DDg3mdDMsvi0fD0pHoGOxmw3uFYk87uq2oPkufu4AScBuN6JHgg0t
	OfN5WypF18g3N6kJtKIY5OedRPDf2CTzVrY/Tux3UIfMh+mLGs3vSYW8eIipLUhrCD7ctFb5mLx
	HTshd6p4+ervG+iroIS6puNbrMyeYUVhZLb28E9NiW/Yn6dp1oERYqtbDNeMj5kY1uugfqcTE1l
	YlyTHgzQuwIG/4J3bSuBwbMWyXq3gMtV8eEaJExl3FCJbNAOrCfpf/dFylbr2u2nx558/j6EdNm
	aq3h364UVRZyjurQ9n6w==
X-Google-Smtp-Source: AGHT+IEkKiASBAM/v8nmSr1bnyXvE15oiC0TbeFeqMLmzAA0Ln0KLA0nGZWhrWf0I/1B3xOi0IZyGw==
X-Received: by 2002:a05:6a20:734f:b0:2cc:acef:95ee with SMTP id adf61e73a8af0-353a428d5fcmr5965129637.52.1762691344990;
        Sun, 09 Nov 2025 04:29:04 -0800 (PST)
Received: from [192.168.1.50] ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8ffd3f6easm10211085a12.21.2025.11.09.04.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 04:29:04 -0800 (PST)
Message-ID: <e5e3a542-ee07-4fe5-a6d5-2bc5b2fa873f@gmail.com>
Date: Sun, 9 Nov 2025 19:29:00 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: tpm: tpm-security: Demote "Null Primary
 Key Certification in Userspace" section
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Integrity <linux-integrity@vger.kernel.org>,
 Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jonathan Corbet <corbet@lwn.net>
References: <20251104131312.23791-1-bagasdotme@gmail.com>
 <aRAdiUB9otJk5i9U@kernel.org>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <aRAdiUB9otJk5i9U@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/9/25 11:50, Jarkko Sakkinen wrote:
> On Tue, Nov 04, 2025 at 08:13:12PM +0700, Bagas Sanjaya wrote:
>> The last section heading in TPM security docs is formatted as title
>> heading instead. As such, it shows up as TPM toctree entry. Demote it
>> to section heading as appropriate.
>>
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> ---
>>   Documentation/security/tpm/tpm-security.rst | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/security/tpm/tpm-security.rst b/Documentation/security/tpm/tpm-security.rst
>> index 4f633f2510336b..bf73bbe66db2fa 100644
>> --- a/Documentation/security/tpm/tpm-security.rst
>> +++ b/Documentation/security/tpm/tpm-security.rst
>> @@ -153,7 +153,7 @@ protect key sealing and parameter decryption to protect key unsealing
>>   and random number generation.
>>   
>>   Null Primary Key Certification in Userspace
>> -===========================================
>> +-------------------------------------------
>>   
>>   Every TPM comes shipped with a couple of X.509 certificates for the
>>   primary endorsement key.  This document assumes that the Elliptic
>>
>> base-commit: 27600b51fbc8b9a4eba18c8d88d7edb146605f3f
>> -- 
>> An old man doll... just what I always wanted! - Clara
>>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Should I pick this?
> 

Of course!

-- 
An old man doll... just what I always wanted! - Clara

