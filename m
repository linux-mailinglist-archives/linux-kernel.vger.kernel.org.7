Return-Path: <linux-kernel+bounces-866518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF04CBFFFB7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C41D4F7CEF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4253019BA;
	Thu, 23 Oct 2025 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="o1xgZHvb"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BAC2F3C26;
	Thu, 23 Oct 2025 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209010; cv=none; b=JT7ZQs6iKEEgQqprVrFaq1F4yfGdWze+8VgbEE204jwsEn+a+NJlot2oHSD+KRssA36sP0cDk7yzDelpxKmKjB8G8YUseWC0PK854XcZf3Ua0w3Ibi22piVWgCsGQol5nV9/3p5nIKkac1S/J8o/16v7zysvoWN2hihPPRCfGJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209010; c=relaxed/simple;
	bh=Tg/YKzlukto5T/VCecBb8o8smKgleGn/xtMOGtkDGfk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=JZSc4LYdRDuIOXOfv+F9LQiFwDMxLqzjeN5V0i1D/P3Rj/hsQADbRBxuWec08xmSE8rd60RGJE3KZ9giH/wIWyTcdGLu23j7h1SrQEysHJTztnwve45iuGWJBdfGd+UEWpoIXZC9GBwFsPa5hQOqYdARN4a33kI3fKD/dVmb+/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=o1xgZHvb; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761208989; x=1761813789; i=markus.elfring@web.de;
	bh=Tg/YKzlukto5T/VCecBb8o8smKgleGn/xtMOGtkDGfk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=o1xgZHvbbWIVaEEpAHExuV88S4AgfCH5AUuIYRK5l3IWkqgPMqoBkrM+owDQx/0H
	 sXQADk9mvbzU15M9bh2PMXLxkwzhEt1p6pwWlyPHN0Hn7/+8f8PhJw5wAc6y0pxgn
	 F+g2z20pt0B5HBwq3YVC4C7XnZWURw3ZAJ77IUmqkvmW2sJ7qaJOajsSzmjw+92ls
	 VxG1rd4otizxwoQpfxQ9RLZrFcueR+Toob+cG3f4ryrA87gwtZWAVAvSJUljjm0rZ
	 diwMi9vduFf7LY3GLFVBRZT4gR39jr1Rz0DMkLyFgla7yl4YiuEhcdkaN6K9WNAvx
	 3GhgD8HRtlX2Ec+65Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.227]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7QUL-1u6FrV3Kyz-017TdQ; Thu, 23
 Oct 2025 10:43:08 +0200
Message-ID: <85643ee1-cd00-4192-90e9-d713fef50f6b@web.de>
Date: Thu, 23 Oct 2025 10:43:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-rockchip@lists.infradead.org, finley.xiao@rock-chips.com,
 huangtao@rock-chips.com, sugar.zhang@rock-chips.com, zhangqing@rock-chips.com
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Conor Dooley <conor+dt@kernel.org>, Conor Dooley
 <conor.dooley@microchip.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>
References: <5a551943-141a-4842-a4d0-b66b32cf3e70@rock-chips.com>
Subject: Re: [v4 2/7] dt-bindings: clock, reset: Add support for rv1126b
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <5a551943-141a-4842-a4d0-b66b32cf3e70@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/oy3S9L6GeTKGz5YzyTSX53U3y+M7SgqrjD9KIpmhzECssF8h9D
 47Lea/uAHzKHuJ7oBvdA9l6HjtlcKpcJwW+XT8SawGo0O8Se8gsRPdIdtt6WfP9de/JvJuv
 yT1WZvxb9W+XNO4QVLCOyOmwr17RJJmOGsFSacsLKnEsEJGTipCvwG87qLvq0ID55lcEw0E
 jQrPZfPSfVzywbQArw8yQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EWk4zlGOIhA=;uu4isQABIj8uqQdmHGpXM4Bpj/g
 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
 miCGQ==

=E2=80=A6
> IMPORTANT NOTICE: This email is from =E2=80=A6 Co., Ltd .
> The contents of this email and any attachments may contain information t=
hat is privileged, confidential and/or =E2=80=A6.

See also once more:
https://subspace.kernel.org/etiquette.html#do-not-include-confidentiality-=
disclaimers


> =E2=80=A6 Please immediately contact the sender as soon as possible and =
destroy the material in its entirety in any format. =E2=80=A6

Do you expect this action to happen more often with your information?

Regards,
Markus

