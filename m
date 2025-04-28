Return-Path: <linux-kernel+bounces-623585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B7DA9F7E6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 20:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14154179106
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 18:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF092973B2;
	Mon, 28 Apr 2025 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="V5cET2gS"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F259296D1E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863259; cv=none; b=n5GXVPmfXLZiQ84LB/z5Ac6oU6MRrG5QzlvjgjLfn1Ifgb3vaZaYWCStKwORJuytgSlFfINwxyY50BtNwu+AU+pWtK8H8cqWslNtfysOLlx31YTitohlVZy9IcUFNfRbDZWHrGEJiwG62Qf3yzq3cy3tG6eXx6dpyLN4Sl5eY6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863259; c=relaxed/simple;
	bh=N2wU7kmG2IIfCkkipVz4Ed3x45pSvoHez5zYP1lbaMc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=EJpYgmUhBnsYxGLzmlvuUI3wK7cNGb934PygoMVIyC2nrpvXaB+rLztVXWuFVaUxNg05MnxXdMimGc+QI47t+AtDbWWUrMdxvdlJiARI/B00aHAfet/+XZCWQDENeyQhjmebcEYffgmlLGWDow8hRtSH5OhcHWrCzpNdb9290w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=V5cET2gS; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39127effa72so660631f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 11:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1745863256; x=1746468056; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZwXwtzXWmeQYckV0YYno1wNCKBMqM9oV5/JyBASh3g=;
        b=V5cET2gS/m3xie1dh1KXei4fIVhB9H+Xr9O5gVCRGfNLSNbhXe12Fu27s2iTHbl0Hn
         5Clw6TL6f+UvZ9yKdH5EbSFuRTY4QGlSXpGdT7p0Vyw7QqgLITLj3/KHBicn5CC2l6Bx
         eTkyVhn0QLazoAxWBp5SBAkyuebJS82z3lTWTXkMuqM+kBaD1qKQveqAjGt4P6VOCQwI
         0OwRl+8/gPCwxZj17A+c91yL6oiRRrrkAZErbf5DX8JAVfJqUBG2+cSYd6TsDUEcKeSS
         VA5WNZMLsyE2oO7TakVjWrSRDKMR5c1ccja6r/sVqNLWNipv6l9OKqT3kEcc6h9EWNG5
         4B8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745863256; x=1746468056;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mZwXwtzXWmeQYckV0YYno1wNCKBMqM9oV5/JyBASh3g=;
        b=BjgSHtwsrHOEc72qJ31rP7rVkUOuMo1Jra+H9aO0iQVVhvpozlQcOjVY58gUPfM9JB
         TPG3hXsrhidDpegp2UIQYCDiitYQc+LwCtqdiFcrZ5C5uJbGr9zMrRBUgTXyvQ9GB/q/
         At7fofrNVTp9Ehcj4y0RQz/Mt5HEby8C4dyuavsbcLrYqL/cYfoThh09qmgtscVEQD9j
         QhzaPzA5/ErhsEu/gRtjkDoe1D4uFx2OvYBDozJGMgzAHHI5RUjaWmHRLUgKxEyCL9iB
         25VaIEN3VRgZnefWuOJAmW9hdTYHfi7dIH4mxioeXOXeuuYWP7mxwDk4lzUX3qOcC4aX
         jTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf90UWynjpcYuN46tODzCbCXqcTRL1JvIBLlmuo196PYNZTap72BVr4oKm874NkfN4zFf4GA4qAeiYj80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9GT25Es5/0SjfvFu3GXhDYQwmkNTcdybohzCOkwxvwx68Jmlw
	3Jq2d+3Oima73DwQ1O2lVfVBiO87IqV/pp3g1wNm9LTaBFgZLt9gRrDu4L1AXm0=
X-Gm-Gg: ASbGncvWeQ9CrNihJTw4LRNK9yZbRwcScbqs9c0ZEYfx1cbDGQ2pmYl1Gs7pjLJtFqk
	4vp1QGluAPKdmJe359Nto5P1A1q6jsRde2Dx8HQmoJ+Nr6wWtwDJWUiNBkPmh3hstnDIvU8Kk+6
	HfvnE7eLba8P8+GnGYyknvCrs+tkg1AZRc2uObIBXXpyDJtolvC6Vu4+NL/VzGTG3ppZ8yChWX6
	pkK9J6BH3C6U4g6/WaValLpd/Te0JE2WBhwSn2u8mTDnY8dE2xcQ0Oh2018FKw46j6puyBxqGDK
	/l++Wbj0PCIbDOHyvouTa7FuoGR7V8UZcLtxdcAQ5W0k4T4=
X-Google-Smtp-Source: AGHT+IEoLn0qfVLaHBdPIxVZ7lJCgR2On0y4jpuci39/L3rmNtHaRZ20QzdrYfwyAYvWF7jRY9MHSQ==
X-Received: by 2002:a05:6000:1886:b0:3a0:86f3:451f with SMTP id ffacd0b85a97d-3a08a3438camr79148f8f.12.1745863255647;
        Mon, 28 Apr 2025 11:00:55 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:785:f3a7:1fbb:6b76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073cbdb78sm11569680f8f.41.2025.04.28.11.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 11:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Apr 2025 20:00:54 +0200
Message-Id: <D9IGVF0OY4WJ.1O1BX0M2LWUVM@ventanamicro.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH 3/5] KVM: RISC-V: remove unnecessary SBI reset state
Cc: <kvm-riscv@lists.infradead.org>, <kvm@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Atish
 Patra" <atishp@atishpatra.org>, "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Andrew Jones"
 <ajones@ventanamicro.com>, "Mayuresh Chitale" <mchitale@ventanamicro.com>
To: "Anup Patel" <anup@brainfault.org>
References: <20250403112522.1566629-3-rkrcmar@ventanamicro.com>
 <20250403112522.1566629-6-rkrcmar@ventanamicro.com>
 <CAAhSdy1RSpVCUzD+Aqbhh7aiQPmC2zdvuQfuOsmYNJrF3HxCsA@mail.gmail.com>
In-Reply-To: <CAAhSdy1RSpVCUzD+Aqbhh7aiQPmC2zdvuQfuOsmYNJrF3HxCsA@mail.gmail.com>

2025-04-28T17:46:01+05:30, Anup Patel <anup@brainfault.org>:
> On Thu, Apr 3, 2025 at 5:02=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcm=
ar@ventanamicro.com> wrote:
>>
>> The SBI reset state has only two variables -- pc and a1.
>> The rest is known, so keep only the necessary information.
>>
>> The reset structures make sense if we want userspace to control the
>> reset state (which we do), but I'd still remove them now and reintroduce
>> with the userspace interface later -- we could probably have just a
>> single reset state per VM, instead of a reset state for each VCPU.
>
> The SBI spec does not define the reset state of CPUs. The SBI
> implementations (aka KVM RISC-V or OpenSBI) or platform
> firmwares are free to clear additional registers as part system
> reset or CPU.
>
> As part of resetting the VCPU, the in-kernel KVM clears all
> the registers.

Yes, but instead of doing a simple memset(0), KVM carriers around a lot
of data with minimal information value.  Reset is not really a fast
path, so I think it would be good to have the code there as simple as
possible.

> The setting of PC, A0, and A1 is only an entry condition defined
> for CPUs brought-up using SBI HSM start or SBI System suspend.

That is why this patch has to add kvm_vcpu_reset_state, to remember the
state of pc and a1.  (a0 is hart id and can be figured out.)

> We should not go ahead with this patch.

This patch only does refactoring.  Do you think the current reset
structures are better?

Thanks.

