Return-Path: <linux-kernel+bounces-730783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB78B049BD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A4B17A82B3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6328223BD0B;
	Mon, 14 Jul 2025 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xC6TWPEo"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E06190676
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752529820; cv=none; b=sP5NviVar5IsPt6IuvrDvaZnFu79pOyte9gIt8S53qzJ7+cLhuUIFgpoUVfAdz5TjhP+a0a10bwHwgJQyXrDyA9yM1jVu72/Wjd/N1vv9WVv8haxybjHJQ5z2tT9H6BQGPaChVS9ZBS0U9DomiBtyfBKr/zh+OWeCHlspKFo87w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752529820; c=relaxed/simple;
	bh=iM0bLDr0wjEfompnEdKiLWQmyHdzCRZYdk03xCWbjnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZHP+8E9elwVkJIluzjghsWfoup19qIcbdN7ZXWE0bmjXcBAbOYLD7PMQytF8a6W4IJQPHVf7nMww29rPPssiG15TrJNWaNl3mX6ozl56BY/Am4hDkDgIan2YmiKEYyqaZK7+i0ZFhBESTMNFlFljl8YQEmnUV01L/SOtBIQDxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xC6TWPEo; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <750dd5f1-a5f8-4ed2-a448-1a57cb5447dc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752529815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PhuocBLqA3gzBc4uu2GGr+rR7kPr/v7HEImY11Vzz0E=;
	b=xC6TWPEoJvNnTQcLv2Qk9thEImxEEpeJqn7+RCxAi0mkv9//Ag4ZtRq8vJz0UUdBGuwd7v
	ya6xCN5GomrCWpqJwJ/ACd97T4mTIq7jDgepOUQaraIQkLKYwBto6SRCXYlZyUKg7r6row
	hkfLasBNcNLb2hVSMr/blgIx8JVP0oo=
Date: Tue, 15 Jul 2025 05:50:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3] bpf: make the attach target more accurate
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Menglong Dong <dongml2@chinatelecom.cn>
References: <20250710070835.260831-1-dongml2@chinatelecom.cn>
 <CAADnVQKmUE3_5RHDFLmKzNSDkLD=Z2g3bkfT2aRsPkFiMPd-4Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Menglong Dong <menglong.dong@linux.dev>
In-Reply-To: <CAADnVQKmUE3_5RHDFLmKzNSDkLD=Z2g3bkfT2aRsPkFiMPd-4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2025/7/15 03:52, Alexei Starovoitov wrote:
> On Thu, Jul 10, 2025 at 12:10 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
>>                          } else {
>> -                               addr = kallsyms_lookup_name(tname);
>> +                               ret = bpf_lookup_attach_addr(NULL, tname, &addr);
>>                          }
> Not sure why your benchmarking doesn't show the difference,
> but above is a big regression.
> kallsyms_lookup_name() is a binary search whereas your
> bpf_lookup_attach_addr() is linear.
> You should see a massive degradation in multi-kprobe attach speeds.


Hi, Alexei. Like I said above, the benchmarking does have
a difference for the symbol in the modules, which makes
the attachment time increased from 0.135543s to 0.176904s
for 8631 symbols. As the symbols in the modules
is not plentiful, which makes the overhead slight(or not?).

But for the symbol in vmlinux, bpf_lookup_attach_addr() will
call kallsyms_on_each_match_symbol(), which is also
a binary search, so the benchmarking has no difference,
which makes sense.

I thought we don't need this patch after the pahole fixes this
problem. Should I send a V4?

Thanks!
Menglong Dong


>
> --
> pw-bot: cr
>

