Return-Path: <linux-kernel+bounces-767311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA63B252B3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD733B2F33
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54672BF00B;
	Wed, 13 Aug 2025 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLKpA9CI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D845292B56;
	Wed, 13 Aug 2025 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755108092; cv=none; b=lx/YpdRz/dB//Vh0z4xzoYOVjlbSVCMtZJ/lG2xEHAMIdj20Z1RDlkoGEr64IbfxQ4iNw1sfTF6CiQP2m2CQajKDAJpdbtv54kk8sH+n000+kc9afvPO+lkHGPvXGd5PUWC/yaOvSBoHtW2uSytuCOPkWf39eJmGKv4r8GICUNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755108092; c=relaxed/simple;
	bh=s9epfny743R+e3V9os6m+gXRE+kEQ2otXiXqPsjz5cc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=JpphZJaTOSQLiNj0pVpikY+Pm6U4KfOPV49vuUrSKNrRaO8kB6/WA42PV9YknLGHofCXVQ20rGbicuEmLnjilqlSwarTr1BREnC5xSHoNnaWJafmN4GjH6RmRodyQjeU9bh9cJyOgHiCl3mYkcBwPf3hs7A0KlRSoPVDPrQPTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLKpA9CI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4144C4CEEB;
	Wed, 13 Aug 2025 18:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755108091;
	bh=s9epfny743R+e3V9os6m+gXRE+kEQ2otXiXqPsjz5cc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=RLKpA9CIk9EexhNVSJBQluICEaKbUCupXg1KrOXWV4iyI22HbxBBSTKeOx0U1LoVb
	 M8W73T0ArlltBYLPOy3LlB5e+AUbcpIO8sTfkQWt0SRTr7jN9OiJ0G36CWOuJT+XIy
	 9N4bXeS849tMZW25WRfe45IelO/3Gn7I+tk+Xjl6RuTegRus/EAR4JMS4Wmab/PWmD
	 pNqsJOWIbFMuQo8s6I6YH1VP8ehaJEUVfURipehWtgnBQ7tO34jgD3O85eg23n4foW
	 QwRaqAOFd+OOCHt9Y9PPIWPWRP3ye8th38DauZp2ctT1jBhbOtBsxVCqCp1rfg3Le8
	 y+DX8n5jzy8TQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250804222042.4083656-1-robh@kernel.org>
References: <20250804222042.4083656-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: Convert silabs,si514/544 to DT schema
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Mike Looijmans <mike.looijmans@topic.nl>, Rob Herring (Arm) <robh@kernel.org>
Date: Wed, 13 Aug 2025 11:01:30 -0700
Message-ID: <175510809083.11333.5316863238551613465@lazor>
User-Agent: alot/0.11

Quoting Rob Herring (Arm) (2025-08-04 15:20:40)
> Convert the Silicon Labs SI514 and SI544 bindings to DT schema format.
> Combine the bindings into a single schema as they are the same.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied to clk-next

