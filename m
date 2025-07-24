Return-Path: <linux-kernel+bounces-744956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA701B112F0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF91EAE2397
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651982EBDF5;
	Thu, 24 Jul 2025 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQjOQfI9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC16C190664;
	Thu, 24 Jul 2025 21:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753391894; cv=none; b=ASC399QM5Id1azy6PDHktdJDneVo2AvHvGoWjE2rsCgM2wWGKlnNqBXWxjIw8kPcI600oOj9U4i4NR0kq9R7O1YnbDGhtvIFJOj5ZyHjVwtNiBqJTDdu/RX/Y45vm2NVrFvwVjvsgjiFTvPorFBE4RIS69WI7GJopydJwYKUpk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753391894; c=relaxed/simple;
	bh=je2F6ZuuHECpICwip9oYkHBZEO0DnwRYGEBFSL91pJg=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=ijXE6F8H897IyWebzvdM7tkhZpnOwAroPi8hvKOw414vM9bOSY+RPPaKT27pZu2F6+6vTV8jEHHguW+iKUBxMDfxlzyQs184lSyZwy4kAvQJsiuikaO9EZoX8mVPrHliiRoPm4kzbY6noDgmWx5yU8fdy17sN3ijIwiozoYkAp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQjOQfI9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123CDC4CEED;
	Thu, 24 Jul 2025 21:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753391894;
	bh=je2F6ZuuHECpICwip9oYkHBZEO0DnwRYGEBFSL91pJg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=iQjOQfI9xGyBJV47DQ3QOipJG1RJ5Dlx4CUxKvSuJX6O04kG/Tf6jx2ndLFI5/0tC
	 ct8IHUtWRuraaeZsSWuWAyvF1LspKeUut+/nNCP6W0cBsOREQDE6kKlfwSSfC65+Uy
	 6T9JU4ulifyeNIk4jRxAkVx2WyHTtjVIcy2FBHbGhRolG3+PnM/2aEKj1ALU/mqz1G
	 mW9Tvc50BQE7bMH2myICs7CYY0f5S6MdyKK71CLcTKdKuOfyAl2/BXXOM7jmtKjsL+
	 7OiJBgkprEfxk/Cfverb+TsmKfygAOFkU3nlwNyXqzRwpeor1iA2nBVqseXfFp50VU
	 TslULrpvQwPGA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250630232652.3701007-1-robh@kernel.org>
References: <20250630232652.3701007-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: Convert microchip,pic32mzda-clk to DT schema
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Chandra Mandal <purna.mandal@microchip.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring (Arm) <robh@kernel.org>
Date: Thu, 24 Jul 2025 14:18:12 -0700
Message-ID: <175339189273.3513.2071408676369082143@lazor>
User-Agent: alot/0.11

Quoting Rob Herring (Arm) (2025-06-30 16:26:51)
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied to clk-next

