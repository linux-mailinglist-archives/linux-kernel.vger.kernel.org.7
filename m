Return-Path: <linux-kernel+bounces-819185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0465B59C96
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131E6324174
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C6D3705A7;
	Tue, 16 Sep 2025 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="H55oyeaW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529D03570B4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037997; cv=none; b=TpDNe3R+sn6xRY8H6HpDcQQrDDZeqgmVYwLFCY/FQS6civnwxjrR+V3hUMmRsVmYHxQOkf3r+LWj6XqRCYahLuibMRI/UTikh87HNBrZXoaExqbjRbtk2qXxN/oqgBoRRbdSK3sXnMvjO8iO267cuE0lihx0gfScnaKsr7qvMkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037997; c=relaxed/simple;
	bh=QdhsLLTi6x2P00SOdHfDzgBCCPRrEZ2OxxiHXGo3X0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJ22FYPNlFkGsNbOGuMAyhDIjAyqOtoU6vqjmqDfXDdTnCpvMJ1hRAGOCCyg5emlRnz4ebDRujbzJ8hHWHX0Jc0amIRNGFF5r4JhmBcU+qgep1BhWopqNkEo6WrqrP/kTpZnGmMRkIpVCORAg/8MvaPkhi9p5PMFyARKK9DvWCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=H55oyeaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DF7C4CEEB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:53:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="H55oyeaW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1758037993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QdhsLLTi6x2P00SOdHfDzgBCCPRrEZ2OxxiHXGo3X0U=;
	b=H55oyeaWjML93nNQVTWuh7rT6YX1P61S2Dhz77e91JuQjlzvZTw1SqL1oOhgOnbzbXVzjf
	lBepXGG5uizyEm2OggZsooXC5KUCOjngNwQd9jwbXDCQAiEYsjJC8lxG7qLao1O1JK8IXv
	2doy5ngRPBcWsrqAj+QeNQy9rhXLzls=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 12170c4f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Tue, 16 Sep 2025 15:53:13 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-32bd4f1b671so2488fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:53:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyP+BDBnhhXAo/+JJVWoMqQiXWMiKsSj/v4M5MAyGDTH8kHqD3du0KWww6BcEK1JRta/iOFQi50SUcxDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs80z5lP0RhTHZOgJ1AnyVL/qH1j5C7qj5447qg8sT+f8U3xQL
	uA+wOxsTTQ7ZDROvSHtKpMWeb6rIe4kgfUwjFQgskj13SfBC/ZkMjzVpOsUcG9yA8UsAfsAti77
	7jjdQ0ySxHO0zB2HvT0Yp6oLsKSdoq/g=
X-Google-Smtp-Source: AGHT+IHIsWlCqXP6w2ex+u5oDjE8Qk5JpGJiSn5HO81iROUQUIe3rwbuy+iUOnTAxJz5JFUcLFFDPdjI0OFKgCB57WE=
X-Received: by 2002:a05:6870:15c3:b0:318:70e5:3ce with SMTP id
 586e51a60fabf-33453569978mr1595607fac.21.1758037992013; Tue, 16 Sep 2025
 08:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915144301.725949-1-ast@fiberby.net>
In-Reply-To: <20250915144301.725949-1-ast@fiberby.net>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 16 Sep 2025 17:53:00 +0200
X-Gmail-Original-Message-ID: <CAHmME9rf9NGRVtJBnjUJVPraGKL6dk0nRxzXmSi-7X6Y1zjmsA@mail.gmail.com>
X-Gm-Features: AS18NWDjjoLajNux7GbGPgbtVGxD8CQj2DjICrmFvFsHsH0-lOTbkqsL1kkKnR4
Message-ID: <CAHmME9rf9NGRVtJBnjUJVPraGKL6dk0nRxzXmSi-7X6Y1zjmsA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 00/11] tools: ynl: prepare for wireguard
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>, Sabrina Dubroca <sd@queasysnail.net>, wireguard@lists.zx2c4.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Asbjorn,

On Mon, Sep 15, 2025 at 4:47=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnesen <a=
st@fiberby.net> wrote:
>
> This series contains the last batch of YNL changes to support
> the wireguard YNL conversion.

"the wireguard YNL conversion"

Did I miss some conversation about this? I figure I must have. I must
say I'm not too keen on wireguard (and apparently only wireguard?)
being a guinea pig for this.

Jason

