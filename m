Return-Path: <linux-kernel+bounces-788656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C588CB3882C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755E54642ED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFAD2EF66E;
	Wed, 27 Aug 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BnZyVOKc"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF8B227B9F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756314046; cv=none; b=XfNok27QZ9mnxfIGqKLtTifn4Qgdzg7J/Rr6vVjNuydspH75MOeXN9jf9O54DrrPLTQyDbZWzOz40CKZNQp20E6kllRTyv/Aezd2AmjcCLF0ZOSj98stR1ibLnvEqtBHpaXE0KHPGI1lCRSiVnHWaBPhfjT1lhOmeeVeWGXm5qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756314046; c=relaxed/simple;
	bh=9yqufHvxMyqOIuBjpYx/ib/8sJw+wS8Coz+Mudh6V4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EbP8lRMA/8lFs14W3mjsuZBq8h9LW4HHOE3X/0tboROKpXw+Hnmfu0afkE7NniVot63bj8fT5OquNrnB6q6ow0ME8GuZhA1PF+MqMttcFRqyFSuwoz+q481SrXD/TYxV5jvS/BteuTFDp/tujai2A4HiZOM/VUsKx/2OBMEYn+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BnZyVOKc; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a3dabb42-efb5-4aea-8bf8-b3d5ae26dfa1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756314032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MQB/6JVMGJQhxdK5s0Uv3W7F4OgykgH3Ou1OA3AP5Y4=;
	b=BnZyVOKc0NcNLarruwwAHzn5UmenXPlIhhYZuCnflHrxe23c1TDsaNxyXgcjd0IVH2gFPy
	b35nkqWPRPgvGzGes8DbFsVDbmlaC/kqS3pwpTnaB+Yu8TILtgdWPg+MY74EN4CbgHW8No
	ON9WhcLpsDOvhEi19s8QZ836ZkzOkxk=
Date: Wed, 27 Aug 2025 10:00:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Mark kfuncs as __noclone
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, Andrea Righi <arighi@nvidia.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250822140553.46273-1-arighi@nvidia.com>
 <86de1bf6-83b0-4d31-904b-95af424a398a@linux.dev>
 <45c49b4eedc6038d350f61572e5eed9f183b781b.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <45c49b4eedc6038d350f61572e5eed9f183b781b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/26/25 10:02 PM, Eduard Zingerman wrote:
> On Tue, 2025-08-26 at 13:17 -0700, Yonghong Song wrote:
>
> [...]
>
>> I tried with gcc14 and can reproduced the issue described in the above.
>> I build the kernel like below with gcc14
>>     make KCFLAGS='-O3' -j
>> and get the following build error
>>     WARN: resolve_btfids: unresolved symbol bpf_strnchr
>>     make[2]: *** [/home/yhs/work/bpf-next/scripts/Makefile.vmlinux:91: vmlinux] Error 255
>>     make[2]: *** Deleting file 'vmlinux'
>> Checking the symbol table:
>>      22276: ffffffff81b15260   249 FUNC    LOCAL  DEFAULT    1 bpf_strnchr.cons[...]
>>     235128: ffffffff81b1f540   296 FUNC    GLOBAL DEFAULT    1 bpf_strnchr
>> and the disasm code:
>>     bpf_strnchr:
>>       ...
>>
>>     bpf_strchr:
>>       ...
>>       bpf_strnchr.constprop.0
>>       ...
>>
>> So in symbol table, we have both bpf_strnchr.constprop.0 and bpf_strnchr.
>> For such case, pahole will skip func bpf_strnchr hence the above resolve_btfids
>> failure.
>>
>> The solution in this patch can indeed resolve this issue.
> It looks like instead of adding __noclone there is an option to
> improve pahole's filtering of ambiguous functions.
> Abstractly, there is nothing wrong with having a clone of a global
> function that has undergone additional optimizations. As long as the
> original symbol exists, everything should be fine.

Right. The generated code itself is totally fine. The problem is
currently pahole will filter out bpf_strnchr since in the symbol table
having both bpf_strnchr and bpf_strnchr.constprop.0. It there is
no explicit dwarf-level signature in dwarf for bpf_strnchr.constprop.0.
(For this particular .constprop.0 case, it is possible to derive the
  signature. but it will be hard for other suffixes like .isra).
The current pahole will have strip out suffixes so the function
name is 'bpf_strnchr' which covers bpf_strnchr and bpf_strnchr.constprop.0.
Since two underlying signature is different, the 'bpf_strnchr'
will be filtered out.

I am actually working to improve such cases in llvm to address
like foo() and foo.<...>() functions and they will have their
own respective functions. We will discuss with gcc folks
about how to implement similar approaches in gcc.


>
> Since kfuncs are global, this should guarantee that the compiler does not
> change their signature, correct? Does this also hold for LTO builds?

Yes, the original signature will not changed. This holds for LTO build
and global variables/functions will not be renamed.

> If so, when pahole sees a set of symbols like [foo, foo.1, foo.2, ...],

The compiler needs to emit the signature in dwarf for foo.1, foo.2, etc. and this
is something I am working on.

> with 'foo' being global and the rest local, then there is no real need
> to filter out 'foo'.

I think the current __noclone approach is okay as the full implementation
for signature changes (foo, foo.1, ...) might takes a while for both llvm
and gcc.

>
> Wdyt?
>
> [...]


