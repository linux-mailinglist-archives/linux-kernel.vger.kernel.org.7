Return-Path: <linux-kernel+bounces-809864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE48B512F6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D053A1C82FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF5D3148B7;
	Wed, 10 Sep 2025 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FjKKfRzp"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708AA314A77
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497406; cv=none; b=gnzgRvxmyPihqLlI7obGJ/YOmpsFbgu7x5Pg1jr10r1uWVcNLvQc5R/5imcFxiopXh0OK6wfpztHBZdReIe1w7ql6y9jkpJ0U4lRWh7T5P4+mGmWUEtWbhCnuGGIsx2+v+dDDg9Sy9JKWLWCQLNLRXtT0WrFZNia4ScQ6LpG9b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497406; c=relaxed/simple;
	bh=GeZ8gRXpmuh4zIH2qzoEpO1TgLkvX/hmsfatSykJQdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dk1G2iezhsuEvX95kFtUaZBZ6pnLtRJy49obHCojW22fL59Nwlq6Dhr4gfdRZ57fshNxZvOuqvfIkPantnKyRophWrrQr3z+wLGfZdQ+GdwP8EP4PuWXLMxp6NAQWDvVkVqEaEl+tcLIWIzYb+nmZf2BXmk33NO0VdrsEBlNkG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FjKKfRzp; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-621b8b0893bso8448887a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1757497403; x=1758102203; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UH6/XT0kvfyB5mO2cKrXbyp31DnusO7Ul6sUo8daz10=;
        b=FjKKfRzp/hxCDsMl1xDnwLyR79PZ7k+UjNNip2MAJMvzJevAf8hf1i9LM2JlVoiP89
         gIOxALJWod57EihdfypzXXN60vlCckxlrl40uKKNpD8oWrBcWoGOQK2JoRcB1cfTdqLk
         CByM1UAJwhqzmvY8DMBwNDilIpKN22S2KShATesu3ITjrvRokazM7vRejCy423xXLksO
         HHhgQCLMhpU0mszfYHGNXp7/x8lfsQzTqGt1mD0GpYoiPurGu8OrkqhDRQ27gZxE35tS
         Xjzh0dT9DrWCx7+Od9DxF+JfIAM71+dcswESBHwjNixCD9StNMTGtEWZn7mqH/8xkzAW
         XPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497403; x=1758102203;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UH6/XT0kvfyB5mO2cKrXbyp31DnusO7Ul6sUo8daz10=;
        b=gcuh16OOCx6gVt19+n3Ctbe1AZcdKN4VhfB9etbBGAo0B2Pg3QkcZtoF7AbpWYqJGJ
         JfCzgXYSA/vqP6MIPf601iyVszMrBnIec8tnyZbyFCDrVBubVw6fayuBQyegzq6ibOYL
         Li/IG0Pol4xZTYGPzwAht2aAIXPC47Z1YO28VzxLQXTgz3N4i49+k35BxYIUEtdZVwIZ
         5Aa/gyqLoyQTPazi1xhrUAxdBr1uWkozYuQs8gWBKhUQQaoYEMeWJftQJI1Rrgpgv0D8
         noCKd1Z7YYTzJclUVQ/8wR3NP3pVrRCWCQnUc8ibYdFKvxnYfmXVsxiYdYdo2g8I2OxK
         YGIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+/5HYGcdtV88LxltIz9hgDEpeeUVCfu3XtKRktLJClK1jIi+frRZKz2ehxCkfjpnZibl5CelaZ5fPYmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeKe74RTkoQnslKx1oa0wK+RLS3sjmqPssOOwU9nOcZ9RnYhtf
	NPGep+HEKYeG9ocHzOXwuyKNjp6wk6vG5++M9IUYO6d3BoGJxjsnKJfLhGHvOxn/tBY=
X-Gm-Gg: ASbGncuC2+mprwA7hf/yZ2HMtUL1lDKqnpXcl8pP55lV6wMqB1AD3tRDlTNWXsPPik8
	NQTo4hGKXVfDf/hNL0sjjRdayi66PBNjFyB7C6PshwaV/bbadWqPqpJGRS3CQM3suNMaTKqQmHh
	dBDt9J+TdqXZQWhO16eAw0H0YCaaqOawqxOI/JE6XTfbdbSQRp5zhUwGp8euNCBpq5l4K1ss+Ql
	sa29QCYx3SKt4kJat8Whlo3hLi7mKkoUoIXAtTzVx1r6fHUmgkgyRnhkDGImJapsdf6SIbIi1js
	AHjhL/7dUs+Fz2/OhWyo8CeZbeMPhK31Pit2b2KlXnwIIa/BBiLN2REWQF02KokiHZgtHQA4A2I
	7saoNtXXG/Blp+O3nO7XVqFWqtA==
X-Google-Smtp-Source: AGHT+IHezEvVl+d9vvOZ0x6lYJthodH+9bMTe2BUEcXlfkeFgiHS5P2xoZIspY68/UNlg2yLMMtPQA==
X-Received: by 2002:a05:6402:270d:b0:62c:3878:747 with SMTP id 4fb4d7f45d1cf-62c38784cc4mr4323427a12.33.1757497402738;
        Wed, 10 Sep 2025 02:43:22 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c018f660esm2874458a12.38.2025.09.10.02.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:43:21 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,
  John Fastabend <john.fastabend@gmail.com>,  KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/5] selftests/bpf: sockmap_redir: Simplify
 try_recv()
In-Reply-To: <35912d55-eb6e-403a-9a7a-05cae551ccf3@rbox.co> (Michal Luczaj's
	message of "Tue, 9 Sep 2025 23:25:16 +0200")
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
	<20250905-redir-test-pass-drop-v1-1-9d9e43ff40df@rbox.co>
	<87ikhs54z2.fsf@cloudflare.com> <87bjnk53uo.fsf@cloudflare.com>
	<35912d55-eb6e-403a-9a7a-05cae551ccf3@rbox.co>
Date: Wed, 10 Sep 2025 11:43:20 +0200
Message-ID: <877by663t3.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 09, 2025 at 11:25 PM +02, Michal Luczaj wrote:
> On 9/9/25 12:15, Jakub Sitnicki wrote:
>> On Tue, Sep 09, 2025 at 11:51 AM +02, Jakub Sitnicki wrote:
>>> On Fri, Sep 05, 2025 at 01:11 PM +02, Michal Luczaj wrote:
>>>> try_recv() was meant to support both @expect_success cases, but all the
>>>> callers use @expect_success=false anyway. Drop the unused logic and fold in
>>>> MSG_DONTWAIT. Adapt callers.
>>>>
>>>> Subtle change here: recv() return value of 0 will also be considered (an
>>>> unexpected) success.
>>>>
>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>> ---
>>>>  .../selftests/bpf/prog_tests/sockmap_redir.c       | 25 +++++++++-------------
>>>>  1 file changed, 10 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
>>>> index 9c461d93113db20de65ac353f92dfdbe32ffbd3b..c1bf1076e8152b7d83c3e07e2dce746b5a39cf7e 100644
>>>> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
>>>> @@ -144,17 +144,14 @@ static void get_redir_params(struct redir_spec *redir,
>>>>  		*redirect_flags = 0;
>>>>  }
>>>>  
>>>> -static void try_recv(const char *prefix, int fd, int flags, bool expect_success)
>>>> +static void fail_recv(const char *prefix, int fd, int more_flags)
>>>>  {
>>>>  	ssize_t n;
>>>>  	char buf;
>>>>  
>>>> -	errno = 0;
>>>> -	n = recv(fd, &buf, 1, flags);
>>>> -	if (n < 0 && expect_success)
>>>> -		FAIL_ERRNO("%s: unexpected failure: retval=%zd", prefix, n);
>>>> -	if (!n && !expect_success)
>>>> -		FAIL("%s: expected failure: retval=%zd", prefix, n);
>>>> +	n = recv(fd, &buf, 1, MSG_DONTWAIT | more_flags);
>>>> +	if (n >= 0)
>>>> +		FAIL("%s: unexpected success: retval=%zd", prefix, n);
>>>>  }
>>>
>>> This bit, which you highlighted in the description, I don't get.
>>>
>>> If we're expecting to receive exactly one byte, why treat a short read
>>> as a succcess? Why not make it a strict "n != 1" check?
>>>
>>> [...]
>> 
>> Nevermind. It makes sense now. We do want to report a failure for 0-len
>> msg recv as well. You're effectively checking if the rcv queue is empty.
>> 
>> I'd add MSG_PEEK, to signal that we're _just checking_ if the socket is
>> readable, and turn the check into the below to succeed only when
>> queue is empty:
>> 
>>         (n != -1 || (errno != EAGAIN && errno != EWOULDBLOCK))
>
> Well, looks like adding MSG_PEEK exposed a bug in the test. I'll fix that.

The gift that keeps on giving xD

Other alternatives that should also work, but who knows:

- select/poll/epoll readability check
- ioctl(SIOCINQ) but no way to tell if 0-len msg is pending

