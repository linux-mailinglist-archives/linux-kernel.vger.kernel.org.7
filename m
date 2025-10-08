Return-Path: <linux-kernel+bounces-845758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A1CBC607F
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26076188B75C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE55B29D29F;
	Wed,  8 Oct 2025 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KzHXsBRN"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30132BDC3E
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759941134; cv=none; b=e94EgBB16B/ilNqbM1Yqe0FmXFy2LyiOctgWJYThx4kAudpKFi4uyZFHfDVRbKEruzUzyymnIyI83CGXI4M8ryPALh5LvjnxPwkcbpiG9OYsGnvQKzkWji013sSLaE13b4PKgbOuAXP0ors0qzR4INtq6EjEhEMo1xDST02iAvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759941134; c=relaxed/simple;
	bh=uFCQkqaDqxzWRXeqursEtkXC8InvxKjCAxBAsyErIrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fop2UkaZyyxvFGnMEHITM2uuvZTQQ8PxkAkfhVNdBgmp/qvU2hzI3YADXHXxxUWsHOwTWVNRXnebZ3yJNk+0K8u9poxPY+ojmZyB/bfgTCYPvG/cwGqbPwUjCkU78Dkilc/uPoexSFzVa4K13nxJsuoMAX3h+yVTGC1J0UR64EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KzHXsBRN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27eeafd4882so1605ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759941129; x=1760545929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oe0JG+T87ZxryLGwcr3JQ+tSMOZN1k2GavGauckPJG4=;
        b=KzHXsBRNRcfHADcpSNxCFEtZ3gGQDPnwUk5Wl2d4EjjSouigVZxHg8TgM4PRx7hdeb
         DKSQtLb4TTu3+YTbpxfWsEXic2QtqQ6o8aE8K6wLatS+su4XO3ypEQDXemDIGn7jX9Bp
         URjlTxuGuBs5JkDJrwC+FO5sLIljvtwjeZPM5scEtlUlauvTJciAQkOuhKNG7NSNfS/V
         NUeXp6D0E8jATbdV9LOSengyvpf/jkK0N+Hpjv2HwCN3CdGWUoo2U7IwSkZdRMC3sIAT
         ZifVF5KpJjcC3Vbkrf8PnsWucQ11QUOU4IHPLkO3h0TB6zKbJ5nHRchtaAat1bDmUa63
         UbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759941129; x=1760545929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oe0JG+T87ZxryLGwcr3JQ+tSMOZN1k2GavGauckPJG4=;
        b=MD8VSkJJ8t5y4UW0nSoyBTgoA5+2CWgBAU7nu3NtfXCE5JDDv6V8xq4IYIpNWZuLDl
         FnqD/oOBNJ6ooncOQM2qFOHCrQc99eRuypmg9gVxHADKY9IUFmstkhqYjWKuCOXTAI4E
         x2Yc17nX8ZcP/9OheV/scEAyjbDlxQYTO3wkJ7cKxCYK80yg64eWeLbGYT8Oake7cAvp
         LteCwHKIC5uzkqkzUzhHV7hi2pegC3/tfuykHvESpGE9a6g6hCiqHxAGOhOfMfyFLndw
         tnpBCiGnvDZ/nFftHuJm3oOISRVMzDKNOfMbQPLxLxLd4gnY3lIoeR34CEH/5jgYBOzT
         yz0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7iIXjMuzNFobgT1OVpSsoeAQtxJxy3zqa43NJTHy17goRo/No+1PRwFU+jzxhlfzQDtmVTJTwq8AU0gY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC5Sw+AHLImhXVjX2mZhQCMuhbczFoB+lvcgIwlRNJ/Tp1mHYZ
	QDpoQcTvgtBv6A5O6RE7T/2hTRIE1+UUBPD5Q0RSietiggUQdrx63lj/ZMnPzjyZVA==
X-Gm-Gg: ASbGnctsMhbq9ttphOJ6J+CMy1n0EAWYs0OuJePzYZf09AuQ6lfuHiqOUGkqnxST1db
	CziiQveoaBTO+bq4swsvScnAxm3JzFxGBzSpKPq5npKs6CA+7eOkQedWG/w74F2O+JKqKF3VlTL
	0ppifSB7xoLT3zkU85X/YLbnre2N0WUIlsEb2LQemUtk1mYTobsJDTGLjnCGGbj6FaJNZ0w8J7o
	BJqP/kf5f+21MqoZwsYR+sgli+riAx9Lk4YT05R/VYcqpQ3e5p434O7wsGZkRgRrL3VaUBefDZw
	ImstmGcpfOLsLCtvPuAfXScJNOAPok9s0+dmc37jV5V30o5f0calBN0FNFioNz/JbZ87UIoW2qK
	62s9dKcVW2O+7IpT1WUnZNuWs/ivP+aRP3k0gF/AfYq5DI3LbdiUyjBMovwZpYpayCiMQMCA07W
	cPr7ldMoKjcpDmyQ9ihUNUxoCQzMFB2IP847KzwDOtPvy4aaPyMmmQ72Lhl/8dcc7rBtQFytAqI
	Q==
X-Google-Smtp-Source: AGHT+IE4UeBVhlmr8nyjA+3MAY4U2585r8312anVnyz7SFqd1+ILwooYTIzTvCfZjIwwJ3yE1VoqjA==
X-Received: by 2002:a17:902:cf03:b0:271:9873:80d9 with SMTP id d9443c01a7336-29027620d94mr5687375ad.7.1759941128492;
        Wed, 08 Oct 2025 09:32:08 -0700 (PDT)
Received: from google.com (235.215.125.34.bc.googleusercontent.com. [34.125.215.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b51116b57sm3952329a91.15.2025.10.08.09.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 09:32:07 -0700 (PDT)
Date: Wed, 8 Oct 2025 16:32:03 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rust_binder: freeze_notif_done should resend if
 wrong state
Message-ID: <aOaSA0dPnY2I4a_D@google.com>
References: <20251007-binder-freeze-v2-0-5376bd64fb59@google.com>
 <20251007-binder-freeze-v2-1-5376bd64fb59@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007-binder-freeze-v2-1-5376bd64fb59@google.com>

On Tue, Oct 07, 2025 at 09:39:51AM +0000, Alice Ryhl wrote:
> Consider the following scenario:
> 1. A freeze notification is delivered to thread 1.
> 2. The process becomes frozen or unfrozen.
> 3. The message for step 2 is delivered to thread 2 and ignored because
>    there is already a pending notification from step 1.
> 4. Thread 1 acknowledges the notification from step 1.
> In this case, step 4 should ensure that the message ignored in step 3 is
> resent as it can now be delivered.

hmmm, I wonder what happens with 3 threads involved where the state goes
back to the (unconsumed) initial freeze notification. Userspace will
probably see two separate notifications of the same state?

> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  drivers/android/binder/freeze.rs | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/android/binder/freeze.rs b/drivers/android/binder/freeze.rs
> index e68c3c8bc55a203c32261c23915d8c427569e3b0..74bebb8d4d9b24860eed34363ce69b1c6df58028 100644
> --- a/drivers/android/binder/freeze.rs
> +++ b/drivers/android/binder/freeze.rs
> @@ -245,8 +245,9 @@ pub(crate) fn freeze_notif_done(self: &Arc<Self>, reader: &mut UserSliceReader)
>                  );
>                  return Err(EINVAL);
>              }
> -            if freeze.is_clearing {
> -                // Immediately send another FreezeMessage for BR_CLEAR_FREEZE_NOTIFICATION_DONE.
> +            let is_frozen = freeze.node.owner.inner.lock().is_frozen;
> +            if freeze.is_clearing || freeze.last_is_frozen != Some(is_frozen) {
> +                // Immediately send another FreezeMessage.
>                  clear_msg = Some(FreezeMessage::init(alloc, cookie));
>              }
>              freeze.is_pending = false;
> 
> -- 
> 2.51.0.618.g983fd99d29-goog
> 

Acked-by: Carlos Llamas <cmllamas@google.com>

