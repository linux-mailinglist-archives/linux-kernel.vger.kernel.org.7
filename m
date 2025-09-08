Return-Path: <linux-kernel+bounces-805545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A3AB48A08
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21B01B252DD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B5A2F744C;
	Mon,  8 Sep 2025 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RiiAWDkJ"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2E42E3391
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326966; cv=none; b=lSll1k4t3vOZxZofhxFlCByTnLXAXNxh988qg5rmQY+OXDYgjz8AOZ2ieyVipK+lc9CsDdV32Iu7D+L2T8QDv4pKHvMS4t5+PuuQ0QxYOaV+AHgiZvBvvrQ5zpISriLizsi7wuOUqCSuvUT5qO+0p2RcnMaqCGYfjyMucN/KBQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326966; c=relaxed/simple;
	bh=RHFxWDCHLy5hvU8idDeLnpypbjz+dKFI/3c2JendMoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNLFjDDJvSF1VBVfP/P7nP3OCyV2iIlIBfpJwQ1R7piMTMRZfikps7H6lVZuapyV73JIsOohbbmWaCTdJ/yNldtQiwtLR7TO7VaWJQiiMvKPTneWeGJrm8TZTs8tVHHxQTG5TJi64BUkSBhp/wFNBvKVxHBRtqdaO88d2jVMptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RiiAWDkJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so2770093f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 03:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757326963; x=1757931763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrzZTtPMBTTwhC4hDpYeCTJZty1sUGPfAIEYck4kXTs=;
        b=RiiAWDkJgLVkF/rUWUJGTeM5S6+zrBpg1qnCf0/zDs7A7WW4l7jqM7vu39E1N4SKn3
         P2XZYzGHAWatVK9OUlT0g+DIMVDvut7SVvtHKl/5IoEMi703d2a1bDk1aUlT9kHkOl+e
         ticcS0I+H8o4z8rIt9xhT00UdsxPsidZp5w6C6hwZPax8Gi+cAfciMEzqiQP0qNLltPu
         JLt4KaIWNxM6atB+RUWcz57jxDTWokfmPy4wvXcQuu5aGkZgKCmusQl5Ti+k+lI/ILtS
         kyZ2HCpT0a1v5kSREMjknDKOiSMUvTGNy9bQp5GrgOvW0e2hEDBhZOeKfoM2hiUMmvEX
         xhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757326963; x=1757931763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrzZTtPMBTTwhC4hDpYeCTJZty1sUGPfAIEYck4kXTs=;
        b=kq0h1LFgTecEhxsOFKpY4eyJVNyB087iYf7XKG87xAiP8UKz5Ymma6l2idP/+nmomi
         aD6L4+ZhKzFbN22yz2TCdpqlHGAJJcb+xaQhOZ7x9he1R4JaiMs9rRXeFYPMOGH+mZDg
         9iwHY1s58BsEiO8eG13AXJ7CslfE3k+TGracCJU3Wb1gWjac47OMKhuOCQNzbxIiEMWW
         M7ZkHHyYOloJeN5jVF+eP/g3Oa1ncp/Ym8yrWsDLTkOo3wVbKd783pNSoIYyl182tdCy
         FeWOrFNlvFFBUKEyccUc7HbQsR0vt9LyrYQCxN9UpgBOxXrLTIoJB6cj/F9u8cCUaw8d
         uFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkcfZNkTKQb+wD1vc44LVmp3EKQiGugDbKO6pqnO37he/qLv3ZyjOKgEBhtYV1nA2Cql9yMNEaAJb8Afc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXeb3jKcvFPkZaRo/rdMp2cV5qyF4FRwO+VCGSzRSD9Ve9KFaf
	ajNcJMofHI6MyTEw48YS/vhIgrSm/u3ahl5Fabw6sS+cG+uymo2BZjJFTRSp8SToXcYli4VWyqC
	wOej3y8FvF0tWEJZtQx+1Ef4SxPS9TeUZIj+yEpby
X-Gm-Gg: ASbGncuWzrzOY8e/gGOC+XNZ2tvs0VoutCcXoGHVz5rtS6bCVD3NKho2SpEV4+Pm21T
	io55hzzDdniIBs7xEHloOgy3HjhaUp4orlwLQ9H33YdqolY7tLcqTUpAYvVd5F0pn+i6+v7jt8b
	B1g1pjTvzT6fLjb3ZcMimGU4d7krWMMP/EaXpR2FfdiKwdoQVoXpi+N5ChH5uXt0vrcgtvBCZgH
	MuQy9khsZgiCuYnRgQcH+vP+cNfYrmwdPH1BKopKMySbhMlO4XmSQAb28c8dH7bXxJidw30lbxc
X-Google-Smtp-Source: AGHT+IFgWYJROM17+WIrfUEk3tvBLaNIow64btrV8OrhYTpagog0f41sQ1woWipkCJ+Mg8IHT5GJftLiAT4HnQvHO3M=
X-Received: by 2002:a05:6000:26ce:b0:3d3:8711:d934 with SMTP id
 ffacd0b85a97d-3e63736edd3mr6168164f8f.14.1757326963179; Mon, 08 Sep 2025
 03:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906140256.3059395-1-vitaly.wool@konsulko.se>
 <aL6YHkF96ICqqbBZ@google.com> <94252007-f389-41d0-b5a0-ed948225543a@kernel.org>
 <CANiq72k6OXcvjzKimfzKAAw8QPzDoVxUx_smFA8KU6gEwJ3yeQ@mail.gmail.com>
In-Reply-To: <CANiq72k6OXcvjzKimfzKAAw8QPzDoVxUx_smFA8KU6gEwJ3yeQ@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 8 Sep 2025 12:22:29 +0200
X-Gm-Features: AS18NWA9hYdpwy_1B5DZiD19hEAKMFtTbh_pCUoACeHBYWDL0ERivZum5zi9du0
Message-ID: <CAH5fLghyDNd1SSL5uTZpSR-5j3q9=frAa=AgUjvap45b-DuUig@mail.gmail.com>
Subject: Re: [PATCH v2] rust: rbtree: add immutable cursor
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Vitaly Wool <vitaly.wool@konsulko.se>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 11:21=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Sep 8, 2025 at 11:06=E2=80=AFAM Danilo Krummrich <dakr@kernel.org=
> wrote:
> >
> > Why not use &raw? Consistency with the rest of the file?
>
> I guess -- it is a good thing, but since we are actively trying to
> move to the operator, it would minimize work to avoid adding new ones:
>
>     https://github.com/Rust-for-Linux/linux/issues/1148
>
> Cheers,
> Miguel

Do we already have a patch making this refactor for rbtree? I don't
think I saw one. I can send one if not.

Alice

