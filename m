Return-Path: <linux-kernel+bounces-815710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BE7B56A3F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E89B17D453
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2CA288535;
	Sun, 14 Sep 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="sZ1mCNjc"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF4F2D9EE6
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757863875; cv=none; b=Ym9EFWkgyQBlzY3axRFIephdK0v5PD2E15Ql/InpXFSZs/+MQ6guvQi74Frn71b4XERK54ThMtPsmZBndQA/DQcfwALpuJsPZij6dnxqGLlTj9WFMX0sU4gXAVIRBenU++Gmc7xA7u1/onq6U8PvTCgIcQQbpVdTWy45kjk7rkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757863875; c=relaxed/simple;
	bh=dTHczNh5onmLp5g+RNC4zwxe20ZSdQUfIQ2nnv/nAR8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=PE17pqyBS1PIMUN7PLcdjoCt5lRngQqpdsOCO1BhGf+Tdjp9/wbgDcLTWSs1oDxpLYMlh9/9IbTUhulOz3tKZGZjmILO0xRDHFEVjX/kih2xKPNpYZuW78VW3qkl69tx8yo+azlyHmVxVeiaTQYgr7HEy35viEHjLwG1nd96QLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=sZ1mCNjc; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
DKIM-Signature: a=rsa-sha256; b=sZ1mCNjcLb8O2Qs59Cgdi8XQmIr2zW8QpF5CXjJPHyYByVdvUfVvzRgrihuKmNY/gYoA2JmFMg8M2T0Gv6U1KFyAZ0s4dZndid+uGX9lC2dFypRRiVGVjYUD1q5TufnXjjR8VqDjBv7+pAEzmdDyPcAGLFDgfEv6l6VyP0XnaQXE72u/OQZtPky2wo2sgEiCdiJxiZawzx3cULzGA6tWhR+UpwjV9hiFnO7djPIvlqPohg7VuWhRn0jFcbHOuYciEkzTolCo4EZehlDWnNG/nGiSrTH9lfnKfo19qKNP7kVOZ2Ol5igXH9o3zt4qib2829ZjTFgJ0HHDgw8jMp6uvQ==; s=purelymail3; d=purelymail.com; v=1; bh=dTHczNh5onmLp5g+RNC4zwxe20ZSdQUfIQ2nnv/nAR8=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1797260638;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 14 Sep 2025 15:30:46 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Sep 2025 17:30:43 +0200
Message-Id: <DCSMQ58API63.34STG82T6E4N6@mentallysanemainliners.org>
From: "Igor Belwon" <igor.belwon@mentallysanemainliners.org>
To: "Ivaylo Ivanov" <ivo.ivanov.ivanov1@gmail.com>, "Krzysztof Kozlowski"
 <krzk@kernel.org>, "Sylwester Nawrocki" <s.nawrocki@samsung.com>, "Alim
 Akhtar" <alim.akhtar@samsung.com>, "Linus Walleij"
 <linus.walleij@linaro.org>, "Rob Herring" <robh@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Tomasz Figa" <tomasz.figa@gmail.com>
Cc: <linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] pinctrl: samsung: add exynos8890 SoC pinctrl
 configuration
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250914114457.2610013-1-ivo.ivanov.ivanov1@gmail.com>
 <20250914114457.2610013-4-ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20250914114457.2610013-4-ivo.ivanov.ivanov1@gmail.com>

Hi Ivaylo,

On Sun Sep 14, 2025 at 1:44 PM CEST, Ivaylo Ivanov wrote:
> Add support for the pin-controller found on the exynos8890 SoC, used in
> Samsung Galaxy S7.
>
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---

Reviewed-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>

Kind regards,
Igor

