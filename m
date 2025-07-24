Return-Path: <linux-kernel+bounces-745018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A19BB113C6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2743AD200
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7433923B612;
	Thu, 24 Jul 2025 22:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POCH5LD6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2008244673;
	Thu, 24 Jul 2025 22:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395361; cv=none; b=i+ZCAMsc80tP9EdOvHSiPbtKNgRPLsNhu0rxRzGTLSxNcUb3aTI40jG5P99ADLQWkjtV/8KlzwUzsWSKaxnPZUukoWkirejw/wLRhB4wt28HENpVWaYPR+J90Uvj+LeQiYw1lD7vENtdeLZi2s8rOm64KuIleXgWgAiLPbyFkYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395361; c=relaxed/simple;
	bh=0vu0ZYH1uAtmtDgNry1u6Sxbl9UtwPaj7VLsq2ucptM=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=pVpSh1keWFrA+rnWC/ew0/hvR/o67LxbWWp+0dZfZP/tt2zMQGmy5ZWt4fj/GaFHAX3Dis2w8gQ6Dy+Degw0YinLW3o2YYypcPOOvN7OPB4I56NdYAf+k4ZEVykG6+Ojp8S3iUGu2Mr5YSV4IThJN8LFwe2xCSs8UBRWBhsINp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POCH5LD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8BCC4CEED;
	Thu, 24 Jul 2025 22:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753395361;
	bh=0vu0ZYH1uAtmtDgNry1u6Sxbl9UtwPaj7VLsq2ucptM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=POCH5LD6VIX+jWBiUh+0sDSNstIDYCCroNQspZplXFXELEsxZCevq3kZ2rLnHOekl
	 ZkSi6TmCRB8SNtDAllCTQ7TbZggLAZ2BuGarv8Jgis5/swj8wnOue31sPD1QnRBgbx
	 4ZdT174ZbUYTCZRAaOHXyL/oZ91k5Ic8JsmAmByPSNJBkIAiBw0ygKTiJfFG6OLkRE
	 e+mmKdpk2QqWbOnpuSMPTfwOSEr2X29axqd0p78WEIr7UudNL8AYjkF5TjlZakrPzF
	 IvblYAc+lb3FR3ZjrvOT3h1jVwWT5Noh3Jc6/qcwQ3hTlo6ztZ2X26zjj1ACyYWpGM
	 cTYcxFPJvtr7A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250710-clk-imx-round-rate-v1-5-5726f98e6d8d@redhat.com>
References: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com> <20250710-clk-imx-round-rate-v1-5-5726f98e6d8d@redhat.com>
Subject: Re: [PATCH 05/13] clk: imx: fixup-div: convert from round_rate() to determine_rate()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
To: Abel Vesa <abelvesa@kernel.org>, Brian Masney <bmasney@redhat.com>, Fabio Estevam <festevam@gmail.com>, Maxime Ripard <mripard@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Date: Thu, 24 Jul 2025 15:16:00 -0700
Message-ID: <175339536047.3513.4426298851401733688@lazor>
User-Agent: alot/0.11

Quoting Brian Masney (2025-07-10 14:10:37)
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
>=20
> The change to call fixup_div->ops->determine_rate() instead of
> fixup_div->ops->round_rate() was done by hand.
>=20
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Applied to clk-next

