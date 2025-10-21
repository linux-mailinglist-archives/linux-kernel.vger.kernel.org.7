Return-Path: <linux-kernel+bounces-863592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3438ABF841E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E7144F3DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B867F350A13;
	Tue, 21 Oct 2025 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IP2DJpFs"
Received: from sonic305-20.consmr.mail.gq1.yahoo.com (sonic305-20.consmr.mail.gq1.yahoo.com [98.137.64.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669D0351FC0
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.64.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761074843; cv=none; b=LNzHh831JZAiUGIlNC6yrpneC8WPNLzMo0WU5mHCgJGR1xBDJWIvEf7bIl7R85CiIdip1cB6NKfmCZxDrk1uPPUrR+13iPWGlGilM1JAEsVApPKqTlgbVa/Tf+bqelQCRi7d65WRaakiQC54CbYQnJ70P6KiciRVYplz+XAO+yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761074843; c=relaxed/simple;
	bh=9WHKMapeY4ONm5uJai3Huy8KdbO9rMDtQjjWlq54YHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/eh7qaWi1it0Su7ZR7Gm+Z7tmKL+26SNADfrgIw1Uj0zS5mxM8J8MsMSMz6/ZBnBbjlO/4KOkmy53p688Dic8njM3BjfllRSAp3DYJ9A+7l08MO2/iu4DPDuaWXtn+uyhSUnddhamiq1W80QZa8+RlZtN2ds0DLaXdVKRPyYNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=IP2DJpFs; arc=none smtp.client-ip=98.137.64.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1761074835; bh=AB/4EEDvXyNJoCWYApA429rALBJ2NrVI7Ehp+NY4wxo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=IP2DJpFsc+0qKtV36X2EBb2L4FCYlPaRdOsrYU0mtvHbGWi2QphQ5VnQXPGP7n+D8WB5kUCfGf2FAUcpRBKyWwa6LDY70vM/1rk1T7R2/qryAoAZ7qBEkQiM1GKvyfBtK81dVcst8YdDOC+uSrDDGlSRsOdFO5I0WSAtwitAww/pvbGrMFjmKM74oyi1KkjMlKpu2hAEFOB8/8B93akeUZr6ipKf8dUZpm0uk1cXuv5w5+JxEKmi6nIgSiQRxralPCymqwW+HzQ9HmfaDluw4JEEK5s4BU/t6Al7uEMaYshLQGFLy7+y9TAgLD2wNsdg3qwrZAvN9Q5vBWvzka2CZg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1761074835; bh=Q24cOkaunDtt2hCJspgk/UnaFCVwOwqPbO0tEf5sJ00=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=mFvsofgm9hxgR1awXRp54/dFgVyccpWHNxDdqjLHYDQ1qbgDr8F5rnis5Lrs+WaG+zU1Sh4vkfVYzRnSf16CClKSgtbUDL6v8Pcx4ozn4J7mHvXFjaHZYn4ziQJYmZBIzKY5R1ULxitcrYgD4z2Xy8q41u7waryCI0r1fcsXhDAT/MZLceeru5SsS25Avykfa83cgsR9oajZkDXEr+Ujo3/Ddb4yHeNjjs+TdfLU8In8+KKt2desy+skZirXq5mjDq9i7Rc1SyCKRK9SE0RbZoXNqeFKfbIZhEsAIi+f94QPtD61U8KvV7RmNjZEQWsYRQCKEheOJ6/bYv+7ZYKLBA==
X-YMail-OSG: p.FfptsVM1n2PbLV8fIwaijWx.EBezcag2pX_bboOfXHADYGNEbfukKTwG1lgLZ
 gT4hYWhiplaTaFW8tQzm.cGhW1HJSXDMcvyi5ezOdrN1WCugmemYoJr3BfHx77uywWOU_Q.CX3VJ
 4sjggaJd_iOBnVRg65UjIFxDkV0oEYda7sDZ8zRQ3lkurBD1vnnh3tQc0ipHrawAkpIv8ygYpQ4m
 h7LEMkWhUMILvbJK01KfttEqdXzXye2NmI9FycMaA44BcQgHTCkUomR9xI1Qlz0qNOkMCiNGD24R
 DJhs.epSrTffIT92ENo9Jt2lm9zJyk5Kv5veU1k4Q9SJjGXc_Jl04ZJbciqhHC4VAy0mDYI4Ocyc
 kDdK4zRMOB4_xXEEB39VI29VYqITmpEZvZqJhzSp.rrNf9ARSZmlo6_jxP1zIfqmuP0TMFp3f8Ak
 kbbbD_ItX.d.Y4pyjGQ_aTSaByVPrNaswIkkSgNd1zwtjFyc3Po5sX4rKmstQKQ97we74KM39jKD
 fpvoOZx.dH73R5o_kfWwgUnoKXeKP4P5Rd1DYS1FMcT_xSq1jCMxNECUngqCoYmFIdrrltqXoe0M
 aBxZDM2V.ASjwuGLvQt0oxBP21H5UhqNUHiFzRYxDCazpQUo399qxgfBSLE4rkEUmeJ7IzATsfgY
 EEoiOnCLRCwZDOMEKF.85t1VAxJ8OuYuPd5OaEOCiUzbN9VVeo2w8_kYCUgWkRQwhTd3UIbFRLT_
 v54Qsw79USoVCeX7cVWjcBhW4XQhmnFdI7lusVCIERy6ormMS8uwDbDC1pb4OhDKi8P1iN7m40YT
 3mFvkLhtIb0K081maxpuOWMFJRsy3Ko_4Mc2qCttLOBPTeMJ.1UlEVjAOMYtN2ZvlyE4sq_cZL5i
 tDM7r5IiTr9BaFEx9KtpdfFw6dgrvXt_G06IUZdAdYA4aTfo595C08maYo3nmpkXgpU2UV_jj2j0
 HyZv4e14KB23H7yf7Z1B733qDKQjqeyUqqvAVZhwN_mHqblOkg.4AhLjw619jLm6E1gqkTQy9yPm
 dCIelTCiVHeUEhrQTYq1G6WSbASHbq__m1XcnxrmWgvc51_DfxlSiDOrniQak_TCcSgEIQXIBWNs
 8apcYtnPmR7p9K0VCY3UcssQNnZzRwax_zgucmxp7C2Pk0ghEWQbw0rfL4xJzU5MRsVv_go6X_1U
 qFRoaZ_Huagl6wJsvoNPGuov.N1nvFDWCg3_3dfjnp0oJAVzqfwvd3fat4P34q3jWj6Zn0csRFVz
 foF67QAXh98I5N6AFvG_7iUTHdts6_Pr_lUb1hYED5xvA9ihPYboew3wqeHygk4dCoGZLlHzRxvf
 cKxTGk00zAXowTC.0PD_Q7sFbxXyONiSi0m._dPX7Tywq2fYsR3sv8wen5DIg4QxQ_2TmF.ovB2k
 tkq4UHWqWLUdNMSLVXGBwpQ1AXhTAdZ7hyMrheMKkWaXQttpBH.JHXA9jVT1c5FnF5kLhtFrPh05
 21aILFZbkVXpSM8KniHABZw6yQJixj8FyWCcHt5.nsPGdv5sMCcBTuX14OfJhgZLS3cKAu.qp7cq
 XMTNOEHHFXIAvrnC_ThT5TyTJuvNONmDug2KrMcMcc4vIN2xFcIFVYdeUCRoPgTQPKD8SBm8R38e
 tunP9ba9CIqQta7OZPhBZQrNOHfVcw8q_0eeDImet8oYaANc70HBCoiqwx5S2O4oGMDk6SgwhV5K
 ytQL3dte8iOyUpAvNGR.aY6dnaLj2U8_YZn783a.p6HBw5dDvuNV9SUFYFSvXYnklXr9unPru7az
 CfwsTPfGvr.pSS9JD1_8OfjoRxWQfnTz4wZST.aurNKXpCKvdYen1qIO1QqvVESy_nIxBM3rnGkP
 0hERZz3tyLMMErSRnWuXdoALFBFDj2lCRqR1VK2CRjzgKFybOaxLRVO7SI_O3YRmvrKy0z4mP_Hf
 5OBL8VDFx0KBDz4VIrr70aihLPkOX9R3rD6qTCo55dRkkMQip0igHhpUhQsoBNaYrY_1.aZbJJYp
 nNdqB6bjx6OrwMulgOhI_ApZemQ4Rr12jZqdx2qgbwuHvt7JoECB_olQowI_oFb55cUpGuteCAT0
 pIKCiYFsTWbbVQI547Etj1X_6XVVWvr9eKiH08E1EQ7oJgyITSn5QpZJYe6Fub4GO2vzRVYLS1Df
 mI7ealkUyIVKv4u.uet5jjrv_sEkGSA6XGgRbsHmwkkKecekk1CiwhqMC2Kzg_9Z7ZYb1IHAfgLR
 AaWETiiCitrXiQOJop6S5ksCa2FCXYReM6J0MYXQjFNhI60fOce9SbXdMw_Q2B0vzt8T1IaWybjD
 VH89Soazd1dMInnvaoGJy.ymVqQ--
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: f0829979-72d7-4e1e-87cb-c575ef19ad4f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Tue, 21 Oct 2025 19:27:15 +0000
Received: by hermes--production-bf1-554b85575-mnhc8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 478ef6da9b5dcce52916c771fda6e14c;
          Tue, 21 Oct 2025 19:07:00 +0000 (UTC)
Message-ID: <ba9f09a9-89d4-4198-b338-6fc7eb926d13@yahoo.com>
Date: Tue, 21 Oct 2025 20:06:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: unix: clarify BSD behavior comment in
 unix_release_sock()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, skhan@linuxfoundation.org, david.hunter.linux@gmail.com
References: <20251017-fix-fix-me-v1-1-8c509d7122ed@yahoo.com>
 <20251018235325.897059-1-kuniyu@google.com>
Content-Language: en-US
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
In-Reply-To: <20251018235325.897059-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24562 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/19/25 00:52, Kuniyuki Iwashima wrote:
> From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
> Date: Fri, 17 Oct 2025 14:30:45 +0100
>> The long-standing comment in unix_release_sock() mentioned a "FIXME" about
>> BSD sending ECONNRESET to connected sockets upon closure, while Linux waits
>> for the last reference. This behavior has existed since early UNIX socket
>> implementations and is intentional.
>>
>> Update the comment to clarify that this is a deliberate design difference,
>> not a pending fix, and remove the outdated FIXME marker.
>>
>> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
>> ---
>>   net/unix/af_unix.c | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>> index 768098dec231..c21230a69f42 100644
>> --- a/net/unix/af_unix.c
>> +++ b/net/unix/af_unix.c
>> @@ -734,14 +734,13 @@ static void unix_release_sock(struct sock *sk, int embrion)
>>   	/* ---- Socket is dead now and most probably destroyed ---- */
>>   
>>   	/*
>> -	 * Fixme: BSD difference: In BSD all sockets connected to us get
>> -	 *	  ECONNRESET and we die on the spot. In Linux we behave
>> -	 *	  like files and pipes do and wait for the last
>> -	 *	  dereference.
>> +	 * Note: BSD sends ECONNREST to all sockets connected to a closing peer
>> +	 * and terminates immediately.
> I ran a script below on Mac (I hope the behvaviour does
> not differ from FreeBSD), and I only see ECONNRESET on
> SOCK_DGRAM test case.
>
> Even after close()ing a SOCK_STREAM socket, its peer can
> read 0, not ECONNRESET.
>
> So, the comment looks outdated.
>
> ---8<---
> $ python3 a.py
> test 1
> b'hello'
> b''
> test 2
> b''
> b''
> test 3
> [Errno 54] Connection reset by peer
> ---8<---
>
>
>> Linux, however, intentionally behaves more
>> +	 * like pipes - waiting for the final dereference before destruction.
> Note that Linux also sets ECONNRESET if the close()d socket
> has unread data or is not yet accept()ed.  You can find this
> a few lines above of the diff.
>
> ---8<---
> $ python3 a.py
> test 1
> b'hello'
> b''
> test 2
> [Errno 104] Connection reset by peer
> test 3
> [Errno 11] Resource temporarily unavailable
> ---8<---
>
>
>>   	 *
>> -	 * Can't we simply set sock->err?
>> -	 *
>> -	 *	  What the above comment does talk about? --ANK(980817)
>> +	 * This behaviour is by design and aligns with Linux's file semantics.
>> +	 * Historical note: this difference from BSD has been present since the
>> +	 * early UNIX socket implementation and is not considered a bug.
>>   	 */
> So, I'd remove the entire comment, and if needed, add a
> selftest and update man page.
>
> Thanks!
>
>
> ---8<---
> import os
> from socket import *
>
>
> def test1():
>      print("test 1")
>      server = socket(AF_UNIX, SOCK_STREAM)
>      server.bind(b'test')
>      server.listen()
>
>      client = socket(AF_UNIX, SOCK_STREAM)
>      client.connect(server.getsockname())
>
>      child, _ = server.accept()
>
>      child.send(b'hello')
>      child.close()
>
>      try:
>          client.setblocking(False)
>          print(client.recv(20))
>          print(client.recv(20))
>      except Exception as e:
>          print(e)
>
>      client.close()
>      server.close()
>      os.remove('test')
>
>
> def test2():
>      print("test 2")
>      server = socket(AF_UNIX, SOCK_STREAM)
>      server.bind(b'test')
>      server.listen()
>
>      client = socket(AF_UNIX, SOCK_STREAM)
>      client.connect(server.getsockname())
>
>      child, _ = server.accept()
>
>      client.send(b'hello')
>      child.close()
>
>      try:
>          client.setblocking(False)
>          print(client.recv(20))
>          print(client.recv(20))
>      except Exception as e:
>          print(e)
>
>      client.close()
>      server.close()
>      os.remove('test')
>
>
> def test3():
>      print("test 3")
>      server = socket(AF_UNIX, SOCK_DGRAM)
>      server.bind(b'test')
>
>      client = socket(AF_UNIX, SOCK_DGRAM)
>      client.connect(server.getsockname())
>
>      client.send(b'hello')
>      server.close()
>
>      try:
>          client.setblocking(False)
>          print(client.recv(20))
>          print(client.recv(20))
>      except Exception as e:
>          print(e)
>
>      client.close()
>      os.remove('test')
>
>
> test1()
> test2()
> test3()
> ---8<---

Thanks Kuniyuki for the detailed explanation and example script.
I'll go ahead and send a v2 that removes the entire comment as you 
suggested.
After that, I’ll work on a follow-up patch to add a selftest for this 
behavior.

Thanks again!
Sunday


