Return-Path: <linux-kernel+bounces-736259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93013B09A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7021C4188F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE5C1DE2C2;
	Fri, 18 Jul 2025 04:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="IfIPHnpC"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E9517CA17
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 04:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752813898; cv=none; b=thcG1qZz57onmQn1BBidL9LIX1GmBq3CVEo4fvU8bE6do5yfnWYuAyJ/VDN4dxxJ3QG4aP/6XnN8fHCgnNyWBmTtWgqor9lfjBdxriFm8fnHZe/+HRuHg/oVbxWd084Khvo87Gk1dd1xC9GSt9kMcyaeBFt+a/rQhx1v17SI47s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752813898; c=relaxed/simple;
	bh=w/7oCVtNwSLYmdO52IwOKE+LWKzNYeup6Zag8FPSZps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=drZ8Ev9tDbVeNpCTsdjjkCA3Saeo4Rrayv4gZEnaTMIGXj5v3wCpokQ0cOKsMzlOWveM0UGK7RTRmCHb2ADjW8ZP/LDsBnuIIgyA615WiuQZRZ1oL7R5Qwaz+kxB8vTpOCQq7rBVeHGci2UcH+riC24OBfYE/bSgVrDACLkLM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=IfIPHnpC; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3e2953dcaa1so3713165ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752813896; x=1753418696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83O1oRzrZe3Tf7Tu6tuN/pr1ROh0NC7/xEo52yjes5Y=;
        b=IfIPHnpCl16Y66VtARHuK2s88cNz7MGUUJ16JjKhWMW0Etz+kfzVObcwbh7lI3NLXa
         gJ9QPCKi9K42ljzfK0iL3xUPTIoBSif/KHyRlSac3UDsfSwjDj3F6c+0dxhq9H4wfxN/
         tt4sieBuzyT74pltu6kDfinfYQyMN4HNK+qJEZJFDUIq1qmwYEy1PQAa2z0ZSsBhkK/o
         WT/F7D8uWyaqaS8Fm3S3R3deaOEtbCQGX/u/DFL48l+c2MxFlFEEFbaNQpGoSQxhgKqo
         6kOFXdTYsP0Lr+6fNcY7A1y0m32L74lH4ABf+6OBw7iAaWqtD2qrTdDPpzwzcq9Exjsg
         yI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752813896; x=1753418696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83O1oRzrZe3Tf7Tu6tuN/pr1ROh0NC7/xEo52yjes5Y=;
        b=TloQJCOqdRJoK8qwUrUPDdeLPEHqYZ5DW5nQCLVFDRL3BVsNyZDmtPzGXwq+OsWNQy
         jJ64lO5ybIX2BzX7gBKLwW/zoolOkNC8zG/rW84QWZJeWuNzVogjmfEORZvWCk+bS3g2
         6D9IB4eJmweBfcSvvfRQ9SrcMJMfTYFNCvuNItCXGugfO+rsxWqCdWfp/DGVtpZ+vz/h
         vymvGU4GDZXCMF7FDwvQxjaw6IMB2UbEBq5as9vSyt8se2NX7eq1ezXEAvKV6sKsyQtK
         b32w0mYuq0ozgGQcUBhOaAo9dlZLTStSzSBPx9fg+cV7l2r4bKqHbCrm5u66mXSLUb/R
         HiRA==
X-Forwarded-Encrypted: i=1; AJvYcCUQnqz4r7NzvfYavBmKAs/0uMXWwo9tptEpIcTygdzqo2tv0pK05+CFOxgezc+AGxlxBqxe2DQtGZwnNfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfDr5KtU6WfkBSxYujVZjVIVOFYom62uJoArNjZVZRiLtEto6H
	sm9jnsnM8l+OuyYlWWLn4VYzfvQSu2SuTD/S2e2PiqrT9qmK+PyS/P8wtXxD6d1jc6HAZhysTDx
	AcJiuvv0/mOB9GR2jUPmBRxKqYRQybccog+kyXit2MQ==
X-Gm-Gg: ASbGncuoe3sawuNB9gsqnuwIJzc+s8c4TSoTGpEr+6gr48XApnB7GBfdE4q7jn+oz0O
	DOn8te9AQivL2cHi1smsUmLjOH9a9sbUCNJrZjFKJ2JpS2QSl5hshhxuecr6QLvQgdoGbp7+nxk
	Qml2d6ivdvnL87yvXirlgQb0QXFmEI58LwwRHw6nAMbDEujnBDKiiFKudm4odA3jGBLod3wnzkd
	aa3fdeE
X-Google-Smtp-Source: AGHT+IEQ4otNtt6pp4gCO0IAJF0iXhgJzg+MtD1U6+aiOibg4+X80HGU1rRgRl9yQCkoPHu/mILJDq3l2KjWUtT69q8=
X-Received: by 2002:a05:6e02:3786:b0:3e2:9193:f37b with SMTP id
 e9e14a558f8ab-3e29193f441mr38720145ab.16.1752813895694; Thu, 17 Jul 2025
 21:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522-pmu_event_info-v3-0-f7bba7fd9cfe@rivosinc.com> <20250522-pmu_event_info-v3-9-f7bba7fd9cfe@rivosinc.com>
In-Reply-To: <20250522-pmu_event_info-v3-9-f7bba7fd9cfe@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 18 Jul 2025 10:14:43 +0530
X-Gm-Features: Ac12FXwDM51LcC52YMXP6x19jKkago_UCHpgC4vfOjbMUKEF0l7xeNYNTebWdEY
Message-ID: <CAAhSdy0t0UuLwBD5abY52dEaHtcai0uVDucY+vtrtxNj0uYQOw@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] RISC-V: KVM: Upgrade the supported SBI version to 3.0
To: Atish Patra <atishp@rivosinc.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 12:33=E2=80=AFAM Atish Patra <atishp@rivosinc.com> =
wrote:
>
> Upgrade the SBI version to v3.0 so that corresponding features
> can be enabled in the guest.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Extending the ONE_REG interface to allow KVM user-space select
SBI version can be done as a separate series.

For this series, we can go ahead with this patch.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/kvm_vcpu_sbi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/a=
sm/kvm_vcpu_sbi.h
> index 4ed6203cdd30..194299e0ab0e 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> @@ -11,7 +11,7 @@
>
>  #define KVM_SBI_IMPID 3
>
> -#define KVM_SBI_VERSION_MAJOR 2
> +#define KVM_SBI_VERSION_MAJOR 3
>  #define KVM_SBI_VERSION_MINOR 0
>
>  enum kvm_riscv_sbi_ext_status {
>
> --
> 2.43.0
>

