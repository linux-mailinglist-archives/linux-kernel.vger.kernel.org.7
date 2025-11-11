Return-Path: <linux-kernel+bounces-894400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C01BCC4A3CC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 700B94F7C72
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D091265CA8;
	Tue, 11 Nov 2025 01:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEO6YDwC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F27E261573;
	Tue, 11 Nov 2025 01:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822989; cv=none; b=H4Pw/UZ7ijD/GIYUT0lbYa8H7bbsNxLv9aeoQo2cZes/pzF+3FdhONLUADl4tUEA0cvhJ0hrlDN/JOIvzR1d1qJfQrhpN3CrnLTG7v3zFwGeGzhDdBrl7U9pRk2F+3IorN6t72SF8lGtWpF9oYJf7gLUY4W8P7D3LwZrDEkDhG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822989; c=relaxed/simple;
	bh=cKFBVOjE2TEHcfLrrrA/EssHwJW0Jxy9jfUxHSkNHWY=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=sM/W1xOOTWhkfMMTN0BoIy1LsAy5i3+iW+Y5ACi3Z3vdGxUR2Ol+RzeWhFg+D0DPaAwbSMkt4qaDgRpS5qZOTeATQi+y7FJaLbhUy9U3UBQQvGWspoW9U6rRopU6EOYXJJYZPHEx7h/ygEddYYmItckj5yj+iqhQAHpi/YG0vCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEO6YDwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB07C113D0;
	Tue, 11 Nov 2025 01:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762822989;
	bh=cKFBVOjE2TEHcfLrrrA/EssHwJW0Jxy9jfUxHSkNHWY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=BEO6YDwCL97Lq3hH324+aXN242l9nqQN9PpxhlBXN+Lj09QkjIDPAOHP9JczkK4n6
	 C62TsALTLQtmCvi5eWbNrP2e96gpKbOwZEipIr7slNfZC6nLdYCBTN+8zZnQyh18hB
	 oPy9tU4ElZi6uParvyLnrfsiIEX+kYjb3WmNf4NnJrMcrjJU5qbTNf9dmUoeKzaNTG
	 h6mLRFBHb0qXNmM4DLZ+TfHASEUkc0/d8gf8FtvezHynukUnate5x8Knld5ka6K85O
	 vp94X8U22BkskFWwn5u+9wqJ7r9QzkHksWEutPvOREwNVYhtt4c8+l9dbP1zQVLz8T
	 kykKmKA8xHITw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251106170607.445196-2-krzysztof.kozlowski@linaro.org>
References: <20251106170607.445196-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] clk: sprd: sc9860: Simplify with of_device_get_match_data()
From: Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Orson Zhai <orsonzhai@gmail.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 10 Nov 2025 17:03:07 -0800
Message-ID: <176282298712.11952.3198486969488880182@lazor>
User-Agent: alot/0.11

Quoting Krzysztof Kozlowski (2025-11-06 09:06:08)
> Driver's probe function matches against driver's of_device_id table,
> where each entry has non-NULL match data, so of_match_node() can be
> simplified with of_device_get_match_data().
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to clk-next

