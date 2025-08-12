Return-Path: <linux-kernel+bounces-763974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D6DB21C44
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE747A7B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 04:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C282DECCB;
	Tue, 12 Aug 2025 04:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAjUgLl7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF32DCBE0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974076; cv=none; b=ZCcWfuzGm6mlRPlVYkIR7WCkXxycmDVFjJK8syITd1cEMBYQrv+K1IKAjZj6BxonCNZk0TxPCelIXiJVpukTW5ShiiD1rb/9X9sMU9DzTXWeaFtG/vFi5D3ic6mObhbnncTeLR1Y8M7HyOXkN1MllyZXZZTTqFLjaa3Hk1VCrIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974076; c=relaxed/simple;
	bh=e71VLinW5AHv7lSC1tatFxzPb+7mAbNIGLPHcCoOSRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnenYRcJSSMFzS+GZ2MlCRWSlXqJclr3aX0AAuuMIVForQ4HELKK4lRBXkBDVUZn++4M6RixMEA+idHZ8Vxun/HPotnc73yF48jga626xZ/G5Tcu8EsskydMzMK55pms9wgF7qZsadhdOkus4HHrmWIsT7XxzH3Rqb8RqkQYv18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAjUgLl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75420C4CEFC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754974074;
	bh=e71VLinW5AHv7lSC1tatFxzPb+7mAbNIGLPHcCoOSRs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WAjUgLl77l6UVu9qna6Od4sYchXOqUtAYBcuYWQwiwbXKo3DhfUpRb92kQEqiYcuD
	 YY4OrO6ZeBliqXBZEJG6+RHiSnfpjCMZud9nBxDPXHQZcImNV2N/DldksKt7t8FJIK
	 kUIOsg58WWqAT1ZowGbQGO6iMqgAmf46gCkrOQ67nt15zFqOMQfQCmWGR+Jcqi3kRm
	 NbP+x8Bj9/oDFLn5z1x3taOLny6FcDNPGSwsv7BsB10lF+h0Hn2eae1NvwoCQn+NHA
	 o4D4LKEndN1trhAfpvnO0u/wheFfc0t8c8/DoRajMXyCgVnmqy0zcXd7MTSzk3rLJi
	 DlJOV0PqjR7fg==
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459fc675d11so26875e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 21:47:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYiDR+nkcwSuoy566AyIFgB60Z+K+cTzBGvIDBxTtHXN/o28pgoGLpdAwdfnSoypQuYepnpbRr3hp5cAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK7oAyDjbttuXEn9wRiZPrDgf1sP9sQfe6exREQ2Ci2fc0NBxD
	hAXW228+Q0jjaUcSFuJD1dgeD6osv+8rIuzkX/d9JaUiPS9F4V0UTizZPje8bszm0WIAPd73Ecg
	CiGxACPh/0UkOZ7zllC9N0wQd4kZ/rb0WfATK23Jw
X-Google-Smtp-Source: AGHT+IEAg5lSfpnioeUcNmQFoqWcyMdIUA/hvVXeGeh9JlSvvvtwinlKM5J0m7oJtm0oDSjJvQjzzxVT0Ys7wchxjIQ=
X-Received: by 2002:a05:600d:c:b0:453:672b:5b64 with SMTP id
 5b1f17b1804b1-45a11111c89mr975835e9.2.1754974072980; Mon, 11 Aug 2025
 21:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-swap-scan-list-v2-1-d50e4758ecee@kernel.org>
 <CAMgjq7DnniGUdpQQA0YF+LuMuL9+FCLQJP2Q04G_Hsd1sztv9A@mail.gmail.com> <20250811212423.5667183e69c373c1daf95ecc@linux-foundation.org>
In-Reply-To: <20250811212423.5667183e69c373c1daf95ecc@linux-foundation.org>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 11 Aug 2025 21:47:41 -0700
X-Gmail-Original-Message-ID: <CAF8kJuP=WfkPSSNs-7RS=1D+3LkKrMU=84o9mhOb6wTPSRNUqQ@mail.gmail.com>
X-Gm-Features: Ac12FXz-iPlIRTVDzJuGwI4wMh3CWqgXJdkWTIuII9-oAMu2X-IrrPPRX7qtJD4
Message-ID: <CAF8kJuP=WfkPSSNs-7RS=1D+3LkKrMU=84o9mhOb6wTPSRNUqQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swapfile.c: introduce function alloc_swap_scan_list()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <ryncsn@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 9:24=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sat, 9 Aug 2025 03:51:48 +0800 Kairui Song <ryncsn@gmail.com> wrote:
>
> > On Fri, Aug 8, 2025 at 3:48=E2=80=AFPM Chris Li <chrisl@kernel.org> wro=
te:
> > >
> > > This the alloc_swap_scan_list() will scan the whole list or the first
> > > cluster.
> >
> > Hi Chris,
> >
> > This sentence reads strange to me, but English is not my native
> > language so I'm not very sure about it.

Ack. My bad.

>
> Yes, I rewrote this to
>
>
> : alloc_swap_scan_list() will scan the whole list or the first cluster.
> :
> : This reduces the repeat patterns of isolating a cluster then scanning t=
hat
> : cluster.  As a result, cluster_alloc_swap_entry() is shorter and
> : shallower.
> :
> : No functional change.
>
> Which is hopefully accurate.
>
>
> LLMs do an awesome job of doing this, although one should carefully
> review the output.  Here's gemini.google.com:
>
> : alloc_swap_scan_list() now scans either the entire list or just the
> : first cluster.  This change eliminates the repetitive pattern of
> : isolating and then scanning a cluster.  As a result, the function
> : cluster_alloc_swap_entry() is now shorter and less complex.  There are
> : no functional changes to the code's behavior.
>
Thanks I will do a V3 and use something like that. I spot some other
minor cleanup required. Might just add it to the clean up series.

Chris

