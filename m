Return-Path: <linux-kernel+bounces-739234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3D1B0C3AE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C98E188CCF7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC312BE7BB;
	Mon, 21 Jul 2025 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brwquzbQ"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FF185C5E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098724; cv=none; b=sh4tmg85VM8i1m7MlLkFKKa5sfTvzkk1VyODUVXuq1biAeLIXWB3z8vLbSL4nAmDDHcGDHmSEP/5i6ldto9CwVAnF+rDxscs3P8yWOtbKHdJGKVuYq4WscZZ1m6dIDhRyo6S22WGPdSeRbOBRqA4LMwK9Fp/k2iV7ed0uLw2CYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098724; c=relaxed/simple;
	bh=l7F7xw4WgGtLgItJ1SqdwtQ/XTF29jE8c0Ug1BN7hMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1YZg6VgeFFGUXqt/msPa9zL8m/5eBpGCi4ajhsj8VVB+d8qfq30eUMUQ1vvj62lZKeKIlArgFbwVhzAW5qMZvX+jcQFt8rQIfzBAz/ZyxzvYcchyZas9SlppYN2j6OlNqpwsqwxQLeaZjVUEk4AU2WEfqSycWz85JnifhCwIC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brwquzbQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748feca4a61so2273253b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753098723; x=1753703523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTqRImf20eq2Y0+BellCjyg4wSRmoBAzUEvr22U7bK4=;
        b=brwquzbQ5NvOjiSx9/uk0XnrYOJwJ1wOQWathQMpnffP22scKyueJ5Q2w8zinz3PAE
         QdF94zM1oq4ojwySPrFT/FQabwVPPPUR10/9GrlEl+ecfAQB+A2c8NMQaOK2vNZThTvE
         MVum9XP/ooS/otNCdh4P9Bf2/I+9VU1PjBBbINkmpbNKz/4mDa62uKUZ39bC9t1bJUD6
         eP4qLJT1lqockpbGMxCskxyfkdxF2JGufku6xleHBOrWVhwlTZ9G7mv+AJzCJFd5AVUp
         O6k+lRRlsEKXGEWtUOWUwYjHUxO0r9Gp7BDCzkUtDhfVxzrjJhqr4dp12/c5U4uVm86r
         aOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753098723; x=1753703523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTqRImf20eq2Y0+BellCjyg4wSRmoBAzUEvr22U7bK4=;
        b=bxSMZ+IYtVEG0w7UqjuWVaTXVRyRBa8ItLZqG6mYrk5s0sgPY0CfhdDrlwLPI9ejCW
         rgS/oh289fT2OPQONZjZo7v3MLFSzI4coHimyUZ+tI5Opvo1XLM+nuIaIBElBSTQXEk5
         HIcE0BW/IBDupswXrASyxR60wQPSwJSOte0hQE/mBV1/Xxu0rHTnkveknQWyPgtolMKE
         Q9hmey7x3Ygw9SJtCUgN/yeEQm6fHZds5OjQkxrVJK0We37hH9pZSBgE/wJdkOSRW3Fu
         DtoV1lkkebBukkSWP9/p2gLz+UkWeB/FRloWNByRjcQwUiLZkPRWoBESlHdTgV0W0gGm
         0fsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc4Ni849ohfqBVd/JO8G6czqnAZZVFuGdXZRwQr/YZ+iDT6XQVTqPvYsLEDYiQvB16MjgXEMCQvByg58s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpm8nZ0sngn2+o6BwCBxM3a8+SvQdZ6kqw1ydmLm9DpeA3JIaq
	Z/M8c6dzn3MoJ8CrqOyI7Aleom9YYOeYeLzqrcpzm8RqEwsOiO5V41PR
X-Gm-Gg: ASbGncsYrfMnx5wK7U7grOjQyTYMckeZlmBi53HLx5HTmwFxa1Q82fPbwFqPr6I6tgv
	N9pkGvkmJ0lplDJUpNlcRS3/sAziQFbHKfvvxAxHeO6wOPDqBVgHEh+KWOjZ1axoknbP9q6lwm9
	G5bnF8A73dLCy+3VB9f2dTJvGwILrMRRKZLFRAGEPkZ+PBrxOs9AskC27Y6j4lkK0jitONvK147
	j39eYJhPnemDlTuPoRkR0YAVygyy1XtxZEakubZ+hSXdhPGhfYKo/UuDRDV7fREOTmNeO3nVF68
	bXafxnz2YLt2cLj7kJwEpqGzZO5T+DCsNokPlYIqSJaSI0xKH0BrqcnEgxoIqoIGDRiHn4WnW9a
	U35PzqQxMciUyOntp+BiCI96oSpv3+xzZhT42j8FehEXoOUlB
X-Google-Smtp-Source: AGHT+IFf3GKJxgu1xGIi32lH3bEVRBQac1EzPtiIwRT+P8U0Db9LLVd6udzMTiiG3M3HwCjsbbP6xw==
X-Received: by 2002:a05:6a21:7a46:b0:235:4a12:6adb with SMTP id adf61e73a8af0-2381426c08dmr31515037637.33.1753098722512;
        Mon, 21 Jul 2025 04:52:02 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe8c06esm5105966a12.19.2025.07.21.04.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 04:52:02 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: richard.weiyang@gmail.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	broonie@kernel.org,
	david@redhat.com,
	gkwang@linx-info.com,
	jannh@google.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	ludovico.zy.wu@gmail.com,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	sj@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me,
	ziy@nvidia.com
Subject: Re: [PATCH 1/2] selftests/mm: reuse FORCE_READ to replace "asm volatile("" : "+r" (XXX));"
Date: Mon, 21 Jul 2025 19:51:49 +0800
Message-ID: <20250721115149.42755-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250718000835.65qaxtwfgwborgls@master>
References: <20250718000835.65qaxtwfgwborgls@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Thu, Jul 17, 2025 at 09:18:56PM +0800, wang lian wrote:
> >Several mm selftests use the `asm volatile("" : "+r" (variable));`
> >construct to force a read of a variable, preventing the compiler from
> >optimizing away the memory access. This idiom is cryptic and duplicated
> >across multiple test files.
> >
> >Following a suggestion from David[1], this patch refactors this
> >common pattern into a FORCE_READ() macro
> >
> >[1] https://lore.kernel.org/lkml/4a3e0759-caa1-4cfa-bc3f-402593f1eee3@redhat.com/
> >
> >Signed-off-by: wang lian <lianux.mm@gmail.com>
> >Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

Thanks!

> -- 
> Wei Yang
> Help you, Help me


Best regards,
Wang Lian

