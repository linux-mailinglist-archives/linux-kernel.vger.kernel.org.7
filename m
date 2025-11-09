Return-Path: <linux-kernel+bounces-892024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5759BC441C8
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 17:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162233AA94B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 16:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5662FFF9A;
	Sun,  9 Nov 2025 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSHLP7+b"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33162FB097
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762704264; cv=none; b=Bi2f4bWCuj+TrjZ98TJcJdv3+XK02Z6oWUJfABhPUmo2rLDI42Zn4htpSnogDp6sjzrYWN+H6kVxds/RkvVzxNz65GbYMt3lZQgPPc2TdtHvqvI2xnocxzW5M/m7pjZQQgGYiutEB0weObXvvVKV/EUHiij9uqYUTm/fdskB4tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762704264; c=relaxed/simple;
	bh=ZwznLFivANyU8ZlKEutMzt9MzcWHkhSBL7kC5XjFM0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VR/2id/k20fmKEl+QAB93BC8kvYzUlMCzzGedrJ1at/KtKr8ZMJi+ADI5Qv/8GfeyUlZF1gBNiXbTf/J9QVX78lagZH3RRAk1VvYNdFNWXgC4Gp+d1GRYAIrJnxgYGS8YCX05ZKCZS29ErijagAWIalI3zIl/p+X1lhLoi6/8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSHLP7+b; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b3720e58eso375449f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 08:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762704261; x=1763309061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZ/3k/Szvk85XYtPGcfXcb2ddiNwOVeYZcc0QlEd1Dg=;
        b=PSHLP7+bXzYqOd4Ca6cAxh9ydRiOhY+xMmvsx64dw4n11vSAFQa+NX2vbnF65zsOIG
         O4Z94tsib0MhmWkvg8I5+lD7nQ3fwhEgWQApjAqe4sA1PT+YnaQOqvCp84Ycrn5WmF3+
         rcnmiR0mEmgvu4vfoU2mLuelcztdKEre3liXk83x61OcSYCa7kR2ShXhV0PCX0rY4U7N
         WtBCT1d8Rxu1daJg5wpMi7JV6Wn9nHyXStcGc1ugLStqkccB0Mw3M1+ASFfUK22W/CIS
         XFtjxq3z8HcZQLx41kkRI/oAiR0eieyp/w9kkcHcxExiJWeMHux+VSFUQNEdy1FeRtpV
         BFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762704261; x=1763309061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yZ/3k/Szvk85XYtPGcfXcb2ddiNwOVeYZcc0QlEd1Dg=;
        b=F3IcZGQLA0e+Co6DdoF3pit6AiKEtS7jl7lXbQ9eDgxdc98HQ7SbH3jD+MNGBX1SYm
         cfS2o2hUgawgJDL7Gyo71nezjJmvFy1pFnlwgyyjr8npHlo9bPMQQ7KjzHsZYFy3H4SP
         bF1Gz9R5y3hd5VVtnhTXikIljCkyt/4U9xRgwwTybgn7sFk8OzDUAW7tEif5fKCmtYkw
         xvIftEsZd9mO333tlaW6/iVtTT84JfzuAl3jw8wnrvDXWH6mBryl2UDqr/AwfRsuYhyP
         D0dsKxW8xU3FsHZQrCDZEJxs6+/w2lJXohziJPzy8eHwaoLQZVYHOLMOGX1y+uEx0Hzb
         rpnw==
X-Forwarded-Encrypted: i=1; AJvYcCU9gCWb79qLT0LxuuWKmltzMYF+KUejqeBLQtFR3RNxYgqZYJAVEYswbwQ0Th7TlYO4hiIFwDV1CsW/kHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2tU/w1CkE5Y6naE21DQ+YtH2Cv3b0FncsQ1nm00t+QSqPk5yk
	CJvNGL4wJeDfxj4caJgVqnqh0AuQFlL0l6viF8834CNhThJDuwqGrUZ4
X-Gm-Gg: ASbGncu2OjIlIfnwH/n5mkLqsiM6dFuPogdTcLl2P/zMTjSGGqUzXZBvLeqm4FfTXUq
	NjmTQaH7JMWvigHUHmeIR7oTzKp6n5aule7Aya366GorpFgcpNZTL+/Z0HNu6JrK+gJ+I3I7mUd
	pSSZu2DDvL+0O/qu1gc85IiX64a7q481i78Q2BOB2ixz13ftPuusclzCNvrMwqqXpy4ClmcN3/S
	VvkxccKAGaxh73SdZdXLsYzWHkKMdV5VnQQkJeoopBro4872zBEQEU52NpLjy6HV0fX/vk7Ax0J
	MiySQLwpYacprW2rLfKuNvZiF6tRNJGMpTmbeHRWOH2H5is5UpcloX9tNxmZ02frnAw+AcMHP2V
	Nuy74eb0hnXDj1Xvwvvf18WaL3ttdOb9G3+P+gYdKG6iPYlVPChAnOmpmFuAZfCsf6gfjxR8rdt
	+/lJkMebZJKyN0GjLWxjy42Q1eAtDEDMYwYrUrTjXxEnCvbGZcxgnl
X-Google-Smtp-Source: AGHT+IF4v4kRAm85ejXHBzeoSJZ5rv1Sf/e1KUUS5XVDP4wZrYVo3g/uJNxMF3qT2VLVXhWlbGOhHA==
X-Received: by 2002:a05:6000:24c4:b0:42b:3978:157a with SMTP id ffacd0b85a97d-42b3978176fmr1366422f8f.39.1762704260877;
        Sun, 09 Nov 2025 08:04:20 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2dd927d5sm10518562f8f.24.2025.11.09.08.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 08:04:20 -0800 (PST)
Date: Sun, 9 Nov 2025 16:04:19 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Masaharu Noguchi <nogunix@gmail.com>
Cc: jesperjuhl76@gmail.com, Jeff Layton <jlayton@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] samples: vfs: avoid libc AT_RENAME_* redefinitions
Message-ID: <20251109160419.5a16411a@pumpkin>
In-Reply-To: <20251109071304.2415982-3-nogunix@gmail.com>
References: <CAHaCkme7C8LDpWVX8TnDQQ+feWeQy_SA3HYfpyyPNFee_+Z2EA@mail.gmail.com>
	<20251109071304.2415982-1-nogunix@gmail.com>
	<20251109071304.2415982-3-nogunix@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Nov 2025 16:13:04 +0900
Masaharu Noguchi <nogunix@gmail.com> wrote:

> Signed-off-by: Masaharu Noguchi <nogunix@gmail.com>
> ---
>  samples/vfs/test-statx.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
> index 49c7a46cee07..eabea80e9db8 100644
> --- a/samples/vfs/test-statx.c
> +++ b/samples/vfs/test-statx.c
> @@ -20,6 +20,15 @@
>  #include <sys/syscall.h>
>  #include <sys/types.h>
>  #include <linux/stat.h>
> +#ifdef AT_RENAME_NOREPLACE
> +#undef AT_RENAME_NOREPLACE
> +#endif
> +#ifdef AT_RENAME_EXCHANGE
> +#undef AT_RENAME_EXCHANGE
> +#endif
> +#ifdef AT_RENAME_WHITEOUT
> +#undef AT_RENAME_WHITEOUT
> +#endif

There is no need for the #if, just #undef the symbols.
It is probably worthy of a short comment.

	David

>  #include <linux/fcntl.h>
>  #define statx foo
>  #define statx_timestamp foo_timestamp


