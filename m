Return-Path: <linux-kernel+bounces-776281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5C8B2CB4C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162153B5CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030B9304989;
	Tue, 19 Aug 2025 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="PwjEPLRh"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4F730C35C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625289; cv=none; b=OVvvZvfc/tbuBVdOK4w66QNckGbsn3LSAuCgTL57EbxwMmK6csh+QljTaKsbg3nlAmSF9V7CUGcRepqdSQsy/tkVFqkVgNV1te0L8ysAI9Xba9/xD8QCoyeWqm0YbMo19cdHY9N3SNAxxtxqZuhGhA2IUddEu0NN/Pxu+wNjyiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625289; c=relaxed/simple;
	bh=+ZNj1HcFzFEzTsVNNUkOo4C00BomnTW+NWmMN+gwO4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiLDgjQpZLsk/DW0A3c19ahAG5PDJw1Vsx7Sn0P82C+FMHnyq8IqWLuvOlbQqQ3gliIke+agQg30F5G7ihhUT9l7f2j0vnw5mFkZQTTc1/vpG3gG+dLoxecv/JR3hymSDpxi4OTqy8tgkx2un43M3vbhLBXFogFzxGG/GkOyiL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=PwjEPLRh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24458272c00so56345175ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1755625287; x=1756230087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=teuGKT7fD7BqQaVOVSC99DwCoHKWjixL/j1wxmLdi+c=;
        b=PwjEPLRh2P7FAGS1uPVwfJYkrgpfoaQQs+4JOCKr0t3V8iUSI0HFg00dz+D+8ufD7R
         6p/+Da4FfozgOm2Senc2uv/o2QG7uJj4l8Nt1GVQjS9MK52dI8kYCO6P4dClhuPNoo6y
         PrHnseEqPQk0BOlWz1Zp/ct1Viz4fcO5FM6kdGevJC9V/KMH3P6IhXVRrIbJYJjL3lfQ
         mYuWgwysPx9dbCijVAz5rkY9m1Kl+o+1HojfygALpcuSVZLCGc12G3axOdCkShUbdz+i
         0qAF3/8kmLzsmepu+qaEh/qeMujFEhJc6PDV9OwGFBsSM59hPh89kFD6yVSHogxaEZau
         5VCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755625287; x=1756230087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teuGKT7fD7BqQaVOVSC99DwCoHKWjixL/j1wxmLdi+c=;
        b=pcL5GkB4K3FLA51d0ib04LmSjROCR4UlRV9qbZzWsKJqD87GPM2DyK6seIOXu/mJ9r
         TgVd0CKLZVVMdAMZeZlE7eOHNXizLi7i5vcdFi0BqE1rPnA5dnZWuID5a+hfa4rdG9Oi
         Ip3xxZN1jdyG4wG8uZLPkCr5+6fvlWG2L4+G7LO4Mxx42JvfF5UVwnt8Pkl8UVdGZljL
         QMYWSQIfUSLKCkWnfrJoVTX8cdh32mmfwvFiZ/1QqHmtmMf+18gblwqxZawN0zgAFGun
         y+NwQbjDl4Ni5ion8sMKsB1FJT8LxoU8i0OJ/i5b5D4VYudSEokpY0ILAaqxK5dyeWQx
         Qtcw==
X-Forwarded-Encrypted: i=1; AJvYcCXOsVssS0mQT0uKDsmNizAxLV+FwZOes5xAcLlGY6J07YE1apfLYSpiAlgMWO8Bgt1BWf4CRF0ecwDEs3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlQhouNNj2WNQWM5W0WSjwgmYH7uqCIg8Y7iMk1HGdtzpT1/xQ
	imqBxjM0NPPwd3lvntIbKAyEPt6Q0+GfpEr2Tw9EUP7hG9vV/VBh6LogI1FUHmSX8N0=
X-Gm-Gg: ASbGncvI5Ti3a9t0r7iSmCxK/2DU89fNA7PMMm13fggaTlUT3uzQDSHq0RRrXk/8POI
	LmBD9uhcYjNcUwUb7dc+F60stDQkNbBYMgI2NZzpUO9QbG16fUAyYwt/7VWx4QsWJzxJHDg8BZY
	hmk6adU6ijaB/5o42sswxohdh8pjuS+rJC/WTI/pdNEojzWi0Gmu+PZ8Yx5lJdVazxAdKRveFDX
	2+aPhVTcnew8BoDlGHTakCa3Rm6Ua/TfIhGhH4vsUvk3P5rA1PCA808KOwvWfeFg9UXBn7JCCUV
	0vGEN2cQJWdt7qKf0AFVPxZ7BUHtspNAK7k8IQ8tT4ijugW4uCdzd+687tKPdjaKGD582WUy/iE
	xr5QMWqQWLT0nVA9drlcVUdBRy+mIMHpO
X-Google-Smtp-Source: AGHT+IFTdQwSj3DC9CetuORCeCyKDcsyEhmSCd1AFXaoCYq74iT1e2fQ1LYumTEfnH3yJtPvqO/l2A==
X-Received: by 2002:a17:902:fc4d:b0:240:3f36:fa78 with SMTP id d9443c01a7336-245e02d7366mr39174625ad.21.1755625286818;
        Tue, 19 Aug 2025 10:41:26 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c73fdsm2837575ad.98.2025.08.19.10.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 10:41:26 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:41:24 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"mingo@kernel.org" <mingo@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 5/6] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Message-ID: <aKS3RHf9AC-nbdKo@debug.ba.rivosinc.com>
References: <20250814101435.GA17362@redhat.com>
 <8818b456954644ce609e07d77a65714788ef9098.camel@intel.com>
 <e50065a9-d5e2-4e94-94b2-e34c5fac9720@sirena.org.uk>
 <78b04d05b94b605f287b9a594cd2aa9f1cda10df.camel@intel.com>
 <6abf383f-2756-4de6-a951-6121f51263e2@sirena.org.uk>
 <aJ-Gc0X0J2GzgmnX@debug.ba.rivosinc.com>
 <2b1a11ea-7b1a-4d96-bf72-0e55227f7d21@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2b1a11ea-7b1a-4d96-bf72-0e55227f7d21@sirena.org.uk>

On Mon, Aug 18, 2025 at 06:27:02PM +0100, Mark Brown wrote:
>On Fri, Aug 15, 2025 at 12:11:47PM -0700, Deepak Gupta wrote:
>> On Fri, Aug 15, 2025 at 12:44:14PM +0100, Mark Brown wrote:
>
>> > confirmation would be good but hopefully it's fine.  I've been holding
>> > back on sending a rebased version out since Deepak was going to help me
>> > get set up to test it on RISC-V.  Though I see now that the RISC-V code
>> > has vanished from -next (I guess due to fallout from the issues with the
>> > merge to Linus, it looks like there's almost nothing in the branch
>> > currently), not sure what the plan is there?
>
>> > Perhaps I should just send it out, but given the difficulty getting
>> > anyone to pay attention I was trying to avoid issues with missing
>> > updates for newly added RISC-V shadow stacks.
>
>> Yes I was trying to get that sorted as well. Because now I'll have to
>> rebase my changes to 6.17. So I wanted to make sure that it applies
>> cleanly. I suggest that you send it out because risc-v was left out
>> anyways. I'll apply your patch series on my risc-v shadow stack changes
>> (on top of 6.17) and will report back. It might be easier that way.
>
>> How does that sound?
>
>Sounds good.
>
>My main concern is that I don't want to end up needlessly holding off
>either series due to dependencies/cross tree issues - I remain
>(endlessly!) hopeful that the everyone's happy with the clone3() work at
>this point and it could get merged, but if RISC-V support is going in
>then it should support the new interface too.  Hopefully we can do
>something like apply this on a branch and then merge that into the
>RISC-V tree?

Yes they should make to upstream independent of each other. There are some
changes which I can adopt in my current set of changes (like change
`shstk_alloc_thread_stack` prototype). In your current patchsets
"fork: Add shadow stack support to clone3()" will need riscv support. Other
than that I see that support for `my_syscall2` for riscv arch will be needed.

If clone3 changes make in before riscv shadow stack changes, then its easy
I'll just add riscv specific changes pertaining to clone3 in my current
patchsets. 

If clone3 changes are later than riscv shadow stack changes, then I'll point
you to a branch from where you can pick riscv specific clone3 + shadow stack
changes.

If they both are going in together (may happen for 6.18 window), then we will
have to coordinate on which one applies first. So let's keep an eye on that.

If I push my branch somewhere on github (riscv shadow stack changes and then
clone3 changes on top of them), Is that fine?

-Deepak



