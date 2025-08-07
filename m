Return-Path: <linux-kernel+bounces-759394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D79B1DCF1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D55C3B69E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972BA25D209;
	Thu,  7 Aug 2025 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="MWlMSL7Z"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3F5221737
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754590476; cv=none; b=kDFeumg12iXB+bf/7JA3RsCMsjq7OBuZ8eE36nwKSUWkL+PZYGEb0EQI26PlNJgvYs72JVkmQtcQOgI18p04XfNEi6Up4k1VVK7oNxBSvDEFShRo2C5RPpJakmTjaSEeHs7FzEfdO9R/Dh/5NI5Yl43zHHUSlBl+hcGIrDHLqFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754590476; c=relaxed/simple;
	bh=tGlWKdn0ISdg/t0zVupmnK73vNDgv/E0rjhoQsCMgeU=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=DQXLSjHf5s+LDOy9C5gFWIregr+d1m0wXfC83jYzC68cm7TQeBglnPzUJMvdLmlMh3Umbu5mj6dq2LExaXXucDrPJiXce4e/xR2d46b5L26lcb8bM7P0KjKlh5PjsjEErXPKBDzZRggkUEmu336Wkbhxxw6fPPWD8M+3p2CAGkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=MWlMSL7Z; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7682560a2f2so1537486b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 11:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1754590473; x=1755195273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6su/4EhSTEeQ3RIzrMdpMTQS3Ts3FgqkCaCvrRsQR0=;
        b=MWlMSL7ZevI6R/WeQ2c8Lpxk4bsDGP+vlZQE92p6FBxvrZx8ZaH8nN+4IQBkxd5JUJ
         +9fHKi9vkEqGh57XYvjLQAt86PwNVUusFsfkPcf/BeQl/4WWNyQlqVxM6LcYYZTM/ALs
         M3VZKfSaCeo0ARO307MCU8NELOjEwiZJGjImY+lHdhjF+JmvqgGyHtCG/ItrQVHPAdit
         IFYBGC2yfiU/l45C1hUEVskwfp7ZqN90jzpBd0oj/a7kUu8QSxd5a0+oVIWBLTYEiOoJ
         O+kGz2ZO6SI2lYaZJ+eht9P1L3SOqu79BSywGiDoGpOx6LDd6t177i2sx1LZlcoMy80t
         cliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754590473; x=1755195273;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6su/4EhSTEeQ3RIzrMdpMTQS3Ts3FgqkCaCvrRsQR0=;
        b=adsdeQrwgSzJgr2lErkFh6p+OiJAKFnk98JovQ0WAxRMG+Omq/Ju41Qy0w70KNNlB1
         pCHNySykQOZ6j1db8Sb8HT0IGcgqmaRP/F/P7T2GEu7RB3+T3lcjNObiwC+6mUukpo4r
         aGuL7pfDFz6Z9iN0VNdGPVy9vZadL4aIi7D49NukRwTTBTQITwbD3jPvSU4V4R562mEK
         z4gx9KEjBnVdMgCVIGI/PODvEs0g4i9eNZBkwICVZedHTRq+1sCRWYFdnnnnmMDm7TJz
         sIG5QzqTXWSflZzMoxKOWZEk8WkeV97biRsYUvh3/5Wk22f+xa3g5fDEZMMosfN/KJjC
         x5Zg==
X-Forwarded-Encrypted: i=1; AJvYcCURr0MUMMD2mQ4E5FO9DSiyBXMy4+bwNBDX7zHaZwVreFJO3z9d08p3SfCF0tSlSDhEU5HUGsQ1xn6XMto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzImy9KvbWRZGkqCKHBdfErOIE8KD7t6cj8q+1dr/W7jjpT+9Yk
	UNPU4QzA8lK6JOIMxLga3J63S7xfNH/TwBkS7nht/7vg2Ccyv+MegYKQOIAYfQ3p+So=
X-Gm-Gg: ASbGncu7nv54YEDGepHQ0CeJ3P+1K85gQMb/zvMPWC+U5B47cDHChnIHJHyiGtgNAGI
	9gk8az65vQkWcagsEjkwCnCbH/rayYt0a6/cmBgKbNSCr23IF8A6PNa5wEkoM8vNITqHGLrKXE3
	2+rt9M0nWrftdUVpJMTDkzJYpZo0BVfy4T0kR044Mg7SewX8vfhupAJcIe5ARj45PzzZu3hPOYB
	8sGgxx5ldu1sGI5lSRbC2IX1a9rmn7ESrS797FWvJHUED0BFq/4vTB3uEKssh1gxWnw9I1bC9Uz
	v1oXET2OViHctJV9AYvHuKWZI7ZlBa8n3uTEneKYzkG35grfbTFlBXX+z2Vblm0D+1srZnQA1o0
	t9R6U9wnA5+EMCSoq78Kx
X-Google-Smtp-Source: AGHT+IHP9EUAhOlvp96atr/vbagfiqpAP24IOcQXyVOv0EdKmDG/UBY89Ef20JFJNMEpZBqO9V2fEQ==
X-Received: by 2002:a05:6a21:a247:b0:23d:6475:40aa with SMTP id adf61e73a8af0-2404102b499mr7439564637.0.1754590473365;
        Thu, 07 Aug 2025 11:14:33 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::4:30b7])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76c3f85c720sm1263514b3a.27.2025.08.07.11.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 11:14:32 -0700 (PDT)
Date: Thu, 07 Aug 2025 11:14:32 -0700 (PDT)
X-Google-Original-Date: Thu, 07 Aug 2025 11:14:30 PDT (-0700)
Subject:     Re: [PATCH] arm64: Expose CPUECTLR{,2}_EL1 via sysfs
In-Reply-To: <92feb0bc-18b9-438a-9567-a9059a8cb9dd@sirena.org.uk>
CC: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
  Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, oliver.upton@linux.dev, james.morse@arm.com,
  cohuck@redhat.com, anshuman.khandual@arm.com, palmerdabbelt@meta.com, lpieralisi@kernel.org,
  kevin.brodsky@arm.com, scott@os.amperecomputing.com, james.clark@linaro.org, yeoreum.yun@arm.com,
  joey.gouly@arm.com, huangxiaojia2@huawei.com, yebin10@huawei.com,
  linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: broonie@kernel.org
Message-ID: <mhng-48855B75-93F8-4CE3-B50C-26D49C2F9223@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 07 Aug 2025 10:57:26 PDT (-0700), broonie@kernel.org wrote:
> On Thu, Aug 07, 2025 at 10:26:29AM -0700, Palmer Dabbelt wrote:
>> On Thu, 07 Aug 2025 01:08:26 PDT (-0700), Marc Zyngier wrote:
>
>> > For a start, these encodings fall into the IMPDEF range. They won't
>> > exist on non-ARM implementations.
>
>> OK, and that's because it says "Provides additional IMPLEMENTATION DEFINED
>> configuration and control options for the processor." at the start of the
>> manual page?  Sorry, I'm kind of new to trying to read the Arm specs -- I
>> thought just the meaning of the values was changing, but I probably just
>> didn't read enough specs.
>
> Yes, pretty much and also because this is in a range of registers
> reserved for use by the specific implementation.  See DDI0487 (the ARM)
> version L.a sections D23.3.2 and D24.2.162 which specify the
> IMPLEMENTATION DEFINED system register range, and the definition of the
> term IMPLEMENTATION DEFINED in the glossary of DDI0487.  If you see a
> small upper case term like that in a spec related to the architecture
> then it'll have a specific architectural defintion.

Thanks!

>> That said, part of the reason I just sent this as-is is because I was sort
>> of expecting the answer to be "no" here.  No big deal if that's the case, we
>> can figure out some other way to solve the problem.  Happy to throw some
>> time in to making some more generic flavor of this, though...
>
> It's something that does come up, working out a way to make use of the
> tuning in the IMPDEF registers in a way that generic software can safely
> and sensibly make use of is rather non-trivial though.

Ya, I'd expect it to be a bit of a time sink -- even if something like 
this patch had gone in we would have had a pile of ugliness in 
userspace.  I think there's no way around some amount of ugliness when 
it comes to implemnetation-specific, though.

That said, if our nubers do pan out here then we'll likely need to do 
something.  So if a more generic solution is interesting to people then 
I'm happy to throw some time at it, shouldn't be too hard to justify on 
my end.

