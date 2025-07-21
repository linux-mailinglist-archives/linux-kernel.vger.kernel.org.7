Return-Path: <linux-kernel+bounces-738525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5988B0B99C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61BA18980B6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 00:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04E113C81B;
	Mon, 21 Jul 2025 00:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="m6x7ny8B"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A2A1A29A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 00:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753058559; cv=none; b=N851eGUS17u+08SFmTqhbgcbFkz1zvEPQq3Gwpipk0FFGL2flgG8HM4sUAHaVsacGL6j5CbKfaTr4OmtIhZD9olyZ+PEkivmYASzgX/wFbDBKe0bVin7IKfF+I3QFos10THXsPZVwf7iGh4u/XLDSZl3pfWpB/DAWyrKJ7i0gb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753058559; c=relaxed/simple;
	bh=qxOrhzqyG9kCjTWQu+y6SKTJcaE8DX9D+ByMeTUpNHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHML7q0A+CNlpcte7vRikKZ6/b95K9tNtptdKavkUp9CZFuBeYsu/mKNLeWI00L3VusP/iVVwAOXifnSJDmclBqmOGUfXFdtAAgETH6tbcjVtnQHvwrT2NAkhDM1Jh0u4XUQqbW9YQgjOGUlTzVt9wGTTtSy4ib0rFWzx+ENvsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=m6x7ny8B; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ab8403b6daso40434711cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 17:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1753058556; x=1753663356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5plOGEMFaS45Bgu/ju0R5BnX8oJZ/qxxofN4PLKzGiU=;
        b=m6x7ny8BDJ3rc0hT3I0QAjGWmpsetk39SMaVruYVXSyk8MkUy9BkkgHKjef7f5De3h
         YFdYHPowq2S27QHuF7uoiOst2t2MBXaQzFBpRvyBJbA0bNeDlzOV6g7QpW0wAwk8REsW
         JrA++QZcPbN5GRNtMa2McNu67+8IPCowHeCDwn+2fM5Zq/EjR3lOU5aJe3Wh23pL9Ul5
         n6Tc3TFGMwH5Q9yHpxgMfYBlV2wmgs1uU62S5cxMzxlFGQZ1BuHtg6RNSGyo61oL39or
         +ymypN3uOzT2N9JGv/YDGDHpq+OsKtP8IvHxAErhGU+Nn+SqTxkNdIaRcyhif8Nt+udY
         N+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753058556; x=1753663356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5plOGEMFaS45Bgu/ju0R5BnX8oJZ/qxxofN4PLKzGiU=;
        b=fOBN/IZ/qVTfED04vfExQkBGmqwKWoEZjdfNEg5MRMngcZU7gDyQRww7vzxW3sO0OT
         75scZsnvDBZJCh3Nc4TwXD/eTUgsCtLFg6vgQJ5aYPn2RHch/7VouZ1AvcHKqpOTPb/g
         EvWcA/MpWoj7zriDqDZYgdsAmaoN2mEg1aT8sadmT67uegxjF6rpYT29kekywOrwYpWK
         ZD3ZKDi1CPFrrqWDivnPz2NR2uQOU8x70dBhIQMZQcQxrnwOAjg2nyDEbsXGM881hTle
         Hw08GGOhfURWGPp0u++kPvRwew4bzV42bRvvn1wpPDrXnjpBZ7Nlm8gVLfO+ZggrOS9b
         6JWg==
X-Forwarded-Encrypted: i=1; AJvYcCWYv/pMFwpAgTS0xszMFiUh8aXNgF4M5JRKk4K/LK60Vjhkkq8mj1ii0IEXn2p6J4EAVVuHMMeQkLbk0LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWYj1oKjbA90AM0GZYV0mmORupaS6CvzKieXHKL7pE3OplIX8H
	LVPG7PMc3gOMeprTojjhMJZgorVCdyHnWs/C2MdWkTPnMCCQ6jd1y7GQwyGVunfaHKU=
X-Gm-Gg: ASbGnctFogsHbPyeKO02Y8hfwriLoOeHneRiyYaWCgE4n9QkhOGhMaz2JbdOuBIGDwB
	3z0OteMPelj6wFqU1QRLI4HSNT8vTVzJofMlPFK6W9jDbgVDvfVAplmgtBUeY0wNSz9AHZjuwHb
	x3bpkanhX63UPzLvptI2W8LAVMsw2W/Rv/cEgIfkHP5HFnYVoTJtHwDu3FHnICcVxrh3W7ESZ+c
	pcLAhZEorSji1wyVUaKPnXPH7sMjb/lqKHittTHRBN6BgtjTy1OTEBOUOiZA6U2rAcJwFSYQDxN
	kZU8S0sMLNPl92zrDAOB0FbQ0NWz7XS6PjJXmJbQqomHd8Evh1p/8LddAt0P4W3ozIb0wBdYcNp
	IoKPdQFMnrn8sBzpaJyXI124vvr0DbU0l3Es+HF1kAdt+Cq7jpnKbS9HNyD3QsttjVKsZqk9uLX
	VFL0rhJERzm/8P
X-Google-Smtp-Source: AGHT+IHNWco2tVVvQ1Qm5wja2fI3VWQ25WhSh/3CmATM5MOVK4gNPykPcyjoE6tfiWrecsdM+TMQUw==
X-Received: by 2002:ac8:5ad4:0:b0:4aa:d487:594b with SMTP id d75a77b69052e-4ab93d82da5mr255955661cf.35.1753058556378;
        Sun, 20 Jul 2025 17:42:36 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b47a31sm35649881cf.65.2025.07.20.17.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 17:42:35 -0700 (PDT)
Date: Sun, 20 Jul 2025 20:42:33 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>, joshua.hahnjy@gmail.com
Subject: Re: [PATCH v1 00/20] cxl: Address translation support, part 2:
 Region code rework
Message-ID: <aH2M-b2b_trVTB7L@gourry-fedora-PF4VCD3F>
References: <20250715191143.1023512-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715191143.1023512-1-rrichter@amd.com>

On Tue, Jul 15, 2025 at 09:11:23PM +0200, Robert Richter wrote:
> This series is the second part of adding support for CXL address
> translation. It adds another rework of region code to address
> implementation changes or conflicts of current address translation
> code with cxl/next, esp. the introduction of support of extended
> linear caching.
> 

Apologies in advance for delays on review and testing.  I am unavailable
until ~September.  Joshua Hahn may pick this up for testing in my
absense. I will make myself available to him for questions as needed.

+CC: Joshua

~Gregory

