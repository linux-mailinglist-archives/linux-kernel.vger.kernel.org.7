Return-Path: <linux-kernel+bounces-578722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FEFA735A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 16:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF8A1887F20
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 15:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2786190692;
	Thu, 27 Mar 2025 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XSUe6Iny"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6A918FC67
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743089414; cv=none; b=mgFdc4EmUvyCd+7Wp0U06Bd9w1+BdD12bVaX3TxjE6VOBaA3tDWmko4FlEkUa9A5ADqF8EW4vTASdO2XblnK7K2IsmCZlHOIUO+mm5/6YeSfEAybOQQvY7iSM/auZ2bS26pQ8hjR4EWwcHqdPeU7XHEvihj496ADzUeEwE1C/QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743089414; c=relaxed/simple;
	bh=l/sLG8PC4gXLKCxWoq5MWAup6XbGuswoRl/UrGZ8sVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tc1WR32Gqzk6lDSFrlRu5Sv4x0/5KCoaBsiiP3EyBMCHqgYNX6he2CbF8Qi1BAURZeS0CtlVrNrNu6oJFDQHH+Eo5sYIg/nM4LiiD9Yw8fci1GfZ0FH91moH/gge/w2c9j5Ew1lT1rqJK6fiJVky+Vt0uu8oeZBPIakffriqR0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XSUe6Iny; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394944f161so1450905e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 08:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743089411; x=1743694211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mDTM7gCM2Kwwvfyexd3QaIiedFBu6zY904IFEm1Fsg4=;
        b=XSUe6InyoSRfXHJrw2YFU8JM+0rPMDl4dqSZnI/iChICWYE7EexaJeo7KFF+qcXHdg
         p45JEc+5g9++9VIYO38CcIsZtiNveL0IIjxbT3IzBD2OMNqZoQa28O0TsX5cSMLeHIdY
         p8WlAx+mdEeMjUWuWBjpb2Jzvws7DE/vcC9nFKyZkFF7A1h/+7bFWKL9wpdiiPNzmWhF
         J05eWKsah50h1xul1BJKsJjizXHmpCTEA5QQJzA7Hyni8OMh8mLxzDw1dbwxkKCNz0JV
         iOLUB27rXU52TKa+PSjccnaalmKtPGE4xVPQ47+kYt8b1IdgkNVk4kNRZtfKTrsXHYh0
         GXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743089411; x=1743694211;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDTM7gCM2Kwwvfyexd3QaIiedFBu6zY904IFEm1Fsg4=;
        b=rbNTBNB5JjeQKR+0sh4hz5Ykys+xq5vvuEvTw2wjLXczKvbUYxxHko6hKkDl45HSrX
         XUo2vowNjU3/nAwPKfMfKLgj7Q/3+xh9VtswiRQcc+4ogdBRheyXnad4VokI+S0Wip+S
         FMsy40ibSFdljd/2fuFkYhl3xktxbe744oISj9BpCkpsJo/i8xPcMtxEzTmUehDbh1Yp
         pR6Yh6BuGeJYeO2fCTrpK4PHPGcGP3oGKsmHkYtWEayg1UnnChA+yLww4oqeFYZuJi8P
         xRGeoC+dJjQpjOwr+rmR8zzw65yIdDof8EhkI1KtNDZweZVmO4NvJ8V+NPdfrKbg2pvz
         P0lg==
X-Forwarded-Encrypted: i=1; AJvYcCVuYIZW13zFUqIVAsr1sRbA3HrNIPutqcxtWPRt2wnL04BWMyxCeHqsOEbIzfPv3j2J6nPa0fSzhP5ylv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6t+PXCX9Ik5Ihkb5ao+qsLu76BiOO5IwCKYyKB2DhOR5r+Sd3
	bDNb6roSekVM4hAjHSUZxgYYxNtYuRe3ztOY9WTHlqydgDUfgQvabdaHFi1umHQ=
X-Gm-Gg: ASbGnctG3wmLTof/e1Pkfz/LwZud0ClUdimskyUUTUxFFKzRZs+nyn9NafpehHXL8RU
	S2rNckzIdh+D0l79gRjYHMKlBoGOBIqtUv8OqUrUpnh+vQ8bS+aWKHyRGV10AX9DTdD6c0W5GcI
	DSSc9FhdY8NK1VMIqaVfQbDtQ9onh1N8M2C51T6l9NEJnZNFL5dBTblLAo/NoC40jGPM+McGEGs
	fIgL3rBKphCxlCKFp17QFaMZm/j8aUQ2mKWqSlwIAgOKofmj34yQI6Q9Nf5S7ict3dxQ1orjonN
	dxfFP1cmK8p9o6Pz/kaQiCqexsYVLlBqK0bF9/VWsU8XLMq02nuYbG3z9RSPHlc=
X-Google-Smtp-Source: AGHT+IF2gN6pmNyXrSbguw4xZiJb1RMuPqlNif0uKWYwjztvDXAo7S1+b0DX3m907oWsIX+97Ua/bw==
X-Received: by 2002:a05:600c:1c0b:b0:439:9b3f:2dd9 with SMTP id 5b1f17b1804b1-43d85f11800mr15495595e9.7.1743089410828;
        Thu, 27 Mar 2025 08:30:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f995a05sm20018946f8f.8.2025.03.27.08.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 08:30:10 -0700 (PDT)
Message-ID: <a772a388-87b8-41e7-a142-2ba48eef2941@linaro.org>
Date: Thu, 27 Mar 2025 16:30:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: layerscape: fix index passed to
 syscon_regmap_lookup_by_phandle_args
To: Ioana Ciornei <ioana.ciornei@nxp.com>, Roy Zang <roy.zang@nxp.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org
Cc: imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250327151949.2765193-1-ioana.ciornei@nxp.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20250327151949.2765193-1-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2025 16:19, Ioana Ciornei wrote:
> The arg_count variable passed to the
> syscon_regmap_lookup_by_phandle_args() function represents the number of
> argument cells following the phandle. In this case, the number of
> arguments should be 1 instead of 2 since the dt property looks like
> below.
> 	fsl,pcie-scfg = <&scfg 0>;
> 
> Without this fix, layerscape-pcie fails with the following message on
> LS1043A:
> 
> [    0.157041] OF: /soc/pcie@3500000: phandle scfg@1570000 needs 2, found 1
> [    0.157050] layerscape-pcie 3500000.pcie: No syscfg phandle specified
> [    0.157053] layerscape-pcie 3500000.pcie: probe with driver layerscape-pcie failed with error -22
> 
> Fixes: 149fc35734e5 ("PCI: layerscape: Use syscon_regmap_lookup_by_phandle_args")

Uh, obviously, probably I thought the code is using
of_property_read_u32_index(), but that's of_property_read_u32_array().

Thanks.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

