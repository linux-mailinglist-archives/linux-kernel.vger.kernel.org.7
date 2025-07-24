Return-Path: <linux-kernel+bounces-743428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9C7B0FE8D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 04:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22D53A35CA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2C8192B75;
	Thu, 24 Jul 2025 01:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XaojIzGj"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E701946DF
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753322391; cv=none; b=udteOLcRkLIVNNPYbClPx3a0JAs0Nh/SzUib5sUIvxvRxLbP6iY2Iknx6SnhAAWfGDRHVrKV4vkJFnjbV3/OinEFdF3FZfMStE9dZSG/NYcQoAqbrZpkCLxMcFNbDNYiXticB412We6PrEWgSYhnC0eXf538IcwjU9I+E5OFN0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753322391; c=relaxed/simple;
	bh=LQc6ia5Ttf0UF4TlP5SysjISVYvdpp6f5vOaMclCMIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAutR58r+oAJ0B5MpsG4B3uPINzrqEO/It/Lmz8zyqts8OwUpw7KhH7ueJkg1/g9DujkqILVuJlPLvG1wwGND/rXW2fAFfxuGHqWqiccotdFR5oDwRNVdvlZmhB+sjMEPt5aokkcniBYE/lNFujZJGT9g6FswqsZg6MS23ge/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XaojIzGj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0de1c378fso62625966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753322387; x=1753927187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pv2/YAjQGx18dZmEkcBB7XSK6g1uvGZpGDr9HxLVLZs=;
        b=XaojIzGj2yxLATeOG9V392lMZybhNs8DSgBWsQbQaEvRylyShPm0gBLPCEkYitXxyE
         l9qyFoCfEdGEOwNXvBduRo4Ox43YQKqXXECiB14NTchopvBupZNX6AhLGMbTKZXagR8j
         DUAJ5oxr3pmvmyeXbuwnYrBWHQd+AIW4lXNb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753322387; x=1753927187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pv2/YAjQGx18dZmEkcBB7XSK6g1uvGZpGDr9HxLVLZs=;
        b=F4jx6RlpuU9gOmjJvEganEj198ReUGRjD0Lc3Ui4GJ3PKtQuaCQfHdsrM0q+nAwjHK
         wKwFfTf6WKmaTj0ZOYkc+SPspL7PVzbAIYY99Ek0jzrqUJQd8mp+7l/+dleJHXxUEj0z
         zuekSH5eu3vEKQe39jo5jWiKhGAic8xxoji6eVQRxs02TFipOnBaW9gPdwB8TYMKbtsL
         3pv96vIFMdi85FqVCZJhGJlEtxZG/7IQkZv8Bh4Y2zfVlOwLxjbWTuag05HERlW4YLdB
         LdIyGce0hPK6MdkzEe0lEI1QWTgR/9wCRosjyTAf7676GHZUEr0HThWjghh4z4qCvVZ/
         2IDA==
X-Forwarded-Encrypted: i=1; AJvYcCW2pKQerWmo73wvp9Whj1u5aULTO1LjFyTO28bhhDMlYvz9l3kbis2jAbvIC/b8fC0iQsHC8jQXB8zA2uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWCx620ocuJf50/JZtmupeANGmBxXyloBHy1TMSQfHGYU4XDwx
	XMrih7qTfPjFyPe+44jw9vkx2ldtoF/WpGaLOlxF1nWzNShO535qupwfgBWZ83ug07pcUuxEDhs
	Sy9Kuh+MXuw==
X-Gm-Gg: ASbGncvRYw6fI0USnMd360N5tZ6LmntEZznaaBCCl1ozpLvM2njRkBpmZfjz3Scne07
	SESmsB0GoaGELt39O2x48nsuDBuAE31mtVYBtb8ML/DQzFUvw1yQTeG3uyThLaWoWjHCu1IRerK
	5qvPVavwoeE3I0729YlIXGccD21SyezljuhJxZmhyPSMOkJQUc+A8E6qq4m/N7FB1PlLcAZBkz9
	7eyA3Wd6x1GwhUbi7TAFMLb7t6dwwa2pgyGinlUZJOZ70wa9IbWXSWp3z6TdU7Kf805+fPcDeHr
	+OaGxAsB7t87AgiwmTDgbxTRdFZNG6gArN9JuDioc1vnvc4k/VYteT2tmAaGAk+icj+lBvDspGP
	JXvZFSSu9AJd9EOEPBQwG4dMm6PmhsVgaNIa1oZQ/OgZnY8XCmKcptdr/3scVKnBR95qMLRUu
X-Google-Smtp-Source: AGHT+IELUCeTFvssSwtLfBNDDH/eDqH+4Jtpex3/hRI3u4xptiCqb3nw6z8NzMnvxiR1eqzy+malbw==
X-Received: by 2002:a17:907:7ea3:b0:ae2:9291:9226 with SMTP id a640c23a62f3a-af2f927ac3bmr418621566b.59.1753322387431;
        Wed, 23 Jul 2025 18:59:47 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47c58bb5bsm37326466b.20.2025.07.23.18.59.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 18:59:46 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-612b67dcb89so913481a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:59:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlmVeD1BYBD/aAoYo4vyRrsK8c4wBqWI5KdHeIbfy+gvM54PfgNRIblXqHCbmgQ5b43DVzx7B4yv6ah0M=@vger.kernel.org
X-Received: by 2002:a05:6402:4404:b0:608:6501:6a1f with SMTP id
 4fb4d7f45d1cf-6149b415545mr4129336a12.1.1753322386209; Wed, 23 Jul 2025
 18:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9twUCJj4X-2jf0VG5+A2YN9Gk8hjOAhJ2hxq4SdgZfvtMA@mail.gmail.com>
In-Reply-To: <CAPM=9twUCJj4X-2jf0VG5+A2YN9Gk8hjOAhJ2hxq4SdgZfvtMA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Jul 2025 18:59:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLQ+EPeV+JzrvkPWt2jeteqwsRkf-X61jjfV8pefgXeg@mail.gmail.com>
X-Gm-Features: Ac12FXyCiDBFkm6GlVYN3UTcVigsgGQehFrUCzri7NOS0-ukmGslf3n2m6dCQDc
Message-ID: <CAHk-=wgLQ+EPeV+JzrvkPWt2jeteqwsRkf-X61jjfV8pefgXeg@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 6.16-rc8/final (resend in txt for sure)
To: Dave Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Jul 2025 at 17:40, Dave Airlie <airlied@gmail.com> wrote:
>
> (this time for sure, plain text).

I knew you could do it! Third time's the charm!

I hope I don't need to worry about the branch contents as much as I
apparently need to worry about your email sending capabilities?

            Linus

