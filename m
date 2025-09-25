Return-Path: <linux-kernel+bounces-831576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DC9B9D0DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B23428269
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AA72DEA9D;
	Thu, 25 Sep 2025 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSzah0SW"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AB0146585
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758764806; cv=none; b=bH5BESliC74QvmJ+OJxar9XKfSsuAjhnYs9LEw78DN2ygCtOXfcCEjCgqi34IM5tKJxinXA9okansOyaodSmgbPKCnS2cGeYJx5RWAHq1G3e9bb+HiYUAOeMR3t42xKgFSFjW660bWtHaYRF0nQ3ML+gYl+DCiA5+PeC2aQfgZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758764806; c=relaxed/simple;
	bh=qIjm0b0AslPdWaTIs2WPD6UpwsjtkfrF/JhmN6MqGNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIFIDV6uToxnmYbGY6eQ4wy5LHKeDMtTDUEb7n8SMqyPWd/ASaqhEiAmVB2sdlW5A0Am7/94sD9Tn6XbOwSRzrKuzkbDoy6iH/5BvNq711JKPtqP3OKhPMYF1Q27Mf9BeyOR+4xVQ9A4qEJ4ZZFMU+eXY7W2iK9D7moq1eV/lWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSzah0SW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27d69771e3eso4057705ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758764804; x=1759369604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=85fJuIkIL0zFa5NAmKr1mvE2dYhK1JVFush8sn/+tyk=;
        b=kSzah0SWohiOvVb8aVH4abFglRNkagkum6PYJCgN3rniiNUih5RybhLiEg93MCNcIw
         YVyrm/OhZWv/SjTLuZblurmt8iJpSOo3tCSnQyOvGnoERwg1st02vfqt8UhkfaAnAHwj
         iXpFGOned0mJCcmwWG4Baoo6dnEknaqIgxpSBaNaqOkNYA4EqrzY/W5rwTjqyZmPooMG
         /t4S1uvoHD7a3d72eQ9SZ05FQRrPInFXwS03GBRH63NeWxDgiWftQtscu+myUAayHm5A
         AE5eJ8DFC31wtWGEv74XBH4JhDTRQhWrCrWpwIer5jDHgsyhSOzLC97angKnvurgRoIN
         ErXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758764804; x=1759369604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85fJuIkIL0zFa5NAmKr1mvE2dYhK1JVFush8sn/+tyk=;
        b=IOV1zafiWiXzbNtnJ67cCmNx34dv/CWXhK9fTW1jFMmbeWVQ7kCfCxZQDrL3lI3bTj
         HaMYRuJ0mh3rsrrqhbDQ+lKUvfJRrkfnmSBm/6faWfZdPNsGHIDez+OjdQy8Rq6TWsCK
         4Ajvctzqe0Egpp0H42GAIKcyQLLcrU8MpL6AAynnAjiV2n0SuK9x1YhC+08bd/Ig3S2T
         LON6RZXcKGOP7rlDpxS4pxx53V+ysrWgMWfbN2yYzsn6VTlcV9moUUmpFF5NM8GBxwO3
         Gw/q9iJpvtNiBHyeSNR4+9Rc4xSgCkuXKPT+q4e1pvjGQ/sargRP8IJ/Gw4IRubrqY5w
         YFdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoXX/c8RdOI4NflDm3RFpUnCZnCUhGJjB9PLM8PJtD5FZmcq5kuaKbBMi37F2amnVRwG7fQ3cDQZvRvvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI/KbI5tGdYqkx04DGUpYyP/tA41Uuug1h9ddebHU1rFmKBqNC
	hkJ8aAm1X4LFlsvsQVGqKZqG1wZJw2Yho3d9BvbHB4pklIPO1gVDH/BkOMLM3Xa4n6lCs3krRNM
	3ty5wEHFQ6E3ofkXzUOPjIv5ho0imWcI=
X-Gm-Gg: ASbGncvQsHpZ5AHeTYuH7Z/F0IIYc3WrGBmxVxAT31SSOwNLPbCvoBc0a38o5DqhwwK
	AIjBzlj28eCMVtsueKaf5APN+qUobrQT2NEwrWKxnu6ivHo/Xa8er2klLC1Xg/K53CxaJt+3eq8
	zrSSFk4mqXDaueZcfevWOydmn2OvUCF03f3iGy3wQGubLeR1BftN047DERhXDl3V0lOYQfl2I1u
	aeZT4RGvmFo7NH0/CcnoXwqsj6XboVcoevY
X-Google-Smtp-Source: AGHT+IH4AchlDsowYYE+w4wzPJn03yQRQb4BMfQMSzOsS136u1OryTmFlDQB0qJjJ3owJ2eL4O9lMggxOrUiKuT9Azo=
X-Received: by 2002:a17:903:264b:b0:269:8059:83ab with SMTP id
 d9443c01a7336-27ed4ab545emr10812965ad.51.1758764803975; Wed, 24 Sep 2025
 18:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-knp-usb-v1-0-48bf9fbcc546@oss.qualcomm.com> <20250924-knp-usb-v1-2-48bf9fbcc546@oss.qualcomm.com>
In-Reply-To: <20250924-knp-usb-v1-2-48bf9fbcc546@oss.qualcomm.com>
From: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Date: Thu, 25 Sep 2025 10:46:32 +0900
X-Gm-Features: AS18NWB9OdekwkAK17ia2naP3ZlyoDmiLGmgYBkC9bH8Iatmiq7IbsVkxyDb_Qc
Message-ID: <CAJKOXPfVhixCk0_Xh=9XokjHObM=P+SP=itaXHv7xTr69pc3_Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: phy: qcom,m31-eusb2-phy: Document M31
 eUSB2 PHY for Kaanapali
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, aiqun.yu@oss.qualcomm.com, 
	tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com, 
	yijie.yang@oss.qualcomm.com, 
	Ronak Vijay Raheja <ronak.raheja@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 08:35, Jingyi Wang <jingyi.wang@oss.qualcomm.com> wrote:

>  Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
> index c84c62d0e8cb..ab1cdedac05c 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
> @@ -15,7 +15,11 @@ description:
>
>  properties:
>    compatible:
> -    items:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - qcom,kaanapali-m31-eusb2-phy
> +          - const: qcom,sm8750-m31-eusb2-phy

This time maybe without HTML:

There's no such code AFAIK, because original work was never resent and
never merged

You create some convoluted big dependency chain and I suggest first to
finish upstreaming previous project, because otherwise it's difficult
to review and impossible to apply.

