Return-Path: <linux-kernel+bounces-895948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C758C4F575
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26BBF18C1860
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40F33A5E6C;
	Tue, 11 Nov 2025 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWTivq5a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWaM8By6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06943A1D1B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762883765; cv=none; b=mXLN113qLbRX5ZGI+8ZTwAe9ydcjHjZv2dHILknZx0YWrY51zXIbqkU0x3nC7vpUHn6F3BVttw4jHNabL6ls9XgHYhXn+E7jI/zSmmo3LbPRiS5uwhg9iiBT2Za8bTSvd/6MYkZgli/wGRqtpsawVqaeb0CFvA2cYVEReSpStb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762883765; c=relaxed/simple;
	bh=xRbkyTX1fJw/xyprWtN1kMSYrUOxW+P2z/B7LlIHjac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7O4ast9yBuBU4pwTUAc7UjLdLA6gjBpxvu34T18pTWfUrtw4emLHpgvq4y0OTNylvMh4HNAlB0wziRwE4qrW4FWiupl4lydHId1rp7xN30cVjGgAGOK2wZHYv+vQRA+QlX3o3w3cVPs5tetzM8SHi3CkA/NETpSuk7GglOteD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWTivq5a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NWaM8By6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762883762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fNlxVhI2wninSgC+yfdHHvz7AE8gBjF6ZWWgDwooKq0=;
	b=ZWTivq5ar795id6eONsTpoQj93MCLyduir2t4CR2ZspuFVr8WINZgKd0gw5wuylU/vG2aE
	EOi5PYukKyZo/3G7AlRAP5n0wBD++QrOjsUpCz+WawRi6JC4eKBfnwfhwJkD6YxDMPtv3D
	0QcwB4BzWH3KwgrzfZx6R8iQqDur9tM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173--SjUHDTOPEOk5H1zBsXymA-1; Tue, 11 Nov 2025 12:56:01 -0500
X-MC-Unique: -SjUHDTOPEOk5H1zBsXymA-1
X-Mimecast-MFC-AGG-ID: -SjUHDTOPEOk5H1zBsXymA_1762883758
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4775d110fabso277195e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762883758; x=1763488558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fNlxVhI2wninSgC+yfdHHvz7AE8gBjF6ZWWgDwooKq0=;
        b=NWaM8By63//er93e+2uSd1fc0dyjoM78C7gvWSzB2kayKUQzw/CTax2Xuk/Iv+Z48f
         /rBtZX88gQ8I2iu9UjP+tfyI1BEDAJuObZfQSnuIwAoyCn+EMBSnkwtkR/wL9HTdDFwi
         QwGwmgjHW0BSImbcMvf8jEhSsBHYw7r5xI1eA97SGKWIHaz7Dre0MSXZ3S6Wtju59kmD
         ix9CwihR6sHDHZkgYXyl2VQNyYVt/yPQnrk8i00SLjrqf1e4noncWXoxOsLFdPMuignd
         0aob35nCeBXpmKRSrZYSeNSiT5WrgCk3kR2+E/cHfEpojOzMIbTi+M4wK7sYz+3d/nMD
         uDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762883758; x=1763488558;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNlxVhI2wninSgC+yfdHHvz7AE8gBjF6ZWWgDwooKq0=;
        b=pkQYWb1xixOwOMzdnYc0GCTs4p6NGmbVU4utWWJtvKBBHx4XfGZp7YGKaeG5VYN3LG
         fapxhBwVpDPWzk8P9xDF+c5n0H/wvuatdWCdi60VMDA2vgKujWNyomEZREZ0oPPIwY6x
         +ONJ5AlERc7jsuXJlzeC5CRwVh9tEQG4R34YEHzo81F5FMax2qdg0o82nRYM3iJQG7Ck
         WZZDTX79g6LYPa7xrF7OSgviIVyPVak3iPN9NXtvdLBjm0slC0Th0ARGlKjJO8pdsHGW
         jbPmRGpZODACB1I4JlyUxxTU4LsyQamIlRfe2fn9S0g8Z1aRVvHebBZTjvCh3LdX50X+
         hKnA==
X-Forwarded-Encrypted: i=1; AJvYcCWc2U8LWaHiPB1dst7WhJaQ7xnoprLeiePNx4BdHsvn2akuSW+P9WGhEk54BXfPk7HVnnBroLNhxNVq5dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAVd58G0YebCaYQvwTDCN7MZKFyfAuZhQs8/sFk8au69KC8pvi
	YIgcv6D3axxgCis9h/ntLhHo40xI557U/R38ChSpQDZDXPD3+YcxThWXI//BOHHjVZaLeAfCrDE
	v+hEUh/MIrBLhaUl6/tXWyu20M8TYbIA5OiYLgwXgGxOikNrFEKvDiIk1Z7HfT2PRVw==
X-Gm-Gg: ASbGncuVLr3dNi4HAh+JmJkOVRIwE9ROxC1uXmbGgkrdoGqgYM+HeiHU4n2+SXdQCAJ
	RaCJ5mxIZRjLQFWp53KuadD+tLkydwlr4i9oDYC6sAxFKbyfclA4P/74OfMA4EKh/2W9kVakSiD
	Nj6znig4kUNV6YQRnIDtsw24EOruIU4oP2QVSqcqoCS+yjgtsuLZIvHMUqn5GecewtdwItA5xE3
	l3te72HyfYgKu++Ufos+GUTd4H/BqyTQ26ZW0yXaR2kQmcI+LGnLJn2BGPjstevsbg6EHIgOGIy
	atS1fju1S9w56L91GampN2MFZglBqBHRIrXdY9SDK2iaYzrkekwIuD5lKMSuGHbQfGjbV7SVv24
	6XyUKE0uPMfK18hv0jU0ZcKqzahm4Ar3j2MfwaT/Xez+HVLX7IyfX+dusicXfVBFQk6QpmIyU/v
	Et3B6vxA==
X-Received: by 2002:a05:600c:1f0e:b0:476:84e9:b571 with SMTP id 5b1f17b1804b1-47787049ddfmr2552515e9.14.1762883758434;
        Tue, 11 Nov 2025 09:55:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtX2Hn3jD1AkyTxJ6T5fTcMIWn87gWtGe1QJBHyjSwpsjpLajTE9QnPUWyilSIkap92vR8PA==
X-Received: by 2002:a05:600c:1f0e:b0:476:84e9:b571 with SMTP id 5b1f17b1804b1-47787049ddfmr2552275e9.14.1762883757974;
        Tue, 11 Nov 2025 09:55:57 -0800 (PST)
Received: from [192.168.10.81] ([176.206.111.214])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47782ceb0f9sm42703475e9.4.2025.11.11.09.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 09:55:56 -0800 (PST)
Message-ID: <6a093929-5e35-485a-934c-e0913d14ac14@redhat.com>
Date: Tue, 11 Nov 2025 18:55:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 16/20] KVM: x86: Decode REX2 prefix in the emulator
To: "Chang S. Bae" <chang.seok.bae@intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: seanjc@google.com, chao.gao@intel.com, zhao1.liu@intel.com
References: <20251110180131.28264-1-chang.seok.bae@intel.com>
 <20251110180131.28264-17-chang.seok.bae@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251110180131.28264-17-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/25 19:01, Chang S. Bae wrote:
> Extend the instruction emulator to recognize and interpret the REX2
> prefix byte. Also, detect and flag invalid prefix sequences after a REX2
> prefix.
> 
> In the existing prefix-decoding loop,
>    * The loop exits when the first non-prefix byte is encountered.
>    * Any non-REX prefix clears previously recorded REX information.
> 
> For REX2, however, once a REX2 prefix is encountered, most subsequent
> prefixes are invalid. So, each subsequent prefix needs to be validated
> before continuing the loop.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> ---
> RFC note:
> The REX2 decoding itself is straightforward. The additional logic is
> mainly to detect and handle invalid prefix sequences. If this seems
> excessive, there is a chance to cut off this check since VMX would raise
> '#UD' on such cases anyway.
> ---
>   arch/x86/kvm/emulate.c | 24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 9bd61ea496e5..f9381a4055d6 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -4844,7 +4844,7 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
>   	ctxt->op_bytes = def_op_bytes;
>   	ctxt->ad_bytes = def_ad_bytes;
>   
> -	/* Legacy prefixes. */
> +	/* Legacy and REX/REX2 prefixes. */
>   	for (;;) {
>   		switch (ctxt->b = insn_fetch(u8, ctxt)) {
>   		case 0x66:	/* operand-size override */
> @@ -4887,9 +4887,20 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
>   		case 0x40 ... 0x4f: /* REX */
>   			if (mode != X86EMUL_MODE_PROT64)
>   				goto done_prefixes;
> +			if (ctxt->rex_prefix == REX2_PREFIX)
> +				break;
>   			ctxt->rex_prefix = REX_PREFIX;
>   			ctxt->rex.raw    = 0x0f & ctxt->b;
>   			continue;
> +		case 0xd5: /* REX2 */
> +			if (mode != X86EMUL_MODE_PROT64)
> +				goto done_prefixes;
Here you should also check

	if (ctxt->rex_prefix == REX_PREFIX) {
		ctxt->rex_prefix = REX2_INVALID;
		goto done_prefixes;
	}

> +			if (ctxt->rex_prefix == REX2_PREFIX &&
> +			    ctxt->rex.bits.m0 == 0)
> +				break;
> +			ctxt->rex_prefix = REX2_PREFIX;
> +			ctxt->rex.raw    = insn_fetch(u8, ctxt);
> +			continue;
After REX2 always comes the main opcode byte, so you can "goto 
done_prefixes" here.  Or even jump here already; in pseudocode:

	ctxt->b = insn_fetch(u8, ctxt);
	if (rex2 & REX_M)
		goto decode_twobyte;
	else
		goto decode_onebyte;

...

	if (ctxt->b == 0x0f) {
decode_twobyte:
		...
		if (ctxt->b == 0x38 && ctxt->rex_prefix != REX2_PREFIX)
			...
	} else {
decode_onebyte:
		...
	}



>   		case 0xf0:	/* LOCK */
>   			ctxt->lock_prefix = 1;
>   			break;
> @@ -4901,6 +4912,17 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
>   			goto done_prefixes;
>   		}
>   
> +		if (ctxt->rex_prefix == REX2_PREFIX) {
> +			/*
> +			 * A legacy or REX prefix following a REX2 prefix
> +			 * forms an invalid byte sequences. Likewise,
> +			 * a second REX2 prefix following a REX2 prefix
> +			 * with M0=0 is invalid.
> +			 */
> +			ctxt->rex_prefix = REX2_INVALID;
> +			goto done_prefixes;
> +		}

... and this is not needed.

Paolo

>   		/* Any legacy prefix after a REX prefix nullifies its effect. */
>   		ctxt->rex_prefix = REX_NONE;
>   		ctxt->rex.raw = 0;


