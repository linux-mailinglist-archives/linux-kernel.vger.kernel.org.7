Return-Path: <linux-kernel+bounces-803199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7436B45C04
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B99817EEFC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9E131B828;
	Fri,  5 Sep 2025 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8/t02kD"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3433F31B827
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084982; cv=none; b=pOhIm6SlHHhKrq5PQT7c5jZvJ/i4VpQ/MmrzoKXkL7sLz6Zh0yRZFxqPQiOjI0er97tTYco4GE8icjSMK5keBW6cfZ1vTIBrTIab55cBv58YslKuoOS5sBgIgWIniRoKS1sroQCH7OZOBVmLMIYrhttP2bkqjbqqtivfTBauyWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084982; c=relaxed/simple;
	bh=dFdVomeaxD4LPhyoEmMyXlkg6qCcKVW87KQws4WwyuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkIpkGuXCzyIjE31c4bSDgWL0ZQoftY4VK1nbg4z5knDqxs5MQ8HFQ0B7CRjkTru/Ggo84LZRHqLMt5wlGmqso3ZFpW4F05l7PuNd2znFQaRQU85Q4TyNEuhteG6sD+/JksSglXRmdgkgHIn4tlc79pVBQ2ImZFujSjqajPZyis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8/t02kD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24cca557085so168995ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757084980; x=1757689780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFdVomeaxD4LPhyoEmMyXlkg6qCcKVW87KQws4WwyuE=;
        b=I8/t02kDYls1rrpwAmxAWi8JdyOA4wccts+YEjFZuyf0FJ/84NJzq1V5B+h3agBL9f
         R5Xjpw9MNrNYzFmdYjQwQfoHm9F13dfHursuLcEOkazXJkOsDNdOutrTFpfsHAJaD7dg
         N1C4cpKAVeuP079/xWoZuAOXagGIKuAk/V6sGZ1Qy98X1X3hpNMUoB6EDHc//YkS4U1S
         yr4qx6RdNWouDWSTwtrUpU5E7/8S1aZ+2JLYUqLAt56BPbhyHOkaQhCFbZuQT7tx7eBn
         QQ2vtqFUxwoD07rCA+a8/3oe/s+p6/bpep3L5M51vsQ0KAlZ9Y3/VaWlhiCI79YSCPZT
         uLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757084980; x=1757689780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFdVomeaxD4LPhyoEmMyXlkg6qCcKVW87KQws4WwyuE=;
        b=uXDqshlOYlgvhEP6WVt/ZR5c1mCjEQbtZZWKkNsZulAPMowUpFkjlqvdfurdGyqxba
         kooKu1x6VJZH9+gom689iACdfdPyJHorW9OVsXBOy0kLPnq4jCwYx+3SB0HYCl1x22/X
         PovBTvWLcau2GllZ+X38w/Ios04QNrciKgxvXGGkRuD+iFFwJv9eoMGAKN4adNxcpLka
         9yCGLPUoD+qNa1MRa0aja0uKW2v/ij6fiGphbLu524wmibTpmiGTTCTxfWmHUvKSOb6l
         k0r1IYlGSUrctxO4GzLrlNHqEtuhESd0ofZARcDk6dr6lLakUCbL7NH/Vwen4mPdtlte
         7Z3A==
X-Forwarded-Encrypted: i=1; AJvYcCVU/Hmo5ZGXTgv3hFdkixo2FJie3vJEO565E+PrckR5SDyi+pT4mDRTnWHNZv9reZ8ob6z4Qly7merdB90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz06DWJwn8CVfAIgX3JiGFo2izvGCOIIzTURB1B7FeDPkbBIIQY
	QF09TKw2axcE/0jeQxrm1O2HaLsZCNYp0fAD2WL6nGZjEys2eXz86hAy3y0jgU0/APO2FRhGjkw
	olknLY+87ArHsnemFHFefDSPyHH9Buraa0u4n8fjh
X-Gm-Gg: ASbGncvDiyxhFfuKpC3UQjTImGIcW3eYn7LaELQOF4+vGaTVYYhYU7agupjTf4Z7zDd
	T0cqSZeWTum6ww6EZxwEwEQcQMYEqE7/COMJJew7m3tY5nbqTP32kOv88lZtN3NV9wY+CBoRiIy
	YLNEzUUfXi19yxNbFgMrYjX7xyyZcha3s1H8oYtLDwtwRwWKAAReszLlTSVRX2g76mSUMj5DNkQ
	F2kjeYJynIPV8xJsukmqpviI76IN1Dj
X-Google-Smtp-Source: AGHT+IFigRlugHFu64XYH5E1HhI8NlSyNuAc3Xp90gTVTmK4u8CmaCMLRItGgVFLK1yt7YLP9pFW/NA0U37fFcFhCUQ=
X-Received: by 2002:a17:903:2f85:b0:231:f6bc:5c84 with SMTP id
 d9443c01a7336-24cf5c29233mr4503325ad.8.1757084979941; Fri, 05 Sep 2025
 08:09:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a40e660e-5a45-420a-8d37-51324242ab9b@kzalloc.com>
In-Reply-To: <a40e660e-5a45-420a-8d37-51324242ab9b@kzalloc.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 5 Sep 2025 08:09:02 -0700
X-Gm-Features: Ac12FXwsBG___TZgBCnwrUiXvtQzs6bTFvY2gqQx0WiC1kXwGKAPta7iWLhYPhc
Message-ID: <CABCJKufSRmYnbjcwvhuGgC=xkyPgJyi7FMrAdDm3N0fun1cLAg@mail.gmail.com>
Subject: Re: [Question] Non-usage of PKEY_ID_PGP and PKEY_ID_X509 in module signing
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, 
	"Sami Tolvanen <samitolvanen@google.com> David Howells" <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 26, 2025 at 11:58=E2=80=AFAM Yunseong Kim <ysk@kzalloc.com> wro=
te:
>
> Given that the module signature infrastructure seems hardcoded to use
> PKCS#7, could anyone clarify if PKEY_ID_PGP and PKEY_ID_X509 are used
> elsewhere in the kernel? Are they perhaps placeholders for future
> implementations or remnants of past ones?

If you search LKML archives, you'll find some past efforts to add PGP
signing support at least. The patches never ended up being merged
though. See the discussion here, for example:

https://lore.kernel.org/lkml/20220111180318.591029-1-roberto.sassu@huawei.c=
om/

> If they are indeed unused and there are no plans to support them, would
> a patch to clean up these unused enum values be welcome? Or is there
> another reason for keeping them?

Perhaps the folks involved back then can chime in, but I'm fine with
removing these. I'm not sure how likely it is, but if someone at some
point makes a compelling case for supporting other key and signature
types, I'm sure they can add back the constants too.

Sami

