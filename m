Return-Path: <linux-kernel+bounces-872468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ADAC11487
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 915A550042E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CF62DE6EF;
	Mon, 27 Oct 2025 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v1dlgCdz"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDC32DECC5
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761594693; cv=none; b=QT1vFiyjHHMio5AOScbHlTa6vv1a37dW2lL4E6n6++u1JSDu15IjMpej51nCk9JaJ5Rq4SNbebBuJjnJ3ITQaIhRgM1eU384ZeYUnajFB0ftFSWl+jjAyk5u6flswHuvAuc1qiH26t1CKLxrYJ4yz3uf6wSUBRP8OgVjLoxho0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761594693; c=relaxed/simple;
	bh=LUw2mZCfH1yOBKTSy9rxXAh/jPqUNSJVBaTxVdNrEJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyFjc8ZKMLVQv58fRLQq6o80hJwHTaZmDLWibQuowsrYUe79ewl1Hjrx/Fp9Wor1u+EKVDadIRzgOPAhwTPDDYE6vIgpZy8eYrrn54e6JKKm7yI/CdHNMDnIY0W4GGqXChrHd7DQNZFKfAICGnr+k/fEv56GBa7U/YFbScJcL1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v1dlgCdz; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4eccff716f4so76711cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761594690; x=1762199490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUw2mZCfH1yOBKTSy9rxXAh/jPqUNSJVBaTxVdNrEJg=;
        b=v1dlgCdzKU2VKZ0tcQYZU9PtfJ+TzPScfLGl+vxfqtwwDx0Fz+gyS9RMoEkK5uhdHK
         IrQDFjyE1qTvzqKbCEq0gE0exVZVi+yT5xqrRJglNH+CmQy3pcG9S+6eJ2TOZsm/zeIh
         XVg4KCVTqjx1cpxfvOgqZt38KgeyUYrobhQZ3Dy4ti+iYalFFqeezm1IsXOd1p3Lq1A5
         KAZ3xncqNFuv2fvLLofC16hE0gxVIdegvos6BuV5yYi5cD0r7t2KWIgM5bXT9yFueV3N
         3EP5N8TBda13BOaWSSA/3htFfO8sq5GMcprsQ2b/3rZ+7IZgbSi+GbFAIukNi1k0mYUJ
         7AbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761594690; x=1762199490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUw2mZCfH1yOBKTSy9rxXAh/jPqUNSJVBaTxVdNrEJg=;
        b=RiYTb6AgtHlu7n5wr2H2xwE7e8jFon8KuhB0VGFSGkiCmq99wYAsVu8SXO1e9nLGc9
         9vyGqnN4NWx4GEKKR5tD2TBHKuKTPn0ZEDmw3iYFkG/45/zMEfhmJfUSC37HWN9RHVXF
         0OemB14UWPXZqEFEShWlVAy+YC0gyagDm+9iL0cfFgfhYctyflXwgSsY2LREZQvyME0D
         5qYDCmVpuThHfm/QrfD1hQt1F4qQ3pDEGcsTK8mTbticEE4Yzr/YkTB8vxDjM28Cqg1u
         rir2/bE0MbpgDq+nD3+uk+6JXW/gVUEfo7uLya+khBMeO73iZp5xnVTYloW0UjQzIY2r
         SIsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmECNzLZGonBziBlR+3XbZ4imMKe+EoHSAIa6k7z2R5alV9bPgze2v0iD1vLTEnA36bXAhFkoiH4znf68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFBQPXVw0sFIjvFtCBRHzpuQ8WnGB+2N7JsWRJ49ATWbUjSKWU
	rNVt6L2LGjP8+wF/LopFwasNR8NYN3esUp6D5Q/3TEvhPVWhhlQtSr7uCCODlXVXwQqVRS3rnUu
	AD947fN+URWuxHw3Pv6k6PoD77dn4Mw4O3iWzPd/g
X-Gm-Gg: ASbGncvlzEH/5Xsx4f1wyEBPgKnTIaFPvkITWRIW4ff7IE106HKmwBLfVCal9XU0s0Y
	TDCNkpfwfupPgObtglU1Y1bfMSVEgOxwd28+Vmj3TZKFT3o1i+5TqIFK2RNvAgeByQokF/r2uPF
	eAp0J/W2SdoybCjEfZhkQsAskxR7IY1vbRQkKBLGRgLITmjVk8jYZXhxcU6NwERxYn9C1S/YsmC
	j1rHmAbZMbvUf0YZjN6H0mhBJxWy74QoEscVgXA97V8hOzrMVGdbQIWm0nqG7F5dwiurQ==
X-Google-Smtp-Source: AGHT+IEmicxEYEPLgQn38b6v1mJfTIvyLMT/qtHkmyMNLHlEBQmcYJx6gF8JYoLZrM0kAWrtv1hez5d7WlrSFzFFVW4=
X-Received: by 2002:ac8:7fcb:0:b0:4e8:b04a:82e3 with SMTP id
 d75a77b69052e-4ed08f1af35mr1416621cf.10.1761594690047; Mon, 27 Oct 2025
 12:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026203611.1608903-1-surenb@google.com> <aP8XMZ_DfJEvrNxL@infradead.org>
In-Reply-To: <aP8XMZ_DfJEvrNxL@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 27 Oct 2025 12:51:17 -0700
X-Gm-Features: AWmQ_blGO7QUW6nBgXPDBNUnzq3Ln5ah_SLow5ox4iXfcHmzA4G72ZsuhQ4Fq80
Message-ID: <CAJuCfpH1Nmnvmg--T2nYQ4r25pgJhDEo=2-GAXMjWaFU5vH7LQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Guaranteed CMA
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com, 
	peterx@redhat.com, sj@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	corbet@lwn.net, axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, willy@infradead.org, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, hannes@cmpxchg.org, zhengqi.arch@bytedance.com, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 11:54=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> Hi Sure,
>
> jsut as last time please don't build empires with abstractions that
> don't have a single user, and instead directly wire up your CMA variant.
> Which actually allows to much more easily review both this submission
> and any future MM changes touching it.

Hi Christoph,
I'm guessing you missed my reply to your comment in the previous
submission: https://lore.kernel.org/all/CAJuCfpFs5aKv8E96YC_pasNjH6=3DeukTu=
S2X8f=3DnBGiiuE0Nwhg@mail.gmail.com/
Please check it out and follow up here or on the original thread.
Thanks,
Suren.


>

