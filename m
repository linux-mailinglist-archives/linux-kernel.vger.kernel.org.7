Return-Path: <linux-kernel+bounces-855438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB3BBE13A2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 04:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02FB44E77D9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5CD1F4181;
	Thu, 16 Oct 2025 02:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fT5mbzuA"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE9EE573
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760580936; cv=none; b=qe1JQ6PLD9OPFSWrA7k7pUoO9JOOGm9qMQiSFjBtiWtobykKun3p7Aw2OsJTxVqiupBQOOFxyqhtFwZnFOq5WYe0EI1TMCR9tkiCslFi8OaR/EXZMrEUfZWslvWigKiS+9CybxYCUfLn76beJCDvhlsNvMQIkPcmD1PyxqjnhUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760580936; c=relaxed/simple;
	bh=67S2aIF/pfkOX5K2acGDT1zOvhxTeuM1fCJ9Zi55c+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEUy5LCdeVbvwrHvozbEMmIhMG2fnBwv1SWECmqJxGWGupAxysw+N9/pmbbl7G9jbvswJ1ukXuC6v56Y5uGnSis0VJWXu2myOTMFMmvI1X7QFzKdPyIMdE8FJ7xNITfN2rbNbCHaVuO4xBCct9X8Ju+QHOf1PcMP829QkUNgX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fT5mbzuA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-28a5b8b12a1so2436045ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760580934; x=1761185734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67S2aIF/pfkOX5K2acGDT1zOvhxTeuM1fCJ9Zi55c+g=;
        b=fT5mbzuAmxD2eXvzc367v/kjGlWToe/KaxukN8gEX0JqPkCenaRG12L1Ias+sey/K/
         eS9p8HtqLUcA1LKQMwphFi2CQefL+pFrfYZK/cJB1IYc8GZJv1mHqqhTW1s0pV5Y7Pal
         JRbGPE0Y4GzXv+NIAB2nD0Y5tfMTbMP3QxdXpsdxtalpmtCkdb4O9EmQHvtK7vbPROBT
         Q2Zx5wPKSxaxmR9kjrXu907pN2HAo9uL0T4eHQyoaGlyQ2objTDe5uNuWXHs9oYhKHio
         fuA5PbI5KpHc2gGK6H4Jt4kWsG9I0iHnKaNft4N+9RCYtZcfX2SzVZfviVs2HDnSODg3
         Qlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760580934; x=1761185734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67S2aIF/pfkOX5K2acGDT1zOvhxTeuM1fCJ9Zi55c+g=;
        b=hRvb4YnkX298CdwsOM5HzY2uN2VI8rIIyReSoi0X/XW+no7W+4iLl0rR7j2hMXhzrm
         Xf4xKAjteB9oe+Ui4LMwxT/XIxzRjL07cOHwRheDz/xP9Ur7DLAxoVd84s/+MITL66P/
         gXV9qALSo41Jn1WV5BZCveRbXs8YOI8PBs9AXCJxO4Ygc0cIK9eoURH2UtJc8Rf8OtEt
         0oouz6Di4En/K7iJBtNFh2RJA9SXBzX85Dth9my0ojbk+fQ9fblFc9nGPC6R/m8RuBJz
         LRY5wX5ZKqc+EhGppAEF+PYHRUVZgZj9iIu0vv1PuLlPLgrr4s3dzkpoJEDcYwUT2PbA
         wk0A==
X-Forwarded-Encrypted: i=1; AJvYcCXIa98y1w5O6LjCx5iIoOzVl3i/X86sVTr6CCMMZEcIGEkUCi7zOdHflX1A15h0158v61h310VLk3YhXAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhGzcWGSBoj41McyAnnFjXoBPTdnryFTt+a0FWP8J/XuI+pP/t
	qAwW5p5O/PLO8lFa4bUq/+lGfQFMWqhT3w4nitzruiEGmKe9TyD2Ez8ZklhLYD/Srzh0BpI54G0
	5rEpHUgSOqt0WZt484yLotOWoNqGn/Uw=
X-Gm-Gg: ASbGnctZsOBS8/S10eFr/HLLdor/q7UzBbM95lasVfSXKBT0BTf3oyBIvsImUgpYrLq
	p2gtqrjGP+OhBYj17OEYA2ybVzdjRr3vV432Qbwnhdl4ihCKCzIRu3GeUtg+lihRWfYXLWaMgUD
	k5oURwf8CAxm03M51bAbOaQjNvjUl1ay05ScIReInTb3BhYj+KD/ACxdjMrUCWdn1EgNrFKsX0l
	At4DIeaXEdpoc177ctAQB+hXWZyZUEPGKzXbEZJ/a3kcLxmFkALHLfH8vOT
X-Google-Smtp-Source: AGHT+IEvRoOtfZkD7JBaJ7rZGlNV110A7XDi8jf3vUgY9Fd8pd0a5HquzKeGR4HlB+RP5ldM64qTIlUt/S7CQGX+WI8=
X-Received: by 2002:a17:903:1447:b0:248:ff5a:b768 with SMTP id
 d9443c01a7336-29027356a2cmr375723705ad.10.1760580934134; Wed, 15 Oct 2025
 19:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015183402.1649988-1-kriish.sharma2006@gmail.com> <aPA18fxQW398WHte@archie.me>
In-Reply-To: <aPA18fxQW398WHte@archie.me>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Thu, 16 Oct 2025 07:45:22 +0530
X-Gm-Features: AS18NWD2IGlwVYDG7C9iI2e3l9CLdrdvxxJHaMKCdoRSM9GgL7yUi4oi3QL3np4
Message-ID: <CAL4kbRMQCMqnjLq6tXCuGXfGZWMAN+Jn-oQ0Ljzc_WLG3rUazw@mail.gmail.com>
Subject: Re: [PATCH] htmldocs: userspace-api/dma-buf-heaps.rst: fix block
 quote warning
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: sumit.semwal@linaro.org, benjamin.gaignard@collabora.com, 
	Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com, 
	corbet@lwn.net, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review, Bagas.

I've sent a v2 with the corrected Fixes tag as you suggested:
https://lore.kernel.org/all/20251016020912.1653230-1-kriish.sharma2006@gmai=
l.com/

Thanks,
Kriish


On Thu, Oct 16, 2025 at 5:31=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On Wed, Oct 15, 2025 at 06:34:02PM +0000, Kriish Sharma wrote:
> > Fixes: 1fdbb3ff1233 ("Add linux-next specific files for 20251015")
>
> The correct blamed fixes should've been:
>
> Fixes: 507211e3c7a1 ("Documentation: dma-buf: heaps: Add naming guideline=
s")
>
> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara

