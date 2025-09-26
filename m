Return-Path: <linux-kernel+bounces-833761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C791BA2FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385353810F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8771291C1E;
	Fri, 26 Sep 2025 08:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="18rDDckR"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5751E2312
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758876086; cv=none; b=T/NvHDeoKbvR5QL8zkhzBAG+sv+qJzr20PFOLuMbWlGtVEj7kkYNjPhHTagkA99JSoDaqhMsZaBrQgt1gYMWBa3SVjWMJdg/XxX8tZ30KuwT0LnJ/iCHDb/4TdWg+qaXmVm48fSB6ZzhTXSVOFNIPq1swsuealWRnKouyZ+RnMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758876086; c=relaxed/simple;
	bh=KAurkbsLLcIpsAM2eFzMZuI+UmS0sa5VjNZaIH32csw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHcVCVPfXl+erbA0YHpf6E8XPFeKI6kpaGVLPlRzkpRs7+wD63kbgD9afwxHONe1hBPz6jrp1bFe2CrDQohuCO9Wj7KFTZJuF55svlZIG0/PqSYm6pNB71FqJ91oCNmbbxarmWPfLXa83abRAQuC6mU37cGm/Yas7McAnpStLPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=18rDDckR; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4db385e046dso13910961cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758876084; x=1759480884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAurkbsLLcIpsAM2eFzMZuI+UmS0sa5VjNZaIH32csw=;
        b=18rDDckRhNm0LBEdnDOOq1OXXNx6cGMS+G+EH9RCjNANdWpF9Ei06mIfjOk6guj+uv
         EdsMdJZ0VclEB882PcehEaiYgi3rs1yjrrRqy9BVvPkxr5xFvt4lbMepnMo/UDH3Vvgf
         O1ew9Cu6KWjNgNiI8eXXTGRCYorxuaphdM6YcYF24NaoOtgF9uJqV2nzxW7tE3n6UONx
         5kIN/Bjpuv+HKDaiX1oDC4SW4QCYQ4xA47d+1cjE4g0SV9KiRqAnJfeoUrbJyM43BIjY
         uJqTQramaM/Qefw/X8BklVFS5CTe8Acdw5hUGxFKc6DBLY+ygcboLf2v98mehyzTCVlU
         d45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758876084; x=1759480884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAurkbsLLcIpsAM2eFzMZuI+UmS0sa5VjNZaIH32csw=;
        b=KGolRafNRiW6pz3BDrhfuBWZ+5NdGvIO1D3C8m4tmsl9OpfXlJ4WRFD2UDn3nI0Q8Q
         i+SeUe8oWR0EN2xkBqp3VLaaGCdMjpM0JT3D5yj+BCDajyQnWU/C2+fbwCg4KcFJoF16
         ywwRgA9Lz8LjHtE8TQfvbKe0x/8c+Z7eaHb0PdKi/aEp7SCDiczpvDOvFl6dWprcqCpt
         b7NYzk1UhFQyF2EwIxdJ3CrLMZichwmLx6VHnJWuaFdXXKcLbjZ6FQ0zve0jeB1v5Zz2
         BQeVJ3MW9cm/N7Usv1aAjHRAv6MG1YdWVeotOmiZnA4Qfx0yZrHrsdhiO4UpAujI5HrI
         NKHw==
X-Forwarded-Encrypted: i=1; AJvYcCUAt8tkByIFoM85IJTRj5Zm0v8rnALgPqzcdvLKuej9UJIG2PTl/tDXVvoYrMr0u5RXZkambiB1vcWYF30=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEJCP+O7IZDZGIqqOat5of5lktpedWd8AitgjUxZlbZjmxO76T
	fVp7rMXGBI6i8aigWTGy7g1gG8ZArri6LDyoSR8vpkSVqm3M4GRQRCCKgK/E0G56uk83CHl8v0I
	N/ITCtprpQvLVxq084FyjrZ0nV24wxDN80AX9TmoWcR7l/m1UaJ3RgoXr
X-Gm-Gg: ASbGnctJC8v/LX0EX2nLAlnfuaFvkD37IsisabZ7NuY0QD7kgOTzxVxO6w7eg8H4oVk
	hv+QpV0RQ55+wGKXVFTN8dx5uD2QCXaDAzpXNRt8eI8JHg9aAN6/fOEyOCbqHPF6wBM5QUVaXwA
	ZWZEyULGXzHjDjqh1bjjWUNcoAvpoZhdG/2JWeEVEZP8HmSzQ0WiNCfDazBrpwSEtRPs4GpX7k7
	9CI0YujFcBAcQ==
X-Google-Smtp-Source: AGHT+IEesbqkJ73QcrgVqONO0Guk4gmWQKh8XvcFNGYHWYQu2S56lHb3J5tJWduHHAFti60ry4vCmkWbS3yWwUqQU0k=
X-Received: by 2002:ac8:7fcf:0:b0:4b5:e017:a895 with SMTP id
 d75a77b69052e-4da4b42cd54mr101570881cf.38.1758876083346; Fri, 26 Sep 2025
 01:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926083525.13500-1-qiang.zhang@linux.dev>
In-Reply-To: <20250926083525.13500-1-qiang.zhang@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Sep 2025 01:41:12 -0700
X-Gm-Features: AS18NWBn5zm2dGef-mtZFwGENelNQOY2h-Q6neznIJIlCvgU7R-4mINCfqfa3oc
Message-ID: <CANn89iL_UVfFXiYGv4GDdtYOZeNDVEgYpRfKHxYDuvNYJU-XUg@mail.gmail.com>
Subject: Re: [PATCH] ref_tracker: Handling kmalloc() allocation failure in __ref_tracker_dir_pr_ostream()
To: Zqiang <qiang.zhang@linux.dev>
Cc: jlayton@kernel.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 1:35=E2=80=AFAM Zqiang <qiang.zhang@linux.dev> wrot=
e:
>
> The kmalloc() maybe fail to allocate, causing sbuf to be null. this
> commit therefore free stats memory and exit function when the sbuf
> is null.
>
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

I think you forgot a Fixes: tag ?

Anyway, current code handles this case just fine, so your patch would
reduce the output of useful debug information.

Thank you.

