Return-Path: <linux-kernel+bounces-641883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D622AB17C5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 16:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB38A189ADA6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 14:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14FB234987;
	Fri,  9 May 2025 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RwDYD33S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBD5233D86;
	Fri,  9 May 2025 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746802318; cv=none; b=qTew61x3sA2VKziCGqCoKpgxnYkFM8AaKM3I7axVW7c+3+B1ReN435jifImrduh0pJUfQ/OlizuLQ2Xh3hG5Ru6Dy1kAL6Wg0jDB7X+t5ryY06egLyyRkLZsVALX5eSNKTleW0SlUGq76E8PNUnlEUJuHLXje2zH5JScM6h4QOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746802318; c=relaxed/simple;
	bh=SQ3ST0q+wlQSTzpE963cNh46bGrba2SRAPHYEHnXIgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4TIOwczukcfdlAtSHRop3gfDMY7vvlub2IxDSLZa22v8t2QWxdXU/NF9RkOZycGqSj7XNoESJhYsByY5nWIr92guxuvYXOEjAcpWedzPHsCa/lVmMvni9RdDacJmGPwces1NOQq7NgxXmIqkB48sZ3+fp7tHq+AyaleT7F9c6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RwDYD33S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A22C4CEF0;
	Fri,  9 May 2025 14:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746802317;
	bh=SQ3ST0q+wlQSTzpE963cNh46bGrba2SRAPHYEHnXIgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RwDYD33SjQ9aKUqfaVwft5DDadUpj0CiulF2fzFJ71vMWCAXZJ50kWMbId5ehqMfS
	 ctRpGO9Q5mUMWHICghU0Ww667FSEMKSkf6Cpf0bwtjKo58fvub7X5ueD2DluePLWVg
	 2fklH6LDRrCmfvUeMRdOXgJ5CnroMOOmVEsicY4g=
Date: Fri, 9 May 2025 16:50:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>,
	Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: serial: Convert
 socionext,milbeaut-usio-uart to DT schema
Message-ID: <2025050935-suffocate-snazzy-c5f3@gregkh>
References: <20250507154924.1602842-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507154924.1602842-1-robh@kernel.org>

On Wed, May 07, 2025 at 10:49:22AM -0500, Rob Herring (Arm) wrote:
> Convert the Socionext Milbeaut UART binding to DT schema. It is a
> straight-forward conversion.
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> v2:
>  - Fix $id path
> ---
>  .../bindings/serial/milbeaut-uart.txt         | 21 -------
>  .../serial/socionext,milbeaut-usio-uart.yaml  | 56 +++++++++++++++++++
>  2 files changed, 56 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/socionext,milbeaut-usio-uart.yaml

Are you wanting all of these serial "convert to dt schema" patches to go
through the tty/serial tree, or will you be taking them?  Either is fine
with me, your choice.

thanks,

greg k-h

