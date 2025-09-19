Return-Path: <linux-kernel+bounces-823942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470E2B87C71
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F299A580F13
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F0423770D;
	Fri, 19 Sep 2025 03:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQVxOCEb"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC24230D14
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758251767; cv=none; b=jhY+NsDEMJqfVHdnf0Caa59OkOlgW3yONi5lHSP6xS+HRgzWdB4IUGIoH+m22hyeJGpI2IBG6OZUjx/QnOAXk7VwATm6LZJtQRUa6iULT9hClDe+kbOgJr81Ah65pMahxZur2K+MM6IRuKTi/LkNHoJOEmL4maTNhYX5uzk42O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758251767; c=relaxed/simple;
	bh=SKwgfiNki99HQfE+BDZ76jqOzfurZlN2ZbRA0KdOE1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8Cf04SvUGES2oWn3hF9AwXD6CFsXbKGAwJyOZmb9M7gzkovGsjHCfTuSmRk/onvI0cj6bSGcUAhXksYXLjfJZpLzr+ZBwCc7U3Xe9p1IqvvGY3HfilnCmk1tISlCfyvy2LcWk9jwqXgX7sGgJ8zDKXsGEcbbeW3oWCcECwrp18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQVxOCEb; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62fc14af3fbso799881a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758251764; x=1758856564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SKwgfiNki99HQfE+BDZ76jqOzfurZlN2ZbRA0KdOE1M=;
        b=fQVxOCEbPGqx+dyhkUUZdDEk4b63Zk/s12muZ+R6pMhxdVG86lkIAXMQFVv7314MMj
         bAMQglMPKlwdjtszbOvFLJU+EiK6GjIAxrrZawu2rzJ1cuX2gHE2rNY3YwiRne38pIuj
         90oi2TzIvuU6krD29TnDAuE60mGfJGZ9iFM1hyjFPQ5Csp+CHPa3/mONCLa7xDtxpuXW
         zmz+/da8FrjWBr9LeDtMWNBm84ArE8t8uWF4s5aVq0o1tOpRbwH1wMiXOZaucC6TSZ7L
         A+GhSnfVU98fPnDScZPPyZby28hX/i0gHspmQLSjy7p84RG7Oh7gV1Enhd3JFKKib6TV
         JgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758251764; x=1758856564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKwgfiNki99HQfE+BDZ76jqOzfurZlN2ZbRA0KdOE1M=;
        b=LdRKFuv+hfEYGyhPwTyvz6Sgg198j0BXqKwwHG+/JhCZm0G77l1UpSv2QPvAhtNqDC
         0uaQaCzWAf+RdOesb54AQl4SNXti6trKgjEKUfKQ/TVmwXjRdjJ1wqscFJyQhr/mL+V+
         hxx1VbaGaufhFrzSRKTmQ61eDiKIpTUCy4/PxYvkYC7f2tZ4q0Yya0rPHPTc/UHmU8gX
         p1skcx+hFGt5fx7IGrt/t1AC6RiGm2nseXkpRZP2S4rXDFSUxmrgEKtSLYA2+2A96c4Q
         2l+nPvOwQOwRNblHHQRDgNJXZjw1u9vHtehcw+DoL+Ke/xCI1Jbd6ELupopIeszglyxm
         uoNA==
X-Forwarded-Encrypted: i=1; AJvYcCVBolIpd78kn8r/3JW0oSw7t846X6Vw8i2t3hRDEi3v2eaxrhALO+/w5/AZGisn0QbGo7WM1nRD5dkYgqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYQi3XqhoCbBMsiAaDwtZuw4d7IAnWrzrkulU2iaWqMK4plOxG
	oo9i7GjezgPjcMOOjtwmMih/zrly5dJomfMgKx+7nVxAVzchJjsA/6XekMyJ+kgCZHekq0U4mMQ
	nnF1sGsxVF/3u8BehAqBh3tuol00Owx7a7Rz9Xik=
X-Gm-Gg: ASbGncskaYg8Ol4GyCyQGw6AgJMXEtuSHP3HAnynpnRwHtNK5yx4nF5nHy2K4dfh/6d
	KCQ+uwU97GETn8pavu9JyiZsYGvbF2WLbpY+68L/SNrGfoQsexTyyS12TT10dOy+slXeRj/S+HL
	uzF61ZpoSaIl4HBQwOEYVi7vghkNrmUC+fglN4Yl9TOj06Cgbv3iyoUYNFxIRy2G08c7J1ULpvJ
	aSzgSsr
X-Google-Smtp-Source: AGHT+IHpuZQvB5VjDIkqb6EILgkWDUV5pQg8TL4O9i66Ma8EIkoa3WtmJBAeGAlFDqdQk9Kqs1c+lPs2vKiXQxoNaR0=
X-Received: by 2002:a05:6402:51c7:b0:62f:3531:d905 with SMTP id
 4fb4d7f45d1cf-62fbff7b4bbmr1183252a12.0.1758251764087; Thu, 18 Sep 2025
 20:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917100657.1535424-1-hanguidong02@gmail.com>
 <a321729d-f8a1-4901-ae9d-f08339b5093b@linux.dev> <CALbr=LZFZP3ioRmRx1T4Xm=LpPXRsDhkNMxM9dYrfE5nOuknNg@mail.gmail.com>
 <abc0f24a-33dc-4a64-a293-65683f52dd42@linux.dev>
In-Reply-To: <abc0f24a-33dc-4a64-a293-65683f52dd42@linux.dev>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Fri, 19 Sep 2025 11:15:28 +0800
X-Gm-Features: AS18NWBWy3JSGoTuAR7nCC9TldQxYSoxjAO81Iqekfd37aXEUhor2yl6szKD32M
Message-ID: <CAOPYjvb1vEzgRM_m=FsjDTTuyGMWpxgK7UfmS458rbN6orVjtg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Fix race in do_task() when draining
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, stable@vger.kernel.org, rpearsonhpe@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Thanks a lot for your detailed explanations. Could you update the commit
> logs to reflect the points you explained above?

Hi Yanjun,

Fixed in the patch v2.
Thanks!

Regards,
Han

