Return-Path: <linux-kernel+bounces-771378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA8AB28638
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9565AC0609
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735BB27F01B;
	Fri, 15 Aug 2025 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="BKnuCTj0"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF6227AC5A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285112; cv=none; b=PwVmaR61azwikYReWYvZ/cw71XmKYRyrzi4iMlgYz48hn62v0kML2Pky2UMMZVQv0lrB0t6ixkH4/uhAP2esN0vg7QPlIlvYFDUqpik4k8zKxUAubTa8WfWK5ulIc7OhO729AKQfEFQXizPUXa3IPGpUTumyniLMXI2siVUwiwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285112; c=relaxed/simple;
	bh=Cl0l4USkrS6SMxwAIg64vflhymXTsZ6xuQXFM5FvnMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtliskXHxaEaDHQLUA6pIw+1gXXmqAp7VcJ561JySI8Em5R4A8f3h9Ayt8Pa1TDQ9wbWbSTw72UciwtNX9TK2LcppIuWqBqZzFPC+ZLXCUOr3Lnuxy3Dw5BOG12Gvz8OM3IpF3xHozZpIKoXVuAMdOpI49MXTAAX2nEZrRYB1Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=BKnuCTj0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so244815b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1755285110; x=1755889910; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hWC6kxZvVjQJygt8d/LDnOWypJyO+Te6j/CoKCQu0RE=;
        b=BKnuCTj0p+7nPxVQy76ubM0iH5MCCnYN1q5UOR5Yp9pK5yVx+fkJIBrzeZRxe4Dpul
         ywcjQPbE9RpVMkl3EV8R2nX0CCpJk0bkTlQFqlgrj2T+CvUGiKbDWOqVzegu3w2fX2rT
         DkEV3SWgWzAjI9AcTBNO2SCX09mnhDdyNfHDiYxvRZgOopc41UBmYl7Y3fhGtlXLf7rI
         QYvAFwWxJEeIaSehFrdh12lCPR2/EvUXqUVAFbhG2tqrC+w8hgPH6gqPXSGmo1kqLeKw
         CNlPCk9lUSkOKySIMgB7XlClzqWRSfCbsHKtEH5a7irpdSXAy8DUApFpK/6RwT3MS/Eb
         4jBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755285110; x=1755889910;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hWC6kxZvVjQJygt8d/LDnOWypJyO+Te6j/CoKCQu0RE=;
        b=IoOp7kEqwO96pws0Bye9D/P9j+QJZd2OKFycr+e6/hNlvEceEUwyOKn6zvlEo2750w
         1LW5HVnkexjZ+Re3b0nFb+YfnEJcNEqb9b0MTVIobvYT0/oQBqoQK2c3hBv/MIejPG1o
         gZNDE8C4m+Q0ISJIAHlDCS/I8ow4f216koGE3Ny2G3oAV/5pI1eruXs2COgFe40k33RU
         SUv6gjYBe2ikKj2F+kYhYlHij7cKvlv6ANDUDkRxy4r02TK8Wy6P//CHI/01YSsf/RiP
         +mfWW0Q3FitFRQf4rkFYhFGXdv5IW5N7V2WmesGLiIywylrL/C8lNBpXt+OsXax7Wekw
         nsbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcJi6LERTMmoxMIs3YYfZ4AM0EOGYuUcjQqgD329V596Tct5Jz9s0xmnuuqZpokN05/VESw2DBVydxB1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE/nqp4cd0e+SFD6tYatr4ZL2YvPa5Lf4Z51WLesV37K47TGzc
	ZETDPeky42p+QT5C77S49AibU1mzzs08/cudbwbNdaMac2mWBzfe/Axks4R7JDIA0Dk=
X-Gm-Gg: ASbGnctay75nbHlTCmuowdPyertUlniBY2LDz+2nhlCmIx3xoSBiFmhQeNI1hw/iq6P
	I/d8p9gwr6x89NVWC+u0eYdqfJ/MjQ+HTOIjGmDSjxsyx6NLeaDQu62xb6MkT10ONhJp76eGABK
	DVRbr8p8FEeq+yT39vyaPBGUw7v0aRxOKButOuM1cngt3rn6YwSwefVyQNcu0G7X+fv2gqQI98Y
	u8CFXEAQFGRIw5RcRsB2n6kWML9wCMBEeGDiw/vJvpn1ZQhmkwovBfLE/FeKO0RkpZkU7P6lFm2
	b+jBPdNzcjJJMaTixqPLcWaUlumdI2u1fOE8kDHYKiYVVyHbtToc/+gfXmPK6Ycvq12FTOrXxyC
	YN4KJgmwAnMX01kwsWiuR7IfPvyDEIwkq
X-Google-Smtp-Source: AGHT+IGOgwnPQvNI+vC8HvmDGATQ5PY57yXcgexWp5sGd797rpWShdna3ArVQLuGqnASVHGgXfeb7w==
X-Received: by 2002:a17:902:f683:b0:235:f298:cbbd with SMTP id d9443c01a7336-2446d741468mr37654175ad.21.1755285110353;
        Fri, 15 Aug 2025 12:11:50 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb0a003sm19873245ad.51.2025.08.15.12.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 12:11:50 -0700 (PDT)
Date: Fri, 15 Aug 2025 12:11:47 -0700
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
Message-ID: <aJ-Gc0X0J2GzgmnX@debug.ba.rivosinc.com>
References: <20250814101435.GA17362@redhat.com>
 <8818b456954644ce609e07d77a65714788ef9098.camel@intel.com>
 <e50065a9-d5e2-4e94-94b2-e34c5fac9720@sirena.org.uk>
 <78b04d05b94b605f287b9a594cd2aa9f1cda10df.camel@intel.com>
 <6abf383f-2756-4de6-a951-6121f51263e2@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6abf383f-2756-4de6-a951-6121f51263e2@sirena.org.uk>

On Fri, Aug 15, 2025 at 12:44:14PM +0100, Mark Brown wrote:
>On Thu, Aug 14, 2025 at 10:43:45PM +0000, Edgecombe, Rick P wrote:
>> On Thu, 2025-08-14 at 19:33 +0100, Mark Brown wrote:
>
>> > Perhaps we should factor the logic for deciding if we need to allocate a
>> > userspace shadow stack out into the arch independent code and do
>> > something like set a flag in kernel_clone_args that the arches can
>> > check?  I think the logic is the same for all arches at the minute and
>> > don't see a reason why it'd diverge.
>
>> Sounds good. Like a little start to this:
>> https://lore.kernel.org/lkml/20241010-shstk_converge-v1-0-631beca676e7@rivosinc.com/
>
>Yes, exactly.
>
>> >   That'd collide a bit with my
>> > clone3() series, there's some overlap there with that creating another
>> > reason why the decision would change.  Reducing the duplication would be
>> > nice.
>
>> Argh, I need to test the latest of that still.
>
>Yury pointed me at some newer x86 systems I was able to get access to so
>I was finally able to test that one myself before sending it out,
>confirmation would be good but hopefully it's fine.  I've been holding
>back on sending a rebased version out since Deepak was going to help me
>get set up to test it on RISC-V.  Though I see now that the RISC-V code
>has vanished from -next (I guess due to fallout from the issues with the
>merge to Linus, it looks like there's almost nothing in the branch
>currently), not sure what the plan is there?
>
>Perhaps I should just send it out, but given the difficulty getting
>anyone to pay attention I was trying to avoid issues with missing
>updates for newly added RISC-V shadow stacks.

Yes I was trying to get that sorted as well. Because now I'll have to
rebase my changes to 6.17. So I wanted to make sure that it applies
cleanly. I suggest that you send it out because risc-v was left out
anyways. I'll apply your patch series on my risc-v shadow stack changes
(on top of 6.17) and will report back. It might be easier that way.

How does that sound?


