Return-Path: <linux-kernel+bounces-813491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 337C9B5462C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E4446267A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACFC274666;
	Fri, 12 Sep 2025 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaF+QRyo"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680F519B3EC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667522; cv=none; b=TXIojmmJsRs7AKusV2msbOwEHyByficNXqLSMKz8mBbzg4+9r0FLF5l7G3G7NgPxGpxW7qMoWnRBktQzWS8kcK8EgKZUg6iP+FqC+OixKbJ4Curdy1L6THEDLVwbLw6ze6FpSe/NPSY4ndHjKW4cVxEul7Qowy3gWSaKzZNvyaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667522; c=relaxed/simple;
	bh=ro8PZYwRD9DQ2WA2wyE5JTGfo06TRzy3FDdEN0mwaow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPcoCEyjDu+2VmehcI515xf82GroGDbmAfqJMCGb0YeWF+6zH+CXy5Xgur+RRBpQQhbg0yzjGE3cu3RCnrWNUmjWnZZLbgzJNjeBIntNjGcHrDyAbBlU1YGaJ2GAxsX1t4wvFSXZXoeLWJ4SKsWaxED9C5J5YNY0/+axelrMpBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaF+QRyo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-25caef29325so11452115ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757667521; x=1758272321; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ro8PZYwRD9DQ2WA2wyE5JTGfo06TRzy3FDdEN0mwaow=;
        b=MaF+QRyoFYU20kgbKaK75dG1TbU8x9HgnrmOBAv5ZMD4CRSMWYEmo44ng+PpHv/ZS9
         zyVSd4qsOfgbPdXqUgzoPoOfURQerp+hbi/f6ZqJCZPJVLPnWrOl/ZUMk7age4wLQUvt
         snHa/rg5XOoP+IWsdRXKcd9QjlLK8zxYE1/XIi8FrSQUiFStgGvqrXT/zNrHpkViie0v
         1GCnjCgL19U8ry1b+AkaZcO2v2l+RSaxcF4ckPz3nGsYV9npWRQeBmMMjzWJbJskcDbq
         1swsR/ehTnESigAP9+CvkAx3eSgY3koqQb2iFC6IuKAjUgsioRg7LM0sad5wNAgFyS6A
         HzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757667521; x=1758272321;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ro8PZYwRD9DQ2WA2wyE5JTGfo06TRzy3FDdEN0mwaow=;
        b=DPSEU4As2KvNj8jyuGLrZ6qL6GJGY/R+jptgwzWZz11NeYHWeW79mplZW7cYmsYJcT
         yt3O7Qeu1LS8Wnnb+SEP4xaalqPXkp4byzINNiHBQIOh7a3dpGhj3Ureb98YwkaM5FBo
         ayXsD53wN+tazknBzNfMWXsTtbfI6o8x7t5RdXrdgMlz2ABlnpsJtPEcnDBSICLy2I5R
         eWD6KcG2YFHrKKaWedkFWD8azaM/7KTYr2qUUERsDJ+dqeNF0P4HDk1ASC7IgbzxSk99
         VDmJq+4vd+xiiX77mo/jB901eZUdxEARMQuKe/UXK9eh8PvgllnGkqnaGcFYnJ9hnXep
         IQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIUt0JXCxp9YxbMxYChk0thb1bmIXaoAmgRJBlV4sIem8VdW+C4U/BHh7FK1vqy8pgxMb9XnxhlquOALY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIgrnFvPNBn7Kj+A1Kdw312wMUT3ngDR9ubXxY1LvnrMVSPuNN
	scZHHJOoY5NL0/HWuY+qxoyb0HW4G/sKmpI1ZZCJ7Z/lCfV3JX6l9Dp2WCK4KLhgeAzPPyJKAcV
	TVgy7IT4NzTSLCB3xyH1vDYY/SGyFFUDSJg==
X-Gm-Gg: ASbGncv7LZnRCfAER7/t9zwCMaO5Y3t1t4FpQh8Ca7s0ts4SxFQzBv6q4XtwUGiPO+s
	zizJun7AGS2x/or6jEUzXUuatc9t57S44RW6Hj71af44BM5i/1kQB56GymdO9UFhYTUdgHKSmrj
	ehbuIRsDdWZd+YWnLyw5bZWAknXZkk6kf/MTZTax4m/MNqLwXBc1zoZNAZgX00GRyL2uZFYbL6/
	U8mLSJBt2tEpqVpodBB/L43REGS4ReqSe+LyRdI8C2zkTD8p5LllmHq0Lo=
X-Google-Smtp-Source: AGHT+IFQRimSGNTZUF8rsCECFnkgLkqZ++YXJEJA7EhcHsbtO0t6DFoZ5dfeGu/99EC1Bwvu0xIa9exB4T1QYyticTg=
X-Received: by 2002:a17:903:3888:b0:248:9e56:e806 with SMTP id
 d9443c01a7336-25d24100ebemr28596975ad.12.1757667520671; Fri, 12 Sep 2025
 01:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-imx-rproc-cleanup-v2-0-10386685b8a9@nxp.com>
 <20250910-imx-rproc-cleanup-v2-6-10386685b8a9@nxp.com> <aMGe/gwmFqjoFszg@lizhi-Precision-Tower-5810>
 <PAXPR04MB8459CABA152B6C1C122B35F28809A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250912061120.GA27864@nxa18884-linux.ap.freescale.net>
In-Reply-To: <20250912061120.GA27864@nxa18884-linux.ap.freescale.net>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 12 Sep 2025 11:58:23 +0300
X-Gm-Features: Ac12FXwYlGvGgqyGXugiWWObiJmtXxlEmnlZ40W_NSnxtz2WGuiuVYkoCU-Wo6s
Message-ID: <CAEnQRZB-yoV+BYsM-9CvmuSZw_8EF3ijtZhqtBoJOoyUc+-pSw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] remoteproc: imx_rproc: Clean up after ops introduction
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Frank Li <frank.li@nxp.com>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Hiago De Franco <hiago.franco@toradex.com>, 
	"linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

<snip>

> >> Can you remove 'method' in data struct also?
> >
> >The method is used in other places and other purpose, imx_rproc_detach
> >imx_rproc_put_scu, imx_rproc_remove, it is also referred
> >imx_dsp_rproc.c.
> >
> >Could we keep it for now?
>
> The method could not be removed from the data structure, because it is also
> used in imx_dsp_rproc.c.
>
> I have a few more patches to do further cleanup, but that would make
> the patchset a bit larger. I would like to see Mathieu's view.
>
> Mathieu,
>
> Do you expect me to add more patches in V3 to cleanup other parts or
> we could keep the patchset size as it is, with further cleanup in
> a standalone new patchset?

I would go with this as it is now. It is easy and clean. Lets always
go into small increments, test them across all the hardware we have.

Then we could come with the next patch series.

