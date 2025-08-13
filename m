Return-Path: <linux-kernel+bounces-766628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4418BB24933
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D81A687814
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6BB2FF14E;
	Wed, 13 Aug 2025 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7xDDgWO"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070DF27602D;
	Wed, 13 Aug 2025 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086969; cv=none; b=a2dQPEYfTiWcvqRXL0Hm/+tjoYkTU1xac9a+yM1L392BiuVWL9k4LImzcsddhJvooD7b1GS/Tc/AV8fGpm9ayszMXSfDnzbVR3z33QVuOu9UIPalE5IVbJDAThVivdWS++VFqEN3KUK4wxAooV4PxQhVqvTvLCg+VxQymubju+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086969; c=relaxed/simple;
	bh=H8g91jdJ2I5Pf8/gXHixSVo5JI5EuDOSta97uJaRL8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DX4ya0udcIYKw+hWvDH7Go/OCc5TK+7VlnsgoKntWsGbMn2WvSmN7jAsaTbQY2GCQLHvBOwDNRsq1zxR64cCvPbk+HOFfpBj5oXt9vERr6zMXp9TDVZLtcLqtABiMM5vSQBSeGj95o2mAMh0QkrRFTENHRJ4ZkrAOgaWDGaM+/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7xDDgWO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2430926b53eso8910275ad.0;
        Wed, 13 Aug 2025 05:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755086967; x=1755691767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O1ynA9yNCLb/DJJBcL2J9BbHmd/+2r7TiLGTA87x+sQ=;
        b=g7xDDgWOC08vzuhDYY5bW4v88RPzwBe/jbcdT4HGsBnRbjmLHrODOe/Ytohr5r46L3
         wM3BvctpxcQngdNIR6pUaMQj0r2+tUPUptPolt+0X77szDb76gR/nMWAxYXDTuIAUEZ9
         WhWbS2rThf/VsR0Z7Wb6XSvD78CeCf0xI5NpvGNAmJHp4vW20CIUZEFhN87FXOShG3ew
         fMOSyzU9JGpPKF+HXhl+68CgrTtblNyXEstS5KHe3D6Bqony/rHoDEYTWGjScyEmn/6X
         xXhAUT96nlHKvLWnfpoKQwDtK7QZI8kCT0b7Q8Vd6wpRwAtdgysRdCd+wgmosALhbn/S
         ghsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755086967; x=1755691767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1ynA9yNCLb/DJJBcL2J9BbHmd/+2r7TiLGTA87x+sQ=;
        b=YUu+ObAEbFFqFHpwKt4dwpzvk9WCW0cNpKaxXKcpKKZ4VZZc7NroFVjniqm+edoVqU
         ngyH23/bArD8g3dT3ekcW/U3GqPYrpeMUegxOUTxGbg4hBlvcVgWGfijl4EyjUUP36BN
         LprpO5HO4P0uQPH97Nq17eRwViMk43tR3rQ6TK1/CGe02DUscN6aI7WgVQvpwDufzAyT
         A1n2vhwe0TJWTaqvOmVhZXf6GUBmDpzjMqXB+MoODznTK0jqFuJfDrvTn+HIQkDWX3Ae
         DM2DxnmBWXliWKF4pMnH2/Cnj0RhAa1wZ5S4bnhSXreu5PV0vk8SIpRjvKK+5GaAFsU4
         MUhA==
X-Forwarded-Encrypted: i=1; AJvYcCV534CNsJ9AiZmRbf38nJkCr/CKDoClfvoCjJiXNO3MwTLWntvOTcCqWMTazYTg7peXTB5NvEaW1TSfURzy@vger.kernel.org, AJvYcCVoI6kCo1nor1SXAgG1gg/retkntINIb85tswUoOIrVBvirac+a69lXfPTW0AJXkWENm3Vj2lcxtEmURHIsBBbZlzkeTg==@vger.kernel.org, AJvYcCXunf+8MBY5lfe1ze1ZtFsRQoF/1HEhczSjSEcyGqCk46HlGJqFY4tJ/UxOLdOVIZ4iy/9wwKboWKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpZv4S3RpMxpTeT5/GotMirbKG1ljsk/U3dWLMS4jBziJT5l+n
	FrgTZQOOFq5LDTkZGdZPlV7bvoYiewhf6NC1/Ai8O1csW5OGfVCNv1vR
X-Gm-Gg: ASbGnctPEEA+uUNhq4rRWEIhko7TZ4Ue7kFojS5dFfBR82Ptd7Fasrlsb1MtOz4+fhf
	jxtznTvNb2CHjyXKbvRFiaUB/p04yB64D/C66sxed/YYw887E3fY9oHPTCHEbvmEWVvXVYkL3VZ
	IHb7gElUKTtgSAZeSddlMO92viHr55169mvkyw5xLCAKG0tXtSAuCs/fU/RwCAS/5NnSLYJkUgK
	D13gf0FLvMRgCmbTMRnfFaAz7dpvjXZAVPYUiGMpEwYaFaPjVAPBtWPste5VlyLf65z9E5zmAcB
	KPiJszTItAD89HCrgD5i/EHAxD6aLYry25PSylxDVGhyq+adxxdozkiLPKSGNss1iLUJjRiAR+h
	lrobnX9hEOa0v/G/xK7i7kGFnSJ2t14E=
X-Google-Smtp-Source: AGHT+IEKxlh5V2GF8tDsf9jD1Ub2AHyeBNd/wpCv29SX9TggXc56K8tKdTw7IPvGqUw42iV6V+rong==
X-Received: by 2002:a17:903:1ac4:b0:23d:fa9a:80ac with SMTP id d9443c01a7336-2430d142278mr41905825ad.16.1755086967165;
        Wed, 13 Aug 2025 05:09:27 -0700 (PDT)
Received: from [192.168.7.13] ([103.182.158.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8977896sm324251535ad.79.2025.08.13.05.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 05:09:26 -0700 (PDT)
Message-ID: <dcbd352d-2474-4d83-b7b4-1dce2932c9f2@gmail.com>
Date: Wed, 13 Aug 2025 17:39:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] docs: alienware-wmi: fixed spelling mistake in
 admin guide
To: Kurt Borja <kuurtb@gmail.com>, linux-doc@vger.kernel.org
Cc: skhan@linuxfoundation.org, corbet@lwn.net,
 linux-kernel-mentees@lists.linuxfoundation.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, hansg@kernel.org
References: <20250812201523.69221-1-sohammetha01@gmail.com>
 <20250812204952.73136-1-sohammetha01@gmail.com>
 <20250812204952.73136-3-sohammetha01@gmail.com>
 <DC0RIMIRP717.345GQONQFW4HI@gmail.com>
 <dea5d89e-d918-4d80-a205-38ca7c166cc3@gmail.com>
 <DC10RH2NVBR9.3QC7LKK4O4CW1@gmail.com>
Content-Language: en-US
From: Soham Metha <sohammetha01@gmail.com>
In-Reply-To: <DC10RH2NVBR9.3QC7LKK4O4CW1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

found/fixed the following typo

- aproximate -> approximate

in `Documentation/admin-guide/laptops/alienware-wmi.rst`

Signed-off-by: Soham Metha <sohammetha01@gmail.com>
Reviewed-by: Kurt Borja <kuurtb@gmail.com>
---

> You are missing mailing lists:
> 
>   - platform-driver-x86@vger.kernel.org
>   - linux-kernel@vger.kernel.org
> 
> And platform-drivers-x86 subsystem maintainers:
> 
>   - Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>   - Hans de Goede <hansg@kernel.org>
> 

Thanks for the clarification. I have added the missing mailing lists 
and subsystem maintainers as suggested.

---

 Documentation/admin-guide/laptops/alienware-wmi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/laptops/alienware-wmi.rst b/Documentation/admin-guide/laptops/alienware-wmi.rst
index 27a32a8057da..e532c60db8e2 100644
--- a/Documentation/admin-guide/laptops/alienware-wmi.rst
+++ b/Documentation/admin-guide/laptops/alienware-wmi.rst
@@ -105,7 +105,7 @@ information.
 
 Manual fan control on the other hand, is not exposed directly by the AWCC
 interface. Instead it let's us control a fan `boost` value. This `boost` value
-has the following aproximate behavior over the fan pwm:
+has the following approximate behavior over the fan pwm:

