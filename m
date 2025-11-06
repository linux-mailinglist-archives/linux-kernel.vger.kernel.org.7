Return-Path: <linux-kernel+bounces-889296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CFBC3D34E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF763BB619
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE5C347FD1;
	Thu,  6 Nov 2025 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N4uIxau8"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC5433EB06
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762456411; cv=none; b=kqqxQzFszcDIs53oQgs4FIenD3IGL+fW6Ne/+FtmgE5CRlLzjmOtn0Zgq2J2zAqgZKKMmi4waQKU1PBjG/92/3M//6HSHCts1i4/T2OV5btk/q9A//8ULrqLn+6McuLyDWXuAgRVkXOv02QntMZdWRK20FFyrcdZ1aOlLIFPOU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762456411; c=relaxed/simple;
	bh=x4jOvehz/l5AwiSkh8ZHNK5e+NDXmXMi2EeVQIPNblE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmIF/WdaT85v4P6F7kPvZ3YNgOTPmRbjuJRvSWAjH2K7p2QzkikUgr1tu6PL3MRhzC2fFeBSlZgG2NUn34vF+l1j3p9O38J8YmR6gBB2q1SlcnAgWyB5mM5JY4eUPm2Xm9MdUIayyDG8KkMjjmYYZrJfbNfUPf71ipOrBm4nGHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N4uIxau8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7200568b13so240384266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762456407; x=1763061207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BSwDbZjhNyoFvwcPDAsMYknEo4DE1C1kmOdtpNJhXPc=;
        b=N4uIxau8JKccPqKdV2mH/kCvQgUEMDWXoE8t7hvsnKNa6APg5PcQYsjcS7Wp1mo2LL
         kiCR3VlgacqoK69ZANfFcuT2XgSbTeejuwgx8Xae6P6D8nKdndnoucWLKlm6y538iRu8
         FP8Y5mq0VtTS3mnbfS5lqU7r+BgQ7a5rlrIjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762456407; x=1763061207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSwDbZjhNyoFvwcPDAsMYknEo4DE1C1kmOdtpNJhXPc=;
        b=OqRXrLsAcdxbsgYA8uO3koMr6z0OHj7bZP0eYiWMAg9UYczDsUJRSbjjp621tFmQ7R
         VBbcFEFM1hXKO6tbTppM3i99gj/SY1RXyiWDgP4k2JQ6krGDSE+IlWdMXbMtE9QsNGJe
         YSIuX/1tcxP8NAn1zdn9yiGc/Ig+r+5r9Zmo/tqTG0cXPz8Z/pNDknZzoyBolQVmFHgk
         Ww0ga6E2VtCLhpTodmD4do0HJYmhXqGZ7nAXr5/swrb0nU2VJIYnhukKvYY2qEXWkaWR
         jdWtgk18tSwOvvKmYpu0OXr/VrzUoVbkjmq16UD8LXBdscwguBtiUCYWSBuKwgVFqXYy
         rQfg==
X-Forwarded-Encrypted: i=1; AJvYcCXDjhgP7QH9g/t8RcPK9LkcDHHOuqmJxtn9h9zmDflLfmZf5TjKuN54083tucH7nf4yb4IlR+mhF51yyn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwSNt6NnOt96TmQyxe+bjAWt4i222Oyc3aK7bAJhI1y77s35iG
	VauBLd26kPXMP0wM+wl07RIF6kFneQRc2IPT0noJhduKoldRESyyK/+9VVT2SLdd2hDNjE8D1LF
	6iVlk8Pk=
X-Gm-Gg: ASbGncuk6jRQrcCMZ/l7ID3JXmxcXTS7A5D0hhiWRSy+8gzldflO2Q10z6KRK6bDMsM
	WAA5XXZesZHmToo8dt8PjOHz2LxPm6Qt7Hp7jC+NN/rc8pRL0veFP+fMI4IWp2FxQQhh2H14uPS
	oP7QR8hpbPj7ZsfCMIzL5DLL5XRWV54bORh7HsdcmTOSc1PzEyX+DA9ELhZwWl3lF+QQwVAs8oh
	U/Wp21AFkQmxUuaUdjQZFCTo5Icb7CSHiTDbPthoTxmSSM5ZRYFAy12+gCNSDecz30IYgTAcD8i
	kZ3op02eMYrVgVZubVvihEbt7bNTBhgF1Yq/N/qt5/LXHYAz+iWppzKgGZt53NViMBdAuswHeFD
	i9o3YzAG3rEmlDeR0X38yoM2xGcBOkMx4opXJF2asMv63SbWOTx/Z4e7ussazkT8PLAXOh4B9Fe
	djfZZ92PUr1oPKB9isWCOb6AO6k5L9q6N/VL2LJ4FDSpn7gtF+HA==
X-Google-Smtp-Source: AGHT+IF9B/PKgPmHk+Goj3HORFDEKVHIHsW8Z7s4V743Xvsa0azFTYjyU4Jjmk/mN4x5fuc8xhldfw==
X-Received: by 2002:a17:907:72ce:b0:b55:c30d:c9fc with SMTP id a640c23a62f3a-b72c073279fmr36154866b.11.1762456407458;
        Thu, 06 Nov 2025 11:13:27 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbcea81sm29794266b.13.2025.11.06.11.13.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 11:13:26 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7200568b13so240380066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:13:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMT1ZsD5Sg7lHjnLI0C+nbSFV6EgJ1hS23awhEUokBx7FYaNk8Qz5eoZEQnKuYIFg/90ZiXQD8q4z2k0w=@vger.kernel.org
X-Received: by 2002:a17:907:1c09:b0:b72:5983:db09 with SMTP id
 a640c23a62f3a-b72c090e472mr49124766b.32.1762456406121; Thu, 06 Nov 2025
 11:13:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106105000.2103276-1-andriy.shevchenko@linux.intel.com> <20251106151649.GA1693433@ax162>
In-Reply-To: <20251106151649.GA1693433@ax162>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Nov 2025 11:13:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=whr8NCjam2007HoR+FT5W_exO9k_-jyHvhpossGwAW-=Q@mail.gmail.com>
X-Gm-Features: AWmQ_bkTzWtaU1K-M2qK_nvVYHzghb1UwFKSpdgbkMeiD-l3K-Zk6yGbI_EZmaE
Message-ID: <CAHk-=whr8NCjam2007HoR+FT5W_exO9k_-jyHvhpossGwAW-=Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] compiler_types: Warn about unused static inline
 functions on second
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Nov 2025 at 07:16, Nathan Chancellor <nathan@kernel.org> wrote:
>
> I can take this as a fix via kbuild or Linus can apply it directly

Yes, please just take it through the regular Kbuild tree (with
whatever modifications this thread then results in).

Thanks,
       Linus

