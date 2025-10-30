Return-Path: <linux-kernel+bounces-877563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51494C1E705
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE5E188B041
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A092D2382;
	Thu, 30 Oct 2025 05:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H7FEbpgI"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B688B286419
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761802647; cv=none; b=cMDc6TutSo23c8N4cZJKBvsgmTJiY16yPzNoG5rTyWetjEQxbFluPK3QRFg9N1b96BgRYjn+bhG6CvISr2vMHr9G9rnp68kM1QdvytZ3nSIGMzV8al51X8Vwbf/stgnKnRzDQ2fpaioO2L3QQ5vkHPggqidsU7Dg9PEnv/BdEB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761802647; c=relaxed/simple;
	bh=46mmGozAfgW5lEgPJaUtGVs4MXmDyYgf5TybHmNQQ7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6nWwYxgDC8sD7Y5DmvQMcaayBbtXQH9MnMLHwOYYf9NKaa3e/rlKj0vjMZbvRgEBpvcI72Y4+TmnVMVYnNXUkV4IbWK5NWEV93ZL0uQg2OiIcACm8rm1jtiDl2xdaWba+pGvWWyHmF9ZouUp+RnDTodK85oNMufTinfqBFXn+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H7FEbpgI; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <44fb71fe-2913-4541-9e4c-a8e9647a7300@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761802639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vW/UvmAQlpIrKevONore/gC6Amc4prfuUc9Jfz4b8f4=;
	b=H7FEbpgI1XeHKqoDskomsDd2bTDMo0tCv6tAYx4x5WPUcrbJ9OshraNqGschWCdQKqPXdf
	CsI/CqhBJIEZFY4zrtlfvvWlZs0AdIeQgfGuhqoYw3k0NaGVQRMTZq27TUqJLlmfqsusfA
	EMYOggVPUjozlOmgycJ8Va5zAWs1IJ8=
Date: Thu, 30 Oct 2025 13:37:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 0/4] bpf: Free special fields when update hash and
 local storage maps
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 patchwork-bot+netdevbpf@kernel.org, Menglong Dong
 <menglong8.dong@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-patches-bot@fb.com
References: <20251026154000.34151-1-leon.hwang@linux.dev>
 <176167501101.2338015.15567107608462065375.git-patchwork-notify@kernel.org>
 <CAEf4BzbTJCUx0D=zjx6+5m5iiGhwLzaP94hnw36ZMDHAf4-U_w@mail.gmail.com>
 <23eddad8-aae3-44ce-948a-f3a8808c1e24@linux.dev>
 <CAADnVQJHAxKmhDdJ_SkgHMf3adiS8MmD5MJCfiFfxU+8peT9-Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQJHAxKmhDdJ_SkgHMf3adiS8MmD5MJCfiFfxU+8peT9-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 30/10/25 00:38, Alexei Starovoitov wrote:
> On Tue, Oct 28, 2025 at 11:50 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>> Right, this is the classic NMI vs spinlock deadlock:
> 
> Leon,
> 
> please stop copy pasting what AI told you.
> I'd rather see a human with typos and grammar mistakes.

Got it.

Thanks,
Leon


