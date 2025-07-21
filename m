Return-Path: <linux-kernel+bounces-739273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B37B0C432
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D03B541078
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597012D3206;
	Mon, 21 Jul 2025 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="al/jmPzC"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D5E2D0C69
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753101344; cv=none; b=nLNbIPp+Tw7febtvAa0eEY05//Xn2n2RhS9tL/l30exQgOh3TuYJr7FYS/w25yS8zWe8JfUIpWKx9W5QsHn9tQqiJT3RdvCsU/oh5aoVbVjteNZ1P6j4dJ8oCjvQ9130i86AbIlX3lpQW5+DUR/vpBu2oxpWYyserN/VbyVXyiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753101344; c=relaxed/simple;
	bh=FhfW4Yl2ze2Tz30g9DaUQC2yawhgCgjVZKlnhz6aclQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=HkAQ7Y8xjvWPbTo1oQ/lEhdxpoiK1WQiJAghcZL8uzQmNHxEgRk/n+7bV7DIfPEHp6S68wNpHIXMXjnujeuNK2pyz+9Tt1AXv67LL4sDn9/jaLmaJdG57m2dtrDcoa+MlYj2eVvwmr+j+/N/pl3DJaio3ZklJzd2TdRXrGJoMZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=al/jmPzC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-456127b9958so5564995e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753101341; x=1753706141; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhfW4Yl2ze2Tz30g9DaUQC2yawhgCgjVZKlnhz6aclQ=;
        b=al/jmPzCBYoC/vPDI+TK7JZC2WVWL+d+LfngR2nPIpRTd8F3yB06WuEBbMJYhF/D4P
         q57KQDcL9LUtFaeJO30L6ZNzFdXqAcR2jg4kCivYZL1lOG2XzfmfZ8RLhXVpqfZ9roM2
         UsM+Xi+sMZeVSwntLZt9kcZCSmincIY9+WZdRP1uUkZywnBWd4F7skpk3WzMKp/+agHj
         R5x1X1cvG81soI/GVNwc3IOhZd+lW1PJEXqHCytVya6x0wFHAKMo01VEGduHJDr09P/0
         PEYzO4lWMyIofN4UjPHZJt0YMjYeiARZ0DTM/lZJmdwBvuW5N9gVuVMCRveSHd8xSC53
         FJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753101341; x=1753706141;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FhfW4Yl2ze2Tz30g9DaUQC2yawhgCgjVZKlnhz6aclQ=;
        b=eT6Q10Ki7P14nxOCPArCaMa+bynal4ya7DX4ZWhPmaGoe7hSWmQ7k76YqMfjv5HnWI
         CndEywI5YJeTeUueMnx7O+12StQYsjdhlOfNsF/+U/Q7HgiRJ+yU0BCz10UxFhjjLYgi
         XVE536DPskGl2WXC5vtjCTeWGDS+ZtSWndwcrDsAQfGPONLzElz0DJv5VxB0Vxf95tDY
         HrzR61aT2lGFaQ9sTeOUu64B/E3+ebwA0RGNnhNQdq1Kq4xBfG4nAgMryY8E1sKtw2J5
         Qsv60gwj9IEmebzKI05ItIlr9d5ael2+EdB0FncMt8iOhmvuuPtEnCci1QAPercAK/0J
         LsPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW31mHluMNoxt9/QEQc7b7o6KkuGHpCQ9FsM4h65/mUaIi7xq0MW0ySe6mq3Cu+gBjBt+L4zRmPtEzJvFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8AzeVEgUbpJAFMh0kusyA5P/oBzifsnUMqQALPQEx+eOEQmI/
	Q/YYsq62JMP4ujB6eCL9XG4Xoxxr9H9+Dpuhvg5qrvapG2bdTZxa1G9xmqWqE0hjEJk=
X-Gm-Gg: ASbGncvbDOPUb4W327kMsb0BMTWDz8ZBVx2vtLTTcxsOkrdvpDz6i2ybRtc/DOGBndQ
	CWiaTz8BIMNr38oiFPOJQsXPhesZgoSDx0BEfH2cKi3ypBNdVpQQoBzNZ2cjElwxQyjp0cGh4SY
	0pM1u9nioWH+kixHYk22lp5gBkhC6HINiuvxAsAZiEMjWlIvJ8k/Z9ZHUCgMUmkYX6E0gPFABu5
	rArVYXI7ngZmWDCuhCxVX5ZDGmTgMMEbtMIWlR7YHuH+MepLbeivUg75LLp294ENtaX/mMcGUVv
	dyZ97h/ixcj7cSbRIfTBpXWLSUVdgOGG2V5Mmo49dX159uPkxkIJrGLL/gzZ7ZyR7XvUZgormBZ
	XppAXqZr1tO/5NPoTgVIpRt6MgTs8JQ==
X-Google-Smtp-Source: AGHT+IEcyghpQXedg8Fbb1DgxtR7REF0rvMfT2EEhXvMZGbm0ucdzrH+CV2xboEPsvvhaT8T0Y261Q==
X-Received: by 2002:a05:6000:208a:b0:3a6:d403:6429 with SMTP id ffacd0b85a97d-3b60dd60554mr6524784f8f.4.1753101340935;
        Mon, 21 Jul 2025 05:35:40 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:25d5:2321:c8db:1609])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b61ca2bb80sm10369612f8f.23.2025.07.21.05.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Jul 2025 14:35:38 +0200
Message-Id: <DBHQK4W9CL9F.1WM8JFVDQZ44F@ventanamicro.com>
Subject: Re: [PATCH] riscv: Add sysctl to control discard of vstate during
 syscall
Cc: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
To: "Drew Fustini" <fustini@kernel.org>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?=
 <bjorn@rivosinc.com>, "Alexandre Ghiti" <alex@ghiti.fr>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Samuel Holland" <samuel.holland@sifive.com>,
 "Drew Fustini" <dfustini@tenstorrent.com>, "Andy Chiu"
 <andybnac@gmail.com>, "Conor Dooley" <conor.dooley@microchip.com>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250719033912.1313955-1-fustini@kernel.org>
In-Reply-To: <20250719033912.1313955-1-fustini@kernel.org>

2025-07-18T20:39:13-07:00, Drew Fustini <fustini@kernel.org>:
> From: Drew Fustini <dfustini@tenstorrent.com>
>
> Clobbering the vector registers can significantly increase system call
> latency for some implementations. To mitigate this performance impact, a
> policy mechanism is provided to administrators, distro maintainers, and
> developers to control vector state discard in the form of a sysctl knob:
>
> /proc/sys/abi/riscv_v_vstate_discard
>
> Valid values are:
>
> 0: Do not discard vector state during syscall
> 1: Discard vector state during syscall
>
> The initial state is controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.

I think it is a bit more complicated to do this nicely...
Programs don't have to save/restore vector registers around syscalls
when compiled for riscv_v_vstate_discard=3D0, so running under
riscv_v_vstate_discard=3D1 would break them.

Shouldn't we have a way to prevent riscv_v_vstate_discard=3D0 executable
from running with riscv_v_vstate_discard=3D1?

> Fixes: 9657e9b7d253 ("riscv: Discard vector state on syscalls")

Programs compiled for riscv_v_vstate_discard=3D1 are compatible with 0, so
I think it would be simplest to revert that patch, and pretended it
never happened... (The issues will eventually go away.)

Shouldn't the RISC-V Linux syscall ABI be defined somewhere?
How come we could have broken it with 9657e9b7d253?

Thanks.

---
I don't think it makes much sense to clobber vector registers on a
syscall -- a kernel might not even touch vector registers, so they are
efforlessly preserved in that case.
If kernel needs to use vector registers in the syscall, then the kernel
needs to prevent any register leaks to userspace anyway by restoring
some state into them -- and why not restore the original one?

I think that main point of clobbering would be to optimize
context-switches after the userspace is not using vector registers
anymore, but it's terribly inefficient if the ratio of syscalls to
context switches is high.
Linux can also try to detect the situation, and turn to lazy vector
context-switch, with sstatus.VS=3Doff, instead of eagerly restoring
clobbered state.
(A good indicator might be that the userspace hasn't dirtied the vectors
 since the last context-switch -- kernel didn't need to save the state,
 so it will restore lazily.)

