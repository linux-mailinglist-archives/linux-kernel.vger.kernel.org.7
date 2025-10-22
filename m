Return-Path: <linux-kernel+bounces-864653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7C9BFB445
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 362D84FFE6B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6647031AF21;
	Wed, 22 Oct 2025 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3HfUkcl"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EB6322745
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127094; cv=none; b=PyBYyXHWcHE7pQQV2v3/+/PuZ4ibE6gANpHaEh/EL+CipBHg+RwnXfFXW1LaR5P55AxO9pzMG4lC28my0k5B5CzwLx4uJiyyZXk70hotLoS91wUx5gwYE0muBBycih7ciWiA2AIi/IUcPY+n2zrB0S1j5y6TcIyoKguMx3dT9L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127094; c=relaxed/simple;
	bh=iCmVveW8K5itPlbSWwTOzhiHZIezfFCVearssnUweJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnMbGpxZjBE+SqaB11r+kGHgswunEZ4boqJpKO+MSlQP4AQwOdhHL+GITZVKGLiaaJNSJF+FdjGhA/F83p+SXzpdXl2zkCwWmptC4Y2TqStbT2hQYhlj4pdPsiCfA6gHbjTS7jGMCHBPSbT0PL/9/I2JUk8BZP9A9By4/6e71E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3HfUkcl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-292322d10feso7215715ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761127087; x=1761731887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVActZ1pq3qGxGgqPiqLHf62BgsT71eBUBtJsDoDR9w=;
        b=k3HfUkclhG1vmrZhEWR2EqeDhV0LKpTiUj4Q0WUqSE7XJY+ZfZA/SqouPQDC4HzsmP
         iilKt3wPVgbzpHTF9GiQKZDBnhbB59tnxQV7IEo05EwXvftT+sWzpg97jyLloTgk6ktL
         5viFKX/mpjK4kWqbPD5EdZP2CUXnL3EHDnztsa3W41ZCa2Sz5RNIUpm0oR/LkbxNrRJo
         FlR4Rlw/oUqWAdUtDiuZdkuApNT+Pb9K9vq3/z7Sm+gxrLorT2QIgwmR8vFM448y9Bx5
         LgzKqLlH4taMZqnVM+kpruKovTs2kypl3l6fpcGWm+wnSMmq4mJ/ARao9JR+DIb6Mp0y
         7sTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761127087; x=1761731887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVActZ1pq3qGxGgqPiqLHf62BgsT71eBUBtJsDoDR9w=;
        b=Wqbf6uAwLa2gcwbEusnyQXdnG2INCyC7yfcbI4yRgcJ+6We3DKsNzLlpE+bduH9IlM
         8rVUZWqjr8fCRVY9m1z5Qhz1HD3hGW2n96u7cO/swHiIY45hGxKe1Yz36xGBWIXsbnKi
         ALNGDRzop2XcpcYTwP8+xy067nhV9aICjZcjrHpGe2SHq6k9Befx6e8iI4aWSUrsfm9Z
         GhN+pMeOn2SAiVJmdYO3Hb58RFFvMrnwO5x5ZWhFUd59SY7DVrQUakAyE+PvmbXAtFc/
         Gm6WJLRy+Fko0V5y7nsa3go99IMwRHwj6d1+WMH9vgDUVB/FnywaAdgnMMw/qzNaiV1l
         oKug==
X-Forwarded-Encrypted: i=1; AJvYcCWqKwPHcKIn6J94UclR0mY4CRH8fB3aFk9bK6o217nb1ZXEHsQNYCeIBB6FpYrli+zf9G5xeIHK1dm4XVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXWRYZDmrLhQjHX0/QjkXSNL5era6nzTBrrwgIu9ynM2qV2HDB
	+Z4qKPb0jOC2QS3QFML1TVADoF2bMH1DPZER8Ze/Ohvc3Cshy2k4jicZ
X-Gm-Gg: ASbGncvIVZY6us8VHRAM/wsl1L3FvwdhaFL2aUbQfAqb72IIYfSKmzF4Xc/pQQDKiqM
	rH23OiHS1soLw8qUIvQL2EdzAMeeZRqjakQ01k77J0T2Qq/D+SRXGgLj+D5ule2sZnC1zbldcyh
	8TnhhmPQaiH2RWOAqWRyLJRhJ+bPw1gb9OTAlgsxRLr51gciNXMTTRHdNvQzwJe/8cjryyCc+Me
	XFzxRIXffN/+CDaJ/gZS5S6iE/pMSkhO1gJZhiY/XCNGHHHiXpzon7vIldeERJZSh36I37WCIOB
	Cw+5crq/tWmGVS7ZYL6DOkxy7aROaEjtzJHnwED9/vBEH2KZx28RtxN+sAzugQaJtGHdNV3L3Dv
	S7PK5k1s/0/vMe7vT0Slu4QtrB/lFMqLojE5tnlO4Q0RYuTllmgoTXN2du1eu2106xgM3YzkXy2
	bG9QHB/a+fiIwfR6c/eBV5wlg=
X-Google-Smtp-Source: AGHT+IFV4XcWduAnqV52GPPuakAlxK8oM1cbQ3QP6ivAnR1Ti0B1TTwmp6oM3qqQPkoCo7w4j7H50Q==
X-Received: by 2002:a17:902:ce90:b0:269:7840:de24 with SMTP id d9443c01a7336-2935e0f97d8mr9472685ad.21.1761127087202;
        Wed, 22 Oct 2025 02:58:07 -0700 (PDT)
Received: from [172.17.49.162] ([103.218.174.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223dfaacsm2086905a91.10.2025.10.22.02.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 02:58:06 -0700 (PDT)
Message-ID: <c6bdfbc6-d9f9-4039-8b05-5f734010e3d6@gmail.com>
Date: Wed, 22 Oct 2025 15:28:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: qcom: Add QCS615 Talos EVK SMARC
 platform
To: Krzysztof Kozlowski <krzk@kernel.org>, andersson@kernel.org
Cc: konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251014120223.1914790-1-tessolveupstream@gmail.com>
 <20251014120223.1914790-2-tessolveupstream@gmail.com>
 <d145f298-83ac-4829-8302-501c7ad97b8f@kernel.org>
Content-Language: en-US
From: Tessolve Upstream <tessolveupstream@gmail.com>
In-Reply-To: <d145f298-83ac-4829-8302-501c7ad97b8f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17/10/25 10:43, Krzysztof Kozlowski wrote:
> On 14/10/2025 14:02, Sudarshan Shetty wrote:
>> Add binding support for the QCS615-based Talos EVK SMARC platform.
>>
> 
> Nothing here nor in DTS commit tells me who made talos evk. Please use
> full names of products, e.g. "Samsung Talos EVK SMARC".

Thanks for the feedback!
Sure will update in v4 patch.
> 
> 
> Best regards,
> Krzysztof


