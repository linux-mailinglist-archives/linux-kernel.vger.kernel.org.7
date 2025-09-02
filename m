Return-Path: <linux-kernel+bounces-795965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED631B3FA0D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE06C16C9F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B4D27466D;
	Tue,  2 Sep 2025 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lvsfTK13"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C79221F09
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804721; cv=none; b=rfsS9kl5iCJVdjwfWvkZgx42j6TzSDwP+cUrs084xZVSsgF/1dWe/j4zPxRtqf8+YSgqr3YknH7uL/RjD+nmVhm9PDey304Qp5AVyALmE9BRBVQkcsc+rxCmL1BnMrEfwHUpTVr++N9ap3ASg9+Uk+H65ZTielekjylPtN0WJTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804721; c=relaxed/simple;
	bh=RxjpUVLKcoWc5xvHEWJKCRABhDI2uL7/9sXv3eiVjyQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pSC+MNbLSavjHwpXjig/+8NW8hD4jzVz6JN5ApM3kTKUoFBEUDB5MaSeMa2B5kgAwb8XKyk0Z66A1YVzYZpB83tiTJqWF465wOGQIjLE72qoxSiEYQhY9U1//FnKDyU6RwGuYOdNSs0XFaJvg+uUegpMLROnlrLrVvwiANyXzGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lvsfTK13; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 96B7F4E40C6E;
	Tue,  2 Sep 2025 09:18:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 68EF260695;
	Tue,  2 Sep 2025 09:18:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 508A01C22D9A3;
	Tue,  2 Sep 2025 11:18:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756804715; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RxjpUVLKcoWc5xvHEWJKCRABhDI2uL7/9sXv3eiVjyQ=;
	b=lvsfTK13vM4HeVhgQCqxYEyRq763oPQbBGQ0D9e6bXGsCyn4VvG+LvC96D0LW3bkPVEJar
	XncUK08QA/jLDEmGquT+yq97aUScIYjddznLyBT4AGYWqvytQjGbeoBXVvijhD8A5rCcbI
	nIvJiGPrNgE8Ul6UmL8Evm31Y9uiaWR2U1gbN4pgbwAPhOSl4xW3hI4pRnR0dcFpUOj/Kr
	2LsLrpOAVJntK0DeT1GOdBAPU6EYvJAGJ4ouf2l+63bEsaSlxd0+3i70G3hiCj9rtPR3ri
	VTg1UGcKSD+/AKMXNCN8D8giqEYYqAvI11e1P50MdVGTaXjJPqKdTdFfG4Ecxw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Vinod Koul <vkoul@kernel.org>,  Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  dmaengine@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw: dmamux: Fix device reference leak in
 rzn1_dmamux_route_allocate
In-Reply-To: <20250902090358.2423285-1-linmq006@gmail.com> (Miaoqian Lin's
	message of "Tue, 2 Sep 2025 17:03:58 +0800")
References: <20250902090358.2423285-1-linmq006@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Tue, 02 Sep 2025 11:18:32 +0200
Message-ID: <875xe1nrfb.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 02/09/2025 at 17:03:58 +08, Miaoqian Lin <linmq006@gmail.com> wrote:

> The reference taken by of_find_device_by_node()
> must be released when not needed anymore.
> Add missing put_device() call to fix device reference leaks.
>
> Fixes: 134d9c52fca2 ("dmaengine: dw: dmamux: Introduce RZN1 DMA router su=
pport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

