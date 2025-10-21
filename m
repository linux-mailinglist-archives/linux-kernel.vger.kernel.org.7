Return-Path: <linux-kernel+bounces-862598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7800EBF5B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51EC14FED52
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C98A328B7C;
	Tue, 21 Oct 2025 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JkBTlwHp"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B082E88B7
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041538; cv=none; b=QOAf3RcFno55PKBsMa5ytYpgR4c/xsRkSTMr6KZ+5O2LNhiheKFLmYvpu2NMrya8Sz1xI1uFvJS3G0E3809EJyxAoFNNjk7+puEL9JFUckqAm3G/g/IQPwmidSIBWNsDdrSe98Zt5O5D2Ahykw/0UPYkIAD7s1Jac2xUb5md00w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041538; c=relaxed/simple;
	bh=lS7BlA3ltA1K+OuXFELUMAx/9ayEMieaqVJ6yEPITIo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=NdtXvqu17MThvw8gtYFePLxhQ7RzT2LFd5NAM7PrFJB5lxev/sHqBDQoPLDKxKXFRQMJr9lk7SSIOSyh/mZ87IQH04tjuISji9ME6EEnNf6iiKI4eEghDxGVLDZvhrqtijISdfyx5cvBQtWJei/vwplU7dkAzMo9zEQyl+rLwx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JkBTlwHp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-427054641f0so794501f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761041535; x=1761646335; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lS7BlA3ltA1K+OuXFELUMAx/9ayEMieaqVJ6yEPITIo=;
        b=JkBTlwHpyLZTgYHz/IdzEveZvpMBXSz6i+qrRCjp6QqKa25oaBZG99U+6DvsJBtoqZ
         EoXT1iTsTmhOQn+eG51AlLpGYoOqrWLVmGj6827ZqWCSD9Gss8uKHJ5z+5usqZNDbktS
         J9hcPMLkvVNWe2Oq+isq+1yKdoQWEKjh666waZjKK4tEfAn9o5KESXN124aun0dLjTSf
         WFJsqdNm1dkXGgRphthprzTPW3Wu2+pxn8kTvoqf/Gjz0PtN9WFwu0bGPg6jbK3rB4lM
         kA3pQUwLeqbX3mouGEPnCAHYa+7WASNeKzkcXlIn4PabuMUEGqnabZIuobJA8swAR6KA
         H+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041535; x=1761646335;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lS7BlA3ltA1K+OuXFELUMAx/9ayEMieaqVJ6yEPITIo=;
        b=EWrwk+r5I3Rd6xkOqsVh47KrIwkc/lM552Af4pgx0e0V1874ljmtWuDSR9uLuK88yA
         fFrsLO9ffg77b1q4/oINRhmvX0XoKmQlMmhEi6ZOG0wYXurchea8zVJR3l1EkATt9xon
         Oa5FM/+d/5UZjXdE+9B9PsYWtw7s2n6Dmb7XMIrfcwu+C0xPuM3eDq5yCxJta/UIxwU9
         A0S5tlQE76m5DcrXwPst7anReMY5L9hcvmotmacSrz8SEbQQGbH7kJ6rmB8fVn/ZDYjZ
         TOphxaxWS916gJje2UBYGrEdH61FRmVM4qpmcMIMmed+M0XBSXYwELc2XlWzpaZVOuTF
         wU2g==
X-Forwarded-Encrypted: i=1; AJvYcCVnmds0qn9GYDaNAcm8TzRmpHh7qYMRnQAWdx8GBbU+qsCfvaCHpfN66Wa0ngGg9U8Qlh/Mi/2fq3X8drE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRCq93MmDLt9N0AAiuTUKcP2+KjI21JxTYA5y5ZzoupMTi6RAu
	Kz021tG4CQsq12bQSJY01yDzsQAuyklOXiKuHY9Xs/OvUhsutKNK6zDzMrerP7Qr35o=
X-Gm-Gg: ASbGncuNCqK3ZsAlA3Z3QenDKf7G8N1i00QD0X/8aIUCCxjxKDxiySA5Ua4keLmNRw5
	oNqKFRuM++UWG+FCc53+r0+R6Di34bKpf/N0dJNLPuZXt6iD/PpFRIVga4RhQMk4MeQoyltP1U/
	vpdDMcI/XcqSVn1UxJwtEImSP8pBii5/bCyrCUVIgIYY7d5am4Q144jZHZbXR+oGY21DqzHW+V5
	73RLelRQCSiBG2ZcO23+NaeVepS7aj7FaEEv3dYCKLPK+Uu5txIqESOTcdepcC+O/DSN7TwjUtp
	03HgBHAv6dkRIYrvDYn7fOoBcRO1eNl94y0MeuuG2sAgm3AZcIzKU1Wv93h0WP2b346cc80zmtq
	884HD9vu67F6lGFfEyo8ntJVRhy2XfmZkl5dgjjndE8CXdkZBnbhBPtajG3WJd8TZ2qxRh4+8gm
	s=
X-Google-Smtp-Source: AGHT+IGMp04zmiOU/hD8LCGYBTUQQCGASEAZAsC4+kzM41lFqGtljB8ajxnMiIjuotYviMNMQl6Bbg==
X-Received: by 2002:a05:600c:6308:b0:45d:da49:c47d with SMTP id 5b1f17b1804b1-474941ec4b9mr10454745e9.0.1761041535023;
        Tue, 21 Oct 2025 03:12:15 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::bfbb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4715257d90bsm189405475e9.2.2025.10.21.03.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:12:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Oct 2025 12:10:47 +0200
Message-Id: <DDNX3CCBLWXK.3KMVX9AKL162N@ventanamicro.com>
Subject: Re: [PATCH v2] RISC-V: KVM: flush VS-stage TLB after VCPU migration
 to prevent stale entries
Cc: <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <tim609@andestech.com>, <ben717@andestech.com>, <az70021@gmail.com>,
 "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
To: "Hui Min Mina Chou" <minachou@andestech.com>, <anup@brainfault.org>,
 <atish.patra@linux.dev>, <pjw@kernel.org>, <palmer@dabbelt.com>,
 <aou@eecs.berkeley.edu>, <alex@ghiti.fr>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20251021083105.4029305-1-minachou@andestech.com>
In-Reply-To: <20251021083105.4029305-1-minachou@andestech.com>

2025-10-21T16:31:05+08:00, Hui Min Mina Chou <minachou@andestech.com>:
> From: Hui Min Mina Chou <minachou@andestech.com>
>
> If multiple VCPUs of the same Guest/VM run on the same Host CPU,
> hfence.vvma only flushes that Host CPU=E2=80=99s VS-stage TLB. Other Host=
 CPUs
> may retain stale VS-stage entries. When a VCPU later migrates to a
> different Host CPU, it can hit these stale GVA to GPA mappings, causing
> unexpected faults in the Guest.
>
> To fix this, kvm_riscv_gstage_vmid_sanitize() is extended to flush both
> G-stage and VS-stage TLBs whenever a VCPU migrates to a different Host CP=
U.
> This ensures that no stale VS-stage mappings remain after VCPU migration.
>
> Fixes: 92e450507d56 ("RISC-V: KVM: Cleanup stale TLB entries when host CP=
U changes")
> Signed-off-by: Hui Min Mina Chou <minachou@andestech.com>
> Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
> ---

The vvma flush is not necessary on implementation that have a single TLB
for the combined mapping, but there is no good way of detecting that,

Reviewed-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@ventanamicro.com>

