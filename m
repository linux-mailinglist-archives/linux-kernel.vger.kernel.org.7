Return-Path: <linux-kernel+bounces-838089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DBBBAE67C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F8A1943EA4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1902128541F;
	Tue, 30 Sep 2025 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNr43fGH"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FD5226D17
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759259491; cv=none; b=nj3JdD6STafxNxSM9B71cXthQlKuC8pPjpyh04z5cMOY6ahMeHLupJSMXjVeq3i93DfC1G3z+IpNUHX1ciVNo6XFCmk3HiWMJGOUne+o5az0PPHNRq0aQQJLDTRvl1XH9wzVKXaO1p6DMXd5Pvi49ST+1A3511zXbuklbKMAJR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759259491; c=relaxed/simple;
	bh=OnydgEP8yA8NDAeS8Ec8dVhZ/ZS9n+ZcfxONpxaOdho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m2us5ovD3QMULq1FvsX6a4Q0sGqq0VAgHPW812BnJ74FQR3edgfS2sb3rQol/Ib5fWJW5jsjPRPMeGXJBgo2xV5c6/yTcvC+W3vPhD/RTAgAclF3ogTYUsDhFVfoaB1mLXNZI9P0TlygXGSPSyYSdP1m7zgHSXqOHi+wU34cKFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNr43fGH; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3737d0920e6so20039981fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759259488; x=1759864288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnydgEP8yA8NDAeS8Ec8dVhZ/ZS9n+ZcfxONpxaOdho=;
        b=DNr43fGHZiKuwm78nOv1uSFhqrrp+BY0BHMWefuedLEs6zm0SDjbidsj+HEdE+xCWR
         kdc6RMEri2Du+C2Xeprj1kKw+rQirIT0ci2nDvo+GxIo6/QKvNOGEKjLsxTjyHJPFX/q
         JJTcD9NbOocusMQJttJY0AR2wMkgJrNFuOLMvGuymLeUDX5iRZd1blDBpE6pjs2A+r7I
         kjzLTWVm6qZ4Jar+ZiPliGhBPEoIA8f2x5jqu2a08GPt3e06aKIPIWDRSsv5J/0+8eMJ
         4UL00PJnmWrgTiw6DWcvdrL8ypreWMSJiS8Tz5jfO+lff/su5ZTBLqBCRFeXaQW5ogZy
         ckJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759259488; x=1759864288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnydgEP8yA8NDAeS8Ec8dVhZ/ZS9n+ZcfxONpxaOdho=;
        b=Lts19i7sTl+1Dh51ny14NLJET651/x11hDyRsTveaXYl1TjULYOyfKeI0HQRDsw29O
         QDIWXwhnaCIqG6o8aLdFBKJD0oT3Q1RcZZz7xMi7e1zqRzGC0fAtagbc10ufpQZ5svvl
         D5KDva9bkjUjXvSHoSkpRDGNNs5Z0Y12mVCAi9hvdMNXRHw+vGJxSLCcCFXxbz1ugQ5r
         Yn7SieEUbIx/HcxpZAjXF1UclHwCCdq8YiJwr+Lj1n+njjd8JnnMEkZcJrpDRHqJ2bmk
         4qawI20bwPeKpVS+5LD+owmXKmVB77OOM5mgEXBYhV3IUvQB+ADOVNZuzk10ejud3PsM
         F/Og==
X-Gm-Message-State: AOJu0YwjZcAJTkjaKWJW0y775ruzsGDIaq3pcApTrU/cCsbRdRuIo4Rv
	m9iziJGNnByJq+PQd14aESSztzjVqPVUySwZqS2JgmFTavTjkf2/Y08ohHZYgac1EFIiDmsVmWj
	ZohtbIqMrCzcCxtd5r+jnfkvcsEgkNow=
X-Gm-Gg: ASbGnct1MnhYT+wqM3X70iJj9JVqZh+x7GX1C2/2T3QD9BswE/LxPypdzSSSJJrlVXq
	LUQcALsyu+MvggkTCjfv+ycYfM+DeI8ufnhFiiJNtKqbOgCC1AFsdsvBg3J5yKJIFwKxot6X4Zk
	GkwX212JWF1jtLFKDNHOTnFP5BWsLkEpLrJD2zcDXACLYgvu23sx7i2wm/+pq6aOwGpxPQxVdQ6
	UN/NRJAyu1+mNdF8o+Csp/S4L5urf4TAm/cWnSex78gT4+o77rVCe9xhyqq1HaCwVfu226v6g==
X-Google-Smtp-Source: AGHT+IExlsJRpWt/L+UdHxFuQFFp/wkAiRX11oKUzkwoXKwtcIWPqFqnYuRmtaCvLBvsE4swHepR5JJEKuNTUOXVs04=
X-Received: by 2002:a2e:b890:0:b0:372:368f:8b67 with SMTP id
 38308e7fff4ca-373a73eae0bmr1747231fa.27.1759259487540; Tue, 30 Sep 2025
 12:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87v7l03pqe.fsf@osv.gnss.ru> <CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
In-Reply-To: <CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 30 Sep 2025 16:11:16 -0300
X-Gm-Features: AS18NWBw2I7ewXAh47Bry9TTdQOQ_5TJrYZpBm_mmk5i8M2jmFOD5kK3SegJOrs
Message-ID: <CAOMZO5BtXsjFFWDbt=Zuy_sUS-HySkcjhrtAg3+k211VY8SMcw@mail.gmail.com>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
To: Sergey Organov <sorganov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>, Anson Huang <Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 4:09=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> I tried booting 6.17 on an imx6sx-sdb board and it booted successfully:

I forgot to say that I have used the imx_v6_v7_defconfig.

