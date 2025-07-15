Return-Path: <linux-kernel+bounces-731881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB39B05AF1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CDB07B160E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C585D2E175D;
	Tue, 15 Jul 2025 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8CKs7ZM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578831A2387
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585125; cv=none; b=eJSWkbqNCRZ2BFAzphfG6VP7hYYy5ssCmnKMm5xMLXvHJHyzCiLkCvufnwUZQSh2OIh5pAASbSYKVNbzlaN9ChppPSTZnsJj8uu1GRGtAaOAk8yLB5KpZdJqyA4ohYJ8JljvBT1TtdgORrjAchWazj/bUFkpM4RjcQnTcPWHzGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585125; c=relaxed/simple;
	bh=6qfx1AFvVvUSMbmXqpWZAUM1XcuqC/9zxs9mjQcS4EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCNwDSTzqiga4MsutuL4z83X4tnOmdhSr/FSa4NSSKFgDD1Hpbhsp/n/yKNE+wJljnpxh9rrsk1AHbEw1h7379SchdGvpjgcUdX5KJbdL4XG3C00CCv3MUtDhq+LVJ3ZddLvi10xXt2DVAxVbvqVytSAul+IpVCKV0h2Xlzrf/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g8CKs7ZM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752585122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7tWYD4tx+fg2lnHVa/1g7HWDf3N37jy+j/78STt+1w=;
	b=g8CKs7ZMRAsYgzhd1haE/7LA42Hrmucx122L5UW+6nRXmeQaaRWvihZpd7OZLTTJJDEyAO
	RHwLG/AzN6VVdiyPuPQ/Da0qAfABpHEbrDz++vFV2BEmbJkyT26jxYJJ5Ngi5F361zIRDo
	mPmuIO+XBuzLkijQoN6RSXS/0RkjKgc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-9xhwM7mGPK2P_bnqdkR9cQ-1; Tue, 15 Jul 2025 09:02:28 -0400
X-MC-Unique: 9xhwM7mGPK2P_bnqdkR9cQ-1
X-Mimecast-MFC-AGG-ID: 9xhwM7mGPK2P_bnqdkR9cQ_1752584546
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-455ea9cb0beso31867645e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752584546; x=1753189346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p7tWYD4tx+fg2lnHVa/1g7HWDf3N37jy+j/78STt+1w=;
        b=HlsJ8nMIjSxUjFyWaMJ4iGqPTmIApJ5C61d3aI8voNsvfvIWv6MLriKoqwEVk69xVb
         sXzmGNict38gIiPs+QSeJ3WFGWibXyazmVP0+kQhMxJ8FhTO2sh0Ws+SPz87xcr80s10
         AnQEWJyGSwTkz/Zn8gGWeSguYkPJXz7emvQPSOiRQEUJF8k1xZwzJBkZR2vPFjsTsSpp
         r2SbN5L/Bvcbv07wsoX6jhSh3is8GLSzbqhyf/Z/ODLJUrarIrxWhotV0aDT1cMA+RdD
         Hoa7wFYTga+69CCok1zQ4oR9jvTT4eSydSMSyymrEyB/vveR4gUDit10ZkeFbVmS3lDR
         5AeA==
X-Forwarded-Encrypted: i=1; AJvYcCUX9GAkYtj/A+Lm8CThHMl/9+1RGi3arrxHxC6dbQnPQPM0qq6dpur4k8FLIdge3niPyuy0uuAP0ZsVfLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6vmxJtwNB4XX7voZNwctHKN2SHB6VFiofNFePf+dkKD7KfTra
	nNg6MG5zv1U4DbGsf0epkhNpwjz8RG+mja/x196bDHpg8gNKOo6lU3mZyoC8oGCdIqY275AVM0q
	xsbwiIJCxIazLg6oa3Fg9wPSMci8R031KHbKsanJ2JeIpOAQO81CAK3PxYkwkF3koig==
X-Gm-Gg: ASbGncvkLVH+G7rWxDReacK0K9TuR5/QdDi4DwQaHRCvrvKE3bNXUDZ78/srkYFja1+
	imIOh3U78v8MN2vajtrySyK+0pyT+g3uqW6bHZyYdz00P+C1rfwYdh/2ilhUpt66BQuLHm6nvMW
	oS1lLLWo0M1xclhVObt0hjzrWWS8EFGwI34vrYdXjAbpi5Wa5/r1jg1yBuQdlIYOwUSZnH6Rbx5
	/4ZxyitftOJSqbEULYnKGqasfSZSwy3XbOUo7dS/a3FbQufEIW0wz24Qb0DD49pdpp2RT0JIoL5
	ZtHgZHy9Ts5SaSVfNg+aahvUqrjK2I49Ek4yXLYp5aMTazNJ56/qZJYdogzwQr9eUqxlGYmOxxl
	o62Pxlp6ZUdo=
X-Received: by 2002:a05:600c:a08:b0:43c:f8fe:dd82 with SMTP id 5b1f17b1804b1-454f4255c7amr153327775e9.18.1752584546000;
        Tue, 15 Jul 2025 06:02:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQmEKYWF5RFQOcNA8dAn6VORUEh2xGxKp+QojOuV5+23NJaOdrjj/10cvaoZSjormmd2ur7A==
X-Received: by 2002:a05:600c:a08:b0:43c:f8fe:dd82 with SMTP id 5b1f17b1804b1-454f4255c7amr153325695e9.18.1752584543813;
        Tue, 15 Jul 2025 06:02:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562b18f8absm5076125e9.36.2025.07.15.06.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:02:22 -0700 (PDT)
Message-ID: <e6801550-fb58-4a94-9405-b14e13c0e936@redhat.com>
Date: Tue, 15 Jul 2025 15:02:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] dpll: zl3073x: Implement phase offset
 monitor feature
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250710153848.928531-1-ivecera@redhat.com>
 <20250710153848.928531-4-ivecera@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250710153848.928531-4-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/25 5:38 PM, Ivan Vecera wrote:
> @@ -536,8 +539,38 @@ zl3073x_dpll_input_pin_phase_offset_get(const struct dpll_pin *dpll_pin,
>  		return 0;
>  	}
>  
> -	/* Report the latest measured phase offset for the connected ref */
> -	*phase_offset = pin->phase_offset * DPLL_PHASE_OFFSET_DIVIDER;
> +	ref_phase = pin->phase_offset;
> +
> +	/* The DPLL being locked to a higher freq than the current ref
> +	 * the phase offset is modded to the period of the signal
> +	 * the dpll is locked to.
> +	 */
> +	if (ZL3073X_DPLL_REF_IS_VALID(conn_ref) && conn_ref != ref) {
> +		u32 conn_freq, ref_freq;
> +
> +		/* Get frequency of connected ref */
> +		rc = zl3073x_dpll_input_ref_frequency_get(zldpll, conn_ref,
> +							  &conn_freq);
> +		if (rc)
> +			return rc;
> +
> +		/* Get frequency of given ref */
> +		rc = zl3073x_dpll_input_ref_frequency_get(zldpll, ref,
> +							  &ref_freq);
> +		if (rc)
> +			return rc;
> +
> +		if (conn_freq > ref_freq) {
> +			s64 conn_period;
> +			int div_factor;
> +
> +			conn_period = div_s64(PSEC_PER_SEC, conn_freq);
> +			div_factor = div64_s64(ref_phase, conn_period);
> +			ref_phase -= conn_period * div_factor;

It's not obvious to me that the above div64_s64() will yield a 32b value
for every possible arguments/configuration. Possibly a comment would
help (or just use s64 for div_factor).

/P


