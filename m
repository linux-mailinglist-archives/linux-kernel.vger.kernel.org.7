Return-Path: <linux-kernel+bounces-810865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA41B520CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0AF5838D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876BD2D6636;
	Wed, 10 Sep 2025 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DlKsJ582"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3167C2D594F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532006; cv=none; b=AZ8Tv3sbzcaskVQoa4nKjzZ72519zSgQbvarE1bQCVpj9XO38g2HTPDE+SaTgoMdnC84Qxr6LMiTJv4W5FCKGb+CtNmifs+jWSV1NrZIseiH/KaEpeG/unc7izFeX1YBUSX1IMtTuSL8KDUAp84GIh3RbXOgjv6NCtoiXWS/s3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532006; c=relaxed/simple;
	bh=VQ8ApmDUv0l+nnhMh/bWuoQq5EcbiYUHx4f+R7dHb7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YH+7ocJJCxMrQOMKc9z8ihX/EYcwwqyDXPPeysExTvai27c0BdfKwX6IEdCJdjnCvaLhv073juJXeFvz0f4+4CRWDuC7cS4r+OaoT/Afw62SxtULdy5Tx0sr57RY5BsemyVGIZuGELfHevqW9/NQkMgqWNqL95lTzWPMxCXxxlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DlKsJ582; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b02c719a117so1271115066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1757532002; x=1758136802; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QJqHvDn6WPdQiKMCmmzDw8Z2IrYFrY+fWnqvUnf9SHI=;
        b=DlKsJ5827VrJhlzCswfhPXKHzUI7a5aPabvjn8Qzo9O+2MQxTRUmvPC4hpGxppunus
         zfCrhJ6mOEihQr6Tsr2zw312TqBUC0dgubZgIvA+5v9zEC612lmEoIBNUTy2+9d73C79
         FO7osKsFYbnfPeMpBw2fZ7z4IfLVDWRsiqw1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757532002; x=1758136802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJqHvDn6WPdQiKMCmmzDw8Z2IrYFrY+fWnqvUnf9SHI=;
        b=DUqkRNYdPjXPQW/SXc3DdFqXTJ+5Ov0c3gR6wWZiSbfQCa8e7xKR0UXaHgL/WFlMSD
         unR4djKzgBYF64CiteAuLPCgzdg/0B94To/ow+wGHtczPa1DFY5oUczS673fqhcuh2Us
         zO5FIHDDY+nMqnQRiYjLfIkyHCNGpRktQwGG9tGEunQ8S0mMwoZWMsoqQavQxnJA0bCt
         GBhiNMPnsko71PW9SeHZG08uCjnUPExyQiDpLnI7SRlZB6NTsJqaT447jP8wkKOBadR0
         BwkxHHZ7mo497q2jKYJqi82xBF9Ten7JtK1ygjrJ9GU62IllhxyVQBw/uPCp06JLzAk9
         wXDg==
X-Gm-Message-State: AOJu0YzkX7BuG52QOKRuAo8dMqgaEC1si155cosvOsu7b1gOZTEJt6Ug
	oZwyK1uA9ajGfvTN5Buyp2AOTHP7BLUzHD9udUhz9bTdXi0sE6qjRsKtFEustiN2xMWCmRrIQv5
	hr5ASYxd+Fw==
X-Gm-Gg: ASbGnctx5KWsuiPKN7W0Tfz4y2d4/d03ojuuuNgprqG8c6rKPORxv5DEeCXOcGgnu0t
	CmAw4AiRLYoGBZi50ok7493ZVuraeJe0JCT/haKR3Ad1HZtrBvS4e70CGAKuDyeY7/1R8wjXEy3
	Pe03LznJywyt/5DEW+Wa5ADk9lCMZmmPwAzfzel28WsBTF0svHDsTGwijG+0en1wmfP16lIhu91
	i9GMZ4kgM8o9f7bsjWnZOo1Y4POkqbJlaFfSx+UJ6D4eMExSWknSKV6olBkfVBffg6r7q7tw7Th
	mBDfjcHiAC0nd0Qmcn+CYbSw9M/H1UgvnWSMLbNptQab0avkBpD/VJdkhEV2m6wP0Jqp6J1Aap7
	i6VRQH9QCo89QqGkHJdPksbTQw6vNgR4M59eMmwCZETTXS+94oSXZUE2SaXQZXfjuQnP7Zsli5R
	5CcPqpdRiZNlgmWMLTTQ==
X-Google-Smtp-Source: AGHT+IHpNTWBLxXsYeqZR9Jl/Ww7qvtFY1ZIlaW6xHJmcamHTNYT9O75oaK92jREvDTM7+9i49H8lg==
X-Received: by 2002:a17:907:1c9b:b0:b04:84db:c83 with SMTP id a640c23a62f3a-b04b14af9bdmr1830099966b.27.1757532002173;
        Wed, 10 Sep 2025 12:20:02 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b078334c292sm220052966b.54.2025.09.10.12.20.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 12:20:01 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b042cc39551so1289905666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:20:01 -0700 (PDT)
X-Received: by 2002:a17:907:3f9d:b0:aff:16eb:8b09 with SMTP id
 a640c23a62f3a-b04b13cf9c8mr1576148266b.5.1757532000873; Wed, 10 Sep 2025
 12:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909162155.76756fe3@gandalf.local.home>
In-Reply-To: <20250909162155.76756fe3@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Sep 2025 12:19:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0c5oBqQiZctP1SYAW7XGHYEDchJWBUSXvQA-XGmNk3w@mail.gmail.com>
X-Gm-Features: Ac12FXyeAXn-jsxZPB1NVQBKN1dMYmabAz23EIZb42te8guH72p-pCfkt5GyMNE
Message-ID: <CAHk-=wi0c5oBqQiZctP1SYAW7XGHYEDchJWBUSXvQA-XGmNk3w@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes for v6.17
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Guenter Roeck <linux@roeck-us.net>, 
	Luo Gengkun <luogengkun@huaweicloud.com>, Pu Lehui <pulehui@huawei.com>, 
	Qianfeng Rong <rongqianfeng@vivo.com>, Vladimir Riabchun <ferr.lambarginio@gmail.com>, 
	Wang Liang <wangliang74@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Sept 2025 at 13:21, Steven Rostedt <rostedt@goodmis.org> wrote:
>
>         Back in 2016, the get_user_pages_fast() and
>   the kmap() logic was replaced by a __copy_from_user_inatomic(). But the
>   _inatomic() is somewhat a misnomer, as if the data being read faults, it can
>   cause a schedule. This is not something you want to do in an atomic context.

Somebody is very very confused, and this "explanation" is just wrong
and entirely misleading.

__copy_from_user_inatomic() is very much atomic. But it is - as the
dual underscores indicate - a *HELPER* function that needs the caller
to do the appropriate coding around it.

In this case, the appropriate coding is to typically surround it with
a pagefault_{disable,enable}() pattern to let the page faulting code
know to not actually do the fault.

You also need to actually verify that the user address is valid - as
is typical with all the double-undercore user access functions.

>   Since the time this was added, copy_from_user_nofault() was added which is
>   what is actually needed here. Replace the inatomic() with the nofault().

I'm not disagreeing with the change, because that "nofault()" helper
(without the double underscores) does do all the "appropriate coding
around it".

And then it actually *uses* __copy_from_user_inatomic() to do the copy
- because that function really is meant for atomic contents.

So that explanation really is very very wrong and entirely confused.

Because it was never about __copy_from_user_inatomic() not being
appropriate from atomic context. It was about the tracing code
apparently just using it wrong.

               Linus

