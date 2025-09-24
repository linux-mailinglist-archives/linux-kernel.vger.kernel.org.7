Return-Path: <linux-kernel+bounces-830115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C809B98C10
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B544C3843
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77A52836BD;
	Wed, 24 Sep 2025 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnp4wJ7o"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D03D28136C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701270; cv=none; b=F14Uze44ECqKdrDDaUaAd2w2nAFGF3TJCo1R0I6gipBkaHfcmLky3EVaZV7PM0nsTgn7EIkbY8YqlLkw/dauzRxUwjcXFsb+r2cI5z0QmPUtzXujYHv3NHwkmoXkblyFwzo/E8+VEJLB+lzcjNPadfyFo9NC5GzKOVIlYKLiUjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701270; c=relaxed/simple;
	bh=CPJFhlS86lHjQ8Ti2XaTHsWA+1yz9pSmmfGw3hKwYcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+Ho4NIGVSidJQPKpx1nhTUoRA/tH1qNUVOflZVOP7CGWlm/l6O31cTJsmko9dFGR5OyHkF+LuGXMnlGOHO8E8+v1BUTRdrsfLtvF7Kp+wDld5XDVUi8LVkc6h9ktFh7az4Ltt45MNUm5Q73elRW4b0HFuoYg16EQLw83p4xKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnp4wJ7o; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7322da8so1172664566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758701267; x=1759306067; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CPJFhlS86lHjQ8Ti2XaTHsWA+1yz9pSmmfGw3hKwYcE=;
        b=fnp4wJ7opiJX1+q2nsrQptUKXzAnZRKZg4g8saYB/aUadbuHQV18LvkD45Krh3hDRz
         kz+GDpHiyI0VBc+MayLeOnRzjJ7IXYB6Pod2t8XJkOtQfa9qg82Z2JuP+RfPfnf/AiRV
         grH3iZPSRT4EEfNc8/2MZhihK9H/SqM+FC/R1IItW4+i38QU0Ct0Gmkd+ODtRhocuQHz
         ZnK2BRTNDWnEhz+2Hj7LX2agSpMjUgO3tvjUwCRCB9eO4huo5J4iqtcQ7Tz1zMHr9lUP
         1bIGafWHzsGQ39i6FuQDJxluLVIqWk4ws7B/s4sg+kYS1LNgF8vrYmfpLCRCUTj6H+Au
         +Rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758701267; x=1759306067;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPJFhlS86lHjQ8Ti2XaTHsWA+1yz9pSmmfGw3hKwYcE=;
        b=VitvofD5tu3nvpKdViEJ1CC/VZsfIcZ01lmnKjIyShV94QkpAYi6fP8KoFxclaxsvy
         AZLYYqxn0gVuyyyelMRuxcjDRQFjuoJSPp5OX4ZC+9h4MXR3rdvbT697sUouxkJmQjcV
         b87qOSOPtB4oZt8BxCHxcfy9/O1XlAT7TUu0RD/nnuJRpQ04IS4uW2BqlYdpQONIIoHh
         WmqdxAUuXal3OWmvWcMShavs+nPCPnWq7XmJksvFkIcH7t06q65PvIOkmnw31iYPza95
         PgldV8q1TAg92StUVkHjhwVSd5ASmL5R7+FT6NdzK4zQQ9LzpgAt0wftYxBz0luXKIqO
         IUFw==
X-Forwarded-Encrypted: i=1; AJvYcCUYN8zr10cEPlecR/73Wpe60tTWhTw3lN+6wviPsWLB/kfDC1iLyKVsWcKl5Fj9sH/zoOizhbvfx9H6UUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk9WQDN+Ef6UI9ykWbqQlFbf0QmoWUK71ynSjs7X26AUhJVnsP
	9jcB/gJN3qfiKO/tKzQDxL4sdGbTtEvUe1wxYsQA83tVy5mlg7uM0c9wBb0MSkJaQ9uYrl7MuKs
	FGF/6tk2/r/EIFV0p4F6m0vJbznvvL+s=
X-Gm-Gg: ASbGnctKCfmvWq0fjRhRa5VpdFZ5n4eL2WcdXZvoUffOWuBz52pH0cKbcvH0sOc+PYv
	qaED3gsKyufDoYa4VvcEeOol0Jah5+yIxQRrlZlpWnlTnEsXcVA0+0DNWtMkPSutccYrr3F/quw
	54Wv07N3C3fGsJ6sk7kyQ09UF8XpE7uXTtTg/ySgJrcPcT5lpxXS5IUk/LlsKYvyk1I8OYwWRki
	Kh2xxBA6yy8bewLQDzHtCbcEfbpEoPhEGkHd/HJZwJcST2Hzqirjg==
X-Google-Smtp-Source: AGHT+IFWa4lkAHwf/4SArdm61wLTC4F7gQbf86GEjLZLwo2VefWv8FFXmP8OkTgdIk6qtNPTw6EZddqMonym0lxMhp0=
X-Received: by 2002:a17:907:26c4:b0:b2b:a56f:541a with SMTP id
 a640c23a62f3a-b3027260835mr530198366b.7.1758701266609; Wed, 24 Sep 2025
 01:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923022205.9075-1-viswanathiyyappan@gmail.com> <20250923164916.5b8c7c28@kernel.org>
In-Reply-To: <20250923164916.5b8c7c28@kernel.org>
From: viswanath <viswanathiyyappan@gmail.com>
Date: Wed, 24 Sep 2025 13:37:33 +0530
X-Gm-Features: AS18NWCT-FjALMCOah9bf_auRuFbM1Q3yx9_Iw8e7RGCWur-FeBhqSVRINH2d0w
Message-ID: <CAPrAcgOzf4XYGA8X6TneRrmVwYVYgF=KvnpmRbT6XA+D9HR6jQ@mail.gmail.com>
Subject: Re: [PATCH net] net: usb: remove rtl8150 driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: petkan@nucleusys.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 05:19, Jakub Kicinski <kuba@kernel.org> wrote:

> Thanks for sending this one.
> Based on Michal's reply I guess we need to wait a bit longer.

Sorry, this version breaks the build.

I will submit a v2 that removes the driver properly

I hope we won't need to apply it.

Thanks
Viswanath

