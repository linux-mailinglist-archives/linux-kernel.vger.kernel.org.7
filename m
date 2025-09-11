Return-Path: <linux-kernel+bounces-812563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67377B539CD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D609C5A5896
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352E734A33D;
	Thu, 11 Sep 2025 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WB7FGuEg"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD572B9A4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610050; cv=none; b=rg+PWWJXJiLXrxk8+4gqkFFFwAFMfg/3qKdKANU/KhFSHUXe2KFFTQEPfjFHxLBj6gtt3D61L1/OZcSjFBO5PoEacFlWambb7YkNiwvILyPYvhygllhIB1Cov7pyA4iQlQWvOjRRAxF+G0ODszSU5nDclFzWBA6pgNV1jD3NxFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610050; c=relaxed/simple;
	bh=y3ENDcuottwL/DKrenKbQJZ1eqbV0Flkl/Xv//bodSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Se6rvXQoK0YNzZnY45DL76R67/hQ8HL1tORrh16uplHIFQVuK8y8rrGZKBOgmCRkEnOFA8tPTb/gjvXXMr9SCNaeCyF7Mh38LxmcTHsdrQLfZ9x4G/S8QZ4jYTBFevEdKo5U4es7y7kmF9HIVJY8YoJMV/JfU6/o/cqHxCRWFDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WB7FGuEg; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-56097de96fcso94399e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757610046; x=1758214846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=69yPHnIsLNbjSOnGkb91deN9ujmIDIbQEy9l+ZyKWrc=;
        b=WB7FGuEguO+dYY55g/XFi4KCU0jRGHuGSL9+qp9LdxGIDf2yI4Gi17Jx2dtnNIAiVa
         jN1zWB/qdU1yFy8Kp4fdEPnFSR1njgIUZA/p6G8GE3ikUfZ4fTRSGeqRh/3HbrhfD8RG
         GQEvncpTXWA7A8+ww5oUQv/aoE2hE43lk1b5T6ai1+EI8QeY8l6zLcHDtkxjDSXIoMPo
         wJIb/5eBgdrfthTMoL/VDodIamBydoef/c9sarbqXPUBKYBN2ZPqg2dxvFPKX3ITAcnl
         4ushg6y3FL3AUGOyGpHDRKXuVftol+KSiJkuTd/d7+6jL1C0LMN53KXbBSZMbB3p/9Qg
         XB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757610046; x=1758214846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69yPHnIsLNbjSOnGkb91deN9ujmIDIbQEy9l+ZyKWrc=;
        b=jkZGjTBxyFS5nMaWCErgV2KYbLtCaTV5snO71OVV3Cl/4ww/itKF8FD65WG3tB9TOA
         +/C2sHEKokJdKwg6muabQ6X/zIyMKkqLkC0TkR7yECmrp4zI56GU6FZRJxFnulSSVQiC
         eKz8MP10PSzYC7JzO/qqxmySsPGAsq8k/6qSvmKHHK5LioGrWmADPlgb5M1dnYVJ3YzH
         Ne4dDNy6wX/4NfXLlypFhPD1pyN2FJubfVfPMa2MR6FR+5OTFurEcQF6W3n96iuRhGbM
         Pwxjit5Pyv9EfJMqAEpiEGtSL2Q5DPQTUUFSpSZa8ku1Uep7xe8sgvF8f3nC+WvLq6Vr
         6/Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUVaJYs7A9fimBdfEiSncS1Z9X9fhFDBOY9mRVUcMh2zj6PqWroupaGpaurqlJpgLA4FAl0ASigWvdZaK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeRKdxjGtGp71OPCQ9ljSjmHFBy7XTHhlV5RT/y5cydlt3v4cd
	6tqDgS0n8QHWrPpch83vIwcyAetIURWYrkG4d40RuTsgp0YYsLSeDpgZ
X-Gm-Gg: ASbGnctrypJzbO88OXs17CIGud621f7wXZbQwQE03ocUhoXt0qrFaHBQ6//Kd25dIvZ
	6zsgQul0waIMhzt58Y/uusIxOoH+/y8KRlh33pTugYFQHvNtQKD7XUxvT7IYJNiPhQSTMHPUx1u
	QX29IWqGnCK2sHp26oNu1NQpyOba5iMXuyaBslH2ncCG9h1MWvpt5AIhwuYdq2EZRTptw9bm/U3
	7MzmFTvAyZX+mkRiA+5t1xEKaOZj3T488J4cDpZDo9ukAh7zU2MOo1ab0giFXP4bhZjncnUCEKY
	dS9TKlC86Y2SwvmPzAGwU6qU47LMZXuQYmu2esk/s925kCPOBr9C6R9TpZta61sPYy/zr9OIOfb
	BHrOJbv5hZquDnijwiBvsWnITcHxwmAX5efHrlFc=
X-Google-Smtp-Source: AGHT+IHnjKPKaFzoMDps2A1lwwHuk+aMxy5X6+2P1DS5X0ZAITIfcYgwM13XJrpIiuwwI6P6z7dSYA==
X-Received: by 2002:a05:6512:3da1:b0:553:252f:adf4 with SMTP id 2adb3069b0e04-57051f3c81cmr19486e87.10.1757610045703;
        Thu, 11 Sep 2025 10:00:45 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460dec4sm523403e87.103.2025.09.11.10.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 10:00:45 -0700 (PDT)
Message-ID: <9f548efd-babf-45f2-99bb-e013c810ef72@gmail.com>
Date: Thu, 11 Sep 2025 19:00:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] kstate, test: add test module for testing kstate
 subsystem.
To: Randy Dunlap <rdunlap@infradead.org>,
 Andrey Ryabinin <arbn@yandex-team.com>, linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
 James Gowans <jgowans@amazon.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Baoquan He
 <bhe@redhat.com>, kexec@lists.infradead.org,
 Pratyush Yadav <ptyadav@amazon.de>, Jason Gunthorpe <jgg@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Rientjes <rientjes@google.com>, Pratyush Yadav <pratyush@kernel.org>,
 Changyuan Lyu <changyuanl@google.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Chris Li <chrisl@kernel.org>,
 Ashish.Kalra@amd.com, William Tu <witu@nvidia.com>,
 David Matlack <dmatlack@google.com>
References: <20250909201446.13138-1-arbn@yandex-team.com>
 <20250909201446.13138-6-arbn@yandex-team.com>
 <1c79b3c7-5847-4960-9454-0c70d02a6441@infradead.org>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <1c79b3c7-5847-4960-9454-0c70d02a6441@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/10/25 2:33 AM, Randy Dunlap wrote:
> 
> 
> On 9/9/25 1:14 PM, Andrey Ryabinin wrote:
>> diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
>> index b6ea861006bf..af9a25bdcd6e 100644
>> --- a/kernel/liveupdate/Kconfig
>> +++ b/kernel/liveupdate/Kconfig
>> @@ -69,6 +69,14 @@ config KSTATE
>>  	  state, save it into the memory and restore the state after kexec
>>  	  in new kernel.
>>  
>> +config KSTATE_TEST
>> +	bool "KSTATE test code"
>> +	help
>> +	  Build a simple test/playground code that is useful for kstate
> 
> 	  Build simple
> 
>> +	  subsystem development. It contains some structure with different
> 
> 	                                          structures
> ?
> 
>> +	  kind of data which migrated across kexec to the new kernel
> 
> 	  kinds        which are migrated
> 
>> +	  using KSTATE.
>> +
> 

Thanks, Randy. I'll fix this up, and the documentation as well.

