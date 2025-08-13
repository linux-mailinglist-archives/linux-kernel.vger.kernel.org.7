Return-Path: <linux-kernel+bounces-767312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E26B252B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77B6189D8EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162EF2BFC9B;
	Wed, 13 Aug 2025 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiYx3JS2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718E623D7E4;
	Wed, 13 Aug 2025 18:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755108103; cv=none; b=SE1yr+u5SzVAkmhUz9BFYc0t6aA1KvgdzyFwilTdK90fmEH6EQRDsVq28H+TE5jL1n8+T/gPOT0VyzBAX50VjU84UyQ6n569GLdcVRI8liyy3P2c75jZxaYrlQcW6grm9oxWiNamPT0MDKsEHJg0Bf1IXqQQRdOO9U0Zzwo8WxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755108103; c=relaxed/simple;
	bh=yaVpy5WaoL8966Ac835jBMQA6Dn9E/g1Z6UEGMXPAcw=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=XxePkog1I373HPZTVULtHKkFe1PF4eqU7TF9yN+/0ScNwyAYP2V+fTfkUZiEYxmP2O3D2gFNrP0taZXjFAQSHPvVt6Y8KCCuVhx8SPhsmrpfbKLmpbnrI+BXRDNvcfHTNsVSL1A7zQojyzPPPIjY7ERmcsIdJNiOITOVHPPCwaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiYx3JS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2958C4CEEB;
	Wed, 13 Aug 2025 18:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755108103;
	bh=yaVpy5WaoL8966Ac835jBMQA6Dn9E/g1Z6UEGMXPAcw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=GiYx3JS2VYsSparEBErGWYnogcWWbRDbIAuKHlLQGnq1c17r2yetNpYcmct6PaEgE
	 SLBWSYFf8zpxFUEHfKD3lN8O/Xvd7kia9TWLhyxBFmoVMZWzab0AvHC/xsmrn6rLBk
	 1epcM1XAblqp5srEDpj6CMTv8ywKS3yUzipzuXXZTUxAhn5iKsTPgdU9G7qB4WHcuY
	 RU9QplgxEdEdL/Lw2rIWWibkhgdyBGpRPLcRtWKt2xgRdptTGJiAlh6YcESSWyGuyb
	 7zN796r9+2ioYQfUJCLgy1tu2Twbb/0jLuW1DTv4MpbEZ3fulznPAWNzIcPU5ky8m2
	 XrTjQFB5ldlPw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250804222034.4083410-1-robh@kernel.org>
References: <20250804222034.4083410-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: Convert silabs,si5341 to DT schema
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Mike Looijmans <mike.looijmans@topic.nl>, Rob Herring (Arm) <robh@kernel.org>
Date: Wed, 13 Aug 2025 11:01:42 -0700
Message-ID: <175510810219.11333.3070936205247892886@lazor>
User-Agent: alot/0.11

Quoting Rob Herring (Arm) (2025-08-04 15:20:32)
> Convert the Silicon Labs SI5341 binding to DT schema format. It's a
> straight-forward conversion.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied to clk-next

