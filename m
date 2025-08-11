Return-Path: <linux-kernel+bounces-763480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C881B21529
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B5316C5EE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99252E285D;
	Mon, 11 Aug 2025 19:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIpAcQCt"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD385E555
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754939523; cv=none; b=idobJr8aUSOQLSgC2kddjBXzdEUN47kZVCvWt3pbXp13oU7AEx6lrTxHqgx7c1/ubZgeAq3k/2uw62tIFDqroZr2pz+FYJCGPIIYhQJ2DmdA0a6DOT8zwd9bPmgdp0Fhk87BLE0c/u6ul8rOuO+gw8RvFMOv5ubx8k2vllUqB4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754939523; c=relaxed/simple;
	bh=f/ahGYqn8eCi6fdy0JtcylMPhSTycf/9bs6D0x0/x+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J13Pa6BFtZrJWxK5Sp8c3f/4JbCIFH0ZJQbVecPzfn/5N8RmGIbIFUpFrB/N/FG9JgCg4fspl780ei5C5sC3F3h+isZrFeCW7Zun4UZO9odo3jbBs4dg28gj1sTKrHk+0PipXkNUsCzcCudzpv8UgDYKb88ZeqE/Rx2bVwMQ8Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIpAcQCt; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8818a0f35ebso334592739f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754939521; x=1755544321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/ahGYqn8eCi6fdy0JtcylMPhSTycf/9bs6D0x0/x+A=;
        b=JIpAcQCtw6o6ljvGc0NTlSnca3e0cIZ5ZkDDMEZHdPi0VFRbRlueiSQ4wogVR0eyAC
         E+WJExSrlgpPv/I8qahBW435Lwg4FAbEVmYbNXE6h8YLgzhVQoyzLQZLWJKSxZ3JdcLX
         IWnFLLjZGTaqEyfRXUlDOPriXPb4ALGLsI6J0p36G+uKSAyseCOngq6KxyU0Cttdpwrl
         c/3FpUazC5uCs4SBDwKEXVjm81cqV0zelj2TCnyrAAG22oERC6nL70zmgCfKqnq3fEcc
         mRADRMUXRQVMIkHlYPe7iz364yHnFdzLPb2uQ5kq0XW0FBm8Fw0QiJVJ0uKKm+EwQxHO
         VRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754939521; x=1755544321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/ahGYqn8eCi6fdy0JtcylMPhSTycf/9bs6D0x0/x+A=;
        b=NDIH0nGpjPSqol1az/WgwaQ+HsKvSoe8CT33mi5hxQS8uY5zqXa6+A2y1YlU6LIq8G
         hQ9iS5orLf7AL+WdhVyx32jLv7jkWXDqsa26FBMn54G0B3nmXEEpOW8LTBxr4baay3wx
         +uQv5nlxADO+ioUw4qQE4tCS9KOs6W10IdEE/qR75zACJS+YyYIPBZcFk5WK++zhbL/q
         lX+KYisuSxzdwNgID+93PlS/e0Lo9XlGpPJ1RzMoBFNmz/H7t7q3+o5qp+w5nN2cB0FQ
         Yxa+l2SdMThS7VbgqPf7CpY/I30Wt9BCNY7zU8R05tEQD+tYjHaOwSmqTD79JjzZqCce
         w/Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVZrNzZW1Q+cxolagXl26gRepjiJJPCrdX8IlXXyci6Hw7/Mes69+kL8hojByOGoX1WILR2thEoPqbyBdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK11udxEzQkUXcSsrtSzFHj3lIKj/JuqCRXL9523RcYpDEsUcN
	R3PY0AC2AieLPW0+ONBMJvlw1sEKOEx/83rinoQh58ZOMW3fWngnnhjYzxXVuNzshFscp31BZ9m
	BqUyFSVN6GyGQBt0VjVZuBy53lTnkAzo=
X-Gm-Gg: ASbGncsfsajrfqMzd3lLIQ8t6Be4WVnPbfMKQuLQqAnhGZz1EV1NUP+0wy+vUlKjb/u
	KJ/Io973thbzLBzt2aeCv2N5GF5zCDnwRyJykeLoGPebfzKb3uaM9/WHzwtIRMnFvgiNfdXFyl3
	zk9xKu5MKNshn1jBuQQ6FV4bfJl1nH7qFz8ZKmOWDezadEEz5bI0IuArS6t9Fjunma/DUcKF3Mt
	LrN
X-Google-Smtp-Source: AGHT+IG23HWqVCkHOIPpPqN9q7I5ThBdsJhF/SjX0BFionkIAcyNbOLdjDdZkq336dBQuPlLWTPsPZp3sY4bPhbYHQ0=
X-Received: by 2002:a05:6e02:1a0e:b0:3e3:d1ef:83f9 with SMTP id
 e9e14a558f8ab-3e55af42426mr9980225ab.6.1754939520874; Mon, 11 Aug 2025
 12:12:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811172018.48901-1-ryncsn@gmail.com> <20250811172018.48901-2-ryncsn@gmail.com>
In-Reply-To: <20250811172018.48901-2-ryncsn@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 11 Aug 2025 12:11:48 -0700
X-Gm-Features: Ac12FXz4m1mSDHBwyZH1y28dCQy2BEgiX4wt9AY6O7YpE4Ekng2GhbNOVlfmlv4
Message-ID: <CAKEwX=O4EW=8T7EwMCiQV8STZcQR-h0Hm9R6Ei2cPB4TBCP4zA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/mincore, swap: consolidate swap cache checking for mincore
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Kemeng Shi <shikemeng@huaweicloud.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 10:21=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> The filemap_get_incore_folio (previously find_get_incore_page) helper
> was introduced by commit 61ef18655704 ("mm: factor find_get_incore_page
> out of mincore_page") to be used by later commit f5df8635c5a3 ("mm: use
> find_get_incore_page in memcontrol"), so memory cgroup charge move code
> can be simplified.
>
> But commit 6b611388b626 ("memcg-v1: remove charge move code") removed
> that user completely, it's only used by mincore now.
>
> So this commit basically reverts commit 61ef18655704 ("mm: factor
> find_get_incore_page out of mincore_page"). Move it back to mincore side
> to simplify the code.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

LGTM.

Acked-by: Nhat Pham <nphamcs@gmail.com>

