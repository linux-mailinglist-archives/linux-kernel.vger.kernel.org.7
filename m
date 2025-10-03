Return-Path: <linux-kernel+bounces-840933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1DFBB5C1C
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 03:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F01BF4E90DF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 01:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693633770B;
	Fri,  3 Oct 2025 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKnYZO0L"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521C728469F
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 01:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759455909; cv=none; b=BM2d83FRFaRdQrPwsv2QiKREf/E4oxy0AivR9BhhJDJYYYpXzOyEbqTMHlEHzIKk7tEkJYBgImJnFjM8xftSPccq9qfkI/TfRiaTVJ4iUwedQDtEJekmgVxPPPc+w+HBwuXK+bZKVrr6sD7gsWEK+Oo4MMIQDB4O+8z6lJLMUgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759455909; c=relaxed/simple;
	bh=Wb/D+E4kiUBjIfwCZkZzNqX0bf8SbHMD9aJHVSnKMVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7CulyV7LrRMGUnNW8+OQXhMSzBEdlW6xL5XdhXcZq5Px45F6nCL8T6X7GTw3JSqvTvyFnP7GTvmK58fToN2m98Rllf9VIvwtkvMzS5UGF6AtRCKabYDGOWYGAXieU7czOcbW5OzRY1XGQ6y7g6obXoYgGRyQ1lrzxy90lWg1+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKnYZO0L; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4d7b4b3c06dso11619181cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 18:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759455903; x=1760060703; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dbZX0YDGEzlIF8RIsG89+OMY5rd2Shf5AWwsJNOua3s=;
        b=MKnYZO0LxTmKEwCk+g/zVw1RGSUSpqcWK62OhLgs4JuEFGwLsKVPo7BdB0yBXmSEpm
         VPmTBsskmolaorw3L9qNn6rF1l1WC6fjgIY70gfzaSSUmb3P6sCTTdvjVxaR45NcbpMO
         LVi6GKynaT9ra4aQLMCpvsnx8BVv08KSjxicA1F4PgZl4nL/FZ2uGRmyWJ9owxNh2RNg
         N8pRiE0RogRO01Jig0+xxl1SAhwie0JZLAaTzkAPPWxri8e9qlL/jwEGJDA5II0mTlZv
         MjmQO+vT9BhMZrPchtY+Xy/U1G1Qrw/lKRAWXqvLw/Eu4MAMOmXuHBDUTInVN/UxwdXw
         dFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759455903; x=1760060703;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbZX0YDGEzlIF8RIsG89+OMY5rd2Shf5AWwsJNOua3s=;
        b=LMSafFuMsSscwJndHt4cDOMOysHEOTLtqMq/rPYbAoZ6eAidSDjpCKrbZARf+4d3Lw
         V4E89nbTB3heidUeWqU8X9sWtlWnJ4afquzuq9ALDmoOQzIcXrBSbUQ3NcinZYeJNGBW
         o16q3mi1zpiLwn8V+z11PLCZaUM20lgt84fFRyKET0wgrZXHqjSmVwXSwCKeUdrhrG5U
         h6k7x8beyKiCg/87EmwhuBCobqun1s9Fw9cUHGgeWjIH/IBnby2gvoz/huIanWljH8B7
         zjotuu7k/G4AtWj/pTeCPrTTeha2qaotZFk24nSgrvA+M/6uU+LfifDIRbFwUqdNVZ6/
         6C+A==
X-Forwarded-Encrypted: i=1; AJvYcCUsUNYF9ULxwkVWWrmpcUzP/j/IfKZMqTAPRk/zrWjIR6Zn3XmRfdqVNP42zMJTL0WMHaq2sy45tus47Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDfjz68w6+mJYOAm/qFQJfWywUW8BbFrlodFo8LtiKxINGQXg6
	eqh/Pe5eghM55rszAROrHHEs8dUV7TJxobGU1CKj4D3P2k/X2ZAVKEjL
X-Gm-Gg: ASbGnctN3O+sYUmm5NYsfD4ZqsW11HSh/D1tlrswdTuz/LJvhX+5QapFF8mC2kF3Gh+
	Du3Hdo3Xhxe/CNBTzLW8A9F80u9aGA81TDIy6WEfVmIwl8+xYTuTzPHuHDeP3oPN61Gy6GV7IAR
	vqoP62gKVfGuD9LnkyVoZPSmZ9tfvqtrby8qagbHj9I2w3ujUTEY7hjSdUOxQPm6b106Sl80wvf
	ud5dOHhpGPQ8FvWkiHqgnmYq6mKwa38m0BJmmttcXvLyEnhf8U0W3T2n2nunoOZOruZly3vnEDX
	U/hR/NOxw1sHhnp6XFijLhjBhAQZb87A36t5hxYktfkQ/SEW/c7+lRuqMrIaQnMRBX0s2Ti2/gK
	eP720VtVJKkADDNILsU4YenBR0KCqif3AA3H/852icSB9D4/faTqM/Q==
X-Google-Smtp-Source: AGHT+IGC0q3AbzHcjA6VvVLioJ3pS8dU7d4NDAjw+ySW6Kf0eeIpzDpoeH8ZNTFGtaSizi9pWO9g4Q==
X-Received: by 2002:a05:622a:1989:b0:4df:8368:4adf with SMTP id d75a77b69052e-4e576a7ec79mr18266781cf.31.1759455903053;
        Thu, 02 Oct 2025 18:45:03 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777a7e02e7sm309707585a.62.2025.10.02.18.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 18:45:02 -0700 (PDT)
Date: Thu, 2 Oct 2025 21:45:01 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RISC-V updates for v6.18-rc1
Message-ID: <aN8qnSfzFjdovsjn@yury>
References: <2c804359-3d43-0fba-7173-a87f9aec4bd2@kernel.org>
 <066d70c7-b0a7-45e5-9337-17901bc95664@codethink.co.uk>
 <CAHk-=wgfpswvq0TypePyjv3dofO5YaUC_fSd_MjzY7jogCUnCg@mail.gmail.com>
 <CAHk-=wgYcOiFvsJzFb+HfB4n6Wj6zM5H5EghUMfpXSCzyQVSfA@mail.gmail.com>
 <20251001183321.GA2760@quark>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251001183321.GA2760@quark>

On Wed, Oct 01, 2025 at 11:33:21AM -0700, Eric Biggers wrote:
> On Tue, Sep 30, 2025 at 04:53:24PM -0700, Linus Torvalds wrote:
> > On Tue, 30 Sept 2025 at 09:04, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > Oh Christ. Is somebody seriously working on BE support in 2025?
> > 
> > Ok, I just googled this, and I am putting my foot down:
> > 
> >  WE ARE NOT PREEMPTIVELY SUPPORTING BIG-ENDIAN ON RISC-V
> > 
> > The documented "reasoning" for that craziness is too stupid for words,
> > but since riscv.org did put it in words, I'll just quote those words
> > here:
> > 
> >  "There are still applications where the way data is stored matters,
> > such as the protocols that move data across the Internet, which are
> > defined as big-endian. So when a little-endian system needs to inspect
> > or modify a network packet, it has to swap the big-endian values to
> > little-endian and back, a process that can take as many as 10-20
> > instructions on a RISC-V target which doesn’t implement the Zbb
> > extension"
> > 
> > In other words, it is suggesting that RISC-V add a big-endian mode due to
> > 
> >  (a) internet protocols - where byte swapping is not an issue
> > 
> >  (b) using "some RISC-V implementations don't do the existing Zbb
> > extension" as an excuse
> > 
> > This is plain insanity. First off, even if byte swapping was a real
> > cost for networking - it's not, the real costs tend to be all in
> > memory subsystems - just implement the damn Zbb extension.
> > 
> > Don't go "we're too incompetent to implement Zbb, so we're now asking
> > that EVERYBODY ELSE feel the pain of a much *worse* extension and
> > fragmenting RISC-V further".
> > 
> > I'm hoping this is some April fools joke, but that page is dated
> > "March 10, 2025". Close, but not close enough.
> > 
> > This is the kind of silly stuff that just makes RISC-V look bad.
> > 
> > Ben - I'm afraid that that page has "further reading" pointing to codethink.
> > 
> > I see some CONFIG_CPU_BIG_ENDIAN has already made it in, but this
> > needs to stop.
> > 
> > The mainline kernel is for mainline development. Not for random
> > experiments that make the world a worse place.
> > 
> > And yes, we're open source, and that very much means that anybody is
> > more than welcome to try to prove me wrong.
> > 
> > If it turns out that BE RISC-V becomes a real thing that is relevant
> > and actually finds a place in the RISC-V ecosystem, then _of_course_
> > we should support it at that point in the mainline kernel.
> > 
> > But I really do think that it actually makes RISC-V only worse, and
> > that we should *not* actively help the fragmentation.
> 
> +1.  Please, let's not do big endian RISC-V kernels :(
> 
> This mistake was made for arm64, it's finally getting fixed.
> See https://lore.kernel.org/r/20250919184025.15416-1-will@kernel.org/
> Let's not make the same mistake again.
> 
> And as someone who works on optimized crypto and CRC code, the arm64 big
> endian kernel support has always been really problematic.  It's rarely
> tested, and code that produces incorrect outputs on arm64 big endian
> regularly gets committed and released.  It sometimes gets fixed, but not
> always; currently the arm64 SM3 and SM4 code produces incorrect outputs
> on big endian in mainline.  (I don't really care enough to fix it, TBH.)
> 
> I recently added arm64 big endian to my own testing matrix.  But I look
> forward to dropping that, as well as *not* having to start testing on
> RISC-V big endian too...
> 
> Of course, that's just one example from my own experience.  There's a
> lot more that CONFIG_CPU_BIG_ENDIAN creates problems for.

+2. I maintain bitops, and I routinely have to take endianess into
account.

I just realized that I didn't run BE kernels for at least 3 years, and
didn't ask my contributors to do it for even more. The last BE-related
fix for bitops I can recall is dated back to 2020:

81c4f4d924d5d009 ("lib: fix bitmap_parse() on 64-bit big endian archs").

Nobody ever reported BE bugs for the new code.

Maintenance burden is not just a word. Things are getting really tricky
when you have to keep BE compatibility in mind. And it's a special
torture to run an old arm or sparc VM in BE-32 against modern kernels.

But what really important is that dropping BE support will make codebase
overall cleaner and better.

Thanks,
Yury

