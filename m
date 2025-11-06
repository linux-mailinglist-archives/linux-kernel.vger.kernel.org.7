Return-Path: <linux-kernel+bounces-887806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91806C39216
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 06:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAB3189D6D8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 05:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8295D2C21DC;
	Thu,  6 Nov 2025 05:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGWl50ho"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB1628695
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 05:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762405397; cv=none; b=oLrr2nDlrcfXROmWn9OdswIA7rNGx9kz5Ly4aceiNTmFacJRWwk8TXDzphO3IQSi2j4Amt4g5eFFNfYLIw/8RnzidWibQ8tptoTlN6hiGMgm6bxZP14E5d8i56Y8Q0y86wsubpUMtU+IOHx4XViSsX+oTDkCLtT71KskNA+jvy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762405397; c=relaxed/simple;
	bh=EvcrG3dDGncaL739yj1nMubM8EpRLHOh2MgJIi094OU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNFJ6+S8rljtqc+1Wxz7RdZ1Xvr/W92mTv68q4N/Pl+AAjRw3FZ3xc13Gx7PzCdX/lAa5uhRhMWkvhUYM2MrZEZnoY8/J+yqm8aBtIfFzxARCt6rtQFdgShlIojFGbZ2b4qm0usym5RD405UljVaci8oqS+tFYqLlOrRwE2kwo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGWl50ho; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so1088695a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 21:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762405396; x=1763010196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvcrG3dDGncaL739yj1nMubM8EpRLHOh2MgJIi094OU=;
        b=PGWl50hoLXqBoiz5k1atMyyqYuxDFlIS1xqH1F1J7gY02ih/OBBCBbhcvlYqi+HefP
         oWpLWMyyrWX9p6Y2ySWM9aXcrQbffegzleeczde/KQaGTy7EhDfzjHxAABTXb9ZdXd/q
         v0h7p7A91LykxCMuOHRDuiomxd6mzJGtdFQZIXy5PYgY/3jAZSh0xWd/x546CZWzLHHa
         KAsg/rqDirONtZeGvmkU0KO7z4Zn9AW5vVprMtaXR4FPbbMrZpYEAOnKvlWIJkhAXalF
         u9aNTH5LOGd6YkpgQbEW/cpFz9hGMbYKJL+8DHQFYl5ikYGjOWIKVWGMD7W/7o95CVkm
         XfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762405396; x=1763010196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EvcrG3dDGncaL739yj1nMubM8EpRLHOh2MgJIi094OU=;
        b=mS5QaydEgByp+F2/NILVJrdk2tPWCVigmAWNBca5QgYGUGLKf7gcLGnMbfGtiXhg95
         CyDW6ZvUavab+sA9hQ9GVU0CYdOXIb9SZfnZ6v71LbYQ2+fKv6KEfzJBJPN2h5pLuDdv
         UlCudjZxDtTsZtW4zqC6HcwWfutq0HzZsKHpgATzm3PdeWCVLlGxJXsmZnrangvd5iK8
         L4p6M4txaJZ4ZGmsqVJNDAQNeVV8hEdNFkpfk4XAktuMSZMBw/6+qMgrex5ADBlFyUhd
         GG8g+A/zu69ChAtdR9u3WNaqu9V4KlJjB+Yl9NZz0KD4YI8IhyQhQ5ecyDqYezmbL1Yp
         j81Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiyrZWDV8MDaFv2w+IWSNjSqCRG6TkuS/9O1VHj6ZlzwOh5crlyw6TqNhNMRrtiC1WkT89d/sn+OMele8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJfStrU2Ej2aR8DDVCkRGfH+Zi36EtXPHKr51W8J3uSVzr+b2k
	K5Ng2wAzZuhxHWURNSeLR4RrGnIC0nnerJdoWyHZbQO4x5y9H9sRhRBcNLI31DXjib7xsD4mUE+
	nFBSM1K5vDqexi1rreQ1lPjUWEDL5lhY=
X-Gm-Gg: ASbGncuGTwEPr3uYGT5OUl2MfqEwvI/4+zU3IvrowybNwUam22xd0NFh6bYt4kX8RGz
	eKFE7H6rfP27FmmkccVkWPmYIBC7SvresfFCeFS3FG8P7jrXRru4UKAxnoGEgdIFDSnGfVoDRvy
	WenTaUIK/740LrmCFHdKAEQ/ZD5ksFsZhvM6KNpMlkKbuVpnSNwIVIL06Zt9n+0Uh02ffnn0H9+
	JKLYc+diKcB434RHuaoj0AQ8T/4lIwDu/0qjjCQQMpgukNMBARQ/bltnA5Uoh6H5AR1Vy9ocAII
	W42Wyl8nOLziyWkkEfM=
X-Google-Smtp-Source: AGHT+IHrzZ1/4Im3y8/huzYUwmXZhSlgvoJLEyQxj5Zo/aAIeNAwDkLVT9KBvnRTTtAYY599LBT0I1aztN6PiD0fTwc=
X-Received: by 2002:a17:902:f601:b0:290:ad7a:bb50 with SMTP id
 d9443c01a7336-29651a60c70mr19004155ad.27.1762405395674; Wed, 05 Nov 2025
 21:03:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101052651.6197-1-opensource206@gmail.com> <959ac74b-a8b7-4d4e-9d34-3b3d971f9f8a@linuxfoundation.org>
In-Reply-To: <959ac74b-a8b7-4d4e-9d34-3b3d971f9f8a@linuxfoundation.org>
From: opensource india <opensource206@gmail.com>
Date: Thu, 6 Nov 2025 10:33:04 +0530
X-Gm-Features: AWmQ_bmtfdYLunGxnebB2YzfbIByDDfiElXZmfRrWBesyRCRzuiHt6fwI6_gKWU
Message-ID: <CAKPKb8-nFzqgh+k3aBxUvZ8g28usiAt5BEdFDQysVnCk3S+sEg@mail.gmail.com>
Subject: Re: [PATCH] media: vimc: add RGB/YUV input entity implementation
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: kieran.bingham@ideasonboard.com, mchehab@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Wed, Nov 5, 2025 at 10:43=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 10/31/25 23:26, Pavan Bobba wrote:
> > Introduce a new vimc-input entity to simulate a color frame source in t=
he
> > Virtual Media Controller (VIMC) pipeline. This entity outputs RGB888 fr=
ames
> > and allows testing of pipelines that start from a pre-processed RGB/YUV
> > source instead of a raw Bayer sensor.
> >
> > The patch adds vimc-input.c with basic pad operations for format
> > enumeration, get/set, and stream enable/disable handlers. The entity is
> > registered in the VIMC core configuration, replacing the previous tempo=
rary
> > use of vimc-sensor. Frame generation is not yet implemented and remains=
 a
> > TODO for future work.
> >
> > This change enables link validation and format negotiation for the
> > RGB/YUV input path, paving the way for software frame injection and
> > test-pattern generation.
> >
> > Signed-off-by: Pavan Bobba <opensource206@gmail.com>
>
> I see 4 patches - are they dependent then gerenrate a sries
> with cover letter explaining the changes you are making.
>
> thanks,
> -- Shuah

even though all 4 patches are part of vimc driver,
these are independent patches

