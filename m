Return-Path: <linux-kernel+bounces-888891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD577C3C328
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91D3188C7CF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D04F3446C2;
	Thu,  6 Nov 2025 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="frUZZgOk"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A55733EB0B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444600; cv=none; b=I9ZRc63zrxsl8gVSHMfdiY31aVdV+yOAYd99Zwma22xIgRbnPhHWXpu8OqKMXzmwHqqee8UATbvOcmN1TUBj1qABQdByNXMzO8WphU33Oku+GQDeO0xGNCGDrrmsUE531NqqZciTOHXGohVUa8Tgr9A/wZ2FNiIaRval+JLPLvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444600; c=relaxed/simple;
	bh=g8AiCJd4Rj9tTeUeL23ATTkGx3PrApL+7L6hu7WWpoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vz/aQhJFFr/GNR8qsWPzdx9Mjsp9GMiR7GkZepdmORNPONFlKBaGZzwdT35Jwor5NN/tOSRiVPQ1U0doivbWdZBuMp76g1ue5tWSYN6yCcqIHhXs2HAOYcL6+qPdiEULxOIT7zihTdyIrbUgBDrnRq0j+AvMlziLK29yh7CuqPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=frUZZgOk; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed59386345so5438291cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762444598; x=1763049398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQlLDOZhUGamhqd3pMIsaftaQsZqtWwuBy/4wJVp4cg=;
        b=frUZZgOk0zqHgq5YjIV+PYbVIM6+6FKzxZ1Yb3Bu2o/X+OS7eCyGPk4eoN7pQZiGvW
         4zvQukqASsoa0f5di2T9OBesm+xPVY12GDOHAGqyrbchbxRvB77AftCEQPJVtyVo+xGt
         gLu5PpYXo2bXY1SAHvQDJcrgLFDATrNnodTVUiK4HdrhFcBIlh7fXHjTJM7PGmeysi8j
         Ul+1J85vVFQ1wuQJz2MLV26vOWzejZs5Rx0ctgtbHTB/jkbztgk3TCKdqhqkAAoIsOKz
         Y9FPA/Y7fLyCllFuODy2kdlpcYZVn+ELCtUAidg1ZySqgTl6mGxhLoLBzeFltVSIghrC
         do4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762444598; x=1763049398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQlLDOZhUGamhqd3pMIsaftaQsZqtWwuBy/4wJVp4cg=;
        b=AKCCisAk/aBz4ewXF/o2UDirW/IsgIq/HnVFn0hQEnyYkQLp36Pxn6bjwYPX/G2La5
         ZOAECCWdPiks7O1MvMROflsV3Dgd7rt9iwfaBB93n9587Q9FmAqHj7ACGphTRIGjBpyp
         h8W7ww4L6hRCgW3SaKfQtrirjY9pZd0kAVoNL+r+5RVMy/XhC46zhSvb2m/0UdvUI0+a
         XrIJrWbQx/9zEXLhajZNivc8RdWYUI/8v2hPhsHxRcMzsCwksT7vG+vDXc04fY25I6AN
         QX24UCDVk0ZUWjoW6mPdR3ALHflqCDpVWElKW/aygrJFZUECdsdxNyi5Jdd90wPJMOdi
         yIHA==
X-Forwarded-Encrypted: i=1; AJvYcCV8tREgnhHhqDcUPGNCMbV6VQpY3oWnD42K8s7qDL+bZB/GzjU//Eb/6DEfoHFKRdPJ7xobCHdrOIkAGyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz5KzCGxhXXRU4G9eQjiAH1vz5hWgB4uG9/UCe+f6BkHkb6OZc
	Fonc+M5Qd/8NrKZMYcm5CCGWX3ZQ/KppfPyl6P6KZfHCYdJ48LZ2Yt5yvC1mgIriUlg21Vcwutp
	VlgRLmTZXHLNnyomfvVPHFr4OBMtKEP/p3ri6cCUk
X-Gm-Gg: ASbGnctfv0JQ4moz0sOLL20facfpQlHBk05a6D+ykzjR0TsfHWfHYi+8fNb3ocuvXRb
	ny+SytcDCqo1dMSjB2c2rfX0ynM/oILeANqBnffny1miOe2KeUyT32YNHBAU5iNMfLvdSmtVig2
	VQ3fsyeOY0XKgzvawP6hNivLu0srbRbNp4VUBcdWniwLA7+qXvgiDJTTNny0e1wJDWUfkqUScgY
	MYSCu3MbzjTbmzWcDc+6kkWDdrAt9ZqvZrPK7rjcMeWzRzgkv7lAeqpjXNdeY1hzcg0FIUDXzTv
	YycUOA==
X-Google-Smtp-Source: AGHT+IEDLiI0USlA6fWy7LXOe/FGCyS4xbZAtGDW6hpAUv6II51smQOaRiksVrgxmmMZQlDyNd16tiLeCvJWicKtn/o=
X-Received: by 2002:a05:622a:180f:b0:4ed:20f4:15fd with SMTP id
 d75a77b69052e-4ed7265194amr84326701cf.81.1762444597688; Thu, 06 Nov 2025
 07:56:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105161450.1730216-1-skorodumov.dmitry@huawei.com>
 <20251105161450.1730216-7-skorodumov.dmitry@huawei.com> <CANn89i+iq3PVz6_maSeGJT4DxcYfP8sN0_v=DTkin+AMhV-BNA@mail.gmail.com>
 <dfad18c7-0721-486a-bd6e-75107bb54920@huawei.com> <bd0da59d-153f-4930-851a-68117dbcc2de@huawei.com>
In-Reply-To: <bd0da59d-153f-4930-851a-68117dbcc2de@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Nov 2025 07:56:26 -0800
X-Gm-Features: AWmQ_bkf1ZUvgOuppHfnD41rLgZ8c-GgzZsFLM8wiRXDADFT697UgcSJHOFdUeY
Message-ID: <CANn89iKioXqA3vdKdpL9iZYVU0qOPGCKxYiStc=WNWQ3+ARP_w@mail.gmail.com>
Subject: Re: [PATCH net-next 06/14] ipvlan: Support GSO for port -> ipvlan
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	andrey.bokhanko@huawei.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 7:41=E2=80=AFAM Dmitry Skorodumov
<skorodumov.dmitry@huawei.com> wrote:
>
>
> On 05.11.2025 19:58, Dmitry Skorodumov wrote:
> > On 05.11.2025 19:29, Eric Dumazet wrote:
> >> On Wed, Nov 5, 2025 at 8:15=E2=80=AFAM Dmitry Skorodumov
> >> <skorodumov.dmitry@huawei.com> wrote:
> >>> If main port interface supports GSO, we need manually segment
> >>> the skb before forwarding it to ipvlan interface.
> >> Why ?
>
> Hm, really, this patch is not needed at all. tap_handle_frame() already d=
oes everything needed. Looks like I had another trouble and this patch was =
an attempt to fix it.
>
> >> Also I do not see any tests, for the whole series ?
> > Ok, If modules like this have some kind of unit-tests, I should study i=
t and provide it. I haven't seen this as a common practice for most of the =
modules here. So far all testing is made manually (likely this should be de=
scribed anyway)
>
> I see that currently there is no any tests for this ipvlan module (may be=
 I missed something).. Do you have any ideas about tests? I'm a bit  confus=
ed at the moment: designing tests from scratch - this might be a bit tricky=
.
>
> Or it is enough just describe test-cases I checked manually (in some of t=
he patches of the series)?

I have some hard time to figure out why you are changing ipvlan, with
some features that seem quite unrelated.

ipvlan is heavily used by Google, I am quite reluctant to see a huge
chunk of changes that I do not understand, without spending hours on
it.

The MAC-NAT keyword seems more related to a bridge.

