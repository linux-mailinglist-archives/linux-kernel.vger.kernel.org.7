Return-Path: <linux-kernel+bounces-740543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A253B0D582
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2FF3B072F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFF52DAFC5;
	Tue, 22 Jul 2025 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8hY933x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A252DAFDE
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175629; cv=none; b=LJVl03oHstMU0RgTgQcBQYoe6T2kiGgC0If8dkxrCw7KtTfIkQsT4QxZYGvtsPl6huBCAIBc4D/jO9C4+WYrs5Q7XkA6EMEdy9kXI6Po9Gv+VU6cbx3/Vel7lM0izv2OzrSBIZep/wIK2W5IemEDtBgyt/gPMOw4ZzW724iBu0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175629; c=relaxed/simple;
	bh=B2n5ZdY4BWnmq8dgSRdoBM07oIPGeT0nJh0yRSNPcDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSqd3UFBHGjWnUcuNWtpVt9PuV9H7oWVcptHyLWVQ1dHiCcRJ7nuBbhQptPlmDF8zpXP/SziLOl3jsxOGbgGh78dORpqGsWwpJBHG7t+cjEjiDRJq5Y00H/m/aTMjC9ohds6n6rgVygki3fnjd8mm9bnAHqzDHzkRNRTUmgWucw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8hY933x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753175626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8KUgQFDAP+t55lsxkHmzTDmsyAfOdX9/W5yq8F7vE3o=;
	b=E8hY933xzig0alikiRZ3QEqhCQvS6Rr82qB+gfYmNoxt6JOPOy7B0z/7fhB/7QtvhfrTBc
	8goONBmb7d/rlEedMFVFZ+O2nu5zWlxJjz+30qLQQVQLCn3uMLvw9trQgTEF03Xuc1vhWr
	DfRbCO4RMCq9XOzP04QcPnUCQz13lIQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-BxHftbgBM9G2qVgENbYPzw-1; Tue, 22 Jul 2025 05:13:44 -0400
X-MC-Unique: BxHftbgBM9G2qVgENbYPzw-1
X-Mimecast-MFC-AGG-ID: BxHftbgBM9G2qVgENbYPzw_1753175623
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45626532e27so35176355e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 02:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753175623; x=1753780423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8KUgQFDAP+t55lsxkHmzTDmsyAfOdX9/W5yq8F7vE3o=;
        b=vCcJ7R2N51t5zVatBwBXFScrSvJAsTXyDYokxLGogF32fa25oOIj9rf3vXhGTLJxuO
         SErfbwj1KgMHh6IJux/K6obVGtAjfCO+Hw+ZbuWFVS2qsbMBQYHI1KeWMlnUTXLQmmaY
         AGQ6bpixGXrMMty7X2NRgodRTED3XAD7kedSKjK780Orc+pz+zXFLClSWmVDtYi79bR/
         BoA1IxyKtFrAF8YB/NXjPrKP0Ci7P9LZAqJv3i9jhq5zzCbdxbiQZMIvceg5Rko+BKov
         xadIEZYTnweJiw1JeW6qoEqjuob4Go9/b3wV9sNzKUNoQm2V3/9p6wUEK/KTrEYvLGV6
         eNaw==
X-Forwarded-Encrypted: i=1; AJvYcCUTOeP+Vr5uUcshoFmm2GJAKdyNphw9/plO5iB1o/O75MUT6eDf4KfWuwHK3nYw7N6btcxmhCNwORQYu50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV3fdHTk++MRxZRlNg+PdG8w+URNDkERZGKY4hszITG6irgfcU
	o02dipXpE/YClLBjOy878LrrIXXDdmqLRj86eQEr4Koyg7aQb5SnjdHZWREdg7aA0yXh1Dlh/Dm
	qne2Mk6w5mqfPMMJHay5N+MqE5USLaatQN97PB5X298RePaPTN0Lx1B02vhTfg4qbACixfLSf5A
	==
X-Gm-Gg: ASbGncsUoeH0aYdqjbrCKIa/upfOZYNcQUfjAWnqoF+cMwpVFEF0l30x5CdDTQG+JzN
	n44rNJJprzY8gMO8wW0nnM2/A7asbal+ycca+506ZfM1a3+W0uFmlWJ9QMWooihdjPnffuTD82U
	q6sxfCb5a8PTj7lR62inouaSTjBsAqXFvzjcx/nfImCJqp/6RpX1ECMsGC8JjluB7NsY78gkXWw
	ENRzZry7WvGiQXby/zYTNzLz+iMUGhZHwqmK27gds0bq7tNqEgk+TwNl95gCP/UQ7ILysIwBcp0
	k/OTjfiwJyOMUF6BBL/IK/GwztH57xmFm7PjpCrQ4YW23DdfNCgZDsypB0D3LBmln42JLhPpNkW
	OdlSIu8ZEmSc=
X-Received: by 2002:a05:600c:64ca:b0:456:1d61:b0f2 with SMTP id 5b1f17b1804b1-45630b6d6dcmr221103205e9.30.1753175622748;
        Tue, 22 Jul 2025 02:13:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq2utjYDgYZbdBZDFtzvubW3FftekBDVtDRK28fBpcCfuSioqYjLDM06EFbnwhSuf99i7wcQ==
X-Received: by 2002:a05:600c:64ca:b0:456:1d61:b0f2 with SMTP id 5b1f17b1804b1-45630b6d6dcmr221102735e9.30.1753175622268;
        Tue, 22 Jul 2025 02:13:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45862d6908fsm10825645e9.1.2025.07.22.02.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 02:13:41 -0700 (PDT)
Message-ID: <49c4e674-ab1e-4947-9885-5c73810368eb@redhat.com>
Date: Tue, 22 Jul 2025 11:13:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] ptp: add Alibaba CIPU PTP clock driver
To: Wen Gu <guwen@linux.alibaba.com>, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250717075734.62296-1-guwen@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250717075734.62296-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/25 9:57 AM, Wen Gu wrote:
> +#define PTP_CIPU_BAR_0	0
> +#define PTP_CIPU_REG(reg) \
> +	offsetof(struct ptp_cipu_regs, reg)

Minor nit: no need to use a multiple line macro above

[...]
> +static void ptp_cipu_clear_context(struct ptp_cipu_ctx *ptp_ctx)
> +{
> +	cancel_delayed_work_sync(&ptp_ctx->gen_timer);
> +	cancel_delayed_work_sync(&ptp_ctx->mt_timer);
> +	cancel_work_sync(&ptp_ctx->sync_work);

You need to use the 'disable_' variant of the above helper, to avoid the
work being rescheduled by the last iteration.

Other than that LGTM, thanks.

Paolo


