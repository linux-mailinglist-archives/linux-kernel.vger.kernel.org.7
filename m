Return-Path: <linux-kernel+bounces-721521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8980AAFCA52
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7618C1BC601B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A5A2DC32D;
	Tue,  8 Jul 2025 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdAgIJOn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FA32DAFD9;
	Tue,  8 Jul 2025 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751977344; cv=none; b=SioOj4M8INgOzT8GMv4BlPCgaw4R1t1+VAuoVmpHgg/JTyqY1XSka4qvyfNxYoDNTYc+kmYG8GkdgOkq6yPA8Ed946skDiJya1+84KpjFVbt3XRI7nEP19xuRx9eUECuEATnUjLqLrqGnypX6Xepy4YGjOsBH0wTC0gnpiddVwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751977344; c=relaxed/simple;
	bh=tuPbb2QbiwQWALy0icO7Ik2odfl9icbCTu8LaMd9R6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iji/gOYS2KszrVmdN+LohgFo6yWuiHMup32ETzzV99nhym2fT4JD7E3kO92bFRyJ3kHpKek2mBB9XtK6p17ypsUh6cPGqa3ewzuZZik10nvP7/scif/hAYlxbFkfJjcljrWk+Rkd7MmAjTmcB62ETZvZu0FJCeZZHnsVlbx1S1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdAgIJOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F72C4CEED;
	Tue,  8 Jul 2025 12:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751977344;
	bh=tuPbb2QbiwQWALy0icO7Ik2odfl9icbCTu8LaMd9R6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LdAgIJOnpBWw0GaK2QoQBfcABnKwwcONliCU0Mr2WUGCn06gwm4fr01/+e+zeNifK
	 MuJw6hlROQR4EAygopaZjJTQDZ2FzVDkIZPlYrzvrgnQXkRRjpohkNMGsSIvr85OcK
	 G7bX9L2sQ5D3FUvaCwgWpifFjQ7n83vPZL6OpuP7mZH5eE/WhCSMkYsN1VhD0gJlGy
	 jBKihNFQ1wUw3OhP6+8pkjNeksGhcuAC5c+DzL+2ofEolzlC2IMJp8pIsbMRqPq/vh
	 33U2a6720qi41hlNLnn0h8GB4jcGSU4SZOa9QTIQDnQmtbBqDION6S+F4oQuOZq4Ge
	 nOLRyBXKTT4LA==
Date: Tue, 8 Jul 2025 07:22:23 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 3/3] docs: dt: writing-bindings: Consistently use
 single-whitespace
Message-ID: <175197734265.278217.13338560214755636835.robh@kernel.org>
References: <20250707095019.66792-4-krzysztof.kozlowski@linaro.org>
 <20250707095019.66792-6-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707095019.66792-6-krzysztof.kozlowski@linaro.org>


On Mon, 07 Jul 2025 11:50:22 +0200, Krzysztof Kozlowski wrote:
> Document uses only single whitespace after full stop, so fix
> inconsistency.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. New patch
> ---
>  Documentation/devicetree/bindings/writing-bindings.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


