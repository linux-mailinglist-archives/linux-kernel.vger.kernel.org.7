Return-Path: <linux-kernel+bounces-844255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAE9BC162F
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3042F34ED84
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41752DF131;
	Tue,  7 Oct 2025 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C5nDRzhd"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A26F2D9494
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840846; cv=none; b=cdUr7bgC7+48adD8tvi/0Fxr478BgN/N4iw+Wo/P9foC4bHyNy8t8SDNp5Iu9INQ45TjStSehLePqp24W2fGrUfIH6faghNdSJrcVsW6FSiG02cTrBgKszvI8L7sfQimTIneOCT9NJr6uGpzUl9iNmUtC2eaojL3HziFHmINkIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840846; c=relaxed/simple;
	bh=ZI62aSMICRCSh6leiVS9+me5WC3NyTpFwWRnOdmHTNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcSS1aVN/DK9JG+30veu7aQH9lEHTGL9A5RqcwQS+2qMSz2fUKWPxUU+5KWImV6O/fqxdQOLgfKt5F5rCw1inY+9dspOISivUlhuhZ1xEOvHOx6OBrIAYmil+/iUQ/NKeWWmCJReZ2GZN/X8QGNhbyF28TE65FblSlaaxPfuEKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C5nDRzhd; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7a16441so1010196766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759840842; x=1760445642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LTrQ7nd2uqnYTWAuME7Z1la3KV1LzKeN4unCYN5xPjo=;
        b=C5nDRzhd3MYMOB05kXldKxoe6FrbnHssHrmBnygiI/wyAVFE3IRWL4x9WkHcebXjpZ
         eYdrv16af4GrXsYlCQahiwog2vrtPc9fUVOuj3N3g4HtSVb8Y/5hQV6c0B77HJZWFMuU
         /97IId43KAt1rH9IqslXv0ORc3h5ScWmwkPjoe0pWNtD/8pMmgqH/VwpLwY3sIlDuVsZ
         SfhmG/Xtvf4bHb2lfuCXvCplrZO55JtzfjQBxzGeUEu+nkLcNyi3REKtd8lJ63uDMmRh
         KSuq1Kwh9nTj6hyc88OHWrV9Sxid9n0ZGSV/2Ict5OSzOJs0IkBqeczNEKkGiFTUML88
         VQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759840842; x=1760445642;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTrQ7nd2uqnYTWAuME7Z1la3KV1LzKeN4unCYN5xPjo=;
        b=u6q84qK1p0bG6Fy47W5wHTpCzbBFY6fT8hfp10IoqUskHDHzTC+0EjF8II11t5933R
         6su+a0QGpYC+Fx8XoUhuwb1VhZXUpPfp9H1faNskikTFSod6pM5Z7vpH5ru+K07jseNW
         T9vTVNqL0fbFwJVKMzWXR3rGCSZ+cvqL/KgnonfWtyGn1AHVrL9Q+patfvJqF9tNfGRw
         l0d+GezJH4EbbzY8Wg7NE94zbF5SKEusk0qXLqEJYnBS5B4wDTETcVNZXFAq2FjIN0gf
         oG2bNA9RLNH7DbkQghj08xqRCYfmvcScGanv8HKZJEN4LcXGK5HlOD/YFD0iMQnOoOb8
         qvCw==
X-Forwarded-Encrypted: i=1; AJvYcCWMYXc4zgj+pTTXdRFelO7VqPIs8EdarErTHO8N/u9EbwaiyGX4Qv6SCruWwxAAMFzyWDW2a7rCNStshPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4JPNxP8hJBQ6hsKoz/SDMaLK+MwcIHVh6yDVhDPwgNfLjQGhd
	8duDG3HZUH+gnX2Za4GhRgYou1x/tYM4klL8sxSs76NekhoKh7JhJBAo2Xfc9/n6aBY=
X-Gm-Gg: ASbGncurtfj0E9oqaBhb4/lGfHb6A7V6oWf/Eg1dliiG2at10RXKu4Zdo7kJVw4qugB
	7NGpXObErRX/HstHUkvs1q5MwX7mr3bZP44e4LrMRKX87qYgrAJHHdfcpod5qBvfXNNQM6DPKF7
	lO9ePKs5aOMG+2XgMtaaPXp1Tv4P6v6AgA6hC1m/l/XDQL0+7PfvKbe5LnfRYaPm2tLxhQfPED0
	DAvaWZtKikhHYxeUCTASdMQxgmHvSGqAfCUJYWV/PbgICNZMWZ6jZ0a1TtcmoOcivz3AChyb+61
	Mqp6FZ6DoLZbAFxLux4+jWx7Ea/Smaq41gLLXF+Rf2r68CrKhQolGqvgzguEM510sPQNAoro6s1
	Kjd5ERmzgjCWd06r8mVHzYBX7QeOYv6gsvIcwdRvkcUV0EeT9+sh8ChVrFNV+Z8WGJP3TMw==
X-Google-Smtp-Source: AGHT+IFKiqjADNUa/d45jLbBQZuzBChgqGDLbIgB6YDNfgCy+x0vApmqahwWJauuwxlToVqj6Xa20A==
X-Received: by 2002:a17:907:c0f:b0:b3b:9931:3aaf with SMTP id a640c23a62f3a-b49c275549bmr2150089066b.28.1759840842346;
        Tue, 07 Oct 2025 05:40:42 -0700 (PDT)
Received: from [10.20.0.214] (ivokam.ddns.nbis.net. [109.121.139.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4fd7112dd8sm122559166b.30.2025.10.07.05.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 05:40:42 -0700 (PDT)
Message-ID: <e6af2a23-e54e-440d-91fd-6669f5bfdc58@suse.com>
Date: Tue, 7 Oct 2025 15:40:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/tsx: Make tsx_ctrl_state static
To: Petr Tesarik <ptesarik@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>
References: <cover.1758906115.git.ptesarik@suse.com>
 <8b7d5f2baf55334a06da558afc7e12f3a78ae7ef.1758906115.git.ptesarik@suse.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <8b7d5f2baf55334a06da558afc7e12f3a78ae7ef.1758906115.git.ptesarik@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26.09.25 г. 21:01 ч., Petr Tesarik wrote:
> Move all definitions related to tsx_ctrl_state to tsx.c. They are
> never referenced outside this file.
> 
> No functional change.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

