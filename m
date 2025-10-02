Return-Path: <linux-kernel+bounces-840684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB0BBB4F82
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 21:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E7457B1AE8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 19:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12462820B2;
	Thu,  2 Oct 2025 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHmK4qwC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267AD34BA40;
	Thu,  2 Oct 2025 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759432484; cv=none; b=ZIrvm0os+u687aDbwY8reAFiE9Z2X4+XVT6IpvdXhXqrkCT4ailJtjt78NJmB8nZAyF+UBHtg2khUxPmle7KtuOWLJs5Jw3fOVRBImizifeKvbSnEnUPULLVXHRBt1DXjrJkV413sc8CzRYpDxKRdJbtrn5lRbR603mTdiLxWBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759432484; c=relaxed/simple;
	bh=92MLjJs609HrhHYwGgr4oKlRLugL7eBkUYYYfFKDQz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFSlCLJ9EKVp9GDMY5Tf17YvQaawA+LX/rHw7eRfAS6NLJ+GyO+G5/0iIWWfGqGqTEGjFtgk+Vd1Yy4XFZNvmdKVueeVEca5XwEOT9CYPC2CKWVn3QtbnT04ff+z1tIrWmuKDWrjk74WjYaFotB6bmqJxVsG19kMvTD7IQvyvE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHmK4qwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B9FC4CEF4;
	Thu,  2 Oct 2025 19:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759432483;
	bh=92MLjJs609HrhHYwGgr4oKlRLugL7eBkUYYYfFKDQz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EHmK4qwC7dftjxl8hzowrFB4APNOBVDoF0Mnb3aALqn3KUPLSe6sNadA0qsYwHMKk
	 RysMe7tFnvHiLKF8xkyixOJrbeZ1CKCF2KdKdLoBTQRhHTmHVANIUcXnYLMNgTaiXI
	 DQDxfucCPSOs+8t1hudYLx3OmcU1TUTcimMDAXCi6bZt+6yBILLBdMVp45gKuL3wrR
	 7FKnNhtPzCYXM6Ocf0MKIukjGlZZ7fNoo3X+oMAElJHk+IH3Eyk+bmXkvCQnfAY/pP
	 MsYcghuEGkK7Hp1SZNm1M/4cHxCiI9IyNt92uTWL6JPWfXy5XBuMDR+GVoefmFXkZS
	 PDMYTTf4BY5wg==
Date: Thu, 2 Oct 2025 14:14:42 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: andrew+netdev@lunn.ch, conor+dt@kernel.org, kernel@collabora.com,
	krzk+dt@kernel.org, angelogioacchino.delregno@collabora.com,
	luiz.dentz@gmail.com, kuba@kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, davem@davemloft.net,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH v3] dt-bindings: net: Convert Marvell 8897/8997 bindings
 to DT schema
Message-ID: <175943240204.235529.17735630695826458855.robh@kernel.org>
References: <20251001183320.83221-1-ariel.dalessandro@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001183320.83221-1-ariel.dalessandro@collabora.com>


On Wed, 01 Oct 2025 15:33:20 -0300, Ariel D'Alessandro wrote:
> Convert the existing text-based DT bindings for Marvell 8897/8997
> (sd8897/sd8997) bluetooth devices controller to a DT schema.
> 
> While here, bindings for "usb1286,204e" (USB interface) are dropped from
> the DT   schema definition as these are currently documented in file [0].
> 
> [0] Documentation/devicetree/bindings/net/btusb.txt
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  .../net/bluetooth/marvell,sd8897-bt.yaml      | 79 ++++++++++++++++++
>  .../devicetree/bindings/net/btusb.txt         |  2 +-
>  .../bindings/net/marvell-bt-8xxx.txt          | 83 -------------------
>  3 files changed, 80 insertions(+), 84 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/marvell,sd8897-bt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/marvell-bt-8xxx.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

You'll probably have to resend this after rc1.

