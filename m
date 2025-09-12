Return-Path: <linux-kernel+bounces-813937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0990B54D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7EE5C0B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14770324B21;
	Fri, 12 Sep 2025 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK17vNLO"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A6B304982
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678934; cv=none; b=YyAZb0xo99EyQ8V2bmp3EmEgHk4woxIlrSS6MhFN2U6QE1PZgXMcAXfPT6RR2tfSfVQKqgXs1sioouH+DeD5sQs/w3eexVXREFutUDHGIepklQ5mgC0KTL3DJi5bNwA9MQkjjyGipEhQ/Y0OabOYDI8IrspQsv7nv9HoNKf72r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678934; c=relaxed/simple;
	bh=PqPZ8RULX7eu8BAG8aFIfDKASv+ULLACp+JE+crY35g=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ZW9cBZDVZTcQ2ZbvhrohsQn75NHgZOFXFDrfytUNHpszNLHReTbJGe3HDl4iFG/ex/b2+EVom+1EUF8D6ak4KGgCk6xR1i3NEOzIq85akcgFaJKdFduI8l6kartRaE1aqtsqEwCCetzIX7NMaJHUliLsDnNLkewHaySmJOaQ7ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aK17vNLO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so21828825e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757678931; x=1758283731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PqPZ8RULX7eu8BAG8aFIfDKASv+ULLACp+JE+crY35g=;
        b=aK17vNLO3FWypqeHtCtGViEf/AACbNqqr1aobsHvHd70tNvEJLvNVO6V9ib/6dbtW9
         1659OC0X7WwHLO5I+fSBPAbTEXQQll20pooTXhDWqeg6CTeciB5Jl7IHpfO+ia0Lsn3h
         JIxDGDQK9DeAKy1KtuJRNEGWoxx8TEd8WoLuOPTPizgOkjaPv8lv4mnm01nxDxTDIpT1
         5sST5WznhYi0MC8G62+4+q9LY9lrrHN+EeY8logmrQc2OqKf0CIThPtFgyEq/jMb2nI/
         NJHekOwMkqhHYWhcrJA15oKuJqQjfE1EvJsJeWqyAJbm5h3Rhyvalzxhe3rScog7qybV
         UHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678931; x=1758283731;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PqPZ8RULX7eu8BAG8aFIfDKASv+ULLACp+JE+crY35g=;
        b=VwZYEmzXuNKdOae8UG4D4vKxG46o4oAqqPCafg3OqGRA7P3PXB+giHzdeTxi6GmRx/
         LtN/QV1Kbm8+TbRFQkxLtlP/audslwNrUtzAXYNITKwWtDKl2Z4qILSvJEwTpXawtag7
         saRGINg060vXT2mUoypatI9XrjzA6hHUUjZGcOG9PhmmO8itw3VVWwqPNFXD82N6IAlh
         nj6IdH/SlOKxFn8/CZh+oXWocyRssilmiRJPvEbFa2u3tK6dKIOl/W2hZwtksJbkd0lw
         bZzspffpNs8bPVKfTJM5G/yEJzZ3boNYkQx7vnU1ioaUfh5K2Xi8fzuDJxvlwoQXsLjR
         VG8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZmlBc2LowIGCk3AhPW4jNO7qXZRUY8Wgk808LOJSxwIVzfUJzHtJ6gagQAgwYYtym0nB0LDE7sh/KDwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhkhvMezecGbxFix6FobgQWrPYtDngtVh5qYwsUilEWZQ/fKWZ
	M0ChCrsCPV9WVfFyA2mcDDprexoHJTLXVKi2PVfBwpj5QSBw1VT1jX5Lk7d3tg==
X-Gm-Gg: ASbGnctpSa8miWFOzsDpa82p60jxU5qS38Q77tNQihY493vbR1V1mjoijo8Rvszmzdw
	utCFchMExzn0Or8U4H6vC+VAFTs8w7gHiWgl0tRwoLPl+ke8LnfpSCuZkbgjy/rvXBgAed/IioE
	KtTwbcjE+m967qS35OiB7pRSkCsKe3zCfiNAS0egXY/G8LYI9i1sHpb+6XmhKKktKsPGlEyBi57
	sh53/fIIE8qa+ouSJpFXgt00B4P81DGgsH/7s66jXSYVIaC8yprQ+DrN9L0yhR+MFFp53ITIcfp
	o3fPH8MBpC5D9umjtCuBCUV1hEjx9Gt3hfNtKir/OUFeRoCiXDvgXVJIIZg9VbOb88YQ6SdxbOK
	4Tb6K/8FQbOfs1XKiMnBnKC6d9ABGCPaumEia6RygYeax
X-Google-Smtp-Source: AGHT+IFcON1v4F5KgBV9t7GPfhbJioy7Wd6FGUuDsb9CuUxnRc9simG96y0fBd2RO2HzmYnS97o6Tw==
X-Received: by 2002:a7b:c84d:0:b0:45d:da7c:b36 with SMTP id 5b1f17b1804b1-45f211f67camr17284045e9.19.1757678930584;
        Fri, 12 Sep 2025 05:08:50 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:18f9:fa9:c12a:ac60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037d7595sm59573645e9.24.2025.09.12.05.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:08:50 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Sabrina Dubroca <sd@queasysnail.net>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 06/13] tools: ynl-gen: deduplicate
 fixed_header handling
In-Reply-To: <20250911200508.79341-7-ast@fiberby.net>
Date: Fri, 12 Sep 2025 12:24:32 +0100
Message-ID: <m25xdnvrpr.fsf@gmail.com>
References: <20250911200508.79341-1-ast@fiberby.net>
	<20250911200508.79341-7-ast@fiberby.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> Fixed headers are handled nearly identical in print_dump(),
> print_req() and put_req_nested(), generalize them and use a
> common function to generate them.
>
> This only causes cosmetic changes to tc_netem_attrs_put() in
> tc-user.c.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

