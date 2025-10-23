Return-Path: <linux-kernel+bounces-867792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 325B3C0381E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E3AC4F0E94
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E5F28489B;
	Thu, 23 Oct 2025 21:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtcIlouC"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DC4254AE4
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761254100; cv=none; b=LO07+Dvwlk6h1xCsAkz6Ns0jPH6RbcCGcpWi9uSB2EB3OFzM3Azml6akpiYVDUT5rdKf2cH9H4hEcpvELPasdNdENJ6/dDKXtUs+VYxH+WRXsNkJDO9cyn+14cZVjO7QC9RysyIZXbiXLBoQJt2zClMfWYkHHJRoznxmFax1P+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761254100; c=relaxed/simple;
	bh=gr//hXY2CACNJmuey8RcSt/nzmsO2m0/uxqUGfrhxmo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQZ1gFLlZK2AmBtTV+sx2cePN9Scx8znr2xYMng9WGb2Eu2j0GD0FySu1copLSwcldYLLsvGy3l9YvOSoLsOmCluSJBnoL2a4hy1oa0uRX5PsVXhUOEKYu7/A5oQBiKoG6tAYVYqqY+TjaAX9HxiQx7cvj98JJX0VoO6fROaYLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtcIlouC; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso1644009f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761254093; x=1761858893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6sEiHIDuaPc1r9BapkeRLwxlBj8uKP+Q15MeH29iBY=;
        b=CtcIlouC854KexNltOZckq+65YjcU0ojEq87VP6S6IyOoSBaSnYdqRzFbID0iIIrB6
         ITLK81ilE4vGCSV9Z/iWzp6HA2BXzh8a82GUuXjZQXBgG2ULQPeEEGdlxlX5mAqSe445
         kDVowmrP1SnntrA809gkbekTTdlr4CWzWw2ADy7mDAhhSH0/F/psWIqmlwhvwugOZOq2
         MG4OuZ/+NqVNPrNsSU1/pvUdjWcZXd1C4MvjFbR7h10kKlN6tsksa+zg677ulWQ/Koqy
         CjN44C97xzY4hMNLtqD2SBlSC6yZtl1cJyW3Py6Ytc/BPIIttcoAGICNtGBu7drCflS0
         kzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761254093; x=1761858893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6sEiHIDuaPc1r9BapkeRLwxlBj8uKP+Q15MeH29iBY=;
        b=Y+3yLG2SKZXKD2G79ZY+eFjk0xeZBwf6udP40uGNcG++6FYWYNW4hDO9JqVX+oWpG2
         yVTimcyeliSRk+OS3HcOZ0O6ZT1Bjs1fzUnu16NcSHMEExwN5mDetztemgKQVoRUqP9L
         yZRPbGJx8rngDdyPynd4XqVNmQEILo7eWUC8YNq1YrUwknI0VR1palv99w7tv7RNOiAu
         wJsTIdAozCRtxdDMwQC5UseAJQ6wMdssE5YdwBEIzxtvObO82GSKeMCZUo4RLoTtoFux
         Z/NW/X/dQVLd/FPN0p9GIrt3X+XSohC1pisnh2bBi0cn4vA1NPw/In9497LkSNXAM0q6
         Q14w==
X-Forwarded-Encrypted: i=1; AJvYcCVUudkH82HA/eN65NKqPXoFx5oKffq2E3fkBDAJSBbQO3xk4Gk+ESBlCNwQ492P3PEU5emiS7Jttclg+Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ4z/VUl2UzntuC1Vv7eECUAt3JsnqDnnxq7QtcvFSPXjL6QRG
	Ucb5MeRTie9hDRH+cevGBSFQ7dParZH2hkRDOSSj30EoavsF5abzXpyV
X-Gm-Gg: ASbGncvQHtr0i80hkPI7xsPugBFPexiYbrXwxw6agbXYPHt+499apPONUAdaVEQ+KSB
	bsUEuK/qwc27lA+miuSrfAni0GTpnWL08xPz+yPXFRuXm1fiUdcNRILqhxmk5HewiLClqbaFsWf
	MPD83HfH0ChbQ/TQqqhfu8zpjd15CcDD5wVBFsZwzq2iRVFzqhbsMPLuHkcgk1tIRr72Hb4kk8m
	pfaSbzDxODJpqbgy38aOeHTt2Cz2nPzEApyfxB8COC/tk7bBmu/5fW1hrq1muY8PX96iNa7fu+T
	82YWbNGvDUagmG/GR9rn/N/dfDXQqNjg5pYYTTzPOSgKCAcd+1fgASxaQ51g++XSm6VZqD/0omF
	UuoKV/6TNuSPRjBxjIbrWfmsMzUNhmIzwEYK5OLVGV3oeKWNCnC31Mt640s8np0xgRNotGjaw15
	HJyO2vO1WN8qkGwoi2wFzlfaxFISeI5dbFI3jIaQywMA==
X-Google-Smtp-Source: AGHT+IGk8eEDWy3Lb1qhGeYZ8N0urG/YCIu8xY7+WZCUmyVKdYxjr9Zc6A6l5BFcgm2g7Vw9SfAVXA==
X-Received: by 2002:a05:6000:1446:b0:427:374:d91e with SMTP id ffacd0b85a97d-4298f545550mr248975f8f.11.1761254093423;
        Thu, 23 Oct 2025 14:14:53 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897ff3f5sm5951290f8f.22.2025.10.23.14.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:14:53 -0700 (PDT)
Date: Thu, 23 Oct 2025 22:14:50 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, kernel test robot
 <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Heiko
 Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas
 Palix <nicolas.palix@imag.fr>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [patch V4 10/12] futex: Convert to scoped user access
Message-ID: <20251023221450.1303003d@pumpkin>
In-Reply-To: <CAHk-=wjoQvKpfB4X0ftqM0P0kzaZxor7C1JBC5PrLPY-ca=fnA@mail.gmail.com>
References: <20251022102427.400699796@linutronix.de>
	<20251022103112.478876605@linutronix.de>
	<CAHk-=wgLAJuJ8SP8NiSGbXJQMdxiPkBN32EvAy9R8kCnva4dfg@mail.gmail.com>
	<873479xxtu.ffs@tglx>
	<CAHk-=wjoQvKpfB4X0ftqM0P0kzaZxor7C1JBC5PrLPY-ca=fnA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 09:26:12 -1000
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 23 Oct 2025 at 08:44, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > But as you said out-of-line function call it occured to me that these
> > helpers might be just named get/put_user_inline(). Hmm?  
> 
> Yeah, with a comment that clearly says "you need to have actual
> performance numbers for why this needs to be inlined" for people to
> use it.

Avoiding an extra clac/stac pair for two accesses might be enough.
But for a single access it might be hard to justify.

(Even if 'return' instructions are horribly painful.
Although anyone chasing performance is probably using a local system
and just disables all that 'stuff'.)

> 
>            Linus


