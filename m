Return-Path: <linux-kernel+bounces-837203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9611BABAE2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D901921985
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6904829AAEA;
	Tue, 30 Sep 2025 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WwbKDoiV"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C9029A310
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759214422; cv=none; b=fbEtwfXQTZXo9teKgrIc7bToUobb6zj1VLbeMncsljnhDG0iOP62BHe49kzAcx3USG+iNnkQ5MH7izOq3dfDHdAjMP/2YxGF7XLpZPY1KDuwE0/CtGEJMdmvWAEM9MKScr2FsdJURaOBPhWEyHzJpKdm9jpZRhJ5jUOjrd+BYx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759214422; c=relaxed/simple;
	bh=gQDZRuX3Iyc8Vxc4NYfOuO3yI92bRrIQu2/zmCtsShA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFd8p1/K+jVABGwBa7yCvT2JbqgpfpiXlH6UG6TsZkLLWx291OsR67xahSPqjjcLPEIXbpkwwAJIN5OOu4+0htXUu2QESa6jeCbqyS1RVfEzNgRCs7E8JLXRxpLq5J1ABnQeixS2hW0suUrmygK5zrRWnu33Ae1atQWETxq5aYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WwbKDoiV; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57933d3e498so6557527e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 23:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759214419; x=1759819219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQDZRuX3Iyc8Vxc4NYfOuO3yI92bRrIQu2/zmCtsShA=;
        b=WwbKDoiVslen1GmzOh7yo5NpvauCzQe3tM9rrYrZf5yrYUte6N0nZ3faimYbBNeBjd
         hO1LT4dO76q/KDpoSroMoh9lIi+pui2A5ekdGcqwQ3oAmaTo26zznX08tmNGV4jUbRR6
         j1uglomfwA0x4rzq1RMtgzkvXcmR2/Gw2Xwto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759214419; x=1759819219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQDZRuX3Iyc8Vxc4NYfOuO3yI92bRrIQu2/zmCtsShA=;
        b=c91lYjUF9PyKwLjCf+7bX9V+x6OR9f/gpGOosuY345KvvZj02YbNIeiYES8U0bplFx
         stH88RIBzS3w70QHUsROCGfRac3YRV6IoZzGZqZ82wx/gqzqjsBO6g7Z3PihObl07CMQ
         XekiykwGgrGOLgSAN9ki6enezS1gZB5pWsrXwOACWHCuAvXFWPJ0Hm5qivZPg0lSy+yF
         TG+rQPZLvHgZ2mHMulNWaQ6SHwIMOf2+FQpydwp7ShVqWX0wHNCN8Vk1GgFnIV5YHti3
         mYPJGUS6rNq15Ql464FiikTr6U7MOdnwc7gRHscZqFO+/Qnu23R716jC34pFRNpJ3FL1
         s20g==
X-Forwarded-Encrypted: i=1; AJvYcCVPXlG3AAp8B5KfkfPb7kxRSZ+w/PoBuLXW7GpyX9id2McLk7RwgcWnQ3ibPj6cn8TYQyEhuQZRRL9i2Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlzD6QDTrGehlTcH8P8pEBGKWsEFZkSVjhP/rWhxUVWEwTUCW8
	C86e1BuZfwZX6iprCxYNxtGtDi7bpEx55m/JRX/PV3R/1a+XOANhpk3mFQKk9s5YGNr0hvn1J4/
	jbYBeqA==
X-Gm-Gg: ASbGncterYyhtmSVLIlMG5j5vhwi82CqH6epzdHkot7+SC2roTpZCKl3fCvpYqpHPv9
	68Lw756qSaOqeYKv2pKcORVyjEsZwF4knoGpKN+jKOLuWiNoec5KZ89DL5Favc4fCd4BvAAjUKW
	FRjftbWq1BoAElqoPVBNfhafZbPxuaA1AievZ//yvkWvKou4aaF8qqJMCFxbW/eDCLTv+xEn0jR
	VqWM3VBBSBT3kI955z7AVEBebIICfZZPJQlSqZPPzxtZflPF2jV5lkk+/kLljA783uLeICeTO5v
	7yVBe10xO5SToKcO+0uQen3IZ+vQgCbHxp/iDLrgBEnpcmbkZfNrZB8QCVezVcLf/yh8g9LXnhh
	Bf4qQ7U3aizxkoNg3RemcXziw8UB0iZqsnWt0RuZ7SX1+W4vy9n0jj4najqgRQr5vU7dDNmABbU
	y7V8BO9JQ1r83AvgN80AE=
X-Google-Smtp-Source: AGHT+IEoUWefB4eVpaNQ4INZ3f7DT1YobffFD4cQ+bbl9cNv/9vTVV0wlJCx6rk0QMutPodipOLVQA==
X-Received: by 2002:a05:6512:234b:b0:57b:5f02:e9f1 with SMTP id 2adb3069b0e04-582d073f8c2mr6158955e87.6.1759214418884;
        Mon, 29 Sep 2025 23:40:18 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-588645df98dsm1073235e87.104.2025.09.29.23.40.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 23:40:17 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57edfeaa05aso5763020e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 23:40:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVEVz6NGIf1TYmBdnifyELjFl4cYIzurcnCDVmsd3Rz7RKwvAAEMOiMEefu61brbcVqH+HpFJkWTNPbY4=@vger.kernel.org
X-Received: by 2002:a05:651c:441c:20b0:372:96c1:b276 with SMTP id
 38308e7fff4ca-37296c1b58dmr15679651fa.45.1759214417128; Mon, 29 Sep 2025
 23:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CO1PR18MB463349680603EC2C284B7FEFF71BA@CO1PR18MB4633.namprd18.prod.outlook.com>
In-Reply-To: <CO1PR18MB463349680603EC2C284B7FEFF71BA@CO1PR18MB4633.namprd18.prod.outlook.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 30 Sep 2025 08:40:02 +0200
X-Gmail-Original-Message-ID: <CANiDSCtwhpCAgQY73phJE0okN+Smv_AbA6Q+w2tuTVW1_qcbDg@mail.gmail.com>
X-Gm-Features: AS18NWA_D8LZfRD_mkcuc94lcACPA1tYsQzBsNOsCaW-qDSlktvb8Q1qfsQ7Ed8
Message-ID: <CANiDSCtwhpCAgQY73phJE0okN+Smv_AbA6Q+w2tuTVW1_qcbDg@mail.gmail.com>
Subject: Re: Realsense camera patch
To: Gladysz WojciechX <wojciechx.gladysz@realsenseai.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kontra.wojciech.gladysz@gmail.com" <kontra.wojciech.gladysz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gladysz

Thanks for your patch.

It should be sent inlined instead of as an attachment. Also for quirks
we usually require the output of lsusb -v -d $VID:$PID.

Regards!

On Mon, 29 Sept 2025 at 13:51, Gladysz WojciechX
<wojciechx.gladysz@realsenseai.com> wrote:
>
> Kind regards,
>
> Wojciech G=C5=82adysz



--=20
Ricardo Ribalda

