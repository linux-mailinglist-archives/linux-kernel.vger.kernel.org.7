Return-Path: <linux-kernel+bounces-876084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF79C1A954
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A65A56559F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFD8302CA2;
	Wed, 29 Oct 2025 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/02/VCQ"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3652D8391
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742863; cv=none; b=t8BARhuzhhJcAlTpUhH5e00G0STVd1HWtx/5OfDQXY7XXwQhyyErSFN6nFOCtLuLBhT1S//AEgBv3g84bngAJ8xsHDM2kbsETHq1yVXlPDzTBa6XpTzGW0KOoWqaPlBkiqGPMXEwY9B1pTEp3apNfVnsWPhwtdso7ZfRmnC8q1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742863; c=relaxed/simple;
	bh=J0j9Fu1hpTGL+B/gSUeYs4SAcX3AxlY77L1M7JFd8p0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GbD5Ta96oYqcnCWFv502TtiDO2IkME8gmVYmI+EePr77fz6vRW3vTjl2tGDh4lmKqTNL2a/aFPNFOed2UmTfl9Rozo7dGYKGbX9rRBxLQJzfa1hhkNzDvHdweGfQnnOSLVS/QJvfsmM7UYRV6DHUeMYgjzahzNR5TRz00TYDF80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/02/VCQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4270a3464caso3604795f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761742860; x=1762347660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2ovjL+MYzVmXGq6CvAvmhX8k8P4mycC2CPxReUa6E4=;
        b=T/02/VCQ2qc/Iry8InWzjSbPTrOnrPnomXRWijrhDbsyzvxoWoV5sHnEMwu6MfQeq/
         DS6ZfpMXrkRRvizyaLnTsxKhqN+OlO+4MsLtut1T8r6g8Zox1U7x5MRDcfOt01Pv4uQ2
         nnzVrfWV2kFXSZv1w0evGwyTW1K234exSMb4jh4GB8JxEHBQo6Q+UQu9zeW8UbMFF+lH
         SnJjMSvdMRZCdt0PnTszcUAppNaEWXT6eGBf4TpggXK06HRroCGZdKdSTA8orIkSiWXE
         28p1SA975SDuImJO7lF9avVyvSoZ9oJAnc+i2ALJaxfoEb9YbQHaZCPBkPTmLtiYbeEY
         HmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761742860; x=1762347660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2ovjL+MYzVmXGq6CvAvmhX8k8P4mycC2CPxReUa6E4=;
        b=wLVT6azpPtkD0USMtri6LexZFAy43C6w7rvIraVdnnpkR7P0J3cbEiin0U8CfkBmIB
         OOMBZH/qTTZ1Cy/NTVKOuMtu7C6FFerNcRlyhMW9FS9dXpV38UThaKmm23gEH32Q0iqZ
         sljjjaJ1GxAX5Azw88sCUmXA04RqwosmdvVxoDDMMlGHnJ0VsKzESoFNRCC++GFBXDTh
         vEAC0CwQ1c8D/GUm13/sYRNvpfCbEPmkxW2AGByNQyBRGClmMhcb/bTGiigkvn5pGgQP
         g7U15mAUGGH2B7uzdmbcF+w1IOnptjW0HFAfweY8WocT39Q7xK26sk5SwDmGEjpY6n3E
         z6Iw==
X-Forwarded-Encrypted: i=1; AJvYcCU+Oyg27zXJ4GBEqYZzDtNNDW2eOWCtybZBFeBVujHou82ApIpSJPC5AJkZJkiztZKvx1fMNcJE3ZlRw50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ztpCBWkHecRt8Q/Br7Atpk6d+YilYCk2iUTEvNbsRi1fXYTt
	0AcfYAYgF0H0wzyBlnFT/CT8iDFbWD0Y5CXbV8L0ySAfy6W/W2nUEAGd
X-Gm-Gg: ASbGncudCW+YgNdH6LtDpzDBWkopYyRqJVqASDyTylq6HNmbzPSv6rsUWvUxIRoV4Ao
	cwVx/78aJNvcKQCXMeDl0CwZky90dEZPk7K+z4MuccI9GsjqUacqpP2nVmnYnU5iInsXDXRgUJy
	KjoSWZUKw8CmbHCrS6en9o+6erYej8AhKUEUz59XNw7YgDntORzrVPEWkjgsTomWnWDMCB9R+GX
	SIp/5lhpp2Movg/lyVOKIbHFdyjrdxRefSB5pJZUVGRmffxK3o/2bPV5/GFWif/+IrljNbpDCN0
	dGs2wLsik4rWl5tOars82iD183ccNBcOVJmZzWP6o3y1qzWo0ibOc7tP5OgWLkDWE+jMYWgjnul
	96YL0OBKHYfsJEgh2yFBgltqMqnU64gYXGqD4YkPAS6U6y1bfgVlCxupStWqnGOVw4+Q4BKAp4m
	PfDPDPY033E34z5KiVAa3749mxC3Awvjz/dDis6Qnbbw==
X-Google-Smtp-Source: AGHT+IGqJlBrEpAy+D80nAwqaMFt+XjmQ9xBuEOWAMuScJNB3nO+jGrpfT4FhLOl1SIvEzsKPLCG/A==
X-Received: by 2002:a05:6000:615:b0:3e7:4893:f9be with SMTP id ffacd0b85a97d-429aef71443mr2281897f8f.12.1761742859629;
        Wed, 29 Oct 2025 06:00:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm26292539f8f.41.2025.10.29.06.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:00:59 -0700 (PDT)
Date: Wed, 29 Oct 2025 13:00:57 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: Re: odd objtool 'unreachable instruction' warning
Message-ID: <20251029130057.70a8f487@pumpkin>
In-Reply-To: <20251029100533.GF3419281@noisy.programming.kicks-ass.net>
References: <CAHk-=wi6goUT36sR8GE47_P-aVrd5g38=VTRHpktWARbyE-0ow@mail.gmail.com>
 <20251029095638.06cce7c7@pumpkin>
 <20251029100533.GF3419281@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 11:05:33 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Oct 29, 2025 at 09:56:38AM +0000, David Laight wrote:
> > On Tue, 28 Oct 2025 12:29:11 -0700
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >   
> > > Josh, Peter,
> > >  due to another entirely unrelated discussion, I ended up resurrecting
> > > my "make asm readable" patch that I have had in my local tree when I
> > > want to look at the actual generated code for user accesses.
> > > 
> > > That is a local hack that just removes the alternative noise for the
> > > common ops, so that I actually see the fences and clac/stac
> > > instructions as such, instead of seeing them as nops in the object
> > > file or as horrible noise in the assembler output.  
> > 
> > I've toyed with using explicit nop sequences that would be identifiable
> > as stac, clac and lfence.
> > 
> > At least that would tell you which is which.
> > 
> > Since the flags can be trashed there are plenty to choose from.
> > (eg all the cmpb $n,%reg if you don't mind a false dependency.)  
> 
> As long as you ensure that insn_is_nop() recognises it as such, they
> won't actually ever get ran after alternative patching, since they'll be
> rewritten in canonical nops by optimize_nops().

Ah - I've wondered about the 'nop; nop; nop' being slightly sub-optimal.
But it is hard enough to see what happens to the alternative that is
selected never mind the ones that aren't.

Instructions that change the flags can't be changed to nops.
So possibly the best options are the 0f-1f-cx (for x 0..7).
So 'long_nop %reg' rather than 0f-1f-00 'long_nop [%rax]'.

(But I've not checked the full rules for the addressing modes of
'long_nop'.)

	David



