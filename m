Return-Path: <linux-kernel+bounces-753840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E58CB188CF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95D2566EC4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5067A28F533;
	Fri,  1 Aug 2025 21:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c+Hx6hGL"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A7328DF12
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754084078; cv=none; b=bIm3fLDgDWeDBIwww2e0HkVyUDjRn/EaZAExJJjsKw7R5PbQXkPPkgGIcjhe4PxbQbdL/L4RLgb7bonlxrvQhSZnMmpTNzcgBSKKbgM7mh2MOsmOTJ2X3j2beBxxcqiHTBh/onUA2/xPYGsiLH7ehaYbfMgxc7w52m5xeXHoi3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754084078; c=relaxed/simple;
	bh=IZkwXQkh8YxYF6KhegHig00grekwiuruDFNARhibles=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1Nq8AJvu1iqTLTT5YtD7B55+pG5Rjg6Bzt2JY6awfgkvmRIwtFdOlKhZpMg6PPRNB4kz5zLIoSDL0MZQI/zhhjNV6cbbvakHGMPYa66VJLQa392KP3dnAbENpXAFFzFlqRdpPdZbI5rraMkzVkqB0JtaspIakMF0yP1W/xmqHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c+Hx6hGL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-615622ed677so3640220a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 14:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754084075; x=1754688875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WLFHL6fOZFPNrc7teT5UWCBGBPE4FkQnF2Ru0J7QGa4=;
        b=c+Hx6hGLh+kDdCrVOa3MTjlzWvD5xwZyeita2x8PukmtOaYfy8dxJ6+Ouxc549zWHe
         /1Dmau/QeWpMUqnjGpt+Krq3qzcJQSm+UjBcz91IJuu4bmnoyA9xAEP6A1vw2uucPAVH
         I8jRvDs7l9l1dX+O5KIpN05BbMDvk0+55534E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754084075; x=1754688875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLFHL6fOZFPNrc7teT5UWCBGBPE4FkQnF2Ru0J7QGa4=;
        b=gol9c/ln+M3m/2DAq+thy80tUQCyggnwx3bjfujebkcg+C4Tr2bVSsdVQDK6mGBGeN
         fcrJL5htllAxLMQlYSil469bMw5/bndJfQohw7wjJZxxMx7N8oIcKPiwfweDjIRNuUMf
         7opDLIWpfomx9mCMR8yt4BPrHrQH94Um8T14npNKC2xySnn8kAW4IUOxbARc3WGTYsaX
         R/vtkAlENWVmpCNXg0cKb8WpgkmB6H7ztNDnX2YhII/3mUY0aefU6v7CHTAdaq+XudCN
         yIfQi+bDMx+oLdgtgBUCJ7UP1eWee4inHFmHqTZrxzMqtemuUHGUi98oOrsTKezcOZiJ
         Abhw==
X-Forwarded-Encrypted: i=1; AJvYcCUjbb6GNCaZ5WA6NbgHQPuXt6ZSvP0OR9K3NF5ILnjQnLsstbh8/0UZ8hs5q4hx+kN/iB1rSTAwof/O+eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbTe7IfCj5y/2eR8c2oO0EyDaBfKD8FFpH2Q01XJrcD4uBbLje
	U2Do+qPlKbJNW0e18woCHV4Gl5ln2VO4UH3XZwwBEFlX0LRvinchDLvWkioZ3+Mtd4ASBdqalrR
	4gtuuDPE=
X-Gm-Gg: ASbGncsa2RK7/S5Q94yHKC/41+Oq9+O+WvTvVlNSv2OzZ5KuNA6ECFgZzDaagHtnCCs
	amuYnzoTfflWHebgAaH0HV8XGCmAXgpbNGH6n91YlRv6UZdBxmyVta/K0a56pBoPXxCAyo00Y5e
	nC02KgKyJHJGndn5Pqb6BFK0LBDFAMgII+b5SMFSOpRsWMb4wbSsjXgIy119611QhdMdIMXb5ln
	KFeDU2Ybvj17UAYtwWZYGiBw/PQu4b9DojEgLDoVCCNh7v4677o5cYg4n/ao+NTTrEcTSKGHH3j
	At3X1erY685PYhbY/GVBTxsUuIueCinD0cgtKDPZS8nflN1DvaEK0uu5r6htSnv/rQZrMWjYAoM
	8RPLD3SO3bv7zDoB95lz57M93m/qfp7CecEuCgteSXrmrcxpR6uSzWu1YyThh+aYIseqhFyWaNH
	THiH8P2ks=
X-Google-Smtp-Source: AGHT+IFK7L1Iligq+isS96Bye5GZLkNsqqmekLYPNk5eA3gqsZx86XDnF2RGVnC++YXADoLFT793rw==
X-Received: by 2002:a05:6402:5192:b0:615:af6c:3bbf with SMTP id 4fb4d7f45d1cf-615e6ebecb1mr674313a12.5.1754084074913;
        Fri, 01 Aug 2025 14:34:34 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffd72esm3250935a12.55.2025.08.01.14.34.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 14:34:32 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61592ff5ebbso4407471a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 14:34:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVj5oQCvcFIMiQH+uHprI8KmkB13DsLLh5OkhkpA4fTvqHZvJg3NMngHH2oC7XaqAE5qF4ARKHBBz8gD48=@vger.kernel.org
X-Received: by 2002:a05:6402:2790:b0:615:cc03:e6a2 with SMTP id
 4fb4d7f45d1cf-615e6ebec77mr689309a12.1.1754084072420; Fri, 01 Aug 2025
 14:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801091318-mutt-send-email-mst@kernel.org>
 <CAHk-=whgYijnRXoAxbYLsceWFWC8B8in17WOws5-ojsAkdrqTg@mail.gmail.com>
 <aI0rDljG8XYyiSvv@gallifrey> <CAHk-=wi1sKCKxzrrCKii9zjQiTAcChWpOCrBCASwRRi3KKXH3g@mail.gmail.com>
In-Reply-To: <CAHk-=wi1sKCKxzrrCKii9zjQiTAcChWpOCrBCASwRRi3KKXH3g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Aug 2025 14:34:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRtKY+tk0mhnHzrC0YMXef0GtVUFQ6cGW0-4XS30mQ5A@mail.gmail.com>
X-Gm-Features: Ac12FXyaANs0webz-gagQ0r78-lvtho7QphOSO_s_LZu61Rm94DR5P3bHuE7Emw
Message-ID: <CAHk-=wgRtKY+tk0mhnHzrC0YMXef0GtVUFQ6cGW0-4XS30mQ5A@mail.gmail.com>
Subject: Re: [GIT PULL v2] virtio, vhost: features, fixes
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alok.a.tiwari@oracle.com, 
	anders.roxell@linaro.org, dtatulea@nvidia.com, eperezma@redhat.com, 
	eric.auger@redhat.com, jasowang@redhat.com, jonah.palmer@oracle.com, 
	kraxel@redhat.com, leiyang@redhat.com, lulu@redhat.com, 
	michael.christie@oracle.com, parav@nvidia.com, si-wei.liu@oracle.com, 
	stable@vger.kernel.org, viresh.kumar@linaro.org, wangyuli@uniontech.com, 
	will@kernel.org, wquan@redhat.com, xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Aug 2025 at 14:15, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> My apologies - they are indeed there, and I was simply looking at stale state.
>
> So while it's recently rebased, the commits have been in linux-next
> and I was just wrong.

Pulled and pushed out. Sorry again for blaming Michael for my own incompetence.

            Linus

