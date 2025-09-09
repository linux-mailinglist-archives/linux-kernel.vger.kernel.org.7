Return-Path: <linux-kernel+bounces-807845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4499AB4AA38
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF5434278E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B03032A3EC;
	Tue,  9 Sep 2025 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fAqEP8E6"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E0A326D6A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412934; cv=none; b=lng7W3xnzG7TqqDg+jPQIA2q7J+l7YqCzajWPRAmfinWeWJuRQCUyScc9TAjT1TFXo0W0aaDbtqN4fdOA0HbLscZY91d8ZC5BPzyJkQeo6EfMuGli5Z+fMPRHS9JXK7sRwsbiDtJfZ+aaFDUsYggezeHbvOC3UqPRemTW0kZPFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412934; c=relaxed/simple;
	bh=dPUtmKisXQ2DA9ev867oAwEPape0ZQTi48/IVDu7my4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uXQB+morfESY1pqgdUhs8b0U82OFrzpjQb+rsL9pOq3nxUaMwS1Fqzp0guy8kYSFroHiXQ2vNv3pV0qxD84EDZdZA3xKv+AGlCX3+tbKjBK5kSUaRmT02Iv5u5BPUiTD5SEAvV8bD0SY0ecbhcCqoZI3USnBX+GihR8z+RDihpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fAqEP8E6; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-625e1dfc43dso4946135a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 03:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1757412930; x=1758017730; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=351+t/CzaGS0ImzNcqgyVg7QleoOdqpZVilL7S3uUNY=;
        b=fAqEP8E6GP3iiGUbYvjdaKciu7UeCmtH0gEAQ8vVKRYtn3q8umZfEoahkZ6uNONIFD
         2pJ52rFXVWP6YD5DTLGHo69SqJWEveXg8BoABoJsISUGL/f8cu0P5jSgJTrFP34ipv1x
         qgSfCdXITWciRDgkPiORfil/W44EpuGbysLnEYIliJgpZmW20c2zn2oK1bo6ePQCSS/Y
         oglv9Meie2KOtwK2UBwcMRwiyftoy8KtbHNXceUemTgDdexYnSy2e9SilxADKfovu1jf
         SdDo0nPFVFfYQmPQCNcwfHRDNBy8+RQkcET/3somMfb3ov3/h3ruf9w/Yww/9pDeArBW
         sRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412930; x=1758017730;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=351+t/CzaGS0ImzNcqgyVg7QleoOdqpZVilL7S3uUNY=;
        b=VLiepHduO7VaXdpNv/Q5zAkB2rkJCrpQbZ5Yz0KC3/xN2layHCGHwcmjd2kc6mbhjN
         58b8/IHq5Azs24V/9w5cth8nA7dAFMzURGfpcg91mHcXSyYtTg9S0dg6ErX7bTKMsSyQ
         ok4bIlyX6Naktj+2l0h5Jbf6FOsLdwObbcrRUWqZMgUtfHG+uFSVILPihVWozVKi4zaT
         g5a6+A/2DfYlbd/9GlNb8hZfjR4NY1tO0EJSloj75gzz5C74Q7hPY4FJvw/24kAf1eM2
         nrI/5pKNGthGR4UfI0Ut1pYFd8X2K5FF/GX12DxA6vDzfARM10Yyvis2kPSJeegTAutX
         4Ngw==
X-Forwarded-Encrypted: i=1; AJvYcCVHoJlbFpjwnidbdc6XIVdKz2k3bFO4T20xE4uf/RGqwG4DF03JwVJ846RgkdjOX/vu1pTtRc1tgvRDAa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwACnBjLkxqxwKTDb6l3OX7ZN2Tr64gtxepTzgCieY1ZkyENxBd
	uS4DQSUS2a/yA8XYbXTNs9H5EpqKBiLLIn/E/jgEyCQ/bWUzwDCqtAXTt4KxTfdIqMA=
X-Gm-Gg: ASbGncsYBjjvcFS+3zoua82xx0g1vQ0bEkPOoeaMhInLRk0jpYKjzUU+jcXMtuWsc9z
	S68/TBzmDWp1CH9VJBPl+o0Yx2DO1k28/FohFQk9IHVr6cR2I5bevZGRUOsfPmTKxb6enetDdxh
	gH4ZP5I6r30f1GYqUMM+wu2EZy6r8vkI1hw7Cm70N/qRni4KUtNAveScnu1EsxHP77oiWcGgGrj
	aDgPn6wpFUmy6ktdNRemUnIzE9cafNeIj87G5MXBt4amPgBO9KT0PZavhK9Ual4rUnav8/f7ojy
	K6woC5z6Wldcp08D3CW3gMtW0puS7gj5L/fEOjWGoTc1x/lrGrS1vWDNnlj+Ims2zpJNSJpb0C3
	NQSQXpk1EC5fHH3p/DNEOLh/T
X-Google-Smtp-Source: AGHT+IGgVxFdUXRSUbo/y34+EjFdFEBPFfYpLtF5ePOQGmUMb73+H4Li5P0mW7iLurHUcakJ9wYkiw==
X-Received: by 2002:a17:907:3d04:b0:b04:616c:d759 with SMTP id a640c23a62f3a-b04b140d2b5mr988468666b.24.1757412929559;
        Tue, 09 Sep 2025 03:15:29 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:295f::41f:a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c01801e4bsm990173a12.37.2025.09.09.03.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:15:28 -0700 (PDT)
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
In-Reply-To: <87ikhs54z2.fsf@cloudflare.com> (Jakub Sitnicki's message of
	"Tue, 09 Sep 2025 11:51:13 +0200")
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
	<20250905-redir-test-pass-drop-v1-1-9d9e43ff40df@rbox.co>
	<87ikhs54z2.fsf@cloudflare.com>
Date: Tue, 09 Sep 2025 12:15:27 +0200
Message-ID: <87bjnk53uo.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 09, 2025 at 11:51 AM +02, Jakub Sitnicki wrote:
> On Fri, Sep 05, 2025 at 01:11 PM +02, Michal Luczaj wrote:
>> try_recv() was meant to support both @expect_success cases, but all the
>> callers use @expect_success=false anyway. Drop the unused logic and fold in
>> MSG_DONTWAIT. Adapt callers.
>>
>> Subtle change here: recv() return value of 0 will also be considered (an
>> unexpected) success.
>>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>>  .../selftests/bpf/prog_tests/sockmap_redir.c       | 25 +++++++++-------------
>>  1 file changed, 10 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
>> index 9c461d93113db20de65ac353f92dfdbe32ffbd3b..c1bf1076e8152b7d83c3e07e2dce746b5a39cf7e 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
>> @@ -144,17 +144,14 @@ static void get_redir_params(struct redir_spec *redir,
>>  		*redirect_flags = 0;
>>  }
>>  
>> -static void try_recv(const char *prefix, int fd, int flags, bool expect_success)
>> +static void fail_recv(const char *prefix, int fd, int more_flags)
>>  {
>>  	ssize_t n;
>>  	char buf;
>>  
>> -	errno = 0;
>> -	n = recv(fd, &buf, 1, flags);
>> -	if (n < 0 && expect_success)
>> -		FAIL_ERRNO("%s: unexpected failure: retval=%zd", prefix, n);
>> -	if (!n && !expect_success)
>> -		FAIL("%s: expected failure: retval=%zd", prefix, n);
>> +	n = recv(fd, &buf, 1, MSG_DONTWAIT | more_flags);
>> +	if (n >= 0)
>> +		FAIL("%s: unexpected success: retval=%zd", prefix, n);
>>  }
>
> This bit, which you highlighted in the description, I don't get.
>
> If we're expecting to receive exactly one byte, why treat a short read
> as a succcess? Why not make it a strict "n != 1" check?
>
> [...]

Nevermind. It makes sense now. We do want to report a failure for 0-len
msg recv as well. You're effectively checking if the rcv queue is empty.

I'd add MSG_PEEK, to signal that we're _just checking_ if the socket is
readable, and turn the check into the below to succeed only when
queue is empty:

        (n != -1 || (errno != EAGAIN && errno != EWOULDBLOCK))

It's a minor thing. Leaving it up to you. Either way:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>




