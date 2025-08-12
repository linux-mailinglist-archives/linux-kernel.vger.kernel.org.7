Return-Path: <linux-kernel+bounces-764384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5478B2225E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3D050531C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B112E7627;
	Tue, 12 Aug 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fIm1c6c+"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3C42E54A9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989451; cv=none; b=qfczxqgBHdFm2PWzYrHu7KrBrfDeb40pylx0Fa/RxIfcl8ZMrv1ioiLSM+Sy2OYlMl2qsuLhPbcWNNOPW16XbkJBziMYsO5QaFtL1FUXhBprZPNfitrTZyVSNCfFI5AvoXKCOz36Tv2o3OtJwZmfx6jShRPZOjGqo2Stu7iAGnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989451; c=relaxed/simple;
	bh=SfGibH3LYjDwJHPtxge+VGyiVYm3yPEC0dBeNwgapkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bCcjN4uPuUKTy+s6aoqcPEoYWfR37Sd/O3tFQY/tJKUN5w9G9+eK8QnlAYpU25gYTbb7zrldAJ28gRdH7Dunor46It0vA9JnD9GEGgeVCx7FTPS9r4sVWtmLo/InPitYsk5nKC6Y4EED2+aphvVW9DxkcA8Z8nergPqoLhNttb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fIm1c6c+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b7813c7858so551648f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1754989448; x=1755594248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xtp0f/XAF/TX0R94lrjgjIgA7neAmWsQ9XVPNzUOsGo=;
        b=fIm1c6c+R4j3BnKlboyp4GFsLEWpuy27plShoPaY5Izhj00+/gj9ETSOBbn/cYgbQi
         5vIXAXojoVLzda/PyRxVfNTeTkakew6au45UwGTCdzmtRfhrPVmRJHXKnv1lNkELztu2
         fovR1IUQZPrYxG38jldFOYGFU+pgw8x0OK1jWL3N67XpsU8yTSVSSVocvv/XGPdiQKmC
         8MXUFcka/pPh3z9BFF1YmzrTuZulsOqzaC3chCyBavvqNlkVSKkgxtV4Wt/Swq5lszTb
         Mnc3uLLru+H9CJzpEZtDcPQr8Ioqb4BcouhJdyxIDhK3k8v4DvB1PJazLv+Ctcw/0WG2
         yM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989448; x=1755594248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtp0f/XAF/TX0R94lrjgjIgA7neAmWsQ9XVPNzUOsGo=;
        b=O1PE3yEihxJdd4tLY0o/+U8wfJhzqONcauipXDIuBMeY5EmnSEeiW5+fbeFhZfUPfz
         O3Lx3q3daRYRjZ3woQgei1feUF7nOToL9ftwJQQ91YdWZK39Y6pHlYeXQE6EHc85mCLJ
         5ZPPUpm9NfThyNhSJpUsgZ1RKIzO7NMtqEHaKfb46YeEyjH4sGOugWbel7E3f3Ptcn09
         Ka396o6JIyVJxW5cNZBVtEfl8DlxBaqh72OrjNnKvMsxeXzU8HKaf1QVcqPAQGXzIgaN
         dv2vKwa5OdVSatzVubFxnY2eGZ8oteZ/8K5FGtZmqwrE2JCGzbrooYG3/rzZYzTCvnOO
         2afQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqPVE9YW/iIb8AP5Be5ZzDnDR+HYkLyhuH5teR9gT2ZKjExs9QsgAXM4Ojqy9gY8Zja6HY62/XUo9/JrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmyDbl6HAggbSPMwcjr0Tb90SWvMIV7twdAko+DgelHaNhansO
	+ov55gFAWUG/GJ4xzbL0suT8R3lZ6vXXtnPrub51FKR2CAFihmPmdirlOo1J+F7t6Co=
X-Gm-Gg: ASbGnctVnCYGBi9NsRUL70qyAirn6gTqFny2TD3A3JU1a6gC+NsNz9B+Ql3mCfyWZXX
	3PLOcym2Qxo8c8utlJ530CO91sU+Di6QA9dVIxDi/FkS/myVDvo8Px+mt/fY359RkxiXSixfePY
	UdI1F1iqJOK7dJbiIedaDH/WjSAP7/+dMu7nBYBcYOhTqaMX5iN+fUiDpUYw5gDbaZ/leBrWUci
	Yx98uGGRZI3wdc4mnt0Xj5rx0FwRJtxDAjMNsMSKmkAsfMHYbK+MW/t+q3GsnHtKgCJE6W8a+PZ
	Y6T4MdAoAbf0UC8ofp4lh++rbm6/zXQP6PRFwb2nbHn/WbfEh+PCXSABlY8vzk4VAYG+jnoWle7
	i1FLOphLra3GBvMmRRUeVch/9gWuA6w==
X-Google-Smtp-Source: AGHT+IH6MhMdd/azBMg6FFj7maPvuhuBI0aLHfN/OOEfRoWpInAXZIecXHTDdNehcRNL9lr4GrhaQA==
X-Received: by 2002:a05:6000:230a:b0:3b7:889c:69d5 with SMTP id ffacd0b85a97d-3b91538ea0emr120027f8f.12.1754989447868;
        Tue, 12 Aug 2025 02:04:07 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:8113:2b11:8f42:672f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3ac574sm43479697f8f.5.2025.08.12.02.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:04:07 -0700 (PDT)
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] riscv, bpf: fix reads of thread_info.cpu
Date: Tue, 12 Aug 2025 11:02:54 +0200
Message-ID: <20250812090256.757273-2-rkrcmar@ventanamicro.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

These patches are related to a recently queued series [1] that fixes the
same bugs in normal code.  That series finishes with a patch that would
have exposed the BPF bugs, but luckily it won't get merged until v6.18.

I don't know enough about BPF to verify that it emits the correct code
now, so any pointers are welcome.

1: https://lore.kernel.org/linux-riscv/20250725165410.2896641-3-rkrcmar@ventanamicro.com/

Radim Krčmář (2):
  riscv, bpf: use lw when reading int cpu in BPF_MOV64_PERCPU_REG
  riscv, bpf: use lw when reading int cpu in bpf_get_smp_processor_id

 arch/riscv/net/bpf_jit_comp64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.50.0


