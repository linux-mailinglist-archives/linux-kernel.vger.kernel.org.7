Return-Path: <linux-kernel+bounces-899702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 028E5C58C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E83E64FA2DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE672FC010;
	Thu, 13 Nov 2025 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EeqJwZrD"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7E92F0C63
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049043; cv=none; b=Bxy2rZXJgzWT03BxlhO3UDSAvdAhzvhCusgg1KWIUeIJAcCJG6ui2sdp5Slnvu/81KLJQ/xUERGIatTXD4j/Hj+K47G+2QijkGGvb3BNdR+FH3vW87LTXU7Kh8ZFRlpFcsSfJ1ob11Q6QaoYVurlTYypsRGmsBgadIhf8ZuXZ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049043; c=relaxed/simple;
	bh=Pfjqk60b3THr6aC7BPzuk/TyhyVleC13UqlztnSEPLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceGMgyVfsinElVvZTK/BIUAVBnw/ncEbPfoqrwvA1pMQJZ70IyMRx7V09ha4xcYaxvvGjqa7tSUThJcgoXDSdzvHtHRrP5VY9h2d2t45j/W1GIlBg9lW/TzV2ESrtg3ZQ55sCiZM7z/IOFxtNl+0NWysYBTXSOgG6fhwARGEYpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EeqJwZrD; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b262add487so103226385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763049041; x=1763653841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pfjqk60b3THr6aC7BPzuk/TyhyVleC13UqlztnSEPLE=;
        b=EeqJwZrDX4SeCiOY3OvCZyuKTaIBqhtMvRrhU87xemKUaOPFBVpP4gg787x60VG7Z3
         OC1UjAAnz9CIxey1yHCt2aoqcA3W5Vo6IyfdFdGKtiVfposu9ksUpVeidLb4tutqDoX9
         /l+XkgXSJYHbhqk+N6gc08qBp/1pr+yGhYRDe54bmCdiVC2fsbHKTnyqE85Q2P2EeFix
         kZCUOUYIEnVG5YTxQ8jkTLTNokATba7v4RYR0J4hZy7JmPU/Ksu9eFF1DiT67dvuv1tK
         RhDljY4YMOyXBxE9SyACGcmAMm2tAAJR5U7pN/PQ3FetXRJV6rXXXncZpfmBnbN66HRR
         lZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049041; x=1763653841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pfjqk60b3THr6aC7BPzuk/TyhyVleC13UqlztnSEPLE=;
        b=u9CE0MxbQpLwLC879TJfObMR3QV6teCkxGpj+ttFXTsuAkMIxCcJKSTM6ZoVRjUq9d
         zYc49QQNWvbmpcaCzAyAzztLF91DXFIDMzfBpSXWZ1pYhn1QoQlas4qjD3BVqoT73P+I
         OJl0ZkoRcA6XQ4ba3oTJPejggJkttAFUYGz2bIyeOCfx6yKJXwiGFVoCsxXzZl4hWamI
         iTxjco/eJ/rRR/ER0+xpu7AmOSuX5a3I+kbx7+Mb6CRkXxNokVMVpbZG4zwMUFVTcsTt
         ayn1vWSmbMAqePi4hQ61f/GtprupBZqk849HQxDUc7rJeWa6Hlvm2M+CkeVxLxsTtX4+
         WzFg==
X-Forwarded-Encrypted: i=1; AJvYcCX2AG5en1h0iucccEwiOwbtVe+WQkAHE/4dceejjwWvnyhMbBpFYGFWFUdV/E0JWLkHSG/gwVNH+ZvVpfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxby6VDgNFkQGg6uUzdRcX3+JneM1GdTsVHU4BGJaHD68+vUBm
	bsmy1kWM/PaMm2kLbAZ2I2pz1qsnpLuV6/ugfMYEkJTpxsiynY/8nl1MaDSU0V85g+/sMlI1k48
	7VYu3wUkaRh81qge0JcD4g913s3D9ngdasvjwz18w
X-Gm-Gg: ASbGncvFtb5FoT+FGRwwANzLnK0Gxc6sXcqNUqr/k6pMikKVdWkxq+8ggvqHT2fcpZc
	VNkxUHq3Y9xCJWVnf1ZuWN4KtOtu0TnBoBgtNnR0wV5wbrokc8aoA3qHY8VbTnAblannzKHKtRQ
	QpDyUjMEiI6vIjEJTG91Rp3iEtus7UHnKCxL1ddZfbVWnZSic/cUBzjaLpqVTYFH0YPqnaZpQ+/
	x+mnLf9H+isWonCnQu8Q55t+1GiRBrNXeAuG6gPq3Ocl/GtuyovMm28cekYMWn6K88oEhaXkEsz
	9VeUdX4=
X-Google-Smtp-Source: AGHT+IGMjRUoY7nRKeINhOpAWlxY1uOyXJ7f2kSGeOU78eFrpNzjxzKtA29ny45jesxZqVrnMlSBnu6gigSBq2AMGhA=
X-Received: by 2002:a05:622a:130a:b0:4eb:a439:5fe8 with SMTP id
 d75a77b69052e-4edf1f39a9fmr2200831cf.0.1763049040701; Thu, 13 Nov 2025
 07:50:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113154605.23370-1-scott_mitchell@apple.com>
In-Reply-To: <20251113154605.23370-1-scott_mitchell@apple.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 13 Nov 2025 07:50:28 -0800
X-Gm-Features: AWmQ_bltsOvb2svPtDoPMFYM_GmVTdMqw3ShE8mYyo_cbuU8uVm_vgFXojpGOdA
Message-ID: <CANn89iJ_b6hfj96Me-8AZN92W+cA52HpGcu81J0MNtzeahpfXg@mail.gmail.com>
Subject: Re: [PATCH v4] netfilter: nfnetlink_queue: optimize verdict lookup
 with hash table
To: Scott Mitchell <scott.k.mitch1@gmail.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, phil@nwl.cc, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 7:46=E2=80=AFAM Scott Mitchell <scott.k.mitch1@gmai=
l.com> wrote:
>
> From: Scott Mitchell <scott.k.mitch1@gmail.com>
>
> The current implementation uses a linear list to find queued packets by
> ID when processing verdicts from userspace. With large queue depths and
> out-of-order verdicting, this O(n) lookup becomes a significant
> bottleneck, causing userspace verdict processing to dominate CPU time.
>
> Replace the linear search with a hash table for O(1) average-case
> packet lookup by ID. The hash table size is configurable via the new
> NFQA_CFG_HASH_SIZE netlink attribute (default 1024 buckets, matching
> NFQNL_QMAX_DEFAULT; max 131072). The size is normalized to a power of
> two to enable efficient bitwise masking instead of modulo operations.
> Unpatched kernels silently ignore the new attribute, maintaining
> backward compatibility.
>
> The existing list data structure is retained for operations requiring
> linear iteration (e.g. flush, device down events). Hot fields
> (queue_hash_mask, queue_hash pointer) are placed in the same cache line
> as the spinlock and packet counters for optimal memory access patterns.
>
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>

Please wait ~24 hours between each version.

Documentation/process/maintainer-netdev.rst

Thank you.

