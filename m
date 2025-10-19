Return-Path: <linux-kernel+bounces-859501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B093FBEDD8B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 03:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498E73B83C0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 01:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABD118FC86;
	Sun, 19 Oct 2025 01:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="V2fdNpgr"
Received: from mail-10699.protonmail.ch (mail-10699.protonmail.ch [79.135.106.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39FC63B9
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760836258; cv=none; b=MRY+s5uvy1G/89LTT3rcmDX66zo/1fkn2sXTbEurSjm5YHr3qSsa/cUt+NpQyGxP2FPai/NiKedQ0uDnImFRV/LIyZRFMSV1S5zWd9l6F+/7oAsmS4yXit4e/aPmL87k7IjOA7pW7/bTHL5uIO07X0ojHHTo6PQ3YdC2IcdwRVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760836258; c=relaxed/simple;
	bh=uDk+Yzqyi+bqx2XkgXNbaVgJp7YXmoUx38nEwbzr91k=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eS+/1daLdIYzS1WHyMzUCfdA1fjWthlVDD4XJOB1AOygFMRxNau+NpGl5LkP7wC/xcyv0ZXu+YQO/8dzfnDr7s0BsQXurSx2liCL5r8p6msd2FR1iThL/hcnv5tXVCmDdK80/qySq4vVOMQTia4N+9vyVDdMBWcY2fZtDR4OzKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=V2fdNpgr; arc=none smtp.client-ip=79.135.106.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1760836247; x=1761095447;
	bh=uDk+Yzqyi+bqx2XkgXNbaVgJp7YXmoUx38nEwbzr91k=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=V2fdNpgrGLJ+ZK429QQDNH4W/7JVBGxSA4zDGcCRylVXRaut6z1Kct0xRTvY5rIGs
	 M8UxZP6sa6pW12J5n59k2JsN7pxtry+wIG1Q81OhZDg/gv56rEfF1hN0MlmDuV6qev
	 8tBxc/RCrnd/b6S7fmGl1ZkyNwUOcUTDl/EdIbIkPqwUOxTSfV3+N4WeoKVdeEVE4j
	 V0CUCEvhSocGtAc+5Zc2kex0cRVzLzsHC+JVWZkrTCr/BQAcwaU/Ec9zLWcNyML/OR
	 7jiIN7S0NhzvLTEZzT7/v3xCYmRJsItcgYeiScOCvWNSBBIaVnfwWXjiw3dhpFUU1g
	 HwK4DAvDbjGkA==
Date: Sun, 19 Oct 2025 01:10:42 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "??\"ceo@teo-en-ming-corp.com\"" <ceo@teo-en-ming-corp.com>
Subject: New Linux Kernel Patches From Intel Delivering +18% Database Performance
Message-ID: <Qxq5gxLlGVXGIvI0CatkH5wWB1VIWBYIEjIIbcjMFuayBgPc1ZazUxGQBv-E40V4D5PjdPdY_JikCuyIfgT_40OSUSiY3Vsp0n6TftyDTDs=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: a989c8d5be06ef6341ced5e8a6cfb89a5c9babf1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: New Linux Kernel Patches From Intel Delivering +18% Database Perfo=
rmance

Good day from Singapore,

Here=E2=80=99s a news article I=E2=80=99d like to share.

Article: New Linux Kernel Patches From Intel Delivering +18% Database Perfo=
rmance
Link: https://www.phoronix.com/news/Linux-MM-CID-Faster-DBs
Date of article: 17 Oct 2025

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Singapore
19 Oct 2025 Sunday 9.07 AM




