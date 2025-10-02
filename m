Return-Path: <linux-kernel+bounces-840386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E7BBB443D
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 17:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D522322EFB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02A3175D53;
	Thu,  2 Oct 2025 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20230601.gappssmtp.com header.i=@lixom-net.20230601.gappssmtp.com header.b="tmk2aVWN"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFF91B808
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759417595; cv=none; b=odvrw0sd4yBP6Wl4H383Dl3bJHnFbHTEDIasMhYiCVm3cWuOH/Yqz3qJaMdSsOdkNd3vU/6r8DrSz6wb+DKCEHXigZCcQNk4LMmvS3K2EsN0kAcjEimPRR9vJYwwDOVTfFq1GO3e2c2qT8dlV65KwKl2t8kg0qFwjQ6fauMhDuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759417595; c=relaxed/simple;
	bh=e/lVBj+Rn5jjglDGRfuLTcoRITz9REiEiexxiWLRkHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5IzE5zqgiU/cq9GZtmVNP1V7C5sRGbQHxwP+Wo9uj2WkyR2yRCZDF6de9EvDNvRjLlROHbGH9dNrqtFMFMN1EoXKibdYpS/GJJrJGdMkgLVAc/ok4bc5S4cyTLHmxE4dtwnYw35J6XRKsgF046MsZX3JjRAvN2YbbhxRIetifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net; spf=none smtp.mailfrom=lixom.net; dkim=pass (2048-bit key) header.d=lixom-net.20230601.gappssmtp.com header.i=@lixom-net.20230601.gappssmtp.com header.b=tmk2aVWN; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lixom.net
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3306b83ebdaso1173490a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 08:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20230601.gappssmtp.com; s=20230601; t=1759417593; x=1760022393; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rfAOtpJmmnifg9QC2JHL+/9O8LHKXkTHllNF53zqwqc=;
        b=tmk2aVWN+vTm5K85OPqYXHT6iLqCDZLbMHa8410jvdc6i796AGB1Lfxn36ocVpoklF
         d+awJySZl/EUMAntGjssNGvv326fWzemrfhMG44+CjfHeVDGwfVrgb/yAI3IBHDueEpc
         1GwNEz9xb2XG5LXSglxAz544KhAP2nFW9opjaoHPahUPXyBWkg4220kwwo2cBTnilsI1
         2xWwjJUtJMOtXiFxoXAV9U+9ovdlvr/FWGIkibjMeq1cjNIIsrYoVwqoeeXdnzhJhE1u
         g0G7F+M5gHr5y8Yt2IGNZcf5XYasENWoKC2sJ6K8fwIvpMI+G8r+M46XCD+OhKbRlO2G
         bH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759417593; x=1760022393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfAOtpJmmnifg9QC2JHL+/9O8LHKXkTHllNF53zqwqc=;
        b=M4XmVdv72h0363kF8njJ+l292syQVO+AEj3tFV9NkvL6K9h07v9pVDwEH3SXmqoUA6
         yc9OozXSdmmuWrTAfCXJW3CRoV0pqY1U2s8lwt04O0Bx6d/YCY5YZesBZ/rcd+iztR64
         5rltocFDVg0G8cYGft7ncIElRujgnjWhHxz2c2MGMs15Y9KHlj7KzO9eYJLgJD6lLp6/
         Mq7uqHyTP5vXfaiWlrzrBWhxQ7cEVoKNb0jcZHHfVcJ7WDP4bwvQCan03NRCZusCsPqf
         CI9PEbiJ8Okt51NKP8tPQCvLCIwOne/OfXO4s7HWn6HbWxtujOmB45GNkGvL8UwEWtNH
         /4eg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ2cIueYrSm2qjNGqZjoxNuEpQu1Jz5bkl6uOdW6m6BIRhWfNSm2Dzgp0XJIjWBFUC4IYKiYtlAhAbeQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyChMaP7zhKIgdJAaQ03eGyW4Fjk/eiSZ86MqfIp1uHLZ191JUA
	eZQs7EnawIt2xBhX7YmjkHweMlVdawEhJJ+GXewF4ufl6PMhTbjM+1VqQElcmpmgGVM=
X-Gm-Gg: ASbGnctWtZZy5nau4hQHKy3B8tgu4qb1V67jwxt+PAHBtZfC0heRT3fPkhOWEiVEGb9
	RC0MpF+lkAkWKfr8SdknjZgk6SiNjyZC9v0EcZyvdxirdZOEaHRRfqIqy3HfVrV3b9TvMEOMyPj
	wV6azNt6FwjFDsXscWjBRYxzFQu40tgnVChgBNhdNNY4QsSk2orNELeyqwq4o0dCW4W6fYdHcn6
	bymLKJ/mX4k7RPFi76NB+nMwV7yPQkT4fJjeVfoBSSOrKQoW//4vjVk/Vdqgs23fFB2DXvzEZxp
	/u4OcmQejQn3ndnvzxNvTKoeFsTppE+Xnuh5WJdRKOyja3lf57Hx4HBrxERor6f7j3hk4g3cwhy
	ISi96qqnYAahsFPfeJelEVGsi06nPBOua6viOYLqyV/GRQfoManK4DSJEQ5pFBlyMEGTBKhkQyX
	qlOFkjuBhFG3M=
X-Google-Smtp-Source: AGHT+IEC8lXy2avFMbURoC9r6NpLlroK3bziveWA5z9xbUH2JRf4uvGmg66hv7DNQQupbjk/KOSGDw==
X-Received: by 2002:a17:90b:1d12:b0:332:6356:86b6 with SMTP id 98e67ed59e1d1-339a6e74980mr8858627a91.9.1759417592931;
        Thu, 02 Oct 2025 08:06:32 -0700 (PDT)
Received: from localhost (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b6099f7ab4fsm2165562a12.44.2025.10.02.08.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 08:06:32 -0700 (PDT)
Date: Thu, 2 Oct 2025 08:06:24 -0700
From: Olof Johansson <olof@lixom.net>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RISC-V updates for v6.18-rc1
Message-ID: <aN6U8NtIfqd-fowQ@chonkvm.lixom.net>
References: <2c804359-3d43-0fba-7173-a87f9aec4bd2@kernel.org>
 <066d70c7-b0a7-45e5-9337-17901bc95664@codethink.co.uk>
 <CAHk-=wgfpswvq0TypePyjv3dofO5YaUC_fSd_MjzY7jogCUnCg@mail.gmail.com>
 <3c9d9f92-aaf8-4d4d-a2d9-8d6a410edc30@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c9d9f92-aaf8-4d4d-a2d9-8d6a410edc30@codethink.co.uk>

On Thu, Oct 02, 2025 at 01:48:47PM +0100, Ben Dooks wrote:
> On 30/09/2025 17:04, Linus Torvalds wrote:
> > On Tue, 30 Sept 2025 at 00:25, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> > > 
> > > Is there any chance some of the big-endian work we did is getting in
> > > for this round?
> > 
> > Oh Christ. Is somebody seriously working on BE support in 2025?
> > 
> > WHY?
> > 
> > Seriously, that sounds like just *stupid*. Is there some actual real
> > reason for this, or is it more of the "RISC-V is used in academic
> > design classes and so people just want to do endianness for academic
> > reasons"?
> > 
> > Because I'd be more than happy to just draw a line in the sand and say
> > "New endianness problems are somebody ELSES problem", and tell people
> > to stop being silly.
> > 
> > Let's not complicate things for no good reason. And there is *NO*
> > reason to add new endianness.
> 
> We first tackled big-endian support on ARM32 nearly 15 years ago, and
> drawing on that experience, we saw value in doing the same work on RISC-V as
> a way for newer engineers to gain hands-on experience contributing in the
> open.

Getting new people going is great, but if you were around for that
one you also know just how little usage it saw over time -- the ARMv8
big endian enablment has been on (minimal) life support with just some
downstream usage in vendor kernels. Adding the burden for everybody to
maintain this work forever is the flip side of the coin here.

> Now we’re starting to see commercial cores on the horizon that will have the
> ability to be endian configured at run-time. For example, MIPS (the company
> not the ISA) has announced they will be producing cores with configurable
> endian (https://mips.com/products/hardware/i8500/).

MIPS has been doing some not so awesome things to the RISC-V architecture
in the last year or so. They've published patchsets that make it seem
like that they seem to have taken some old MIPS designs and done the
bare minimal conversion over to RISC-V, since they need their own weird
system peripherals and hooks. Again, with the burden for everybody to
maintain because their hardware engineers couldn't bother to develop a
full proper RISC-V core.

While I'm not happy with the lack of upstreaming from the (mostly
Chinese) SoC vendors, and we should be encouraging more of them to
contribute directly, MIPS seems to be making choices that might have
long term burden for all of us. So far the slope is slippery on the
system side, but needing to worry about BE support seems to be stepping
over the line for me without some obvious clear use cases that make sense.

> Note some of the patches we are proposing also make the code better, such as
> swapping .word for .insn.
> 
> > RISC-V is enough of a mess with the millions of silly configuration
> > issues already. Don't make it even worse.
> 
> This feels like the price you pay for making a flexible and free ecosystem
> to build cores. There is no single authority making you use every feature
> that might be specified (although Ubuntu's choice to move forward with RVA32
> for future is a current pain for anyone who already has purchased hardware).

Just because the ecosystem is flexible, doesn't mean you need to encourage
and support everything that gets built.

> See initial reply for comment on MIPS. We also don't think this a huge
> change and given most projects we worked through had few (if any) issues
> with building big endian, we thought it was worth having an attempt at this.

To me, it's not about the initial effort but about the (forever) work of
keeping it going without regressions. Now everybody will need BE CI, etc.

> > Tell people to just talk to their therapists instead.  That's *much*
> > more productive.
> 
> 
> Thanks, but that isn't helpful and is just making the kernel look more
> toxic. I am however going to wear the "I got ranted at by Linus and
> survived" tag with pride.

Hey Ben -- you posted a *RFC* of the patches in December 2024. I replied
to those. So did Palmer. With exactly these concerns. Did we get a
response from you? Nope.

So, seems like Linus has better success being impolite. That's a bummer.

For the RFC thread, see https://lore.kernel.org/all/Z2XLS2HX2KqBJW6U@chonkvm.lixom.net/


-Olof

