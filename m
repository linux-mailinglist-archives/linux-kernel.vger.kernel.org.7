Return-Path: <linux-kernel+bounces-889575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A69C3DF0E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE18F4E6DD3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D38C13B;
	Fri,  7 Nov 2025 00:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EfZWOr9e"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FD228F5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762473931; cv=none; b=PsbUFK15MD3KmoAnFrwaIaQSnoYTz+pDhYGM5h7ZxaZ5sY2n6KIzAEbVnQYOIBhr2XRNmmIcBBBtpJBRMLSdFvwUJsnFDyDVAlfIGxFxvIWhklGPsrziWYTSU7TTRvlagP0j0WLodfirCSQN80bBXKh1a4V7z+HLgtTGt+tN3uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762473931; c=relaxed/simple;
	bh=JvQcyTGbIEdjQyW3vauSTT5vF3wwevsDGfMKipoR3Ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+lgFQvYT+vl6ASNKKy02DQcHT6iVO4x17650svHAd9THBC8AN+RERFy+ddvnpyRuGdGFywj+5Z6+5r+pbXPveHzDQMbOO/3DYet8hc92RK17+G+1rH+PNKLxF/EN/cSZbtaXpohJVv7KuJ9Hh7sKA2TOKeUnvSOj2hWU7IpzJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EfZWOr9e; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso330216a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 16:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762473928; x=1763078728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RFcSpZH70/7YNRB+5bxfaf4cWVrjbOzG9BUCsOhtLR0=;
        b=EfZWOr9eyyu+mVmeTFR6hsh3L4N3qNuf+73dNefZWCsPgnZuaiUd7bsXWQ44VO0FMb
         Yx/xwK7etUlGKLDYnB7TBEosyYrD5iJ70c2iU8P03kmrM/lAQR+DrQM61rHeGw5mlpBr
         taGTENrdq/m/lSm1qSiMPlEcYay0TF3J8A7O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762473928; x=1763078728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFcSpZH70/7YNRB+5bxfaf4cWVrjbOzG9BUCsOhtLR0=;
        b=Kq/5KR0I1MvN61tFga9DHOKkEeJ8zoP01A2NcTt5CAu3PfrRL3j8BZqELSG9SuMTks
         A/+W6Rm43j9gRsHIxT3loKugFiXkE7LtMur4SqEf1tlLblbIA7/BBEYoQrWSCzWnT60T
         xRBqZ13S1IKDSCIWaq0jHGz8twahuVq42x+h03IT31Fbi66pVDbYxjZ0rV/gwA2e4KNf
         1pMZxo8tfeCu+g8gb6hfitGblPBar2K/SQWgmmd64D9sF5CBfmv6IHy2W4zg7R2BkmZh
         7bjQRYwRzkRiRH6ebKvdspOaFgpUGLxwh+7ZU65AjiZU7UOSdrndwrtTfeHVB+adQxvr
         YCXA==
X-Forwarded-Encrypted: i=1; AJvYcCVAG0QLvyTDeyocM+lFmvQYi6KbZ5ya30igATNW+zUuJJAt/zCfQmmzPWZ57h5/8JYZNIlhib1tsmK2JS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS4ZIgFah5DTcnTiOgOKNDIY8he9NFHwX11m4yLtiygu7VO7O6
	1735LyRs0KP0Aeq9gyVu4wLxuUycl3tLoohN7UcaPkq4IaYZvTMQbnOGjuE84rtS8/bvdjIH7uH
	eheLD5sk=
X-Gm-Gg: ASbGncu2njsEtl5HipOEGHEiO0YKd4fgriBDbTGrPkD6VMyHsB/6C0Zcwh7RHVNCxot
	ChanSt5nFTWsXkHzCcF5g4mYWPcnI3/1kFA2C0hInfrKKufK2FlqOo/2zITIIrEnp4snxRsoqs3
	a/nTvP9dqpnMunWG2kgbMKnE8MLP3MX/RghBrcQFLimcgCSdjdoFEmDnVyLcX128HnnUB+RRIzB
	DgJqoAH87drT5cgPrSXAnz96h9IOmoX0Pabkl9Y2ToP83rwFE68xEU7i2hjrU0MMDGxY9SEoy4/
	22zioguX2dv5wqyPu4qzSlYlPxr6oI2tRtP/rHAAunT3saiPm6S5GwO6vDyahZVVKnqTSGeXxpi
	dqe2gGCdLTvpo9H/N6g5pGttbptaiXD7fqVBYV6Y4AtsExBHR9meQl+mvEmEZs70/kf5XNdxaxi
	Q0Y2XgqlTnWFBAeSkGBwxscFub6RpTNyPuczaLVPHxxxZBc2YwiQ==
X-Google-Smtp-Source: AGHT+IGsgJ9kR8c/SnP9W2AAXOwI4xoUKv4u7TD/ggVKL7Bn96aoRPNg/iSjzOkmK/UoqK9YSMhmxg==
X-Received: by 2002:a05:6402:461c:20b0:640:c849:cee3 with SMTP id 4fb4d7f45d1cf-6413f1fa695mr1022109a12.34.1762473927666;
        Thu, 06 Nov 2025 16:05:27 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f713a68sm2874806a12.2.2025.11.06.16.05.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 16:05:26 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so26882566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 16:05:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV022cPVxnoA0obZLDJ38qpAQd6+7d7+Mp2U8Nqv/VH+Q03q/5CuU+BMJ+7y12Gwx5LMQ1yxj59C5Ps7Jk=@vger.kernel.org
X-Received: by 2002:a17:907:d86:b0:b72:6d3e:848f with SMTP id
 a640c23a62f3a-b72c094e5b9mr108513866b.19.1762473925385; Thu, 06 Nov 2025
 16:05:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wi6goUT36sR8GE47_P-aVrd5g38=VTRHpktWARbyE-0ow@mail.gmail.com>
 <ubqjeplvslhnspqw6pnqwo7c6sq2ygdtmkuqr4q3hjlxfkuwii@xn63k6qz22mz>
 <CAHk-=wgs8+xVbv5tu9kv5n=LwWFZ0FW4GPwVmXBPjLQ0goLfjQ@mail.gmail.com>
 <es4awalt6i63cy5kkrbz7f22cxpt4zbmq6zsbol3yafek2375e@6b6stnc6k6h2>
 <CAHk-=wjhcrqXoTLMjTF=pH_+Zq4vRdFY3Y4c_A3TemzSvssRzQ@mail.gmail.com> <20251105195103.GR13846@twin.jikos.cz>
In-Reply-To: <20251105195103.GR13846@twin.jikos.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Nov 2025 16:05:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgb-rq67WdzzK+=tiL1_vGn46KU77KdEHLhNKMPyD4gww@mail.gmail.com>
X-Gm-Features: AWmQ_bl6ZrEgFK2-yALeh_5th5o4wAcU7GMXqFqu3QLuCqWT9j7WE5ZmQm3JI-c
Message-ID: <CAHk-=wgb-rq67WdzzK+=tiL1_vGn46KU77KdEHLhNKMPyD4gww@mail.gmail.com>
Subject: Re: odd objtool 'unreachable instruction' warning
To: dsterba@suse.cz
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 11:51, David Sterba <dsterba@suse.cz> wrote:
>
> FWIW, 'objdump --visualize-jumps' shows the arrows, with
> '--visualize-jumps=extended-color' they're colored and it's readable.

Hey, hey, hey - when did that happen? I've clearly not read the
man-page in ages.

Because that's _almost_ lovely. If objdump just handled relocations
more sanely, it would be really nice.

[ Looking around in the binutil sources, it's been there for five
years, and was in the 2.34 release ]

Because of the insanity of relocation handling, it shows regular
"call" and "jmp" instructions out of the function as branches to the
next instruction (because that's the non-relocated info).

And because it puts the visualized things in front of the
instructions, the end result has strange random indentation depending
on complexity of the function.

But it's tantalizingly close to great, and it's certainly an
improvement over not having that at all.

Added to my "disassemble" alias.

          Linus

