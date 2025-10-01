Return-Path: <linux-kernel+bounces-838982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2A0BB0906
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295FB2A1398
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5726A2FC016;
	Wed,  1 Oct 2025 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NlqwsgHc"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2922FBE0B
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759326553; cv=none; b=fpEDBIV4y1vaWwrYCZWyV8dR5JdnXZMEx8SS9tRvme99KodfngfAhiiFwfUW6hVGn8bey1RaE/IyBA3MLv3TFaOU24ak9o7znfiFtDGjarZv7gIE3ipkc9OHlvX5n5XX+QSKfCN+zS4uo80G/8iibP4JItyr5//f00bUjPmemDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759326553; c=relaxed/simple;
	bh=oUMtdNZYK6Fyw7iywZcExti86DdeEspgiPN/lnLvNww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cG7GnUa/Xf7fLH/oIjSUXa1ZmEQzuDvU6lJBT6eeprzabNXqog3wxpwo4si+lbFEOEvWG/y1gkZFPuQS3Jv/8zdzQSfluug3Ia3qfZsOBQP5K8c5uccN3MVuWNoamDuac6HF5AFid5LN3YwLMYxtOUcn9J+sk3v/mkoz2XFE0KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NlqwsgHc; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso6534498f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 06:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759326550; x=1759931350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aXTHbm1yGkE2/zORBswhWrACx80/EC1QRjdLtiEom4Q=;
        b=NlqwsgHc3VMPskc1Wanto0WarOUnYXNYz7//IivTe5CGIP4mmC2TSnWOgswNtDO70f
         KbKzT7Ry1DXR2LDvsQqsdYfh049PDvlA+vxxIhSBmNiFKG1JEp+IaIHoYl3EudEX9PfS
         AZQ4KDZuc+gTEENn5waj1QD7oBc19E1noskNsTWcFi1aIQ8rWeAbn/gqnVxxzInlXSz1
         lb0XnzsAKKMCZdmOL5PXXCJdilupD4/XOZUpfRuF+8LxJvMsTim3+xydxqxqaL09QDZG
         g8IGSo0jhktxodWxjac58td2ycXUYxgHApj8ckIKCaHqoBlubOGIsaNn5Wb3JoYl2ENW
         q9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759326550; x=1759931350;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXTHbm1yGkE2/zORBswhWrACx80/EC1QRjdLtiEom4Q=;
        b=j/EexBAqJX8BargHfLhehEIeL/+wnJtsKCox2IVu+SYZDn7Y0p6QT/bx9a8gNqjkyQ
         dmoDX4sukbfnGvx1Nda5puJVOwoU2/WPG38n90XmEbHgD7o+pGdgoLoN27zjV7+10acy
         CACnNri38dOwZhWigkf5r6q1LS4bht8/tuKrW9UFzCLF12Y1Hr2+EKTSkarVOa/jEetp
         NI8yBQoG/xwrFWfq0nFjykDYzKJbCF47g85vEvSgE88gQ33cCZZOAMsMXCRuKn0LPvMN
         hjPptFzlvBjvGE32OqmHNuGzT2LzrnRXrmYUlcDjCqjw67ApMxGW23ggll27mA5ZXEGM
         Zxvw==
X-Forwarded-Encrypted: i=1; AJvYcCU7yuDu5gcvYJV+Nju7JeoUKLFJ1mz4g0ZOC52VgRvUgeavHtKCp7djcoCBigO8hugiL643gf3/rEGmLDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvnnSWjg0czs032wCMD1c7s5YrPYkgWxII7oUzr8/QqLXk2RiN
	hcq76//zJjRo7NY0K60w29zReKLMp5P06mkQcx2zxPVM2fRotI/tFq0TscFH8gMTays=
X-Gm-Gg: ASbGncsFRb3iSeAjcOrpyl9jW9X7fLXd14m1RNShgJEjSevnYfqcgye45RrpNthD00Z
	0dG8fo3OODQGdAR9PkW9ZG3sDjAKZOus9pgR3VYXL7bcXBzWEbrT9h9Vc6QXcHCCq71zt5QH5eW
	jhGnsbpY+Bcdc/UAX6b3JlFgjhwC+NOwBOl3kjvLPR9odbKDaTx7Qy5ogENoxPdmks8PPo79NOP
	bXJNLt6yFbrSM2wl+44D0uJJMiSepPTtDr4eiZ6oU7o6vqxLck8DAHO06quXHGWuypsLvyfsM3i
	qHOjN5ufLekSopvXoWo5/EkGMW2ErK4ab2t2QjSOQqhPY98jvdrrdFd6+zxHXMOjR/z54PMYfGV
	lgo5kmA5Ri6Iwt1G4sQVSmgwGaHE8PNDE4VVz958PKSi88Js52tQx
X-Google-Smtp-Source: AGHT+IGLrHf4UIk1KWnOc/zaVSe2/+LGCHS141wLHD+2YH4GOoHIJk5yG2sHN2EHQfFgXGXp5sFacQ==
X-Received: by 2002:a05:6000:2001:b0:3ee:f10c:6baa with SMTP id ffacd0b85a97d-4255780b811mr2734622f8f.37.1759326550066;
        Wed, 01 Oct 2025 06:49:10 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-41f0c467ecasm14427731f8f.38.2025.10.01.06.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 06:49:09 -0700 (PDT)
Message-ID: <6baf0f01-a333-4bca-b39d-d01f8624e170@linaro.org>
Date: Wed, 1 Oct 2025 14:49:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] perf test: Extend branch stack sampling test for
 arm64 BRBE
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 "Rob Herring (Arm)" <robh@kernel.org>,
 Adam Young <admiyo@os.amperecomputing.com>, Will Deacon <will@kernel.org>,
 German Gomez <german.gomez@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
References: <20250813-james-brbe-test-v1-0-76a0144b73fb@linaro.org>
 <CAP-5=fXdFQCgeF5DRH=-cUErz2opU98H6u1cTTO3ZPJ7SMQfMw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fXdFQCgeF5DRH=-cUErz2opU98H6u1cTTO3ZPJ7SMQfMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/08/2025 10:38 pm, Ian Rogers wrote:
> On Wed, Aug 13, 2025 at 6:39 AM James Clark <james.clark@linaro.org> wrote:
>>
>> Refactor and add some extra tests for all platforms which were useful
>> when developing and testing the BRBE (Branch Buffer Extension) driver
>> [1]. Then lastly extend the test for new features which are BRBE
>> specific.
>>
>> Tested on the Arm FVP RevC model [2] and Intel Raptor Lake.
>>
>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=58074a0fce66
>> [2]: https://developer.arm.com/Tools%20and%20Software/Fixed%20Virtual%20Platforms
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 

Hi Arnaldo,

If you have a chance can you take this one please. It still applies 
cleanly to perf-tools-next.

Thanks
James

>> ---
>> James Clark (3):
>>        perf test: Refactor brstack test
>>        perf test: Add syscall and address tests to brstack test
>>        perf test: Extend branch stack sampling test for Arm64 BRBE
>>
>>   tools/perf/tests/builtin-test.c        |   1 +
>>   tools/perf/tests/shell/test_brstack.sh | 106 ++++++++++++++++++++++++++++++---
>>   tools/perf/tests/tests.h               |   1 +
>>   tools/perf/tests/workloads/Build       |   2 +
>>   tools/perf/tests/workloads/traploop.c  |  31 ++++++++++
>>   5 files changed, 132 insertions(+), 9 deletions(-)
>> ---
>> base-commit: 6235ce77749f45cac27f630337e2fdf04e8a6c73
>> change-id: 20250811-james-brbe-test-f5a20dffd734
>>
>> Best regards,
>> --
>> James Clark <james.clark@linaro.org>
>>


