Return-Path: <linux-kernel+bounces-852112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAF5BD8320
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B99224F24AF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4DC29ACD1;
	Tue, 14 Oct 2025 08:34:14 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79C6236454
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430854; cv=none; b=Lk4q1kAuv7wpSAROWkd5T7g602i+B8KcaTXWV1oiuLrfK3eLccIafyZfDuEu/HOR06eZ/FGTyWRjgyr2Q/jqpSKJJ56rQ/CAHAXb7sAkkrRxa2TNTzIQWm5pTpPBsjqXRHMKMDD1kkPfqJu8gMkZlauPgS1VOSsIDET1+yuwMfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430854; c=relaxed/simple;
	bh=0B2UMYbqUDmb5TRAEFZ3iCetD125VgS2XRk3m5uYAII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVo8GizkbThO/KB4dNUEV7NNbmnFt0kT4Zz4nS5ICoQR0E8t+DsCQYr7Rjwzwy7bfiOnU9hLrq7ydx1c0uNASFz11KVkzaswCYSRJyXTbdlxVm/7QQ3t5bEC1tiaJuk2xR+WuWkBlvdE9pHLVdRFy/f8PTvI4S2Mx6jg5aYUAFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63163a6556bso10042517a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760430851; x=1761035651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKUCHW/MBIZsUc3ODKKtWIaDlEQsfe7hY3IvRmB8i8o=;
        b=QFs08H2TSlIKDFNcVSSwcAqTFSnYOThFIB9d6VERfipH7KKtrL+ACsdWdPWQ8cvW9l
         yTMkaRMlDjSaUt0DmfQHrTTtqzZd1V/XTeFfvwdoAOynjbWkn/p2HoK/Agep1Ti0jKou
         V0FfRQnkc9+dPuqH+PLR6eGr+9XxCb04yztOGTenGMEj1eDcKkVkDVnqjXSkAKT0rKbc
         decHSHXeiuT9/auPYNq6U2/9vvVL/UfsiK5hJedmlbJtyjWW9O0MlQ3H0SxT5q/sbb9S
         O/MZK4jgnmzy2i7QmxCEKpCfVW4Ys5VAv3WxRCfm5bi51/D5i2WEh6AwGGM4XCYCSoOa
         Qj2w==
X-Forwarded-Encrypted: i=1; AJvYcCXLYFGQ4Dlhg+mKQfA1GUzxz+TWOQPtEbsL3llw+DaB2QuL3Ioro2vOiPtZao0QaY4xsD1n9aQYsQCSICY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvafaUHNvOe9MxX9gZJBX/uPtPumNMLu5KwhieWX+lU4wlSmod
	u9h4Gk7EhGJVSoqoFhSShEMaG6Qiwy6Esy1usRhYQU0WuTzh3ruAvI3a
X-Gm-Gg: ASbGncuFrE2GuhOmr1NGtjk2IqUGqcW44N6M7UEv7rihdrAEkHdvrqBysOqSOOmzps2
	uHeVXi0LYIIdEUY+6xynhSCX9hCY9Ob4oI2ZIWT5aIr8lyzn+r4KMN7wU/iyVdyXgQwlcgKg+T+
	i7u/P+UKllbhLucsQtKYSdE45c5pfq2Ti4IGLHj8PPGdu/qtCLJ939w2s0TtqP45KRLeZ+WZPa5
	W1sIUbqIt68MpHsy/rwUde5dW3XOnpPvyoLKNK3HDiVbMNlHKnuXvcO7Pwwh7ftqvzz/QtLun2r
	qCrdqibArww1blbsTfoEWTeehu9dLUZuI+yaSQ8eYpVMld2D+EUfz+G9dg5zOp1943DxelfXrdT
	um2G5k9ralsSFPpBy9ONXocWGmdQdAWMyNG9J
X-Google-Smtp-Source: AGHT+IH9yDBhkiPY34+r8L4QfGlETNuwKEKExxU3npIvUrJ6TVQTuSdRSJEPMfeufN3cm41sP9BTrQ==
X-Received: by 2002:a05:6402:50c6:b0:632:930c:ed60 with SMTP id 4fb4d7f45d1cf-639d5c57a9cmr20902180a12.30.1760430850785;
        Tue, 14 Oct 2025 01:34:10 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c322e91sm10304155a12.45.2025.10.14.01.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:34:10 -0700 (PDT)
Date: Tue, 14 Oct 2025 01:34:07 -0700
From: Breno Leitao <leitao@debian.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Changyuan Lyu <changyuanl@google.com>, rppt@kernel.org, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, anthony.yznaga@oracle.com, 
	arnd@arndb.de, ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com, 
	devicetree@vger.kernel.org, dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com, 
	hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com, pbonzini@redhat.com, 
	peterz@infradead.org, robh@kernel.org, rostedt@goodmis.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, tglx@linutronix.de, thomas.lendacky@amd.com, will@kernel.org, 
	x86@kernel.org
Subject: Re: [PATCH v8 01/17] memblock: add MEMBLOCK_RSRV_KERN flag
Message-ID: <2ege2jfbevtunhxsnutbzde7cqwgu5qbj4bbuw2umw7ke7ogcn@5wtskk4exzsi>
References: <20250509074635.3187114-1-changyuanl@google.com>
 <20250509074635.3187114-2-changyuanl@google.com>
 <ef6wfr72set5wa5el3wbbu4yd5tnc4p2rhtjpb5kpmncv3xs5d@i3c5v3ciioi3>
 <mafs0wm4yluej.fsf@kernel.org>
 <mafs0h5w2lpqu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0h5w2lpqu.fsf@kernel.org>

Hello Pratyush,

On Mon, Oct 13, 2025 at 06:40:09PM +0200, Pratyush Yadav wrote:
> On Mon, Oct 13 2025, Pratyush Yadav wrote:
> >
> > I suppose this would be useful. I think enabling memblock debug prints
> > would also be helpful (using the "memblock=debug" commandline parameter)
> > if it doesn't impact your production environment too much.
> 
> Actually, I think "memblock=debug" is going to be the more useful thing
> since it would also show what function allocated the overlapping range
> and the flags it was allocated with.
> 
> On my qemu VM with KVM, this results in around 70 prints from memblock.
> So it adds a bit of extra prints but nothing that should be too
> disrupting I think. Plus, only at boot so the worst thing you get is
> slightly slower boot times.

Unfortunately this issue is happening on production systems, and I don't
have an easy way to reproduce it _yet_.

At the same time, "memblock=debug" has two problems:

 1) It slows the boot time as you suggested. Boot time at large
    environments is SUPER critical and time sensitive. It is a bit
    weird, but it is common for machines in production to kexec
    _thousands_ of times, and kexecing is considered downtime.

    This would be useful if I find some hosts getting this issue, and
    then I can easily enable the extra information to collect what
    I need, but, this didn't pan out because the hosts I got
    `memblock=debug` didn't collaborate.

 2) "memblock=debug" is verbose for all cases, which also not necessary
    the desired behaviour. I am more interested in only being verbose
    when there is a known problem.

That said, my suggestion is to only dump extra information when something goes
wrong, not affecting the boot time neither boot verbosity.

