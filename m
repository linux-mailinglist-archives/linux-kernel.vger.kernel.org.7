Return-Path: <linux-kernel+bounces-857422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BABBE6C23
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBAB5E25E2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B6B3101BC;
	Fri, 17 Oct 2025 06:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uc+OZZt6"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65717310764
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683555; cv=none; b=ZRrUNYfUODU45oXJLTOCcGH5xiWWP37TG43PzgFQq/zPlIuBqScWf10AZzpbw24TxZxm2rL3HUFEm4CiU5HrKtA5t7IT+NWubbEOO5vYSgy6nwWsNs3vsPj+siNhTCoaM6I6uHBnSyh/D2fT4rKULMJXEkOlbM9paoJxSSINxj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683555; c=relaxed/simple;
	bh=Y8VoXhImxF1w1dbi0lgAcXI04oMk6uKN2d6iSlSdjTk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jF63FQx7uRkjLEbFfySqX9pBooR1XNqglSVsS3WT7LoORcU/dSaw50bB5LQiTYsXVHXUViTR7zrJ1fuVKYy0cb09ohuWjYkihKjhV5Res7V/FWUFdvpOATQJUqhAg7rUQamRtE2bFmTaX7A02FjPUTwx7+tfuFuX0W0QzNtfg1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uc+OZZt6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so14254935e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760683552; x=1761288352; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxXwBRH3OdLI6ivv4eNJ4mVtVC/UotONZ6PQtTD+YIs=;
        b=uc+OZZt6bbuvCyutKKMIvPG3rVkJ2GIgOy5aVU3oE7vOzD4iXxA9OBh6ERxTy7Z306
         6oMQlEyYtTEcY6RMqDgtMo0KBk3c7SQTGcZx4O0PkbSbZeh5Lj/f3ET5DX448msxCLIp
         fIlPrD5ofd6qLa8I0I+vilTBnCF6OpGa0Pl41MZmELHLG7WEb/gGLSGT8UEnJme0OREz
         80XFbD/F4+ZGdgeRXqyWNQ5v06bb+q2uI1hguEZdJvA61akneZyY8cIbE8y0ftpS1EN7
         SnggNWsBVgZtWXUFnaDcjnY0DoAazpF6WIC8i6pZmE0i3wcCaWHfoyazoFoaHC8e1dX2
         g7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760683552; x=1761288352;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cxXwBRH3OdLI6ivv4eNJ4mVtVC/UotONZ6PQtTD+YIs=;
        b=NDnHpb3kUzjY8F/V1CWzn2jYaCdYFPZyFWfBy57h/8litR4wEEAl4fYIgle+tVlUOl
         HexSJvecrziiiCYHTNNKj40LP/ewBvRLCiUojcKwmRj1PtX6sMo9t1RSuMPVI/OZj03W
         p6/XETEeA7eH2/3MNLhbef+aYOGvtwnMCt1i+i4YW6/wswoSuCeJavidyeLUAM+UrFPC
         sJnMK1ACKpn4hlqs05mRrkEzWcjcn3F7uRpzU8T+XpARt4glbrrzWjAhVtvfzu/8+k5Y
         xzQrWULHby2KhukZi+Wb1stqeseFNpzSv1GYbFmUkTSiv2QOYBKhiLY2BerLpg0i3kQ9
         paWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKdgKdwS/X+OSDlZQF5B7sGrRtW/B/mUEhJengUyKbpvA3vmdFBnaQC0uO5edv/oaLjzGiGIivizCLrVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd2olyzK5j61K+uHvxh/eOi60FMdsGfZWEmYK3ju5j2pQY95W0
	TW4RhPvIlVA6cou7FlA/fdgVzAvVgJqejmgB1UOQcT2ZpQr/U4LcSCUVHV+Ijkp/bR4OWvTipd5
	+pNwv
X-Gm-Gg: ASbGncusk+wVYvPly56aMz+biVFBaQWCQ1gW4eJOyD5nqvEoCDCFeUH30ajMHwFUClj
	M4ykcJHNRhF3IOSDhtRLCKoezyt7lC5Oy4VTZTc4nk+XLaWC35IHQeW+qiIUqscGB/1XxFJsDWv
	P1HwE7ulBhUWCE5bumM5hZ6d6EMUzU9a1WnYT96QUH3buuctkbQLZJyKNualowuri/+WK3rVklh
	8eHfXrGAtSesPvXjJILGJ4WUciMUgEvvEIDnnYgqiFh4hvAw5Ik0i3SulAHSporpZdWhH99lxUt
	lvo0YU4DNTs90yI7MIGjK1i9HSVqgIhbCsmYvWlXispqzBwhfPA33G6QdY2Pw3crd91n6kDYLF6
	knefxFpbsT5Oqo7r7mA4QFfRZLGtM8KGro/bXTg3wFrzYggc7SBUvd+xGTykMUIAnL+PP4Hu9bS
	mO3YuO
X-Google-Smtp-Source: AGHT+IGkGQlk9WZP2Ulpn4AcpV8f96nPE/t/dP3omgDpA/THfd4k+GylVoGgGF64mCc4wmfibWovUA==
X-Received: by 2002:a05:600c:1551:b0:46e:2801:84aa with SMTP id 5b1f17b1804b1-471177b143emr18469735e9.0.1760683551674;
        Thu, 16 Oct 2025 23:45:51 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:6426:9b9b:6d3d:1da8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5c91sm63630395e9.11.2025.10.16.23.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 23:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 07:45:50 +0100
Message-Id: <DDKE88TY46WS.1XKHP5I1S3CF6@linaro.org>
Cc: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <srini@kernel.org>,
 <krzysztof.kozlowski@linaro.org>, <linux-sound@vger.kernel.org>
Subject: Re: [PATCH v5] dt-bindings: mfd: qcom,spmi-pmic: add compatibles
 for audio blocks
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, <lee@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <sboyd@kernel.org>
X-Mailer: aerc 0.20.0
References: <20251017061314.644783-1-alexey.klimov@linaro.org>
 <2e4e0ad1-a030-4933-8bc9-7b9782234a15@kernel.org>
In-Reply-To: <2e4e0ad1-a030-4933-8bc9-7b9782234a15@kernel.org>

On Fri Oct 17, 2025 at 7:25 AM BST, Krzysztof Kozlowski wrote:
> On 17/10/2025 08:13, Alexey Klimov wrote:
>> If/when pm4125 audio codec will be added to a device tree file, then dtb=
s
>> check will emit messages that pmic audio-codec@f000 doesn't match any
>> of the regexes: '^pinctrl-[0-9]+$'.
>
>
> Future errors because of present mistakes are not a reason to do
> something. This makes no sense because there is no DTBs with that
> compatible, so drop this sentence. We never document compatibles,
> because in the future they will be errors (if I get it right?).

Ok. I can hold it off till it will be started to be used then.

>> Add the compatibles for two possible audio codecs so the devicetree for
>> such audio blocks of PMIC can be validated properly while also
>> removing reference to qcom,pm8916-wcd-analog-codec schema file.
>
> And that's now incomplete. You add new device here and because preferred
> and sufficient is to list compatibles, you change existing audio codec
> child schema reference into just list of compatibles.

So the way I understand this is that commit description is incomplete.
I can change it to your liking, okay.
FWIW, "add new device here" is said as
"Add the compatibles for two possible audio codecs" and removal of
child schema reference is also mentioned as "while also                    =
                   =20
removing reference to qcom,pm8916-wcd-analog-codec schema file".
But I can change it, okay.

>> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
>
>
> I don't think I suggested this patch. What's more, it wasn't here at v4.

The original idea was to fix the warning or error emitted by dtbs check
but now the whole body os the change is your suggestion. Now it seems
it was not even needed at that point earlier which is a new finding.
Your prefference -- drop it or keep it.

>> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>

Best regards,
Alexey

