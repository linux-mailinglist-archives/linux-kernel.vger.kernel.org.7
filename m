Return-Path: <linux-kernel+bounces-824324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFE5B88AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984DA16F1DE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5382D239F;
	Fri, 19 Sep 2025 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CyH62hPA"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA758252287
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275658; cv=none; b=EHQfUFZ/ON7r6eGKP1yqp3uq3qpHNmSsoYtIMGfUDc0hlMVCAtssxeiDoxuOwzBu3YFoCTrkDnh+psLyTmeeiy0qtEtkQOwM8E0DiyUlfgRnex42N9ozhJl3eqGT30UWzLEAIWZmyIEdkln4zpK2mlHzGDT0X/t3i8889uBD974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275658; c=relaxed/simple;
	bh=r8WWHzbKJIxTeouSgwB4Mr2pbj4QCBcVdISTTpSBgvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J652rJztbcT9wu5Tduu+WeHXuYK5GosX2bUbMmZIRkieCpglVN0ZmHW1mt1PILH+yEJVJliVuobRx8oZCJCyl62btqYuRASk+tzYo/nraG9nTUOHglxEW0Hmm6sk000Vrt1cxMwBdlbcnTeAmRGAtQj7912HJbDetwoCEnkIsME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CyH62hPA; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-ea5c3e8b88bso1335992276.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758275656; x=1758880456; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=POTRFWGD9N2Eju5JQSXhfOmcmRxIBLOL3ZetmyJPEbE=;
        b=CyH62hPA09osl6nefCXQ/8hXKAuLtUUzcsuNPYN6XoeW44BvChr6/rt+W2v69BbpN9
         vFC/oszlNTfD2ifi2dyPrZJwaVKMO46KSjxvzUutEqSG9Lj3PBr6g45qg3iZ20VeRIdC
         AntFg5KFQI3tFzjbRG3gJpo5THOKedIxGnssGOOdTfTp8PR5+uJAup0tOyHdzY3Ta7cF
         KLf2BPb10OR33/N2Y0FcTLL4dzVznVhZ4DHXATTJkQsMVi72bKn9C3hJKM1xZlRer/Gs
         yy9uNMfLylRc5Re53aQo2fVTpTgDIM0GdenRzs2WJ0mAf8IvchDKePGt/kkP36USo02D
         WijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275656; x=1758880456;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POTRFWGD9N2Eju5JQSXhfOmcmRxIBLOL3ZetmyJPEbE=;
        b=uSYZYGC1ZSi2Nai9F3MyIYHDpAjFkvhCLthrp3Q72a4xYJ6Hw0KZuxSeEHXwxhEHmm
         m+xouSICD3FELK5eQ/0gmFpKw2fAwfhDIAB1Ksee1tIlvzOiKog43+j2a1a+u95ccvvo
         Hq96yfoxDqDHMyW0D5iN27OETq4uKLtFSpu2WTJUVSPhMzCTVDZZqNmjwxameG8j9vEh
         fz8Y1hu7sFZRZNloFS+Wvjz34FmZ4YNo0BpN5+2BY9nHY18vRmMwQWMmz4tLBpHInuvT
         G+0YAIJQ+y3UI8WjtRIzCqffXGxDDbaTbuvzO6Rgd2l37CyrbT77fw0VoKZeCXry0duC
         4KnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdob8K5ZZO7Wz8SAaIUQ5en/q3zUWJqGphttrK43rx4WJA6ZHrOMmCQWqjGDBp1AYyxJl0Dtm648gvlnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIbrhfPGvBCJZuCTMee5FVhDY/xGyRuY6plCQHlowalceoQG36
	fcr62c12YKwO7tSQPTze6iJePbnEpoqwFMD3NtES2xbw4mBnqehoH41lCUTfvVWEUQU=
X-Gm-Gg: ASbGnctCbT9267VfIEF0fzk+Akb345UVNhisr1SSfZrlHufhUXpBHvv/hv9lnOZies4
	Uvu7yYJCmJVfD9hG5FWdUfAbKzWrXxmsiZe/rYs1QQnbQNh5f/cahUO7KZcimlJJzbPpq+t01XG
	DOepygyU/aifnj9H4SYrVeLUe87HWN02J3uxgipdEol+l4kAroncwxWyJA+KUH3nd4yGcZzCiYW
	5HUxaUbHUeTDwor5LPoD15gDpQR6XnhhJDsWMEDwgPZTqXWZ2vpKa7UaMj6Gu4JFq5qKSDZCnbh
	B+sqjdJ2MzqLj4Y+mvVjOjq6OWwQF32JBO7hsJzwyw4AeKMBN4757x/cxml0BVeIT/rkGXVi3bK
	Uff1yaXUbLZ+6cA==
X-Google-Smtp-Source: AGHT+IFh6gBvRGK6CP91Xd7WmHsxfSp7jA0HwoLiouLAGHBFeou/eRHvssueILk3xyR+Puuh0g2paA==
X-Received: by 2002:a05:6902:150f:b0:ea4:139d:33f6 with SMTP id 3f1490d57ef6-ea8a0c2f5e3mr2212165276.29.1758275655893;
        Fri, 19 Sep 2025 02:54:15 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:2432::39b:31])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce8544b5sm1580858276.17.2025.09.19.02.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:54:14 -0700 (PDT)
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
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: sockmap_redir: Rename
 functions
In-Reply-To: <20250905-redir-test-pass-drop-v1-3-9d9e43ff40df@rbox.co> (Michal
	Luczaj's message of "Fri, 05 Sep 2025 13:11:43 +0200")
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
	<20250905-redir-test-pass-drop-v1-3-9d9e43ff40df@rbox.co>
Date: Fri, 19 Sep 2025 11:54:13 +0200
Message-ID: <87frciu5ru.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 05, 2025 at 01:11 PM +02, Michal Luczaj wrote:
> Preparatory patch before adding SK_PASS/SK_DROP support:
>
> test_redir() => test_sockets()
> test_socket() => test_redir()
> test_send_redir_recv() => test_send_recv()
>
> After the change (and the following patch) the call stack will be:
>
> serial_test_sockmap_redir
>   test_map
>     test_sockets
>       test_redir
>         test_send_recv
>       (test_verdict)
>         (test_send_recv)
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

