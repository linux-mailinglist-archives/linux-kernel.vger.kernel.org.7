Return-Path: <linux-kernel+bounces-892527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C43E5C4548F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA01188F67D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C48E2F39D7;
	Mon, 10 Nov 2025 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ahumAj/a"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A6C2F5321
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762761588; cv=none; b=JMw37DyBYawtFIM232PJUFqJs7M80M/gw/4YbGZXfJmmA08il/1ZxW/5OS3kd9q+keWXRbkD548SM01f2zkTRQzZhi5Wk9v8hvCs5H+IUIbjEodxtKKRSX7N8rqAqcBECLybUAMMmpZ9gmHmfr1rBIfmTJbknuCk6eLx4CwO7P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762761588; c=relaxed/simple;
	bh=l6rAjgIfDlhOHg/0Bv9x+4BwfAtvCUpo+tG/vXOpkuA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IIhIRaN5aS7/lDBG51xs6XZbG4V6BeO3gZKBBbpScLVQmdVI6KUpibocf5FBYkOAH4UKYd+QTmw9t7NLpZxkYH2/z2awjyFiNAYG6QuAWn9tSxWpH1PFZu0bEpeKj2yXI3r6rLzQyN6r74ITBBWr20bC6hegvp0z+L/MZoUsn5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ahumAj/a; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CF36D4E415FF
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:59:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A5633606F5;
	Mon, 10 Nov 2025 07:59:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9934A103718A5;
	Mon, 10 Nov 2025 08:59:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762761575; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=l6rAjgIfDlhOHg/0Bv9x+4BwfAtvCUpo+tG/vXOpkuA=;
	b=ahumAj/aDXbJoRdvrKUIbCnZrAHisypL1ca1YI2jBWh+OI62ou9c/hikOW1bqE3UHJxe/C
	+Ja6VUru+WVsULqRORDzKvj3Eje16Kx+TNEw+b5ZoXhBAWpSPFny/3+DlOWpNxGd67URgl
	rMW3bOd9gDpbe9eVa6IHj8f9yarfIG02jRvd0Umd6RGi646YBzF9lj518YtjM0HiiiA73q
	uzG6OQz04mXBl83NZGTm29039oLQ4sKUzNR3FwVHmxu6jGwJdOFNEYH9/FMP3lZV2gQcD5
	QSSO1kT/2jHx3reTsa1vVOWAhmDB0MLAIs65CimKc88KqfQ7IpMkoO/S5J7tKg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Nov 2025 08:59:33 +0100
Message-Id: <DE4UTRD2E5EW.2APL4DF6P6GUU@bootlin.com>
Cc: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: dapm-graph: Handle sound card with space in
 name
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
To: "Yiwei Lin" <s921975628@gmail.com>
X-Mailer: aerc 0.20.1
References: <20251107171302.2228-1-s921975628@gmail.com>
In-Reply-To: <20251107171302.2228-1-s921975628@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri Nov 7, 2025 at 6:13 PM CET, Yiwei Lin wrote:
> When the name of the sound card has a space
> between, the script will fail to output the
> dot file. Consider the case to generate it
> correctly.
>
> Signed-off-by: Yiwei Lin <s921975628@gmail.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

