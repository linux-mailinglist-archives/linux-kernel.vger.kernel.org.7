Return-Path: <linux-kernel+bounces-849821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBC1BD0FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 02:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB6674E76AD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 00:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77E41C8631;
	Mon, 13 Oct 2025 00:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b+QRD+Eb"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0401199935
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 00:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760315164; cv=none; b=Zga5UofakC0TFscureECOsqmF4uX2ED85TPnNG5f8kYxN8jX9FPbwyWORmZu+buIJzHHam5KdvFI2c/dMlfvp3DFNt04HSsY8+X+FxVRfZmmHJQlLI6CszfmavbacUDp79bmIgTrRq2A4DVXwa9C+Urgdz6zYFjb6nc4LtTzX1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760315164; c=relaxed/simple;
	bh=yTHGa3VhxPtU4MdOYplB9XQjuEwqZ7zeosg38lw/Lsw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ph6f124MbSI8Agaoogt2NNFWzlgnPxsIhL6vJGwRvNI2pMbn9cBph3oB6ZrEcZ0TRIHka/Ie8/x9dXwo0hMWQ9m904RvYRLPLeKdWRoF2r2z+rcQDju9toIuyb2Rm77QIsTp+mWeuR6b32AieiiaIBczswIyoyclSfO1eu/xxaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b+QRD+Eb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eda3a38ceso8630635ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 17:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760315162; x=1760919962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBN2M9cMiE7Nv+ckCsZbOUgyHJWNUYkdtLKpVQjtD08=;
        b=b+QRD+EbM1H25Euku2dTdoM8J7+VeYBtOrh/D1hMwaDuRv2LDuwYnYVXAwqDW/WUck
         CgjFWN4WF19N4HbbDhwoo3LOXSk6mlSDkbOrGC+F0H4WFYil4JSW6TpCF9hunZ7S6LmP
         2w7vL82PKoPSZKYkUr6c0S43u+k3VVp62YIHqTzuRs70FRSBKakUsF+DdDKIV2Oe/1IW
         rwpa8xga4WF1qteQHag72CPeTWWn8Uk5tCGdMJl5ecJGzmG2YGuk99jSjlzVeF2htO9A
         EfVuEztVc733T9XhQCD209h3vpi5ZuhKuhiV1rohgpMpbGETpdRyNr2qzIq5xTmk/YL8
         rp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760315162; x=1760919962;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBN2M9cMiE7Nv+ckCsZbOUgyHJWNUYkdtLKpVQjtD08=;
        b=Q41fjsMKgndQ+RjgXwspCUMKlyuZnJKhFBE47hsDW33u3xC6aABBbca6hrnn7v8vEu
         lh28Sl5e7ohHd6/ga4fDSS5wcxwh5SgLLimL2ZDreehi6HUOjPw6IwJEHnrvl+Q8Rjp7
         fhI31Nzpum6NoUGg2kFa0B69x2vNNtI6nPyqg8Cta1Er4EbPtsNNjjW6Q8OYFDTOhDhI
         b7QOcfdb8+WEHd+r5Bvbv/VIQc61S8u3qxjbfX/gxuX10fou33vUutau5yVOuC15qmK/
         SNJo026vZWJQHyZeFqTi9cmKS2+lns7p8VJYW4yzWIqWReUpolJ6OqOYzhghCOGRICGd
         kCuw==
X-Forwarded-Encrypted: i=1; AJvYcCXm7fdKSQmmfX/jQ+okGWMZ+L+DE23gR3vmSVw7dBJewRQCimAr/Dg+RZkb/bwqk6HnhJKTS53Dk1tBnoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA71vc5e8TTbwgEqS0YBL5MS2DNMEP6l3VI5iO0pCaA7usSU/i
	eom4oE8WKHXAGZuiMR8CZBfUcY8rq/EKyklmlS4nt6avtCWfZBOkcn/uwFA+uTQ5EiU=
X-Gm-Gg: ASbGncveu1AZJkSUqIgyEOR8gsEe0FAFglpVHZ9Y8FoNX5mEMsnKKGRWN9ecgwXjgpB
	k/jvdEzMZF+V5Fh8EV6OAiLtqxkhLUrbLAv4Xj9Q/t01Nu/W+sqZSz9XZ0vOpQ/Gd6YTWr3VN0n
	z9ypd3EDj39LdC/i3gGbfURDWWrJGKWNA9KWSmpm08X3Sk261frI/fTbBsLaA/SqSgdfymV919Y
	mvBRloNDx7aDgknhTgO4j/MorLH+eSyu9KlcWh+Xbt97TkD7pIPw640Nv929MKIkjnZs3SAe1AP
	PKjT5u05IvvDxA0WuvkqRVDUsjdcRDdqRbq9BGjevxqcgvZEC6py3uU9VP1lert7F68vgYSHKWL
	wqo1x7rFu1BvS3f776/BnVanleHtSGX0gkynj1KXuUVciwl6Boy4jMPBlO6KLwk4FwDxoqiPlqT
	pVBd65+A==
X-Google-Smtp-Source: AGHT+IEwIgW8gINldWjknWYV8MJ0j1jUN7u37O93AJbcBBhfRalcRq5iqyc2MYvjmSLv9qtnZvLvRw==
X-Received: by 2002:a05:6a20:9383:b0:2df:b68d:f7e with SMTP id adf61e73a8af0-32da8461710mr14706065637.5.1760315162189;
        Sun, 12 Oct 2025 17:26:02 -0700 (PDT)
Received: from [127.0.1.1] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d096740sm9624862b3a.38.2025.10.12.17.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 17:26:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250928-exynos7870-dt-fixes-v1-6-a40e77a73f16@disroot.org>
References: <20250928-exynos7870-dt-fixes-v1-0-a40e77a73f16@disroot.org>
 <20250928-exynos7870-dt-fixes-v1-6-a40e77a73f16@disroot.org>
Subject: Re: (subset) [PATCH 6/7] arm64: dts: exynos7870-j6lte: add
 bus-width to mmc0 node
Message-Id: <176031515743.11660.18346080313426927067.b4-ty@linaro.org>
Date: Mon, 13 Oct 2025 02:25:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 28 Sep 2025 22:13:57 +0530, Kaustabh Chakraborty wrote:
> Add the bus-width property in &mmc0 node. The Exynos DWMMC driver
> assumes bus width to be 8 if not present in devicetree, so at least with
> respect to the Linux kernel, this doesn't introduce any functional
> changes. But other drivers referring to it may not. Either way, without
> the bus-width property the hardware description remains incomplete.
> 
> 
> [...]

Applied, thanks!

[6/7] arm64: dts: exynos7870-j6lte: add bus-width to mmc0 node
      https://git.kernel.org/krzk/linux/c/9e3e37939362ba110c341cae09acaf000c0edb34

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


