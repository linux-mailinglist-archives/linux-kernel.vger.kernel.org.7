Return-Path: <linux-kernel+bounces-885244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAD9C325C5
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0B3188F610
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8E6334C26;
	Tue,  4 Nov 2025 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+CT1P90"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC72334363
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277564; cv=none; b=Xp8WyYmBwIyK/BcXevkhFKLV+Ob5J6IM5/HgAMshZxZHntHW8Fx2VNbvWibH8h+gvlR6o91eatawG5/HeEsEd7tonj1EQ0c90s1u4v3a+5P1g8redxmecyCvus6Mt6Kau2hLsHKKlQ/x5XosMCQeHr/OIGbCKNvixLyvMJVPGDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277564; c=relaxed/simple;
	bh=SzM3QuPCpSLxXdGGco1ngdrEoCX9QqchdJ7DcUdSPxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fg9bWHCHcDoknaGJIUdlXgfGd9Nln6URru0eP4fMHQ03NcZdNQsgYAa01d/eW5srjdxzkVxe74fwrR6Rycq0lSRpNDT5J6PrNIvi5NVeDbZzQHfkw55yewGvxvfLiHTrXam1rqvBdHjIpSJkJvwuZcYFK8MKHasi3Sv6WQPRxpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+CT1P90; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-591eb980286so5468935e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762277560; x=1762882360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzM3QuPCpSLxXdGGco1ngdrEoCX9QqchdJ7DcUdSPxc=;
        b=m+CT1P90i9Y1oP5NhNXKq37Koow+3nuUbCmY3uUFiMtfGxvof0Ic/xTASERS2qvhuj
         osPlh/hqiZbaazBo9L1WgNZ5h1vOoD/jj+h15dHtTrD1e88SbjfSx/CMitKoHf9K6rER
         3VsU3arTkV+wxLM02HplL4FIUozHZ0gSBaqj9VlWwp5ZYFYxeq0KazGy19OpaDZQPFiU
         tkuNofn35rnguMONhmwo00odGtrSG842ewdd/8KkdWa8MHSBwu80xR6gAVbbuKPG0D7F
         cwMpKPV8lGF2iuKrnkgtW7kFtjhmuo9cxhJIkMtNcKSS7GHS0gNQ9j5CovWkdjcwCxJo
         XfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762277560; x=1762882360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzM3QuPCpSLxXdGGco1ngdrEoCX9QqchdJ7DcUdSPxc=;
        b=mzj1Y5Wf+Rq2mVdilJtJrXw2klm8gkeLdARYoIhIgfPN1xapFPr0bm2pxZur/xEpFH
         JDX51iFtWmv7SkgvPA0KAtejcsMOn4Ui6vXDFJw2eeVpAdGrLFjpWJUW0rSNCRQhlP6X
         1F24ga9i7cWSQHophscBPo1m5I2Unv/t33hHwLD55IaL102b9IFroAEo9pt2mlmplIUN
         fnsYaLidjxNFbBmEFfmDhFsoE8jTxVBvdTxL5VqwsodpYD0nOXi1dAmhEGZCsUwlugar
         7iMXV7HDNS04ACfkpqO7MYgr+zdAj59t1/4VKGrB9W6d3ATjsmF1513tX619H/rrmm9I
         UH0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIKofkyQ2SeXjdS1VuUPevF1KGi5QoR5ZUOb9GpsyBY5dLAjw1/mkQwOTgM6pTHVoDjEHmUIHpGHzc3AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCDFnze+ZkpWbp0Jsf8Zp6FjgEQTTUVUOsXwIXoCIOu7FuOHzV
	sOcyOauhOkOiLtRSlks3UN1iXhlmD0vMb1QLBFNdptQcToJKYNzMYwP69kvY5/+bR3NI46RSb/6
	i3IZ9zY3IzI5r+1xyCl3VPPBFO7Vs+XU=
X-Gm-Gg: ASbGncvk4jMrctEDnG5VOD3mnsgXzOY9JXZPmGsRySB+Nu3Hjw0hxdgjmK6QPqcvni8
	18prX/TEQjOd0yOSG1wSTTFSt1GrqXLmN7+oe2Q68h+WZYKtpWiwBgKVsNg08UJHlN1CPlYXYkA
	V55ABk/N21FLNdKBm3Qcx7uxU4l9pD57BChiALOpzNcbnjE/2R00Zw72TT21rMeKJU4TJbvGpeZ
	ZsMI5QJOwkHnTtHv6rbm13WwWzh3iGu5hJIrdxRLgzTjw+gUnW4qRHE7A==
X-Google-Smtp-Source: AGHT+IFXI0b26Xu2rKqQvjM4aCQpacUKpmY1KjXZETX93PxYlp9C+bCDV5fm09oDr/KGDn8H7OyKaA5fDQv4TCtmtZk=
X-Received: by 2002:a05:6512:150f:20b0:594:261c:1ed0 with SMTP id
 2adb3069b0e04-594261c22b4mr2564678e87.54.1762277560179; Tue, 04 Nov 2025
 09:32:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104103525.26410-1-linmag7@gmail.com>
In-Reply-To: <20251104103525.26410-1-linmag7@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 4 Nov 2025 12:32:27 -0500
X-Gm-Features: AWmQ_bnuBM-eGvsdkAbseo8EWUGi1fvIqcWoT54YTpb8Ju7ny4iXd1Z7El2G21E
Message-ID: <CAEdQ38E9hWDy65vOdjwmTcy5tqtNvY8eebV7c9Sxx3e9Y4y8JA@mail.gmail.com>
Subject: Re: [PATCH v2] Add Magnus Lindholm to MAINTAINERS (Alpha port)
To: Magnus Lindholm <linmag7@gmail.com>
Cc: richard.henderson@linaro.org, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 5:35=E2=80=AFAM Magnus Lindholm <linmag7@gmail.com> =
wrote:
>
> Add Magnus Lindholm as maintainer for alpha port
>
> Changes since v1:
> - Rephrase commit message and email subject
>
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

Acked-by: Matt Turner <mattst88@gmail.com>

Thanks Magnus! I will take this patch through my tree ASAP so we can
get your kernel.org account set up sooner rather than later.

Matt

