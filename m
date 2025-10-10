Return-Path: <linux-kernel+bounces-848285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9504CBCD48D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928C2189C12E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AAF2F3C03;
	Fri, 10 Oct 2025 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Le6DjO+9"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE2234BA3A
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760103262; cv=none; b=RO77oaB1yHi8sxxUFDvrttaGAVGRgwLBfRT97vaPtwynutnBJshLxrJpcnIrib84J0c/1/XDYZfOBXHThv0/LJ6yumRUlNy4sF8y3lWF4+XWQmOMvKI87YsCbFXEGhynprRyqu4My5ItIJEd7fGHGH8mGG02yQjGCZrGmNqMpcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760103262; c=relaxed/simple;
	bh=DZiQCX5XUYZdTQeBytL5g/Uxd4GVZVy4U/Kk3OE7NPw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mw9bMIFQ/IRzax4v062VyaVkn5gKDVwYf8T0bCzeXFODC1K9XGey64yWhYUzjOa3nOYKavLBcfx9Llz67gNF+l00nC0NmRMHOPkoj5tQEYtGbLL16eaaZ+Q+Y2vcOpiKc6keC3DHPHzpBME6N5KmKsVyBxi01FYOQ2aDwA3opcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Le6DjO+9; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 17C433F7D8
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1760103258;
	bh=8Awu2eIx7vXUcm0ifNHBhM6T9yr87CNa2eOKE83TFaY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type;
	b=Le6DjO+95ScR9UK4UKmlJu3pmzXKJ+HM4iHfNMMMdqWC0OimF+NqsYczxPCJwxTQv
	 AS5xjiIY2tOrKHXoMXH2kcgdsoB8aTj5qjlc7zNF/CpwiZUCYIEHQO6bUNQSNQDQM4
	 ZDZDBIRROGJ0YZ8/VhjKMfqIFuYUkC7I2Pxz+iIhejKbW/SZkBpM5zXmjounb6D+Zu
	 6VJlKvsxOJqq2HD9I1fOhE8sMgDYTF7Y1d2ZkN6pRzDQLzOiBBtDQE8sT4QXFpyk10
	 4+xVRSQ9qM096IilLyDeaVmFUyKCUbdEF4AdbgZ3HSEj23B/tk+gj/zbSPl0O5BvFp
	 kwv3HNpJkMj9xkNcwAqJSE6nGUYJfHWInNwDB/4z1iNxLAEUmSuaHBdeXrAsleZ8wR
	 9eQRkSOmaEnMdAxwhLrMgPCcO8Mv5mE77vhTEGQXGG3wOmIyfVNrN4gTWFgOqCjc0A
	 Q+6c9rzUJHFo9YhjuaSxcW9xlc/KvkFe7+TSrPB279AvTOGCQw/H2YG6941UiaS+nX
	 Ldza72UbcO71p6cmr3TFAIZ15MqH834hDTYydqXQ421Byc0soiPIE3BKzDH3yJvpcM
	 oPXJMd09TVzxrJt/NoNFN/DfPD0Gw0z/zjQwvPOClX2rcVHuuJpSB59oX/vqImcyIW
	 tvKIF6xD0FKet66+DG6qDDrw=
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e2c11b94cso14758915e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760103257; x=1760708057;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Awu2eIx7vXUcm0ifNHBhM6T9yr87CNa2eOKE83TFaY=;
        b=vvUbCFWhUPqQ2+OlHnlYxQgwwQMZPKIvZsCbCXRKWMUIKZi7E9YdJbdwzGd5rs5J73
         GK4IBAAt2k+4Htt60QZ+Vo2GuccXV3QKelx8WhqTdan/miz2vpyRYjKZV90D65uUNCW5
         zETcKClOe+m/yCD0fqi+lpsD/xTHcXMRv9xzKFS6jvTwVtBfgvLhB+7gXOEm8yY++Tod
         E5romJhKTkPDTKZUDsACDY/RNx/9eVKmbasckXTRYiJJVkCIzOU1a0h405tGMBMvAA/t
         SFOQxdvBtYyUt1yNNrCquiOnk0/cQ8GSznXn6uOwgCblvbSpcIcpQrGnt6hdV+3pUpKE
         sDcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYC6MKKpQEtqbyW2NIyiCvc1EDrs9gozn00vLj6LIEynRM+3NiJusTIb05Qlvh6o6kOPcaSzSyePB3m+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXoUV+3SDltgpH4vMowKCZNqbFrXGz6gQfx02eWdP8g2N89+9T
	fUOWLScDkacPF8cx+IY+BS2Ul2Dg9hQkIrzJs9SPSldlY4SA/dgrOHnUYd069DezfQya+iztsrj
	mjE0F2l7VF5HCQOk+Q/3AjYScSpfc1o2xegyG1kZlUAwerKM78SY0D7TulsQApybmRSZxlBvdSf
	Ws6FGNnA==
X-Gm-Gg: ASbGnctxrWVYWDi+i18CnYDY7gc5X5euOPx2Xwz9fwUs4pTKsf8p6fsOOwITbvYZvb5
	fg2vUS+OY054NXAyw36UvjisqzRgnxoGNRQc5doWEUqoiXPJMHWQ+xqe2T7w5vTsE0cUm4fKyuh
	QuhtJ7XjZFSESL6dZCaVmIceAqDUjJ+IOfs7BmZ5hxmVrJg2rAs58yoJm92VKprDpHoaxi2LeQT
	A7vplwu0EwQWXfoTWYhWWF8ez/zEnYXibyr6QSlYeTyiWSxGbkzpUpOkMvAkPZ4eN4aHaOPHMpl
	YEEbTobjUy7oXXhpQjCIUR2OImiVfKPBtVFbryOZaMf3sQGnBvCTk9OuYV2DRx3uwJX8ETOADGp
	RHVoDUnfGtkwBfnGI2dVwdzAjRgWx
X-Received: by 2002:a05:6000:41d1:b0:403:6f7d:ac5d with SMTP id ffacd0b85a97d-4266e7dfaf4mr6678126f8f.34.1760103257219;
        Fri, 10 Oct 2025 06:34:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7z1RCyySnr04IwsYiwIMTnCJMVn0IFEFxtmsVNIxWdOTAw2u10BPfhGaSDUipsfPrLTgbYw==
X-Received: by 2002:a05:6000:41d1:b0:403:6f7d:ac5d with SMTP id ffacd0b85a97d-4266e7dfaf4mr6678093f8f.34.1760103256700;
        Fri, 10 Oct 2025 06:34:16 -0700 (PDT)
Received: from [192.168.1.29] (lau06-h06-176-136-128-80.dsl.sta.abo.bbox.fr. [176.136.128.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0987sm4185865f8f.38.2025.10.10.06.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 06:34:16 -0700 (PDT)
Message-ID: <0b7d5ab4-9b1d-4c59-86df-d91829d6d764@canonical.com>
Date: Fri, 10 Oct 2025 15:34:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: Re: [PATCH v5 0/3] lsm: introduce lsm_config_self_policy() and
 lsm_config_system_policy() syscalls
To: Casey Schaufler <casey@schaufler-ca.com>,
 linux-security-module@vger.kernel.org
Cc: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, mic@digikod.net, kees@kernel.org,
 stephen.smalley.work@gmail.com, takedakn@nttdata.co.jp,
 penguin-kernel@I-love.SAKURA.ne.jp, song@kernel.org, rdunlap@infradead.org,
 linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-kernel@vger.kernel.org
References: <20250709080220.110947-1-maxime.belair@canonical.com>
 <5ae541ce-613f-47c0-8a23-1ec9a0b346cf@schaufler-ca.com>
Content-Language: en-US
Autocrypt: addr=maxime.belair@canonical.com; keydata=
 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
 yriCIKEAbLqHTyj+RhbroZmv5q3X7iVq
In-Reply-To: <5ae541ce-613f-47c0-8a23-1ec9a0b346cf@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/9/25 18:48, Casey Schaufler wrote:
> On 7/9/2025 1:00 AM, Maxime Bélair wrote:
>> This patchset introduces two new syscalls: lsm_config_self_policy(),
>> lsm_config_system_policy() and the associated Linux Security Module hooks
>> security_lsm_config_*_policy(), providing a unified interface for loading
>> and managing LSM policies. These syscalls complement the existing per‑LSM
>> pseudo‑filesystem mechanism and work even when those filesystems are not
>> mounted or available.
>>
>> With these new syscalls, users and administrators may lock down access to
>> the pseudo‑filesystem yet still manage LSM policies. Two tightly-scoped
>> entry points then replace the many file operations exposed by those
>> filesystems, significantly reducing the attack surface. This is
>> particularly useful in containers or processes already confined by
>> Landlock, where these pseudo‑filesystems are typically unavailable.
>>
>> Because they provide a logical and unified interface, these syscalls are
>> simpler to use than several heterogeneous pseudo‑filesystems and avoid
>> edge cases such as partially loaded policies. They also eliminates VFS
>> overhead, yielding performance gains notably when many policies are
>> loaded, for instance at boot time.
>>
>> This initial implementation is intentionally minimal to limit the scope
>> of changes. Currently, only policy loading is supported, and only
>> AppArmor registers this LSM hook. However, any LSM can adopt this
>> interface, and future patches could extend this syscall to support more
>> operations, such as replacing, removing, or querying loaded policies.
> 
> It would help me be more confident in the interface if you also included
> hooks for SELinux and Smack. The API needs to be general enough to support
> SELinux's atomic policy load, Smack's atomic and incremental load options,
> and Smack's self rule loads. I really don't want to have to implement
> lsm_config_self_policy2() when I decide to us it for Smack.
> 

I provided a minimal initial implementation for SELinux and Smack in v6.

For SELinux, I implemented only lsm_config_system_policy, which
currently allows to load policies with this syscall.

For Smack, I supported both hooks, allowing modification of both global
and subject rules. However since modifying even the subject rules is a
privileged operation, both operation are limited to CAP_MAC_ADMIN.
If we could ensure that the new rules only further restrict capabilities,
we could allow to load subject rules with fewer privileges.

>>
>> Landlock already provides three Landlock‑specific syscalls (e.g.
>> landlock_add_rule()) to restrict ambient rights for sets of processes
>> without touching any pseudo-filesystem. lsm_config_*_policy() generalizes
>> that approach to the entire LSM layer, so any module can choose to
>> support either or both of these syscalls, and expose its policy
>> operations through a uniform interface and reap the advantages outlined
>> above.
>>
>> This patchset is available at [1], a minimal user space example
>> showing how to use lsm_config_system_policy with AppArmor is at [2] and a
>> performance benchmark of both syscalls is available at [3].
>>
>> [1] https://github.com/emixam16/linux/tree/lsm_syscall
>> [2] https://gitlab.com/emixam16/apparmor/tree/lsm_syscall
>> [3] https://gitlab.com/-/snippets/4864908
>>
>> ---
>> Changes in v5
>>  - Improve syscall input verification
>>  - Do not export security_lsm_config_*_policy symbols
>>
>> Changes in v4
>>  - Make the syscall's maximum buffer size defined per module
>>  - Fix a memory leak
>>
>> Changes in v3
>>  - Fix typos
>>
>> Changes in v2
>>  - Split lsm_manage_policy() into two distinct syscalls:
>>    lsm_config_self_policy() and lsm_config_system_policy()
>>  - The LSM hook now calls only the appropriate LSM (and not all LSMs)
>>  - Add a configuration variable to limit the buffer size of these
>>    syscalls
>>  - AppArmor now allows stacking policies through lsm_config_self_policy()
>>    and loading policies in any namespace through
>>    lsm_config_system_policy()
>> ---
>>
>> Maxime Bélair (3):
>>   Wire up lsm_config_self_policy and lsm_config_system_policy syscalls
>>   lsm: introduce security_lsm_config_*_policy hooks
>>   AppArmor: add support for lsm_config_self_policy and
>>     lsm_config_system_policy
>>
>>  arch/alpha/kernel/syscalls/syscall.tbl        |  2 +
>>  arch/arm/tools/syscall.tbl                    |  2 +
>>  arch/m68k/kernel/syscalls/syscall.tbl         |  2 +
>>  arch/microblaze/kernel/syscalls/syscall.tbl   |  2 +
>>  arch/mips/kernel/syscalls/syscall_n32.tbl     |  2 +
>>  arch/mips/kernel/syscalls/syscall_n64.tbl     |  2 +
>>  arch/mips/kernel/syscalls/syscall_o32.tbl     |  2 +
>>  arch/parisc/kernel/syscalls/syscall.tbl       |  2 +
>>  arch/powerpc/kernel/syscalls/syscall.tbl      |  2 +
>>  arch/s390/kernel/syscalls/syscall.tbl         |  2 +
>>  arch/sh/kernel/syscalls/syscall.tbl           |  2 +
>>  arch/sparc/kernel/syscalls/syscall.tbl        |  2 +
>>  arch/x86/entry/syscalls/syscall_32.tbl        |  2 +
>>  arch/x86/entry/syscalls/syscall_64.tbl        |  2 +
>>  arch/xtensa/kernel/syscalls/syscall.tbl       |  2 +
>>  include/linux/lsm_hook_defs.h                 |  4 +
>>  include/linux/security.h                      | 20 +++++
>>  include/linux/syscalls.h                      |  5 ++
>>  include/uapi/asm-generic/unistd.h             |  6 +-
>>  include/uapi/linux/lsm.h                      |  8 ++
>>  kernel/sys_ni.c                               |  2 +
>>  security/apparmor/apparmorfs.c                | 31 +++++++
>>  security/apparmor/include/apparmor.h          |  4 +
>>  security/apparmor/include/apparmorfs.h        |  3 +
>>  security/apparmor/lsm.c                       | 84 +++++++++++++++++++
>>  security/lsm_syscalls.c                       | 25 ++++++
>>  security/security.c                           | 60 +++++++++++++
>>  tools/include/uapi/asm-generic/unistd.h       |  6 +-
>>  .../arch/x86/entry/syscalls/syscall_64.tbl    |  2 +
>>  29 files changed, 288 insertions(+), 2 deletions(-)
>>
>>
>> base-commit: 9c32cda43eb78f78c73aee4aa344b777714e259b



