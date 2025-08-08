Return-Path: <linux-kernel+bounces-759621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4F5B1E03F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243F9174E12
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBE284D02;
	Fri,  8 Aug 2025 01:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="hUqof9Hb"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6E123CB;
	Fri,  8 Aug 2025 01:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754617595; cv=none; b=p/jpvesClW6Kn/ie8/l7RtPsATR5TeVQ2Q+07cNda8gcarqcULDwY6+8a8h//+GwADhDxwGp0cgg80djQ1XQd7vAUI0wVBsZ4jpF9oUL4+xynG22wURJqD7Xn9v0q8mkYLh1h6WgG8rM3tkbP2VWy84fKWNthHwhEvkTcI1sgss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754617595; c=relaxed/simple;
	bh=yVp+q0OXEFKzrgZ3sx/tEBHw0oQFJlRYZK/S98YsvoQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yo+GkeD1IjphzEQQUYcUZiEcEDkZ0jIX0NWx7hTqUIHptWfdGsM1jVnRp4l/rPHY8o0jhj7IGuGj7+4LJX1T4aQhnTeJ9H2vi4Tv+RR2auY2r9r4BTcWFfI2ILXMZdcyt/ozfPULabO5Mie9EaMqJTufln+OrPdVAL6l269Ft/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=hUqof9Hb; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1754617591;
	bh=yVp+q0OXEFKzrgZ3sx/tEBHw0oQFJlRYZK/S98YsvoQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hUqof9HbnGjzHizOMdz7dyj5F//rbpBuUZZzrwVb8zd823QbWdNCY2r0GbjAXV8Q0
	 ByI3u6/6ZvmCtcUTIltp0jeanALrnF5bYC3PHSYtQ8LNm/cRGRD/v0lwe9Plo18U3/
	 PTsElkZRTkzZWwEU6aewBeD4jJqO990eQUKZCkxYv7CepGBFq6KaN6svE2woaEae9g
	 1e6bqZHGQeRgaOSczGvPzVhow3jfDV+flGn0hHo97KicVebuOKBaIUF3ajZ9DlH3qm
	 YQmX4vdiKDzINFtflGxbHekmmAIv/+3mkKDVJS/W+a3np5EIjXa/k1WPzgYytYlCzK
	 PU+viEaUta1bQ==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8A4786AF39;
	Fri,  8 Aug 2025 09:46:30 +0800 (AWST)
Message-ID: <54e07d5e67b2d15810d79bc196e92c8bacabf789.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: mfd: aspeed-lpc: Add missing "clocks"
 property on lpc-snoop node
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Lee Jones <lee@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 08 Aug 2025 11:16:30 +0930
In-Reply-To: <20250807132909.3291770-1-robh@kernel.org>
References: <20250807132909.3291770-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-07 at 08:29 -0500, Rob Herring (Arm) wrote:
> The ASpeed lpc-snoop nodes have a "clocks" property which isn't
> documented. It looks like all the LPC child devices have the same clock
> source. Perhaps it is the parent device that should have the clock, but
> it's too late for that. The driver for lpc-snoop requires a clock to be
> present.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Thanks Rob.

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

