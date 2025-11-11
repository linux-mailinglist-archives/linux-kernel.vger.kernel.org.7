Return-Path: <linux-kernel+bounces-894953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E83C4C8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61D11884BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7C23375C2;
	Tue, 11 Nov 2025 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UyFSIlwB"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7789F2F12DB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851800; cv=none; b=R6r5FPmZfkGvpagJo+4ZDtgU/4bcFLZ8fyl7NJmSfo9zdwDoIJHNV52mHvBqH9JtH7RZHFv+EcBeFI/SoQimANbbdXL4gU+n5H/TNi1YRa71CUJ/A9+aEu7uiChBSxyjiv6PdS/c13t1ItImp2bjwadSeGLSxCKelML8yY0m2Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851800; c=relaxed/simple;
	bh=pvNoy8QjEGF5vDREzb9JJ0U69eI//OHw5iW0XV0TScg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4Jb9j8PXY7PoeefDo/sxMJwqqNlt/iviSkrgGP4XxoEBZHx0KKzqkY2aXiOFKjLYt9M9e9JXuI8Rz7WiOhvzyPmq5Phr8NRNhrfi5PSERi7UthvjI7wcTBnXiK0CvC8NnSy9jil+/9c63OpAObWf4X0tgNLk4xTzvKubofNy1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UyFSIlwB; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8804ca2a730so59064876d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762851794; x=1763456594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvNoy8QjEGF5vDREzb9JJ0U69eI//OHw5iW0XV0TScg=;
        b=UyFSIlwBqni/WK3LjDAS7FYlHe741djJ/Stxqtrp4ECcr4d/ij7y2e20TxB3pNOE+k
         nVia7+QMOCM/Q2YE+Rcr7hm3DxiSdycZMJxdWQ3w/e4fxYc+YL4PgyfYtyh2Nk74m5Sj
         4GXBl7vlsL2zQ8wsjKeVsGxPCucHzPthtHmBV6EAQwE1UYTPYpUtJBmxcNHfMS+TrEBR
         SctNhE1TA2PahMS60wiuRST29P3fpeV19FuNarur0ywSqk8o94qPIRKDAAAa65D4EKT4
         90Tb4cRFDRw/f5wbBH1i0ofeNF+vuIiZUMJL9xxHY364kD5UNSXD16yOW7drnppEwCuM
         R9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762851794; x=1763456594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pvNoy8QjEGF5vDREzb9JJ0U69eI//OHw5iW0XV0TScg=;
        b=B9YhAJa6sLsQDuBxYDEyGqZebQcEQdwa4y3fYUyWbw3OT7ei1W6GmgpjaHQ8Nz3Qwk
         G/PWYlyNcZVGes/MEWaGwz1V8b2T5UtwGXigjBXkVD5ofUmnfSH4iZoz02w5a5D1f9Ph
         C2XihA2yijXAnT/U/XzN41G5jtWFLVggqbqT5s4AyCBJPpAVeBpT8R66HTvGz0rue0ze
         K56O25bBkdxywndJCGIzKsuEF3Xkga0Iwk5J/406/nkWtKYh5DJNeLepGdXkw6GJNodp
         CMkXwzhjYBN6uXiZmlaDETp2Kly+pLfidhS7FXvQvMJKBF7beDak3dnALRBLcx4+R4O9
         rbTA==
X-Forwarded-Encrypted: i=1; AJvYcCXKyHGuIb4a1vHvOaLgEBw8c0CKrpe4wpXnDaIPOpG+Y/s7I5ZBVHroFHpinMsbMUyy/G3MuV3V4mlu/+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjDB5cV2a9zJWuMiN+rAqu3UJxE7rRwseNPcjmRXb7k587/Zl0
	0NvQVJy6vN6g2TDXfTYOD3xpJOABk0ewQXcYfhZA+mn5fWx7nJ9uiRIoWUpcYZo6UFrjkpYMaOa
	w4wSAQz/NnY0zyA7AY6TUG2gY5YqmoD0lMqTf/1Z+
X-Gm-Gg: ASbGncsZpnzQfO83y4G5REXthHnC2LJEXl9VNHrvg0dA19PMrsrg1bbr5jAkpqypABA
	A8fbX5iqMFY0eaDLe4dV5n6gLCBrPSrdoxEZrbYwjAc8likksIJw43tUGSHBpfnwsQmWONy/4ix
	N5mvgdkJNGk6UcCLRMJBlP8BfBwjUyN0384KAmGRRNfVVQOERz3wKlTnHBcT+QW7AnVUHRm6NJg
	CdugR6IHCaRCvETjPSFBI/b57DT/uHavHZK8X/CgiER1GAIa4MZSUQJtxyrlHn9sxmc+K34705b
	UmjrM/tWFOhmyct4hKDl9tAuew==
X-Google-Smtp-Source: AGHT+IH4F7Ckq32jrbiUxtB1JJ5uFrJqHGgUMRdrFl5ONAv3USRRzhM1TtECqM3yfM33Ue560sqRvq2+UhD4VMC4pSM=
X-Received: by 2002:a05:6214:e42:b0:880:51ab:a3e3 with SMTP id
 6a1803df08f44-882387621d9mr168741746d6.67.1762851793588; Tue, 11 Nov 2025
 01:03:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761763681.git.m.wieczorretman@pm.me> <0a21096d806eafa679798b9844ec33bf8a5499a4.1761763681.git.m.wieczorretman@pm.me>
In-Reply-To: <0a21096d806eafa679798b9844ec33bf8a5499a4.1761763681.git.m.wieczorretman@pm.me>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 11 Nov 2025 10:02:36 +0100
X-Gm-Features: AWmQ_bncs5LVtJN1ReProGRqJJIZk54xNH4kh3rOCX8uWFHvQkLT6YYoepdGREs
Message-ID: <CAG_fn=XQPbZb4MTBUgkJ17gfQL5K1QMahaJ39Mw7Hv4zm1crXw@mail.gmail.com>
Subject: Re: [PATCH v6 16/18] arm64: Unify software tag-based KASAN inline
 recovery path
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: xin@zytor.com, peterz@infradead.org, kaleshsingh@google.com, 
	kbingham@kernel.org, akpm@linux-foundation.org, nathan@kernel.org, 
	ryabinin.a.a@gmail.com, dave.hansen@linux.intel.com, bp@alien8.de, 
	morbo@google.com, jeremy.linton@arm.com, smostafa@google.com, kees@kernel.org, 
	baohua@kernel.org, vbabka@suse.cz, justinstitt@google.com, 
	wangkefeng.wang@huawei.com, leitao@debian.org, jan.kiszka@siemens.com, 
	fujita.tomonori@gmail.com, hpa@zytor.com, urezki@gmail.com, ubizjak@gmail.com, 
	ada.coupriediaz@arm.com, nick.desaulniers+lkml@gmail.com, ojeda@kernel.org, 
	brgerst@gmail.com, elver@google.com, pankaj.gupta@amd.com, 
	mark.rutland@arm.com, trintaeoitogc@gmail.com, jpoimboe@kernel.org, 
	thuth@redhat.com, pasha.tatashin@soleen.com, dvyukov@google.com, 
	jhubbard@nvidia.com, catalin.marinas@arm.com, yeoreum.yun@arm.com, 
	mhocko@suse.com, lorenzo.stoakes@oracle.com, samuel.holland@sifive.com, 
	vincenzo.frascino@arm.com, bigeasy@linutronix.de, surenb@google.com, 
	ardb@kernel.org, Liam.Howlett@oracle.com, nicolas.schier@linux.dev, 
	ziy@nvidia.com, kas@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	broonie@kernel.org, corbet@lwn.net, andreyknvl@gmail.com, 
	maciej.wieczor-retman@intel.com, david@redhat.com, maz@kernel.org, 
	rppt@kernel.org, will@kernel.org, luto@kernel.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, linux-kbuild@vger.kernel.org, linux-mm@kvack.org, 
	llvm@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 9:10=E2=80=AFPM Maciej Wieczor-Retman
<m.wieczorretman@pm.me> wrote:
>
> From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>
> To avoid having a copy of a long comment explaining the intricacies of
> the inline KASAN recovery system and issues for every architecture that
> uses the software tag-based mode, a unified kasan_die_unless_recover()
> function was added.
>
> Use kasan_die_unless_recover() in the kasan brk handler to cleanup the
> long comment, that's kept in the non-arch KASAN code.
>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Alexander Potapenko <glider@google.com>

