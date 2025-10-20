Return-Path: <linux-kernel+bounces-860150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42685BEF6ED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF6394E3C16
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D883B2D323F;
	Mon, 20 Oct 2025 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5f/6tzS"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB75B1DF26E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760940796; cv=none; b=ki681N5oSYekwyaF3cb2CxpxOj7OgHN2xryNP+99jI7USEbIYdZBJN0hI6YwPKBkKtXfkd5jCNLyQNwkC76aU/8H7jG5zVoqDIdrlgVPa1gLTU2UDpzOo8TsTU+6EtP3cDXGkZWt7veUtJcmvm80ip+PJfQ2SA9QYtohYxCuGzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760940796; c=relaxed/simple;
	bh=F4iOUC0s4wVCK3QnRwNJNDquVt79I6hyvcqETtbjUq8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VJMuEkKfBvjqqNZfDWpAS+xltR5c+BNxKA2PuWCWaf7GXmg1aopkrOk4R7Oi5xaXMnEiH5muJlY34N4sW2NEiSPIPcTnZsjQEA+6P3AM8uVqYOv3fxpQK4pHWMYn+VrjrEqrDjsN9gzz4qCD0I+mKPXCWPskTg7CHIGNqJLt81g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5f/6tzS; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-782023ca359so3941224b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 23:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760940794; x=1761545594; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F4iOUC0s4wVCK3QnRwNJNDquVt79I6hyvcqETtbjUq8=;
        b=N5f/6tzSIbyg6E60Xzwt0pdeTGKxdc5LVljrJ3zRtOgPslrr0ccdiLS/EnCttKAssP
         WaKgqXhqhDUoKqpVW9CKDbRzkm6wSMafVHmgnL/BOaVyKBabI7dsEFJbDvqV1gCcRw13
         iOaY4rMJOa4unz2STXjmdHwl+F9R7Pp+8IR7w9/0UYGeOBG13/ncxhfJKa+9KxG0Gjzk
         EnfCur4OmqW2xgDL41CAE83m78omTBx3DFUONVu3VnN4g4w3ZU+41cJwqzAUZBUlDV6U
         xY3mAIE/olMHHRkJ3iICFHOdMcttzK1q009nWR0scMUswc7q2rA33NYg9JKM63YJsM8Q
         y+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760940794; x=1761545594;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4iOUC0s4wVCK3QnRwNJNDquVt79I6hyvcqETtbjUq8=;
        b=HZhn9Rjb9QYN4BeOBoUDpo8DYaH2TzGyI9q/uovqjSDKRZvYzJZ0yb1G3wJs1q0wJw
         2ItJJ7zXO6QNhGcJzsrbyYbkPPf9Vd9rVaHLpkeuSSbboC9E6iUUiuM1yccuLyRGeYaN
         YmYfIDUARiJ+Q2KVbvtovnnG0KjQln1Xz7Y7DmRu0wGWycTuKY8GdZd2XGIvb02qnt80
         TseZIC9lFnBx+HHuKsN1NxFPIMDA+Kbz4ll7juP+H8ow7nF4DtqTTLltGyWBpBX6Pool
         7/H8t6ISvP0OflhIJU+VDu5rYLhll/OcAvsK3GCsKgOSPpS8hJnlMl5d6OeJuZ168Wjk
         lYqw==
X-Forwarded-Encrypted: i=1; AJvYcCXe+vqxVcQu1xA0hSHa70wDhfRLSLvIrkmeoDzHGEYJroAzaGej7bpqRyX6VC9kX78ZUEVYlDK+5Kvs75Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnVHnUTH+i+DY/kDqq2+NQQQYDwVvkPqxGHv+X/O4rBFNQbJE2
	PzXfomfunzTUe4RPxeC70OeXB2burGKgpUsJv45OVz7mEjipjWnKlpoo
X-Gm-Gg: ASbGnctw5j5N+QCaNzu8w6LU6wf96iHQ+0vZ8L2iY16bdSZNdz+Fhb5pEmrtmj41LIu
	h8YXzzDIxtR1MYvulkFbtGtse3BVILC0wTpeFz8vZjDWpDYSOCFGqad3y1LNC3kbH3ve0RJYSkS
	Qv4Gf+uIUAQt4g5/E1ezRgFgYepvLoHoq+bJU0Xwt5Y00Qozi0LaycDUcsWHXCPIyXhEaXTScTI
	FH8g1jtESttliymmZdyr3KNQsg3L7k5OjCKPHwc/S22i1AR+RVenzaxmVITKpyj54kXeX0iEFUv
	gVZIq7TFjPHUECrNRKpwDfYcvLe4iTH4/RoxZgP/fjmoZZEYAjyqOz8ZzRZWgefpwrVqLJcneSt
	lYgSyv5Xk9/xnyZQacBGroJoPTba4KduxCK/8SUcM+5le7qfuImo0wQoGr6PKqPjrY2/2zyWvEm
	KWQ7VXhA==
X-Google-Smtp-Source: AGHT+IEVt0uPupSaUZz6KCq86JlbvGn8ZichEvFdkGuM5SiBJbGyCGKkO/2pPlvVbwplEmeRswBETQ==
X-Received: by 2002:a05:6a00:194b:b0:77f:50df:df36 with SMTP id d2e1a72fcca58-7a220d232femr16694859b3a.18.1760940793834;
        Sun, 19 Oct 2025 23:13:13 -0700 (PDT)
Received: from [192.168.1.12] ([223.185.41.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a230121ed6sm7216442b3a.73.2025.10.19.23.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 23:13:12 -0700 (PDT)
Message-ID: <a4fd6596e4a646d7c3a19b4a8f398b970f27e8db.camel@gmail.com>
Subject: Re: [PATCH bpf 1/1] bpf: liveness: Handle ERR_PTR from
 get_outer_instance() in propagate_to_outer_instance()
From: Shardul Bankar <shardulsb08@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Mon, 20 Oct 2025 11:43:08 +0530
In-Reply-To: <69d2c22ed0cac19a2fc13d422597d781281e4625.camel@gmail.com>
References: <20251016101343.325924-1-shardulsb08@gmail.com>
	 <20251016101343.325924-2-shardulsb08@gmail.com>
	 <69d2c22ed0cac19a2fc13d422597d781281e4625.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-16 at 10:43 -0700, Eduard Zingerman wrote:
> We can land this change to avoid confusion, but the fixes tag is
> unnecessary.
>=20
> [1]
> https://lore.kernel.org/bpf/8430f47f73d8d55a698e85341ece81955355c1fd.came=
l@gmail.com/
>=20
Thanks, Eduard, for the clarification and reference.

That makes sense =E2=80=94 since update_instance() guarantees the outer
instance=E2=80=99s existence, this case wouldn=E2=80=99t be hit in normal e=
xecution.

I agree, the Fixes: tag can be dropped. The check mainly serves to make
the intent explicit and avoid future confusion.

I=E2=80=99ve resent the patch without the Fixes: tag.
Link:
https://lore.kernel.org/all/20251020060712.4155702-1-shardulsb08@gmail.com/

Thanks again,
Shardul

