Return-Path: <linux-kernel+bounces-847258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A9BBCA5F0
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70FF81A644A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E862E24167A;
	Thu,  9 Oct 2025 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoOMPMCm"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C17A31
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760030822; cv=none; b=BflF3sTcMMIIwyXCmjgMZ1C+R3H/FXRz/RNCOL97Iqp0Wu6x1UVIclmzB+b7VFKVLnqUxEkLHxChE5CC6JaqK+klZP2bzf5z5tmlB2cDmue9FR74+ZVrTW1nhJ/tGAwu4lUkuorRAXXEfmou3goVBI5ExwKMYzykej8bgcmSKnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760030822; c=relaxed/simple;
	bh=vRQIo87DqjEemD4pYNCv782wvQDRcsie6ER8oA3XJzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzDCS/Cf8ym/MaeVhAV/IJ/DNIV0fDlJoF0joq5lZzaiJHaOW3LdPNHlP6tUjPVD+nObjsrCdZekJBdy9VHrE2RK/np11ZnjRqq/myvz1tRz4wpZ7eG+neoCM+hMAmqrK55hlx8pGaT/+Vlz9J4gKQfQO7F+QlVNDlyqqGQykxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoOMPMCm; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-367444a3e2aso12926661fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760030819; x=1760635619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRQIo87DqjEemD4pYNCv782wvQDRcsie6ER8oA3XJzY=;
        b=UoOMPMCmf4hhXjOrkiLeXhd9FIlmY9KEepZs+lojNlxYPWHzqNMG4cEJI9Az/8xKGa
         UyIdr4kzMGLf4LdhC6cSGB3l4cW1YIdUWfRgmSG/NkX9sxQTCld4yS5f/jk6o8p55TH9
         BKPpeYbh/uy/lW3jbfEfxSpDCrv2N2Qb6eo6l0/yXex8soU5o9IDtNP8gjxHzmJdR+5w
         nVRNASxoO4qMHSj8SzaVnniReTq+7092jGqGJCFwU/NGkmfwIC3BTTNdQixoJ643jZ+I
         PuAEIxw/kqkXOxkaN70QyHITjdUs5H7PG+6/Oh0sXGKeQKMqlMtbQZa0LomPxRp6TyXg
         8m6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760030819; x=1760635619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRQIo87DqjEemD4pYNCv782wvQDRcsie6ER8oA3XJzY=;
        b=aF//FLlRBW1DiXYVWVI86kG1/q7HWG2nvYtPvwg2lhHk44aNSDyfla665cn7468xPf
         REfmMgcKTaGLkNBlFzOPL5gdpB3qVAxDntBOJiiSRpqhs2wbNFUJPtpCA59pcLgrEZj6
         XvGkPJzya0b+qTuLMbDkkpJ6CuQSQWJ59ugL/c3KpW4V/Tlrr8eYgJnKX29HXddNDMWI
         rPyugD8NBQAg66TR/ysNE22rPWh+17HtBvhbGf4PSTY6HRJbvRixnh37lRAlV1LkQmr5
         1nKpHswCDkK5Qq0RPOPkiwdRqpdgqfUNzR5oKbUTNWyIHU1NPmqoFGW7Zixec2g/3MpO
         TiQQ==
X-Gm-Message-State: AOJu0YzGC4xh+O0yzIrEOwp5XmLAoE+JOhGr5TBDK0Iiel0bJlYsQbx+
	IPC51VGIMjtjJbU77kucFHk6cCyfnkgtCJV/FRmlY0Nedz1IFRFkDURzTbXZVpyf35ciZNWMJzv
	oZ1zkRIdB3m4poNN5gSYbDP4aXHfC0NVrYY6k
X-Gm-Gg: ASbGncveZCCPrpMtnAA+lbx0m/7Q9rqR+Dy3NViaf6mAaRMza2jdS+dS2x4pklTSCFx
	LXiuABo1On8vMwrxBIV0E0e3HKMarVLyGs5yzwq5TF+EGflRCZjjVVYYFzM05e7tZY3WJYQPm65
	VBGw8j7ECDrJ3zJLEOoZbURVbXa7IcV0URsK6TtWpQbXNJElzO/RjIR0H8f2YCbOfAQmdmrhkav
	V8+TH2T5QE9A/lzks5nBCzbN+pGIYM677vUtDsZER9zjNrHDyLvvJdwouPxWFk=
X-Google-Smtp-Source: AGHT+IHe9EOnwe0w9E+nMf0F17dd7jAtXVGtTVUJCZhIhZJcM3sQ4yzuaRMF1hBe3oRttwvA4PumqhhM2Tt5LtQGZ54=
X-Received: by 2002:a05:651c:438d:20b0:376:2802:84bc with SMTP id
 38308e7fff4ca-37628028bb9mr5301681fa.48.1760030818408; Thu, 09 Oct 2025
 10:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87v7l03pqe.fsf@osv.gnss.ru> <CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
 <87zfa016bd.fsf@osv.gnss.ru> <CAOMZO5AFer_Yy20fqD9oVSNVPR2ZvvwYbrkSuj7eFgS_uMJC3A@mail.gmail.com>
 <87v7ko11iw.fsf@osv.gnss.ru>
In-Reply-To: <87v7ko11iw.fsf@osv.gnss.ru>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 9 Oct 2025 14:26:46 -0300
X-Gm-Features: AS18NWDBAPpeySn7WFQWxbYhr30CBQJiZRY-uFGiswIoAc5aC5UqU3RmuAMR0uQ
Message-ID: <CAOMZO5C0=vy6aABa6PGrD2iWBBRQ==LfpnRg3BTh_yTSn3vHcA@mail.gmail.com>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
To: Sergey Organov <sorganov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Angelo Dureghello <angelo@kernel-space.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 1:30=E2=80=AFPM Sergey Organov <sorganov@gmail.com> =
wrote:

> Uhh... U-Boot is very old and is heavily modified anyway. I figure our
> local history starts at:
>
> rel_imx_4.1.33_7ulp_beta

I attempted to build a U-Boot from this branch for the imx6sx-sdb
board, but it failed to compile with recent compilers.

If you send me a U-Boot binary for imx6sx-sdb from this branch
off-list, I can give it a try here.

