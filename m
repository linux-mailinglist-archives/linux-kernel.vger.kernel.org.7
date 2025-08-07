Return-Path: <linux-kernel+bounces-759428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBB6B1DD6E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E889F560694
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8B721D011;
	Thu,  7 Aug 2025 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="bEWBTsO1"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1902045B6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 19:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754594262; cv=none; b=dKonPjkll80UjPY/bNQtf+4JCqUzRCKcS/OUx37IIh3ARul/Y24SiRgVw1izL3uOLECLrN2A5C912utSIhvfWvlwbh2aFTUeSPQXuai/OjKaR6t+zN9uvN1UHpB+6ZXUfui8RQqR5D5jcHJzvuoTMppMyIUp2Zbj+PPStMQimCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754594262; c=relaxed/simple;
	bh=NOr5wFfOXJ+nds7RgcrDVka8+MRC+St5x6VpLfmJuV0=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=LIfv8KdK0/DwL6qB+GtvHjfPaXofYwSSn4YIgswEyW61Z2EBQZHb+b9NQVB7cyW8H3KnA0jXm8NM8WWDuh+HG1sg7NNwIUdcV6ttCb7BKSzvaujOgioqqgQPUMIxTitfoc+fGldTFtnAp5aNbzNpo6yku6pNIbCXyIsjFVsq79o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=bEWBTsO1; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7426c44e014so1241233b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 12:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1754594259; x=1755199059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LFTGdFdrwPEXp/07Hyvbq3e4qPYS7VEbCtDeVMipK3U=;
        b=bEWBTsO1HwUQDrzb0lzfGppEKuf9+S3wC8xUmBpkwxouwRgM0oe3HzEdP6uaqJla48
         MQ5Eg9C27z5APFA3U7c8IuPYn12sPPGNBYdtz2cgxA1wcn2eo+WAf2/JU6uB1K9kEwdz
         S5eWAJFkGUwGPQph59sMI1qHGNH7buVgBwwZwNl922ta4U/VTgXVYFtAcF7wvqgsWIxi
         9E0hhNbslA5gz7oFti3yt5APxYY74EtFPHmo/Yr50okSSp+Nl/Jwx7Dc8SO67HUa2k1u
         0mCYTzZ+WQoW0MVY3EURK4sJZtDgmbmojSu7RlKu+mY3Rge91OWybIPr00pkX900RjGA
         8HlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754594259; x=1755199059;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFTGdFdrwPEXp/07Hyvbq3e4qPYS7VEbCtDeVMipK3U=;
        b=G2KXw860a35TjdXTWB/5M3fTIGdNiT/sVfKkIW+4xadDE2kyCypXps5vZY2vny56/6
         3FgC6U48SfkzGAg8zDdikL0I3Sx+Zv4/kRUKg/4XUx5OKFt4S3gf/xVOU8tzBHEEISlU
         dnpaabxboRvp1B92eQ8qQvTKQsX6KLMYO/kRmHkGOxoONz1NRg64haWnTOM4nh9IjPhj
         YYanNDRRDSWcOz/El8KR1b4oe0mHUx4ja4I2QmKYZzbRBXjYz0eQlTBhIMFXVXmvw0JW
         EL/Rid0jraOGtZJly61gRqQwn5fYiH5HSRBixKBAU+8jZlsYlhae9YN6S3D410Z0Onwj
         ZNwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLgJZRbnDx5DOeTU0m/sZoFtjPJy3JScn1qxj8f0dzNds2D+rpwbkjnzn4OlFPjH9Fw3WMKh8OoyHX79Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5aR0CGTppt7AHPl24LVe8wvNyos8kTbF0T5aS+6X13LGbJSw6
	9BSZU5MXZ13TJELEpHPCIlK6pCkSih1cnqGCz1l96XCW1bNLMknH5HDwejDujtAdY6Y=
X-Gm-Gg: ASbGncueUgKR3dUEjJX2MTZlq8kboyY2eNQnFdoDVlZOVphsAOysvcAowk30SFkK8Nf
	39OJAwLy0o1yLRgZioCq7hAoY1LElkYIK09o2/YVnRaWwxD/Li/HRQfuWaIjrrm3wZqVllkcqWH
	PyUWqvYYFq+WtPb9FB6XyOpOjlp00CcpnQDKXamJfYnj9J3eMRtr2LhaSBPoif5RhUVTbuHzsKh
	K+WRB7cIimyV9933mdP7f/EwXq2bJqvRnB2wV5535Sp/Yp26jTySRrY+eZ3JgGgrf6P3yYg8ucw
	pyFOmhemFRwIqx5KmqQ554+gHAcnIkdVzcQ9Y+OukLg0YjBerDUpDXlMOVaMUSs1qvEJvsyns25
	aOrUU5LgJbzSyiskZOBDmNX/uxg==
X-Google-Smtp-Source: AGHT+IHNqjBzNa6x9y5nuMTjhL/RlmBkISPYGPU0iPpiI2kbUCaUjEOs8chag9KSPSg5MZtZ2aU0kQ==
X-Received: by 2002:a05:6a00:80a:b0:74d:f997:1b45 with SMTP id d2e1a72fcca58-76c460ad057mr415274b3a.8.1754594259196;
        Thu, 07 Aug 2025 12:17:39 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::4:30b7])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76bccfcf5f7sm18719092b3a.88.2025.08.07.12.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 12:17:38 -0700 (PDT)
Date: Thu, 07 Aug 2025 12:17:38 -0700 (PDT)
X-Google-Original-Date: Thu, 07 Aug 2025 12:17:35 PDT (-0700)
Subject:     Re: [PATCH] arm64: Expose CPUECTLR{,2}_EL1 via sysfs
In-Reply-To: <861ppn9fbw.wl-maz@kernel.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>,
  Will Deacon <will@kernel.org>, oliver.upton@linux.dev, james.morse@arm.com, cohuck@redhat.com,
  anshuman.khandual@arm.com, palmerdabbelt@meta.com, lpieralisi@kernel.org, kevin.brodsky@arm.com,
  scott@os.amperecomputing.com, broonie@kernel.org, james.clark@linaro.org, yeoreum.yun@arm.com,
  joey.gouly@arm.com, huangxiaojia2@huawei.com, yebin10@huawei.com,
  linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Marc Zyngier <maz@kernel.org>
Message-ID: <mhng-D7782B90-52E0-44DB-89A8-70079A8751E7@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 07 Aug 2025 11:06:27 PDT (-0700), Marc Zyngier wrote:
> On Thu, 07 Aug 2025 18:26:29 +0100,
> Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Thu, 07 Aug 2025 01:08:26 PDT (-0700), Marc Zyngier wrote:
>> > On Wed, 06 Aug 2025 20:48:13 +0100,
>> > Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> >>
>> >> From: Palmer Dabbelt <palmerdabbelt@meta.com>
>> >>
>> >> We've found that some of our workloads run faster when some of these
>> >> fields are set to non-default values on some of the systems we're trying
>> >> to run those workloads on.  This allows us to set those values via
>> >> sysfs, so we can do workload/system-specific tuning.
>> >>
>> >> Signed-off-by: Palmer Dabbelt <palmerdabbelt@meta.com>
>> >> ---
>> >> I've only really smoke tested this, but I figured I'd send it along because I'm
>> >> not sure if this is even a sane thing to be doing -- these extended control
>> >> registers have some wacky stuff in them, so maybe they're not exposed to
>> >> userspace on purpose.  IIUC firmware can gate these writes, though, so it
>> >> should be possible for vendors to forbid the really scary values.
>> >
>> > That's really wrong.
>> >
>> > For a start, these encodings fall into the IMPDEF range. They won't
>> > exist on non-ARM implementations.
>>
>> OK, and that's because it says "Provides additional IMPLEMENTATION
>> DEFINED configuration and control options for the processor." at the
>> start of the manual page?  Sorry, I'm kind of new to trying to read
>> the Arm specs -- I thought just the meaning of the values was
>> changing, but I probably just didn't read enough specs.
>
> The architecture defines a range described in D24.2.162 (in the L.b
> revision of the ARM ARM) which is reserved for IMPDEF purposes.
>
> What these registers do is not defined, and there is no standard
> across implementations. This really is for chicken bits and other fun
> stuff. Most of them will simply generate an UNDEF, because they don't
> pass the decode stage. But for all we know, there is a bit in there
> that turns NOP into the HCF instruction -- or better.
>
> So exposing any of that stuff for any given CPU is dangerous. And
> exposing any of it on *all* CPUs is a bit like swallowing a powered
> chainsaw (don't).

OK, makes sense.

>> > Next, this will catch fire as a guest, either because the hypervisor
>> > will simply refuse to entertain letting it access registers that have
>> > no definition, or because the VM has been migrated from one
>> > implementation to another, and you have no idea this is doing on the
>> > new target.
>>
>> Ya, makes sense.
>>
>> >> That said, we do see some performance improvements here on real workloads.  So
>> >> we're hoping to roll some of this tuning work out more widely, but we also
>> >> don't want to adopt some internal interface.  Thus it'd make our lives easier
>> >> if we could twiddle these bits in a standard way.
>> >
>> > Honestly, this is the sort of bring-up stuff that is better kept in
>> > your private sandbox, and doesn't really help in general.
>>
>> So we're not doing bringup (or at least not doing what I'd call
>> bringup) here, the theory is that we just get better performance on
>> different workloads with different tunings.  That's all still a little
>> early, but if the data holds we'd want to be setting these based on
>> what workload is running (ie, not just some static tuning for
>> everything).
>
> In general, none of that crap is safe to turn on and off at random
> times. You really want to talk to your implementer to find out. And if
> it is, the firmware is probably the place to handle that.

Ya, if it's generally not expected to be sane to runtime modify these 
then it seems sane to just hide them behind a firmare interface.  Then 
it's really up to the firmware to proactively expose the bits that are 
useful, and it's inherently vendor-specific.

>> That said, part of the reason I just sent this as-is is because I was
>> sort of expecting the answer to be "no" here.  No big deal if that's
>> the case, we can figure out some other way to solve the problem.
>> Happy to throw some time in to making some more generic flavor of
>> this, though...
>
> I have no idea how we can achieve that, given that there is no
> architected definition for any of these registers.

I'd basically have some interface for getting/setting the registers that 
the kernel exposes (gated behind whatever tests we'd need to make sure 
the registers are accessible), and then some userspace program that deal 
with the implementation-specific behavior.  It'd probably just devolve 
into some database of known implementations with what the bits do, with 
some attempt at mapping them to generic behavior -- though even that's 
kind of clunky, as something like "this tunes some prefetcher to smell 
different" doesn't really help a ton.

If it's a firmware-gated thing, though, then it's probably going to just 
end up as some vendor-specific firmware widget that we go fumble around 
in ACPI to mangle...

>
> 	M.

