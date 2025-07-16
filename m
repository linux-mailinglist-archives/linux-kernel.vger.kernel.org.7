Return-Path: <linux-kernel+bounces-733484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76132B07544
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA993BA0A3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F242F49E5;
	Wed, 16 Jul 2025 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DKWIEuwd"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C036B1FECB0
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752667455; cv=none; b=NJKEO5UjReo8I0Kih5F1SPKp8RaJpdHWmUJ6m9E2+Xs+EEUJtwOjwzHHbC79pIClQizMbrk6PzaCFeIoQmibwOvf53mvq2CclaM5wJk38IjJA0CKTT2QwjGZbK344+fA1uMkCgHxa3nE/z4VJqG6ZGe4iVewJFd7O9m+bxPzrLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752667455; c=relaxed/simple;
	bh=TvaafB06rCr8tuOU9vZPWgCbFPy7lxlkirtCxoG7TnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugsCu1jXY2DSf7GzF86uCBHXdq+Qx6tnjCbqy/LAvFS43p4gp9KRAF4qH0UCgqHXapX9rcX9HmgM5N92ro3eSb7h/0+XlLewG/q93iRFLdxurmvjH/zoHEMzmVkykY43PPNJJdWAoxrrF4YdSZxMu+0WfRA/U4nXk6xmVihbMSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DKWIEuwd; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so13351938a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752667452; x=1753272252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lsXEE1hISIb4cJAFw3dYr+DwstAQXXeJCNfdlxzLq1c=;
        b=DKWIEuwdV3WfAvD59J3wSXUSNPGCXpxIbgmNYePCmgf9TRt7rzkjeo7wygymi1F3qX
         th9mPmmdC8O+Io47KjXRJT6Ym5JxSfilh5jxpUjWSFc3mHSKg+bVBCwQIQdw//5Ek13R
         z0MHerMgQyQkeuPaxo2AN/P+rEoMbZMe7t9m++BNZIGsm27cE3L9REYAWLZMp+8De1wo
         P1qZLCg6uLPZrzsxIG5xwyBGlf4Gm/5Gj5frtCd2ioofKVt55vIjzucAaysMgeCU567g
         /5LSxauKDhRm+4dzVtu8GTippY8jEsgR4OR0kPuXh4iMa/+oa42D6Ns/+kSByzVcytou
         AQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752667452; x=1753272252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsXEE1hISIb4cJAFw3dYr+DwstAQXXeJCNfdlxzLq1c=;
        b=A/ImfPIJD/h6r02mmfENTRRfgNNAFt0nlzw11jzvzouwclHzrT+huT963oV4qj2UUA
         xJ/afEieoQeqqT0/AfF6c48GMMczxbb76vUmB+Ey8rhcay25Y/QcA59QdeYP16KBCxt+
         IhLY/vkC6lln0XbNx04q0wHvxe7j2A612EaBNZ4rJ5stiB+PPotwqPJQq0C+vrunw18o
         6FYcM+yNXaAtk2r319Rdu805X+zJzCKY6OXE7VvcyVLY3rgSRcc7lHW4L/amtiN6TIMb
         PvIAO9ePtHtv3J/tOsY02Q9qH3YhXdtdRm4T1YesdO40SxMXIkKks2mp/OVEhuv7Q0IM
         +fFg==
X-Forwarded-Encrypted: i=1; AJvYcCUrq4C6AyVX4ZNp+tNyAvq1fVzhyBxv75KX+FlhrdJOm2dJcnagCVcJTreH4xvfQ/DvH4wYb0NmolzyvdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQVTIg/VM0mFsjVnnHpBqnl8FMfVEmVhDm27W6gZe2I/lxmMiB
	tdmW1QFPJEDOxH99SOrF0nauU6vv/FhG2PXlzs0mWhE5nV9n0aJtSFnTeQWMws0Rqfw=
X-Gm-Gg: ASbGncsB/Pf5UAJDpm9FFTmvrIh2rJnnYfVvtM3+40jE5eqxX3Nah+MnmfNqYmQ9UlN
	gXogrNfYvEKFrcsYfZFv0Ugl/UYOHMTQVc00SWxzFQIOc4ZZlvJOwDDrt5YsWc5LvqD3HgzAFNr
	Vxek4XQzw7qoaox72GOA8BwfXtZGQd4X2n0dBT5bpxHgR96FzzkDDzBlBLsgl/oslFqGkUyUh3L
	pTDx9MKT0OfbJu1zyOVewFsLK1wmmcFWpamN2+aWCco9i5R8sksVf2nFCJk5txi1O6Sn0823Kq5
	Xn4dqUfV7Y/bno+sxxTVtFvLktIYv/9HRAJ6RbPYPr+brMe3V3RRT1Z9n6FtEgzoUwCJIaE8qV/
	mwWh3cOOgO9gVh9Dy8H/TvnCLGcoM7g==
X-Google-Smtp-Source: AGHT+IEhSGvwKZCfWmTvLUG6dGYIJWTd4OdkmaI9VTlT7Ykv1sEpL5pIQSQFmLdV3hms4bc49wFnVQ==
X-Received: by 2002:a05:6402:348a:b0:606:df70:7aa2 with SMTP id 4fb4d7f45d1cf-61285bf41c5mr2186091a12.31.1752667451997;
        Wed, 16 Jul 2025 05:04:11 -0700 (PDT)
Received: from linaro.org ([82.79.186.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c976d9f7sm8622193a12.54.2025.07.16.05.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:04:11 -0700 (PDT)
Date: Wed, 16 Jul 2025 15:04:09 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: imx@lists.linux.dev, Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
	Frank Li <frank.li@nxp.com>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] clk: imx95-blk-ctl: Save platform data in
 imx95_blk_ctl structure
Message-ID: <aHeVOYUhLu8uIhFe@linaro.org>
References: <20250716081519.3400158-1-laurentiu.palcu@oss.nxp.com>
 <20250716081519.3400158-2-laurentiu.palcu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716081519.3400158-2-laurentiu.palcu@oss.nxp.com>

On 25-07-16 11:15:05, Laurentiu Palcu wrote:
> Currently, besides probe(), the platform data is read in both suspend()
> and resume(). Let's avoid this by making pdata a member of imx95_blk_ctl
> structure.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

