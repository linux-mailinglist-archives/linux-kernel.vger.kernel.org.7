Return-Path: <linux-kernel+bounces-850942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF624BD53A1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114254871A3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AFE313E0D;
	Mon, 13 Oct 2025 15:41:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC925312815
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370071; cv=none; b=LLyhGrdvT81MuGDRQUgmV/aEXSY6c1m7Dv3i2l4ml5OwZyxEbPennRBJ0eu3iS+HDO+donKwrWcywURKtdet4XaR73HjFUM/wH/JDSJHq6zR6vyhDAJuf//INOLo00Vz+uHIL7etLAzvoTom7peF24516ZKs4RHPxnCk+1SfKEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370071; c=relaxed/simple;
	bh=ZNGpwN1spmmQtLYHgY9XQ8MI4uywOHGxkDfxDwlS9Cw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yf4H/IuMU7dcmJ1PiF6gA7KHZ4aFUMeMOHDPQkaoLLiOxAfB8MTT8rb8JPQYeo0D3yPnKuiTkI4rMj+Af/ERaMR88Pp+6AqiJRt6jmCdX0jNUON6MiSOv7mB8ZmRLqDJ9K37Kd3gfWSA954TxWZe7VUYnUt11P/F+gZuqSwBcfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v8KfX-0003C1-Vd; Mon, 13 Oct 2025 17:41:03 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v8KfX-003PMz-00;
	Mon, 13 Oct 2025 17:41:03 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v8KfW-00000000DI9-3soz;
	Mon, 13 Oct 2025 17:41:02 +0200
Message-ID: <06e7f7f23fb264e9db39441698b33c048d8192e3.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] dmaengine: dw-axi-dmac: add reset control support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul	
 <vkoul@kernel.org>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 13 Oct 2025 17:41:02 +0200
In-Reply-To: <CAOPX745BVB4oVUxz0ZYRRs3_KWT6Y6cGrMdc26v49U66+u0ReA@mail.gmail.com>
References: <20251012100002.2959213-1-a.shimko.dev@gmail.com>
	 <20251012100002.2959213-3-a.shimko.dev@gmail.com>
	 <bf59e192acc06c88f122578e40ee64e1cafe8152.camel@pengutronix.de>
	 <CAOPX745BVB4oVUxz0ZYRRs3_KWT6Y6cGrMdc26v49U66+u0ReA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mo, 2025-10-13 at 17:56 +0300, Artem Shimko wrote:

[...]
> dw_remove() has axi_dma_suspend() function, which is where the reset asse=
rtion
> occurs via reset_control_assert().

It looks to me like dw_remove() is now missing a deassert before
accessing registers, in case the device is removed while runtime
suspended.

regards
Philipp

