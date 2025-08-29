Return-Path: <linux-kernel+bounces-791233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C568B3B3BD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E061F1C81FFD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786502586E8;
	Fri, 29 Aug 2025 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mp69JyKo"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F331EEA49
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756450931; cv=none; b=mByIzuuc8XiTFT61xOjyZr86aUUw0QF/AQwDi4jfC20rGxN6CHOobE0iIFvNR5xxv/G4NJgXzXE/MKz/hsQkdB+W/XO46A4SCcb4paTX2fUn1CCYyjRL5Pq2IpuwskPH0/UioJJPgbsYpx3cnXsOCFxVhOJYkBJo4ik98TwYr9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756450931; c=relaxed/simple;
	bh=omNOP8uD0neMoRr0vom7QO6aDGEbvrDeBjuKiW80gHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7cCnx11oCK62AIGyLV8kecK/L0QJCixhPSMsxEqpUD8vre/9Lfy/BwvKH2+hmIz9YafYZR6nq1FShctMZJBJL+9L3vSKFzik+glsYZ6Db8pWs0wh/E9e1vf7u9aLBBm+7CTWCSvsAYKFuABWaHs6lX8j73fFImvrAz+xDSa3Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mp69JyKo; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756450917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bd3e+8o7urvotPF03J0WT4gVg9O1YwwE9+c++fsRojQ=;
	b=mp69JyKortaWInQLSW7cMq0ncQFO5YRlAMNZrK3aH8eV7sNS3aTTHWbOffVvbRLfVxf3B8
	Yu9z1dadwum1L6avbgQmXC7uJpT9IziYn6d+nTK5dj45TmWs0SkU+AeI3dERMgv8q1AbIn
	RLx8tc6me9gjL9CTvdTrdThJ9n/2Sgc=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, shuah@kernel.org, yikai.lin@vivo.com,
 memxor@gmail.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v2 3/3] selftests/bpf: add benchmark testing for
 kprobe-multi-all
Date: Fri, 29 Aug 2025 15:01:41 +0800
Message-ID: <3664215.iIbC2pHGDl@7940hx>
In-Reply-To: <aK4BiJduYDsw7e0m@krava>
References:
 <20250826080430.79043-1-dongml2@chinatelecom.cn>
 <20250826080430.79043-4-dongml2@chinatelecom.cn> <aK4BiJduYDsw7e0m@krava>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/8/27 02:48 Jiri Olsa <olsajiri@gmail.com> write:
> On Tue, Aug 26, 2025 at 04:04:30PM +0800, Menglong Dong wrote:
> > For now, the benchmark for kprobe-multi is single, which means there is
> > only 1 function is hooked during testing. Add the testing
> > "kprobe-multi-all", which will hook all the kernel functions during
> > the benchmark. And the "kretprobe-multi-all" is added too.
> 
> hi,
> fyi this bench causes panic on my setup.. very silent, so not sure
> yet which function we should blacklist next, attaching my .config

According to my testing, the panic is due to the task hang.
With so many debug config enabled(KASAN, LOCKDEP, etc),
the system will become quite slow. What's wrose, there are
many debug function is called during fprobe_entry(), which
makes the BPF much slower. If you wait long enough, the
testing can still run.

Add more symbol to the blacklist can mitigate this problem,
but we need to maintain many symbols for this purpose. So
I suggest that we only run this testing in product kernel.

What do you think?

Thanks!
Menglong Dong

> 
> jirka
> 





