Return-Path: <linux-kernel+bounces-805523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E65AB489A5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042871680B0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311F42F83AE;
	Mon,  8 Sep 2025 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NzU48yL6"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A742F5306
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326188; cv=none; b=YiY0YNrdVMkFO77UixVACJrSFajOEZGJ4QxzykwtoB3MNLr/Tk+TwjcxSDBIU6iFKrEFIMn6p9TfdYgY04+xHfIgID+ytwTNDDsLK08JRnEil7ofOl5dmMlYPh0nACcp4zucd51f5rNRT8VfRVQ1CVeIPBF4UE30hkjolmcl6aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326188; c=relaxed/simple;
	bh=Qq6riTPm2rueQMQkOfKmSuNcy3bdh8dnvTR6Js2o/qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJeanOWrxBhSd82W8mN9iGbZZ3GSNUJ4fpsIdy1drwjue6HGL2ShMRd/BwndR0mtyxZfavvPMe3Us2zPijVh0kxPncC5V5hgmJifshHP3dn7T54j+GBcvelQnE+8/ue0jbiiki2O2Qml42e7jvU4tatcClOekaGB3c0ux4Ptvt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NzU48yL6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so35696225e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757326184; x=1757930984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=loBAPZn7jZfvkoicSll1Tf3khNjpahU6T+pGDlZXXHI=;
        b=NzU48yL6TePxgIraBCR7Pr9w6vb97RL3u1UeqvaQpGJEHB2A86uo4GDEScE/BGTCIc
         Jxa/ddmlKsKDMcUI77s+ix/NcNcmTgAq4uq+2z+wRNxlcjAt3uz9pg88vAyLxrhZQMLV
         krzFjFxqDj0oOYT/SAxRRnz+DZ6jUL0oBLq9xk2J7QRHb3+td9FJtwisHuO7l3o7XP8H
         BRX13b5Sf0cCESY29jPxmbVurRnnuJDI+G0/F4Ra+4zm+KsCqTgALdS92yByVpj5cuOl
         sUqKfz0DWuIhJmg7tU59TX3UILCem23wkGE4zqDFWn4LuursSteTuPSRBJeOBlKcGize
         EuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757326184; x=1757930984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loBAPZn7jZfvkoicSll1Tf3khNjpahU6T+pGDlZXXHI=;
        b=XPvT6+qp5VYBA8Yj0jH+CCgIqd7gO/nMxTN2ve8N+bBt9kegD2z5hRemJfZymPqwmc
         IudwkuD8elKmqU9ILqKp69EjXCvxFzfXNsAa2t/V1rvwfGPKbv/Iq0McOypEXcY55Djo
         vSO92aH0l+sbvMOCur4uIckqp4SGO69IPofedjoDTUvYuei5CtLugTepc1KH+/KGRcdB
         WiAsO7kY++GXGhc+IZqEy/9YG/V3/gr8MXAVOcjVYCy2givWzzuR1O/H2PX5fWPrcLIT
         0cUfX8hXUd7P6wgZs5NbSmWNRQhnM8zHZwweOTYyHAYm/HR9r66GaltHeVKlK5aprokn
         zpig==
X-Forwarded-Encrypted: i=1; AJvYcCVRFviCugdBrmJeWOkzfHqGL3CXKDn2fkIeL78eeaJQR7azElwDKwuusreyDF7qhNZ0DbPcDnVMmLk7KYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxlpsmQ9PrKqnJc+MzM4iCCol0VNr+0DATs4RnweChuM2RAN2l
	pgFC0j7F4P2/VlFZmp0bCw5YKW82f5YOzIBQxiGKL3Ntmfu8UcTfzuDxdpAA+dW2q4I=
X-Gm-Gg: ASbGncudeO5TnynwFVckavyP2mqTLdNWEGOgTmoxyL29LYCYHpjIMuMreBefgLfgVak
	apPvmLOpSkDb3h/nY2BnAZfxnoM4wFi6+C5AQlbLexmGyvUZ6V2RT5dgiqyoWVdiCWZyjn7iA68
	WcDBgNKuqGVRg1n3XlGSkMtVILAOv0vzR32C1A6JK4aS33LM5qT6OeXWdWeaJSESFpFGn/n08fI
	LoLFEo1/JwbNNz2KQqX1QItywNXG1h+7J5EMqhq0Ekz73fBr5tongk5WrPWjg5/HBgAU/KkGdTL
	lJNWhKVMd5aLqCNVc9yl8b3HWL9G/TO+NEAOvnbVhQti7mZLwEdg1qaI6aLiDrfYYuspcOhbxpJ
	5HtMaXiT598KdqooMZCU4M6a7rbgwlYL295+iuBgi
X-Google-Smtp-Source: AGHT+IGoeoqPrEGwW9DjGKyo/WaAC481m0yF50a09X3rLy0OSLpd7m3ef9LFrP+A/wO0TN/s421I1A==
X-Received: by 2002:a05:600c:630e:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-45dddee5da3mr54003155e9.27.1757326184156;
        Mon, 08 Sep 2025 03:09:44 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd0869b33sm193338125e9.9.2025.09.08.03.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 03:09:43 -0700 (PDT)
Message-ID: <409ddefc-24f8-465c-8872-17dc585626a6@suse.com>
Date: Mon, 8 Sep 2025 12:09:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/10] scalable symbol flags with __kflagstab
To: Sid Nayyar <sidnayyar@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Nicolas Schier <nicolas.schier@linux.dev>,
 Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Giuliano Procida <gprocida@google.com>,
 =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>
References: <20250829105418.3053274-1-sidnayyar@google.com>
 <4e215854-59df-489b-b92d-8d2fb2edf522@suse.com>
 <CA+OvW8ZY1D3ECy2vw_Nojm1Kc8NzJHCpqNJUF0n8z3MhLAQd8A@mail.gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CA+OvW8ZY1D3ECy2vw_Nojm1Kc8NzJHCpqNJUF0n8z3MhLAQd8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/4/25 1:28 AM, Sid Nayyar wrote:
> On Mon, Sep 1, 2025 at 1:27 PM Petr Pavlu <petr.pavlu@suse.com> wrote:
>> Merging __ksymtab and __ksymtab_gpl into a single section looks ok to
>> me, and similarly for __kcrctab and __kcrtab_gpl. The __ksymtab_gpl
>> support originally comes from commit 3344ea3ad4 ("[PATCH] MODULE_LICENSE
>> and EXPORT_SYMBOL_GPL support") [1], where it was named __gpl_ksymtab.
>> The commit doesn't mention why the implementation opts for using
>> a separate section, but I suspect it was designed this way to reduce
>> memory/disk usage.
>>
>> A question is whether the symbol flags should be stored in a new
>> __kflagstab section, instead of adding a flag member to the existing
>> __ksymtab. As far as I'm aware, no userspace tool (particularly kmod)
>> uses the __ksymtab data, so we are free to update its format.
>>
>> Note that I believe that __kcrctab/__kcrtab_gpl is a separate section
>> because the CRC data is available only if CONFIG_MODVERSIONS=y.
>>
>> Including the flags as part of __ksymtab would be obviously a simpler
>> schema. On the other hand, an entry in __ksymtab has in the worst case
>> a size of 24 bytes with an 8-byte alignment requirement. This means that
>> adding a flag to it would require additional 8 bytes per symbol.
> 
> Thanks for looking into the history of the _gpl split. We also noted
> that there were up to five separate arrays at one point.
> 
> We explored three approaches to this problem: using the existing
> __ksymtab, packing flags as bit-vectors, and the proposed
> __kflagstab. We ruled out the bit-vector approach due to its
> complexity, which would only save a few bits per symbol. The
> __ksymtab approach, while the simplest, was too wasteful of space.
> The __kflagstab seems like a good compromise, offering a slight
> increase in complexity over the __ksymtab method but requiring only
> one extra byte per symbol.

This sounds reasonable to me. Do you have any numbers on hand that would
show the impact of extending __ksymtab?

> 
>>>
>>> The motivation for this change comes from the Android kernel, which uses
>>> an additional symbol flag to restrict the use of certain exported
>>> symbols by unsigned modules, thereby enhancing kernel security. This
>>> __kflagstab can be implemented as a bitmap to efficiently manage which
>>> symbols are available for general use versus those restricted to signed
>>> modules only.
>>
>> I think it would be useful to explain in more detail how this protected
>> schema is used in practice and what problem it solves. Who is allowed to
>> provide these limited unsigned modules and if the concern is kernel
>> security, can't you enforce the use of only signed modules?
> 
> The Android Common Kernel source is compiled into what we call
> GKI (Generic Kernel Image), which consists of a kernel and a
> number of modules. We maintain a stable interface (based on CRCs and
> types) between the GKI components and vendor-specific modules
> (compiled by device manufacturers, e.g., for hardware-specific
> drivers) for the lifetime of a given GKI version.
> 
> This interface is intentionally restricted to the minimal set of
> symbols required by the union of all vendor modules; our partners
> declare their requirements in symbol lists. Any additions to these
> lists are reviewed to ensure kernel internals are not overly exposed.
> For example, we restrict drivers from having the ability to open and
> read arbitrary files. This ABI boundary also allows us to evolve
> internal kernel types that are not exposed to vendor modules, for
> example, when a security fix requires a type to change.
> 
> The mechanism we use for this is CONFIG_TRIM_UNUSED_KSYMS and
> CONFIG_UNUSED_KSYMS_WHITELIST. This results in a ksymtab
> containing two kinds of exported symbols: those explicitly required
> by vendors ("vendor-listed") and those only required by GKI modules
> ("GKI use only").
> 
> On top of this, we have implemented symbol import protection
> (covered in patches 9/10 and 10/10). This feature prevents vendor
> modules from using symbols that are not on the vendor-listed
> whitelist. It is built on top of CONFIG_MODULE_SIG. GKI modules are
> signed with a specific key, while vendor modules are unsigned and thus
> treated as untrusted. This distinction allows signed GKI modules to
> use any symbol in the ksymtab, while unsigned vendor modules can only
> access the declared subset. This provides a significant layer of
> defense and security against potentially exploitable vendor module
> code.

If I understand correctly, this is similar to the recently introduced
EXPORT_SYMBOL_FOR_MODULES() macro, but with a coarser boundary.

I think that if the goal is to control the kABI scope and limit the use
of certain symbols only to GKI modules, then having the protection
depend on whether the module is signed is somewhat odd. It doesn't give
me much confidence if vendor modules are unsigned in the Android
ecosystem. I would expect that you want to improve this in the long
term.

It would then make more sense to me if the protection was determined by
whether the module is in-tree (the "intree" flag in modinfo) or,
alternatively, if it is signed by a built-in trusted key. I feel this
way the feature could be potentially useful for other distributions that
care about the kABI scope and have ecosystems where vendor modules are
properly signed with some key. However, I'm not sure if this would still
work in your case.

> 
> Finally, we have implemented symbol export protection, which prevents
> a vendor module from impersonating a GKI module by exporting any of
> the same symbols. Note that this protection is currently specific to
> the Android kernel and is not included in this patch series.
> 
> We have several years of experience with older implementations of
> these protection mechanisms. The code in this series is a
> considerably cleaner and simpler version compared to what has been
> shipping in Android kernels since Android 14 (6.1 kernel).

I agree. I'm not aware of any other distribution that would immediately
need this feature, so it is good if the implementation is kept
reasonably straightforward and doesn't overly complicate the module
loader code.

-- 
Thanks,
Petr

