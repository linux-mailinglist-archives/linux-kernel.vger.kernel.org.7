Return-Path: <linux-kernel+bounces-804427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A971DB476A4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 21:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A53A05798
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 19:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E648626D4D9;
	Sat,  6 Sep 2025 19:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NocqwHjw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FA014A8E;
	Sat,  6 Sep 2025 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757185330; cv=none; b=EMhCUFZyd4HJwkH2+tO9OD8oe9oXmv6Qvbtev2Ih+JkyPImt3KGSvn0BRXDlGoFZRUnF836IJoSkfRL5EAlnqFdenXJh0qi+MtEuuZC5ymcISolxmuY3pK0tCG5PQ0p9BXFUrcVZS/FtPuH4ZZ9Ko/0PQNsTPqT1lVYZnq7aalY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757185330; c=relaxed/simple;
	bh=AcPPmlA+JFLya7tpl9ybxpQdmK8HSFENwjrLPX3j1g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmxsHThIn3OzxgUsuoSaGNbQdDF0Vm1t9YJ6aS9Af0v9nPvmoZmkDnD0yBaN5pFr7yPX6cv8UgjNjb+59VNY33djrN4dXekM/JD/hNKA9FbA3Sh36KVz3xNTNmU3AwwcDPaXGx4VMnp9DdGXLjUTmHRIg0udvqmHXdhw5RwoHGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NocqwHjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB40C4CEE7;
	Sat,  6 Sep 2025 19:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757185329;
	bh=AcPPmlA+JFLya7tpl9ybxpQdmK8HSFENwjrLPX3j1g4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NocqwHjw07cmuVw+SD71MT2uaV9ZVNsUzR2lPnz40eJS6ZxIRGVC7NYB+zYJGxfyY
	 mugBwULbbTmm8LUPmLsLx8FQzcWlxzbmsg6O6sdXbbEbC7HWxNZYr9h92siC6Dekrc
	 2DZf8PugnAsDxwpWNGgF/VsUIdxjCuohKrbGIAsXZ8FYiluZgY+2t1TEh7hc7G3F3w
	 G1uBFP8N/e0GD5/bLAIsVtqGYFvnmMPHutJiDjaM9RidRcxanxuPPUax4sczIruYVx
	 GBc8ylUjtFETiZpNU82TiV6cZN+Q9fAQE7kAAukbzYmfB0mwrrwORK095L7a022uZm
	 hUMyCTdK/F63Q==
Date: Sat, 6 Sep 2025 14:02:09 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 1/1] bindings: siox: convert eckelmann,siox-gpio.txt
 to yaml format
Message-ID: <175718532835.1623882.13775387740774045796.robh@kernel.org>
References: <20250905164200.599448-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905164200.599448-1-Frank.Li@nxp.com>


On Fri, 05 Sep 2025 12:41:57 -0400, Frank Li wrote:
> Convert eckelmann,siox-gpio.txt to yaml format.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v2
> - add missed additionalProperties: false
> ---
>  .../bindings/siox/eckelmann,siox-gpio.txt     | 19 --------
>  .../bindings/siox/eckelmann,siox-gpio.yaml    | 48 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/siox/eckelmann,siox-gpio.txt
>  create mode 100644 Documentation/devicetree/bindings/siox/eckelmann,siox-gpio.yaml
> 

Applied, thanks!


