Return-Path: <linux-kernel+bounces-836698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7AFBAA5BD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1801923A94
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57B523D28B;
	Mon, 29 Sep 2025 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="BHxl/QZs"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A660222F76F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759171074; cv=none; b=Qw7AMBoiR7o0znrjRSIPjVRWts8U0VC2NGdrimXFiESjLwUuapx/Wa9ijrphgru6cFBHyByxAa3AWqJbujlj2YbQGTn1J34If6eEHb4AL01iujRHFwehx84yN0NxeXW5jeV4HEx0HfbC1RgcsPvPxEWWHVeqmaH5cUmA44QS9uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759171074; c=relaxed/simple;
	bh=JQE3aDLBn4uEFiQFU9/nZ3ri3B1AK5jMtTpQbEJ6b4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVcMX8Td2MGRw0wJyQyk+RoE+TnFmz7AKCg/W0sL/EXr9G6konbx00WhKTkmRAm27y/SkeqODMdMX97WBTyyhfqXvs5opT8tSSF9zD3URQ0IzYo4V10YX8SMU/qC8vDeAQbMtMZniOhxKhWmRJVEwZCnigebgo6+NLvyJeCoR7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=BHxl/QZs; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-781997d195aso1609572b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1759171072; x=1759775872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iJLpaj/c6dWR6gSCWApgd6FdexxQb0VtbiytQ5OXSGA=;
        b=BHxl/QZs1adPEeaIHUBm/st0lzrEt3BMKN5WndQj4qfTbOSO5bZvldmdLTwCA4nCZk
         Jm5uPmcTJyqhhiXDqZLZLwa883jKuglps6+z64IWPxnH7jEd8dcyshN0hQ6P98uvfQ5X
         h/+E4oNTuyUkZyREUPiczW9vEVB/1pQ7KgozExmBuGyblHasxdZ5bJfhU6NplQW1i1cV
         39/AjbhWWeIqk2bDPA7xNugNHwOJsuZcOwzzS3hzDD/OuDHH+Do10qPrW/IYqbAP62gL
         cEZruIv0e4Vu9RjYVKkDRQHaqOSz8TeXWk+xmOv2gfBObl3jPP4QpTUg+WH+TtjCEk79
         C0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759171072; x=1759775872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJLpaj/c6dWR6gSCWApgd6FdexxQb0VtbiytQ5OXSGA=;
        b=TAa+cdX0ri6dgChEwJOUl9bnUtRuE6XeUrHI36djM+Nr3EiXjHdyWI4gGkdkgRaONO
         r8sv3hx+l5edJRCVtEpQeHK6jNh3YYdaudGxZTPw8JYDeKzbRU/oOwL9+HGWPJsaifWY
         468wNdka50oQkyfu0zm5EpoZp6vnM5VmLsAJ+unEJ0wUfRW849Xh76kWslTovUVPzYev
         vo81N95NSUu9eYv5d5woHGaRp8mANb8PrQucE1uLn4wggKPu/NPd0NBucdJSZ0ki2Iat
         BCX6G/4zTyoDRNT0IPNICkP6W/BPl0BfBbGcY1d6osAJO7fNGXjfffMWfW0ukWDYZN7l
         Bnew==
X-Forwarded-Encrypted: i=1; AJvYcCVb6ahNomy1OLKj38JSiqEH9r+l276T8fGSfXdqj/FmR8rffsAWjtahz4SmXBu6l0DOXQcyJ6HEFj/HEpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuyCWn5YV2Q1Kky+8rN0Vipc4KYVt8dIITutLL+Hi4fyC1NebL
	ZBbvx74O5YWMDyd0W2E5bK8JB1oar3wAkHodL/zz6AdNaCNjJJh9HCmVjn5sR3WRDYv/fdYeJxE
	DT1LP
X-Gm-Gg: ASbGncvAnTg6WKD3neaaQqiz7fGyT89sHclR+c2dZrx81E8DsCqkyYi4imDyQvXRf0f
	05sMGATJTXTDJvxDwrpLV613894ttXwYCfgfgrXwgHXuBkM8TnYf2Y3Z40QCrTRtf5LkhKgejc9
	oXhh/hdTBngZFXgvuVxtu5G7PrLiyhZfdAPbpVSody18TyOwDxtqcRO4hMUHT3zkCg4vwOjv+iR
	tLSTLd09mYL/tMeUjql79hBA9LUOrDp4KGT7PeZUOx6Zp5EYWYMqIeXdpBvUT+ebcHuqK2U6jQ1
	F6dh6PyqHeE/VaJW1BnEIArFJKmJVpazsoxYAQGfMxvGPEL2EJCgmHQMPYOgGC4yxxkN4BFihI0
	ZECl1awTxkG9zc81J/sRBAT9Drry37OHx
X-Google-Smtp-Source: AGHT+IHBfLpwSOdsOZ3rlXG6ZEpP4ToRS6T8QkcIX5AOO47fspaa/84bLNk9yI3gfkzoA6f1KMT5jQ==
X-Received: by 2002:a05:6a00:138d:b0:781:15b0:bed9 with SMTP id d2e1a72fcca58-78115b0c301mr15805467b3a.17.1759171071800;
        Mon, 29 Sep 2025 11:37:51 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c1873sm11683639b3a.23.2025.09.29.11.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 11:37:51 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:37:49 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>,
	"nsz@port70.net" <nsz@port70.net>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"dalias@libc.org" <dalias@libc.org>,
	"jeffxu@google.com" <jeffxu@google.com>,
	"will@kernel.org" <will@kernel.org>,
	"yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"codonell@redhat.com" <codonell@redhat.com>,
	"libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC 0/3] arm64/gcs: Allow reuse of user managed shadow
 stacks
Message-ID: <aNrR_TD5JB5dHJ5b@debug.ba.rivosinc.com>
References: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
 <760447dc3e5805bf5668e80a94bf32356e2eb2d3.camel@intel.com>
 <8aab0f36-52ad-4fd6-98c3-bcdba45dbe16@sirena.org.uk>
 <ac0ceb09ffaeb1f0925b61ed1b82ee6475df2368.camel@intel.com>
 <604190c7-5931-4e74-a1c9-467e52d3001b@sirena.org.uk>
 <eab692794cbc82080b708c581efd5973b6004be0.camel@intel.com>
 <5397025d-7528-4b9c-b38d-b843ab004f47@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5397025d-7528-4b9c-b38d-b843ab004f47@sirena.org.uk>

On Fri, Sep 26, 2025 at 05:09:08PM +0100, Mark Brown wrote:
>On Fri, Sep 26, 2025 at 03:46:26PM +0000, Edgecombe, Rick P wrote:
>> On Fri, 2025-09-26 at 01:44 +0100, Mark Brown wrote:
>
>> > I agree it seems clearly better from a security point of view to have
>> > writable shadow stacks than none at all, I don't think there's much
>> > argument there other than the concerns about the memory consumption
>> > and performance tradeoffs.
>
>> IIRC the WRSS equivalent works the same for ARM where you need to use a
>> special instruction, right? So we are not talking about full writable
>
>Yes, it's GCSSTR for arm64.

sspush / ssamoswap on RISC-V provides write mechanisms to shadow stack.


>
>> shadow stacks that could get attacked from any overflow, rather,
>> limited spots that have the WRSS (or similar) instruction. In the
>> presence of forward edge CFI, we might be able to worry less about
>> attackers being able to actually reach it? Still not quite as locked
>> down as having it disabled, but maybe not such a huge gap compared to
>> the mmap/munmap() stuff that is the alternative we are weighing.
>
>Agreed, as I said it's a definite win still - just not quite as strong.

If I have to put philosopher's hat, in order to have wider deployment and
adoption, its better to have to have better security posture for majority
users rather than making ultra secure system which is difficult to use.

This just means that mechanism(s) to write-to-shadow stack flows in user space
have to be carefully done.

- Sparse and not part of compile codegen. Mostly should be hand coded and
   reviewed.

- Reachability of such gadgets and their usage by adversary should be threat
   modeled.


If forward cfi is enabled, I don't expect gadget of write to shadow stack
itself being reachable without disabling fcfi or pivoting/corrupting shadow
stack. The only other way to achieve something like that would be to re-use
entire function (where sswrite is present) to achieve desired effect. I think
we should be focussing more on those.




