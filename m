Return-Path: <linux-kernel+bounces-732207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C30FB06370
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 283FA7B3375
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1858C24729A;
	Tue, 15 Jul 2025 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="nPW3NJiD"
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5072C20E710
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594584; cv=none; b=rM57rnFio8qpOOGAzFbvxH5RSmGzEdXllxvkY933odSX4aPnj7YUSENlXPh8ZCPdPC/TE7FdR69zoSD17Ki9SzJcvjVnM3LoW1SnLOy/s3OuiZqJeY9ns2WI5Gdl8kYzazcwbEVyU67ke+6s0rDLXtY5Jwd0v+Am6egITgpJmqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594584; c=relaxed/simple;
	bh=9gmrSWjkPf6ptmRUjb9+4+JTqajV+K87bEuRScfXVKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0DVV5ov3uW3iJ3lmeKYDKdTiLBjhHxIjdFArILt3Sgnx+/kRGWLkrZ5g5eBdpZL6fUCo0JUo8AqfOnJlOk1AKpUQRjhNI1E42PYQrFUi9I5tdOaK1GZNMLwaGO7sYBKbkgMJGXO8ibG6z+9i236oO+gpuTADciSrpXNzo4D8HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=nPW3NJiD; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so15151f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1752594579; x=1753199379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9gmrSWjkPf6ptmRUjb9+4+JTqajV+K87bEuRScfXVKI=;
        b=nPW3NJiDG1FGLj9/R1XeYQXzceM5WDxiWsE1kDVn3gfUNz7D8TkB2fzdDd61XZv8EO
         lvUK6zx72n8/SgUDW+dciMu5XbcKfWtfve+nxEKVFJXRj3wAVSdXyuhRncw8d+hmc6WO
         6gU8mQoDr79vs6jscCyzQjOMeQbREU4Whnp74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752594579; x=1753199379;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gmrSWjkPf6ptmRUjb9+4+JTqajV+K87bEuRScfXVKI=;
        b=URTQrY1Jblw+9SCAz6D8CPlzeUJcH4aByZBt0r3teQyveKeySKvKYbm4znu7jWrLh7
         T98ZsCCEGIt83IsI4n9LUkJ0bpdto9mVcIJY6i0xqVg8jZk+IqCxOhkYM2dCczdM50kn
         sbhSRmsXzroi5fGAyWLC0g8KZGh2AgRQ562NuGmXp2PQWIY5fYwWkwPpOz/s6ywZyxnE
         yxM18PeYfdhcrWgxfASX9djf7usRoIfX4eAisbMZoJF78196eqFyNGQatPvK7OZsGD4Z
         jNUuI3PMPZgzLet4opfoYlOiaz2XJim0S5bNB1mhOUhweEzvroMG4qvySob6Xdb6X5GH
         l5sA==
X-Forwarded-Encrypted: i=1; AJvYcCUtHDPj2QHamolY3FRIT+SOACAHZZZsGBoWN2tZD1hvn2Mls98TDAFnO4OtMm/qz8/8mVK+WhqPI72jQbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+G+HcX65SwF1ZUty3ca1UE9RteQXrqyXL1igABJ0OAPWdWolZ
	tyNGNnCFAgS0DX8xbitQGUyRTGttCcRBV9lQuRdLCZlvfiOybMUM1LwkTrKEw+P5Jy0=
X-Gm-Gg: ASbGncumE/WTe4yUbasyc/LFCT7sh3bEzrES6z+if2UPJ4mP+vD9yTVZwAshyoZUK2q
	llYdSf2WqD/QYv7uZnezW8zTx66c0Fvxeb5IvVScianE8gSQa9SLzHCroMTEO5JXpoRaqhba3R6
	xpWBBzxOrZY5Dff9RUEwIPf6R6Ag1hY6awLg3rhEDfxdPbf4jTG+OS2brbjFx6FesbQpz/n/2ct
	IEbLxyDv+BBYIL/4ZmsZZkye912rliv1jS2cZ6oVpGH358QiuHv+/Y/I6ZFW8K399HBxOuU9v8G
	by/pl8bo2/oqLEs7J56oFjPU3cVRdkTAq7F/OOi88DQCKOETraFEjNMGOERDuiBksZ6kVH/OyZZ
	v9dZ/dvinnjUD/0ZmvRpjdm2GKSxiI+T+njCaPGqO+27Uw0vLeqU7ywrs5iMf0FQC/0Jju0NBNG
	Xt3D0=
X-Google-Smtp-Source: AGHT+IFRhw/ZviPKrKns64f3aAyeXKlIkol5iF/KXQ0hI/FgEBYlEP9Vjn93ob1Etjy88cWqsVQ3aA==
X-Received: by 2002:a05:6000:2089:b0:3a4:cec5:b59c with SMTP id ffacd0b85a97d-3b6095442f1mr3679871f8f.25.1752594579525;
        Tue, 15 Jul 2025 08:49:39 -0700 (PDT)
Received: from [192.168.1.183] (host-195-149-20-212.as13285.net. [195.149.20.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560394e061sm107648085e9.31.2025.07.15.08.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 08:49:38 -0700 (PDT)
Message-ID: <2e198fe6-c08a-4489-bb0e-aff6d2d5670b@citrix.com>
Date: Tue, 15 Jul 2025 16:49:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86/fred: Remove ENDBR64 from FRED entry points
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, jmill@asu.edu,
 peterz@infradead.org
References: <20250715064437.807569-1-xin@zytor.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20250715064437.807569-1-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/07/2025 7:44 am, Xin Li (Intel) wrote:
> The FRED specification v9.0 states that there is no need for FRED
> event handlers to begin with ENDBR64, because in the presence of
> supervisor indirect branch tracking, FRED event delivery does not
> enter the WAIT_FOR_ENDBRANCH state.

I would suggest phrasing this as "The FRED specification has been
changed in v9 to..."

Simply "v9 states" can be read as "we mistook what v8 said and did it
wrong".

After all, the change here is specifically as a result of new research
showing ENDBR on the entrypoints to be of negative value.

>
> As a result, remove ENDBR64 from FRED entry points.
>
> Then add ANNOTATE_NOENDBR to indicate that FRED entry points will
> never be used for indirect calls to suppress an objtool warning.
>
> This change implies that any indirect CALL/JMP to FRED entry points
> causes #CP in the presence of supervisor indirect branch tracking.
>
> Credit goes to Jennifer Miller <jmill@asu.edu> and other contributors
> from Arizona State University whose work led to this change.
>
> Link: https://lore.kernel.org/linux-hardening/Z60NwR4w%2F28Z7XUa@ubun/
> Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Cc: Jennifer Miller <jmill@asu.edu>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: H. Peter Anvin <hpa@zytor.com>

Preferably with an adjusted commit message, Reviewed-by Andrew Cooper
<andrew.cooper3@citrix.com>

Any idea when an updated SIMICS will be available?

~Andrew

