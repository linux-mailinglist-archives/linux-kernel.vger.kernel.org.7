Return-Path: <linux-kernel+bounces-720865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2193AFC156
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58FB427991
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF8D233D85;
	Tue,  8 Jul 2025 03:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="Ue1gy2eF"
Received: from sg-3-18.ptr.tlmpb.com (sg-3-18.ptr.tlmpb.com [101.45.255.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E77722837F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 03:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751944853; cv=none; b=KTJi4NjDUOXKZBLOEiraX3iai8/1N4vuDMRmju02pxf67RNV/uLznvETgAGIzFHyx5wWnstqyBAzFxN4MAn2M5KwCKPuyWScPqb689XjxbQ72kyM+8JbVaPng1drFegBkMLxuyQ8qL0lh1IK6Mob3AoTVZsrMSD9ytI+/IxHsqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751944853; c=relaxed/simple;
	bh=mTYeSdk096tddeoPFCBpOFDPThy6vwct+xaDWa/7ae0=;
	h=In-Reply-To:Content-Type:References:Date:Message-Id:To:Cc:From:
	 Subject:Mime-Version; b=m/dKVNHZX17qOv0XEOdOVBKp1lttUanr+hw9PHrDERVHXV88GNxNtEIsFvwKFxNeH/whE5YLqN2apwF2K11fL5z2V0EZZ1d5cn+R+KNWGu1ADTTYU+6KYbcgmSKgIV5pbq//ztfqNNUeRjBAN7Nq88CfTugbw9jBncnhrv8PJYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=Ue1gy2eF; arc=none smtp.client-ip=101.45.255.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1751944844;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=6n3AcRO1UInIIx5xP9ytyTrFoeD+tlmMSa9ec0eVTSo=;
 b=Ue1gy2eFuQuDVBytQP+0t6TeYW8qdUZNqN9GJpBSKoGtO2+3gaC+/qXxV8PfVpXEvf6qIe
 yaBhMg5m05rMfjDCYx+V5lSpoSdV8s+4+FWsd3nzJhMPwZvRozcMKB4g/KICuq2Ymg/kj/
 Tc8/ktNP0e7GM2bCosPC6N0GAfpAguOl0vExFVIDua+nBplKP+KxL0+Ucf5jErzdw90s96
 hixFKaxJ22um9t3V6IsXmRxcBp5E2h0cEqbEl05NsjmIXTZ8wyOnHKYcadZV/ajB5ow64b
 e6Jt4wkQe7m6fadsWvHy1ZUgmEoypFkj27HEasbY8l3dpESwTOGy4cyAcl6m5w==
User-Agent: Mozilla Thunderbird
In-Reply-To: <204c8214aa084d592e8dc45d6c5ca23381937b54.1751700954.git.rabenda.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+2686c8e8a+c6afbc+vger.kernel.org+liujingqi@lanxincomputing.com>
References: <cover.1751700954.git.rabenda.cn@gmail.com> <204c8214aa084d592e8dc45d6c5ca23381937b54.1751700954.git.rabenda.cn@gmail.com>
Date: Tue, 8 Jul 2025 11:20:38 +0800
Message-Id: <bc047c7b-c88f-438d-8f0d-0f593dfcfbe2@lanxincomputing.com>
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Tue, 08 Jul 2025 11:20:41 +0800
To: "Han Gao" <rabenda.cn@gmail.com>, <devicetree@vger.kernel.org>
Cc: "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, 
	"Chen Wang" <unicorn_wang@outlook.com>, 
	"Inochi Amaoto" <inochiama@gmail.com>, 
	"Thomas Bonnefille" <thomas.bonnefille@bootlin.com>, 
	"Guo Ren" <guoren@kernel.org>, "Chao Wei" <chao.wei@sophgo.com>, 
	<linux-riscv@lists.infradead.org>, <sophgo@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, 
	"Conor Dooley" <conor.dooley@microchip.com>
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Content-Language: en-US
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: riscv: add Sophgo SG2042_EVB_V1.X/V2.0 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On 7/5/2025 3:39 PM, Han Gao wrote:
> Add DT binding documentation for the Sophgo SG2042_EVB_V1.X/V2.0 board [1].
>
> Link: https://github.com/sophgo/sophgo-hardware/tree/master/SG2042/SG2042-x8-EVB [1]
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>

Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>

Thanks,
Nutty

> ---
>   Documentation/devicetree/bindings/riscv/sophgo.yaml | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/riscv/sophgo.yaml
> index b4c4d7a7d7ad..e21b65938a65 100644
> --- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
> +++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
> @@ -34,6 +34,8 @@ properties:
>         - items:
>             - enum:
>                 - milkv,pioneer
> +              - sophgo,sg2042-evb-v1
> +              - sophgo,sg2042-evb-v2
>             - const: sophgo,sg2042
>         - items:
>             - enum:

