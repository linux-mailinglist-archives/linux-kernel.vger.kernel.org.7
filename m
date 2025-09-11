Return-Path: <linux-kernel+bounces-811714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 408F8B52CF0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6DB1C2071F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFB12E9EC2;
	Thu, 11 Sep 2025 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yBHad4Al"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A012E8DE1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582302; cv=none; b=IZe0rBVu/xuEh5urSect98GruHhm7+ug3Ir/+5WsKrSufBkDZL5h72anQnCtQhf0VGwkJX6V8cwi2SjpOhEYGRu7VXaq03G3VA69Mckfab48zPXdqJVxILWDegTJIP9gujqIhCUgfvDTPBMsHOLHXPpSWxDAEz8IlfzyGFN5ryI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582302; c=relaxed/simple;
	bh=1B3D6WIyM4uKCWTK+JvwjK5rmKnBn1DsJarcuewJmQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJxMqUn6vn92q6By4XjzTE+5vcnRjIDc98juZtGTjA6mbHyi74KBEhPI9JwhlNo2qKgm6jNMGbu/NlTgB5t4B+cKcGYToTkuwHdDDRPIXHOstSTBByQPyhl57enI6Fg2N3dSebLeP3yJfbfTP5wlLDaGHK5JIqBUeG7I0ga8lv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yBHad4Al; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-80e3612e1a7so82098985a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757582299; x=1758187099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1B3D6WIyM4uKCWTK+JvwjK5rmKnBn1DsJarcuewJmQY=;
        b=yBHad4AlHhN6xy1ETyIXTUjHUNyn8b1AyhTsMHAfhIed9rD2urdwr25RkJl/3nbDmo
         1VWACUkvD7U3dYFobURlyHBwJJdDnpOtUHDT6WMqkM9y4XeoGBhk2Ru9hfAdfBfoTBqO
         mJ2sJEeVKNHoSwzDgOZD34o0CJ4wsOwF45aUg8OsHxQOV6BMVRBPjlHEPc3y1eg3xuWz
         w3lZ4EqqzNuLbF8ir0bMPq6eWdsBtOO4CNcj0NhrJ6o2WZw4K2d9JZIRCOMXo+ckdvK2
         WlHQ8DAKM5F5YmF8fLW7d3BWgiLPrKXsjMA72uWERZna9hnOKwmoDz9alq8MGWJg27kC
         ZA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757582299; x=1758187099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1B3D6WIyM4uKCWTK+JvwjK5rmKnBn1DsJarcuewJmQY=;
        b=wkz4/FWFM8eM5kt3ocCSwtzZ7rFwo+N7faczvFwD1t0JkX+mBds8+gpadaHF705+Pt
         9DbKCduK+CmpYYeFfJQpFoTBS7CgvSrIehvY7FjSEOJdnLdNJDdKGp06DL/FDmYhO3j+
         3EMLQ+BUvQ8NL2jA57ASfWEUeM65hxDSumjdjbiAD1BjskcT4YHuwDzYekfEnH7a60p4
         3cMsnWBft0/wgtvrB9d+gxui1uGLgEfWkhiQbgNjQnFc6GIjaPMnpnNP+vBlnLtiqlgf
         K+VcWYV9GXXDWojeD+/cKmMca4rMUIsP9ddBDWSglQ6FYqBFexuRpWobnpf9BbX8pk6B
         Rdkw==
X-Gm-Message-State: AOJu0Yyl8N72wliMCMgfy/gR0SvF5zwoIRkohN+vkRqc4B4FdGB3TlzD
	BDlenXa2M1sKJNWfdaucR+rVa6/DwDxQlC6AHik9Fpcs5w5s2eoe9uOoiJZmz4uUI9NXzxpzqBG
	6vTqZXa52xBcDW9+FpZ3VxZGdssoNPcoerNXqUSk2
X-Gm-Gg: ASbGnctWMjdy87PNR6qXzmax/TA8M1rhQIBTn50b3B4bfDbViUVz++PI/xIlKl1Vg8P
	eEY3CwXpHxl81+mhhES1WVlzuI7HN3hotxq2B/mqpWpNykFxjZ7vVpuQnpecetie+rQSN9YXtu9
	Xk40rNPd/o/LMuQe1QI7ep8uJnPxlqJ/SaOcjiqkwg96i2qvNl30hqvlSoowDzHtlpIFGqW/lli
	M1VPU5W6LdUhQmst2HAwRRLkVLAToCPKLpmwDQ9tlBb
X-Google-Smtp-Source: AGHT+IEAdn2JRKDnhaL2qmt37A4l17luV2CMhXbLee/vFTGYZd/pxxVUthlBX8HJQeQEoIdvrbi8slCg3eRXyv3n/Qs=
X-Received: by 2002:a05:620a:45a7:b0:813:8842:93bf with SMTP id
 af79cd13be357-813c1e8e0femr1958044985a.40.1757582298381; Thu, 11 Sep 2025
 02:18:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910024328.17911-1-bagasdotme@gmail.com> <20250910024328.17911-8-bagasdotme@gmail.com>
In-Reply-To: <20250910024328.17911-8-bagasdotme@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 11 Sep 2025 11:17:41 +0200
X-Gm-Features: AS18NWC9Ax6HJ7xE41xsztIAoL9MxJcZhppucVI7C3-6QUaMqtQ6glgozKyha94
Message-ID: <CAG_fn=WPCtL2Knk7_so+9QMcUPY2wCG93BZN-rwJC+ELLgJ4nQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] Documentation: kasan: Use internal link to kunit
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux DAMON <damon@lists.linux.dev>, 
	Linux Memory Management List <linux-mm@kvack.org>, Linux Power Management <linux-pm@vger.kernel.org>, 
	Linux Block Devices <linux-block@vger.kernel.org>, Linux BPF <bpf@vger.kernel.org>, 
	Linux Kernel Workflows <workflows@vger.kernel.org>, Linux KASAN <kasan-dev@googlegroups.com>, 
	Linux Devicetree <devicetree@vger.kernel.org>, Linux fsverity <fsverity@lists.linux.dev>, 
	Linux MTD <linux-mtd@lists.infradead.org>, 
	Linux DRI Development <dri-devel@lists.freedesktop.org>, 
	Linux Kernel Build System <linux-kbuild@vger.kernel.org>, Linux Networking <netdev@vger.kernel.org>, 
	Linux Sound <linux-sound@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, SeongJae Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, Jens Axboe <axboe@kernel.dk>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, tytso@mit.edu, Richard Weinberger <richard@nod.at>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Waiman Long <longman@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shay Agroskin <shayagr@amazon.com>, 
	Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, 
	Saeed Bishara <saeedb@amazon.com>, Andrew Lunn <andrew@lunn.ch>, 
	Alexandru Ciobotaru <alcioa@amazon.com>, 
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Ranganath V N <vnranganath.20@gmail.com>, Steve French <stfrench@microsoft.com>, 
	Meetakshi Setiya <msetiya@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Bart Van Assche <bvanassche@acm.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Masahiro Yamada <masahiroy@kernel.org>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 4:44=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> Use internal linking to KUnit documentation.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

