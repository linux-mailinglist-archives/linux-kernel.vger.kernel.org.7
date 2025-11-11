Return-Path: <linux-kernel+bounces-895617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB84C4E86B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A703A6D85
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911F52E7182;
	Tue, 11 Nov 2025 14:33:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B58248F78
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871625; cv=none; b=JuOL1LGkHsg4gcEF0I2t75zLZJFYCmElNVkaKLDI1Kl3G22d9Qny0tgSJnDks9yAH2thaJOplwz9+KsGMrzbqIASzzXhymXEf4MXGbqeGhAI1wjiHDSUSH0KU45qAWmkp3B6ceBTFGWudMb5pWp3fnkOeJmNFysMsD3Fdj/eysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871625; c=relaxed/simple;
	bh=hF911FpD7hHlzOp+ZGUO10mJQA5px3sr1D8cTSFnPH4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ddEH1aOy4kolnqLwMM58VXwrbrfGHdG4lzGLr8VjZaxJDBO143SM/maRZU+Vr8YzWOCaw1MS7jktzoIp6zVVl3aYeuLRjxWadEfZesnHXIMCgEWmGDBONpqplOrZ4PtdDEPKhU08sPiZftLu016Atf6PbCAlzWZyN6+53TFTQ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vIpR9-0003tQ-9H; Tue, 11 Nov 2025 15:33:35 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vIpR8-008DWM-17;
	Tue, 11 Nov 2025 15:33:34 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vIpR8-000000009SG-19RM;
	Tue, 11 Nov 2025 15:33:34 +0100
Message-ID: <750f15baa9373252a94b9e8a4e703c3494c49481.camel@pengutronix.de>
Subject: Re: [PATCH v3] i2c: designware-platdrv: simplify reset control and
 error handling
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: andi.shyti@kernel.org, andriy.shevchenko@linux.intel.com,
 jsd@semihalf.com, 	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 	mika.westerberg@linux.intel.com
Date: Tue, 11 Nov 2025 15:33:34 +0100
In-Reply-To: <20251111140935.3220840-1-a.shimko.dev@gmail.com>
References: <3c3ece1a00c6e39d865c231e27508bdde0783070.camel@pengutronix.de>
	 <20251111140935.3220840-1-a.shimko.dev@gmail.com>
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

On Di, 2025-11-11 at 17:09 +0300, Artem Shimko wrote:
> The current reset control management uses manual deassertion and assertio=
n
> calls with goto-based error handling, which complicates the code and miss=
es
> the benefits of full device-managed resource handling.

Unnecessary.


[...]
> combined with devm_add_action_or_reset()

No, that's not what I requested in v2.

regards
Philipp

