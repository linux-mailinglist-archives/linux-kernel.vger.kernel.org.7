Return-Path: <linux-kernel+bounces-767337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E5FB2530A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CF95C0053
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995682E8899;
	Wed, 13 Aug 2025 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW23Mq7+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1613303CA7;
	Wed, 13 Aug 2025 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755109722; cv=none; b=FtFGvgg5XI92ExWEBYzIcjRsYrqUm0aKSSGbBrRSER2IaBQ8GZZXdElvnZUR+huU2MSFIGsUOyK7B8jVY15iUZXRBW+oPIV7x7wh4G69EImPIJht+TM/juguRSYwqsZBZqHyChS664kPdXDUgcchM48Pgo8iMZM+kzs3ah/lLBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755109722; c=relaxed/simple;
	bh=g7NrmZyTpoXRHvylX8G3S3T4bCEbl2q/bDIlwKTnf+k=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=a8/gNYcJB6/3XapdmjWzDDci3eJ1djH0iOQsjgImfC3VGsUOXHDvQa21vPeHCHo9jfKxwKsODBFdhYHTntqGfkYuMfOww8XQfnxe07AYSDSyOjmDkHxiJwc3dBB5Fum/hRypXmxUaWESsnOCeWSXkjIzkmOhEzuPVZvnH3FmI4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EW23Mq7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67082C4CEEB;
	Wed, 13 Aug 2025 18:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755109721;
	bh=g7NrmZyTpoXRHvylX8G3S3T4bCEbl2q/bDIlwKTnf+k=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=EW23Mq7+FlaIzY09fHbFfT0pR+L2s/S51W5lBwMUJQVk+Vnam8y9NpvkrElAUlwYj
	 AwSFvqS0PeuqZNRuQolQgR6ZEyd6dZcI6qlWiCyO3ZMi75kzZryf2zEQMFSrtEq5bl
	 0mxL1FF0g3RV4yUZkdEFGSyx3mq268vWZqPrZqlBQVCCsZQMZvdjikfK4kQw3gAywO
	 qQc78SU79PvgMka8lL1GCAdTP3yJ0yyzXDede1WLbF1wN8ZG5fJa4K9sAfMVzRNLtz
	 DiSoHr+TI0u1fQWJBoAJkpMsJzjwR89NJ1PeoVp83W55VzOY7iwDBrvqJJmBwsCWfA
	 sgfSBrG/IO10g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250804175304.3423965-1-robh@kernel.org>
References: <20250804175304.3423965-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: Remove unused fujitsu,mb86s70-crg11 binding
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring (Arm) <robh@kernel.org>
Date: Wed, 13 Aug 2025 11:28:40 -0700
Message-ID: <175510972073.11333.9047041648755955518@lazor>
User-Agent: alot/0.11

Quoting Rob Herring (Arm) (2025-08-04 10:53:03)
> The fujitsu,mb86s70-crg11 binding is unused. The driver for it was removed
> in 2017. It's not used for Synquacer DT either like some other mb86s70
> bindings are.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied to clk-next

