Return-Path: <linux-kernel+bounces-840749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F566BB523D
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FD03C696C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A28828489B;
	Thu,  2 Oct 2025 20:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaxpuPeZ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF54271469
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759437827; cv=none; b=KdCM0BKjqck7F2jvf5emNp47ZDkp1qrzehIcLInbAAH18GgKpZZVMbsCVWUCzw12IkdoI9NQ+xdB5aFoQ7PQGz7mK0CoKckE1A94ZCYNwyh5mFsD7xWy1NxvcCV5K5+4OmBIlJ+iYVjZPCGy16Z0lwTbUpnUikVVaBUEdN5OQPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759437827; c=relaxed/simple;
	bh=hWzuRXDCrUX3zFh4rzWTXm0POiqsAnBBM5ORPbOLcyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DnGX2126eh0rFvBasVJ8IM2Vr8Yf0V9P6QlqmCUMgw/rxXEl4o2dDaGQMiX7l31XlPSlIXIsDMVRIWTWlDhh+yTs5F9a+Hq9rcczB2MlzLqrIRysjOdQXyMVeEmuF8j8J9L+7YpI55whXP+9mJZM8Gb81ysc6SQZMG2Cw8bCGgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaxpuPeZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27edcbcd158so18698085ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759437826; x=1760042626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HRY0VePK+ES3Imbvh+CGHLFf9jXlNxuHmEATSkHnxuM=;
        b=aaxpuPeZIFniEZmRRG0DNgYGX1gAfnykimvvVZbR0V4yEADJj2eQJizB8PebSoR2qu
         lQGtlKyyFvonxAbWWJzrPyM/rD1zz9bbmeMrA97ngZ56fhikfFIzsclT3LfXXM6ZYnJY
         QGgB0F8UtSaNSvcJzNUvF14ePOHqNYOwFs33wE/ZaGmNYYyDKQBZFqZDOYwVv1gzVQgo
         ZR1W3yG9tB8yqG5kYdzj4lK4lR1nKKxnOLzjm9YFQcwJUo3ck9m4SUvLtevY9QwoT/xM
         be0j3W8OulWwu6ln2I3cyO9TbMciEFn5kvpNPmXmueDaq5m55Od4ylDef3vRB8ljHGqm
         1HHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759437826; x=1760042626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRY0VePK+ES3Imbvh+CGHLFf9jXlNxuHmEATSkHnxuM=;
        b=J8RAjdTsDf07t0cUbMKDMHTJu17enctc+mIiUS4RwP4NLHb86FIXUom6Z5nBeXlKlQ
         gLKlGm1cLSMjLSdAqC6N8zFAsRwYBE3kKcQ9eu/0AYr5SeWzVMzzNW/l4TyW1jdMWZei
         pXYj6eEN/oJu5YqivQ7xTmF5NpwnyyuP3sd7P3S951ztwhywswRHom81iMUFksSJ63UL
         DBv3orF6N4tc2w3LM91XFaCMcBo+ViCYe+oTH1qOn5Vc2ZIphyyN2frANkxt4OQAb9bD
         3nhPmOBMSQNldEWyPvg9YpQH2o8uP3VdzCiJArALQmLzMt/XR20Ir+qY/E5jFzC5pnP7
         9gMw==
X-Forwarded-Encrypted: i=1; AJvYcCWOI+aUejDPHzrL1t1LZ413VN11tF0vz4+YzxF1oAdowjZItsqXp2hfNEwwccoLXEJClrvvDHRM8wYgRJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE91frSmrYgYFiZBJU8DBH0tHeA1s+T6rkcO13u/YdkNcjPjE7
	dKlHaL3P+c7hJd9Plzr9C9rWO/sb/lr4+igHNjqrZPXCOql1Dv+qSMgF
X-Gm-Gg: ASbGnctll63WETB341TOiQIAbMLgXshuyKVSe403bhUxxs8R9tJEMap5FVnI9qQ/tQI
	F2LYn6Mq9kfZFJIbWnmdZWb/BAMB9GwYDgf/LtWspHCo8YNckbVsgCgBzdfGYngzuhqS8rV7JfL
	UTotqKjDOcy6v4ltYXbXw4iObYfSftsQTBBc29yfhkybLresh4Yhxhsbjskn81JwHlELnL0Pv1n
	3Jwet9CyGkJOW2eeCB4H1Vfkv+T9e2h7GvbsJUH95fHxv8dWIQqHhgOEom753LGjtDfZq65sj4m
	Huf8na2/FX/TE5emnCR7ZtkwmFiRyE9wOuoLkia1Q4tj0W8JnG3Bxols+FmR6GGyA6zoM5VX2Gf
	O3242asS+a/nK0ba0I/n1NZNnXEaAKiyVBL8d+Vmp3LotCAad
X-Google-Smtp-Source: AGHT+IHwQNosp0cXnn1EJbHqUTcUQOaG4RULI0Bh4YmEkrcrselSen1z+26ZGolK8E4JLN9dpIcDCA==
X-Received: by 2002:a17:902:cece:b0:27d:6f49:feb8 with SMTP id d9443c01a7336-28e9a546360mr7478395ad.16.1759437825699;
        Thu, 02 Oct 2025 13:43:45 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d125e9fsm29618905ad.36.2025.10.02.13.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 13:43:45 -0700 (PDT)
Message-ID: <30efd90b-ba9f-4291-b9a1-8739f1c5f24b@gmail.com>
Date: Thu, 2 Oct 2025 13:42:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Linux RISC-V trace framework and drivers
To: Greg KH <gregkh@linuxfoundation.org>, Anup Patel <apatel@ventanamicro.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Liang Kan <kan.liang@linux.intel.com>, Mayuresh Chitale
 <mchitale@gmail.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251002060732.100213-1-apatel@ventanamicro.com>
 <2025100208-challenge-protrude-d6c3@gregkh>
 <CAK9=C2U9FV6crTL1G2X6tUM=RyRnPBm1dPeFc29n3vmrFTcfHw@mail.gmail.com>
 <2025100255-catcall-drinkable-23f5@gregkh>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <2025100255-catcall-drinkable-23f5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/1/25 23:44, Greg KH wrote:
> On Thu, Oct 02, 2025 at 12:09:23PM +0530, Anup Patel wrote:
>> On Thu, Oct 2, 2025 at 11:56 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>>
>>> On Thu, Oct 02, 2025 at 11:37:21AM +0530, Anup Patel wrote:
>>>> This series adds initial support for RISC-V trace framework and drivers.
>>>> The RISC-V trace v1.0 specification is already ratified and can be found at:
>>>> https://github.com/riscv-non-isa/e-trace-encap/releases/tag/v1.0.0-ratified
>>>> https://github.com/riscv-non-isa/tg-nexus-trace/releases/tag/1.0_Ratified
>>>>
>>>> The RISC-V trace framework and drivers are designed to be agnostic to the
>>>> underlying trace protocol hence both RISC-V E-trace and RISC-V N-trace should
>>>> work fine. The discovery of trace protocl parameters are left to user-space
>>>> trace decoder.
>>>>
>>>> In ther future, there will be subsequent series adding:
>>>> 1) Sysfs support
>>>
>>> why does "trace" need sysfs support?  No other cpu platform uses that
>>> today, so why is a new user/kernel api needed?
>>
>> We saw trace support for other architectures (e.g. ARM coresight) allowing
>> trace start/stop through sysfs. If this is an obsolete or not preferred approach
>> then we will deprioritize and possibly never add it.
> 
> Why is that needed for coresight and other arches do not need it?
> Perhaps it should be deleted from that codebase instead?
> 
> thanks,
> 
> greg k-h

Hi Greg,

sysfs is helpful for controlling the trace if not utilized through perf
framework. It can also be used by userspace to discover the topology of
trace components and their capabilities. @Anup I assume this driver is
designed with other sinks in mind (not just ramsink), so it can be used
to emit trace to external probes, right?

Bo


