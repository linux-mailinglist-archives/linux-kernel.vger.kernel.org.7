Return-Path: <linux-kernel+bounces-725867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D4DB004CA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891D0188AF3B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC55F270EC8;
	Thu, 10 Jul 2025 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1ddgn8lu"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C176A270552
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156616; cv=none; b=UqoxRYbsegor+dNJ3bVZa0BZbvNuT/3xv8FWK4jFgcT9J/e9goAPw8oQsZAKRPdrYQnT5yNKtzGLTZTVlLE+tqvVEz4WqNXYGDXPVS9zdJhqivy2knVaf1xteT2WXn+ubId0LKyJO526GKeHW18s8ABhB7yw3syRq+bn8TLAblk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156616; c=relaxed/simple;
	bh=juAkrnXSzoy+efW/p26vYeCuBN4Z/qAUA6KBfvyQ8yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3hULuAjPr2z2mTT8KbA1XhAHFsm9HkLX2DS5YabheAFOycXLB9A8f/QdTEjeDwc9/O+egNdYPZU5O5I+QtfwhmaplawHWqT7WuxRp7JB1dQK2bpbwAe1laEMsJ1REzPKB9xuUyLJ8ORe3Hg+z5+kXRdpId3OVhXZgSwwswVAGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1ddgn8lu; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so1073685a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752156614; x=1752761414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=21fWOwK2yuSSXtTJ/i70WbuqBdOJcLRjYfY+8UJRw7c=;
        b=1ddgn8lurECb+/FBfXJwrImIbyK1myGwir/ex24X/MH2IDJYS0MaVcWQfOssXMl8VZ
         pQNJW56sJSBZqsMMpiYNrr5Tem1/ABfVMfX83iu6SuTkVDb2UFAWEdzlWQzPqDsV6LRD
         gU/LDTTo715fAexygLLLLfFchrv0UYDBlzE8m5N7H1Pc8h7MzW98H8BLWqzPS2Uussv1
         Mp14N8p3w8tDx4S6sLqabP2ZKcgByQ+LUWji0EG7c9v3yEOpfzdwPDaR4hanQqDUzD6Q
         uychDbpXj1S0Efzm2injPbxDyFl3poKrk6Hu2DNVZMTOSpKrinV97AWvO8mdLzPxNQLz
         nemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752156614; x=1752761414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21fWOwK2yuSSXtTJ/i70WbuqBdOJcLRjYfY+8UJRw7c=;
        b=rFVF9RwrCB0QMVbNRscrkCLAp7XpzpN60LAfPBE+UO1iqxbUwEdh8IgoZrAZ75Q9vw
         MNQhzU2KaN0WJFXx0uGecqYmuurxjlWgvfi3nolFvYRn4zJe3IMrISOMithJDEll6tOG
         z0KztTty3PEl7BonBfWsX8+UgdbpCBN18Z7QAWm3icvntTucU8YNEbmxH0w2M5yMQpfQ
         8iDpTLDHDjuhASeCawzXCCBx8TrYtADPUXklJKQP35E1d0gGnQh+WOsSqCRVqbuvySRx
         rMAQeaU8UbCIRHtRx0lKkq8zBbVe79+3d1WBTDjbBzAjShx9BUSvWwolK4yPubUhe9mQ
         L6Fw==
X-Gm-Message-State: AOJu0Yzt4v93DjdRIntjIcCmVr67svr7E0K6I0PYWrcGRrlmatyXAa57
	o5SKIIuucjCmvr2py+dY667drRMr4IAfnhUcOBozwBT+93KDKyDx934mhUDQ8siDyZg=
X-Gm-Gg: ASbGnctyKdmcKgotVoKxwXCbRjOqWaF2yDNVO//O51dSqp5zBDyZmOgw09YVwPdf+Ai
	+BWtcAXjkEzdqv9SVsZEiLv8L7qp2cbkd4vcAfRjBXMOTp7Wz1Rwbl43Ccu7bidaIS9QwOo6zsB
	TMbUMAngOWSNRxx8RbQCmQdzXJlGi3hFFsLV2Ytg9FfhT1KIsw/cSvfQ/QWJ2iWm4Uf7BPtGyOA
	Q68hI+xuw+IOxgSqITfP/GjRzrVtcT7AOR490JH53ABcTDMrrDvwr2jToD6K7gUXa1NOg4SpNqC
	6/EsBqCsqPyuRXPhJP4MCF4nT4D2XSIgCVugBP/h48pvCOuJ64MN/2AyoE92HjV7uiv4zly4QVu
	CucGAy8kaItPZmktrdI3y2fdABllamjU=
X-Google-Smtp-Source: AGHT+IEMWPpfmJ6IKhaXf/A35j7A+4FLkS38lFffV7k0+kEpETGtEytg1GAw3/ZI2K24PUzBRx4VBA==
X-Received: by 2002:a17:90b:2808:b0:312:959:dc3c with SMTP id 98e67ed59e1d1-31c2fce136cmr9449563a91.10.1752156613976;
        Thu, 10 Jul 2025 07:10:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3e958166sm2318999a91.5.2025.07.10.07.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 07:10:13 -0700 (PDT)
Message-ID: <5db9ec69-d0e4-4113-a989-ac75d0f1e5dd@rivosinc.com>
Date: Thu, 10 Jul 2025 16:10:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] selftests: riscv: add misaligned access testing
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 Alexandre Ghiti <alex@ghiti.fr>
References: <20250710133506.994476-1-cleger@rivosinc.com>
 <mvmecuognj7.fsf@suse.de>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <mvmecuognj7.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/07/2025 15:53, Andreas Schwab wrote:
> On Jul 10 2025, Clément Léger wrote:
> 
>> This selftest tests all the currently emulated instructions (except for
>> the RV32 compressed ones which are left as a future exercise for a RV32
>> user). For the FPU instructions, all the FPU registers are tested.
> 
> If that didn't catch the missing sign extension that I just fixed in
> <https://lore.kernel.org/linux-riscv/mvmikk0goil.fsf@suse.de>, you
> should consider extending the tests.
> 

Hi Andreas, you link doesn't work and I didn't find anything about sign
extension except a patch you wrote for arch_cmpxg().

Thanks,

Clément


