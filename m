Return-Path: <linux-kernel+bounces-895871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2294AC4F25D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75AE618C0FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40288377E85;
	Tue, 11 Nov 2025 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1js4xGl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUXpbIAi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC636A022
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880141; cv=none; b=eVKvyZvHz07BPdoN0IlAD3ytnL7sR7RPDVd1JT6kCg1uTJQzMN4hgjytiEpejtNpQR3aPU0CsMbT8WQZVKZYOUBx3EgSXBTlW5c/yAKS747V64Ek9570TawmuVdF1ifKDwCLyNR+dz2LnnfbEu5h2h4ySzryQ9mQ+7fhWcPAhIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880141; c=relaxed/simple;
	bh=nlEfTmws0Q46o78NUfhpjE3w9PAskdTxv3a88lJzlpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aexdao6X61C0EzGiU3zbtq+o/0C7sv2Tv+DngggXam72aG/rDZLJH0Bxc95B4wKbH3UkSVHk3SqJRAlE1+Pgmv/Isbpk/APhJ/JJeIVRQ88GKF5cP2/x/5apftof2B47OAwq0zBBv2C8zpTbYtSFxcrKN/RUIWt98IuFYnWIcoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b1js4xGl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUXpbIAi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762880138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gnMIv0Ik+hITHUqF7t+6yoyTUpUVXjJtFWV6UcASCo0=;
	b=b1js4xGlbKUSGz3rtJp2zOMe8x77+rZvE9HrYlFpounWmIxWIVhPEEvg2/u/pRLK10kMeR
	4eHkveRNxwVdZH0rMP4knXLirU8D1qyZdqH1VMTZ9wYaIPP17qbToIiSwnX7v+ikzAizZc
	/fdNd4cw6zo7jRyuK0fk6xt7t5VYKRo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-R3_Xg6a5M6-zXB7nCWX3Ng-1; Tue, 11 Nov 2025 11:55:37 -0500
X-MC-Unique: R3_Xg6a5M6-zXB7nCWX3Ng-1
X-Mimecast-MFC-AGG-ID: R3_Xg6a5M6-zXB7nCWX3Ng_1762880136
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b2b642287so1781786f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762880136; x=1763484936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gnMIv0Ik+hITHUqF7t+6yoyTUpUVXjJtFWV6UcASCo0=;
        b=BUXpbIAi4TzFpdEinFY81Q/MYpNv6s5W/kRxFAC2GPgT7AgQrAa/1YnyGqPT3NFvkw
         RsWZE5KdNsBPHD2MI8FEc5jQIn0U33eqJQIyG/fZqzxUjeYQb2LRVG6SHqXHFhFQdS1t
         RMXcVziQkC6+eJSDzaNpLA64Z1Rkc6Yqyw5whMW9VqCIhTTEcXe5i56TYp+nvY+WOJi7
         QOR0RCsZXYCKozEb7Nnn/r/VqMaviS02n5VsrjjEu4iXPFMBI6kwHppk3cOu2waqq5C4
         1KvkFRtQ36rXZyD75aYAXD3A3WNJKyFImc6D+5NMLWo59Cau91HXleSnPYVO4nGK8jYk
         eJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762880136; x=1763484936;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnMIv0Ik+hITHUqF7t+6yoyTUpUVXjJtFWV6UcASCo0=;
        b=rh8K2o1+SSgxzQichFIRIr8GdUT51T/ZjEhP3JtqQdbz5Yj2v7dWveaagaPo9PQRd2
         TU/NicQg2M+qOu+rnI35KCoHGbzxGWP7QI9p2D2yimo1fFyGLo+BLl4+HMLXtQFMGVFU
         3BFLPiWwYY9bdPDupY6fHX9CWA1Q2/xhwh9AtirHg32wfNtZltdWpQ4UU0/W+mxx57S/
         UiFnKhWZ4mbIlWDs5cuD7s8ZA9LGry8+RDx3pMQBQrkOyybosl5VlCc69lG4xAHsMDxD
         YbEsb+S33/pWOC1aMfuKLfonrgqHmCn3YwxXJmoQaTG+dy/7va4gA4pgVlVlQ6TsHEtn
         Dg0g==
X-Forwarded-Encrypted: i=1; AJvYcCW0FA8FzJ8OeGILR/0PMZ4bbFArnoRKQu5XsgqUvnunYWbK85PLqEwGpSWOU7aBxjVoxQCAAfPUzitDjB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRySnRBh7WLI2RjYlwx9Vm7l3eyRSpJ680/EFoUrxkSNgYRE0t
	pGCA6X4RtLm0mhv9MvjptffaBl5xWGaHBPQsobcOOcXUUJRZF9OILZ0LL2RHpYdZE5OZl4n/xIY
	72yBgo0+9wx8qFxH1o1TEKIXqiPp+qBmh5Yi4Y4wAytFtbSK2GtSjwv87U/f4ij4UHw==
X-Gm-Gg: ASbGnctc2H04a0qzD94Z7vJAR3fBTJr/miE010AvTKnqTNB0ZM9sGbS7rjH53GVTZ1w
	4IHAmY7/Yc1jn1+u1841UQ5hbUVi97dPWsig+McMN3+Z7Et6mpkU4xgb5vQyyjgHxGzswMb43J1
	2tSuLLScL/rAbwfOrzCBj/QOJ+KN6djRIkjDY1uf3pz4axxtakb3Ks/5Pp1Jqw+PxbXuzhUnP9m
	QKR9O3szcJRaWQvuKRrjOTMPMhmdoED3oYWj7zOxoDum1n9iHYRa2jPndhUGkrdUgwoOZl289WM
	fWX5DZ5v1LZFNASdsYvju3OCOdaFr6IoXjVp4UO4J1n/TwqfuktqO+DFIWHIw05yoWg7UNqesUj
	vEC/oNFW4uivEW2TBMDrtg3a6vPxM47+4UtpRn6Fn7U3JLhIf/Pr2JAmhBlb6NwCzLSTrvNqU07
	zscL0Eyg==
X-Received: by 2002:a05:6000:144e:b0:42b:3bfc:d5cb with SMTP id ffacd0b85a97d-42b3bfcde1bmr6451770f8f.51.1762880136107;
        Tue, 11 Nov 2025 08:55:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwXz8O+8CJxSCaosY+x8WzSmDIqFBYmIyaTJkW/+khTeoschvxJNMBqDWOCSADXh+6y0zXnQ==
X-Received: by 2002:a05:6000:144e:b0:42b:3bfc:d5cb with SMTP id ffacd0b85a97d-42b3bfcde1bmr6451748f8f.51.1762880135650;
        Tue, 11 Nov 2025 08:55:35 -0800 (PST)
Received: from [192.168.10.81] ([176.206.111.214])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42abe63dfecsm29514102f8f.12.2025.11.11.08.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 08:55:31 -0800 (PST)
Message-ID: <0de0215b-6013-4565-9cda-92a7b6f8c34b@redhat.com>
Date: Tue, 11 Nov 2025 17:55:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 11/20] KVM: x86: Refactor opcode table lookup in
 instruction emulation
To: "Chang S. Bae" <chang.seok.bae@intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: seanjc@google.com, chao.gao@intel.com, zhao1.liu@intel.com
References: <20251110180131.28264-1-chang.seok.bae@intel.com>
 <20251110180131.28264-12-chang.seok.bae@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251110180131.28264-12-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/25 19:01, Chang S. Bae wrote:
> Refactor opcode lookup to clearly separate handling of different byte
> sequences and prefix types, in preparation for REX2 support.
> 
> The decoder begins with a one-byte opcode table by default and falls
> through to other tables on escape bytes, but the logic is intertwined and
> hard to extend.
> 
> REX2 introduces a dedicated bit in its payload byte to indicate which
> opcode table to use. To accommodate this mapping bit, the existing lookup
> path needs to be restructured.
> 
> No functional changes intended.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> ---
>   arch/x86/kvm/emulate.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 763fbd139242..9c98843094a1 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -4773,7 +4773,6 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
>   	ctxt->_eip = ctxt->eip;
>   	ctxt->fetch.ptr = ctxt->fetch.data;
>   	ctxt->fetch.end = ctxt->fetch.data + insn_len;
> -	ctxt->opcode_len = 1;
>   	ctxt->intercept = x86_intercept_none;
>   	if (insn_len > 0)
>   		memcpy(ctxt->fetch.data, insn, insn_len);
> @@ -4877,20 +4876,24 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
>   	if (ctxt->rex.bits.w)
>   		ctxt->op_bytes = 8;
>   
> -	/* Opcode byte(s). */
> -	opcode = opcode_table[ctxt->b];
> -	/* Two-byte opcode? */
> +	/* Determine opcode byte(s): */
>   	if (ctxt->b == 0x0f) {
> -		ctxt->opcode_len = 2;
> +		/* Escape byte: start two-byte opcode sequence */
>   		ctxt->b = insn_fetch(u8, ctxt);
> -		opcode = twobyte_table[ctxt->b];
> -
> -		/* 0F_38 opcode map */
>   		if (ctxt->b == 0x38) {
> +			/* Three-byte opcode */
>   			ctxt->opcode_len = 3;
>   			ctxt->b = insn_fetch(u8, ctxt);
>   			opcode = opcode_map_0f_38[ctxt->b];
> +		} else {
> +			/* Two-byte opcode */
> +			ctxt->opcode_len = 2;
> +			opcode = twobyte_table[ctxt->b];
>   		}
> +	} else {
> +		/* Single-byte opcode */
> +		ctxt->opcode_len = 1;
> +		opcode = opcode_table[ctxt->b];
>   	}
>   	ctxt->d = opcode.flags;
>   

This will also conflict with the VEX patches, overall I think all 10-12 
patches can be merged in one.

Paolo


