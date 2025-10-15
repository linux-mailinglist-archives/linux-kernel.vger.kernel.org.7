Return-Path: <linux-kernel+bounces-854429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD2DBDE57F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302F4189AC82
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC87324B13;
	Wed, 15 Oct 2025 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+tVgvi2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7E53233EC
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529194; cv=none; b=E4EqYlG6qYSy0x3AcAHGi06tzHjNpyJJIY3w20u0TvGa2Wnz5aDdTbFribElYwP7RAAsHRdl5C86dn2PhcXcGAaQn3sBfMMJoNtZ1chUs+z0E6mJ0sk+SpQNzpzIyqXQohsJd9Ox1yEibfvaELkIU4xD/DkBF2YZlkj8gJMPUd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529194; c=relaxed/simple;
	bh=j68Djg9MIPNj1/yW5wQOpBS5ZJ9KqRr2JdVAjj0PjLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdZYSsrBOrZc7v20zg3H+hF1YlhBsliw+NiDrYEWQwhvmhXwlRVOBuuEUxFlTV0aeSHAZuKUNkriWuaBS6VdUmoUg1ViappX6kosxg9+Bo2P/S4PB73RHI4VZ0qeTzDhpIwzvNzJfeqlHYlBX6vA/0ql5oSCKFJgOQY5YPiiK68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+tVgvi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D5DC4CEFE
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760529194;
	bh=j68Djg9MIPNj1/yW5wQOpBS5ZJ9KqRr2JdVAjj0PjLU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M+tVgvi2vPNEUpRiZD4fZpAU6hFYWkRPhQbrGFcZCZ0rj6U5K3NkppqPdChIy6jw2
	 thRVFWL46oNpZJO5WI2ygN1d7vawJmGga5Np2nchNCWKm/Jhb1yZcqAjoKQvlAU+MN
	 IyXrG+RnBJWOkIgLKEppP8vDbS/26E8D//QCqc28UgIU9kw5kn+TiTZjumekG//lcN
	 dKvQFQz2KeQUy8aSPJi6e4/hH0EQsH+bhpYzjA4FVqmtgcyXkSuGac2s2x4Hj0AueU
	 cTKpNeAEMwveihom1R/vjbQcWOwQcHaa1ggOYnUo8Be6c4/xzsHkWzV6z04Ct6WnGK
	 OJ05/2UTKKa2w==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3b27b50090so1194576566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:53:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWeq7e210/FKEsa8FggMaUfnW96i16YosuN7iwysUjA/AT0BsAEDGC/ejFjKUhMEtpzK/zUYU4Z1EfsU9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGdlBDZYfjh5A/uw9XBsOwjqMihezrI38khwJdRMKwm3gdMGte
	t6GH65uUznKaWcrrqqWqqNytpDsSTEsXvJKPbOzOldrPy1gegyqpRb6jbOGHe0Pt4EoJrRwQeb9
	EqnJMNu1WNaLDWPDSnVdej2n0TMtR8g==
X-Google-Smtp-Source: AGHT+IHpBsZoPqy1azuK/vjwTS/jNRB6fTmD0NvYAu3GizHlrEGmyD/1vlyW9f+VRJsbJ7v4OWHL7IrqoHGxFu1lS/8=
X-Received: by 2002:a17:907:724a:b0:b04:5b0a:5850 with SMTP id
 a640c23a62f3a-b50ac1c3f18mr3099214366b.40.1760529193310; Wed, 15 Oct 2025
 04:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010183418.2179063-1-Frank.Li@nxp.com> <20251014-flattop-limping-46220a9eda46@spud>
 <20251014-projector-immovably-59a2a48857cc@spud> <20251014120213.002308f2@kernel.org>
 <20251014-unclothed-outsource-d0438fbf1b23@spud> <20251014204807.GA1075103-robh@kernel.org>
 <20251014181302.44537f00@kernel.org>
In-Reply-To: <20251014181302.44537f00@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 15 Oct 2025 06:53:01 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+SSiMCbGvbYcrS1mGUJOakqZF=gZOJ4iC=Y5LbcfTAUQ@mail.gmail.com>
X-Gm-Features: AS18NWC_gYw37Br6ewmB14S0Rj55MCQnT2_L9wHXys5hY5S_h2Z178AMbZOAzBw
Message-ID: <CAL_Jsq+SSiMCbGvbYcrS1mGUJOakqZF=gZOJ4iC=Y5LbcfTAUQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: net: dsa: nxp,sja1105: Add optional clock
To: Jakub Kicinski <kuba@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Frank Li <Frank.Li@nxp.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 8:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 14 Oct 2025 15:48:07 -0500 Rob Herring wrote:
> > On Tue, Oct 14, 2025 at 08:35:04PM +0100, Conor Dooley wrote:
> > > On Tue, Oct 14, 2025 at 12:02:13PM -0700, Jakub Kicinski wrote:
> > > > The pw-bot commands are a netdev+bpf thing :) They won't do anythin=
g
> > > > to dt patchwork. IOW the pw-bot is a different bot than the one tha=
t
> > > > replies when patch is applied.
> > >
> > > Rob's recently added it to our patchwork too.
> >
> > And the issue is that both PW projects might get updated and both don't
> > necessarily want the same state (like this case). So we need to
> > distinguish. Perhaps like one of the following:
> >
> > dt-pw-bot: <state>
> >
> > or
> >
> > pw-bot: <project> <state>
>
> We crossed replies, do you mind
>
>   pw-bot: xyz [project]
>
> ? I like the optional param after required, and the brackets may help
> us disambiguate between optional params if there are more in the future.

That's fine. Though it will be optional for you, but not us? We have
to ignore tags without the project if tags intended for netdev are
continued without the project. Or does no project mean I want to
update every project?

I also considered looking at who the email is from and restricting it
to the maintainers. I know the netdev one doesn't do that either
because I used it a couple of times. :) It does seem like it could be
abused.

Rob

