Return-Path: <linux-kernel+bounces-786168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B612B355E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A613A2039D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2082F39D7;
	Tue, 26 Aug 2025 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZNSVWdB"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAA51F8723;
	Tue, 26 Aug 2025 07:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756194139; cv=none; b=sYZUawsUJuXw73Y9nzN/EXlsLKP2MbiYIuGvuzxRur6H1T+aor+LzsjAp1PsleCyg0u7KPl56/LyqGhnWTy3AbtkORk7oWJeFs20SMu2zyiu6t033/OIBMDGy4MgDAi5KG196WEroc0KcsfOchFRn3mKP+ipYAn+9P8KaZrve40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756194139; c=relaxed/simple;
	bh=8Dnm6LTIYAhJi4bWdvEAqnpRElUivPwL3ZDlM0iDCak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYyb/1h8UA7IdHtpJui5QZg9lGcM889lL9RYaUmbPA+LqKIEz62Tw6VJOe1fj4FdDzE7yeayWjRYCuAHfAllCv/STrUlOoSMXhymTCmYFNtS9R4k/W41VoFjEFxUYeouhwxxsVXc7vTEfS2km2llvJceuy2HzSS1RgFUuZApPq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZNSVWdB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-244580523a0so51780225ad.1;
        Tue, 26 Aug 2025 00:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756194136; x=1756798936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5avve5K0r4ZBw/y3B3+9woG9oTDooCG2sxKJy01FS7g=;
        b=UZNSVWdBEUjmTCYAXSIkoQzCV6oVHudf9/IVpwgCiToZeObU9rXqurZAW+hADFHFYs
         N9G3SKCsT+/6rx8YEYZjoVWMzrHy1+JpRUY+GLcYdu6vNWhakauKgQ39dA8XO9ujkfWv
         0RsXO4Uh8RqTXpVHlB6zYq1chZYRdhv6gqgqNJp5JhTpUTfyzp0zfxVPXW1bUHrtfvsR
         Bhg62aYttPUgJ2kZ1sy7wiUkg9KWg5TyIiAUXweDjH3MDEBJFkBP+6eDFg77JTvAl4Iq
         b8lMPSJUvxHyAoqiqpkAfCuBYOG81SZcu3fDszPpRU6mTYyDHuwDEqu7GgSs0W0tBE4e
         UOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756194136; x=1756798936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5avve5K0r4ZBw/y3B3+9woG9oTDooCG2sxKJy01FS7g=;
        b=NVST7cYFNpSX6JHsM9IsjQVlRsjBJ9GaQtv7B9ZSXtv4YnDY+FB78iO2AmDt9T1Wjn
         mZS/aTsLQbneLIpnovwSyo9FjrZ31fnThlKuGX1HbL3JRu+QJDk5z9dyR/HFzmgCksmh
         7VdM2IoKrFEIib882NWIxTIOCuMEhLyzzsx6bf9f5+Ocpw8n6N29UDsYAcB1UlPsyyvn
         uOCrliaQXTKL5CkZO6ihncbki9RzmCoNMOyk2ep6a9fuAWcZOOU1ZmEqRagAdzG3V+2Q
         02cPySv/XoB+ewikqb4x2xTGOovtU0/Fip3D+CA2pixMkprpgOF8BtUa39kdT7ffBtqB
         FTEA==
X-Forwarded-Encrypted: i=1; AJvYcCVA1LeTPPaqz+Tl3ae15obyqhfASFcsZumqE1w9W3zxhvRIkyyCz0I4QKK1Skv2yeamrS6iq0YMjPk=@vger.kernel.org, AJvYcCVxRmg2IotcEfszNYP0bw8sU8nuOYKaj1e7i8CxVwkIROhyrGFX4fZe6d/atN337rCJiUifnad5GQgCvm9K@vger.kernel.org, AJvYcCWAnj8wrPUWWF/GVwLcK0PpNbGf/2WbUtkV0N7Y9cNvi7b+OdesF09ewUVwZ3oc28pv/Xw3VRKcp44v@vger.kernel.org
X-Gm-Message-State: AOJu0YyzYtRCr3wpbMhvld6ReSjvz/t3Jx9LsirWSpBdVqziD8i71sCX
	PkLzg71JW3qmEzWN7SfQLO27E0voUSJM9GunZPro5cwebwcKck/yeY7p
X-Gm-Gg: ASbGncvNdNId5LO/oetWmb9f4uXhdVsFSBtC2G/ABLqlmAS8unTqyv6m08BZGEMpNuq
	USA6bLbDRX2vYcN7son52n8nshGMuEfzGtUpSFOJB7KSNMXi/GEoqqrdbXSHPRVcEo6fWzoeaO/
	ANYnn0ztez2EKfQOATDBWcYEGHMMnTMaMsx5Ke/3buuNlg5Yb6UEYGE4rFN8KjFYbS/Whplxa0e
	EAV9iyvzvE3q2huw+0QWHGFocGck/49cLEH0lwAD4HCZou05MxTq7LuGbhgKtaeJXlQmoDMpt7z
	ZbcCL+xfeMXs+ntDNAdsnxYwAaCeOTJ4prwK3gWJcMoeN//Z/fWDcFaBo0QUEn2KW25UJ7JuLV5
	zSDk4+clpIIyQ3t1OHYSfyCrpjz7TcTW7+xoCxp5f
X-Google-Smtp-Source: AGHT+IEFcZtjLSZdczxv4eS+7pkAGInRGBtMajPGK66kHgxUefbn93THV9SVOhFmR4aQpV2rQTomyw==
X-Received: by 2002:a17:902:cec2:b0:240:9f9:46a0 with SMTP id d9443c01a7336-2462ef05828mr188106125ad.38.1756194135806;
        Tue, 26 Aug 2025 00:42:15 -0700 (PDT)
Received: from [192.168.0.150] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2467d4030fesm80659035ad.137.2025.08.26.00.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 00:42:15 -0700 (PDT)
Message-ID: <9044fe82-043f-4e45-b7cf-114a8860f650@gmail.com>
Date: Tue, 26 Aug 2025 14:42:11 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: management-style: Correct "know" past
 participle
To: Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Kernel Workflows <workflows@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Fox Foster <fox@tardis.ed.ac.uk>,
 Federico Vaga <federico.vaga@vaga.pv.it>,
 =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
References: <20250826003437.7695-2-bagasdotme@gmail.com>
 <67d355fc-7ee9-4203-9578-095004c4a7e6@infradead.org>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <67d355fc-7ee9-4203-9578-095004c4a7e6@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/25 13:54, Randy Dunlap wrote:
> 
> 
> On 8/25/25 5:34 PM, Bagas Sanjaya wrote:
>> Management style docs writes on people under a manager, where they know
>> the details better than the manager himself, in past perfect tense. Yet,
>> "know" is in infinitive form instead.
>>
>> Correct the verb form.
>>
> 
> Hi Bagas,
> 
> I don't know about the patch description/argument/justification,
> but the wording makes no sense to me...
> 

Do you mean the original or the patched? Should I left the former as-is?

Confused...

-- 
An old man doll... just what I always wanted! - Clara

