Return-Path: <linux-kernel+bounces-878151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F417C1FE4E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDDF034D27D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07751343D67;
	Thu, 30 Oct 2025 11:58:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4169C334381
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825494; cv=none; b=ZjYukqeT6JnOLdO7UI/C9Ufx+BFvUYebHyE9wT8FxhkOLeiWQvEDwep1XBpvDe10lVKP2bXLeSj+SvcVmd+juVVVhI4ygrddMvAwG/O04V+/hQH5DlrqGybUsvhwmA+emZrZQzmect3yzPY9RhTmdAvYfTkE4lDSzKpr+MU5ICw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825494; c=relaxed/simple;
	bh=xSF0W1po5UrFGHK6PGiBHZSXBo40IA7YKCsPSU3ZtSQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dzLqtYfhs5yadS2WI/TgB9fDKe0+20p7/+wDYPRQTwrN1IURZOCrfU3/kyGREcqJ9eURdh1GvWNTYfKFwTILf+453BKkKmf5H9BlR+9sjKt2pdbUTLF761Y9CDlCHGkf4SXN8cVbXGaWnyvZNdbAeVe8cgXzMRCBSHpfDRlJMjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vERI5-0006Nt-Vc; Thu, 30 Oct 2025 12:58:05 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vERI5-006Cgv-07;
	Thu, 30 Oct 2025 12:58:05 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vERI4-0000000082a-42H4;
	Thu, 30 Oct 2025 12:58:04 +0100
Message-ID: <62f91fe9f5dc24057c156d2e80e45d6cc2c434e3.camel@pengutronix.de>
Subject: Re: [PATCH v7 2/2] reset: eswin: Add eic7700 reset driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: dongxuyang@eswincomputing.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com, 
	huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Date: Thu, 30 Oct 2025 12:58:04 +0100
In-Reply-To: <20250930093238.2116-1-dongxuyang@eswincomputing.com>
References: <20250930093132.2003-1-dongxuyang@eswincomputing.com>
	 <20250930093238.2116-1-dongxuyang@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
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

On Di, 2025-09-30 at 17:32 +0800, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
>=20
> Add support for reset controller in eic7700 series chips.
> Provide functionality for asserting and deasserting resets
> on the chip.
>=20
> Signed-off-by: Yifeng Huang <huangyifeng@eswincomputing.com>
> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

