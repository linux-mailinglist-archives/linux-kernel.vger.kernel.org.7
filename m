Return-Path: <linux-kernel+bounces-744957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13414B112F3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 923BB7BDC86
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B852EE281;
	Thu, 24 Jul 2025 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBuEp15A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05771274666;
	Thu, 24 Jul 2025 21:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753391916; cv=none; b=Wz80CQsNmWs1p9C41dlnxFuc4PXaj+Yxgf5NZsKRkpSW30sTYjWIg+QTjPKVGBFRYJn+3IsZiQWaD2QxJaCPYk3RXoVvlZkoHKMK8GAH2TM2NivD2ac/U4W6lpJqfui2GgafgLDeE4O113qC/6OkoYiBJJT03BavQmy5Ah5lShg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753391916; c=relaxed/simple;
	bh=IdtfimAfbnNoflFww3wHpTZAa3JCqSHF6qHluxoM+AY=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=VtjmJrkXuea6nTwDjeCr6tpK6vf6SRlpIKxqB9ArFDaRo6mefddV0ExhJF6k4XiWWT3q3KYVCseKi0Wra/lSa+IgHGBY88T+YOsbCD2JyZKqBORiI2rhIUt3lA8yQ7dZfmHlhQVPmFy2sief3CiVBT9xQc6y85V0GOL5+SXnQpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBuEp15A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF81C4CEED;
	Thu, 24 Jul 2025 21:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753391915;
	bh=IdtfimAfbnNoflFww3wHpTZAa3JCqSHF6qHluxoM+AY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=qBuEp15ApxOomIh8MRz8TTIrolzvjwiIC+cs7NxzalnErdv6R7ZKg9tRNCP2Rqh+E
	 bjcVZL4+xgm3T2ljWQua4Xj4V1luh/wzvwIga1MCyNhTGQRK7XvcBkosx5vt6W/Y4+
	 nzN5lXkLFQk8cb9xnz7sVnCpXBI5PbT7P7u4T/aCKlLO4E58YXbMR+sMXEU1tFikRU
	 rXaBwdxchLI5LI7Veq7kueiulurmWX+VYsH99mYio6TkWgdbMGEEbb62ZTynIqL4qS
	 mSPMoqB+08774dcbilb/j7YvodDwBcJWe2R3Fx65f+BGIxKKxOOnNQ6sQ1KFa6U0TL
	 msjwhq0lpJvhQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250630232644.3700781-1-robh@kernel.org>
References: <20250630232644.3700781-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: Convert moxa,moxart-clock to DT schema
From: Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring (Arm) <robh@kernel.org>
Date: Thu, 24 Jul 2025 14:18:34 -0700
Message-ID: <175339191465.3513.9610109190156131662@lazor>
User-Agent: alot/0.11

Quoting Rob Herring (Arm) (2025-06-30 16:26:43)
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied to clk-next

