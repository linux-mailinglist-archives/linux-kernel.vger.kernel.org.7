Return-Path: <linux-kernel+bounces-778591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB603B2E7B0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2281BC51D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AEC334394;
	Wed, 20 Aug 2025 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j89Fnpan"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2DC2BE7A6;
	Wed, 20 Aug 2025 21:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755726530; cv=none; b=R/Dh+eW0Z/edLRdZPFjeb43lhDLQfjkV0XYf5POWkDNSHwYsOi9rv4uVxIgzDJKyNVgDaL/aP5GpaBNG4/Kb5kD3zcT3b/jhaDiC+yJgRINAEkFSbbB46zmpthvZj9sbD/kPG3pwQSJQrK+a9HCkSDy1MQdzWKPMprUlkb0Hh4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755726530; c=relaxed/simple;
	bh=qH0h2tOn9Z19DroXvhL+6bNfSaAXjcN9VS5tRg0Hhts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXd91Ow675LFLn/ZH8KCwCiolmULXohl9rCu7IJGAOJTxbZfSqQKywkr5KFAhJkzLl0V/DO6lEUgJn+MLZY4skTbrY0Tj6hZ153xkgknuY1JJctub9U6zqGaoaM+KMQP6qZy+oA3GjuoSTdnQBpJXKd4r+DaJDm+XVHNUu2MfiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j89Fnpan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC316C4CEE7;
	Wed, 20 Aug 2025 21:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755726530;
	bh=qH0h2tOn9Z19DroXvhL+6bNfSaAXjcN9VS5tRg0Hhts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j89FnpanDGUpCQhqKL0sA8eFdMyZUuFd4zOfGXPKiw0fFva48x/mlXMIspFoQiGW6
	 q1tBeAlELDzdagBz+mRyPprvisMN/4cx4x0mpc6eoQU8SY3NtBXV4FHn8ur6leSRSY
	 SAW0RRCEJmpyDumzp1d48fkRrdU7nZFAsvpM6kPt5xyEqSpvS7xRhv7yCjHh4AfUAa
	 hK1/CSHgM7cLjSU80dc0kLE/67kO/DOdSvyTzTCRyUTCRZY2p3Upoci/n2FlM4Mwf/
	 mtfZsng6ETDVqZYbuioxPQs8CG6L3NzDUqxt8Ige0yZ4HEnymC1PA7/j7Bkx6BWloP
	 DRhG/dsrQtjlA==
Date: Wed, 20 Aug 2025 16:48:49 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Conor Dooley <conor+dt@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: extcon: rt8973a: Convert DT bindings to YAML
Message-ID: <175572652839.1377855.2943403733213575519.robh@kernel.org>
References: <20250817-rt8973a-dt-bindings-yaml-v1-1-150eb4599dc9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250817-rt8973a-dt-bindings-yaml-v1-1-150eb4599dc9@gmail.com>


On Sun, 17 Aug 2025 10:52:04 +0200, Artur Weber wrote:
> Convert the device tree bindings for Richtek RT8973A MUIC to the YAML
> format. No functional changes.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> I've added Chanwoo Choi as the binding maintainer as he is listed
> as the author of the driver for this device; I can change this if
> needed.
> ---
>  .../devicetree/bindings/extcon/extcon-rt8973a.txt  | 23 ----------
>  .../bindings/extcon/richtek,rt8973a-muic.yaml      | 49 ++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 23 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


