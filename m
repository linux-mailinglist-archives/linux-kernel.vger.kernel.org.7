Return-Path: <linux-kernel+bounces-894460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 502BBC4AC64
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C2A1886503
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE78133F37D;
	Tue, 11 Nov 2025 01:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0CVJGNP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F7226560B;
	Tue, 11 Nov 2025 01:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824576; cv=none; b=KuxEu0mjGxnlRVzq0ddzw2wQB7J/b7JgMTKcu1tfN+HO5cGS2QNUZQ+qq5pSOOw8fRIiur8jqcbM8LJpzQpM9lnDxLrHP0tg2/K+j+pEvM8xog9RpHOVwfdatOguOyDk5hETREoXGfDg89lSduBvX6RnFYPLVT4neMRcGGQ9Vak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824576; c=relaxed/simple;
	bh=U6W2jPr8540SGRXE2UTsnrYLyYTWchfI5w6pM9R1bbE=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=DFzsKlUlu6FEhslDSY2syVbKz+4D40mEFlnFg/3COMznCbiJ5gqRDMC5DqgaP9ci/q1wrGn0Ue/UjbWtmr1PIQDRzVPMQ5UhN1WtNUb+nKTlYv5AKTJpVgRF0HBj0yYDM1eBNvtxx4FeaGieaWdBNxuwTBevMEVRuv/+Eh0m54U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0CVJGNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27E9C113D0;
	Tue, 11 Nov 2025 01:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762824575;
	bh=U6W2jPr8540SGRXE2UTsnrYLyYTWchfI5w6pM9R1bbE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=S0CVJGNPBL3Pk3s6zhEH6PRwayDKVjniB3ozUH6Srol4qeRB1ImwzaCt+jIV3mhyM
	 3d9cNIapc98Y8VhJDppv+WflQIrVJFSkJXUMB45S3LZ/Y84J6DVxOwOzlKa8jzYs5N
	 uOvnVM7R3yd00e25PUL/Bx5dDFVKcvbBXz/wyOwEmC72MV0oq5SzXjiotucpnJUh0i
	 9fORh030bnWesZYo65JoUVrPqqufv2UDSPT+262E8F+K7AUXXl4YZ63Vn1xeS9rsmX
	 ncLe/HJA6Mneg0qlpw6nI+fukbxp6h0Eo+O4t02b98x3cy882SUgmHO7GVscfQ0dEl
	 WsJyACN/Elrpw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251015090701.2049164-1-wenst@chromium.org>
References: <20251015090701.2049164-1-wenst@chromium.org>
Subject: Re: [PATCH v2] clk: tests: Add tests for clk lookup by name
From: Stephen Boyd <sboyd@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 10 Nov 2025 17:29:33 -0800
Message-ID: <176282457391.11952.211745741683699733@lazor>
User-Agent: alot/0.11

Quoting Chen-Yu Tsai (2025-10-15 02:06:59)
> Clk lookup (by name) recently gained some performance improvements at
> the expense of more complexity within the lookup code.
>=20
> To make sure that this works as intended and doesn't break, add some
> basic tests for this part of the CCF.
>=20
> A new "clk_hw_lookup()" function is added purely for running kunit
> tests.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>=20
> ---

Urgh I see I missed the new one. Please look at v1 and fix things up and
resend.

