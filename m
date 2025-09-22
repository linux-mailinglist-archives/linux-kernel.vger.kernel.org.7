Return-Path: <linux-kernel+bounces-827855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C88B9347C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0E319074DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E468A2820BF;
	Mon, 22 Sep 2025 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2ActnDC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46122262FFC;
	Mon, 22 Sep 2025 20:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758574444; cv=none; b=I/3bH7fCXoMlT9Qlr42vAmOVx8fHAUUAeaSOj4gg9HwfdTCs2wrsJd2rhU1BeSYgU/wsYD1Q55u/copRObsNTyAhowgbivBQrgC+RtNIGAMEvE8qZR8mdCAcyVMEYgkdxok/4FMxdSNlFM407veygCs5ravWJW8cCoJr2JJ1ZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758574444; c=relaxed/simple;
	bh=Sr2X5P1gNWeAsocKaWUqNJp3KIq8TIFmVTuLBsbU70A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEl6vWtJGqv+8HkeHwCRlbfkcFLC3mpVm65gRIuL4B7k7cFP6U2wA3eF3JUAtWfY6xcCBrJmrTt93+Q3drl4LD0ItUxzKrbYanafRMbNTrrT0IlWxQV11OT4tWZi3/OjuUIgDmWIbJqrLw/6IcdPnEi7iqPyOlwK6V62r5V56Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2ActnDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6131C4CEF0;
	Mon, 22 Sep 2025 20:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758574443;
	bh=Sr2X5P1gNWeAsocKaWUqNJp3KIq8TIFmVTuLBsbU70A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o2ActnDCu07Tsa6Lughyxct0Cd9FIxHiuwhFxTQSzSh977Ito3vj4x0F0hh+jMQ3T
	 nDjVj8tCwmSqJOz6G0HpWHptllsygqpiUva1wwjADecCewtRykJ/2cbSjKrjeppX+d
	 ERhFmgFD8EDDR/d/PyV9I0oeKDNkPpOSp7E5UzdAuWsP4TXMjyDF0DsFmC9H6z/umy
	 V8emmE/c0NKRAWAcSPh4d6u3w6g8JGAYK1CWhQPgo2i+cRCqY0ayu16Ue6zOcAMOiB
	 ofEAOtB7aF7IKlrEl2uanGx7s3B/ecC0QJ/bLWvt7j5sjfGTnnwPkNrbHisV3vsUrH
	 a37vSI8OW56GQ==
Date: Mon, 22 Sep 2025 15:54:02 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Rogerio Pimentel <rpimentel.silva@gmail.com>
Cc: primoz.fiser@norik.com, imx@lists.linux.dev,
	alexander.stein@ew.tq-group.com, devicetree@vger.kernel.org,
	joao.goncalves@toradex.com, Markus.Niebel@tq-group.com,
	y.moog@phytec.de, krzk+dt@kernel.org, conor+dt@kernel.org,
	marex@denx.de, frieder.schrempf@kontron.de,
	linux-kernel@vger.kernel.org, dario.binacchi@amarulasolutions.com,
	xiaofeng.wei@nxp.com, francesco.dolcini@toradex.com,
	linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
	kernel@pengutronix.de, festevam@gmail.com, josua@solid-run.com,
	s.hauer@pengutronix.de
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: fsl: Add i.MX8MP FRDM board
Message-ID: <175857444205.1306528.291706454583324337.robh@kernel.org>
References: <20250921233534.838680-1-rpimentel.silva@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921233534.838680-1-rpimentel.silva@gmail.com>


On Sun, 21 Sep 2025 19:35:33 -0400, Rogerio Pimentel wrote:
> Add device tree compatible string for the i.MX8MP FRDM board.
> 
> Signed-off-by: Rogerio Pimentel <rpimentel.silva@gmail.com>
> ---
> 
> No changes in v2
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


