Return-Path: <linux-kernel+bounces-874704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 797F1C16E5B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C801A687D6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EAD350A31;
	Tue, 28 Oct 2025 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XX/GUnf2"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9B92DC78B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686085; cv=none; b=qGlBzUAJNiovi+Jhkwks3RUQLLfqZK+m9y8yruUyO38Yj1zqvrqHOb1beHDCBU6PMJkFYq0u1IJ++Dy0pjqHX7/e4iweUjpMDa93OmJ60i8eZX8ex6K66dMZYaK209yVC9J3upECTMaaG4qRe/F7TJi13VwsUiFwgAbX1PnSMYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686085; c=relaxed/simple;
	bh=DH/vjr1xJnlnDcFd7bDABFJGNE8f4srzny3zaaOtqPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6zrDW6R+1wtxoCQLQWbXrlVPEhKB3uboli03FpOT8eTMPpe5/qD2Gt062PyfRreuf5pxaPcWBy4X6/sofAzthTMjnfaG8Q745wPmDrUVtXz3ikUGJbaWbLTPnoyvP+kPhQuT0OFguKgGgKWpGuq6C0NrfUt+BWf3im8CA5Q+T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XX/GUnf2; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7861978aca2so5593297b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761686083; x=1762290883; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z/gHqxUO2WlS5D6RSGbV1tmzbakm4fCZt0obMcOQyEQ=;
        b=XX/GUnf2odQ6UmbazRq4Uk4ojI2N6Q+SdrbRSG/N1jIuRuDiHaCpaopZ6oVTOzhgTX
         W3mN2oDXAsoh1LkXu6cj+EYcTwJqdl+jiD9H2tvhKVBzq920gNjpjy0nqG4WFFgr4k/J
         wbff3mSk5qZ9JvyvsSUQxjLg+mDsoXpSGKzO9YAGhRS5twj3OIXbVE0ttwmNVjOeJvyY
         QViu2xSfdJQBZpjasEAUpRA9mo5/Cj6asYjM45tWCNO65RN9lG7Ka2myz0tfiAAomRzV
         XrRSEKyZqXeqlR6ryRYY4NmoqCTbnacpyId13H5FDv0aF7FFAVinGUY0MI6FkanHWBU1
         Zb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686083; x=1762290883;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/gHqxUO2WlS5D6RSGbV1tmzbakm4fCZt0obMcOQyEQ=;
        b=RAEoUG3IYBoAzpIWEfVkv4mff1akNRvi0eRi+qRAWM3Sf58//mqd3IKs9HIFv5EKx/
         BG+eGDZLAIPOpUUTBRv9BCubK3qv+P/7Kh6dYUF4idXv24mpFse+MffiALr4AeyvVwIO
         vfD+6slFc3TrKhNeDP55uhda/zp9zihTmumzayysWKNb9IoY/Lv4bG2cvJRTRupj6iwJ
         MixD7c00KUhNrTeLwzugnI7TqNstRwdQKxfrcLHrVY5shgGIUWWgpumnSpoJ1RrIemRF
         OwuUc4mAJTgJms/KEVvzxCta72VoUeQnSR/KslCJKIGVDu/IFWTJV5asMRT1znKVF5rj
         oYbA==
X-Forwarded-Encrypted: i=1; AJvYcCXlW6uhySprdGEUj2pfZx1+PQITJ0GVRvgRKEjxmNhDXCXv63I3eaVMuCGlGUU0YkOvNXZ94EXnq7uvI0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2X3xUOjLxB/EUhSHlZgXaAYoXrAHC9/bq4ShLAzkcRerYenRD
	zWtHWaWyZXEZVpMM+f17DB8scMlhUoZTuE6BNXbwcU5Em1q+89ACfK0x
X-Gm-Gg: ASbGncsFVOzCcEhG/AdhUZFzq59AmEuxC/8Ba6DO2n9cI5pByJr6IDG4Zhi/IeHe6dR
	vUAMFYkfAJN9T6US/0Zib9u0ZgkVWktNnDJtoNOpiZBafiYQsUhYB1oLAUi69T2BvAq33xkg5b5
	x7a/F/3JjYPq0zzCuaynVq9NZmcfvlhQeJuQfTOBIku9C2KuMloHPkRSAUdxxfJPlN82r0JGC4G
	BrZMsbSYlHNSgxjhIuBtZ9+F+q6lG+djO7BMiu/LYcsHtaThnbROGA4ifkUGt1pFa9OcogRDHLu
	2bzH1uOgRgK/rmDi1h5Ornt57aRg4oEHaskOHWfoM8YFG9wPMBWElqugJ9lGQ+UvjaTu1ag22UK
	aIiFA2i1qeys2ATkKYx4NwWmxMnBcLOVaTxC9F/DQ02ljnyE75uVGFmo4gJbqfHvR6F+f+B4wqi
	Q+74MLbzJVUQgXLyr5dXONzNJXDatCj+apiFG1
X-Google-Smtp-Source: AGHT+IEKHk9Tj7gTL2kHv59PTJwI76uKFohRHRAHgq2x+6XnRzw5DJhCwK1ZxK0k8M71IYtw6Ct0pQ==
X-Received: by 2002:a05:690c:3604:b0:780:ff22:5b1e with SMTP id 00721157ae682-7861904ca66mr49752757b3.14.1761686083091;
        Tue, 28 Oct 2025 14:14:43 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed17a1e7sm31020997b3.12.2025.10.28.14.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:14:42 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:14:41 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 4/4] net: add per-netns sysctl for devmem
 autorelease
Message-ID: <aQEyQVyRIchjkfFd@devvm11784.nha0.facebook.com>
References: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
 <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-4-47cb85f5259e@meta.com>
 <CAHS8izP2KbEABi4P=1cTr+DGktfPWHTWhhxJ2ErOrRW_CATzEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izP2KbEABi4P=1cTr+DGktfPWHTWhhxJ2ErOrRW_CATzEA@mail.gmail.com>

On Mon, Oct 27, 2025 at 06:22:16PM -0700, Mina Almasry wrote:
> On Thu, Oct 23, 2025 at 2:00 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:

[...]

> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index 8f3199fe0f7b..9cd6d93676f9 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> > @@ -331,7 +331,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> >                 goto err_free_chunks;
> >
> >         list_add(&binding->list, &priv->bindings);
> > -       binding->autorelease = true;
> > +       binding->autorelease = dev_net(dev)->core.sysctl_devmem_autorelease;
> >
> 
> Do you need to READ_ONCE this and WRITE_ONCE the write site? Or is
> that silly for a u8? Maybe better be safe.

Probably worth it to be safe.
> 
> Could we not make this an optional netlink argument? I thought that
> was a bit nicer than a sysctl.
> 
> Needs a doc update.
> 
> 
> -- Thanks, Mina

Sounds good, I'll change to nl for the next rev. Thanks for the review!

Best,
Bobby

