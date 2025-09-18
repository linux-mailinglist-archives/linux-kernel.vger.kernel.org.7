Return-Path: <linux-kernel+bounces-785495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD92B34B96
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E811A882AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDB7280CD3;
	Mon, 25 Aug 2025 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFlxFsri"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B1D1DE2D7;
	Mon, 25 Aug 2025 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153100; cv=none; b=PZYcxUXE6fLf3gSYPTgrLIziw9NOJjDrjXnIffGxcMPHUxyEns6GQVPWktE8oVYAhCMGEm5AgAV/PagbrA1jwrcYP6GA+cNLbQGDr9uWiWxzzFqUX/dihveP9J5aloGipkLENobd9FW67FniEx6Q3NKF/o6ASDQtP4JXMZLNLz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153100; c=relaxed/simple;
	bh=yNerjuxI+KYbw3mNCEHMV8i09CJJK9GCt86H4fr7e/g=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=EqjvvKR8wtt/HRd9Vx+m+7UK0WN17o4MgZaxym6z8xT2/b4VXRjQG5mgMOCzPF8L4eQRR3lrBFqLuUzEcUNaf+Z7DdfApeiqxP0ATARvthrC2qz2FFyNWWU1gyNIDoE5a/yVajweSlOe+EPkB3oBgpwRvgXP9GyW6wkhwTFrxls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFlxFsri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51237C4CEED;
	Mon, 25 Aug 2025 20:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756153097;
	bh=yNerjuxI+KYbw3mNCEHMV8i09CJJK9GCt86H4fr7e/g=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hFlxFsrioVHoPBVPmP1nQAdWfA6sGqieK/3eJIPNwb/fgHtGy72TnnSEvhYryibRv
	 GFKFFoV8oSOgWAtWyCNJNocRKr9FJwZ2ZGpaUfnsOhsyI0kupY0SZiqYyBfPilEvcE
	 lC8u05P6vI385iou8sEtH/JARLmrK/KjWR9Gq8DplgFKfLbZgXtCTwPYWtcQRGEdVk
	 RPbLgoMWeYCoQ2qRe5bF0p/PlmOi7wwTGbEdmACDi9xjXr3qRzKZgG4IvzRNF2m7fK
	 PHyxc8DoAeOJeLn60+cbpo9WKw0T1FU8V8yljOwRUbnW4SHutpvZMkzdJxcZLgjaNC
	 4b0+vQDoj+Kgw==
Date: Mon, 25 Aug 2025 16:17:53 -0400
From: Kees Cook <kees@kernel.org>
To: Marco Elver <elver@google.com>, elver@google.com
CC: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Florent Revest <revest@google.com>,
 GONG Ruiqi <gongruiqi@huaweicloud.com>, Harry Yoo <harry.yoo@oracle.com>,
 Jann Horn <jannh@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Matteo Rizzo <matteorizzo@google.com>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RFC=5D_slab=3A_support_for_compiler-?=
 =?US-ASCII?Q?assisted_type-based_slab_cache_partitioning?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250825154505.1558444-1-elver@google.com>
References: <20250825154505.1558444-1-elver@google.com>
Message-ID: <0DC67CE5-6006-4949-A81D-882DBDF4DAC4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On August 25, 2025 11:44:40 AM EDT, Marco Elver <elver@google=2Ecom> wrote=
:
>Additionally, when I compile my kernel with -Rpass=3Dalloc-token, which
>provides diagnostics where (after dead-code elimination) type inference
>failed, I see 966 allocation sites where the compiler failed to identify
>a type=2E Some initial review confirms these are mostly variable sized
>buffers, but also include structs with trailing flexible length arrays
>(the latter could be recognized by the compiler by teaching it to look
>more deeply into complex expressions such as those generated by
>struct_size)=2E

Can the type be extracted from an AST analysis of the lhs?

struct foo *p =3D kmalloc(bytes, gfp);

Doesn't tell us much from "bytes", but typeof(*p) does=2E=2E=2E

--=20
Kees Cook

