Return-Path: <linux-kernel+bounces-759639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC607B1E07F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 04:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93336582D48
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 02:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C3C1624E1;
	Fri,  8 Aug 2025 02:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e6OTTpJ+"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B40B72629
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 02:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619286; cv=none; b=NtqyV1DHsKQb0OX90pMLUqTNAEXo8DufMI2D8H0vhGtPrcB6wx71R6kB/tbDd/hdRS+gPP2zXJbb06qllEKYJtHVQqpdTumHaqskfQsYXwPz8zD9tiLipdGyuDygTBZrDrdFmRTcrP1zc9xVOpMM1U/rHDPUKq2E+7wOZ/ALqiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619286; c=relaxed/simple;
	bh=wQtY/4WqbgE2guErpzIRLGgpkmE00KVZtNgRMV+Pi9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWbDzqnrb8vCGqIvMrQNxfdQipKkFvAkLcRy1YL1OsPLPLcEDRTFXtwDxrh6x8BW1s/l2qSfmIXbo5SvMxMSjX+jPDPBxF7AP55PUCx8MjLrRZJq0E1PP+T/Iy+S4uJ/dP3WI+ju7IFYCyZ7Ww++knfxSVbAhIiQmcW/Y/l0f4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e6OTTpJ+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-240718d5920so60945ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 19:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754619284; x=1755224084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U/CmW/UMEXSdHhdIMaJM/qU0QyxbiGV2rEVZVgEQQR0=;
        b=e6OTTpJ+CMRNIcfLBNXCn1/5XxPUHS0WOW1XKnBcfBLkCGavtrBGjBC62UuQPf7eG7
         88sP2h8TBrm1wa64Ex9S88Tc3NNR0iSjfXUFEz7Hp9dNqH0Rt3nUQqY/IN80bAPSr0iA
         6qOTQZTXbKuEYcBDSmwoUHYX9NLlW63bL+bysCYrHZPsADBRKJ2Y1WLMZ87YE48p+DsH
         4QaJAXaUE1u72TNxwAbHCY4s7cwoZmEzQX+9inhG6z6pm8m11ADGefYM6rWjBlGh4Bs6
         maHBzprpG6TbbpWZ28/nmZRawLfrnxWTjNUCQlRtHTdVP839XPHNFGqwl5dHEnxrTD+e
         JTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754619284; x=1755224084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/CmW/UMEXSdHhdIMaJM/qU0QyxbiGV2rEVZVgEQQR0=;
        b=GFOmH1dhQyW1L2hlJOa6AVJLK1U6CK2c96WbvPXw1oot/2EKYcxU7ew+2G0vKwB8LO
         dMz73Zt8wCR6uKUeDS0VCJWnihx5bgW7u1eRqjsIuiXFXJobbRrhpr48K8dqF7ryFRuw
         IXd6xmy4kyRhhrbuu7YidDwt5zaxK342i1KEjAdoGhlWPOI0vmbdCSItPqLFLLFhlpsD
         Tny3CKzuPGhHme0b5F1MtTKFmzEGwg92XyTj3vOySiv5NYxDf1eWzW0SbNv/892UbiPY
         Z5ENsIrTedzJ6R4LhTCvtoTD0gMHe/fvO5EPMTpBWaKHCe0rXwunzz20drpDjZ43QCLu
         wKdA==
X-Forwarded-Encrypted: i=1; AJvYcCWYgtWqn9/pcKgA+q4jR1FCczDadLHk1Y8TndwKSTbwqlROLqFw7IJxNka0wZ6oFz/LIpkLjjtdpit21yg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww+fFPzgetUIywbatdJjvX+Oqu2f9gJZVZyZ9ZyIjlAA2t98+h
	BP+YIp8v1sy4wKWd4QQWAKKHN2LeEzChMb9WG7Bn8JoCqQBzpCpBA6A9NBmUl6Ag6A==
X-Gm-Gg: ASbGncuWcCf4Ejc8mxYhOFhjwqaBAGAMLNo7+2tBjKPn70tJy/ZbhZboRYFOcd47fBi
	3moZz2ob/e/pFd1LfCYW6TppH+yxrG/fm/n/ULuDRCDiL9xVWDeEAyqH0ITPMDKi+LPBPV5kw+J
	QkVBH10o7qdQ9hSOyarTozvA2WgY84Cqz3l0lx8sijXx4UFNta5qcLyfObdmi4qNzuOZ2ORG7sM
	4CziOO6w4tHL2d3JtCivXpM9gY6QnoJ0dUjIdcRy92BOwgUtwCltML9FL67AUS/N7+Oqf6JZ0j8
	td/c76UCrPKRpks9q+TxbqXwRVozdCfMqv6T9VpZAOdizwEk9BiEnVRE9vKnV4IRnNP77+hsUBV
	wft5w8C7GxS07Q3t85GDKVQOHyhirO0jgX+aUARkRrC/oNiZD2En04Z7mEiVEPQ==
X-Google-Smtp-Source: AGHT+IGDf1jT+enxl9JNofYHdNovWwHe1MWvyEkHBvgLmHv5L9E3x/M/t1aB9uYIJEtO8WST68i8fw==
X-Received: by 2002:a17:903:3b87:b0:240:2bd3:861 with SMTP id d9443c01a7336-242c16e10e2mr1712075ad.10.1754619283982;
        Thu, 07 Aug 2025 19:14:43 -0700 (PDT)
Received: from google.com (167.212.233.35.bc.googleusercontent.com. [35.233.212.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3216128ac08sm6689684a91.30.2025.08.07.19.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 19:14:43 -0700 (PDT)
Date: Fri, 8 Aug 2025 02:14:39 +0000
From: Prashant Malani <pmalani@google.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
Message-ID: <aJVdjwU-qkdDIXaD@google.com>
References: <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com>
 <CAFivqm+kbRbJsJ_Obb4bV6fgxbqAwOndLUCDwHvWWnpMYoNoNw@mail.gmail.com>
 <aIvSe9VtZ-zlYfbQ@arm.com>
 <CAFivqmKR1dqVqTsoznH2-n8cyAM1=5zEGcEvmESU8RNGac-0sA@mail.gmail.com>
 <CAFivqmKgiVEWMQ90Lh6T+Y44E6m4jmdF5sUFfVNTmgVHOMtZsw@mail.gmail.com>
 <aJMCgGt5zu5Dhrd5@arm.com>
 <CAFivqmLSp6RwfsPBK0d=zvRd6M_5GoeU4jHb-0OM9BpaDeSrzA@mail.gmail.com>
 <aJR-4J-sTpLaNIJB@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJR-4J-sTpLaNIJB@arm.com>

Hi Beata,

On Aug 07 12:24, Beata Michalska wrote:
> Right .... that's what happens when you are (I am) making last minute clean up.
> That should fix it. Would you mind giving it another go ? Would appreciate it.
> 
> ---
> BR
> Beata
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 65adb78a9a87..2a51e93fcd6c 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -543,7 +543,7 @@ void counters_burst_read_on_cpu(void *arg)
>  
>  static inline bool cpc_reg_supported(struct cpc_reg *reg)
>  {
> -       return !((u64)reg->address != 0x0 || (u64)reg->address != 0x1);
> +       return !((u64)reg->address != 0x0 && (u64)reg->address != 0x1);
>  }

Here are the measurements with the fix:

The readings are less accurate. There are some which report
3.4 GHz (as earlier) but many are off:

t0: del:77500009084, ref:22804739600
t1: del:77500020316, ref:22804743100
ref_perf:10
delivered_perf:32

t0: del:77910203848, ref:22941794740
t1: del:77910215594, ref:22941798070
ref_perf:10
delivered_perf:35

t0: del:77354782419, ref:22762276000
t1: del:77354793991, ref:22762279400
ref_perf:10
delivered_perf:34

t0: del:64470686034, ref:22998377620
t1: del:64470695313, ref:22998380880
ref_perf:10
delivered_perf:28

t0: del:78019898424, ref:22957940640
t1: del:78019912872, ref:22957944590
ref_perf:10
delivered_perf:36

Best regards,

-Prashant

