Return-Path: <linux-kernel+bounces-807079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2CDB49FC9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255114E39E8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66E525A338;
	Tue,  9 Sep 2025 03:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eLBG8Dh5"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E7258ED1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757387630; cv=none; b=IOsTOmWCSaB/5ICLhNlxlorr70Ip4RyiyzKYrigbaqIeuz7FzISdF9dLu3wZosM9NUon5a/1yhouBWqNYb3TYC7OlgOa8NtMsfu4esy6lzj4DM/J7Mk3/3JntfIrAOZhEulG3ykbsRZ+6Akwiazvy4V+PRc4pwCw1NE0I0SHy34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757387630; c=relaxed/simple;
	bh=4tnLzSgoyH5Nmr+fmB4heyANSklWEBYDavEKVFkzKtE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZfnOVkbveZ+DUZff6ZB09t5n05Htk29dv+HbDIdSLoD+LfHYg7h/F8z2oyiGTQdgweNsl+XjR8HlNmYTRG4wFYXvERU+VzmtKcyQ6ZB3rbQ/gnf8gt4M5H9oSA/eh2NlqN0yvoo2WF4gQco8wePRz20C+TRdyWGg36XxazkQqSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eLBG8Dh5; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-30cce872d9cso4719394fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 20:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757387627; x=1757992427; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4tnLzSgoyH5Nmr+fmB4heyANSklWEBYDavEKVFkzKtE=;
        b=eLBG8Dh5uERujYNt/ml0iVxFMY1RccYTVZUxEe01BRBgQSnexDuKZLtHreMNcxZtsO
         HmQQj+kkoDTtpyiLqmhu7thk8u9JNAHW753FKp+STG6Byg2cm19ljvdhxHNEpUBWo04i
         K9Gmyq51nguS5A8Fpcqeca147ic+uoXlPV/SyA9hlCMHKWLDdLEqKm5qQP6xxLyB0cMC
         /0yMWQaXPD3VjDG9jxtrCuu09Ip+VIzwhmGQCOnuS1baddIE/SVYnevLdzyR5RfdbVfk
         y17OsUz4LuZ+lP6wSAEjQ6dfezKpHRnwAR0Vj75YiVxsT1eSWhxM1J9UphFf2PVvcEnL
         cjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757387627; x=1757992427;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4tnLzSgoyH5Nmr+fmB4heyANSklWEBYDavEKVFkzKtE=;
        b=tZ9qwC/q4JWTcEZxubGet4ZFp/g07eYCndNqsYJ7RFa5tbf5Uk2lfdanRIteIqqKkf
         afegGhPWT9kGsi8j8o0HekGXixRZzO9vpxMaV72mLBySgH72IOMewBOf0L/ksO22PuAi
         HsIbKRLL5MnD17emxIFeZvmHInPCnigrjkoJbLUR0M+/N3P9iHwnmhP6fG1GR/Sa3KIj
         YtN2n3WiT6P87naI28GOosArEuARIrWVRKGWR072MmLyJyy/sDY78ppHOVK5LvxvwOcF
         NZUZQte56IFPbUBypMgLdQFoDWROJsBI4E/DPAQxc9kLREmEy9V6DgoPaXv+6zZw0eVX
         qoNg==
X-Forwarded-Encrypted: i=1; AJvYcCUmNMowYxBVAfF7loMj8GcHYeS1uRNi4xJnsDB+tFymhJioOvQuQHURN6TKpERCH3YHX+lKuZI4Rnzzudc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRhjhECNWgJU3ICLLiR7p0j6b+4WNYvzCJMeKHd7bmnlKUPImt
	KHiyQ+E12EHsqWSDViMcH0QOTpfllBcFFX7w0DJSAys8RXTuXFrvFbFPKIXIolnJm1M08EG3X3a
	SaaPeB6hRy/T39lNsv6JTM0e6Ee7LwEcPRQbpLdG+rA==
X-Gm-Gg: ASbGncvXE0QaPpmtE6XKw5Owh/aA0EiP1v8+BIbwOCHNVHfniss+8iLi2yp826/5+0X
	C0lW6Qu22JbQJZLRskhZ9k97zZ51dnLGjq5bAqcAHV9StALZb5x/iBFGsjOfCs7+VyE5ttLo2zN
	zD+dfJPkdKF06Ol9zBumR47PQVJ3TphNZY4SsUy/pEeViJ15cZcPLIXociVMlq3l8aVN/fCu34V
	qY4NEhNoBPQnU/5n0Tb047yzaZrWVA=
X-Google-Smtp-Source: AGHT+IEjRnKVoKvFFA+E6GmCVRCB5SlIscn/ZuyjOxoBfVf+jCSOBjaZ+L0Ztd/wOGk5yQEwow86CDzdQXH1tpXYsRo=
X-Received: by 2002:a05:6870:9713:b0:321:2680:2f82 with SMTP id
 586e51a60fabf-32262955201mr4819276fac.1.1757387627362; Mon, 08 Sep 2025
 20:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 9 Sep 2025 11:13:35 +0800
X-Gm-Features: Ac12FXyRlupJTj4FkuA2woE2fvmmsdddZIrbELQIbDuD4dgkvkFHAjvltNE7XBA
Message-ID: <CAEEQ3wmjRuC-Z1PRTw1chP40KXFksBgHu+dayjYA9KXE9Q0Cmw@mail.gmail.com>
Subject: [REPORT] Should rdcycle be deprecated?
To: atish.patra@linux.dev, Anup Patel <anup@brainfault.org>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, 
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Hi All,

1. To use rdcycle in user mode, one must first go through
perf_user_access. However, in reality, the return value of rdcycle
remains unchanged. This is because SBI_PMU_CY_IR_MASK in SBI includes
the bit corresponding to "cycle", and the kernel's pmu_sbi_stop_all()
function disables the counting of cycles.

2. Currently, some application software (e.g., DPDK) uses the rdcycle
instruction. In fact, rdcycle is affected by WFI (Wait for Interrupt)
and CPU frequency variations.

3. Some applications mainly run on server CPUs. Therefore, the
precision design of rdtime should be higher. For example, the TSC
(Time-Stamp Counter) of x86 architectures is generally around 2 GHz,
which can meet the application's requirements for timestamp precision.

4. What are the future plans for rdcycle?

Thanks,
Yunhui

