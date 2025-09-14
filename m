Return-Path: <linux-kernel+bounces-815704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAD1B56A0D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29C03B83D8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D52A2D0C69;
	Sun, 14 Sep 2025 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="L4WDnHCv"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2C42C376B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757862666; cv=none; b=c4+5uNgzIm2Jf0YH90xUFpMBVwzOZoI3Yb8rZrjFRkQ9f43Wsqwckbgf/WArdRKiB7pbk04SUBsrw2ox63Pkzeb320JB9LKuG1cRGKhUCM9JOSyRiks1iSwznHjqF5BzJ6S3Z+MqktlJXprydsyDsRPV6daaNL3HguRh1bbLkCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757862666; c=relaxed/simple;
	bh=Kaf1vFQl07mrX87cDZrFLNzQLYHTzKo/KND7wsprVr0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dBajFUaPECcBDosKqEGbmIeutjdvs/cfb/PSA8ehuoBy9fT0dUeiDQbT564+vvt9rb0SdUmR5tFnLRbnJBG32I5yceVGbW3yTzHTPBVmwZJLFn8Ae79uFMB/So0GQMoIW9ylo+F3lTUwu1WztK1YaAA8gSJSsdDVtU1nSLMafNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=L4WDnHCv; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
DKIM-Signature: a=rsa-sha256; b=L4WDnHCvWEfmG/9j1Vq7V3uSroHxRUgM8oYKb1PtlnZXCjsaiQXideBK2e9dAU+0AEUNENM3FqzGDtQDfcoxzdA1oZgj2N3AqWTG8wpmsllqW+Mw/7ZpcngrWpgP6smunf8WPIdaQNjBEzqijMnzHmRukUNhbKnl3zqYNt+SUfp0qmKxy9jlqkPMs0GqsrGHLIr/JGLjmwQZDc8F66xIsbfFKHb30v2cb9K0AUueJDlhToDoVUmMj+3RGN72vDY1L+IjU1zQmkb2+4RDHDiJSVcMD5x5c6CfJ+5na60WPE+GR5cOexGikJYdNvSn4x2v172SPRSymlt+dc9cl0tnGA==; s=purelymail3; d=purelymail.com; v=1; bh=Kaf1vFQl07mrX87cDZrFLNzQLYHTzKo/KND7wsprVr0=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1079693920;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 14 Sep 2025 15:10:46 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Sep 2025 17:10:44 +0200
Message-Id: <DCSMAUJKRPOU.3RGWV9GNN97ZX@mentallysanemainliners.org>
Cc: <linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: regulator: document max77838 pmic
From: "Igor Belwon" <igor.belwon@mentallysanemainliners.org>
To: "Ivaylo Ivanov" <ivo.ivanov.ivanov1@gmail.com>, "Krzysztof Kozlowski"
 <krzk@kernel.org>, "Rob Herring" <robh@kernel.org>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250914130230.2622030-1-ivo.ivanov.ivanov1@gmail.com>
 <20250914130230.2622030-2-ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20250914130230.2622030-2-ivo.ivanov.ivanov1@gmail.com>

On Sun Sep 14, 2025 at 3:02 PM CEST, Ivaylo Ivanov wrote:
> The max77838 is a pmic, containing a BUCK regulator and 4 LDOs. It's
> primarily used in the Samsung Galaxy S7 lineup and is accessed over I2C.
> Document it.
>
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---

Hi Ivaylo,

Reviewed-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>

Kind regards,
Igor

