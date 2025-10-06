Return-Path: <linux-kernel+bounces-843179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7557BBE92B
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF1024F0548
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 15:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074432D8DC4;
	Mon,  6 Oct 2025 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WWBFenpo"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316EC2D94A6
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766373; cv=none; b=as9ZC12L6IPUskmxkcsYRKsgGZFtykd1CfFR/Nrj5cHLTBc0EieqCvqvgHRYLXaKbwGuJnuvxQy3RXAWUoYqam1DwqitTUNYbWJPC23O6nu96WrAyVWFC2nVmn0vqmkmJ0GT8tXcGoW2fg4VfLLIFW426/F7pD6fzNVLmkI9/kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766373; c=relaxed/simple;
	bh=BseUJKpsLaegLmNp7WT0g4mpkXoh4QdEttJnOiyLuW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bo2WjVrhk/vQhTN1KqfDKof1uqIcz6mXe8lldVHhd0oz4aoMsPVq6b3yjUsuR90vY2CM0fYks2P1IH1y47KlIyB0Vhfmxdfy+wAOPmM8zHsW2pyxsIsKwH/2ii08K9ooBMvNz7hCYD25IEdAqGLA2VKhZpaWaVj74kXyK+hNiPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WWBFenpo; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-637dbabdb32so10083818a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759766369; x=1760371169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LCD1fiV6Ykufjk0Uq+8ppkf8Grb2SGTaTNYyOwubFaU=;
        b=WWBFenpoeSBvRNO/igF2oUvP9xnUWw7KFtkYt7QpibPQJWkow987YPwoLAm7AsrejM
         u9FtiX+rn1zUUlDB8g9L+B8RPYcLEVbj/hSCRwpUmQmN6o87tQ58hf7j0ZRJP8va+Ibb
         rmU81eQhEE5jZT5ZNr8BW5G1WzqU8FdwIiNDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759766369; x=1760371169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCD1fiV6Ykufjk0Uq+8ppkf8Grb2SGTaTNYyOwubFaU=;
        b=FV5KfTt1BqAwZOpzaCZe3X320an2IwYw7GxUxmP550ew8LT4/oAF3qIJVCwL77GFoP
         bnN4J7pY58lylBsiJZBOoPwWPg63CdahUfcmKb3Tdll1HqURb8VUvmcCfdixNyuPnID1
         Md6cabQTb7KSRBfr3oL1z5kV+SpSpxfhMzY8HB6EOwPlOcpEF3IopkGlyVlYoXrL4EeA
         drnJ5qUgCsQbKv4jz+e6UFKtsArEK/wtf+2YW/BWML0sn5acImMoVnDZiFNNDgvHidwX
         XY8J4rdblbQGULHYRcnVAD8kdar4Me0DjjF1hEQVRIuuv1Iw3qjkMCkWJ9Ul95lsmJOQ
         dIHg==
X-Forwarded-Encrypted: i=1; AJvYcCWtFTjro/hOkoy9tnPBpUCeOhely+bDaA0+dFQerUbtdqRpntuRVzNNUjDQegMFSn+gZfoHDU0ce+3KaiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBeON1yxhyEbnLXnT7GE9E1tNdrwVIA9Y8LddLvh8jpUmYF/7f
	W4JqV0DTXer2EUfz5fCwTqlqkWGNHhV8eE4Bft/ZSxsCfZU3a+UzQ7br/It/rS7VhN4nceApcEK
	gBfGIuUA=
X-Gm-Gg: ASbGncvjjTGRfJxLo2h9HKsFMZahsTeJxgyThc0M3a8ukKdLlvhKIwr29X2S8WoA3Zo
	3YePxAebbzKq8HAcbsatkEEXCfpFcUbfTaXWPF9KUBPXAFfanpLAev7ZetSNDSRQEoDarkNFPyT
	JtrncPkygzfIREkKdIDHQhczH994eY+MDpYsgHNo1zhskKKYKrEhPsveItrq07R3gEZjKXgNCBu
	wfqScB47d3fBmWQVlTqKLxlX7pESKxIXVz4e2S1MRyeDpRgbpSCioMREjB4UiTe+PaybIrLokMW
	YxCH1zcwTKqfD2Zh0jBlKd6b8zVu2fjvPE9rKD1AgcyEs+DpbfJoPqTS9DdxhyfAsWZvP/7I0gK
	oEqx4enoinLyA51tvQSaOog71OlfrXCFDOq3HHDHttfYiTxeLH2qrbG0NDby+THPxiYBYdVP+LS
	Ih9SCnTN7KcR1SEE8gIV4TrcVKs2F6Nd4=
X-Google-Smtp-Source: AGHT+IENjsfgVz4kF/HWH7RWsH/kfZSlPXobJx13Y5N65i1lAHrDjsFnceZCvJcxdLJUlEJ2Tf29ew==
X-Received: by 2002:a17:906:d554:b0:b41:fe09:7411 with SMTP id a640c23a62f3a-b49c3932ddcmr1627188666b.39.1759766369226;
        Mon, 06 Oct 2025 08:59:29 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4f314sm1164756866b.69.2025.10.06.08.59.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 08:59:28 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7ae31caso947882366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 08:59:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW81oUXP2CiJBcAaEtckeQ5dzt+VUZcNx1HbL2xkoP8fQhSFE2my6U/UZco290e5dIpcx2xvjaV6a4a4hM=@vger.kernel.org
X-Received: by 2002:a17:907:c1e:b0:b3d:73e1:d809 with SMTP id
 a640c23a62f3a-b49c3f74b27mr1880978166b.48.1759766368026; Mon, 06 Oct 2025
 08:59:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926102823.GAaNZqxzXkasrXXFjn@fat_crate.local>
 <CAHk-=wibOJBAp66CPz0qfSWe93iisGvN4xL_MzuwSZ8sAut09A@mail.gmail.com> <20251006122857.GAaOO2CX8vkmVw_4Ya@fat_crate.local>
In-Reply-To: <20251006122857.GAaOO2CX8vkmVw_4Ya@fat_crate.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Oct 2025 08:59:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg65RDkvPd3rFZr32n8L_LQJAcWie1K-=azcLS6Y5JwkQ@mail.gmail.com>
X-Gm-Features: AS18NWCNInP8kSIXjDfWSThMWelX_gKZP9WX9A23FmZC0fMqVGwlDO3sipNSCik
Message-ID: <CAHk-=wg65RDkvPd3rFZr32n8L_LQJAcWie1K-=azcLS6Y5JwkQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/apic for v6.18-rc1
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, x86-ml <x86@kernel.org>, 
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 05:29, Borislav Petkov <bp@alien8.de> wrote:
>
> Sorry for the confusion.

So the biggest issue really was just the explanations. Both the
explanation for why the merge happened in the first place, but then
also the resulting explanation in the pull request.

Due to the merge, I feel that the explanations in *my* merge ends up
being less than great. I think it would have been good to just have
separate explanations for the apic init thing and the SEV parts,
because they seem entirely independent.

But maybe they weren't as independent as I think they are, and there
was some deeper reason for the merge that just was never explained.

Basically, a conflict is never a reason for a merge. That would be
unphysical: conflicts happen _due_ to a merge, so a merge is the
reason for a conflict, not the other way around.

If the merge was done for some linux-next or testing purpose, then the
merging should have been done in a branch _for_ testing or linux-next
integration, and then there would be a reason  ("merge for testing /
linux-next").

And if the merge is because of some future conflict resolution, then
that should be stated too ("This conflict is so complicated that we
don't trust that Linus will get it right, so we're merging it for him.
Linus needs all the help he can get, and he's not always at his
sharpest").

But "merge due to a conflict" is simply never a reason in itself. It's
like saying "The sun came up because I woke up". That's not how the
world works.

            Linus

