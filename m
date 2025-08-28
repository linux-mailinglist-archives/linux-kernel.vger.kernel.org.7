Return-Path: <linux-kernel+bounces-790230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621AEB3A2C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81DE47AC413
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F4E313540;
	Thu, 28 Aug 2025 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uVMSpbPL"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129C226C3A4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392819; cv=none; b=HGoNtiB2kOh3Lm+DoXXU+Hv/mpYiu+HmhzVCNNyJXAiPg5djW9R37urz4Bei5BxMktfVGE3Ynr4thw2vNXBDqpzTmg/dcpD2/S4AAO1ktNSfojXxcb2ZaS3y2ZYJHy/Z20uog8sTXlRY9iYfnw7sy+UzYSgoPcOJo9GnfqcfjF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392819; c=relaxed/simple;
	bh=/DJCTdY3b1P2Or2NvSx10h8mL8R7PGDv7zdfJNYKi88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsqRL2N1ns907fDSIZZkLEnIz3l4LtJrZDMFX0o8UtWcXtROigc8XMbGTlkoXC4ceXezixmVUhozCaqZSclk9H04hBdIy10ubdrC63aPuLa2+KJJwkBV7t83KQ36Nz/I+YiR5qDxuWrpBvRffHI48u1XQywwFpB/xfj/j/PH7h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uVMSpbPL; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f34d792c4so183377e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756392816; x=1756997616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgRsIq6h9IQubkV0Zd6BIst1A8E0nIWsW8u9giQ2ZLk=;
        b=uVMSpbPLwEREKSdUhOsR9H6bvbCJ6YjXSHgVQm9tfQG9uoEaHo71GR/LTCuyCi1Q/b
         z175iwtHVFEZGkNAXUfDcwR+ADQDCJbEsv9ikPHpGEZ7GVe0XgYKgQ6+++Xt0xOxBrUK
         xBYmSQYFAY69xQNzvCF32LhUCvlnnNcX/vU6eWspr7Tt1y4TUKq4GAtxCOpmUAYi1XIM
         DHQrMI6zni813zf56hgzP/6/76MDUwz050IsSae64ruk8lJW13Hri2lcexax6XeJUbm/
         iSW5OGeaxHV6hK1GKiwxmGvokZ4Q10/YkgFUAjT2s7BtXx2GRUZwvl0og80XoyQ/zJYZ
         R0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756392816; x=1756997616;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RgRsIq6h9IQubkV0Zd6BIst1A8E0nIWsW8u9giQ2ZLk=;
        b=mXyRM33NQ0T4Y1dxvhNZ9dhrK1WK5IW5uVj17jWHrWjlr+yNMLuISut3eKOVTi3SQO
         0okr34jFCMdj2M6zLVsEnqTlnl2aWcIa+emIJB2wE1IIkssBgqrV57QCkaRWx9r0645A
         VwyzttpwD02adRzb2Igops5BZkO6ePIldcMlm22wEwAG2aSQEZA02fx+J/9ieKY1KyJb
         WxVhRHdnxf3fr0Nb3Jt5WLSW2/sHEsYqQxfZf1GPzAmh9FSGOhKrlMtDsI0So5WpIXYx
         jkaFZThBEumPaSbPfb1m/dymTHUriyVpJth61o5L7Z33NzqLMu+rL+E3hOY85u7YZ/W/
         SVCg==
X-Forwarded-Encrypted: i=1; AJvYcCX7nDJqccTTkEbPoHplarcK5o3Mryv1LYbcvLYxX4trJ72Mj25ViTlrVj4aXkiOEPpYcM9H57NxshLunHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcF1PZDtNLHcmWmnQVHIpQ2QKeM4z//Fwf+/+ZCSfggnuMvMwx
	IHT59OBJu+OuAGVU1LSX+qlp0LZVWNC0aufBkIHp3YfykmY4qZHwyQFCzDyxqir7eAw=
X-Gm-Gg: ASbGncvc5YUfZU8dbGuzG6bqDQz8+LVwMSIP6ekLv/tw6wzICWIbIfKAI/lSk74mLiE
	i95diG7MBwAumdSX3pCkxwEH6ndwFalIFxEYlWPQlswfVe8DnBlyw/tOV3HH1YK7whKr3MIP3v6
	qEdeaLzmAMR2lK1eDIdTuiqw/GqKKoV0/Hs1Td1WSxKWbM+otfhPlSKWlJKgvHI6Wq6nj7hPjWk
	Bwf5T7z6GBm76daJGpDWtoHnd/6AUedn0DBrDBY1f5a7BNY7OaMLtrm+oKLgZK5wo7xtKPrDy/H
	khBe37aBZ23FBpObJ0IrX95EqgUbjgI1iHlfV8p2NB3yTwbMksvMFrcK6iA3z4getRVZ091Fkx7
	iW9O4IVKj3NGHGa4brZSr5L37CsbLYKvBRxsU4Z0JkJK97SPNcJYZa7e/eHQZiQInSWLhuLzcbm
	6O1hdGcg9ov1Y=
X-Google-Smtp-Source: AGHT+IGSuI6V+Kke1CGBKIzaGvPw1P+D1NcZ65uMuJ+zPiHBgCmf2jcWw97duRvN9bxsU4rWcf1vCg==
X-Received: by 2002:a05:6512:12d1:b0:55f:4e46:8979 with SMTP id 2adb3069b0e04-55f4e468ad1mr1956400e87.8.1756392816152;
        Thu, 28 Aug 2025 07:53:36 -0700 (PDT)
Received: from [192.168.1.100] (88-112-128-43.elisa-laajakaista.fi. [88.112.128.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f63098450sm227908e87.60.2025.08.28.07.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 07:53:35 -0700 (PDT)
Message-ID: <17cd27d4-c881-4b88-9a28-555527546bbe@linaro.org>
Date: Thu, 28 Aug 2025 17:53:27 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] media: dt-bindings: ovti,ov2680: Use
 unevaluatedProperties for endpoint
To: Frank Li <Frank.Li@nxp.com>, Rui Miguel Silva <rmfrfs@gmail.com>,
 Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 "open list:OMNIVISION OV2680 SENSOR DRIVER" <linux-media@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20250827194919.82725-1-Frank.Li@nxp.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20250827194919.82725-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/25 22:49, Frank Li wrote:
> The endpoint ref to /schemas/media/video-interfaces.yaml#, so replace
> additionalProperties with unevaluatedProperties to allow use common
> properties.
> 
> Fix below CHECK_DTBS warnings:
>    arch/arm/boot/dts/nxp/imx/imx7s-warp.dtb: camera@36 (ovti,ov2680): port:endpoint: 'clock-lanes', 'data-lanes' do not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov2680.yaml
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>   Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml
> index 634d3b821b8c7..ec5c40684b6bd 100644
> --- a/Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml
> @@ -58,7 +58,7 @@ properties:
>       properties:
>         endpoint:
>           $ref: /schemas/media/video-interfaces.yaml#
> -        additionalProperties: false
> +        unevaluatedProperties: false
>   
>           properties:
>             link-frequencies: true

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir

