Return-Path: <linux-kernel+bounces-838252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9123BAECD6
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 01:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5651925351
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3A42D249A;
	Tue, 30 Sep 2025 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="NwodKnn3"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10702242D63
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276127; cv=none; b=Tr7xgvXziKrgppf8CEVZxnAyySc43mYV89W9MlGEGGV0rVb8PXZVtiCG5zmBlvbztSvGEVYV5+XurrlEYxg78RiD7VbRtfEdziBwIrydwX/TsCXoKCqePRzfTkGE4YJqru6sf6XPMS8eUbvFRqBm3Wb7WlriqTLYVECtTEt2ALg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276127; c=relaxed/simple;
	bh=4bm7dBKTe7VHUpax5O4A5sblWjBcLkrJbyIa/W7uP1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geDGUtLPuaCOo9Sy5UmUj9NX5B6U/ReZIU5VV2vs3RMWKDOsKs32nQ0R4EPsEmRwa4YJuWD2Y7LwPOIf1B13qby8RDoiV5aF+H8w3EY6Injj1i2YVPU5O3lepHjR1tCG99m5/o95uwVlHU8KbXoWojzJiblRvuo9cMkjo1PAAws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=NwodKnn3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-26c209802c0so68977575ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1759276125; x=1759880925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bm7dBKTe7VHUpax5O4A5sblWjBcLkrJbyIa/W7uP1A=;
        b=NwodKnn39OQecdVF6d8bOQQDGJ3Gwu3/er8rraGYUv3SuTXqM7jJoNUUTX1ncfQeNO
         aVL4BoTscyDkvFc/witRmX7H6DznBmneHqFSGq3Gw/pALqTtgcSRSchoeu47dGxoazx1
         vqzpdHAOZHplVP0PIE4cJJloFy+YxjIo6e6/dS1lqIhFdxN4cJggB67Lvl3YcPYVKqIO
         t9iibATEJDpJ6slDDzqH5n/R/L9p/WJP9toJHOK5HynjH+6rGAsd3nQ7A2Dn0wRPOdoJ
         ivtTlLJXlIqfICiwwgqY4RDnnVBPjUZkF97UFWMXLGl4JJCZRaYbJ1HTv2rAzyPZyCdN
         B3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759276125; x=1759880925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bm7dBKTe7VHUpax5O4A5sblWjBcLkrJbyIa/W7uP1A=;
        b=lHPZHOrgoeZZ5u3Bz1jFj+V58ioyreUKqiCfwb8+2ZqmbqIrKOtq/sBZwEqLjH2Pca
         xELMcN+3lMScbGGcnc4hH4jhTWYf6NVN/phODS5gdSvd3KAzQgOND5QIPjtIspmfiOMj
         ueOjzmhZ/Xs5Ifpd+srV0MdxqHinEeSktG+DoS288s07QJstMnCpT/RiOny96p9JOa6C
         lYUlD+p7wKOnhkldTDCMFj3DuNQ4tUL26In3EDDNw2aKpEixjbO46XY89Np4Y45ktMNR
         NE3sekO0+mH8Uz4sX+FCEBA9sx+ywccXOwpoy+9n4tcPOCarItDo551XMyq+mSPOmxw2
         HE5A==
X-Forwarded-Encrypted: i=1; AJvYcCXej7ju9+YQVrkLlilI5GNsQwkSHThao0ZffNhaW+tn3r9GjLgEJkRqO5tMzDbHk04CUMETAZ8nuuhSkEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA37H72YgUDHdb+urIPZB5x/VLiOIGK5zk5Sasjla32zGyFS/B
	9YVfaWw9LJhnJprKM8n8dhfYZ4TBAD6aTnrzCmjDqFIQE9JPoRGojhc9BeQT9bzkhmo=
X-Gm-Gg: ASbGnctB2ruPTdH1WwkNHOvgXYP9dFmEtob+hourw456UDO9BkLkW994ao7XO5F/kfa
	b2VoMOJ/aCRpng2UWdAgpPNFnqCKtUw6nEdGs/7azBPGMI6r/2F3s2A/pvKXq2u3D4snb5GNcq3
	pNSCiIqICiEgoeibMR83WDABnGPsZ9UF2jW0OtmnHR0Fx8ywC9PUzhHiuUO6jr8BdQrfCZEfEeF
	z1nUFmC9GcOHlq2T1FcIYOm1llJaS7iu9h8KbY2zqnngXzFdZmnF1JOfqSVNFxYc2z5tMLybix9
	vr1nHjQ51OSm/HYNGC3v57ItAayrqRl8r6Ox1x8S77lQDwrHVEZUIpcZ7rDsfq/DtUY9uTkS5S5
	z+Q2ITm+4yJ0ra7dfEDB8ZAaARuiOnArhermbbUfZ89A5YFnXHXeBpJCp
X-Google-Smtp-Source: AGHT+IHuRRsekWNjgE7yCPLG9pq3eS/GOyyUhj/f2Q9rAEjbYAirvs/e72q2qhgNkEK8PrNvRevQ9g==
X-Received: by 2002:a17:903:3d06:b0:27e:ea82:5ce8 with SMTP id d9443c01a7336-28e7f291db3mr15309515ad.14.1759276125338;
        Tue, 30 Sep 2025 16:48:45 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882133sm171972415ad.89.2025.09.30.16.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 16:48:44 -0700 (PDT)
Date: Tue, 30 Sep 2025 16:48:41 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: Charles Mirabile <cmirabil@redhat.com>, pjw@kernel.org,
	Liam.Howlett@oracle.com, a.hindborg@kernel.org,
	akpm@linux-foundation.org, alex.gaynor@gmail.com,
	alexghiti@rivosinc.com, aliceryhl@google.com,
	alistair.francis@wdc.com, andybnac@gmail.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, atishp@rivosinc.com, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, bp@alien8.de, brauner@kernel.org,
	broonie@kernel.org, charlie@rivosinc.com, cleger@rivosinc.com,
	conor+dt@kernel.org, conor@kernel.org, corbet@lwn.net,
	dave.hansen@linux.intel.com, david@redhat.com,
	devicetree@vger.kernel.org, ebiederm@xmission.com,
	evan@rivosinc.com, gary@garyguo.net, hpa@zytor.com,
	jannh@google.com, jim.shu@sifive.com, kees@kernel.org,
	kito.cheng@sifive.com, krzk+dt@kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, lorenzo.stoakes@oracle.com,
	lossin@kernel.org, mingo@redhat.com, ojeda@kernel.org,
	oleg@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
	peterz@infradead.org, richard.henderson@linaro.org,
	rick.p.edgecombe@intel.com, robh@kernel.org,
	rust-for-linux@vger.kernel.org, samitolvanen@google.com,
	shuah@kernel.org, tglx@linutronix.de, tmgross@umich.edu,
	vbabka@suse.cz, x86@kernel.org, zong.li@sifive.com
Subject: Re: [PATCH v19 00/27] riscv control-flow integrity for usermode
Message-ID: <aNxsWYYnj22G5xuX@debug.ba.rivosinc.com>
References: <f953ee7b-91b3-f6f5-6955-b4a138f16dbc@kernel.org>
 <20250926192919.349578-1-cmirabil@redhat.com>
 <aNbwNN_st4bxwdwx@debug.ba.rivosinc.com>
 <CABe3_aE4+06Um2x3e1D=M6Z1uX4wX8OjdcT48FueXRp+=KD=-w@mail.gmail.com>
 <aNcAela5tln5KTUI@debug.ba.rivosinc.com>
 <lhu3484i9en.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <lhu3484i9en.fsf@oldenburg.str.redhat.com>

On Tue, Sep 30, 2025 at 11:20:32AM +0200, Florian Weimer wrote:
>* Deepak Gupta:
>
>> In case of shadow stack, it similar situation. If enabled compiler
>> decides to insert sspush and sspopchk. They necessarily won't be
>> prologue or epilogue but somewhere in function body as deemed fit by
>> compiler, thus increasing the complexity of runtime patching.
>>
>> More so, here are wishing for kernel to do this patching for usermode
>> vDSO when there is no guarantee of such of rest of usermode (which if
>> was compiled with shadow stack would have faulted before vDSO's
>> sspush/sspopchk if ran on pre-zimop hardware)
>
>I think this capability is desirable so that you can use a distribution
>kernel during CFI userspace bringup.

I didn't get it, can you elaborate more.

Why having kernel carry two vDSO (one with shadow stack and one without) would
be required to for CFI userspace bringup?

If Distro is compiling for RVA23 CONFIG_RISCV_USERCFI has to be selected yes,
kernel can have vDSO with shadow stack. Distro can light this option only when
its compiling entire distro for RVA23.

If distro is not compiling for RVA23, then anyways CONFIG_RISCV_USERCFI is by
default "N". This would simply build vDSO without shadow stack.

>
>Thanks,
>Florian
>

