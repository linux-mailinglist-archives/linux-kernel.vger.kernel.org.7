Return-Path: <linux-kernel+bounces-744958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C87B112F5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6F418833E9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5582EE281;
	Thu, 24 Jul 2025 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dM8RfUPP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E7726C383;
	Thu, 24 Jul 2025 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753391940; cv=none; b=tBqgWRQGEBDtfwLETEDwmAbR3/TP2CLJ0hV0OmBopkaySqPVzhu95vPtRd+rbEYTBDM9rw5JAD1NaAxHbJ9znCUoZTC0YoHEFtNAMARF4G/AzTlDoneFS4pnpYdqAwtL8y4j8yTrtADSONrYwps61gceNEW6eQmwK3kCl9XXZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753391940; c=relaxed/simple;
	bh=sDUTulu8EaMXy0JMLPPQVThRM3cEeroePKOHsh7S+wo=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=OsWbnCc0BSzaSIk3mZdPx4f2tQgzVXM7j5b9s/SlNa1lDBZcX50OQdFEJR3OgOVQUOn3UPRLTQifVt0Cmd98QkDSLvyIsnGnABZn+INHd4b31J3dEi8656/4aHnAc5h5PglyUpXh389BnkM3rsU+gOWmNV9lC/zKGD3EoE8kXBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dM8RfUPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5A3C4CEED;
	Thu, 24 Jul 2025 21:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753391939;
	bh=sDUTulu8EaMXy0JMLPPQVThRM3cEeroePKOHsh7S+wo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=dM8RfUPP7mZBJCohjnwCH8zRQR+DUU8jOFkmU/ZGOxK1auHybNNou9NH9HLvOXIun
	 SLWZfhuaKnid2Rk8oDzx1xZ7K9zkKQfrSnCebo9BQ+mtR5kWHXL4BfFZaPYM60zpj2
	 2+m0RZo41BWgkQuj3TbulXf6q1ZOMxvDuYQd1BT4zqT0rh7v9tIxwdZ3sSeTffDJps
	 gyEAPdT5/vPGk4ywsJYb9JqK9pbebbH9CKprzFHux+oIDZggTmTaPqKYqMeZJIas0D
	 pJIrjj+ill4abKJAJBR5rmnlQBfyZEd4TBXEHE2a50h5NMDt45uFPeBnvWjseZHadr
	 VhuAxm9w8xr2A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250630232637.3700584-1-robh@kernel.org>
References: <20250630232637.3700584-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: Convert nuvoton,npcm750-clk to DT schema
From: Stephen Boyd <sboyd@kernel.org>
Cc: openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Avi Fishman <avifishman70@gmail.com>, Benjamin Fair <benjaminfair@google.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Nancy Yuen <yuenn@google.com>, Patrick Venture <venture@google.com>, Rob Herring (Arm) <robh@kernel.org>, Tali Perry <tali.perry1@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>
Date: Thu, 24 Jul 2025 14:18:58 -0700
Message-ID: <175339193882.3513.3051672630813216313@lazor>
User-Agent: alot/0.11

Quoting Rob Herring (Arm) (2025-06-30 16:26:36)
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied to clk-next

