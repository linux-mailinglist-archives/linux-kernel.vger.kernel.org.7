Return-Path: <linux-kernel+bounces-824104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235A0B8822F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D3E521971
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D137A29D264;
	Fri, 19 Sep 2025 07:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="BW6jO6fA"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C010B287262
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758266286; cv=none; b=tUkCPJqViptN+A+ZjykSm/mqKziX3o4Row1ghsNf9JZA0YSlfKIX7fJNRSDpQfhCp4l6r1NEbDFfOMHzNJcWRs05Hsf2olt7GFi9QOUsNyxAKMAsRvlTOKkefAmDqwqB3nnQvNQ9HcaJEvt3uK1wlBhk0CD4tpIa15kPZyWEEKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758266286; c=relaxed/simple;
	bh=OhslTkeBWpnWawE7wRgxWE+TZwArFGDjrgtCV8NjvXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VNUGdDyhYkBN5FygcDuLgb/TZeeKPGiUJUBMR/yPywH/5hMdWgVNMGeZ2bRft2sWQGOGhG+oCDmmK8VsuO3aj5HvCY/Fw3WKlID1E6Y1LvRhqBRHwWT+AMXijwUFh/gBHKh/RcUwfrfO/n5h5SPnZBr1oNOUI2qWnvtuEfA1sTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=BW6jO6fA; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77da29413acso1554332b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1758266283; x=1758871083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Elc3LlmJxWrLOLFn+TT32evVZ4EsvzwpLcFPfR03Eis=;
        b=BW6jO6fAi+8uIbKVENtjOOW2H2/JczZ6MITHAE/IAcSYz4tapsUZ0XBr5PI1OoQAdj
         oArEJKDiSn/ptCOOOjep7in1D5l/tnsvUfluSX4puwsmGzsb/9w1uZ39NjQZx4lD6d1o
         BvtmZjVR6PbcnIh56VZL7y8xSl4DoyNLGk95+cd8SxAppMuJR1bLWu9P+RZiBn00o9eS
         6aHAaBq/aMm4oRrZkGRj+/o6w8C15BzS9+oSqRiWHouNrWWk4a+AEFZRXDOsYmXbdbdD
         GUKKrtzbWopqmaCP+8mS4/g/fqi/od5TBwtpn+SB/51RHP4T3EbEpS6Y+8JO60KTjWnJ
         iHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758266283; x=1758871083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Elc3LlmJxWrLOLFn+TT32evVZ4EsvzwpLcFPfR03Eis=;
        b=U98ke1SBT0NsZEDX9Msnp2hVYzJgIsRdXj/NyIfsQ2lGih6weVBo4RsJ4cn6p/WUkf
         WPzc1JaXStdCe73IvviPlpnIecUCv/oI8BFrb+yC6oJ6yhOZcoS3ep5tHEtCG3tXbIM4
         BoXRy2xq2weitxRX9o+cMVMOzwEWO/IpPKr2bDx0//InQccUSbY+AdPlY3uuS4qVgFTw
         PQcJFJqE3ZsAm/MALiY787WSKYy2FNcd4CT3G3okSsoYpYZyLsPYrQKNnYvGLJQpoFIb
         LD2n/b93WT/+T/PPdi4l5/qsYWZI/bvSsAQ7/nJSM7uv26WmzUighZSQWWaaGYG581n7
         6Bkw==
X-Forwarded-Encrypted: i=1; AJvYcCVYttgfHx0VZuYOlS2mhUYcA2BD9HfbN9z2ANOz3Ig2ErQPfzD7GXhxTopmG1dZzTL38ioK6131yNT25pc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrl2zWcmL6j4y545wiSE0RLMpdxuolsqQpEN8D1yUQWnJZrCCl
	j+U0aNj6KEyhXYZydq/GLqq/OPDHWBC+lhfHSzbG5+47AOrTo+cWXjdF6asCiVXlwQU=
X-Gm-Gg: ASbGnctlF2pJ05CGlC21P46bIQX3/zFwNPuKfCP8xj0YUPM3ycCy8D62VSKcTXnVGZ5
	qYXA9Q2DBymI3sWeVfK0mNred02an+Bb5rgUqwNrmLdBy8OfX1hiPz5GcS9iQEHAWwwb034l5VO
	3fKkdvu4EsBMSFOKTiUFZU54CikkfNjlh3xMcYSqmH3mCSkiy0aealkasuUlsjF+CVmX7JFMQ9Y
	ODnVpqUJaoZpPdfFaNxkLM3xcoTRmyLGLqJflQpKYZqSCRQrWBWlD2mBS/pm04NnSMfGPirHyN2
	Q5sRofAFxhzTqy2znMiE8+2a0M1G+DIBIdgQIZtA6atePRpIEnScZoQ/pTt6s/mHl+jdbYDiKeJ
	TC3qCh/yG6aiaMTiANnfA0AdBLSwobVI+Hp7q6F0shBjBWMOxyXlw+qIGlZgvc7a4kzE=
X-Google-Smtp-Source: AGHT+IFREcj7LgmwxdyNVkaDM0mx9VSkGqCRLXAZD26y/lYkInopAdg+s1pF+t7NPUl9mhmCj7A/5w==
X-Received: by 2002:a05:6a21:6d9d:b0:244:aefe:71f3 with SMTP id adf61e73a8af0-2925d0db79amr3879785637.14.1758266282535;
        Fri, 19 Sep 2025 00:18:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff4004d9sm4285297a12.35.2025.09.19.00.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 00:18:01 -0700 (PDT)
Message-ID: <ae93899e-372e-425a-ae23-deb4bbab3eeb@rivosinc.com>
Date: Fri, 19 Sep 2025 09:17:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/1] drivers: firmware: riscv: add unknown NMI support
To: Yunhui Cui <cuiyunhui@bytedance.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, conor@kernel.org,
 atishp@rivosinc.com, ajones@ventanamicro.com, apatel@ventanamicro.com,
 mchitale@ventanamicro.com, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250919070048.94646-1-cuiyunhui@bytedance.com>
 <20250919070048.94646-2-cuiyunhui@bytedance.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250919070048.94646-2-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 19/09/2025 09:00, Yunhui Cui wrote:
> Unknown NMI can force the kernel to respond (e.g., panic) when the
> system encounters unrecognized critical hardware events, aiding in
> troubleshooting system faults. This is implemented via the Supervisor
> Software Events (SSE) framework.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/include/asm/sbi.h     |  1 +
>  drivers/firmware/riscv/Kconfig   | 10 +++++
>  drivers/firmware/riscv/Makefile  |  1 +
>  drivers/firmware/riscv/sse_nmi.c | 77 ++++++++++++++++++++++++++++++++
>  4 files changed, 89 insertions(+)
>  create mode 100644 drivers/firmware/riscv/sse_nmi.c
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 874cc1d7603a5..5801f90a88f62 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -481,6 +481,7 @@ enum sbi_sse_attr_id {
>  
>  #define SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS	0x00000000
>  #define SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP		0x00000001
> +#define SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI			0x00000002

Was this submitted to the PRS WG ? This a specification modification so
it should go through the usual process.

>  #define SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS	0x00008000
>  #define SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW	0x00010000
>  #define SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS	0x00100000
> diff --git a/drivers/firmware/riscv/Kconfig b/drivers/firmware/riscv/Kconfig
> index ed5b663ac5f91..746bac862ac46 100644
> --- a/drivers/firmware/riscv/Kconfig
> +++ b/drivers/firmware/riscv/Kconfig
> @@ -12,4 +12,14 @@ config RISCV_SBI_SSE
>  	  this option provides support to register callbacks on specific SSE
>  	  events.
>  
> +config RISCV_SSE_UNKNOWN_NMI
> +	bool "Enable SBI Supervisor Software Events unknown NMI support"
> +	depends on RISCV_SBI_SSE
> +	default y
> +	help
> +	  This option enables support for delivering unknown Non-Maskable Interrupt (NMI)
> +	  notifications via the Supervisor Software Events (SSE) framework. When enabled,
> +	  unknown NMIs can trigger kernel responses (e.g., panic) for unrecognized critical
> +	  hardware events, aiding in system fault diagnosis.
> +
>  endmenu
> diff --git a/drivers/firmware/riscv/Makefile b/drivers/firmware/riscv/Makefile
> index c8795d4bbb2ea..9242c6cd5e3e9 100644
> --- a/drivers/firmware/riscv/Makefile
> +++ b/drivers/firmware/riscv/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  obj-$(CONFIG_RISCV_SBI_SSE)		+= riscv_sbi_sse.o
> +obj-$(CONFIG_RISCV_SSE_UNKNOWN_NMI)	+= sse_nmi.o
> diff --git a/drivers/firmware/riscv/sse_nmi.c b/drivers/firmware/riscv/sse_nmi.c
> new file mode 100644
> index 0000000000000..43063f42efff0
> --- /dev/null
> +++ b/drivers/firmware/riscv/sse_nmi.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <linux/mm.h>
> +#include <linux/nmi.h>
> +#include <linux/riscv_sbi_sse.h>
> +#include <linux/sched/debug.h>
> +#include <linux/sysctl.h>
> +
> +#include <asm/irq_regs.h>
> +#include <asm/sbi.h>
> +
> +int panic_on_unknown_nmi = 1;
> +struct sse_event *evt;
> +static struct ctl_table_header *unknown_nmi_sysctl_header;
> +
> +const struct ctl_table unknown_nmi_table[] = {
> +	{
> +		.procname	= "panic_enable",
> +		.data		= &panic_on_unknown_nmi,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
> +};
> +
> +static void nmi_handler(struct pt_regs *regs)
> +{
> +	pr_emerg("NMI received for unknown on CPU %d.\n", smp_processor_id());
> +
> +	if (panic_on_unknown_nmi)
> +		nmi_panic(regs, "NMI: Not continuing");
> +
> +	pr_emerg("Dazed and confused, but trying to continue\n");
> +}

I'm dazed and confused as well ;) What's the point of this except
interrupting the kernel with a panic ? It seems like it's a better idea
to let the firmware handle that properly and display whatever
information are needed. Was your idea to actually force the kernel to
enter in some debug mode ?

Thanks,

Clément

> +
> +static int nmi_sse_handler(u32 evt, void *arg, struct pt_regs *regs)
> +{
> +	nmi_handler(regs);
> +
> +	return 0;
> +}
> +
> +static int sse_nmi_init(void)
> +{
> +	int ret;
> +
> +	evt = sse_event_register(SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI, 0,
> +				 nmi_sse_handler, NULL);
> +	if (IS_ERR(evt))
> +		return PTR_ERR(evt);
> +
> +	ret = sse_event_enable(evt);
> +	if (ret) {
> +		sse_event_unregister(evt);
> +		return ret;
> +	}
> +
> +	unknown_nmi_sysctl_header = register_sysctl("kernel", unknown_nmi_table);
> +	if (!unknown_nmi_sysctl_header) {
> +		sse_event_disable(evt);
> +		sse_event_unregister(evt);
> +		return -ENOMEM;
> +	}
> +
> +	pr_info("Using SSE for NMI event delivery\n");
> +
> +	return 0;
> +}
> +
> +static int __init unknow_nmi_init(void)
> +{
> +	return sse_nmi_init();
> +}
> +
> +late_initcall(unknow_nmi_init);


