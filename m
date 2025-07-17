Return-Path: <linux-kernel+bounces-735226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983F1B08C68
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC56A41437
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06AA29DB7F;
	Thu, 17 Jul 2025 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="lO8fYnlR"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC3329B77B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753880; cv=none; b=L8tc3tXeGJn6eHsTey/1mfs7YheXPbJKFJiqVa0AK8f6tuIPPvAUfpTy0/+Xc918++c67NoplD/QSSaB1pokJn5CNk5dRgKLLuxYPK4mR99YOgfWBv8AVNCENyQbU8TjiwjgvwfETdYXRu5aaI1qYIWwPMSaV7s4NqB67toBd/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753880; c=relaxed/simple;
	bh=V5qX50zWv2Vid5uaus2ISEQNzjkiBmKlVbxYGNc1y7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhJQFFUhHTIqDsHORAKqvHSwNXj5kl/yCu8oaceo9ZnwINq3Mu7kdhLZjX0SITbzNJwGPzKRjFjPoFcLsVos/WKtOKPgoMexhN+lIGXP1Im2FP7rMkPSFDgVW3/jkjbjgFMduTmpiUj3zmnuSMgw4zzHI9/L3BRETV8aHMe6B6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=lO8fYnlR; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-86d01686196so30624039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752753878; x=1753358678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QcVJX052LEXBJv99aAWEE5wFktIbYwNU2eZQCUhFGg=;
        b=lO8fYnlRjZHpqv1a+xswxqggfHtBaVbClZRJI5TySzEyI7M1wkfoqHd7pHuyuTNPRQ
         Usg+hamVt3n6MskK9fAHohfWv0YvXKENPTaMge7Nob4RnOPCWoW0upEvmq98vm0BeTx4
         tZsBhCtsg2j5/BvyLPz18lqDdUSA27O8DAHq4fF7tekyG/PtMBlWvyFaPUZGh7jckCIl
         p4zz9HnDgqyGigrfLAJYU7xx8HJ+cCGZo1IRfNXJga+QKF+CheY2oVeaCk8C/gUXN7Pg
         0NPEjTSJhnimJuVQbpIvSiLNHq6ENneO66vzToHQh4zNlkaXp72JtGHOhOKhetltq2bV
         2CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753878; x=1753358678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QcVJX052LEXBJv99aAWEE5wFktIbYwNU2eZQCUhFGg=;
        b=iBsN3/al5HVM4n0I7nU+37pcBfM8acuy+Z3Jc1V4eu/2VfTWKi2Q9h2GYw6YkHw0+O
         32yTte1QU3gJiCYV3wQR/MNB+4IWMKwQJAKwbKcj43hZVoLxEUcYw9O54ZpeQ+x+Vby2
         I3s64VVQZ5X+N9mbaKodJeWMt7Vsxy+E2jmIcuY6cal3mSiZV/JpAi0PzldJrQby3wIR
         xBY8yuSvj/tmvtsz5EdJ/BfXE+5A8RaC7V2gCDwLDOhsbNMIT7wQhvk0PEVwFh/NIriJ
         65LA0f6bOy9CdYUkvd172/+PQcU4xVUCk44U1mOM9Va/MgP/DdyQ6PcUVU4x4BYPLH16
         B8qg==
X-Forwarded-Encrypted: i=1; AJvYcCUojzYky+8dubP614PzCsH4sOXBUvs/WfTVyw0D7/z2RpBTWapM+dqSqq41DF1SBMXHVqM6LH8cVuTjF5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyFicxFVV1czSYL7ywdIEahEexpsSqiw6RdpZvymKXp+oHAD7C
	s7IoGDVrh6Bhn/gKgu9tR5wHBLpadAX1Md17EC3590WXdUsvlSKpata7aqA4vcWs69e24Vxc8Me
	OTuyqYD3KwRnYrx3ANckTDA2BMHnJ+HiM8X5NO+zadA==
X-Gm-Gg: ASbGncv+JzaQe6JR/1KHsYpu4EEe+pI/Id8GWgE1MstSJkNL3xr3uq4ZqH1nHanK6vi
	Pj03vp9gyS2zk6krc9K4P3A8TIv26OqDlHf7qYdJOD2o+ex1BET9KRlZdhRPyFgXqU2FZ5AJLHK
	eESK/YK7AtSCUH/4DqAhE5JT2cdO5kA5ZYAmCQwq+s/xIVQD2NHPkWXaUOSKYjyXWAOXyYcCdoP
	sYJ
X-Google-Smtp-Source: AGHT+IHUjN0WtpcP4Ro+lSCJYUTyuKmTlKwKgPzpi8LVsCv5TFEcqprpyTpUikU7+qtzrB5+BO+NiFTYY7tWuiIfMM8=
X-Received: by 2002:a05:6602:7185:b0:875:bbf0:8bf with SMTP id
 ca18e2360f4ac-87c01356e4emr274220339f.5.1752753877857; Thu, 17 Jul 2025
 05:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750164414.git.zhouquan@iscas.ac.cn>
In-Reply-To: <cover.1750164414.git.zhouquan@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 17 Jul 2025 17:34:18 +0530
X-Gm-Features: Ac12FXwbyEoUlz3T8TSIi03E9WKp7zPs9qMqtNqR8ejTADSP2ePNd_lJkM8wKLc
Message-ID: <CAAhSdy3gYp7uc6ddpNxHhSQDRFDBMiUW3EOf695U77C2JH=HhA@mail.gmail.com>
Subject: Re: [PATCH 0/5] RISC-V: KVM: Allow zicop/bfloat16 exts for guest
To: zhouquan@iscas.ac.cn
Cc: ajones@ventanamicro.com, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 6:48=E2=80=AFPM <zhouquan@iscas.ac.cn> wrote:
>
> From: Quan Zhou <zhouquan@iscas.ac.cn>
>
> Advertise zicop/bfloat16 extensions to KVM guest when underlying
> host supports it, and add them to get-reg-list test.
>
> Quan Zhou (5):
>   RISC-V: KVM: Provide UAPI for Zicbop block size
>   RISC-V: KVM: Allow Zicbop extension for Guest/VM
>   RISC-V: KVM: Allow bfloat16 extension for Guest/VM
>   KVM: riscv: selftests: Add Zicbop extension to get-reg-list test
>   KVM: riscv: selftests: Add bfloat16 extension to get-reg-list test

Please send v2 of this series addressing Drew's comments.

Regards,
Anup

