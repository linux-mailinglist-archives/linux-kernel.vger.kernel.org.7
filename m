Return-Path: <linux-kernel+bounces-882467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C56C2A85D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 09:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C4C2B34101B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 08:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054EA2C3247;
	Mon,  3 Nov 2025 08:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpPsGbJR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623512D7DEE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762157817; cv=none; b=YFylas1hV2XZ7hReokQAIO8DzqOQjbfu1Xelui1vwj08ANpQf/ei1GE4C/q6XHWJ1dgDwFVyfCJ0ypGZgbqjz8a13HFjzN/X1es2zd7KVCCR3ed1Mia0NayUQXPzBMSp/LPD8NCscHIgBBE3BOPdAGb0wfAfrbh2Jp8OzT8fKuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762157817; c=relaxed/simple;
	bh=WgEI7eEHVqz24S0MjBdhNQ4iYzouwo5KfLOuQiAPpbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7fbs87h7JUZEy0UMmAO+xt4j6XYPLNLH3/YO8enW8afDcHUqRwCz2GSb1QlWFxsQs1BT+JNRxrR2bPyssMCmEyBdC3l4JRopEeGl6dDakJRSonJnzOWl3lxSm9eQ0TGETZdWhJ4JPuOydfXZkLhuXkipweWH6pQQDRjW0eBAD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpPsGbJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B16C4CEE7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 08:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762157817;
	bh=WgEI7eEHVqz24S0MjBdhNQ4iYzouwo5KfLOuQiAPpbw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YpPsGbJRe3l8L9kG6h4nDc1iNtQeMoUrVZolqwsF9C15xGS1og8XvxNqWqCyk2Dmn
	 e9FePOkX1GYfMaWPo78UNFo1ldhVLXHRgBEqVWPqhsHDYREBfMSv3i2qqpEziTfMd7
	 wPb0E4o/Gi+T8gBouSv3JhWey5LQLYbPNIG4xHvXb1WHxxvOzJ8D7U3M9QsEDA5q+6
	 PtFWxQtKj20Zjyyp86+TKms06ZKSLzJrMAEbdutrAD78LxoIkBgT+0mQW4aHV1OqRJ
	 2XfQCqh2drz8qkHyNbLTqS0ndXNcHbvIbrgAgO6QyId/UjEriNDZK6ZY7qEZnwEOy9
	 9wpO8Z8ZacT+A==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5942ee7bc9dso325340e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 00:16:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhuEywuXCiGYNZi5OPGOaRSzif5HVieph1+kARq54qxGYLl+ikNw1CVz35YfoEynH2YHX9KBqHRirWauQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzQGuvRcc780D3/l9OaZgBkra7J9HJ5rrnB/ungGE64t6nJCeL
	7djNURv9QqDO6HjspwCUoj4cVRX3VKKLtmnRHwgSsoHbnECadUFFagcbFI/pEUq0k7jrOp5BL7Z
	QE4GbmO29sE+pAWUIz7lNYkJke1tDU5w=
X-Google-Smtp-Source: AGHT+IG+lOQrU1AFbtrAgnHhD2b8jTjTxqKjskKGvoenJjx4bjsY6sELSD4i3JTmYaduhKts49p7W/ILOW5vg1lLps0=
X-Received: by 2002:a05:6512:2390:b0:594:2a78:fab8 with SMTP id
 2adb3069b0e04-5942a78fd55mr1151440e87.3.1762157815476; Mon, 03 Nov 2025
 00:16:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102015256.171536-1-ebiggers@kernel.org>
In-Reply-To: <20251102015256.171536-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 3 Nov 2025 09:16:43 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEJAqt6_QKg12Ejf6RRpvOfh5bhPRg-7wwoB-A8uDKj6Q@mail.gmail.com>
X-Gm-Features: AWmQ_bnrKcIgct_2mhYFy7vlTQrJxZdAswF-L9lo7h8EFLBPyzRueadWJqf44zE
Message-ID: <CAMj1kXEJAqt6_QKg12Ejf6RRpvOfh5bhPRg-7wwoB-A8uDKj6Q@mail.gmail.com>
Subject: Re: [PATCH] crypto: x86/aes-gcm-vaes-avx2 - initialize full %rax
 return register
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"

On Sun, 2 Nov 2025 at 02:53, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Update aes_gcm_dec_final_vaes_avx2() to be consistent with
> aes_gcm_dec_final_aesni() and aes_gcm_dec_final_vaes_avx512() by
> initializing the full %rax return register instead of just %al.
> Technically this is unnecessary, since these functions return bool.  But
> I think it's worth being extra careful with the result of the tag
> comparison and also keeping the different implementations consistent.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>
> This patch is targeting libcrypto-next
>
>  arch/x86/crypto/aes-gcm-vaes-avx2.S | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

