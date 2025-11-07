Return-Path: <linux-kernel+bounces-890632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E62F7C40802
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B315351842
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279732D3732;
	Fri,  7 Nov 2025 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byr6CtEZ"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11AB1E0DD9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762527703; cv=none; b=WQR+H8hsIxjwwxYw/dNRw31UCQFcH8EaRxyIiQOoL42mpfDzLPfIdLFtFsNGEuQbsNM+Xrm7YTG+T7gkfxulx5CNboCgcW8WvjGbCpYxVw0HIepP5qGU81FYtTzns6g74FyOE0HR6L/o8g29vIpCoWE6A0CW2ZLxdt5VCdtwRz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762527703; c=relaxed/simple;
	bh=6VCPxHuvcxV2caBQAFdNC/oO1hhObmq+VbfMx6jt7WU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u12NVQVtE6GFe14RRq9JprPZzr2zmy0YFpf1skhhGMhoitO556DUhpNdoVgBzDSpUQxeXyDncBE98p48LtNvSBZCG5MWz5WOCgzyN0gZeu/9Pc5XdAP+Fw3M7XpwQvWNX4v0xrUBOAwHV41nWTz7txwAY5N1Hn3BKJ8RtQKlmlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byr6CtEZ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-782e93932ffso716923b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 07:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762527701; x=1763132501; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6VCPxHuvcxV2caBQAFdNC/oO1hhObmq+VbfMx6jt7WU=;
        b=byr6CtEZMzYcYeiC1uO8CQkfBP2UT8VsjKjh8Qk1gH0DezaQ6PRHYmLkRt/bpBC0o2
         e7sEG9j9MlUbZGF+1AsGUnLVJYP/uXvr7YSMVeNkCYZSWVpgTKPI/rD9IYfbQIDlCfvE
         71VS7RQ/lwInwXY1hMYqbozQKc+rAM1aUzdyzlYFAAR62fOvyJgN3AP7VOni3GF/gI5A
         SWF/gbv3JgRdQtOU+UZmTBjy6MIs6IOqDpgO35FSY3cdXm12Wkf8txghkkzHKGG0nj/c
         qcLlgjUmSfWxp3frCgXh8/Oy5PqshY4rwGJiCLV3YeKob7VSnznCEPoJs65D9FY0GlDD
         nY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762527701; x=1763132501;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6VCPxHuvcxV2caBQAFdNC/oO1hhObmq+VbfMx6jt7WU=;
        b=gzOgEWusaFkg7NcnrrMNv78hyUC16tunR5RIpLLb4yRiJeamejkjCPh1zuhxH6zJwR
         Y2jglGpeKQ9Ey3vUfYpAiQzfqKr74NWc2R4YOFBNl8k9ECUb47qNGkpamzwObbFxzX+s
         qSgh2z6fC/GE8ENgYlSsHBepAdtlk44TDgs/IqxfkRgurKGn+5JWgQKx11BwZ1uSDksd
         1tdIABDTjtLI1uXGJ7ueP5b4FWX1SiLCxFbkCRu0hU+OmF/4qudJRVVOxOpDAQcZBarQ
         jUShdckun+H9Sm+lJ/s7iBXf6WmEsjLqzX+wAQqldhdR5A2zZ82HNhWg373eVlcIxfKA
         jLjg==
X-Gm-Message-State: AOJu0Yxp0eMQiRvhLUw5Oq8v1aF/bKgumCk/jSGQYMNV6xXGb6zo2XnJ
	Sq/U42QD9tu7TzigfhselFm25FiiptqWIeqTELjTYt+LlJQy4YZpB8u2
X-Gm-Gg: ASbGncvlrX3gqHjJzkhfg8rIqWhgFSWyw6qa5AxON94plMnPN48IKgV3xDQ2tuq8U3j
	8T0eV8BDDxbANFBN0N5e8c34m8/mFT7qZWwMoDiMGCmGg0tQZviPUjHMSTnrX/9Pjxxat+GrBd4
	bbyfFe85Wta6im5JHx9N/s9+erx/3TXHFZDjna6U1yVMGOrJ75oLfju8r98FYAI78cpCK/g0Fc3
	radnMM4e91/MOCJQ3aUJZsmN12oWmRC6GysrKhGyFKJdCZBjhdRLnEo9NySa8oP4jVYEOZvbXhv
	SA4zQEo3uyb0LQBDeQcrRIQGohCN+iiP+yWi7yjmkZlnjUolJn0klyLW8n0X4R1RNhNmbp1MVY2
	9tOh8GB1nNI8pg4F4Z/3Lb9Hchmc95MRQXgqPBXCs/JHX66yQmz01FJcUr5cS8jtts6uIYH4Gch
	cBkGnLIzzRWVMp+sMPWuwgXdBGuMo=
X-Google-Smtp-Source: AGHT+IG88KPp78g2Bc2Y1K0gqv0viNMPATKjIaOzlWRHWeja33iSDiag+qbCUqfP9TmPF0GSPqj5cw==
X-Received: by 2002:a05:6a20:918e:b0:33e:6885:2bd4 with SMTP id adf61e73a8af0-3522a16e933mr5431340637.29.1762527700725;
        Fri, 07 Nov 2025 07:01:40 -0800 (PST)
Received: from 10.0.2.15 ([223.185.132.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba901959a47sm5408443a12.28.2025.11.07.07.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:01:39 -0800 (PST)
Message-ID: <214e350af7da3f870e1da306c9498f80f1e90c07.camel@gmail.com>
Subject: Re: [PATCH v3] nvmet-auth: update sc_c in target host hash
 calculation
From: Martin George <martinus.gpy@gmail.com>
To: alistair23@gmail.com, hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, 
 hch@lst.de, sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
Date: Fri, 07 Nov 2025 20:31:34 +0530
In-Reply-To: <20251106231711.3189836-1-alistair.francis@wdc.com>
References: <20251106231711.3189836-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-07 at 09:17 +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Commit 7e091add9c43 "nvme-auth: update sc_c in host response" added
> the sc_c variable to the dhchap queue context structure which is
> appropriately set during negotiate and then used in the host
> response.
>=20
> This breaks secure concat connections with a Linux target as the
> target
> code wasn't updated at the same time. This patch fixes this by adding
> a
> new sc_c variable to the host hash calculations.
>=20
> Fixes: 7e091add9c43 ("nvme-auth: update sc_c in host response")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> =C2=A0drivers/nvme/target/auth.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0drivers/nvme/target/fabrics-cmd-auth.c | 1 +
> =C2=A0drivers/nvme/target/nvmet.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A03 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Martin George <marting@netapp.com>

-Martin

