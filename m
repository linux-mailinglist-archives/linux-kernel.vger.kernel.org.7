Return-Path: <linux-kernel+bounces-744948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D5AB112DE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE13AA31C2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACC72EE275;
	Thu, 24 Jul 2025 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPOxXiig"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86CE1F4CAC;
	Thu, 24 Jul 2025 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753391531; cv=none; b=bCVfu9sYABSCEKIVP2bjNCYAGdLu/SwPgGGDt/wsZh7s7nz8VRZ7d2vYbDWFYCI0mDGilKLNkBo1StADnlRFXZlVUqAAYpLHAj0utCiEeUi4yg1KkWhYDjxNi75/c/UUDZEESlJDh221Io7vNfo4Hb1iEWBQO7hmn/MU80Ldt+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753391531; c=relaxed/simple;
	bh=WqXl0oSRFmrg57tuZy0QoZl1j1CEs9cN8MESRjdRHP4=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=GZ403s5MJbeH60knaoiWMuBv/zrWh8ExA46iX5aWbCbSLvQ41bXYBYw3CzOLxNFOpjzB6IOam4zzUzG5t3HHDzI8RWXvGpJxiz30PEVWwve0ClnLtHWIy1dB6DOmlG5QsbcE6K000SBnUYFfyMz8KI9Ynaol4EmY4QH65aJueBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPOxXiig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31197C4CEED;
	Thu, 24 Jul 2025 21:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753391531;
	bh=WqXl0oSRFmrg57tuZy0QoZl1j1CEs9cN8MESRjdRHP4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=RPOxXiigZl0IXkgqZbHsY81oVCLVvAoJciliVxuiWWMaQqiPkDjZlE9n/sj09zX71
	 Dl1/yQA8b3WYfqbg0YhxW+1zBaH+l9gtEEcgRbf7vah3tc58mnoy+XENlbv9Ng7wiD
	 nb5TXscnns4PJWAGEs2w9/sxN7I8Xefu/0bXqI8bYxhWKG51JSvXc7dEzx5ehvuxuC
	 SyIuPfzaFcKlwgcyrHZMUT3KRLQVIC61JdYzwFbX76TXZhHQmS7Fss36NiuCxxxWKf
	 0plZfSmyMR/lxZ5VvZ26LkqBgVf8yCyqeQbaj2qtcY2GciIM2tBrBIWx22mXNnjHGt
	 iJz8Yhq3prg1Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250630232658.3701225-1-robh@kernel.org>
References: <20250630232658.3701225-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: Convert maxim,max9485 to DT schema
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Conor Dooley <conor+dt@kernel.org>, Daniel Mack <daniel@zonque.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring (Arm) <robh@kernel.org>
Date: Thu, 24 Jul 2025 14:12:10 -0700
Message-ID: <175339153034.3513.1217988806822508120@lazor>
User-Agent: alot/0.11

Quoting Rob Herring (Arm) (2025-06-30 16:26:57)
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied to clk-next

