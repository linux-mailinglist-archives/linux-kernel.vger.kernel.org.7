Return-Path: <linux-kernel+bounces-844265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CB2BC168E
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 678294F5CE3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B1E2DF3EA;
	Tue,  7 Oct 2025 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fWotCO4n"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E742DF15C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841407; cv=none; b=phISfeYCzcwH3UoDCayJNzgzzQKpKfAPKLpGY5nDn3PGAtglQwdq6OFBu+kCdE+9eUbjCtj0YX9sKwRCed+EBDLB4RTzoDuGC6MKS4VPRaj0SVaOr7P9gES4CcCHbgDb2xaI1LACkmp4eS/B0fOH2qJs5lQa361QDyOyWyUhl8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841407; c=relaxed/simple;
	bh=gDFkczEy5aLumk4mklhks8XLo/0MjhJ8I7UhjJ9LD/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kk0uxeVVlzutuvoi/koGAQJ7K1QHb38u02HI6qGeYjo44S7sYUmip/qIxrmVrnxqVaXhWrLPi7b4jLnBG+G7gHaXJi+zFjR2A6tT33182LkAwAuZALRiKqziD7RQWmEWHDaP9ltaIAl/bxkCzTsD4jPJmb+j5uff+z8u2I89Y0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fWotCO4n; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee130237a8so4328988f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759841404; x=1760446204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6l4qDzHlUYQBmQQYtKJ85nOEgJMlrYTsriVtxYcb/0I=;
        b=fWotCO4nZY9cX6jyh6+DRWY7acS/w0K3WRfDntYLEUwNbleT7A0BnvumnMuakW5wAm
         iN98EMuWc05UyemiMBOe4YvTmAVjW0XDWpEfuOMNN1GrSboEckqXkPR2N+TeUnOF35vk
         vazddY4LSq/Ypxk/KZJ8UN2B+Hi8ervgkeczBM5dQtYsTOVDZO8Rek48DbcGKN33L8HH
         HjzY8QNxw/IKd2Tq/Wpwm3fjPmd7asFgqHQRdHePBxqfuu2L5AAJAHzp7EnCSY4fd/XC
         ZWwDa64F/QzHjlPY57lcVJv2T9mzI66GGrw6owArdbgiX46v40pOSa0Gv5MVc10trqOb
         WSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759841404; x=1760446204;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6l4qDzHlUYQBmQQYtKJ85nOEgJMlrYTsriVtxYcb/0I=;
        b=PAy+fz0vCnizLXFXZRV4V1euZ0XVq55ep1pPpZolsjvOzIBiffh4+rTi2DR78urcyP
         UT3yEiNujAsy/j6/ciuE84SPEP09K0r7Nxibw6elnMzNBxJ3rf8wRqusvn5zxnEBgGnS
         c/nXkXo4s7A/MF0AvF2PfrSknH3S4wC4uBmVqgK8yeqeFGf0gjZeRTz1K4Z9p7/8mAI1
         KpN3tQqKbwpPjU1CSb8j/2ln//cFmRV37yVXqpw+9uMaP0ny11S/mq36S3ssqt09eegG
         lLtwRQCBlgy0HVsTRYEMsHjBX2eB19X9zp01YDyB3QwRC7sWgzFDdf5SYT4e5wciGorQ
         tg2A==
X-Forwarded-Encrypted: i=1; AJvYcCUKe83dS1C1wPVBlw9bNkwM2pGnLsY3ejZTSGvvHaQMqxC491s05O6Iq4/pVAWZiVmiKztgXfTpFMvT9GU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+KCZTaUf0M7gcqrFHC46MBSmlGO26th89yKdy30OXGrU0fOtU
	QH/sRjYdCeogsh9Bto4sGVfN+OcLI8d5yvz25NFDSM6mt5EOClYmR5pG6Il3LEsUbjs=
X-Gm-Gg: ASbGncs1zL5XbDMQ+2yLVHFyUzJMfetqh5BFyj+T2WBKfEcchOYXrvOV/EMvvxd4xWO
	40+Sa9hk1iMGqWdx1GQSego1B21AJNkPFwDBYqsVAxPeImc+bQr95c3Z9CuR9rBcLUXwagoqvVE
	LpJ9yVHEGfrIplkXT41gAfKYlG9qxxhprD4VNVP131gNar0Jg2K8f6E4M/VcR836G+sX8cxBFxj
	7Mh3gqghhGa3IgFr9Dmch2ixjFtOBtiiAGSTNZ1rvNmFYAyK0tnOEjYOLJagkMbIIVhhwIETkwE
	W8Q9vxc9u1PPdWUjRE6ivow36DzioGPR3X5v3SEpsmKrf9xsNNWXjpla24ca9qEBMtmLrWrSPyY
	S10h6NySfrYB5WC27ezLy4DIGpgB6dLwmBiOjuulb9U5/rOc9dS/qT1gy8ntwoBrD3iuvrg==
X-Google-Smtp-Source: AGHT+IHycONYE0I9/Fts71hnV2fdXn2nPmEVGvc0scyDQGRv5ii/jl7XmGE+QxbL2vJAlrW0eanXtA==
X-Received: by 2002:a05:6000:25c6:b0:3e8:68:3a91 with SMTP id ffacd0b85a97d-425671c36e9mr11207300f8f.60.1759841403766;
        Tue, 07 Oct 2025 05:50:03 -0700 (PDT)
Received: from [10.20.0.214] (ivokam.ddns.nbis.net. [109.121.139.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a8542sm25275178f8f.9.2025.10.07.05.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 05:50:03 -0700 (PDT)
Message-ID: <9628cba6-f793-4301-8620-8de46e0c5c97@suse.com>
Date: Tue, 7 Oct 2025 15:50:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] x86/tsx: Get the tsx= command line parameter with
 early_param()
To: Petr Tesarik <ptesarik@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>
References: <cover.1758906115.git.ptesarik@suse.com>
 <63118e583443490a285fd194baeae874d65eff87.1758906115.git.ptesarik@suse.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <63118e583443490a285fd194baeae874d65eff87.1758906115.git.ptesarik@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26.09.25 г. 21:01 ч., Petr Tesarik wrote:
> Use early_param() to get the value of the tsx= command line parameter.
> Although cmdline_find_option() works fine, the option is later reported
> as unknown and passed to user space. The latter is not a real issue, but
> the former is confusing and makes people wonder if the tsx= parameter had
> any effect and double-check for typos unnecessarily.
> 
> The behavior changes slightly if "tsx" is given without any argument (which
> is invalid syntax). Prior to this patch, the kernel logged an error message
> and disabled TSX. With this patch, the parameter is ignored. The new
> behavior is consistent with other parameters, e.g. "tsx_async_abort".
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>

LGTM, also could you include some rationale why early_param vs __setup 
for example, or arch_param_cb (which by the way has yet to find its 
first user).


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

