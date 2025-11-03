Return-Path: <linux-kernel+bounces-882256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E55CC2A000
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 04:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45EBA3ADE05
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 03:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75AF2882DB;
	Mon,  3 Nov 2025 03:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="wulbIpkX"
Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F1B1A238F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 03:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762142252; cv=none; b=sa9mF2WfuoIpgOpHcBIOSKrTBW8FRHLu1aF2ivHQI8Uq7lpMj659fALznEMh4N+0DLTjEMlAgnwcRBN47sW4QxzGaVIIV8TrC94ejZ96DQh7zBui4qDMndZZdgF4cWJ0PPN3Kg2Cd/CHR6CS22aHdR7MG8sJTjojoUGy0U0DuAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762142252; c=relaxed/simple;
	bh=ay8XPj39g9ljqdDiXiNZB+eA0apDQH1Jd0Wlrmap9i0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eir6g8LtIFfTJteApMtP8xjQd50Hd903bnSv3u7PKNi5t/30WlvPmjoVPZRMA5SX75oQXxyKDV8defzbEYM9e7xlkvDEYXCLv2x/UqmFVgrm/QGfRN3xiSd/WSG0x5o0wZrPlRoYPT2eJt14x9XJ4jGQkJ3xnFT9AEW+yyR7UiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=wulbIpkX; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1762142233; x=1762401433;
	bh=ay8XPj39g9ljqdDiXiNZB+eA0apDQH1Jd0Wlrmap9i0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=wulbIpkXW9oS/xLTU/geAgUpI0Xoo3Jl5OpMjumAeLcw3HFsS9E3k3wsIsGxdBXZh
	 o468B7Vze5UAYXzr5kr4kLyozKcRPoAZWIBTAi42RKcrVzvZJ0nkGvT6CvjZdQ1VIB
	 ms5qColuVsZZs4aJnIZD+fE+grNVNS25P4IRhfGFgXViy4WcKqUsl6II+RvgukeUxQ
	 kIuTelm8GXJRY+oDh9KmxiLdQz9BEiwewG9fbG+z95qCLvA11w8ntwbpuF1qRGX/XT
	 Y4ivR/A9dmFEroOkDTqREqSojdE/o8o7tAZn8NHv2GGroigXfoMVU9ynWembKAhVaZ
	 6WPKOi5imi7ww==
Date: Mon, 03 Nov 2025 03:57:09 +0000
To: linux-kernel@vger.kernel.org
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: ceo@teo-en-ming-corp.com
Subject: Linux Kernel Ported To WebAssembly - Demo Lets You Run It In Your Web Browser
Message-ID: <PplCuRuGiAiF1MHqa0IJ7GY5HfuPP0oAo0UUWE_eLdFVyetVEExbgwzGk_kWFFtlczG4AY2ABvCPRbD2elVGDAsrq_bvuL4rB9nlCUihhgU=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 267c91c03a17f36d1890f829ee108a249f07c2b3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Linux Kernel Ported To WebAssembly - Demo Lets You Run It In Your =
Web Browser

Good day from Singapore,

Here=E2=80=99s a news article I=E2=80=99d like to share.

Article: Linux Kernel Ported To WebAssembly - Demo Lets You Run It In Your =
Web Browser
Link: https://www.phoronix.com/news/Linux-Kernel-WebAssembly
Date of article: 1 Nov 2025

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Singapore
3 Nov 2025 Monday 11.53 am

