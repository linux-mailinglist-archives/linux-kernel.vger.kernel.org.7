Return-Path: <linux-kernel+bounces-830334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0097BB996C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 893837A8DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9102DEA90;
	Wed, 24 Sep 2025 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kb1tmWjY"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041862DE6E6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709526; cv=none; b=QBQi+gm0uV2nZ9gRPCFDk57brLr2GC5AR7/ODSef03e9wYx5C+eaBeBDaXInGhOLIP7HlKYG26rxnsPt+lTZi/2twm1w2nMMNqqi12up97OUI0QQvm1978TS10U7WYVCFp7sUISvFTXsYdOhE02kDX1NSL3wi/Jpt66KRtfv9f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709526; c=relaxed/simple;
	bh=gQ8E927A4tX2ZNYrTzlCctAB5m47ibJs+IG1u3p+hbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7Dl0zH1/TDreinRWT0los+aEyS8Dz1th4PdO2y4EJSRlMktwiFs81Hl89deOBLzNo4cpGHbZW08H8JAY68xst8ClMrCz3/mlArL4hW5oym7I+jWp5KIuembHYW9PnB6iEXVuceZrwoHAIkcQWHYI2G4RwilWH5OZJidmza818w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kb1tmWjY; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so8627952a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758709519; x=1759314319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gQ8E927A4tX2ZNYrTzlCctAB5m47ibJs+IG1u3p+hbo=;
        b=kb1tmWjYAxZHv1lEtKs53N0IKcqh5YZzGspNXeX//gkxLfgZyusc8wk+0qFHOItw38
         S86jENoqHKOS81W2wGHd6TTkCGehE+p4vf94nilorxKiWUMJt4eZ7/RR5/jfJ+JFvjTa
         n0795byLhWLF0n3lEGyBUbde3qRLhEou8OsZ8l+i0GvYZD7pi5/i2ustfabxeIDY1fPQ
         lf+XOX1z2eYQw8cvm7PgUk8ctP2KVi0dvFgGgBV5eVqrBTz3uoYR63xOvRLusRlRJfdl
         /S7AQ1TIGnVdpywQdcDjeQXGOynu6kX3oP/DQx2FWMTF07vdCANYW5B+o8lfhLpIUpY+
         EGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758709519; x=1759314319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQ8E927A4tX2ZNYrTzlCctAB5m47ibJs+IG1u3p+hbo=;
        b=B9ZxTO/hReRmgZhoNRM7CzzMeLmPkaQdP6JoStYCEU1MOFdxSiCffJFOqV23bigd4h
         ETQtFGbAAeDh0ITSZdMa31DxG/rMHjxOey4ReKC4d6kF+wRmOwBI0F50A6719afoYdeE
         1/cLNfH8tk9TxBhtWD7g9hsYTZWYmIlk5Kf+AlPuDVr6DmOQcNmcI9Wt+905wP1iHfZo
         /f40M8JXjP9QeNqICODJPvcpQsKorzrEEVUelomGQkRFv8VKl7g5gCvmSZgCzLq4BLXN
         n77o7huuf0PBly5Gras+BYEetVflroC+0Pt6YYgwLc95TCMwwT4UAUVGWPqtNqF0snIw
         4ttA==
X-Forwarded-Encrypted: i=1; AJvYcCWWYgzNrWsIQ6MXW+GMnzGJDEwzhvbbotYzOoAszaLeW0/Yonzyow3Gte+H3skOwdc/mL6AMVBU9pSA8OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXhLt3yVSKfeW2sEM5jQjNfFlPXa1N1YFhKhqigVKrP0xw1HLZ
	5hZxycbDC6k6ZZ9+2kzjkloBLjtxbkf3kba+alITAWhzn/1TEeV63P9/VVQ3ACgyR6IwMp05ld4
	1iFrJspQdcE7MhKKBFO6S0Sd+pbkBWr8=
X-Gm-Gg: ASbGncvDc1aYINN68BAZTiP8np4JTFdq4qlQlNqaW8oZJBMAvNJcr00GcYw/ANG4fz2
	Oa0M1ACOYiH1uXHBQHUzKjp+VOBplKCBMgYtcj6yjxI+yo4OpBHpeEXnRCMLYGMAU6THw4L3qjy
	OYfdFAXsWYjPYIaaoCPGIEClEoVNXeDuWNZASytiuj0RW3Jux7DN+HM42/GfRKLdlsVIu6prboz
	w/HHj/P7sjrpebUgan8AQNNJYiNlLgtMfs9Y4Agoalsi+oKGwFb/g==
X-Google-Smtp-Source: AGHT+IE12lCZ7Wl/ftwQJZ/gaWQP8iDkebbGgJsyR1xTOQTAeL+WLTgk8+fgJ+TjcKwHn6/rpkz17KvFRLGM6maxk9E=
X-Received: by 2002:a17:907:3f95:b0:b07:b782:51cc with SMTP id
 a640c23a62f3a-b302cebc948mr516277766b.64.1758709519082; Wed, 24 Sep 2025
 03:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <83171a57-cb40-4c97-b736-0e62930b9e5c@lunn.ch> <20250920181852.18164-1-viswanathiyyappan@gmail.com>
 <20250924094741.65e12028.michal.pecio@gmail.com> <CAPrAcgMrowvfGeOqdWAo4uCZBdUztFY-WEmpwLyp-QthgYYx7A@mail.gmail.com>
 <20250924113653.5dad5e50.michal.pecio@gmail.com>
In-Reply-To: <20250924113653.5dad5e50.michal.pecio@gmail.com>
From: viswanath <viswanathiyyappan@gmail.com>
Date: Wed, 24 Sep 2025 15:55:07 +0530
X-Gm-Features: AS18NWAdKXxMmFRzk01TMU60U3Xy0PNKUuld4uhrZt1ayU1Hp7kGVqqNqefl328
Message-ID: <CAPrAcgMhphs1U88_POpxAeAp0KzNCH6-xuvNiSBa5dn7ceSU4w@mail.gmail.com>
Subject: Re: [PATCH net v2] net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast
To: Michal Pecio <michal.pecio@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, davem@davemloft.net, 
	david.hunter.linux@gmail.com, edumazet@google.com, kuba@kernel.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	petkan@nucleusys.com, skhan@linuxfoundation.org, 
	syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 15:06, Michal Pecio <michal.pecio@gmail.com> wrote:
>
> I think yes, usually in USB-speak "completion" is when the URB is
> finished for any reason, including error or unlink/cancellation.
> "Free" could suggest usb_free_urb().
>
> But I see your point. Maybe "finish execution" is less ambiguous?
>

I will use completion if it's the standard terminology

> I think it's an irrelevant detail which CPU executed which function.
> It could all happen sequentially on a single core and it's still the
> same bug.
>
> In fact, I just reproduced it with all CPUs offlined except one.

My bad, I see it now. I keep forgetting the actual urb execution
is asynchronous

Thanks
Viswanath

