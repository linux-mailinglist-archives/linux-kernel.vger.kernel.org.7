Return-Path: <linux-kernel+bounces-896777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B28C51341
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08E974F79F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0972FD682;
	Wed, 12 Nov 2025 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z8e2/kwm"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6D32FD669
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937381; cv=none; b=p3Xtd6xG206gCmsTSU9tm1ySTDosAP0B/3oR0WQzn6XB1gFvCNBU4gLXKivGf32EHrxLvAmOrSr1tvNX5J3SGbHyhBOVwan0P2jkbhPnNyX4snoINwhkrm6ImGo7wX7fjAFfvAlUBOXdWsxLQShUULsSe8hEWzTB0F9EnyQwnm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937381; c=relaxed/simple;
	bh=Z99mIqeia+YwnxsvpuycDzk6TGzbqIDr6NWTdL8N780=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUNgu4GSYhu8+QN4p/yhzTW/TG2B0wICul7hd0x9f2vESvEpLV893yTHeNotwAwS/a34nYHMIjnP+0jmN12ftPU0ax9JM4i/f1jLiOqAGCAlpzTiF9GnGtsKBuYwiFr9lTA8zSg/p1lkYjJkG0xzDeJ0HBeDLcXB0rWaHxhsGUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z8e2/kwm; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5943b62c47dso489867e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762937378; x=1763542178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z99mIqeia+YwnxsvpuycDzk6TGzbqIDr6NWTdL8N780=;
        b=Z8e2/kwmWfSp8Q3897seqT1L8mx1wB9X4L6CwASrrsN4A9b+q0mAuJxAlb6midu3MV
         gCVZ3lfOcDDG9rX8C17tFd02GAXW/7DolY8TotOg9y3LOAIY9/PxB61fmQZmPQIZcI4Z
         14ppuCQlAkX4WQ74eyoVHXGL7hzphywLZxdpUiy594mwUabfzuDIhDMrRyHL2XwbFMdn
         JquYBbfJuMRFCjTUQ/NL4sl1mjPowPQ9GPOj7QGJximm5HgmGlaZ4N/d+Mr7esYsKG9m
         kn9mD7UQ7BuI3RKbtNXhI/NN8sG9sEc8tPBbnEGrMJDC4tH6wLkGr5gngfIguiklBbPJ
         0R+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762937378; x=1763542178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z99mIqeia+YwnxsvpuycDzk6TGzbqIDr6NWTdL8N780=;
        b=n4b2Ttr+ZaW1atmj3zZy4trzdd1lMGco4zwySATyiMTe1okkBpN7y5O/9ONLl7L/0d
         JDkVxj8Bw6aGrbI/cDTqMakVckaP3wjaplKKLUESL3Xjf06yT7FmJiUvZUfVhAd9TaYj
         mo1VsmIb5TtZsddUYvZR0/KDB71tvU8Wuzy36zw7CA9smb0g0LrP3R9F6WcbsMBz28mE
         YQywFCsa3I5/Yr6nE4kofQFdpT3OxjOPu/TPWW/iBmW/Hi3uVe68SP2yhutTsqogUZbC
         igIHFSK+fUQ0pesk9Bco+X9jQ6mq94gEbfPTtvIgrL+KubiV1rvoPuzNJMUZsRbHdE94
         YIPA==
X-Gm-Message-State: AOJu0YyzKlxAJQ3iiZhNrDQsyj8rKqMFxdfWg3rl3/PAH9Zg6hEXQprD
	hHMFQ3oZ47k8WGfP4Dbq53c039w1YKOx0tq+cbhlBXZWTsmq0EP84PETGge5Ug3Mb4HmLioAIFc
	e7hsTQWTSD8YkZ+HMOH0jpWBATkI75ttNGaW5q1wAtQ==
X-Gm-Gg: ASbGncsdheJN7RRdQBsBhBcYlbANGfQiMIWF4EBJ5QCpnJczLOWSkiz12S89nRMHQkG
	knjNW2wlgrkfLsd5wDqTppW90JWbRMF0wD9J4kOcPgBekJn7P1kcMx/MC0VYC0hEPWSe+RvivaH
	7tGUhxAbZsmucq8j6IihoN9vykaBjM7CrMoEijzYyo3uLA1VcoEDz3gNE/65ECTsWEfvOIOjk1D
	MppKerRG9RqLJ9wfkWTyo4MUBbqH5rxtCXHHqCvAVj1hGulYGZqb/bqJhd8HGEGzrO8XTj7u9Sj
	4tZbmzIJwFBwi39U+NUr/Ey/0xw3
X-Google-Smtp-Source: AGHT+IHwkyX27togvHCQMW2BZonFzlk/AX1LRSnafb7ksgAGV7MSuE3/MUECC9rK4STtLAD8hduluRS8ToF2sYh+/Uk=
X-Received: by 2002:a05:6512:a92:b0:594:2b70:6d09 with SMTP id
 2adb3069b0e04-59576e3a932mr714105e87.44.1762937378011; Wed, 12 Nov 2025
 00:49:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105145824.239054-1-marco.crivellari@suse.com> <CAPDyKFpVS9Z86D_QLhjvOYFAbXaa4_Z=ZQnV+x1ZTuXG4x8oXw@mail.gmail.com>
In-Reply-To: <CAPDyKFpVS9Z86D_QLhjvOYFAbXaa4_Z=ZQnV+x1ZTuXG4x8oXw@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 12 Nov 2025 09:49:27 +0100
X-Gm-Features: AWmQ_bnT0AamP8qb05zC_dt0cIUnpnjMsIHeflBvyb85nhOL9I5Vg8kBfSa8zH8
Message-ID: <CAAofZF74Ojim5fJmeu2Y3OTqi1VTTTSqLiCf9VGd6XqbXJSq+w@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: replace use of system_wq with system_percpu_wq
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Chaotian Jing <chaotian.jing@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 6:37=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
> [...]
> Applied for next, thanks!
>

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

