Return-Path: <linux-kernel+bounces-764814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFC3B227A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA741B683C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7417727932F;
	Tue, 12 Aug 2025 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DyI0Kw2l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DB5277814
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003268; cv=none; b=DvQcm8GYpTXVQzFeeqiecklT14kqBqb3oEsl2s2VCsPkaJygNJQd3G7EZtPV6knZhppn4/pjs9fmx7CuoJNRGDMwnikJC95Gow41HskSO1Hfkh0hmRAhxeSjDHJwbzDqBwkwSzgBU+qazq7CxSXIrfGVPuKo/FDhWJawGdixMEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003268; c=relaxed/simple;
	bh=ODpyotMqbR19gg+oEM80+cCkM0ODDUkNV/2kT+hopxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5DHS/TEY3H4MezmfILxqUzksJz3CCQtho9z6qG62kRbdTCtdo1wJBFnxqnLeFnCSh2nzvM6gJsLD2NQ/qo0jEkHvBzuQRo1FWcYzoBz8f9Wq9E0Cfinhbkhbk0xDMP/RIHUGW6kQgqx7meOZP/L2J7n0yrh9YgyzKqfqJsBcys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DyI0Kw2l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755003266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRwZCYRsxjvJxx5GllLV801jS3kCOXiKfQ2tbx5q35Q=;
	b=DyI0Kw2lj+PTRNAJ3wUdHaxfM8rJgxIEbGH0bvbrkNQ2qejA0e0wBs14QE1gHAPC8Wt1u6
	cwqwp5OG0+ZpGEpgW3b6VAW5hQHPfg2FzzJfiwh2iUoQBU80Y6Bn6NuZGF1D3ajjGQsqCa
	TxVOZMdivsq/VPsZraGfHd7KuJYpST8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-WPKCYfRONQGW1wDAjtTlyA-1; Tue, 12 Aug 2025 08:54:25 -0400
X-MC-Unique: WPKCYfRONQGW1wDAjtTlyA-1
X-Mimecast-MFC-AGG-ID: WPKCYfRONQGW1wDAjtTlyA_1755003264
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459e30e4477so46891395e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755003264; x=1755608064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRwZCYRsxjvJxx5GllLV801jS3kCOXiKfQ2tbx5q35Q=;
        b=WYdW7DxZ4H3n0OZD4pd0D15exwTnrWQbcjvK0XvpbKnzGj+xOAtOinEImJh4ItkFXf
         fvapIiMQnN5iR6EC7saa5vanP93s/a4I/wec+HsjQJO/1AXJ+/MXEAy4/Wq8WkNEct/P
         mUzphbVWZOzD/F6ObZNeUaK+L9xnHgvotsM3UW41Qgv9aVC2mcWXz45JzZ/cefZg/3jx
         yEX8GLEqS4D+fuqraSdcguX6Wt4CLT0oTk0/MwDMvC3R6lIWcQ1nuAF9S6NEBV5hZUke
         nm7w2DNmZqoUjBN7L+pZgMSD8LEGAU1nOOCd17Il4wJ/9tDeBt8Bj5fKj6zWi1rjNxJb
         mkXg==
X-Forwarded-Encrypted: i=1; AJvYcCWxvco9NaxyGZkay/h6TWbY4HxqsV+CUyeoAK9OFBMqgS/ZTSQbj79PMMPwbTPbWx9/EYIY4nIOai//MWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwScV2XSdaszdBHef6tDwKM8Fw7h/mvZZ0NsbPtWFm+NFU2Lcod
	yc022NlMCiOtVLw1gPx8K6xdkqkOwqzY7zrWCR8r8UDEbMeu+idqgNWLfbof8UZ6NVPUUF/0Iaq
	iHCFDQBBUkQ8x6twfQYb6c4bNB+K1uSkikRqMeeMuUgQWiA2QU9G+ufcEZRHklR4upQ==
X-Gm-Gg: ASbGnctnDL+gCl6BIy9Fr0KohuJnkGFO8N+n+bdfCZKMyvN1fjp7pTrWh1/Pu0+jYcU
	WJQkjav1qX0+wTilAFQ/l8aPHZrZEX5GN4qvWXwvrNBrdHng8rsVlmLbuYT124lVHTTot3+BzUw
	1+WVjPEuQ7lJUioUL2pC6yHxjdE0y/oArwwChW2k4AlmDwHLu7mWgXoZc2qQEgUzw5ZKAsNDuEU
	GhOC4A03Qr8ZtiRMonkYc9jPj89O5FB9/7XZ32toag6EFIBtiuJavVlH7qothq++wfnschxnuxI
	nu7+tAb54ILOgIlqwf5qpYUfOCXVy1ZIh18iI4jqy7s=
X-Received: by 2002:a05:6000:2502:b0:3a6:f2d7:e22b with SMTP id ffacd0b85a97d-3b900b4f08fmr11620937f8f.18.1755003263970;
        Tue, 12 Aug 2025 05:54:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFERWBxAhdG/9H6I4uUmTqO1UoV/PLVlBD6GvON7ihQC9dnpd6IAbGFKbO3xw56aaR9q/kStQ==
X-Received: by 2002:a05:6000:2502:b0:3a6:f2d7:e22b with SMTP id ffacd0b85a97d-3b900b4f08fmr11620919f8f.18.1755003263540;
        Tue, 12 Aug 2025 05:54:23 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.149.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac093sm46464914f8f.9.2025.08.12.05.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 05:54:23 -0700 (PDT)
Message-ID: <194e4774-a931-4ce4-af63-4610da7c4350@redhat.com>
Date: Tue, 12 Aug 2025 14:54:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: kcm: Fix race condition in kcm_unattach()
To: Sven Stegemann <sven@stegemann.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+e62c9db591c30e174662@syzkaller.appspotmail.com,
 syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com
References: <20250809063622.117420-1-sven@stegemann.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250809063622.117420-1-sven@stegemann.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/25 8:36 AM, Sven Stegemann wrote:
> @@ -1714,6 +1708,7 @@ static int kcm_release(struct socket *sock)
>  	/* Cancel work. After this point there should be no outside references
>  	 * to the kcm socket.
>  	 */
> +	disable_work(&kcm->tx_work);
>  	cancel_work_sync(&kcm->tx_work);

The patch looks functionally correct, but I guess it would be cleaner
simply replacing:

	cancel_work_sync(&kcm->tx_work);

with:

	disable_work_sync(&kcm->tx_work);

Thanks,

Paolo


