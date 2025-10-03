Return-Path: <linux-kernel+bounces-841787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F96DBB83A7
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 23:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51DFA4A025C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 21:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2826426A1AC;
	Fri,  3 Oct 2025 21:44:35 +0000 (UTC)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9EA2459C6
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527874; cv=none; b=C20/HPOYMcdJAbV1zDknuT4zImhfFazqtakRDLD7sZhG9vrQ7EhIKLCOxKMmEjam1JMYRVguUGvm59iEJQoAQ8Ud9ScduuDy/ib2VvIbIRXci5FiQHxhwgP8eRlVNIEn8dugxObCYyibLloUsyuaE4DEhbwqU4tHNoPvLo0+ifA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527874; c=relaxed/simple;
	bh=WgYLm3VZ0UmFV01TgPlUig2yCKJnOPmNhrFlqaAZ2uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZ9HWrDgovDcpTnj/B4FzkvhwLCn7+udiYeTpGblSK4DnzlISDFD/RFcTPlPylja5Rf5iZYQWEvMGwia74Tn4nYxmicpgKmuZi7nTrkdMpznIby3T2dj0w8b1Yill7OORDVezTt4oqlOh9eFc45jBFjzsKholT2+tMhP8qC9vCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-364bd7cce53so2107804fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 14:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759527871; x=1760132671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YROip0u2m51t7JzjiRptwt79A/Uhb6ID+VcZ6g1PHCo=;
        b=apsgiNVJ6KSGhqvMW6CANEWx6dK3FjhSWAsaU93fajw1LUtrEZ9j0Q5jqskQ2hAUPQ
         2svo+9pe1wztVt3uTQ2Y21x4676rRJvH/kO4WwQ+H0sVAfjtKGeIo5Jsx4INMLt4zuuG
         osNapAg93WpTT5tT//YqDoWxBm30qiGkyEhdS/ZlHHY5ExeJi4ZAfnD7GTiqYUQk78qG
         OnMaQmKfTTz9DWfEXzmmLs4uaPlYjTTa+P5x/kxmsZN9uNAYyxY6/tbAFO+YSazzI2nH
         YfPrpQ/285voHefHrU++q4MbTZs3MVBjEiIMkgy5XerZslbaTvpIvG0RiTfl/kh/LT5q
         Tu8w==
X-Forwarded-Encrypted: i=1; AJvYcCUHifml71eQ8r21jLzF+aZpGMYDdeRWhRzOBaJQ6B9YSFn68DD6PrLulczuxH6eaV3fDlGo36dJkOM+0U8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvOZMEtzb34E+dxCNa3xcVQp0sQ7YqsJ9CmAm8ZVnotl/9l45u
	nLZZBs3pcXri3t9YYm7iGwmZevVbaIhA5JzqfN41kMOAfGN7nrzhrAThHnDeg3yS
X-Gm-Gg: ASbGncu9dsap/wX13LJxtmaX1BkM4eXANdy2/eA5o23qawrrmGNENrjn1xCc/+rxe64
	4IRMWddwAjH+KSV0l5NnZH7iUzCze83QhM5MDWT0UAizxyRHksC8Els7FamassE8XLERyX7TWuR
	2cKjRs0maz2L976AvRR0rxOO5JrqJ4+LwZniF/tSCrsVYqWHBFqT7MSl8JyjziGbHMNb1LEmhaL
	EbuVqQJrLDh+J3xtSxYlV+lHS2MRF6QAy6RjZ7yx4YyOgW479hvPV/eBRQFMMngIWYiL04B1D8j
	4i73q6tqe2TnhB4qpmkboP//5D6M2bDiEHqtcYpeWXWNJf6yzzWV9YangEJO7DQJv/acBvqp2NV
	jIveu1SgAv+jJtbpvzY07yhtxEve4gZme9gbT8AuFYIt8hsJmgAOZHjfoidhwKDm1iJAuNkauWE
	ZHMhgH7oeVJzuVMFd0nvc37T+/PYN7ZQ63YtEjDgZ0iyQ=
X-Google-Smtp-Source: AGHT+IFvwqY7W852B3PMABgOiTit5Y1CBza3iqIJwpM2L1X6sFIXIiP9Q5QR4iesnRjKFVEEDYqddw==
X-Received: by 2002:a05:6870:d327:b0:31d:8ceb:20f2 with SMTP id 586e51a60fabf-3b0fa0501d4mr3024378fac.41.1759527871323;
        Fri, 03 Oct 2025 14:44:31 -0700 (PDT)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ab760ed109sm1914061fac.3.2025.10.03.14.44.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 14:44:31 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-64c7c78369aso1375138eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 14:44:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNo1fbw3yNE8ltF4JcydKZAt6bnTgG38K3H3jV3LFnAaxSZ/wH9Nl6lq0b9OBKqN8LHhtFuYqoWMLdXFg=@vger.kernel.org
X-Received: by 2002:a05:6870:d327:b0:31d:8ceb:20f2 with SMTP id
 586e51a60fabf-3b0fa0501d4mr3024357fac.41.1759527870652; Fri, 03 Oct 2025
 14:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926143132.6419-1-johan@kernel.org>
In-Reply-To: <20250926143132.6419-1-johan@kernel.org>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 3 Oct 2025 17:43:54 -0400
X-Gmail-Original-Message-ID: <CAEg-Je8T+UCMeLsT98SEB5L-KXa8UiXNkZ4x+YXK2d+0bmBv_w@mail.gmail.com>
X-Gm-Features: AS18NWBdsDw02jLLWNxaCp3ioe8zcoIOI8PUxPu5WG55XB6t2CA2MqNUivNjj5Q
Message-ID: <CAEg-Je8T+UCMeLsT98SEB5L-KXa8UiXNkZ4x+YXK2d+0bmBv_w@mail.gmail.com>
Subject: Re: [PATCH 0/2] soc: apple: fix device leak on mbox lookup
To: Johan Hovold <johan@kernel.org>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, asahi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 10:31=E2=80=AFAM Johan Hovold <johan@kernel.org> wr=
ote:
>
> This series fixes a device reference leak when looking up mboxes and
> simplifies the sart lookup by dropping the corresponding reference
> sooner.
>
> Johan
>
>
> Johan Hovold (2):
>   soc: apple: mailbox: fix device leak on lookup
>   soc: apple: sart: drop device reference after lookup
>
>  drivers/soc/apple/mailbox.c | 15 +++++++++++----
>  drivers/soc/apple/sart.c    | 13 ++-----------
>  2 files changed, 13 insertions(+), 15 deletions(-)
>
> --
> 2.49.1
>

These patches look reasonable to me.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

