Return-Path: <linux-kernel+bounces-893026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A6DC4661C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AAE3A6823
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03223093CD;
	Mon, 10 Nov 2025 11:50:36 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E8E309EE2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775436; cv=none; b=eTMO7wR9EUsndty5SbE8Fv5wNRHwbfxyTHQXujvfjNToM34GA2BfdBLiSHqvCbqoutvaGxIY0O43nGFJIM5VlB+P9WVJLEMbtM1SWe10R5/u2B56DusfFRKVeeYkg4FSwxXypnzDv/sHmrhPag9gHJ+PwaezQtcUrIpOo49bXuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775436; c=relaxed/simple;
	bh=ERs0u0zkQlzIeg3jZm9sjx4QfAqbHsrh9tiqoUmaybU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IiI/OywqNfubBFHReUFLTqBTHwfe40iNSu7ACqN55jkuGBroQySLdX07CX1m8lWG8hRvFKl/vS0IIvEPsmFWx11T9Yqc8CJ8fW2Ve04muO6Rx9NmPPIPo4hRvqvlzjTBjJS62lEVvfP6Qj+kIGQqKetcsPetE2bpXAErwF8U26s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d4nbl2pTqz9sSS;
	Mon, 10 Nov 2025 12:33:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ju2cuXQ6JEfZ; Mon, 10 Nov 2025 12:33:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d4nbl0zrcz9sSR;
	Mon, 10 Nov 2025 12:33:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DFE738B764;
	Mon, 10 Nov 2025 12:33:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ioscGiQ2gGqe; Mon, 10 Nov 2025 12:33:22 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6A62D8B763;
	Mon, 10 Nov 2025 12:33:22 +0100 (CET)
Message-ID: <d2e51443-49dd-445a-88aa-f29d7b777bce@csgroup.eu>
Date: Mon, 10 Nov 2025 12:33:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] powerpc/tools: drop `-o pipefail` in gcc check
 scripts
To: Jan Stancek <jstancek@redhat.com>,
 Justin Forbes <jforbes@fedoraproject.org>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 npiggin@gmail.com, linux-kernel@vger.kernel.org, joe.lawrence@redhat.com
References: <cc6cdd116c3ad9d990df21f13c6d8e8a83815bbd.1758641374.git.jstancek@redhat.com>
 <CAFxkdApQVEqCjQMAUqy8cuKnMy8GY9j+brgPZBkxCpeGi5xHxA@mail.gmail.com>
 <CAASaF6zvFa-mPaPfKnBcerfVBkDt5B3TEn7P9jjAfentqSNmxQ@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <CAASaF6zvFa-mPaPfKnBcerfVBkDt5B3TEn7P9jjAfentqSNmxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 30/10/2025 à 19:09, Jan Stancek a écrit :
> On Mon, Oct 6, 2025 at 10:19 PM Justin Forbes <jforbes@fedoraproject.org> wrote:
>>
>> On Tue, Sep 23, 2025 at 9:31 AM Jan Stancek <jstancek@redhat.com> wrote:
>>>
>>> We've been observing rare non-deterministic kconfig failures during
>>> olddefconfig, where ARCH_USING_PATCHABLE_FUNCTION_ENTRY was getting
>>> disabled and with it number of other config options that depend on it.
>>>
>>> The reason is that gcc-check-fpatchable-function-entry.sh can fail
>>> if `grep -q` (or scripts/dummy-tools/gcc) is fast enough to exit while
>>> there is still someone writing on other side of pipe. `pipefail`
>>> propagates that error up to kconfig.
>>>
>>> This can be seen for example with:
>>>    # (set -e; set -o pipefail; yes | grep -q y); echo $?
>>>    141
>>>
>>> or by running the actual check script in loop extensively:
>>>    ----------------------------- 8< -------------------------------
>>>    function kconfig()
>>>    {
>>>      for i in `seq 1 100`; do
>>>        arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh \
>>>          ./scripts/dummy-tools/gcc -mlittle-endian \
>>>          || { echo "Oops"; exit 1; }
>>>      done
>>>    }
>>>
>>>    for ((i=0; i<$(nproc); i++)); do kconfig & done
>>>    wait; echo "Done"
>>>    ----------------------------- >8 -------------------------------
>>>
>>> Fixes: 0f71dcfb4aef ("powerpc/ftrace: Add support for -fpatchable-function-entry")
>>> Fixes: b71c9ffb1405 ("powerpc: Add arch/powerpc/tools directory")
>>> Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
>>> Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
>>> Signed-off-by: Jan Stancek <jstancek@redhat.com>
>>> ---
>>>   arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh | 1 -
>>>   arch/powerpc/tools/gcc-check-mprofile-kernel.sh           | 1 -
>>>   2 files changed, 2 deletions(-)
>>>
>>> diff --git a/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh b/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
>>> index 06706903503b..baed467a016b 100755
>>> --- a/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
>>> +++ b/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
>>> @@ -2,7 +2,6 @@
>>>   # SPDX-License-Identifier: GPL-2.0
>>>
>>>   set -e
>>> -set -o pipefail
>>>
>>>   # To debug, uncomment the following line
>>>   # set -x
>>> diff --git a/arch/powerpc/tools/gcc-check-mprofile-kernel.sh b/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
>>> index 73e331e7660e..6193b0ed0c77 100755
>>> --- a/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
>>> +++ b/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
>>> @@ -2,7 +2,6 @@
>>>   # SPDX-License-Identifier: GPL-2.0
>>>
>>>   set -e
>>> -set -o pipefail
>>>
>>>   # To debug, uncomment the following line
>>>   # set -x
>>> --
>>> 2.47.1
>>
>> Would love to see this picked up, it fixes a problem we have run into
>> with our CI.
>>
>> Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
> 
> Thanks Justin.
> 
> Would any maintainers also care to review? Ty.
> 

Is the problem only with those scripts ? I see other scripts using 
pipefail in the kernel:

arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh:set -o pipefail
arch/powerpc/tools/gcc-check-mprofile-kernel.sh:set -o pipefail
drivers/gpu/drm/ci/dt-binding-check.sh:set -euxo pipefail
drivers/gpu/drm/ci/dtbs-check.sh:set -euxo pipefail
drivers/gpu/drm/ci/kunit.sh:set -euxo pipefail
drivers/gpu/drm/ci/setup-llvm-links.sh:set -euo pipefail
scripts/check-uapi.sh:set -o pipefail

Christophe


