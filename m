Return-Path: <linux-kernel+bounces-734707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553E3B0850F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5870E4E52AB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8D42165F3;
	Thu, 17 Jul 2025 06:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="TYoW3SNH"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AB072635
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734257; cv=none; b=to+NFdPlP9g6TTwiU9bl+Lv6zTC//280M8gVsNMDOkqyK7x5YmpnYu7ZOU5dfiaXldskjNTDjXyG0dX/AUU/2wO+Mhw2QN92bBYz8aGGSloy9cw9qKWxjlIJMcVdY0MX8j6L+RRms4RJt9bmgak1/xqHotVlhjDqfPcwx+dkIEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734257; c=relaxed/simple;
	bh=Zni4kW5i/r0n1MT3GlQi9RAdKp2l+BHLM9aozZDydqo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:
	 References:In-Reply-To; b=h8raQU3FqA7bczkWEDli6OexaBwS8XxnvvwF9SLBMgZ0BsuyzOgkafio0EoXiw1OcEHdw2Qz6S4b2HTmn0IMpkP+2kyTNMPxUOYj1tL61QEgg5QoFmwHejCUzUArpkJWHWfqEZUMh+kO0SGlEiGgtNVtECv3qVGcE+hUBMw1hV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=TYoW3SNH; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso118357866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 23:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752734254; x=1753339054; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zni4kW5i/r0n1MT3GlQi9RAdKp2l+BHLM9aozZDydqo=;
        b=TYoW3SNH5iZ8nWo5x3YTIv2lAGyP2cJ6eFc+4n5U1Mm0CtpMZ2YBnGkTRUOJpuCmdH
         Iy9Qsp2y9hjswmFtBWIDG4gENSbKZDCEFToVQNVboOnwURLu3W0Pa74dqbEnpjumkhPS
         unFI294L37Z4DL5MyLvyngf/SYv+7LCkQ2NRVj4V7NDTkNkC2o2797jd0xMNJ4vaOIYY
         lisKCrttO+Viw8XKylroIlqqZc8j0OP4Bzusq82RwxoWYWIc330OBtyxrAdne2CL8WZB
         Bq7w4r/+Qp27cctQB1AQ7vcri0NsSiCIVC7shsmk0ySJZ86NsjZp69cQMGQ6UKccLAaM
         nJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752734254; x=1753339054;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zni4kW5i/r0n1MT3GlQi9RAdKp2l+BHLM9aozZDydqo=;
        b=JsJPBcFJQfbHr+InJKMXHRdOFzy9BlSR5IBUwoGmgtgup9JuQc4JwdMyi0EmLhcdTX
         iVDRBH7O+jc9iCIFenBKhVjTpk8GVfk21dxDsP5yPSwZAYS+e+GJJBfMGdgrs7vF6LZm
         OJfr3NfPku/uX1zLV7y1IY2/A5Qd93p6MN8fotXd9rL5+9zLcICa2w0I6YSR71sigAOI
         bzhps28E/zQmWy/0qyEJ5YZBk0h/Z1rmZOw4LAkkws09QbIwdGY0zGGQkNS6/5JAJuze
         8Vr1xW4JMGzXjaQJQrXQi+NQvKzrqj8MUdvQBhwQGPwMXw7glkj1O3N6IINkcRkOht6b
         0Rag==
X-Forwarded-Encrypted: i=1; AJvYcCVvqoimz4iS1kwAeHyHjccsdcA6imwoXTdg+7wKUOnjHqKxYTkHRwY83nBHLgRGgYWkauCSlw/LsCBl1Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQbVfNQekmFMadsdem2r49OzMWc3jcnWAXe71Uvkx5yZsUgYpu
	69Ku01YCgbLl+MRNpcSrUGud4LP5H0YYwWuPucpMRtyRM53Ng8udPf1LM2PNteONjmk=
X-Gm-Gg: ASbGnctLfWhhTO06JNNqeWofkZ1pAtanN/qkGs8vhdt1bXL+UFTFyWt3JSAwnjH+T/m
	fFFS2ojcZE3gq5zwSj6kXg8tGKmRmoApZ/R3MrkxXPxHMBeZbc4ubJv+sIFxv4ezM3d//niscl7
	Rgid/TK3CkF92PMWgJHaWUwSfUcwtHIQrPYD1SRzKDkBKiNaVU6L1tb23zl8a80GFNSdi5Xpy5o
	jnZ/o8BFYOXWul328tl8iVu0hC03Ld8mNFILdcHjiULVK91+cZ8GDc8h3Ygnh/DSZntCQL6vVKt
	mG/8ITSBCEqW2GFVlIZMnpPy5tx/rZIXjv8TDejpNjFIky3ROiVN5z0ZQBf2L3dT4IgX9aziF8o
	3XhQtI8hzvBSH/t3dj9wr3KzrYihG/UJ4dR4pJoXunvvem5dxJI/pkMdW
X-Google-Smtp-Source: AGHT+IGz1stbTnvtFDRlGNi4Bv6lmWH+rbIuhvgmaYas5MP9Lr4lEhFJPcw6uCq9/uRql5jJ5FaC2w==
X-Received: by 2002:a17:907:a588:b0:ae1:f1e0:8730 with SMTP id a640c23a62f3a-ae9ce1c2d25mr614526466b.57.1752734253912;
        Wed, 16 Jul 2025 23:37:33 -0700 (PDT)
Received: from localhost (212095005146.public.telering.at. [212.95.5.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294b5fsm1285352466b.125.2025.07.16.23.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 23:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Jul 2025 08:37:32 +0200
Message-Id: <DBE4FRROKPLE.2O2PPHRU80073@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: arm: qcom-soc: Document new Milos and
 Glymur SoCs
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250716162412.27471-2-krzysztof.kozlowski@linaro.org>
 <DBE47UNGCDLE.3AZF5XENB5BEB@fairphone.com>
 <7a552f24-50df-4c94-9bda-50712fc72485@linaro.org>
In-Reply-To: <7a552f24-50df-4c94-9bda-50712fc72485@linaro.org>

On Thu Jul 17, 2025 at 8:33 AM CEST, Krzysztof Kozlowski wrote:
> On 17/07/2025 08:27, Luca Weiss wrote:
>> On Wed Jul 16, 2025 at 6:24 PM CEST, Krzysztof Kozlowski wrote:
>>> Extend the schema enforcing correct SoC-block naming to cover Milos
>>> (compatibles already accepted by some maintainers for next release) and
>>> Glymur (posted on mailing lists [1]) SoCs.
>>>
>>> Link: https://lore.kernel.org/linux-devicetree/20250716152017.4070029-1=
-pankaj.patil@oss.qualcomm.com/ [1]
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>>>
>>> I asked for documenting the Milos name at v2 of Milos patchset... it di=
d
>>> not happen and patches are already being accepted.
>>=20
>> Sorry about that, I seem to have missed that.
>>=20
>> However I did not see any dt validation errors with my milos dts or
>> dt_binding_check on the bindings, where are these patterns relevant, in
>> case I should touch it again in the future?
>
> There would not be any errors, because how these bindings are written -
> to ignore other, unknown names.

Ok clear, thanks for sending this patch!

Regards
Luca

