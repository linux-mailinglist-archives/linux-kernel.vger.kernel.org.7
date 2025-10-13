Return-Path: <linux-kernel+bounces-850435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08661BD2C55
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72D43AF5AB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A124E254855;
	Mon, 13 Oct 2025 11:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPLXLGqH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D4313D891;
	Mon, 13 Oct 2025 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760354710; cv=none; b=UlNs4tyzixEAK4s8C1GAiVCJuvHBLjUg/79AbLzlPHZoM7Enn3YvEHvG8JanV52ogCoKGPfcT6JEnB+zKzNBQUWriRr+sUuQSgjkIeExZKwRCzEy8+YXPqsYIWqR13rYRvkGWUDpjCZtm1fvzZnoxMi0I9p0njz/RYec/JuKt2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760354710; c=relaxed/simple;
	bh=jzoOGI1CSu6LZhJ6iGLpEOibVfYTPpg4U4whIWU8rQU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T30DISQSFxGumTRTN6jNnAL7IUzlTTLUA+/dn16z+1ufCMofMVGhhYsvVJ49amUC7Yheswve1pmUh28EA0vBmezrzB8VE92zbVT5MskPrC4foJRBCkN0YBI1VpgN++ZZYEQHuTeGcxDt2H6ZZfTd/3pBdi5j5PZwU0VofdlWZG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPLXLGqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64758C4CEE7;
	Mon, 13 Oct 2025 11:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760354709;
	bh=jzoOGI1CSu6LZhJ6iGLpEOibVfYTPpg4U4whIWU8rQU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XPLXLGqHGRWFTDpmqk2tMr/WCdIwMJXdN//5s91pSA/uGh/iGPDyrxdzxTjt9QmK2
	 YtkRch5cmggUziSmABc8NhrayibpP+cEgSoA8AEs58bOgtI3UfvMtQUfWgVzviTtzx
	 H2EjzhAfSeFFZ2YHRJuxU7Xd75/OLrUId9SaP3mcEfm4uMGw/DMuSAHg1+detdT9my
	 QFKcQD3Kuk21LQUHSWfJxkbApRr3zAJAI9S1KHuT51s0rQIXVjHete9RTvqY31cOkk
	 FS4U2xadb5RdiddSKvlfucMg8Z9BXZKIeLQJJK2ZUVan20UzxYLTU1xoFjrrQmwdWS
	 Xx4Yk4QsKzU0g==
From: Srinivas Kandagatla <srini@kernel.org>
To: robh@kernel.org, 
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, gregkh@linuxfoundation.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251001150003.417472-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251001150003.417472-1-srinivas.kandagatla@oss.qualcomm.com>
Subject: Re: [PATCH] dt-bindings: slimbus: fix warning from example
Message-Id: <176035470817.14625.3607322556102415198.b4-ty@kernel.org>
Date: Mon, 13 Oct 2025 12:25:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 01 Oct 2025 16:00:02 +0100, Srinivas Kandagatla wrote:
> Fix below warnings generated dt_bindings_check for examples in the
> bindings.
> 
> Documentation/devicetree/bindings/slimbus/slimbus.example.dtb:
> slim@28080000 (qcom,slim-ngd-v1.5.0): 'audio-codec@1,0' does not match
> any of the regexes: '^pinctrl-[0-9]+$', '^slim@[0-9a-f]+$'
>         from schema $id:
> http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml#
> Documentation/devicetree/bindings/slimbus/slimbus.example.dtb:
> slim@28080000 (qcom,slim-ngd-v1.5.0): #address-cells: 1 was expected
>         from schema $id:
> http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml#
> Documentation/devicetree/bindings/slimbus/slimbus.example.dtb:
> slim@28080000 (qcom,slim-ngd-v1.5.0): 'dmas' is a required property
>         from schema $id:
> http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml#
> Documentation/devicetree/bindings/slimbus/slimbus.example.dtb:
> slim@28080000 (qcom,slim-ngd-v1.5.0): 'dma-names' is a required
> property
>         from schema $id:
> http://devicetree.org/schemas/slimbus/qcom,slim-ngd.yaml#
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: slimbus: fix warning from example
      commit: 4bb909aa44edc254a35bd29b4f63f7c430494b24

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


