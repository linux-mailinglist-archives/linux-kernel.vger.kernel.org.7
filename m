Return-Path: <linux-kernel+bounces-824453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB704B89455
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2EB31C88430
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B6A30DD14;
	Fri, 19 Sep 2025 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cH28JY7Y"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165DA30CB4A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758281301; cv=none; b=scBJULUl6w+E+slxmjVy/tt87Id6nyHcaGSM2Pg5MVtvC9Onz9ok6gx01VJKCbG2S2XCAX9OLJPL/7lgpH/yyC9IEZl0kr2WE4uTOmstHTW3Xy210T+BKWJoyx+UI+VlGf+gmBgwlx+FMzJQ21ylHY7Jr9OcblR1mosgubVqYGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758281301; c=relaxed/simple;
	bh=1DjitIdbNIx+396uLnHjHFUU8A0D1BjI4tRa/AeOXro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kPrNQKIW/SsE0It2WwkZ0K86PqkCNKcJxFb2a7AiurM+Kj9R1pTZDSVTX9yb3n3QbADhdIrxVhW65WwrCqMkUUmrnIyYIa9v6TgHwxcxn+8mkETIV2aknWc/37K2QyWEEdPrGLwuP8upnKIocuTGf1y9ba4ONAETKNCdlwlXB2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cH28JY7Y; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-72c3b247827so16938457b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 04:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758281299; x=1758886099; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1DjitIdbNIx+396uLnHjHFUU8A0D1BjI4tRa/AeOXro=;
        b=cH28JY7Y1HKiYUVzcZaRuPvKMaKJfqn3fYwNzQg0bDX34f4d+N1e2FzB/ndOjx5b3m
         Q7DjM9oJMy57tcVfQyUGkb2nkXFW6xAWVxS/v/2ZebOy9PVPOHRmoRiG0IxMuOTuG2QJ
         h1tI0jJXBEJquwFN0g5dqwcBQ4QTqKSeaiO4uL++3Yl0hwdyS06ky33eLsLe0sSaUUcp
         +FulWOjw7jPOE+IgU+z0Bxa1L/01XGR3lk92e7qYvMEswj98Z6BjoiGGlsaC3KVbrtzf
         4EgPsouIaMPEdO7QR3qfDYSYcwzrIA29UsyHWpXdkKlqHrp460AwKkHFYODuRM4LQem6
         IMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758281299; x=1758886099;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1DjitIdbNIx+396uLnHjHFUU8A0D1BjI4tRa/AeOXro=;
        b=QprGMotJpFHF4ujQ1t/RV2zuQ2BZ7C+iVul0UB1561fKRRgolU9FOLyMWrYCK6uW+r
         j+KKBhpxtjvgBltPQVPDZCXvwLNXj2mXgpOtaXzjxGr+/reglOyDOUDDQkRetV8RNPnE
         bHjaRS2BpE6/myUWvGZqqi0J/D26m/EsnHEx06KFQg3vyMqS+t+r5e3OeN5MPhWiXf70
         JgVl6aC4dX//6CoDrJCbB5nWcrWVP/QTwtCXycO+bVejdIwiG7cHSuT5R2u3F38NFjt3
         EAnG12sfo9rnqpvhKkgdzt8ZjabFmMrhnrj1qFcyc2fQoYZI69DNkvK2gV26U5L2s8qk
         ydtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3fVk3ZzpncmfePf7sUpPDj6+85TCHvENkMWuULM1/cSvV2kmyGyWn9ZrUAtHlLkOfzaQH0pdNkoQNGvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVW8yA0xQY0sedujwWOQH9k74NQMcDaGmyg0s/NZ8mUxlkYqx
	km3Fb6mG8Ma5f74K3BTOs2wGAzR8ZPy+hMQmb4KNcJEFFZKqBfSFqMCMLPchma3U6JI=
X-Gm-Gg: ASbGncvan7bxmniNF3D2jKGoXVVYcb20VmaVOFOLINtCyg7I9pqNxnONPrxAHEwlh3H
	+5Y57akKpZP+Ni0mtz1UpuKQ8m6mBSkTht1X/INNmnXo1j2w3pVSBGxJGKEgo1hQNelMUL6xP+H
	e6CkQo32Z0sb7OcnQ7bXWL4zn/k3hxiyJfdskdhkRCw3ra5lJyJbmDSKAL9usG464nv6n3757Yb
	9gf8PN1oOL4g28CAqrQ/nP3mDCTNgAxHHKNnkZl4uEm4YKP40F14pNFI/eZR3RyxqWaBYF2qH3Z
	yEpyVnBADN9RFLBH1wkBLBi8JLq3AOUwvt06b2jeY4rJOrhVUElsaTBUUkD+zxGl9iqGSsmVQW2
	IrNnf3xCM/qrFnnlF8ISpMiPG3g==
X-Google-Smtp-Source: AGHT+IGzit9Xl09pvF/y8vcEFtgKSFANQAuy7aNdn4IaGhXGUoBDbxyhkZegsmgt/FbqMid9KfiZtQ==
X-Received: by 2002:a05:690c:9c0d:b0:723:be82:c78a with SMTP id 00721157ae682-73d39d75d6emr24479897b3.31.1758281298949;
        Fri, 19 Sep 2025 04:28:18 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:2432::39b:31])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-739718ba1d7sm13612217b3.65.2025.09.19.04.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 04:28:18 -0700 (PDT)
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
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org,  Jiayuan
 Chen <mrpre@163.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: sockmap_redir: Support
 no-redirect SK_DROP/SK_PASS
In-Reply-To: <20250905-redir-test-pass-drop-v1-5-9d9e43ff40df@rbox.co> (Michal
	Luczaj's message of "Fri, 05 Sep 2025 13:11:45 +0200")
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
	<20250905-redir-test-pass-drop-v1-5-9d9e43ff40df@rbox.co>
Date: Fri, 19 Sep 2025 13:28:16 +0200
Message-ID: <877bxuu1f3.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 05, 2025 at 01:11 PM +02, Michal Luczaj wrote:
> Add tests that make the BPF programs skip the actual redirect and
> immediately return SK_DROP/SK_PASS.
>
> Suggested-by: Jiayuan Chen <mrpre@163.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

