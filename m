Return-Path: <linux-kernel+bounces-869036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D84C06C65
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9461B88A01
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7D423A9A8;
	Fri, 24 Oct 2025 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilObv4L9"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB76A238C23
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317329; cv=none; b=XMTwYTWMXTz5wPRREk8nzuqclKEbCwRZgtsNTwb7lFitL4m+crARGgVVCGQwDZu9zkRH0BjRGRbkZWNMBmHMe0q/UiPE6OFrYu1A+aQAJt2L5OlOjuZY7JwrzcPvX9USjsQwIwbnUDeb6KWwqGumAKMXOJ0c69GJrosXBX+yQ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317329; c=relaxed/simple;
	bh=uhF5fwIHxFW8yAs72wPqDFCFh7Wmk/B+MbdX+eOAYsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubZeggRkKF62dpyQcTtwMXU40oC8fmbu6euyJ6McpiLhBzES+4H+0z2lbJ2K0CJCm411I5dUshWEUmBs4HBqf57keNUItQxBnAMWuLm2jniZLZdz0AKhs/4V5bKM0j1G/vLyesTBR0QBf4NLr6VkBwBPvTaKTzByOUKEmBI+6zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilObv4L9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-471191ac79dso22772795e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761317326; x=1761922126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BMGadhQcL+1aLi8mh0uAQp+IfyQTEprbYOlmMCxs0BI=;
        b=ilObv4L9HDXGuWcnhGVztYtkCdtKDzLr0oRuSCXvJp1ysucHtQkYrh7UvTq1BlQQDF
         oKlmbY5KFXnM8ZREUIJHZiaiMAan0niIR5Wq2hyZV8GAvK1saf0O6Q7k6BXr1XtVk8p7
         iGJ1LGUJjbVW00BQ8RDXoWKy1wY9OoqQ5HEgUaumMCn50jTsZ2QD9vdkDkt/tQCpti9E
         /8kWygtXv9unCfmPcovsreB4c8fCgWP/HyCpFrtl4NBQ4jWItsvhNYLSxm743CL62UhH
         IgLiLrBm+m1g+Pj4RRvgQ468buRZYng/fYN5qjXBpgJYCt7OSztFNJI0TN0Ff3B2R6K/
         4idA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317326; x=1761922126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMGadhQcL+1aLi8mh0uAQp+IfyQTEprbYOlmMCxs0BI=;
        b=qjYal6578kSJ4wzhadkQ5OIcMAh4xgQdYh3sQxVzcr1wDmaeygkuqmt1YkyKoRxBmc
         nl2RS4iPwzdOpad2E4W9/xSwL1C+iBwbopld0ooXnT9keqnoUy+KlyFOY+kngXAW5d+b
         I/TTD+slInPaYNZRvn/Nv60oBw6EbfcTDpDMYjgGgSntgoc9ZUU0AxM5jm9lhwEckHGw
         QahzvHirNS2EJIOoQ7buqRXYaKSNWylm85cT3w2YaQ78sIqxkTxwWYHFK3c3/NsrAddO
         7IUXJ/dC6zTv9jvdc4HeNqPgqLL8FhAb6TmrIPsANRKmEryYZvQE4XavAhH/vC7VerQO
         VJiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQpT2SBhahmQpj3bblG9xs2Hc7Y3CZxYkRUtviGkdFzhJdwWkq3XjSXv4q/Wk/wxgEQnX9cMe7sqPh3yU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6drR7d4F54BX5DcUnz1jRUWkcZpipcTtIWppaFsxRNiMxiTV7
	BMjtgOoLwIw5UFf14ZFu4o/vLvpMX4wFfa/icqFshXmsT2lKV0dz+6Fc
X-Gm-Gg: ASbGncuiHMn0FQxdqMu1e11GxRuERFfPfXvsFoVgJC81UdMcmYWA9Rt4oJyB4n3YCHy
	oFf9aIvgVqNVegOb2E3PrF4OwjI4Pzym9Cw1WKsUlZG+mvIHZksIk6IfHkE2r+GXLDP+q9/5D94
	5nJifWZPVy3PGtBGUifQnhO/GZcYIEzFKJjqPpKQkWJvtWVg/VScODeEzNsNmpMIElQSM28cpFA
	E4lfvi5iWd0Y8xzVREz4mgjbG04CHb1ISMAnYg5UOU5+ONkRLrw+Spm8Xf30NQnojcNoUfv3Hk2
	g/grpYNcN6ZDScEo28g8ejkL+b75VP1sC9k7bJOHHXqG11Lz9Fel2x2Ug2oWV5FfCKYoWsU5NJ5
	bX4F6INMtg5Hz8jhBp3PPH1Z0M4FOO9WInN/G896reS5gY5/1VuGG8UTLJPFbhYpRKCu9v15kw1
	YIkAwS5XmoRlfdy6WpHAut0AISUCRatNK9z5kxewbna5qWd9fgQblVdlkElespW2o=
X-Google-Smtp-Source: AGHT+IE/AVTzwrD3CWn4mjR7pxPu/85JnSgPabtjowdHZXXaHv6875lfhiQksEk798Ron6BdKqvkYw==
X-Received: by 2002:a05:600c:528d:b0:46e:1f92:49aa with SMTP id 5b1f17b1804b1-475d2e840ffmr22165245e9.15.1761317325986;
        Fri, 24 Oct 2025 07:48:45 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf2f142sm97999755e9.15.2025.10.24.07.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 07:48:45 -0700 (PDT)
Message-ID: <699aa920-ac7a-43ef-8ad5-5157d0018b54@gmail.com>
Date: Fri, 24 Oct 2025 15:48:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] sfc: fix potential memory leak in
 efx_mae_process_mport()
To: Jacob Keller <jacob.e.keller@intel.com>,
 Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, habetsm.xilinx@gmail.com,
 alejandro.lucero-palau@amd.com, netdev@vger.kernel.org,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
References: <20251023141844.25847-1-nihaal@cse.iitm.ac.in>
 <a4ef697b-74f4-4a47-ac0b-30608b204a4c@intel.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <a4ef697b-74f4-4a47-ac0b-30608b204a4c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/10/2025 01:48, Jacob Keller wrote:
> On 10/23/2025 7:18 AM, Abdun Nihaal wrote:
>> In efx_mae_enumerate_mports(), memory allocated for mae_mport_desc is
>> passed as a argument to efx_mae_process_mport(), but when the error path
>> in efx_mae_process_mport() gets executed, the memory allocated for desc
>> gets leaked.
>>
>> Fix that by freeing the memory allocation before returning error.
> 
> Why not make the caller responsible for freeing desc on failure?

Since the callee takes ownership of desc on success (it stashes it in a
 table), arguably it's cleaner to have it do so in all cases; it's an
 aesthetic judgment call but I think I'd rather keep it this way and just
 fix this one failure path than change all the existing failure paths and
 the caller.
Alejandro (original author of this code) might have a different opinion
 in which case I'll defer to him but otherwise I'd say v2 is fine to apply
 as-is.

