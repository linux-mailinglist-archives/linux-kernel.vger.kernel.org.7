Return-Path: <linux-kernel+bounces-863304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A55BF7831
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19027422368
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF7C340282;
	Tue, 21 Oct 2025 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IVX7j4b3"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D08355057
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061909; cv=none; b=YhbM6OaB/utxp1X0XwgpnYb3lRasKNmdSIZvo3Cff6BRFr2xjJBBpMSKTNqjsGSua1osStKtavedA++SB1zeTgL748xDU3A6bx3tXGtyHr0/jc0j6qZDl47zd7vV/EgrQkp9GUMs1KFHcwjSOnwwH0NTeRWNbrQTkeXtDWsUcM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061909; c=relaxed/simple;
	bh=lViBcaKLu+UAiDt1Nf19hKosCzWDWEUaKqiaIlkaqqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+qe8Px3438iNYzZErF2ROwsZcpglARvtmKxuZsuUmRKS+fEsWObQAKo2ww8K/jgjuJb4W1d0cw6O4rdGKt8BqXx8r9B8piPa5ijhmtkTHxKpxCOhLuiBwAHc84Cm+a0Cj5vZcsy9zW0b05iDBa1Z1c8xjaYi6tuopbWAVxf424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IVX7j4b3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b5a8184144dso941674566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761061905; x=1761666705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+0cSMAwFRMJRxsYANvmyJeRZmZI2zdPSEESzl/tT500=;
        b=IVX7j4b3r0Y1ESPHIeWh8815sJzlcF+mjmohss+B3sEAbfTRtZqY0NHLiN8iTltYMk
         uuBQ3+rYHYxEbl2Gj/chqXjU97ZCTxJ2qN0TV5Ge92VhWdoUWXTCiDpBnqx0rMgWd/aM
         0xzZkEqCnIZwwxANV9IP32XXBcPyDotu9gHtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761061905; x=1761666705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0cSMAwFRMJRxsYANvmyJeRZmZI2zdPSEESzl/tT500=;
        b=H6/Y7tuEIo2vh6LxbknX0rDj7JD2g9hScf7mSSwkpD7zZnGluRWsWnY2aDH1HfUkEo
         PD6EfJBZ8oRZxeBsm1id6OIDJ1C4MCdjMGHTvncwgM2wHLBx8HgLhyaldFpXCUjXxLGM
         yezTyxhIqE9Elv4VjlbRh3SUIbOt6UZw0pg5JgFU7c+Fbkj+gaes/75vcnRrGya/qVwH
         /y2zLyjJmjs1il2YZ6nyv1MuU/8NHXC2Rp1FKsSR/PGA3V0mRvb2H+/n70PrzmSdjFpE
         CbyOn+iriH2U1QuEwJiKjMwZlfB9OfRIl3w3wIDr1jF54AtcmCu1xf4xu+6G1WZ5/Z3O
         g2ZA==
X-Forwarded-Encrypted: i=1; AJvYcCX+22jKGzXGK7MweoE4+gCaZ+iE65Ip/yMZF0tkd+MLtd8O/21YBxzAtbTzgVM9BKrEjy0rkfxR67LNjJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5oBaPak4IlWy4Uu7cHqadRa/9ws9BCmAnlDg/hGb+2h7zs18D
	N6K6L14fGhlQgfRwLlid8hB0eRjguHH0csOkFw/eceubCxiwbqScCW09CBXbHJuKgpvlXDrguWc
	ISOCom70vOQ==
X-Gm-Gg: ASbGncs/HLsuCHC16TMsgNtOd+M9GBEhcXC/sdU1hKH+QlAKZ3m9Z6xEJnnK/W3V2Pl
	Pnqr84oyonzTs1Mpp4cJoaL+vrISdIGOdzvdWFTxpHrJbyxTBrfff4f60pxr9evMqVnqk3PkeWO
	nLLMkaRcL2BoG1GQKzNBdhbo0VKrBCEs76+P0nZL5sTibE4FVWj9276SoiMu4lOwGjMhUlKJw95
	Qx4X+boRoJPGCa7BB4sZLLqxvS5oKU47bjJnkP9zK4Pjf2H/Cwi+toAcz9CYpMJ4FTW8bkcQfsE
	TrDxr/HAcTLyqrlCBAh+qykDoki920Wi5FE6jSComuxfvEf4h5mg5ovrpe2mIsMC/kQxIR9Z7uV
	mz3GtNlkluKtSVnM9Rcl/Vh1m3OlN/0//878iUKGQv29358UlQ9N9rOLX5UlFF95DSjt4y5Phkj
	JV30mV33R7kqgJ4ZIWIFx1Eb0XGeVaGEd43NJl3cB6GmQFmZmciQ==
X-Google-Smtp-Source: AGHT+IF9DmoJj/ViDIFoNSSdc8qEpR8DTghl1+dVPf312qJ7V4k/ya8KGglbQDES1wf7BchvhGfRsg==
X-Received: by 2002:a17:907:74e:b0:b04:67f3:890f with SMTP id a640c23a62f3a-b6475e09c31mr2143826966b.33.1761061904716;
        Tue, 21 Oct 2025 08:51:44 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb526098sm1085153266b.62.2025.10.21.08.51.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:51:44 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso9753326a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:51:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW44T6mkaeTl3raCrqgihHtF2RCNEBF6p6iWgET1ghhIET3pZ+BKtT0zW0Ik8OfefazJnDfmYnNYkCF/Ac=@vger.kernel.org
X-Received: by 2002:a05:6402:518e:b0:63c:4da1:9a10 with SMTP id
 4fb4d7f45d1cf-63c4da19c97mr11628470a12.31.1761061904052; Tue, 21 Oct 2025
 08:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017085938.150569636@linutronix.de> <20251017093030.253004391@linutronix.de>
 <20251020192859.640d7f0a@pumpkin> <877bwoz5sp.ffs@tglx> <CAHk-=wgE-dAHPzrZ7RxwZNdqw8u-5w1HGQUWAWQ0rMDCJORfCw@mail.gmail.com>
 <871pmwz2a3.ffs@tglx>
In-Reply-To: <871pmwz2a3.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Oct 2025 05:51:26 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj3VgQAwUjfM_6f5O5gFr4kXBma2q5m8PLarRCnA8R49w@mail.gmail.com>
X-Gm-Features: AS18NWAG7YIQvZWdpCHOlvhJ3OJWyOrD174ntZFm1lwB34kJVwOkBypjHYnGjQo
Message-ID: <CAHk-=wj3VgQAwUjfM_6f5O5gFr4kXBma2q5m8PLarRCnA8R49w@mail.gmail.com>
Subject: Re: [patch V3 07/12] uaccess: Provide scoped masked user access regions
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Laight <david.laight.linux@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Oct 2025 at 05:46, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, Oct 21 2025 at 05:06, Linus Torvalds wrote:
> >
> > We could still change it since there aren't that many users, but I'm
> > not sure what would be a better name...
>
> I couldn't come up with something sensible for the architecture side.
>
> But for the scope guards I think the simple scoped_user_$MODE_access()
> is fine as for the usage site it's just a user access, no?

Ack.

               Linus

