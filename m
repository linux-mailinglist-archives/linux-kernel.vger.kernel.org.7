Return-Path: <linux-kernel+bounces-862437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C06A0BF5484
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB7424FF3A4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733453054F7;
	Tue, 21 Oct 2025 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Rk3c94xz"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5C0248F47
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035708; cv=none; b=bc5HBbAwhZwE05e26UeZ/rGVOt5EFFVL8zJThzJOul8Ryx/VThPMvVjymEFmSfRpRUrAHbsFRdm82eg9GfUJURMDUZvrdWGcbuHebvzaORg4x7PZz660b4QJW9T5WEngJ/cmgOLjiYeuuJyWNRf6vkSDcbKdGy1bygBV56j0dYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035708; c=relaxed/simple;
	bh=YaSBAbdAjpIG34xK5rBs7dOb6NfAJ+QEOT4p38B32Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mvi0IBCJ8nolsyYjgjfsCJ+Nfv7W01VzZbxuZAe8usQhcqlsACwqrex442BrOLTAT2IfvQUTKAb5NzTWSUKg6S0pJmb8/7EouEP+kVIW/DY44kPWhMKzHAwcuCIKcPRltPstavFiFiC0MkK01yzgIytImMM46n+t7RulJ28sKT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Rk3c94xz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so49652775e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761035705; x=1761640505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+WElwxfDhwAQUTUU6M8FcHqJx7EeTmN3/ZrtK46jRLY=;
        b=Rk3c94xzzE0PN+RoGuou8xmw60tdtJ74A+P801lG5T219t+6Uyrw4ql05seXnyG/sa
         sqTeUwbErdOik9QKSGOIvpAj66MJbLhlBbKsK+hKn38sJewgPA/j5lUU28kPB0mis9NQ
         TTCoO/pWRX/bthYXQvgjCN/Nkipa/Gp73jwOFHWHBbOsrdya0eTUCETlPh9Y1pfXfE4w
         4TjV94xtu0DpaBT1sm0M9Fti4+tkUuTwTpDOpdXtQOWzh2p8SkuBaqnyoA2TdzF6vKV5
         eDooE409MyRlLDfjxstpvor9y2+tEtghOUVW45qnVIroxuF8f/Cox/9PwaxxtrY0UvAI
         bVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761035705; x=1761640505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+WElwxfDhwAQUTUU6M8FcHqJx7EeTmN3/ZrtK46jRLY=;
        b=AVOqRUUDIBbe6SD+/KLLE47Vs/f9tWzUnpviVLGMiZn3o0xac3MVdxHJo0pB7/nrXp
         l8DWT88grJQYucYgNnR1GoV0nlWlA6NxLRJ5pti4fYGdC9mO0eOetkiNUk4U31URltVM
         XlB5KkriDIEiB+CQw6IgpIRGs8n7FKtbq1NL67N8v3SHrebmLzSkilzUOV/4Uw6rTI1f
         uyXNaNFLIoITl2MVukLK7GU1RRvKKxQj+9WTI0xiZMGpgSOZCKLKV4uYbLMlxi7wwOcb
         QrP8/xWh7vXiTdw0/3Y+L2gQIJYMyo3EeuIGMB4jgJsB+CPtjX2gdNV6/q+0f6oHrlnh
         tccA==
X-Forwarded-Encrypted: i=1; AJvYcCW0eoD5L0vYSGFvHINmfvdYdl0IRjRo+zaGFKa9hYenxm+isBzY9jgZtEEubxPtOy03F+dsemnkkjiJ/HI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCPuUNOafqYJWZ2mF92DCXMiAApIIvyZduSocbAPA5u02OfprZ
	10x+lRH8B0oo5Sg1bOtWvxmYlSpH/vsMGmIUMTRqqxlC2wOuwd5onyMVDUcAJp6XkU8=
X-Gm-Gg: ASbGncvMbXngl6nocU2BXR1+gBicNYayUA9VXVStb3iHl8A03EveaDRTx8FICk4NzgB
	BSgRlzT19t8I+X0s+0eeRIvAxR+3PO8jZ3yKtSpnj3cUAZB4h1QN8k1RZ5LRjiyso6Fkg7SAATn
	94Yl9OYEsz8SNoyv2CYB4kZsCfueDtBsZEaEhd7sdD8XsuLjbtLVPGuHNEbBvOWIFoUkpveOGAG
	fyaQ4Oy+YOc3YwZgdEE4+CI1et581Qcf5hp7IMrD8pZUF2JjWMqvd7N+QdflahdpmmHK2+PTARJ
	wM0ebFW+wjt3Vhh15jQNEAmAUhC+lkWg2P2k6GBhqcCf13gfU1koB1gPvGLAl1FTaMtsQzrCsny
	LcaG5ph/A5nInoMhyOlX37k+OqZnhEn7utLRYfuaUcScdhlhsjykKOCbKy1Fjho39o8ejhMXFeL
	zcFqwkk/4LXSYbw5pzW41uUFvtEosjGqU=
X-Google-Smtp-Source: AGHT+IHyHD3i9/mFT3HJ78GMd7f/qo1UWDeznE2MAfRacbhe0fu1pqUuTs5oe6SC2j+nOkpKxqDXfw==
X-Received: by 2002:a05:600c:8284:b0:46f:b43a:aedf with SMTP id 5b1f17b1804b1-47117925da1mr94027305e9.38.1761035704645;
        Tue, 21 Oct 2025 01:35:04 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a7dasm21065529f8f.25.2025.10.21.01.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 01:35:04 -0700 (PDT)
Message-ID: <cac5ed5e-3320-4db0-99d8-ea5e97e56bfb@suse.com>
Date: Tue, 21 Oct 2025 10:35:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] scalable symbol flags with __kflagstab
To: Siddharth Nayyar <sidnayyar@google.com>, corbet@lwn.net
Cc: arnd@arndb.de, gprocida@google.com, linux-arch@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, maennich@google.com, mcgrof@kernel.org,
 nathan@kernel.org, nicolas.schier@linux.dev, samitolvanen@google.com
References: <87ikgieiar.fsf@trenco.lwn.net>
 <20251020224317.723069-1-sidnayyar@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251020224317.723069-1-sidnayyar@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/25 12:43 AM, Siddharth Nayyar wrote:
> On Mon, Oct 13, 2025 at 8:02PM Jonathan Corbet <corbet@lwn.net> wrote:
>> I ask "how it will be used" since you don't provide any way to actually
>> mark exports with this new flag. What is the intended usage here?
> 
> Patch 09/10 (last hunk) provides a mechanism to enable import protection
> for all symbols exported by vmlinux. To summarise, modpost enables
> import protection when CONFIG_UNUSED_KSYMS_WHITELIST is set. This
> results in all symbols except for the ones mentioned in the whitelist to
> be protected from being imported by out-of-tree modules. In other words,
> out-of-tree modules can only use symbols mentioned in
> CONFIG_UNUSED_KSYMS_WHITELIST, when the config option is set.
> 
> I realise I should have documented this behaviour, both in the cover
> letter as well as in kernel documentation. I will do so in the following
> version of the patch series.
> 
> Please share any feedback on the mechnism to enable the mechanism. In my
> opinion, CONFIG_UNUSED_KSYMS_WHITELIST has a complementary goal to
> import protection and therefore I felt like using the option to enable
> import protection. In case this seems to convoluted, I am okay with
> introducing an explicit option to enable import protection.

CONFIG_UNUSED_KSYMS_WHITELIST was originally added in commit
1518c633df78 ("kbuild: allow symbol whitelisting with
TRIM_UNUSED_KSYMS"), specifically for Android. Looking at configs of
several distributions [1], it appears that it has only been used by
Android so far. This means it is likely acceptable to protect the
whitelist symbols in this manner.

On the other hand, I think what is protected (all exported symbols or
CONFIG_UNUSED_KSYMS_WHITELIST) and how it is protected
(KSYM_FLAG_PROTECTED) are two different things, so it might be cleaner
to keep them separate.

> 
>> If I understand things correctly, applying this series will immediately
>> result in the inability to load any previously built modules, right?
>> That will create a sort of flag day for anybody with out-of-tree modules
>> that some may well see as a regression. Is that really the intent?
> 
> Unfortunately this series will break all modules which export symbols
> since older versions of such modules will not have the kflagstab
> section.

I would add that out-of-tree modules are typically leaves that don't
export any symbols. This means it should still be possible to load such
modules on an updated kernel.

A problem occurs when out-of-tree support is split into multiple
modules, where one module exports data for another. Some drivers can be
split in such a way. For example, a NIC driver might be divided into
core, Ethernet and InfiniBand modules, where the core provides exports
for the latter modules.

In such a case, the kernel will ignore the __ksymtab_gpl section in the
first module and issue a warning about it (patch #6). Eventually, when
the second module is attempted to be inserted, the load operation will
result in an error due to an unresolved import.

In practice, I believe this series should have limited impact. Stable
trees and distributions that care about kABI stability should not
backport it. In contrast, people who follow master releases typically
don't use out-of-tree modules, or they know how to deal with updating
them. In this case, only recompilation is needed, which is less
impactful than when an API changes and the actual module code needs to
be updated.

In the past, there were already breaking changes to the format of the
exported data, notably in commit 7290d5809571 ("module: use relative
references for __ksymtab entries") and 8651ec01daed ("module: add
support for symbol namespaces."). As far as I'm aware, these changes
didn't cause significant trouble, even though they actually resulted in
silent breakages of old modules with exports.

> 
> Out-of-tree modules which do not export symbols of their own will only
> fail to load in case the CONFIG_UNUSED_KSYMS_WHITELIST is set and the
> symbols which these modules consume are not present in the whitelist.

[1] https://oracle.github.io/kconfigs/?config=UTS_RELEASE&config=UNUSED_KSYMS_WHITELIST

-- 
Thanks,
Petr

