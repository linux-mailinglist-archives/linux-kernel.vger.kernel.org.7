Return-Path: <linux-kernel+bounces-851307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F76BD6139
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35773E0F46
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8192E9ED2;
	Mon, 13 Oct 2025 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="AV9lNiYJ"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA922C1598
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387352; cv=none; b=VUSl6eDtIfeixoZw5iP1fSILT7JWIlp9vi1r/4BV9iSnBQdr5vx2kzZlSZnb6YqdqgAwr3Z8gebZPJbBZ6R7KSbIGA/CF3sMEmA/yJbpjoMJu32cT3+80Pv4zdlQI4DMtDmxcjG/2OWHtyvvkWUmSPmeb9WKGyPmdVCflA7LHnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387352; c=relaxed/simple;
	bh=a5whaLNNw/2oDdU+xynqj3s5bjcsWv8y7KEZSCBcVAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1WVyV9PZjKdCW3y1Hz4kiOfIfsN0T4/8MdLz6RXsBzRgfp3ovK9t/bDSv730QxDWmbf91UhZeMmgBXJT8QVPmWbC7XH6JO4hZxJNULz4LVs+GapfqQkMO/2kBwHSUOYSGk7RoV5APPJWWjXHfW2JnyHN73/csLWvPT3iyxNMZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=AV9lNiYJ; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-887764c2868so516440739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760387350; x=1760992150; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lt6afCrReoA0JetcvxGjdIUfBcXG8UG+CLV9XrNIQkA=;
        b=AV9lNiYJmYjvmNWzDKKnIFBKusIgvLRLsbFHvUeR7+7AgCyR2k3BNAu+lLZVUWbJnk
         ZS0gANPrD8tVaWzJ48dQjcmaD+Ahe3O+NPTrW7PoDEgao07ADHmgLmooQ2ySAlKT5r5v
         P0vfrEneV9pbZRJV/up2GyDYom9jKsgzv/mAj8x9YObbJQ75EHXic5P3noGREekt1xKu
         LuXKlkeHnl3HGSvaWOd1d5kfE0XX34dprlADeF2WRFXLxVyd6pX9KEOK+dzSXBr7D1jC
         fz+JGfmv1olp+GGxzARJr+IRakPImujAOwdApDhBhxscNnFBnlOyxaDmxQBH9+fMpeVr
         A1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760387350; x=1760992150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lt6afCrReoA0JetcvxGjdIUfBcXG8UG+CLV9XrNIQkA=;
        b=L5p/b4wKvClgika6XY1cLgflU7lbrYtvvrXZKOSizzey7BTO7FrROznnhZET7zt6zT
         LC4qZ9aPDwjOnHrpMnu2MAOjV9Z615O+YPMo7ifq+/BQySUKc15hBDr20FK3qBSRq1OU
         cGGBn/dvZZHMGwl73xnk/7qJi/Pw6nE1uHhpTegEifiU8GZ+sAHVsPsiKTxetHh0V1ED
         kzin0UqLhb2DkfUFc9Yqan+9FTaODfLeYpVT0ASbhsIatBr+GIu3LrqqFR5XCGylWF/G
         sqf/TJefDdph1GiLDKehSQuXoTOqOpuxzU0Vd7C3/QJ8ilegZ/d0wK9qLQPIbndpHl8l
         u0HA==
X-Forwarded-Encrypted: i=1; AJvYcCXDlJ0IfqcldbxXLBBmUIYLCMMJeQfspaAxcAykLHkb74H+0NwAsSWJ0zRWZW/rh3mwtUk3hHN2OKHIUNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYGbICEeNpnp1QYhXVdcEiXaV+CybwA3+Ki6G312IV1BFlNQuC
	J7n8fwVviB6tmv1Po6PvzuBNxO/vaamD/IGBG1ymE6ZsHs8zX/xkLIaYlkX/H7NoY4w=
X-Gm-Gg: ASbGnctpOs3UWJDI7hsOM8EjS71wfiUu0tPyL+gZiDNGZu4r4p4iZk8LCja+p2nq3GZ
	h0mTR/xc4HYZsqKiKnK5gbRW6picEPbCBwW3r9lUUrh2aozfBW9Cc/JClnYJtOSPM2ONE4JmQIT
	aQXBKUqQ/R9OBV12YOoq9/LIH9l226U/X5p4zBxe+H9VNOFUwgu0WnzdZUDZe84Ka+BGUrCY/GB
	e4M8nCL1WwWsWSV9iWVxm1jpix/f/5gr4hF+qJirKASZoBJ0smaUvH4YSOUAmo9ezK/MNXUljnK
	f8JyNt2I7RgVULBWk2rSN4fEKah/ExrBLUKhViIWAPIYCw8d4WzVEOF4LGyKIdFgN4jroZbA9Mz
	OThqy/9rvSDMwzb/ZUEE1KgqRPLryKaPreeK5WiQU78U=
X-Google-Smtp-Source: AGHT+IFAEeOFIgQZsxlTo4ZFQ5S1ZlK+bDlxrvpTDcY38SUWGb8pL41ejoZdXoSRHGQSxWChB02oUg==
X-Received: by 2002:a05:6602:6d14:b0:926:a24b:dce5 with SMTP id ca18e2360f4ac-93bd18a2e74mr2738341339f.8.1760387349638;
        Mon, 13 Oct 2025 13:29:09 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e25a97830sm418857239f.23.2025.10.13.13.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 13:29:09 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:29:08 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <pjw@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Himanshu Chauhan <hchauhan@ventanamicro.com>, 
	Anup Patel <apatel@ventanamicro.com>, Xu Lu <luxu.kernel@bytedance.com>, 
	Atish Patra <atishp@atishpatra.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Yunhui Cui <cuiyunhui@bytedance.com>
Subject: Re: [PATCH v7 0/5] riscv: add support for SBI Supervisor Software
 Events
Message-ID: <20251013-c5eb76e005d982fa4c8ce2bc@orel>
References: <20250908181717.1997461-1-cleger@rivosinc.com>
 <86817f9a-c601-81e8-b95b-0f2396275f95@kernel.org>
 <628d357c-f462-4dc8-92f2-99006b73e0c7@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <628d357c-f462-4dc8-92f2-99006b73e0c7@rivosinc.com>

On Mon, Oct 13, 2025 at 08:53:01AM +0200, Clément Léger wrote:
...
>  I would have prefer a bit more reviews and testing before going through
> since SSE can be quite intrusive at execution time (even though the
> classic IRQ path should not be impacted, I expect mostly feedback/bugs
> from the SSE handling path itself). We'll see in a few days if people
> find such problems.

I've been planning to compare this series with the code we merged into
kvm-unit-tests since the kvm-unit-tests series is where I put the effort
into reviewing wrt the spec, etc. On a skim of this series I see several
similarities with the kvm-unit-tests code so I should try to actually do
that comparison exercise, but I'm not sure when I'll get the time...

Thanks,
drew

