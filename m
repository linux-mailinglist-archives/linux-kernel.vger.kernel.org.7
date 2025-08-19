Return-Path: <linux-kernel+bounces-776116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1657FB2C8C2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E855E5D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EB22874F9;
	Tue, 19 Aug 2025 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrJFWGVt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7800A283FF9;
	Tue, 19 Aug 2025 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755618693; cv=none; b=MtNJQpjVI0Jjk3llaTwf6vorRnL5zyNycOY/96/icFodUhGvifDFkOLFDXxpjl0u5cy6GxfY0kmlIe7c3o+dLvrkcop2pnw7LAa7vwW4+s3qVTKzJoT09G0kB1TKcuz6zxf3vac7MI4MPmf6uzHfDG2vCtPLPRvZVkT0OENnNjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755618693; c=relaxed/simple;
	bh=mWBaly7bkukCq8m5VXbJi5gIoLW+tCiQOL99VH0GUTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPxpb04wdJqyUg5y+RFemK/VZiYAKHbl0ibr/Mgr4WOSKoKrW96ByHzVMS/vBzVXJUDjYuTkbkciy84B6v9b4OilH3gvAvZg2TO9Zvo/OQmrtEHHT7S3mdq0R+8FF41jmkxZ4806B19W6hzzwBSrLtpkonj1O5vsvaIpppR8jJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrJFWGVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF4EC4CEF1;
	Tue, 19 Aug 2025 15:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755618693;
	bh=mWBaly7bkukCq8m5VXbJi5gIoLW+tCiQOL99VH0GUTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QrJFWGVta1cSbFnLibenV9UBYnABVDcARhOwatYfp7y8UPN6zjirPIbpMEK8xC1pc
	 D+gZFq/+NFc27/c0VuPIXdCpTP+RG57SGEvjAoLrouePkJC6szWe7eI0ZGcWAP+TuU
	 4DY2HXoK9o7LLoPsoJ1xd4Aug+cpt0uQNyYihOuXK+3tHfN34hOL5ssnwhJH/dfjJm
	 W6RMzQJ5KzTlA84tGFIfkZvGVkh5cHcqDM8j6IR0/wkiTBbey39qpY53rw+tql9CoD
	 KXsR0pkY4n0OwU2+ifzqFuJwlxdRU1kFpGukFeLIRQj5+4LAV+/n6H1khCb1PNisRS
	 WhHJjap/j2maA==
From: Conor Dooley <conor@kernel.org>
To: Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH] riscv: dts: microchip: Minor whitespace cleanup
Date: Tue, 19 Aug 2025 16:50:55 +0100
Message-ID: <20250819-dimple-camera-93d21a97b0a3@spud>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250819131549.86279-2-krzysztof.kozlowski@linaro.org>
References: <20250819131549.86279-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=320; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=GbAqJH8GGwxxCZgEZhCcQRaSiWxPVwMWGD9JIZcHYdY=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBlL5iYY1TF8LF3aUmHfbvnpzpVwrapHK1dNyRacqfb6+ lYevt2pHaUsDGJcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZhIz0OG/8FinEEOnK8eC0tc CWTl4vzhpund1TH3vpiOxjdDPvs7bIwMuyfP+FQTEH7vvNetGSLTVRfLW3i89U5sv81WK33c/v0 jFgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 19 Aug 2025 15:15:50 +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space around '='
> character.
> 
> 

Applied to riscv-dt-for-next, thanks!

[1/1] riscv: dts: microchip: Minor whitespace cleanup
      https://git.kernel.org/conor/c/cec6e40a02ef

Thanks,
Conor.

