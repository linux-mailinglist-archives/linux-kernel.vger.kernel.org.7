Return-Path: <linux-kernel+bounces-841227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2EFBB68F0
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 13:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 104D23452AC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 11:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3AC26B2AD;
	Fri,  3 Oct 2025 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SccaffRP"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B3C149C6F
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759492074; cv=none; b=pAExc/5YM3sTjqcN4WhSg0TR+hFcu9ctjiVR+RQUfTuvYuMzJw9BiQzd59IT5wjqrXWfvqQ0shrVJAPH2QHWFfU5aajtBe/LTlYd6W3FEdUG544hlFqfnt8S9kHqPofTFtiRiwlFuGrh60Mho2P3SKRMInOhZdHogcBozxLj9QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759492074; c=relaxed/simple;
	bh=2svmnL5W9fHAh7OCwYJI52rMygM4RGmMIOyvOwXoAD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJl7z34g7odbUm9OKPB/bUwQ+CQXBRj/C7qi+VQQ3o7dlwUSSIH2ejujTYYp1LHFt3Ui4V+CS8xakFsqEVuA2OEZG6SnocuG6BY7kTjG8HeXRPFmdO+hOdFoTO/5QUG/dxX59mEr0jlkdN9+t3m/L1srT3GlTTWrBeIZss9yQP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SccaffRP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3fa528f127fso1625457f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 04:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759492071; x=1760096871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7/KgDb2EOtzAaHCJpvVmhuRV/FvIwMswDF2oXvMiSp0=;
        b=SccaffRPX6u+8az5OI6Jr1K+dDajMZ2CMEfUOIAZQXZnsf9ls82dEMfE72427SncY5
         hxUZ/Rek+tnC73/oo+mvAt3h+cDOl0BNbpB+1CG3V6eXZKWA31Gvl3Zr9U+RbTB9YY/S
         DsuPGu0o3EgGS9ApXAwff1d+RGnejieQ1QAgF3LmH5/NYDwb+kMl9XLZDKAw02NVQnl0
         FOHjouBLd75p4Y2MP8xqI223KKwHQOTQe5ypB9YyEdYHBnbRz5m1Zi8UMCfgMAkuI5Ye
         3AEulRw7H/j6pfMKVSYiBx4ET2IPm2hphymsC5sOHHm00d7SCddRHaVyB60xMxSZfVWl
         z+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759492071; x=1760096871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/KgDb2EOtzAaHCJpvVmhuRV/FvIwMswDF2oXvMiSp0=;
        b=PceFxbBopZ/diBQ9l4BXWydioaHVGKRPzofB8+IBwQb2qrAwpxNy7q0nU1R+XiURVF
         M/pNBCfqUfH2TfDe2kS69TIGfuTGvEZd65Mj/777bmVetp9Q9fsFjHJF3dptfdXZ53OV
         GiPgl4feOgc2+vAlH9N5SeWIKk5wahhsVUOKUPQtRyRVItBuvvxkEau/nP4zY/qVgr3J
         aI1sluHgpORo6kCmMZCiJC42MMhXfI9eajLu6JmUuq1/lmMolnA7+PGrb7rNgH8vyjit
         WDEKy3KKn7J8NBsg7n5oWWPK8RaEFeoECFcJGTmjP1IVVPkwqqRDf5HO6jPv0+cOjwD8
         EYng==
X-Forwarded-Encrypted: i=1; AJvYcCW1XLfB6FSnWMFf6a2pwbNNVOsG6xMI71b5hgfw6nKe7mGi5xT7Ol3XRwF4PSjJzyB+NZDCSK/4O5q8JLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynklr4asWRvrmrxGnFomeS+Itn3it+uGcxF+Sr9XSOBtXtEb9M
	rKykYSpYzZbPTjFwp0sDrKQ/6vpW6l7bGRcmNP2uLl6uV+6BftzfNcz02D4Us5rNsMA=
X-Gm-Gg: ASbGncuw5s6MfEOGDkqeNmSrPCE1kTJ4hZnv53LEJPK9xhnk+bv6evjDp35F9G210iR
	lRqBv8lNeDj2AbK+ZJsqs4HIf/Tp9N3B0URuVXLrYyVFUjP3xTXmVfuZJKC/1JmaoVSBvJ9QNRE
	2ZL5H9fGQLgmkQfV2cu6aK9Om9d1h9EFkSVWvuF4HzI0B3toentNYRWMMHQH7VHLjUuX8U4zyz1
	VECVXt6G84Yx76vOxyb+kmPY1TMysgjaLmYnuODM4J01eKg9zdSZb1gNdPv6OMZYZ5eODkoc3k0
	RlxV4N7nnxhGO7LNMktRMNGK5ohR5mDM3/zk7h0zM1FDoyxbqGkd2bn7KrByHFf38l2X9UhAco3
	BL6+V9WkYL45ZNBkrx/B7CqXNlytnfNQK8jD1qR9U3b1QPfZUj/Xxycxchg==
X-Google-Smtp-Source: AGHT+IESJDSc6mQQMKMQyR49ZqsDALXur77A+f6oIUGvguZQzEFSN2zR7wxxCAC6D4vSJcZ/1VddfQ==
X-Received: by 2002:a05:6000:2303:b0:401:ae97:a1ab with SMTP id ffacd0b85a97d-42566c0cb9fmr2236560f8f.10.1759492071508;
        Fri, 03 Oct 2025 04:47:51 -0700 (PDT)
Received: from [192.168.0.25] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8abe9bsm7694982f8f.22.2025.10.03.04.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 04:47:51 -0700 (PDT)
Message-ID: <56579459-4e33-426c-a6bb-cc56fcc2ffa4@linaro.org>
Date: Fri, 3 Oct 2025 14:47:49 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: soc: qcom,aoss-qmp: Document the
 Kaanapali AOSS channel
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>,
 Das Srinagesh <quic_gurus@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
 tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
 yijie.yang@oss.qualcomm.com
References: <20250924-knp-soc-binding-v1-0-93a072e174f9@oss.qualcomm.com>
 <20250924-knp-soc-binding-v1-2-93a072e174f9@oss.qualcomm.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250924-knp-soc-binding-v1-2-93a072e174f9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/25 02:31, Jingyi Wang wrote:
> Document the Always-On Subsystem side channel on the Qualcomm Kaanapali
> platform for communication with client found on the SoC such as
> remoteprocs.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>

