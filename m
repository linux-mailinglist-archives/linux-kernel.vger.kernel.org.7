Return-Path: <linux-kernel+bounces-767349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B482B2532C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C44B1B685B4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1772F83BF;
	Wed, 13 Aug 2025 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTTVMV7a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240832F1FDC;
	Wed, 13 Aug 2025 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755110550; cv=none; b=iMsG5mLTckhv07UHZwkM44lMHJM9ZdjnCYsX+sj4s4LYgpQkNXBbUg8ZYS+TUW4Aw3RRObWPNKpHssQQIKiwogk+ySd51niHODcvguU5+ck0zd7C4YDy/22EMynUmXOnvlPHAdOiaqbrTqMSpmd+XxwIGEHPxaRm+aLDd2zuqxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755110550; c=relaxed/simple;
	bh=nS3R5nkgBeVChvLd+J1Ree/2a0Kj8mr2rcxpfR9PtSo=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=mrP64KqGf58BglhYG5iEs9cjdUfUC+9xFvIGq7qrzu1Qd6F93WUIbBq+mANz5OOvwOL0+ag5tcyE4IRvt7XgiMZ+j6/pJJQQxbOqCEFbU7Crql9wId28KuEM2yeEjNXm9PY8qa750P6zBkNd3elRpcjXr1YUgrfOws7H52ZJks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTTVMV7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E40C4CEEB;
	Wed, 13 Aug 2025 18:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755110549;
	bh=nS3R5nkgBeVChvLd+J1Ree/2a0Kj8mr2rcxpfR9PtSo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=uTTVMV7aaDWAbnyKDdFOCIwI8YOwilsmaZX2T+CtsxpxQ1sHSVmyb6ZLoKrUh3XFW
	 Dy6TcQuUxYjZIaHMDjy4ufuK89glY9iy856m/gQs6wTHtX6wZCildttbiunRFuU2zb
	 T79jLMnYIjztDAcjIU8PzqrWP9xqD4uAUxyt82Q92rbj7YWQbaKvPv9n7RREdfJUHE
	 dQBE71qnyFuu9269ED6pTjOSfm577nCmqYw1/8yTI/n1Q9chUwPJ8fMejAuMumAC18
	 wDUR5iE155oXY96KwdVOt6cmfsJfaZXC07zQLdbjNwgWP8a7Xbtml/Nl5mvCC89GNs
	 PevmEEEYCbtmQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250811-dt-bindings-clk-axi-clkgen-add-clock-output-names-property-v1-1-f02727736aa7@baylibre.com>
References: <20250811-dt-bindings-clk-axi-clkgen-add-clock-output-names-property-v1-1-f02727736aa7@baylibre.com>
Subject: Re: [PATCH] dt-bindings: clock: adi,axi-clkgen: add clock-output-names property
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
To: Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <michael.hennerich@analog.com>, Michael Turquette <mturquette@baylibre.com>, Nuno =?utf-8?q?S=C3=A1?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>
Date: Wed, 13 Aug 2025 11:42:28 -0700
Message-ID: <175511054884.11333.362620555660290747@lazor>
User-Agent: alot/0.11

Quoting David Lechner (2025-08-11 15:17:01)
> Add an optional `clock-output-names` property to the ADI AXI Clock
> Generator binding. This is already being used in the Linux driver and
> real-world dtbs, so we should document it to allow for correct binding
> validation.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Applied to clk-next

