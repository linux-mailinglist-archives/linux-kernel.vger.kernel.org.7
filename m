Return-Path: <linux-kernel+bounces-812782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 375EBB53CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623D11885171
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8390C2DC76E;
	Thu, 11 Sep 2025 19:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RB5206Y/"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AE12DC78C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620452; cv=none; b=I+3euj5iBK1WrnN+wwk3w6wAIVOhdKVKbG34EMw+O5JDb48CiyVrucSvFjAyNT/zxKNP7cG6rkN3sEUrNktM8LBmmDbglZihviqEeIj9XkT8T+sOmtIeRjxETKIgJoVgVgKKQTYgs0RfzThdWsBIlIc1CkAM9uVx8OyTrJdZfoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620452; c=relaxed/simple;
	bh=C9oaw89htYCAQlCZ0NUg8UBboUF6FXp/isTMZl9ZBuw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=enaN7P5kXJ5WQ6pTRO+iHCyqk1zXADd+SBK1IhodJZwYBPQMn1Z1TgyNUx6sz16gZasgYrXy1TV0ARjcbJrir4to2uOh89N5uj+kJ3XZtQhOGBN0xS+EwoHNo7QD3zFUGmJxXkJXSJQmyhkEHj4xiFtM/iJyj40sOmFLhcOVkLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RB5206Y/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3dce6eed889so1077245f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757620449; x=1758225249; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oKeretZYtiau/KKPwp/maBA1dGY4AYzbQAj9U/iXV8=;
        b=RB5206Y/EesUxt2FaFBQj0OAWbh4Ulpjzv+ZYwAB9NSw2u5axQIQvukRec7b5vBiUG
         RagaM2phxZFv5+SSqOA/tAzYkwW5Um1DUY8EH3QxMPEEM5KD0jQ6RWaGa1T2NpKCm9tv
         fefYAFeqm1VLujdmFM079ptymHiQBSxSxf2uZpqiTAqEua/5xv/K7E0pnmSuGj9Vi5wJ
         d9F4SQMQVo8Gv0Sq+iuE/NHmXzja/OsSG2nF/cZr5Q5vXokWqHCObYlFk+LihwEviQpo
         anxyeESy5AU2CWpsljso2kUXAEQe/el3inctnqmKEvDq1zxE8MHh2FwAKmY8/MXiGbVH
         WFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757620449; x=1758225249;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4oKeretZYtiau/KKPwp/maBA1dGY4AYzbQAj9U/iXV8=;
        b=fv4ihhUPZHxgOGldy4RK0uvx1Shc4HSP+hSlJIth+H8OsetxYh+ZqpOeR8K13jg1CY
         svx/rP2KAXq/49CZtfxbRmc+xVJg8YdO1NO/HsmzIS48QaSzcBNW93iaymL9aF8zrTUX
         FOZkDnkEfHbjAMByab/opBbkqPqxusSOtzyltaKKfx9T6Zt74Zrmvw5UIFms/O+TRDrT
         JEymu1eIIqQzvkKh3mrWv+izmrxermWoEmdsoX/7asRzOz2IlIx+FwbZpIdk6VJljcJ0
         rUUREM7E3HrwbUpROfnmOi1LFY1y4vNnNkEal0MnDB/pbZs0AZOs/XnnQkuZ31xMU1SA
         +H6w==
X-Forwarded-Encrypted: i=1; AJvYcCWLs7OiZxBXwtsEHZCK3fbU8TWLn6JtLmKFeAMG1iD/Wid+zmCy0PPWdj3mAa2exWmdKXOqlaV1ewT3HkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY2on15AKtvn5LTsH1Dn+deMczTyG5YUclJ3DxK0J74ltcZyj7
	J4w+4Q9N4JxaTfQ9gvDvjbHQKeLnfPPV9IMaGmzgSehikBC1mHLse9fiyHou5OukRSU=
X-Gm-Gg: ASbGncsVSFKrC/IQh89t67Fz4kzSH78XXFwr1M8z5FanoHbRuQ5S4mKCf2Pb/IOsvnp
	Ujbq88ygJRNSSQw8vFUxGHzKI963GzhgWWqO/cudkvU4FBJZS6XHxotMMGnxl00UpIrtfHeXnXt
	tdgWIdMKIkuyk1AmfzJzm7L6j1UxxJCd9EOleMYhnDALsvHavUj7HGqcchsjW3VqQQdUykR//n6
	2+pLUD4VXEdx7SDwNFUyYXSuaGAJclv2pohbzo3RWaSlDRaX8nRQkZeFl2ZtXRHuVisrrscNLi4
	X6yjDEubpsIhsuORUykrXV+CgWWgqUug3Px4llpeFx2jN8rGP2es5l2JfleLa07kIhCSDZvfR3t
	JKlQy1DxNxXWOE83O1f4lUBPIzsQos2ydvLc=
X-Google-Smtp-Source: AGHT+IGTnQxibZ37xyPnj8SePmvouWMa7nELymuXsr6TBZk9JPUb3PXeIrdR9ULXwb4CIWEV0IoOAw==
X-Received: by 2002:a05:6000:2f87:b0:3e7:47c7:9b3 with SMTP id ffacd0b85a97d-3e76579214dmr541452f8f.14.1757620449495;
        Thu, 11 Sep 2025 12:54:09 -0700 (PDT)
Received: from localhost ([2.223.125.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd424sm3498794f8f.36.2025.09.11.12.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Sep 2025 20:54:08 +0100
Message-Id: <DCQ8G73ISXHC.3V03MOGB6NDZE@linaro.org>
Cc: "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Dikshita Agarwal"
 <dikshita.agarwal@oss.qualcomm.com>, "Vikash Garodia"
 <vikash.garodia@oss.qualcomm.com>, "Bryan O'Donoghue"
 <bryan.odonoghue@linaro.org>, "Neil Armstrong" <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/4] arm64: dts: qcom: x1e80100: Add IRIS video codec
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Stephan Gerhold" <stephan.gerhold@linaro.org>
X-Mailer: aerc 0.20.1
References: <20250911-x1e-iris-dt-v1-0-63caf0fd202c@linaro.org>
 <20250911-x1e-iris-dt-v1-1-63caf0fd202c@linaro.org>
In-Reply-To: <20250911-x1e-iris-dt-v1-1-63caf0fd202c@linaro.org>

On Thu Sep 11, 2025 at 7:38 PM BST, Stephan Gerhold wrote:
> Add the IRIS video codec to accelerate video decoding/encoding. Copied
> mostly from sm8550.dtsi, only the opp-table is slightly different for X1E=
.
> For opp-240000000, we need to vote for a higher OPP on one of the power
> domains, because the voltage requirements for the PLL and the derived
> clocks differ (sm8550.dtsi has the same).
>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 87 ++++++++++++++++++++++++++++=
++++++
>  1 file changed, 87 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts=
/qcom/x1e80100.dtsi
> index ba602eddfb54616ad38205570bc56a1f0e62c023..d6914165d055cd0c0e8054126=
7e2671c7432799e 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi


[..]

> +
> +			/*
> +			 * IRIS firmware is signed by vendors, only
> +			 * enable in boards where the proper signed firmware
> +			 * is available.
> +			 */

"enable on boards" please.

[..]

BR,
Alexey

