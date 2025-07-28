Return-Path: <linux-kernel+bounces-747856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB52B13929
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCBE37A227C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3247924A054;
	Mon, 28 Jul 2025 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="r7JnFoBq"
Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52674248861
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753699452; cv=none; b=iyJ2YMRFUDSyj7ZeD6BwxmpaDimN/FXiucQ+PHwea2kARps2xkLuw8bKoNZb/1brhR6zyDssSwLxjNBE9THLQTNNmRuS9dsRsKXQQUUnJGjuR2i478Bf9sQEIVHTGxuXpqo8smSNRvaxtR5twambzFF8pMAWCKHLAxrjKVB7Fb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753699452; c=relaxed/simple;
	bh=zttwuoi5H+FctdTtaIPO7H1f9mySAGgB/s93zBTvpWk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=T6udWLhJ1b9sWwiTTX73hbqjzG4qJylPt32p1/BX0TxGuVLbUQkIPN/MzsqKbSuGV7dUE/jmGoRKhcrfTYTYfr3qreDr/AVP7LKGfMohgbZImKG4YkAJALDxjiTzmQhNv5EgbSFOzB6q+0WLdm5XWfDxwBJ3DrQK0IOVev4hDSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=r7JnFoBq; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1753699443; x=1753958643;
	bh=zttwuoi5H+FctdTtaIPO7H1f9mySAGgB/s93zBTvpWk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=r7JnFoBqQr2voIA4Duseks7yY9+sSwpI3OZv4I3PKJxfPwnp2+QXeFRefyZ9PlyxT
	 t9RSAtoRlw4dQ1LQLciaaNNR2z/a+nL9cROekYvzy0SWQCuVw3ea25XKpBhCcAIIck
	 u6IaPdg+uOToADf6SVNikByNmoINl6wRdSkdoPVVI1f35KJkv0SoOQx5lzb9r/qUdY
	 BbE4xkfEFXSfaR8n9v3wso9Omwp1PrYmCTsK52IlbAARv/UL/lwEGGWKp0WgOUlJp5
	 SMcw5SfDmRuKU3Ak/Frr11Cej0ZvmzgNAEg0iTvz6RVxT1i+nGRLZyfCAffTu3rAMN
	 hKxs7CutiBvWA==
Date: Mon, 28 Jul 2025 10:43:58 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: CISA Warns of Active Exploitation of Linux Kernel Privilege Escalation Vulnerability
Message-ID: <-odY_U0GMKGhMdDC8f8VIriSRDcKJeGe1VdoDoDVY21kH1qeapJdRBIhzfQZmQuuNlu2b-xx-VgmLmZ-X89hAYTPqqJAKpDtLJPa3VJgU7I=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 9b7cc9cfaf0538b461dac6434b929d87e3e2c389
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: CISA Warns of Active Exploitation of Linux Kernel Privilege Escala=
tion Vulnerability

Good day from Singapore,

Article: CISA Warns of Active Exploitation of Linux Kernel Privilege Escala=
tion Vulnerability
Link: https://thehackernews.com/2025/06/cisa-warns-of-active-exploitation-o=
f.html
Date of article: 18 June 2025

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individuals Singapore
GIMP =3D Government-Induced Medical Problems
28 July 2025 Monday





