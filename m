Return-Path: <linux-kernel+bounces-894872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7899C4C582
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E5F3BB948
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29BB307AEA;
	Tue, 11 Nov 2025 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbSPphKu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C94D2FB987;
	Tue, 11 Nov 2025 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848753; cv=none; b=kxWDeu7IeUQkrewMcD/67UBplOM9O+Mw6n7LPaLgiYfFgYwqaGZhjOy2/CQDoeWBNSJkaNriLGA99DZLPf1j6+L8z8JIbZtVvilzI4j0+WVAqz73w2WXAp9Ig0nm4gUuhodk9Yk5ahoarA3rL0eaJukArOLuoapPFyWXCiDMFcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848753; c=relaxed/simple;
	bh=3td4GzVGI99SuHF/ck+Aq4smT3AtdPcDpKlSVw5KB3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGFOD3fqYG3l9oEKDaEYhFSLlC5H7mcvQ7RXHtWkhlrDg+wd8cJO9Z4pK0f0EE+RyETrzN+K1M3LvizqavaGXkv6SQlBVmBJ2V1GhkCE+JKjBFXiJrL+fe7OOASXaXeL07TtxXi1gyhkdkO6jNZQZp0H4I2oZTXdMVy/jFANtxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbSPphKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65F6C19422;
	Tue, 11 Nov 2025 08:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762848752;
	bh=3td4GzVGI99SuHF/ck+Aq4smT3AtdPcDpKlSVw5KB3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NbSPphKuqyO2xNB1KUDk5h9oQw8fExaDVL1G9SdSs4rxvzyJzk/+1oEouqrpRifEF
	 7PzwbilBffde6VUZ5tnmYSp0xU+DaLBhZ3c4hbCy9JPgdwuoap3QJlGGmJ174femDH
	 CudzQaXBD1wA+GWhQHCA4Z7/AhxBsu7bTwsS+qA7YUJXjBgwNPD3fYiv81Q5OUaWWQ
	 dsR+bezpZvWbNHFHcHjq90uKx30MbZ9gT2tHkTXMNitoMEE0Mq6OEqhOr4fBM3fefK
	 iykw5fmlevDGCZ8ngvKCFzD1PA91R4CpZehR8KD10ZAUN4B570hHDL/9Ml+7z25oft
	 7pULNCeh+3S1Q==
Date: Tue, 11 Nov 2025 09:12:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: adrianhoyin.ng@altera.com
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dinguyen@kernel.org, Thinh.Nguyen@synopsys.com, 
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: usb: dwc3-altera: Add binding for
 Altera DWC3 wrapper
Message-ID: <20251111-furry-curvy-gerbil-acad1e@kuoka>
References: <cover.1762839776.git.adrianhoyin.ng@altera.com>
 <607dec2fdb41cba0220b7b9947e04651f51ff56e.1762839776.git.adrianhoyin.ng@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <607dec2fdb41cba0220b7b9947e04651f51ff56e.1762839776.git.adrianhoyin.ng@altera.com>

On Tue, Nov 11, 2025 at 02:18:45PM +0800, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
>=20
> Add a device tree binding document for the Altera wrapper around the
> Synopsys DesignWare USB3 (DWC3) controller. The wrapper manages
> SoC-specific integration such as clock and reset control for the USB
> subsystem.
>=20
> A parent=E2=80=93child node structure is used to comply with the generic =
DWC3
> binding, which restricts the core node to a single clock and reset.
> The wrapper node provides the additional clocks, resets, and address
> translation required for the Agilex5 integration.

Also, standard message:

A nit, subject: drop second/last, redundant "binding for". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/=
bindings/submitting-patches.rst#L18

Best regards,
Krzysztof


