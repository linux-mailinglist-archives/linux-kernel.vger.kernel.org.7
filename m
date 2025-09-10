Return-Path: <linux-kernel+bounces-810126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D093B5164B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E70565C07
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CD53101D2;
	Wed, 10 Sep 2025 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wiSnBkBY"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9FC28504B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757505551; cv=none; b=E0dSAthAs55k10jSk1b8uiuUQDAGInwu8Au18Bqhu9aU79cAv+xAEiIwX2f64yFE0Nv5bdw3XkNNQ/OJ/icE7pglRQT8dKBM3Nx5J0msTQVy/BIfASEWfFL/ahtGzJv3Ecz+oiwQfLjtjwyDbf6CJGFUSd61Rm/g6ZzWrG/glfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757505551; c=relaxed/simple;
	bh=OySP/ewzDP7qYoXqik2jfMmlTSWEYVQiB3tXcLsIXio=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qVrKgk007gWBXwsieoHFYZrQmcZM5YNwHhBEnoFpK6Ur8Ubd7zYP/1bw1bVxwwdcG1Ebw9Y2F0nJUg05Q8zoU7Fu3NOhWP69YOLhalBE1oA9XmsWlZ7B+Qyqe/7oHo1E+3kE0paaZx8p4Y7lsCeJVuUWDFhZft3kJCJMTQH43bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wiSnBkBY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OySP/ewzDP7qYoXqik2jfMmlTSWEYVQiB3tXcLsIXio=;
	t=1757505550; x=1758715150; b=wiSnBkBYwa+50/p8jh4IcTFNGOxWKzU/lrGFveaYhb1NH0g
	Tn2McFc8/HHgvfX/qmDTwIBaVJSA802N9GyQ/pquoPnu+bE+4FIHnC/VtMjcyHBJ1cv1ZGVPejexR
	PYtRIV7R2h1y1RQ9Q6P4cxe4Vzj2JrcTMFadGHnJcCskpgOCuq9Cc7vFdEwB0+MCf0dbauDqkrSor
	tgnMOezneZuG+FvR0PEaxT11EH661/pY3DXdlEQo0KRKEJJqErFaJnOhv7TOeAEikbPQR3rjnby+0
	UB7Ie2/PxtHbcXfPPfX1pADVU/DXlYAUxyEcqeMklap4B/FbsLPEKAdCteGp4HmQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwJTb-0000000CnNR-07Z6;
	Wed, 10 Sep 2025 13:59:03 +0200
Message-ID: <d28c9690341715fff04fbc01fd80723a30195f23.camel@sipsolutions.net>
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	benjamin@sipsolutions.net, arnd@arndb.de, tiwei.btw@antgroup.com
Date: Wed, 10 Sep 2025 13:59:02 +0200
In-Reply-To: <20250810055136.897712-4-tiwei.bie@linux.dev> (sfid-20250810_075310_514820_7C2543B7)
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
	 <20250810055136.897712-4-tiwei.bie@linux.dev>
	 (sfid-20250810_075310_514820_7C2543B7)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> From: Tiwei Bie <tiwei.btw@antgroup.com>
>=20
> We are going to support SMP in UML, so we can not hard code
> the CPU and NUMA node in __vdso_getcpu() anymore.

Correct. But does that mean we actually have to implement it via syscall
in the VDSO? That seems a bit odd? ARM doesn't seem to have getcpu in
the VDSO at all, for example, so could we do the same and just remove
it?

johannes

