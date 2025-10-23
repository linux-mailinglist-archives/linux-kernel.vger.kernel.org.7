Return-Path: <linux-kernel+bounces-866376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A36BFF9EF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40FE2563C8D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1676A2D3A9C;
	Thu, 23 Oct 2025 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI0iwI8f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1BF292B2E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204049; cv=none; b=IYvjO7a9r5I/cvQP9sV2L56JqddVsiBs85hZTAGPH0C9J6C2rdrCFeepSDvhbgPEIMzuWYdaXFtSYfF9xmj8Lci89sk9pqUdrHbKg7N7AQ1sSOAT5qdwCbykXJ0q6T+OEP+pYWz50B7sUNCiQBDZ0vYE3v/ZsSCBpkNRe7LydBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204049; c=relaxed/simple;
	bh=FHUTIJwPFC4Ioyuh/WpSnECIWsTnz0fQa4OEteHl/Eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGUQtD2qYs/FffXKhwcH83z6pJD3NmZJEIAOQJfj9hjGItLVe4rHZaoSBbYzctalPBjNOFKQNvgG2bZVCft98JJfsvNmeGdJhgca8miRtfTmTk3n1ex2R+0qrANMREUet4KqrI42h6rkpTaWLd+kqyl5QALKTs4RYlHg9C/VaVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI0iwI8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9042C4CEFD
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761204047;
	bh=FHUTIJwPFC4Ioyuh/WpSnECIWsTnz0fQa4OEteHl/Eg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MI0iwI8fWXPGzQqO50Q9MOyUHMGbXpsBJohUikGsKbdQuCt2Ql3DZO72vdhaGkSCE
	 3+6gGMBZShuSKTdpjPbwjOb3d6ghw16kzRhH3TghBoHeTyj2rvr7i8Fupwf3r9MBeZ
	 bdcXV50vTGvjYiS8JFr2NVz4xz7X7qZfJUxEV6QtKj2/tqnHVsgl5NQk84gXXAFHNt
	 TzU4zAaw+C93G8YZeP8K1/mvPq3AOlSsuQXYmTwDagHTp3werUikyMHwnhqgbm0dKV
	 ZTxwfYprUgnYawJ6HXvmOfnYy54dRz7Wr/b9zCS37DTM4RP+Z/R0Kfmk2akQe5QPvv
	 uHF/f34G/moPA==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63e11cfb4a9so750736a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:20:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlV3DWEGcuAFuDSkbgmlthy5YiVNaNPbEu1GwZ0qKI266ZAry0fqHA5fjhtLrW2JCtbyUmUTjEBgr3C4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5GGmiT/9fKvkbhBZLlpNI+Flo3+WTmNK4WFLrZGAJc9XqzLzd
	0N0pjRUuJPw2Zl1oijqgdnpdggYkqz4B71jSkb3G9d0QkMgpZYwmvCagDeNTWa5KrKVEey3WwJz
	SX1wIN4x+gSIsyhfXWzH6uulndSLPbSI=
X-Google-Smtp-Source: AGHT+IElUf9rSzCuxbQ5j6+hxdzT+twdeGeIrzOd7tiXsqwRcYLtM/FWZRhWgbL+IK0INLNzwr3CMimpnNInb7WpYPo=
X-Received: by 2002:a17:907:db03:b0:b5c:5df7:be60 with SMTP id
 a640c23a62f3a-b647560b117mr2665886966b.52.1761204046310; Thu, 23 Oct 2025
 00:20:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7YXJ4T.2LNCI9JPXKCZ2@gmail.com>
In-Reply-To: <7YXJ4T.2LNCI9JPXKCZ2@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 23 Oct 2025 16:20:34 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_CteiFdBsAJ+BMzuRhk1VN=H3k2JdSoSsW0dLMzfXw9A@mail.gmail.com>
X-Gm-Features: AWmQ_bnPZlMZAOpzO9J_YURK6vwW65A5gLE3E4k2ieTa1Dk1tSjJq-l_RC2TU0c
Message-ID: <CAKYAXd_CteiFdBsAJ+BMzuRhk1VN=H3k2JdSoSsW0dLMzfXw9A@mail.gmail.com>
Subject: Re: [PATCH 00/11] ntfsplus: ntfs filesystem remake
To: Lassebq <lassebq.mine@gmail.com>
Cc: amir73il@gmail.com, brauner@kernel.org, cheol.lee@lge.com, 
	djwong@kernel.org, dsterba@suse.com, ebiggers@kernel.org, gunho.lee@lge.com, 
	hch@infradead.org, hch@lst.de, iamjoonsoo.kim@lge.com, jack@suse.cz, 
	jay.sim@lge.com, josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neil@brown.name, pali@kernel.org, 
	rgoldwyn@suse.com, sandeen@sandeen.net, tytso@mit.edu, 
	viro@zeniv.linux.org.uk, willy@infradead.org, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 6:20=E2=80=AFAM Lassebq <lassebq.mine@gmail.com> wr=
ote:
>
> Hello
>
> I wanted to apply these patches on top of my kernel build, but I noticed =
that not every diff is included in the thread. And I think some code in pat=
ches appears to be a out of date or target an older kernel? Like there is u=
sage of inode_generic_drop instead of generic_drop_inode.
>
> Is there a reason for that? I'm new to kernel mailing lists so I'm not ex=
actly sure why that's the case or how it works.
>
> Appreciate if you could clear things up for a newbie like me.
ntfsplus patchset is created on the latest kernel(linux-6.18-rc1), and
generic_drop_inode was renamed to inode_generic_drop in
linux-6.18-rc1. So you can apply ntfsplus patchset to 6.18-rc1 or -rc2
and try to build it.
>
> Ivan

