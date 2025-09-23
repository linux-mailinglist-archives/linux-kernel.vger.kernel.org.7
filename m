Return-Path: <linux-kernel+bounces-829610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DD6B9773D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657212A5200
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE60730AABE;
	Tue, 23 Sep 2025 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FbT1835m"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEBC2FD7BA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758658306; cv=none; b=EDVUWDBBPN5DD2AoZSKxjINx55ujuRbtROCGXvzMX3M45pffibJxgJXwEM4i6hd7G5/J/t17vovIZrJWWcylEbbr9uCtMJIZI5uitsPqJcQIir6aDFFgiqPKcARqmoy+S5TbpSMxfe09CBlkwZ/NPmMdthJfdMNxZ46VAoSBiw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758658306; c=relaxed/simple;
	bh=JTP+YEG1q5M0peS7PLFW88111RMYmHr0walTvZYiwtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hmf4fI+wkmKTDPW5tac43AJNrBrYPljnuRwwksRHM8E7FagyJzEpwm7OYzTseNbvGLNWQOr5s9lUzWM0+S4uHS2ANgrvlFF4hcthvayECNCeOelPVJOUqfeyfpg6hS0yuijMRRFlG/XHm/aK54jMsfsaYgP1/hWfy75GOO9s5Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FbT1835m; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3306b83ebdaso5210166a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758658304; x=1759263104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUa4pObT86h1jy2D2nCUjbk/1KGY1/f7404WMtXBXxs=;
        b=FbT1835mijmeaAO7VocKZXUr/Q6icQEosDqYzGJhWdi9A0CqCqjxDYES3BkFKmnjex
         x5FcFRkD3x9ARqqa8dUjPYi26bvgQ8MLdbZRXi1vd3GUgq8HA2fhmcQf3TbU0ORlyazR
         SNyzQEqw0tUjN3cZ6EpXrGA58nRfNn972erTw4sMiWe/s3j/F2BsEYGMMtPHB5ijdVES
         G82xQP1PTAOKnwPvti1P8tq/JblgcOYqgd5866I0BeEk/az/GEfwKyItp1Z2qI5jx7M1
         ZGPT/SfM7Rqt0M89mVfw2Bw/tJu+4KiDF+eUcFlYfJmJCBnaoAEqbo9bSMh4tVyPEZQ+
         85MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758658304; x=1759263104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUa4pObT86h1jy2D2nCUjbk/1KGY1/f7404WMtXBXxs=;
        b=M8Gf9ugOqGqgjkuBtqy0tEZTVKWFbe0YQu7oQpOqA2IhkJX3TVyhoQ8tSrtFh09elV
         plCNpSQAQxvIiBp1edkQQGmTM74l6/UQnhqF84Yd03NmgDQIPTnMJp28bMJdOv8Q8FxD
         WkJaQ6hd3qwXBYNnGAGMFsqtailf7tnMZ7ovXpv+63eEZ+LkW/dWnoFAE3vdXC+YRA6t
         jLlHOFBZKbL/AuaKUL8BTHzHr5HryVaUCfxi1cMLNmUJEaveqGNZ9xxKfACXogY8LOB7
         +dQ6CYq7cCLCudeo/GikYHnHBhdNBpE7Akume0yXwO0CR8hJY+U9zd6vOjLJtnl4qIR0
         m+Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVG+HJH6qUZTKxkwIZItdWvL1+mxA7d3KcnkFkKG4xzMheU+FnsEktEAznqty5fBQKKxnHtqAQrlkimE7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOL7jVnS0goX4+S/HOjpb0EgyTneQHQw1ywKh8ZqSxAO7tSZXZ
	WNPQI6gq7X4xZkExva9/ch2m/UTSGTHkFQ0jYxlT548+HNfMt+Np0ACTH3J6BwfRXRi3DwNaeHI
	6541Mv+lQHb2FhBhWyE64uhF8QHyQWomLmd242BdF
X-Gm-Gg: ASbGncvWmaGYJDI+orIeJLN1nyOa3YO6yixJG2xDo0VgS2ivUsgZ+1J+zdh+sYoQqxj
	+NTpRBsqOWNCJIRha143MSa8eCLKADmeLVbRfrwUjOWyMHSkcHFSTZ4Uf7+DluMLeae5hOiVd5v
	1HhmhQdtSocogBsjlo13S8Mf2xaPS4LcMCiZEJOzTAPr+STCORWyqO0kEEw7DMusvucbyaXtDkl
	e6782w=
X-Google-Smtp-Source: AGHT+IFfr973oj/4RM14CnqVmiX2e4PE3O74vfP5owIc23SKETKDt7jPpQDpXbNLtGzX165ba6mvtEDFXWf/gKTzrCI=
X-Received: by 2002:a17:90b:2e8d:b0:32e:d015:777b with SMTP id
 98e67ed59e1d1-332a96fd52fmr4559524a91.18.1758658303649; Tue, 23 Sep 2025
 13:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922200942.1534414-1-rrobaina@redhat.com> <p4866orr-o8nn-6550-89o7-s3s12s27732q@vanv.qr>
 <CAABTaaDaOu631q+BVa+tzDJdH62+HXO-s0FT_to6VyvyLi-JCQ@mail.gmail.com> <aNLcbUp5518F_GWL@strlen.de>
In-Reply-To: <aNLcbUp5518F_GWL@strlen.de>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 23 Sep 2025 16:11:32 -0400
X-Gm-Features: AS18NWAxG3daqHqw7bG2TIx-RGmTbVgn4C6ruCnGJ7CCWQmmYWHkT-7bWgCbXHA
Message-ID: <CAHC9VhSJGas4uUivmOvncyTcC-UZkdqcqkVKPzDAQL8oGkSr-g@mail.gmail.com>
Subject: Re: [PATCH v1] audit: include source and destination ports to NETFILTER_PKT
To: Florian Westphal <fw@strlen.de>
Cc: Ricardo Robaina <rrobaina@redhat.com>, Jan Engelhardt <ej@inai.de>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, eparis@redhat.com, pablo@netfilter.org, 
	kadlec@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 1:44=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
> Ricardo Robaina <rrobaina@redhat.com> wrote:
> > It seems DCCP has been retired by commit 2a63dd0edf38 (=E2=80=9Cnet: Re=
tire
> > DCCP socket.=E2=80=9D). I=E2=80=99ll work on a V2, adding cases for bot=
h UDP-Lite and
> > SCTP.
>
> Thanks.  This will also need a formal ack from audit maintainers.

It's in my queue, but considering we're at -rc7 this is a few notches
down on my priority list as this isn't something I would consider for
the upcoming merge window.

--=20
paul-moore.com

