Return-Path: <linux-kernel+bounces-862260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C5CBF4CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F1EC4F74E8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB36F2737F8;
	Tue, 21 Oct 2025 07:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ6Aic7a"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6651726E6FF
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030193; cv=none; b=RJVgyM4DCQ3YLE1lGRu6fReIIX6xxBCjxyRbwfcr/x94agLEtN194U1TJYKlT+UDJuR5Tp6ImWlK+7BYVOJPeSAQWxpnPpo77B+QqVw0P07I3rRd+/sX9h1ImuLzH9ISxoPKYkvXC+2ejHt5yPMBFUWfd9KQXK1fJniAsCm+XM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030193; c=relaxed/simple;
	bh=Trt9/WBbPE+M4yerJ3ajCCIXdwVs8rCRfWuIswNj814=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egdfTyfHcW1iWodLQCfJWWkgWf63bwb8lTaNyEC2veajuv2pvmDHuKQO9WL24y7OI5n1DJFQPZyk2VqRrfjT1VnnjOhI0ctHKuegM3ml+iGuoGHCD8KfEbZf8A2tKf9RbZ4am9VhAsLzMpQAjxjO76fmlPdvpc940FRp9JDk68w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQ6Aic7a; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso4650302b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761030192; x=1761634992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ytwICgmHnNiFmycdKKSg7V7bV41hOS/rk94HNVcG15I=;
        b=VQ6Aic7aIBN7BvnAi+E3SsHA9dsx9Z83eobHy7WN41mtbJgzzdH5YKhZNsZmrKwEDR
         /hsD1Ty1NCCQJceRKRM4md/ZMABuwOGvHMmBicmpsQb6mtDpDrhSQ6wDUNnHTNH3M/9r
         li2IScUP4a+mBit3WTHaxkTrvfFCJhFunUh+f7kSWgU717xJBGjVOuQnTbIXpudZcMgh
         yMnRm3GNDHBbgq8iqYJSJRnjkB7UUbWjTTROtyrLIKW6nk8ymu10Cg0w9XJE5Z/l6ruR
         p+D1y+peF2SQw47DmvcT+0D76LReujNUaHQV+n2er8qs5p7DBkXDka11Hua7jN7EuMik
         B/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761030192; x=1761634992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytwICgmHnNiFmycdKKSg7V7bV41hOS/rk94HNVcG15I=;
        b=an9BgGItISsoE0ZZ31xAK5s16DiPnEnwfPB4MuBvgfg8TarQHbUPQq1sPcnjTsu9Mj
         W5lqjEn+n3Xz7HeI0wnboURe86/XG1EJzvHFp7NJfchdZ9IRfcdudKucpgULOMp0nAms
         R7Y9tEV4JU0ZeY3ohrrf0SCagyH1k7b0Bb/gxLbY0rvHCWrTMPZHYxQ+6rB5kvYTfDn8
         COJJXaqLsFlsNxyL7+IskMOMOCjpxXaRL+ZQtH5g2GAd2xDBvfzBigzzv9e0P8yL7oeU
         mL8mcIvFO2pF2G1KQjFIFGLNF1l2yUc6LfyUcbk6hw3d/VAUb4cEf0FWi39i31M3jL5Q
         Q7aQ==
X-Forwarded-Encrypted: i=1; AJvYcCULGNWfg+JkyWhW52wK0ZKMTGQgAMPPuvvKf/ESFpCC380lXctnMWrp0pFe7cAX2fW5MCnjCLvfUIeyNTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUpBm4VFGvTh5UfpDN2gQJMIrWoE8IXNvdEtnS063Nyam4Gpvv
	ebSK4TUBOaAwNUfX1bqsziGDrzV/Lfpm9k33SdQsJa9e0NJjRaiK0hNa
X-Gm-Gg: ASbGncuFfK7p8t4nqXxrJjGwsr5fTG9cddiI3JEnh9Xf79OZHMMS5ir4IEfd7xUMM2L
	s2s5IfUDXOKKWXO6guY1/iIu4KgDlF8qmEyWy8okavSWvaZa2VQxNx0dC9x8YNSXyfbstuD3EB4
	5pz1e4I1/gzmS3SQZlIabVa/JCr3MDyRvJ4KnmY3Gtc8zvxkLVhgecpkhA4YRNHYuY90klPpQHa
	4Sx2KDu6/H01WoXuqdUZTez0m1OzivnyUEVsaJiSBRYKJJYaw8fITQ54W9EGEPS4jScN3HRsGkb
	2gI6KaZC9YZF9yBOg6FtpFEkbdPYNtH1Z8Mx8S/X2KtlokbFHOW6M5UoJfEf9krpGhhra4O1OT5
	wOBpfBH3LmKFRqzRIRDDHOgFATRjkBAzEkzyan2O5X//fweU6o/sWJ0ZpfcIzvOr/gb+rsrKXrz
	jxRZvDi6ApbrpxfK6HSYQQ3cI=
X-Google-Smtp-Source: AGHT+IEY2zmPOwhscx1EDdtuLAginTFIvWQhGpHhHiYdyy7zAELaeMJCOQiAd3k0JqmBbx5zBDOJkg==
X-Received: by 2002:a17:903:3bce:b0:24b:1625:5fa5 with SMTP id d9443c01a7336-290c9c89d97mr186476275ad.11.1761030191637;
        Tue, 21 Oct 2025 00:03:11 -0700 (PDT)
Received: from [172.17.49.162] ([103.218.174.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29247223a3csm99924915ad.112.2025.10.21.00.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:03:10 -0700 (PDT)
Message-ID: <291a0fb6-12e1-42a8-8cd4-0171ec996ef8@gmail.com>
Date: Tue, 21 Oct 2025 12:33:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: talos-evk: Add ADV7535 DSI-to-HDMI
 bridge
To: Krzysztof Kozlowski <krzk@kernel.org>, andersson@kernel.org
Cc: konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251015122808.1986627-1-tessolveupstream@gmail.com>
 <1689b441-89f1-4f2e-a528-be0b91d34b36@kernel.org>
Content-Language: en-US
From: Tessolve Upstream <tessolveupstream@gmail.com>
In-Reply-To: <1689b441-89f1-4f2e-a528-be0b91d34b36@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17/10/25 18:50, Krzysztof Kozlowski wrote:
> On 15/10/2025 14:28, Sudarshan Shetty wrote:
>> Hook up the ADV7535 DSI-to-HDMI bridge on the QCS615 Talos EVK board.
>> This provides HDMI output through the external DSI-to-HDMI converter.
>>
>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>> ---
>>  arch/arm64/boot/dts/qcom/talos-evk-som.dtsi | 21 ++++++
>>  arch/arm64/boot/dts/qcom/talos-evk.dts      | 76 +++++++++++++++++++++
>>  2 files changed, 97 insertions(+)
> 
> There is no such file.
> 
> You need to squash it into original posting.

Thanks for the review and guidance!
Understood! I will squash it into original post.
> 
> Best regards,
> Krzysztof


