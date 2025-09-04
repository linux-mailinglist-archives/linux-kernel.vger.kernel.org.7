Return-Path: <linux-kernel+bounces-801623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EEEB447C6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8231D5A54E6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AFF288522;
	Thu,  4 Sep 2025 20:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=editrage.com header.i=@editrage.com header.b="BK+H8vpQ"
Received: from beige.yew.relay.mailchannels.net (beige.yew.relay.mailchannels.net [23.83.220.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190862882B7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.220.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757019221; cv=pass; b=tE/9POGj+137bWaMcKFL1S/AsA0VatBUfD0Fq3LZR+kGcHFdO1ZqXUiXpomXcFtJFozHu8yv3b1BOllw7tvOtzQQ6UvoU4FSIj+w2f0QbXs1ZZEoKqGJwfSXZ53bdT1sL585rix1QqM1E25e1iUDV/da/3VfGALtABMq1Cpk9XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757019221; c=relaxed/simple;
	bh=YsKk358zWKMe2Qm3eNuUlPjlEKDHPJ5nSK2erZ54WzM=;
	h=Message-ID:From:To:Subject:MIME-Version:Content-Type:Date; b=UjyvW6ShCxEzYqzDK5G1fd8FesIIIVKmItpwhtg3zcjzhfnx6AvEpVClGUMl9ttwJkgx3gi23sHEr72HSbnyNRCAvjBzTrcmfXd4sm/xOHyDxbox7ToAal2UrGR4KtiEaBDflmmhyubGXs/Ic/O22iwah8vsLhgN+sCh7oBINDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=editrage.com; spf=pass smtp.mailfrom=editrage.com; dkim=pass (2048-bit key) header.d=editrage.com header.i=@editrage.com header.b=BK+H8vpQ; arc=pass smtp.client-ip=23.83.220.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=editrage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=editrage.com
X-Sender-Id: hostingeremailsmtpin|x-authuser|drsupport@editrage.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6B1BF3248CF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:25:45 +0000 (UTC)
Received: from fr-int-smtpout12.hostinger.io (100-102-63-102.trex-nlb.outbound.svc.cluster.local [100.102.63.102])
	(Authenticated sender: hostingeremailsmtpin)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9298E32429B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:25:44 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1757006744; a=rsa-sha256;
	cv=none;
	b=aEjkmCd4gvnIn84KnMyhRbT4iiSQj/ChzloCsnc/xtZLAwR+QUnBT4KlpsYNQu5ZfKRJRM
	Flk+mNQBIBAkCRYxd/SnjLtLFIRaGIvI1RpwORN3drGkX4dIdrrHiI/xWYqoXFg9/ns87Z
	IdvIEtMqAI+vA5R2jm+5OsM5flW5XCmD8zO7Vj6qUE+mG8lxoqMNdEe4M0BO2KNLyi0dAI
	LUgOulsWDb0zAHhNWcxArQKfwtVk2h/ULG6MS5bEJhJ1P7Dw6DPIYJBuVifRZvR8ci8fuT
	UzuTWfhHMk6KcZdM3WRa11gWb26lQomNsoZEvluCkCtIEyqUk4GAUvg6OKP6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1757006744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=YsKk358zWKMe2Qm3eNuUlPjlEKDHPJ5nSK2erZ54WzM=;
	b=VF76QiSrSKRMLDtXp8brSuJITg+c8L8wF7gdGPTeeb5ytfBCTi3Lvcr7D440BNGMZ9j6Aj
	wPrAZw4FZoNXN4fsqfAkOVDXvMXq4ZxURmdbGDXIVb/qbyBqmOuvK+BPpJeozuI6GPWb7T
	L6BRnp8PjVUn0nWW21oDpkUkKs7/BpemNr9yCZaNIfuDmT3lhfnjVQawoSkY7pmt/ks925
	ZyVm2GY8oHdMwhP9F74Ys8N5tnnSZUd/4Aa+2tJzKdpYJtTWveG3oMBhZXZWtkOZG5L2Q3
	UcSGjmLXR9t0b9cU85nNxH2fu/cfc+MCUtJ7Wtb2iWcn+lV/aH+wRa6iD3VbSw==
ARC-Authentication-Results: i=1;
	rspamd-8b9589799-8nm74;
	auth=pass smtp.auth=hostingeremailsmtpin smtp.mailfrom=drsupport@editrage.com
X-Sender-Id: hostingeremailsmtpin|x-authuser|drsupport@editrage.com
X-MC-Relay: Good
X-MailChannels-SenderId:
 hostingeremailsmtpin|x-authuser|drsupport@editrage.com
X-MailChannels-Auth-Id: hostingeremailsmtpin
X-Arithmetic-Relation: 0bee8b017a6dc42c_1757006745103_2245112427
X-MC-Loop-Signature: 1757006745103:3694424935
X-MC-Ingress-Time: 1757006745103
Received: from fr-int-smtpout12.hostinger.io ([UNAVAILABLE]. [148.222.54.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.63.102 (trex/7.1.3);
	Thu, 04 Sep 2025 17:25:45 +0000
Received: from 35f9bf90-8522-4fe6-b8fd-2ebe31b60b5b.local (ec2-44-222-226-4.compute-1.amazonaws.com [44.222.226.4])
	(Authenticated sender: drsupport@editrage.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4cHmbB4y5vz1yF8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=editrage.com;
	s=hostingermail-a; t=1757006742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YsKk358zWKMe2Qm3eNuUlPjlEKDHPJ5nSK2erZ54WzM=;
	b=BK+H8vpQVXpi/9VmaXajD6wLVkWZC0N0kGClnlgJB7nWKB2/XScwd+imfzDoBc1q/nnk9p
	PvCrozFJSG10PYLdxysQ0oJHrVu2iaW3iL+/9WxhXWo1d4ybWacj6w4dGMykdaAEGLKLuM
	Rj0yH9D1PWYxO9tNarExGvQ/8Wi+pScV7zjnBFTJ7dTxiLqxYXEd065nIOX1/0pNGeAkfE
	UyUnvuehnhhq9IsHVoEcR8TDvITexQ9lVPiQMsi688WxFwv777wVLOHDhKoMvMp9la4O7c
	2fY6yfJswumpRcVidsHErB13rq98QyZQabwjrpQXn3OARYvW2W98zA+Msh3WGg==
Message-ID: <35f9bf90-8522-4fe6-b8fd-2ebe31b60b5b@editrage.com>
From: Mohanish Ved <drsupport@editrage.com>
To: linux-kernel@vger.kernel.org
Subject: Truth: AI adoption in healthcare
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Date: Thu,  4 Sep 2025 17:25:42 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=DJTd4DNb c=1 sm=1 tr=0 ts=68b9cb96 a=6zFhyHCCOneUZrx2JNiB/A==:117 a=6zFhyHCCOneUZrx2JNiB/A==:17 a=IkcTkHD0fZMA:10 a=amsrZz8KWSJj8ufvzgsA:9 a=QEXdDO2ut3YA:10 a=UzISIztuOb4A:10
X-CM-Envelope: MS4xfAa8aQKBP614JTg3z5cMO5D+vZoyQtq+ESjv50Ef+Q1Qn7aer4Ct3TVyETMY8cLGd8u/EI1bPPDUvhpJUJbGnB5QunfTQLg3t3pu9atrsSRdBFbNfgic 4d9cx69boCiMul4Wjskpvzfkvq1x0AFrmXX+H2K9Iu2OuNysSmhSvTwjEI7qaXyJ2Z+hVwVSZFp/hUWGjEPr4vEjKdUtGIg5OKP1XnPhwKum9pgWjCkKlapz Z3cbco0J2E9nk3DfGr8/BQ==
X-AuthUser: drsupport@editrage.com

Hi Dr. Sam Lavi Cosmetic And Implant Dentistry=C2=A0,

AI adoption in healthcare isn=E2=80=99t coming =E2=80=94 it=E2=80=99s =
already here.
Some implant clinics are quietly using AI to handle patient =
calls, consultations, and scheduling.

Their growth isn=E2=80=99t a =
coincidence.
Being first gives them an edge =E2=80=94 being late means =
playing catch-up.

Should I share a 2-min demo video so you can see how it =
works?
Reply 'Video' and I=E2=80=99ll send it.

=E2=80=94
Best regards, =C2=A0
Mohanish Ved =C2=A0
AI Growth Specialist =C2=A0
EditRage Solutions

=C2=A0

