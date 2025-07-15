Return-Path: <linux-kernel+bounces-731179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19337B0507A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668241AA6BA8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206432D0C61;
	Tue, 15 Jul 2025 04:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qTzzCOZ6"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ECBEEC8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752555138; cv=none; b=SqwBobbmy0nDvZ9T5JNlZTdjtNbyEdCVE6UxXhNS+jZm3AevI/IUA13RXt1lvYjDjMgROOuIVSNBRYABEKu/5merF91svpRP9ommxfQTjNqKVh1giihceJqC3m0fU/ReEGwLdqbMsvSMVG29HQKyYyopcRGEIl/saA5PtpOsL9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752555138; c=relaxed/simple;
	bh=9QB63VBz9r996WNRV3pyu57KzX9K0mFXfnRk7MDY8mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDVzpeyf6SqHQkZB+rSLB7JyxiM5FEWjK59Be0ldgUtgCi1Ib0dU70swGiogfH4u+CZUNA09OrRJJW52EhZlfg98Uo25BzXbbAkH4a3JMKxIbmrATsIB/sUTx6vfP10M0JHuiMVCjEDh1xMJ/qKctv8K3Knb6zSKTYIu4PaeeoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qTzzCOZ6; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ab3855fca3so152581cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 21:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752555136; x=1753159936; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yQ8PD3h9aJl4C1vHw50I9+gj4+puVBXvKvI7nIOSE6E=;
        b=qTzzCOZ6GvM3fgUX5qn+nFvXt7OZkTeCC8RCcBf0zSXkJHLU1/0D8hk7Jea/0b3hk4
         m76q0NiALmgw19dtzB0D+KBZ4uLpsCfrb5/t8gAkrCExtYWksPKagDw0keHFaiDh3ueY
         infiV7ByzNMPRVQu5nzP4rW1WdF1FTPtMULbyU6zLF2j7udsKbygz2MHCG4Ww813ah1U
         X9vC2sSd0RelZ/KKAFCPmuz2GNKV7GYmSSQthizfqLGU+9KdWJlf9k0qaflFUVnbuEXT
         qJNoYTm2DjS03mVXENGvqW6ZEijtHq/G6/fMycFJ+21DMUOBs+fOiSTAdwi1MrjLpcCz
         ES1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752555136; x=1753159936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQ8PD3h9aJl4C1vHw50I9+gj4+puVBXvKvI7nIOSE6E=;
        b=Un66aFN9eL7F1fEZFOHzds93jpB8W5JznrxUIOKNqhN6fCWDtY6ym8KgSMAv37f35P
         2fu45BhwEd5bMwVtvIhaTw0EW4D9j1X4w9cQrLXdmCTSQhMc+uVaMIOvlZszDRKqZMbO
         8sctc4oSlqpx1vCoxDK2M65y+yC9cQzynQb2/qtc6SCgSfGnwOf05KES+qGXZ6uv/UVn
         /tyeVxEQY5DKCG6BNn5n5KbKYrAY4aan6IiM/KQmmDIBVxxWaTsXeMAK9DRT/boB8J96
         vvdhIz+OOkzafVA0lbt6RxnJZu+rYKLO7+aublDKNigOjuam12T2EMQsl7+mqHhV4WdP
         kHcA==
X-Gm-Message-State: AOJu0YztjZg0pW/Ai8bdLkWW/gL+t0LABsAjVfaE3lLNueDjIFUHTzkU
	kyQT8Ihy2ObrUJ5h86J7l5dW5yWC+dGRSqjIC5eYJhdnk0xSzJdzKmlis2tPHh0vB4TdY0L7XoN
	+8ShtBDKeJyzQQt7LCkYxamw2ywfLH/km8S03XBXh
X-Gm-Gg: ASbGncuhs/27+5lwlK5OBq9VyvqRTLbQemPgcgIzuBYbhrVQsCQpOguMK763cWEHBRl
	nijVR0/C7K6V2bc+hLO65CRNDwrmrMvPPX46XBqxV6pGZlAk+iB8TdpnzJAC40JNhax5oTLR7pR
	YH4sCMBUFEqfOuPWpF732WK3WYPPinUicD4Ro2UGdHY1YRqA8xA6Hoe9jiBJlAZ7mDxLzsZsZC4
	kY0WmHcbTRH7cQi
X-Google-Smtp-Source: AGHT+IFYrfbYbITqLsmbDEhhjGXIVHUkcXKfujJVgXOvLl5+zvZ5jKAWuBeT9un5hCCfW2/bB0KRKvBcMzJyu/6aRmY=
X-Received: by 2002:ac8:5712:0:b0:4a6:fc57:b85a with SMTP id
 d75a77b69052e-4ab80b73ff6mr2385041cf.14.1752555135579; Mon, 14 Jul 2025
 21:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714185321.2417234-1-ynaffit@google.com> <20250714185321.2417234-2-ynaffit@google.com>
In-Reply-To: <20250714185321.2417234-2-ynaffit@google.com>
From: Carlos Llamas <cmllamas@google.com>
Date: Mon, 14 Jul 2025 21:52:02 -0700
X-Gm-Features: Ac12FXyXnbLo4F75vEUCjUhTuGs_3hGSJQ3tUclmIrwJ3QRBp55s4SEV7DssqUI
Message-ID: <CAFuZdD+ZCo6s5Yo=OeUt22F9kymERk+a5w1xH32Nyae_29q6PQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] binder: Fix selftest page indexing
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, keescook@google.com, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 14, 2025 at 11:53:14AM -0700, Tiffany Yang wrote:
> The binder allocator selftest was only checking the last page of buffers
> that ended on a page boundary. Correct the page indexing to account for
> buffers that are not page-aligned.
>
> Signed-off-by: Tiffany Yang <ynaffit@google.com>
> ---
>  drivers/android/binder_alloc_selftest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
> index c88735c54848..486af3ec3c02 100644
> --- a/drivers/android/binder_alloc_selftest.c
> +++ b/drivers/android/binder_alloc_selftest.c
> @@ -142,12 +142,12 @@ static void binder_selftest_free_buf(struct binder_alloc *alloc,
>       for (i = 0; i < BUFFER_NUM; i++)
>               binder_alloc_free_buf(alloc, buffers[seq[i]]);
>
> -     for (i = 0; i < end / PAGE_SIZE; i++) {
>               /**
>                * Error message on a free page can be false positive
>                * if binder shrinker ran during binder_alloc_free_buf
>                * calls above.
>                */
> +     for (i = 0; i <= (end - 1) / PAGE_SIZE; i++) {
>               if (list_empty(page_to_lru(alloc->pages[i]))) {
>                       pr_err_size_seq(sizes, seq);
>                       pr_err("expect lru but is %s at page index %d\n",
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

LGTM!

Acked-by: Carlos Llamas <cmllamas@google.com>

