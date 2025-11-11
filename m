Return-Path: <linux-kernel+bounces-896245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC28CC4FF69
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944133A9646
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FDE2E6CA0;
	Tue, 11 Nov 2025 22:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="w+1Xe0IE"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FABD35CBCB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762899467; cv=none; b=k8qayCvZO0WrdErBEB8RWmXPRjNwIHHohj7lcoskQojnpqdT1IOb6T/Xt4aD2mcAlMDtl8DYk9ShgcxaShZI1xSsdq3iH9tiBqTLF6YOzkm6HOloL0fq4W74EHFYi5SJOgyvjpGCp9j7k4UhU3Qnjbw82Jscz+8UaMmXx1wZNWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762899467; c=relaxed/simple;
	bh=LUfJ0FUszw/lMWwcBkVzYmFdTPbMBBt6NZCCwh9vWDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHpYebAf4vIvObswNNMsKX6jQyliCPN9bQxsSHF5iwhf+MG7wlvpv/mvFaZMlQfWDWEH4imuJbVR+q13FJBrJ4y/KAiLfqioSifNzr71KUZEN+PJuA8qHPgaO4I5OTpZBEZFVR9SOTlTtjDM3ASXRf2N+kWfZkhHUuSFEI7Q+SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=w+1Xe0IE; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88059c28da1so1759866d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1762899465; x=1763504265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IXzEi3kwADspB9uGnAqBRmtVLn10E7o5jxATEd3rTNU=;
        b=w+1Xe0IEqnJgvJ9hDYVAbXKA9K3KNmSs8Md4i7nc0jST1OYZkHrbdtZwteTKBXA9vR
         +dtgj41GXGrsoIvUcT2VSL1H3DDpDHnEtbIKkJUIj0vA3UZK3v/M/Bt616Yavh4AlA58
         nyEsHGfgGOW5kgrNyz1DxKok3l5Wr6/O3ZzWG7TvOKTJOnkACIkFrm5wD6mzKhyNmEyO
         6S1Ik6fBEnhWUBJZiO/kIoGRhW2XAWLizB1/gVdA6UEpH8N7j5HGym9gA69ExuRB0qP3
         AJlvXXY33Nd7m5NnJXUQvv7+U/6IyxMXHKuyGcvWG/8L29nmmo+hIb5M/bGYocVPYZ6o
         vBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762899465; x=1763504265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXzEi3kwADspB9uGnAqBRmtVLn10E7o5jxATEd3rTNU=;
        b=E7hBCLYaUbz8dyxy9MCpxdjg7s2nZ0klp3FimrgtkG9OWt2lYKJo35h+In6rsqflXX
         GuXJs7kSXYaYwMhQbpR+yM6rXuLDm231qDe5S05lhDoCgsGJjOgDtW8VzD2skQneATjG
         bWBQCuWKxjYvxjQEPIb2rwO6AO8QAZMVldOOud8R0g+YFfsqpN3L4rUchbFYZNjayM0a
         gbBcdyFKQqg1VlHsznpcfEvcnRvdQb5xBksUmFO+jVbHAwsvYEZokFBy74Ixm32adv8Q
         GmXYmtp6ptKaLGfC9d500PxXjyfgwASNJG8+j2eKb62ZUtV7cpBvEI2b974bf5xkYFOe
         620Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgnyYnqan7gODXq0n5rF5ps8vs9uMsDBnciu9N2XMlsUsITx2XpfGwcW7EYw52U6ZG22xmXUJYu5Bux6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9NU45G4As/Z7xNr01EDvnH6xjaRYXgsxX5Tw1Q3BDBoLFWk1m
	8pJnbOtbOIrFoctE3AwYb348OHSzU+Pa7sDp0ChoDoyp5kB2AMPWiodyYlTWffYSgjs=
X-Gm-Gg: ASbGncsnVANUoLvLDxgg+tbmRQB5YNB3L0StrrXZZXEPmZO4UO12Sy0jcRLhQ/f7HBH
	BTcT/b5OCxKYj/A08Dah488tKAP12w/2lekVuLg0FqFxLy48QQl6waQ+7xNsYvkPyFOKIKcNIwU
	kOHgVBS7XCxcIUjKc3Q1R4R2IXfxAnOHnZoe+hzeA3svvR3Vcif01cWvEyFJ5EfKyrP2tr/Oe1C
	5zH7KMHoz6oHyxnZ/cQ5lCY3gbK8PSPf1FUnzelISnnHeiVW3v9IhQEv4GQULgXDLIbYUxYtSXj
	wYDqreagQJe2WfXEcHC1F7iF7RoN8yJjvhvOHfR5trKboZN7BDaEFtiJVLgTYnWNyIbUUuUakbx
	ntm8qTan0iw/OEAqOIdKEfYkfvZpuawxAmPzlqeoR293BJ5lU/u16bb3sywBcwK60XVspDRlJRS
	iw6Sah8iVTnCV6Cda1EsxUlFiwF1BWBw==
X-Google-Smtp-Source: AGHT+IEia83T9DAZr1U6CtvLbgDwmCeTmKeArNboqrVpyZFeiMKt6z0RY2/FwY0aGwIMLWlwyoQYtA==
X-Received: by 2002:a05:6214:cae:b0:880:48e4:198a with SMTP id 6a1803df08f44-882719d6880mr18229316d6.32.1762899464853;
        Tue, 11 Nov 2025 14:17:44 -0800 (PST)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-88238928a8bsm80646736d6.12.2025.11.11.14.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 14:17:44 -0800 (PST)
Date: Tue, 11 Nov 2025 17:17:43 -0500
From: Nick Bowler <nbowler@draconx.ca>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: mm: Prevent a TLB shutdown on initial
 uniquification
Message-ID: <no3uc7kk4ohwrzoc7opcrj7poakjxqrwamt6karapdfaa3nwht@tgvacwyjj6zf>
References: <alpine.DEB.2.21.2511110547430.25436@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2511110547430.25436@angie.orcam.me.uk>

On Tue, Nov 11, 2025 at 06:21:46AM +0000, Maciej W. Rozycki wrote:
>  I have verified this lightly, also with some diagnostics added so as to 
> make sure things get set up correctly, with my Malta/74Kf system for a 
> 32-bit configuration and with my SWARM/BCM1250 system for a 64-bit one.  
> Sadly the latter box does not finish booting either way, but it's to be 
> bisected separately.
> 
>  Can you please give it a try with your systems?

With this applied everything appears back to normal on my end, no
problems are immediately apparent at least.  Definitely not seeing
any kind of segfaults during boot.

Thanks, 
  Nick

