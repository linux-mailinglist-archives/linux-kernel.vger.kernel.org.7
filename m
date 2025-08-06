Return-Path: <linux-kernel+bounces-757275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413DFB1C02C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B8E7B1235
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1562202996;
	Wed,  6 Aug 2025 05:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="buB0JW6U"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B811EB9F2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 05:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459899; cv=none; b=JhM9lNWCtPn6PInNOTL5k04BcPcB7QuM+0jpr605SY2xu0mySo25gXI0x1JuOOQWp3pLL97RiLAHWhDBgneE1W8AQ+LYebJPJ3oLtjid72nNEIcaicMfK60pMmScbZ6K/AlKhITYUrrhWUaYcm8i17kVPotKwurJQkg+m7/tSAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459899; c=relaxed/simple;
	bh=0wRXWn07qZNdwQLWXGu6/e6uroSeA3oZMDdv+cemm/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ebtu4DauW4iCkOyV0ogQ/7g5EZarwzbetU4hNm/ZUSrSLn0KIpRP8Af5dS9kJgwabktLOYWz/Z2O/umst+ZeftoSLVJCMXTEmX+BTxMuRAd19AYWfudian7s+gwtBU5wpDTqWgiZhZW72xrKm9jMrYJkbwrkwi476zqhaQpQOWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=buB0JW6U; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61539f6815fso1041012a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 22:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754459896; x=1755064696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lujnusIOjVna7AWXW37RrttIaPYgCcALZjbW0FcrlsY=;
        b=buB0JW6U1frAANZoApn/DEBHagqDYAP1ZGDEKb8bn2lDnYhEKCam4Mgabl73S8QTZf
         zSirLjJ96biPP5dlgHMTU1bHYAdPGmcjFEekgAJEdte+H6QJ9bAQb1c78jMy+4tdecEh
         zeYE7Hy74NiivKIzgrzpm4dYid29MdDbreMNfsW6BV8X5weMCKkyC8LH+lzk7CMZg2pc
         7oubyX4HMROp+DtB4+q884UavLUIx6jlTWNRe9Y/SSDKo8y5DVJHbW0TtzL6tsZcdywM
         yTiX3Uh13EhcusumjS6WVwqvut1Hip7GQMYMxja3ODmXW9iEFol6c8G0s/MmY1j2otwm
         lDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754459896; x=1755064696;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lujnusIOjVna7AWXW37RrttIaPYgCcALZjbW0FcrlsY=;
        b=b/ku8inkjKAc8VaSqEhmrgOMgl7mfKbr+8aofQGxRt/AZpUXaDBxnfOqKuKxOKKPm6
         HQm72mB3KXefUe6E1LCT9sl0ZspRylzFBKIJ9jSwsddPnLuynP8g5eLI5lt5Txbtp8Zf
         KFWzQFuCT9kMaV+TQVbepHnvPY/2u/Vs9BYQCN+Lxi7PgLyr4U87B+BiPSDw//5Wvekk
         ztSGxhpgTIycA7tWVKLxDf5dHNovYUcVlZe/nYYy+GjFlq7KxdXHLDgK+yZ9sEgkFVpz
         2S7z+61lEGZ/nvrB7sKnUFhtz9OGhvIsSDiS9+/jhEDbGjprKNgtaZWAh5g79BPu8i6X
         OukQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvRhN+RsZbulW9+y8mRCTEog47Jj70rO9IGQJKP3Twu4gMJSVjsf1bJO66j2ysPykhwy5KX3JgBrGk32Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAjWCD/rpBmqFEKGJXDIEUn+sWbwNIW1abjny3PsPm5cOWVrAu
	eKUWby7OwyMD1QSBun/B4Lf//FK238CeqVBa2JX0Y6shPPs47A5hZ+dM9mMYZOmamN85SWTxfWJ
	+YtFx
X-Gm-Gg: ASbGnctz6l8x8XcPFEA6V6nzqxnJYVx77/iH7tDLWT60+OLYCwG8+sHUVefF7r/PQIA
	8Y8DpVbd815Mz4vhgX94/ilkOL4d06+VhCjWxBIywvUUjO0V42KpeuOSdLhDKb94UmTxTsOb9Be
	Jof5b3Zm9ZZUwzxOi+eU+lVOhX7PVgMzIOBPjKl88Qz/99PM0e9YH33j1sfwlWoKnNVQ0DaxQ/r
	QP4ISjwIZfgShyRfiQMtGY+IPKrZ9kyeCx/fXTXzANrfdx3Fy2RZ811w6SFhiP4zfZxvoTfQsQQ
	27Dq+LMcusnc3fbiaD7hhVl6ZLedJXeZh/Ff7tNX01R4VPkvjWQjTAa3Nma93latm1yni1KAJrk
	LDYTBvyaWhEWe+z2lzdIclKhYgNZCgc2cUdTQIaAzW4c=
X-Google-Smtp-Source: AGHT+IF5PBw1AWigxP/i3lXZ9qZ3IjP70cb7iYCKvwuxa85ErvQ/KvH596gR5FjO/aMn2ru4M+YOEg==
X-Received: by 2002:a05:6402:3595:b0:612:e258:33e2 with SMTP id 4fb4d7f45d1cf-617961d10dfmr592247a12.4.1754459895685;
        Tue, 05 Aug 2025 22:58:15 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.218.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a9115562sm9686773a12.59.2025.08.05.22.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 22:58:15 -0700 (PDT)
Message-ID: <279fb589-d22c-47f8-9c71-4e959bce3800@linaro.org>
Date: Wed, 6 Aug 2025 07:58:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] dt-bindings: ufs: qcom: Split SC7180, SM8650 and
 similar into separate file
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
References: <20250731-dt-bindings-ufs-qcom-v2-0-53bb634bf95a@linaro.org>
 <yq1ms8d9nx2.fsf@ca-mkp.ca.oracle.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <yq1ms8d9nx2.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/08/2025 04:37, Martin K. Petersen wrote:
> 
> Krzysztof,
> 
>> The binding for Qualcomm SoC UFS controllers grew and it will grow
>> further. It already includes several conditionals, partially for
>> difference in handling encryption block (ICE, either as phandle or as
>> IO address space) but it will further grow for MCQ.
> 
> Which tree did you intend to route this through?


These are bindings, so please take them via UFS tree. Just like with
every other driver or bindings patch.

Best regards,
Krzysztof

