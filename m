Return-Path: <linux-kernel+bounces-873766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F2DC14A68
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 499034F3D56
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FED3054DF;
	Tue, 28 Oct 2025 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JsE5mqYW"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EA22D7392
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654990; cv=none; b=pUG+W07aGOBrLQIsNivEGCv3qJ3uGNXc1/QaY2mh0DBIu/cBTsK63W3iqdKhruecG8HrVVLgriQWI+miM4gtF1gQvXIl/ojkoBg5CF+PlBHEyZjld9TOiuu902B6rP8GPOxA+gWzz8OU3qbYlVrNbWXEt8Ct5tG0OVfTkY8husQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654990; c=relaxed/simple;
	bh=XFtFTzB7nIubQK5+Jnuf6SOxgMcv7Qtuxa8kZNaB4YA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=AT5c3V8ffgEsjM3fXS5L60BSBNhZQRCp32hF1Ffb4gdpRrAwisuGwlvjtbYrcyjdDJ2TfphbR8LSKadOX14GSbYTbQk9Bm9wdq9zywpWonaGxTr5uZDMb/RHVIfs0ke5CuP/ozh8bKTl+jz9jg3OFMmQcy+Buu9KoF6wlsNuYWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JsE5mqYW; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-427087fce27so788249f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761654987; x=1762259787; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQyOvbQrIsm+G0Ym24/Af4gfQ7jSESa1LluzqC9uUdU=;
        b=JsE5mqYWeSgxhW+UQ7tdtopO+6gnFue7Nmv9XzA7LRnU6fmjaOgPKjW/kEL5ow1NKG
         DZ3m6Yt9KyA3Bc7NCSbIQ+4iwY3hUI2FaQztgwdayh9UnNTLgqMPBDPkZAvlEXniMQKL
         jLevFWYuMVsDAT4pWwISqFmYbs/sgxhfqx2iVhHQ9eub2782wEHxHjmw9MiFXi/HVsN+
         TM/HA36VSvtgtuoA/irhIRsSR/lzmjAuV4o0KcmOhg+5jU+NQP2QWpCZJHLY5D4m7X9w
         J+Gnc+1264RI71Vs0EaLsxP3KhYWJ7ugDgD2RfezcHY6sGRB55+tNmf6MPY3sGgewJ4Y
         Hpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761654987; x=1762259787;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iQyOvbQrIsm+G0Ym24/Af4gfQ7jSESa1LluzqC9uUdU=;
        b=B9IYaqvSs2zpujiYyDWlnS40sryo6FNNjwxRBCRmlgwVpVIo75VdATbDhFhSPHVQpN
         DDTBOJ+I5LMqu88NxRB3trE82F+PRjRg/ljbkeGjy1kIo8GNGogen/gYToWb7tMUZf4k
         P4l97V/Bh7/w+3UIw0ZG6KWHvXZ9kYvR3fHOmMUtAtgmyTT+Go5eAyaVQ6Fdzpa8yOTy
         EVmyuc4yVwVigzsPsGd4sEcIiHFyaFDXPQFVOHkK+nguORRfeRJtqRY+f7/6/wUvdI1l
         1jo7VTIBqoXbdK4Tv8rR2UB+aSfPspXV68Dn5UaU+tQoaX9BfS9XZ9rNvFc6R5p5Dvvv
         EfQw==
X-Forwarded-Encrypted: i=1; AJvYcCXKSs2H8EDF3n7baSIOGqkmgGJuvFsT4xEQx599a4uQbhnm37XPMBvJ7K7PPp7tKpcGW4BQ744BokRoEmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznTac77S6kpRKCWn+32pCbj6YnI0AwNeDkCZOyflHWSG1CH3gg
	PYiLjWQoK83Qbb2zl8qjiOQB/RoEdX3L3HOiVm1Z/ZfAUDIYSTAmBktTo/QNVBqLoVc=
X-Gm-Gg: ASbGncuM+0dxgQZ2BPDMX3UfOwr2KPEqsSmU3HMdTa9pRMZTDnHLGLXQLkC+bNRrY+8
	qcx8u4pDKmwNmli60VOdxCaKYiqsxCNseKcpYiHIgzHuy8YThOE6LV6X1i6spq8CCGh9cHlZWLd
	fW1OwJ0t3ROfYUF5/ljcyNfYIvo063uMEB2mQEpN8lrWLeLKWd+eIXklsCweDY1CkZ/4xrDzMJA
	p8tUfsgo+ibT72d6dqHKVhi4WYw/RXLoA5VcUOPu/r/tqExNFtv/wb0k28p0XCnuh3OXUtxcDUb
	nBENjwtUw+wk6N7Ue0JP5pqEZuvUwwj2MsCNomc7RGcTikgpGa1eIdpLBfAY7lVVIVunvw3zbNu
	UUW/xubUCV0xpB7deMvocXObYhRHTL4oJRY7JpcfbstL+uRU/yUG/4gTJEfqZ6qVE
X-Google-Smtp-Source: AGHT+IERzNAPCuMV5ZEd056F4yvrhY3xaFUs/IZCciZzISu1FZ3xid6ZyglBvWFh7twn6bZPyUL+oQ==
X-Received: by 2002:a05:6000:25c5:b0:425:6fb5:2ac8 with SMTP id ffacd0b85a97d-429a7e97509mr1501787f8f.9.1761654987044;
        Tue, 28 Oct 2025 05:36:27 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::3052])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952e2e06sm20285678f8f.46.2025.10.28.05.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 05:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Oct 2025 13:36:20 +0100
Message-Id: <DDTYKLFUE3M0.17GD0S4OSQG16@ventanamicro.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH 3/3] riscv: crash: use NMI to stop the CPU
Cc: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
 <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <luxu.kernel@bytedance.com>,
 <atishp@rivosinc.com>, <cleger@rivosinc.com>, <ajones@ventanamicro.com>,
 <apatel@ventanamicro.com>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <songshuaishuai@tinylab.org>,
 <bjorn@rivosinc.com>, <charlie@rivosinc.com>, <masahiroy@kernel.org>,
 <valentina.fernandezalanis@microchip.com>, <jassisinghbrar@gmail.com>,
 <conor.dooley@microchip.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Conor Dooley" <conor@kernel.org>, "Yunhui Cui"
 <cuiyunhui@bytedance.com>
References: <20251027133431.15321-1-cuiyunhui@bytedance.com>
 <20251027133431.15321-4-cuiyunhui@bytedance.com>
 <20251028-scallion-list-c8aa5f350286@spud>
In-Reply-To: <20251028-scallion-list-c8aa5f350286@spud>

2025-10-28T10:42:12+00:00, Conor Dooley <conor@kernel.org>:
> On Mon, Oct 27, 2025 at 09:34:31PM +0800, Yunhui Cui wrote:
>> NMI is more robust than IPI for stopping CPUs during crashes,
>> especially with interrupts disabled. Add SBI_SSE_EVENT_LOCAL_CRASH_NMI
>> eventid to implement NMI for stopping CPUs.
>>=20
>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>> ---
>> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
>> @@ -487,6 +487,7 @@ enum sbi_sse_attr_id {
>>  #define SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS	0x00108000
>>  #define SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED	0xffff0000
>>  #define SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI		0xffff0001
>> +#define SBI_SSE_EVENT_LOCAL_CRASH_NMI		0xffff0002

This event isn't defined in the SBI pull request.

I assume it's a pure software event that the platform shouldn't inject.
If we want to reserve more events for software use, why not make them
generic, like SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED?

Thanks.

