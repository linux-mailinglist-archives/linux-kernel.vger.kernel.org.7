Return-Path: <linux-kernel+bounces-777857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC11BB2DEA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E1F189D540
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4FC25A2C7;
	Wed, 20 Aug 2025 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZUTVUf6"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E7B21D59C;
	Wed, 20 Aug 2025 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698499; cv=none; b=kzT+kCi+KXOJRvuBxPHlAv6K2KfZMYaFwT5bqg+UbLcUnM0KFJRPqOEqN53bHKg6MRDDp5DkFweyC4JQHcs0ifyldOCg75G6p2LCSVxTXWZwW07yBopqinrT6U7tyt18PyDBUo8tQNLNxExe1bxYtVmVkLZLOYRclE57C6Lz2Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698499; c=relaxed/simple;
	bh=mNgrOaOzDD2mooavRMaXw3re03XEZVIOCcf09EZBKhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8ZwpTgrcE280vy1Z0lz/AimFGwdpXkt2hsFVd4KXxWea6ppjA17oWDG5H7Fxm2NaGnitb7fL3lbAbJuZv3Nr6RNTmNDNEli4vUBRSHREjfJq6NNPgBbG4dIZaNIuhS5F2fXz/jVQTyDuKTJWPGO3TDUgU6VjKqXltS02YEtjKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZUTVUf6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7a0550cso986080666b.2;
        Wed, 20 Aug 2025 07:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755698496; x=1756303296; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1b7SewZAz6UJbowyw2858+jipp4/HLFXQ/0LNBzaDtw=;
        b=LZUTVUf6j8MR0Js+Hl8rGmZ5GKY8wdKVwjgGYY/npOqO479Hq/vsJ7thWJWiuOb1li
         wtzafHDnQXYYM6u2AZLB2yKk+BVctdPWb+uAobqfR2/uZt6vljeMj2YT/DsGjWDFdKiD
         fdqY9Nifnmn94NN/tKy64FcaoFGEHmjDo6Iol7UH+SMW8Cmpj2atnzvZXYSm0yHL/NZ9
         OXudapLRWeS6EeRaM6b3R3vDnWXJHobpcT2w4gD55INdfnUGqjVP8X5yz+QJpq5BV3Bv
         3Bk2y/ankVt8TLb52WDwaqw3EfESzR2vSTcKRozbkdbIFhlZEvjFZ86wghzY6fTq+5hy
         H77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755698496; x=1756303296;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1b7SewZAz6UJbowyw2858+jipp4/HLFXQ/0LNBzaDtw=;
        b=Xo4+XfFB6Ua4mpyfdavwRmoX6J56ccCwkSkUZCjSLm2RfG5jPm0J67dxVKH85S2tR2
         CBPr0PSNkFhjwCTmf/4pC+nfAhglPCNHNhUKUbeiCRV/+9Qx3F08whPF1x+C+S1WIEeK
         rcPkHON96UzJJHVhopvgoOe/hxGSW48MOGbKz5GAVxxJSh0RFeqL7Dv4sAV8ROv/ZA33
         eN5ynYIf5rMxbCdxUQ1101A2P/YehdcKiMmAYOYdCIzTQJf+bA8bUsbXLgkRPH0Se/bD
         13fyPBmDOvusqKUAebOg+olP88UPWtzpx0owoQPkwuSx/OWAJeKwRC9RnhDE3flupGW7
         iTEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjTsBJUGDuxuhPlyCGOFPa0xoLOElaw7Ji2SFYb5It0/a+4xcB46Kx4DK01DbUiTPgFGNemwzSOwaimxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVbcbrXml/Rx/1bDyTlfIfa1UTqwR0sxspWAskJJGJ7uWriYcH
	YN6+gzcS2KpJwxTRerR5Q/zXom4jadRbZjNWI3oPKY/JZmjRjaGfS+FbCTB4QC+X+XrhSZbOS2r
	zr0lB3KQgXSYXryhAaWc9lj3wKOPSG9Y=
X-Gm-Gg: ASbGnctZoiAuUvGTe2npAGq9YcrxjpHVvJfl/f/O1fmXPqKZYBGhklx7Zpbi52Srw3c
	KxWT+4kfsTYfhtjtZFwHqkMoJw0GBPqs8+YOBW27Opx/WExrIGfYGgIABLvnIed2vtFMnOpd5BM
	s1ETM5YsgN5Xzs7UYDL54uZgGdXSygmfH2p4ZcX8xDGW7hEGTrEc7k3/lMLS705sbwMkem/Va2y
	jh6lg==
X-Google-Smtp-Source: AGHT+IG0mgYvT5kpudU6JBy79HoJor3+A1PLqYusQ7whieg5l9/kAstZ1IOiqt1ql+aYF7lyLGGYc4RTYbIiHCVo5p4=
X-Received: by 2002:a17:907:60d2:b0:ae3:6d27:5246 with SMTP id
 a640c23a62f3a-afdf0205351mr278895766b.48.1755698495409; Wed, 20 Aug 2025
 07:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205171930.968-1-linux.amoon@gmail.com> <20240205171930.968-2-linux.amoon@gmail.com>
 <CANAwSgSzUW97U8MbWPdb_g4hqEpvLrVDGHG9Gjs2xALbDasqmg@mail.gmail.com>
In-Reply-To: <CANAwSgSzUW97U8MbWPdb_g4hqEpvLrVDGHG9Gjs2xALbDasqmg@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 20 Aug 2025 19:31:16 +0530
X-Gm-Features: Ac12FXyMcTdBuOxtvDWahcqoFUq85wpCJOj43vT1dhbjrrGJIqgkd2zIHaAMyYo
Message-ID: <CANAwSgT5RPNviXGfP9wdXoYMB220b=fd0mFbcANtWzSu+aPDQw@mail.gmail.com>
Subject: Re: [PATCHv1 1/5] arm64: dts: amlogic: Add cache information to the
 Amlogic GXBB and GXL SoC
To: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Neil,

On Tue, 27 Feb 2024 at 18:33, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Neil,
>
> On Mon, 5 Feb 2024 at 22:50, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > As per S905 and S905X datasheet add missing cache information to
> > the Amlogic GXBB and GXL SoC.
> >
> > - Each Cortex-A53 core has 32KB of L1 instruction cache available and
> >         32KB of L1 data cache available.
> > - Along with 512KB Unified L2 cache.
> >
> > To improve system performance.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Datasheet
> > [0] https://dn.odroid.com/S905/DataSheet/S905_Public_Datasheet_V1.1.4.pdf
> > ---
>
> As per the Arm Cortex A53 TRM documentation
> [0] https://developer.arm.com/documentation/ddi0500/j/Introduction/Implementation-options?lang=en
>
> Since this SoC supports arm-pmu we could  read cache info using perf
> [1] https://www.baeldung.com/linux/analyze-cache-misses
>
> [alarm@archl-librecm ~]$ sudo perf list
>
> List of pre-defined events (to be used in -e or -M):
>
>   branch-instructions OR branches                    [Hardware event]
>   branch-misses                                      [Hardware event]
>   bus-cycles                                         [Hardware event]
>   cache-misses                                       [Hardware event]
>   cache-references                                   [Hardware event]
>   cpu-cycles OR cycles                               [Hardware event]
>   instructions                                       [Hardware event]
>   alignment-faults                                   [Software event]
>   bpf-output                                         [Software event]
>   cgroup-switches                                    [Software event]
>   context-switches OR cs                             [Software event]
>   cpu-clock                                          [Software event]
>   cpu-migrations OR migrations                       [Software event]
>   dummy                                              [Software event]
>   emulation-faults                                   [Software event]
>   major-faults                                       [Software event]
>   minor-faults                                       [Software event]
>   page-faults OR faults                              [Software event]
>   task-clock                                         [Software event]
>   duration_time                                      [Tool event]
>   user_time                                          [Tool event]
>   system_time                                        [Tool event]
>
> armv8_cortex_a53:
>   L1-dcache-loads OR armv8_cortex_a53/L1-dcache-loads/
>   L1-dcache-load-misses OR armv8_cortex_a53/L1-dcache-load-misses/
>   L1-dcache-prefetch-misses OR armv8_cortex_a53/L1-dcache-prefetch-misses/
>   L1-icache-loads OR armv8_cortex_a53/L1-icache-loads/
>   L1-icache-load-misses OR armv8_cortex_a53/L1-icache-load-misses/
>   dTLB-load-misses OR armv8_cortex_a53/dTLB-load-misses/
>   iTLB-load-misses OR armv8_cortex_a53/iTLB-load-misses/
>   branch-loads OR armv8_cortex_a53/branch-loads/
>   branch-load-misses OR armv8_cortex_a53/branch-load-misses/
>   node-loads OR armv8_cortex_a53/node-loads/
>   node-stores OR armv8_cortex_a53/node-stores/
>   br_immed_retired OR armv8_cortex_a53/br_immed_retired/[Kernel PMU event]
>   br_mis_pred OR armv8_cortex_a53/br_mis_pred/       [Kernel PMU event]
>   br_pred OR armv8_cortex_a53/br_pred/               [Kernel PMU event]
>   bus_access OR armv8_cortex_a53/bus_access/         [Kernel PMU event]
>   bus_cycles OR armv8_cortex_a53/bus_cycles/         [Kernel PMU event]
>   cid_write_retired OR armv8_cortex_a53/cid_write_retired/[Kernel PMU event]
>   cpu_cycles OR armv8_cortex_a53/cpu_cycles/         [Kernel PMU event]
>   exc_return OR armv8_cortex_a53/exc_return/         [Kernel PMU event]
>
> [alarm@archl-librecm ~]$ perf stat -B -e
> cache-references,cache-misses,cycles,instructions,branches,faults,migrations
> sleep 5
>
>  Performance counter stats for 'sleep 5':
>
>              52794      cache-references:u
>               2311      cache-misses:u                   #    4.38% of
> all cache refs
>             480343      cycles:u
>             140018      instructions:u                   #    0.29
> insn per cycle
>              15012      branches:u
>                 46      faults:u
>                  0      migrations:u
>
>        5.008073381 seconds time elapsed
>
>        0.000000000 seconds user
>        0.006952000 seconds sys
>
I just wanted to revisit this patch series with some updates on
Arm Cortex A53 TRM, here are the L1 and L2 Cache size details.

[1] https://developer.arm.com/documentation/ddi0500/j/Level-1-Memory-System/About-the-L1-memory-system?lang=en
[2] https://developer.arm.com/documentation/ddi0500/j/Level-2-Memory-System/About-the-L2-memory-system?lang=en
[3] https://boardor.com/blog/understanding-the-architecture-of-arm-cortex-a53-cache

Thanks
-Anand

