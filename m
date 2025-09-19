Return-Path: <linux-kernel+bounces-824454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE1CB89464
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947311C88263
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0547E30DD0E;
	Fri, 19 Sep 2025 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="baPpSguH"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A062264D5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758281353; cv=none; b=a55pE5bk3Yu/AZ3C/6TYFfDo034fIqVuIzwijmYQ/LpQPLsiGuaUcxf2Z1RauX39ogb3xoJaAIpZmTmwALC86yMYub/neLp12grMPkybN5d5T1hBoimmuW8EB5U6GOIdJNYSF/rmBdIzJEesCBGx0cl9f+rTdNKo3Y92O/Ng2Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758281353; c=relaxed/simple;
	bh=hoyRD8cY6+eAWp0Ym0oqTHL+yd0Dp6KCPwO2D3eCKJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Er1ysE7YdDdCFC8QufMrlpRk05L13TcDQicCWqkv1kVQVHFZ/Xo7D2njNAC2cASh7pyaHmL5dJrB38VRWewTkElIYrGY6TgTBxmijDPTjEipWUwSsQ36znnnqk6y+hb/20ZvretHM1Yl0Wnc8DbzhUeiTssd1Ok77HtfX24Zp0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=baPpSguH; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d5fb5e34cso20583417b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 04:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758281351; x=1758886151; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G7lPhtBvPOvEeVY2Tw1J4kWk3fxAvD+cbqglxKZ4L5k=;
        b=baPpSguH8CfCw51lUwZAi/EBle9vHTKVGZghlCMQ1aSKCDkTGXSnMyt62sqhIOYLVS
         D2aspQ7wqNL2Y26urF7lCY1dj5WPs4rn5BcMWF7RO2/qTm/0iFeUz3eRBDDTA4et8BSO
         cLeLBSh5Nyiss4zTJB1iOP4xJLl39Rv4eTrSEKeYRBY/0oCiTLxwKeWxqqWoLgRM3Pes
         VUOMydwke5rpcTX/SXmG+SP8E/8FEbq1QEeZM6XS5HwiAnY0ofy99NXCADBZkI3JSQ+/
         o9vFxrAX/w6cfdbLcbBZSx0ZUj6AHIeWDL/4lOQhtxgiP/XCo0A050JmuoOgHeb8mPc4
         7TLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758281351; x=1758886151;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7lPhtBvPOvEeVY2Tw1J4kWk3fxAvD+cbqglxKZ4L5k=;
        b=bHQo2MgrrQFh09OT5CIHGNtzIBDozwf1N1zhl0BeS7rTGHvLrDHJoNwqNcpyiTE7mJ
         Qh5HneuXl8mXQI1IF6L89UiWjHJ0yKDyrBA4AJq5BeXx+HwKt4j6mRqURk5rzhP+fjBQ
         RQhG1RYSa490bIvMMyjvmVjYn0ywd1/wr3UNIXbSAv4uBfDm99rZkfNta3hs7gM0wzIw
         2O7O2dSEa+W1GApO8jX2zhBDybTYIM3xTPUL7mQjm7aoYiV0c5CuXvpzjuZgTZoSl8DP
         dA8SJMYq4Bf6DwiwzTWEaOaxZvARi428VAROUVoSnUIiFejB6EktP5bCqzEnUrvs9JRn
         mZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCCSrgr3YpJq3a+gx07AD72/j57F6WA63SkZm7dOW9JU8bMoLxhkMHixw4e0ZE3mF4GnUpHTYja44fxJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy333YcQZ11KQBmqfc5BkPSjpZ2MPj3WbjKV7q2EaCrSDMlTyOo
	tlBhbcGwTAhXy8Wqg2nu4tujCwssbsEFqVbyW76hvR7hqB0vgVDNhqI7fPipDQiWsSI=
X-Gm-Gg: ASbGncsYXZQyMn6D6bdiGb+4OT3F5WKTpejH9QN4K85pyCF4bYMbCkEZamQ6DWuRw5J
	/31Gm0UEyzE11wdaGt+DguM/hg8AaMf2TdU8+HfP9g74kIU/sRyDrdAg8rQHa/FaPyoUxD/zW6c
	EF7cg1SOkR4WPt0qvcKa59DUUq/Ud7FEvqlQno6LMOyzcfJay58cnnnLG6vAnrxn+fidTZNzcbA
	UMCTlouYTnURLxJdQQwH2Fk9aHS70uYJj/X0h0uYAIKL5IcsvirpmS3Fbam48yaaw6J0OB0GDlc
	fUsKgn4GYXWa0yoIHEZe7+h1HrO+gzxHFlHtjuhoDgR3/fMYhqMBZPBII+kNm6ZNSVZSuwWy6dI
	mVI6hL/r70IkHiA==
X-Google-Smtp-Source: AGHT+IG343kCVS+/qgurkYvvVqrq3Jkl6cJnzpfAyvWHus5fb7J8doUVLBe/IYPk5awTCYhicojNVg==
X-Received: by 2002:a05:690c:9506:b0:733:aa00:3860 with SMTP id 00721157ae682-739708ca5b2mr47901377b3.23.1758281350992;
        Fri, 19 Sep 2025 04:29:10 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:2432::39b:31])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-739716bdc47sm13585717b3.12.2025.09.19.04.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 04:29:10 -0700 (PDT)
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
Subject: Re: [PATCH bpf-next 2/5] selftests/bpf: sockmap_redir: Fix OOB
 handling
In-Reply-To: <01f6c3f5-be73-4505-8a34-212dee30b5fc@rbox.co> (Michal Luczaj's
	message of "Fri, 5 Sep 2025 13:19:46 +0200")
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
	<20250905-redir-test-pass-drop-v1-2-9d9e43ff40df@rbox.co>
	<01f6c3f5-be73-4505-8a34-212dee30b5fc@rbox.co>
Date: Fri, 19 Sep 2025 13:29:08 +0200
Message-ID: <87348iu1dn.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 05, 2025 at 01:19 PM +02, Michal Luczaj wrote:
> On 9/5/25 13:11, Michal Luczaj wrote:
>> In some test cases, OOB packets might have been left unread. Flush them out
>> and introduce additional checks.
>> 
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>
> Sorry, this should also have:
>
> Fixes: f0709263a07e ("selftests/bpf: Add selftest for sockmap/hashmap
> redirection")

I'm not sure if we're backporting selftest changes to stable.

