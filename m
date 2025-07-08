Return-Path: <linux-kernel+bounces-721517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A6DAFCA3E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A5E3A6E3A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6DE2DAFCF;
	Tue,  8 Jul 2025 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruuy5wWF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0B8214A6A;
	Tue,  8 Jul 2025 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751977213; cv=none; b=pf9ES8nWxNxQDuzN6a5bKDU7r9jFASBJbW8uHQtkXwZfnfX+RQ09t5QurBMJNURvM7MD2vCsPwxi+tzM9HGYgZuL7WZUpz6rFEcpDVPkDQuqXxxGsBsqpdUCgGGy7GB/KraaSpxld/kCIYFL8LLuqxmKR1LvFE/2RTXcitFH4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751977213; c=relaxed/simple;
	bh=MIehr9jluEp3u5+Mu2StLmgYj37opZ6jQN+UeB8HFp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtML+kWfXZLWfMNJxOIfeXIMoBTr9yUOJz0SACdMWoToopzf5SCp5o9DuNZajs5RRFvK8wBsAPkK7xO3mXOjtnPyBbmQH6ThJNQ6iHDTWDct2jRPes5R62TPMG1sT0iKBwBIkGRnfCASJAuaAcyB/N7JEnhz9wYCLLwPFyqYU7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruuy5wWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D64C4CEF0;
	Tue,  8 Jul 2025 12:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751977211;
	bh=MIehr9jluEp3u5+Mu2StLmgYj37opZ6jQN+UeB8HFp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ruuy5wWFUqsEWusK7NUHv4T9ngpgfIWTzTzfEuRDXF1lU7cm+J6795JqMipPPizzk
	 UfyjtwVIf8LQlnAr8Kca+F+pPxh7UIB29LOY42EER3EUpFRx7MBBsS7U/+UjCz8HlW
	 9JWrHzLSoqBIaYj0erZpEgR+Ah8u7dE1MdC7RmjUFAkmDVBNeLzM2DRj+gZpPQfnnl
	 0Ipt3jGhBi4sW9Z00K8YN108cGX/fuEToS9i7khLR6K7PxcB1EHPLjbRfFEjO7PMZE
	 Q7iiqxyW9JlPOAO/rMeg9CS7SmVjsRCMJgazYhUPm14YmlVckB5cA3+ZCs8pat6Pif
	 gk5MbjJnU+aqQ==
Date: Tue, 8 Jul 2025 07:20:10 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 1/3] docs: dt: writing-bindings: Rephrase typical
 fallback (superset) usage
Message-ID: <175197717909.255573.12171787230277051433.robh@kernel.org>
References: <20250707095019.66792-4-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707095019.66792-4-krzysztof.kozlowski@linaro.org>


On Mon, 07 Jul 2025 11:50:20 +0200, Krzysztof Kozlowski wrote:
> When speaking about compatibles for new devices comparing to "prior
> implementations", usually we expect new device to come with more
> features, thus logically it is a superset, not subset, of "prior
> implementations".
> 
> Suggested-by: Conor Dooley <conor@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. New patch, superset suggested by Conor.
> ---
>  Documentation/devicetree/bindings/writing-bindings.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks!


