Return-Path: <linux-kernel+bounces-819144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 424FDB59C10
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B651C022B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B0A346A1D;
	Tue, 16 Sep 2025 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gYqivpUp"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C2433A02D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036471; cv=none; b=AG/d/ZvMZ+8Lh31ULW8KM8gV2q28LXmKEExZHhj6Ez7FdbRy76YipUkJvomMDDB8rX5AGZWInYBbYecjtZKM4S5UGvTSbJwOFxy4Bka/npwFvl2R54XPVIekRxw1efLEcUSjENa6GJExkvbpSA7gNXTr8uS8TvlzIe+sa8PSrP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036471; c=relaxed/simple;
	bh=xsVGrDBuIpyS5tIu+vza30bL4Ph8oIfodBVdwJnIvlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkAuekVj36OjizOKxC8f51W5LFjfKucFAXazxcuMGLohdDzYCJfLU9/SW/wAgDHP8M5xDKQahTQcRkR+pgJYpPn7Qof+g/oPS1L1J1+e3NQVBtTUabUHukX4PFKJOqTzEgWNryQJxCz1GiugaibDYZrwwK7KDYRVwMFUfVLbeIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gYqivpUp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ec4d6ba0cdso1004986f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758036468; x=1758641268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zBk3cgVrEpdZ+x59L+pHlmsugwnIS3miRhoSDYBnqO0=;
        b=gYqivpUpYDejz9tee0YfCxZXKPOpYnf5qdnTts7a/FDqyo0mfuksoSiogh8Ow1AoMZ
         CLMEpshVdIFCOH+Z48Br04CsPs6vYUGpoCo3iR6AA2qGz4bR4Rlm/yoe05LTPDYTAf3e
         /tDTK3QO4tAjY1hlLiKl9ksb6t6YH77pJgdZ8SKFUynnZTQqoAVoK4UfsfD/WiAkVkf0
         7VRJjKDHVodvCxqEBaaciiKPWhuNHJGUHBUCfz0ZBgXBFlGuze+3hAEVyT6Stm1vEhqJ
         eR1u8bsr90GjSrhEww3LJuLfJ516Yox3IfWQ/EylgQyrIL8Nbom/Phr+i1CcVyblep7e
         oqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758036468; x=1758641268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBk3cgVrEpdZ+x59L+pHlmsugwnIS3miRhoSDYBnqO0=;
        b=RqwUT9DnxscHZPKsCpPTjQlq7pYTU6O/5ep6+uVOBxLlbokX7rriU6z7zyBXG7RsnL
         ZBW80zSm7x7lHsEf1tv691P/Xa4xqP/8i9yJkqRrK7rrbqzydhtIts7BQc/Fo2D6QC5G
         PyBOd3zcFdESUL7SiTwplamfAnj8EJNFvAm5bFThzilQPQV3rB2KicNwpsuFNjlW6PGx
         GCF5hgLlubzL+6q3mZz85Drc7nhQl9BDBLWQFvNArFD6m9ERxj2+gcIdDQjA9FyygUxw
         Q+H0S3Q5KQsdat4AtM3rYeznp4Mm04uAYihi5puc76BwAyLKwupVp6nL8RQZxz/nc0Gs
         fTgg==
X-Forwarded-Encrypted: i=1; AJvYcCVQBKtro+cVz1/yyMn9lrqHJQvpVoqKGhhui6GLRMLYkjc9QugnPfr9Gbb0F0TzKJfbitIVMeuIfEy8TC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl4rBUl3ISX7qa4Cl4Vq5m31LQI4++fxSgPXNM8mQTBXRD7sSR
	DjodT0un9ZMlqB51BPBZQOa087WtB66y7UYhp7gIQdkvdwoJRKWUpM85G3DwOhh9Uio=
X-Gm-Gg: ASbGncthrXd0MxPMH9ySVtgMMH+jCiF1AkvZ42cVoq7Bc6WRUUQIYOYtnI0zesxyWnZ
	lLhyUo7KRgwjNbDZhvLYNn+wk8ZYBNrbvirawswB76SlfjCKWGVVji0C3D/b0vnqlulwaNrRu7t
	voxD/uwGyBspFZOUW1ARTxx4uMEumbUyWT0q0luJc9vC1MdgAZRXqxXxdzBZXKcMVQV+/qQI40z
	TKKDDj9sPcJhYktMxvPslPphSmMcZlXshzfxjxRb9JamRu9+dRJMJ5pKJcgYCudNzEYZ7oYgc04
	kjDTsEs2V/2ULwR833ilQ5wUMsiYt0sWfZLcP5XLmdBHhAUg2bj6hTm3NEEHgdqkGG+ooNiA8ik
	h4jWYOXqT8U/Nd2rQBQu6Yzq3yZB0sw==
X-Google-Smtp-Source: AGHT+IHDwjfQuIQJuBkMmBQqFsxSOzTJndqBY6wuQhoBVd+d/7RL64/dV9lAVoQBQ7xySIf7p9k7wA==
X-Received: by 2002:a5d:5d05:0:b0:3e2:c41c:bfe3 with SMTP id ffacd0b85a97d-3e7659d3a79mr16152029f8f.38.1758036467575;
        Tue, 16 Sep 2025 08:27:47 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f27f44624sm148981005e9.3.2025.09.16.08.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 08:27:47 -0700 (PDT)
Message-ID: <f9e90d18-ead0-404a-937e-f5e2cf11c0f7@linaro.org>
Date: Tue, 16 Sep 2025 18:27:45 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v3 00/16] Introduce kmemdump
To: "Luck, Tony" <tony.luck@intel.com>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: "kees@kernel.org" <kees@kernel.org>,
 "gpiccoli@igalia.com" <gpiccoli@igalia.com>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "andersson@kernel.org" <andersson@kernel.org>,
 "pmladek@suse.com" <pmladek@suse.com>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "corbet@lwn.net" <corbet@lwn.net>, "david@redhat.com" <david@redhat.com>,
 "mhocko@suse.com" <mhocko@suse.com>,
 "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "jonechou@google.com" <jonechou@google.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
 <20250916074929.xiait75tbnbyjt4c@hu-mojha-hyd.qualcomm.com>
 <SJ1PR11MB6083477193D9EF7CD10DE9EAFC14A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <SJ1PR11MB6083477193D9EF7CD10DE9EAFC14A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/16/25 18:25, Luck, Tony wrote:
>> +Adding some pstore experts to bring this to their attention if this can
>> be followed and if they find it useful.
> 
> Depends on the capabilities of the pstore backend. Some of them
> (ERST, EFI variables) have tiny capacity (just a few kilobytes) so
> well suited for saving the tail of the console log, but if the user specified
> more than a couple of pages to be dumped using this mechanism, that
> would exceed the persistent store capacity.
> 
> -Tony

The backend can fully decide what to select from all the regions.
Some regions of interest are named (listed inside an enum with an ID),
and some have an incremental ID that is being assigned.
Either way, the backend can choose to ignore what is unwanted.
E.g. patch 16/16 where the kinfo driver selects just a few of the
regions which are of interest for Pixel debugging, the rest being ignored.

