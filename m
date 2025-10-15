Return-Path: <linux-kernel+bounces-855233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD83BE0916
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FD24871D4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039F530749E;
	Wed, 15 Oct 2025 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVanscR2"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40C4238178
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558285; cv=none; b=Bm8EJLhxmMvfabPXSIbzyE78pgweEsRP+OvJ/X7OX3Tcke77A4W+q8Hu8REsEq8wB6MMkc0RpItgJi4czk+28e3pQ6It7AvM80yo3kCf7SNEgwQTCwGHemhw22SiOHd4+KNMJhWb9RXrBHZxKoBcYOvnD5IzUK2C86mlK4YibS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558285; c=relaxed/simple;
	bh=iBbCAcZjhrqIgbhQqYVKivZiMNzfmlkCukX9J1hV+qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJueZuLDiRWYGt26ynmWqu2Cpm/SdZ0OIch9xGrPoN9qp1nzZYdsq+GhEnmb+f/e46vEfdjpD6VJeIZC2dLckTqL81+WuWwVzNrIQ7WHplKXVu8SlXjSG6ukMmy8OrdKSWRbUzeAEuzU0oPgvMKJatqeqHVZU0X1Eh1VZdjy5k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WVanscR2; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63963066fb0so14562454a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760558282; x=1761163082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X93ngL5NMyRYdgDq3leVhpEnsjXz8ZNeGovlsQr2X3w=;
        b=WVanscR2qQIOyHYPu7MjcziLqHLtqHtVZkRAkqdOtQmZVZMOzFTBQtRjabYSIwUjJc
         M1QkoE2Vc1K/OaPWiToZiLgGnruyaQbw3TFm/7p665StFQRkWWB2tdHalF8zgSReN03l
         a68FgWhr2sIDEthfjdoab8f8qcI+E40i7Q0iInLeJVd51sYVaScrcVhvekL7kxu3yU0W
         uIdwXN2Irw+QvgYLjFYqKfiYdjdNCFq9kvQgWiMGC2rqU23L6jDVYLG4hQ59OBtatbHY
         /02bJPFe1wmMls8B56Xd01Y80NJPtGOLPc88jihshRvK6PmQ+7nzcDh+ugRq6qPBSAvv
         8Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760558282; x=1761163082;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X93ngL5NMyRYdgDq3leVhpEnsjXz8ZNeGovlsQr2X3w=;
        b=vz5xskPh7k6PjrZDhiDzjLJEH9/u7mtNJ4RbcMjKxhtuhC/AxYfMXsM6XlcBaKI+4Y
         pyVd8F1MbeaSsG/dmdqjAf96DZWj6f5L0LVxHBO/VN354IVpNC1bnV43i1/FbempTQP5
         TRjYS0j/Taj9hRrfc9DwsfMdxRmH2ZZ7WHIeP06WHFDzL2CqEfiquVXLudhtLZ8WPJcc
         fnAfJAWt/2WIndW9wzoiRqRHq59ZOk4dToRcAX6QV3ixX1b0keHii8Yjq5tyrKgcY/fu
         4iQV+YvkUJow3pzhDW166oV+zL89yntMdHS65KTYx+zbVrd4nEG+lNiVvOdXUwJiguan
         YCXw==
X-Forwarded-Encrypted: i=1; AJvYcCVWb6UZ6uVBQDo1r7O/9ehZ6I5dH7AhoapQ9ZJkqYZpNihFsAN7wv2oG07JfnDGE4OBrA0WnZJEp+N+OrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyMRhWX/Eu/MJX1saZuHoLc8K7cKezEb1Jtc1unqDwGUyzIlxK
	lEsWjfKG+eIISCoh8yZWcVSuITqK2AMnYbMXnElBxxiwnNEwPRxMAxpUuHALhv60PGU=
X-Gm-Gg: ASbGncu6vcJgdhIXR2NRBO0wJgDKY9QvF88GKQrIiXOrAtEizUN7DJM7qG8CKNDMIpN
	Sv8p4C71PByIZBcn0W6EdNUwFsb9z1DMYXsOABR8JWQqjnh1YJHWTRddtraGhqkMvwmp5xVzlvC
	LbdDLjm8pn5o+w4EICixO6ou/rVcd9nfmDfgce8zv2QXKC7qgx7tP47xuL+QoRmNumuw7w9Wn1b
	2CxT6Jeq48hugDeH0LfelkClCR/xsXjOjXtoz2tq97wFw4/XogSMCLinAV+bifNHHVDYadi1yTc
	Sz6WKcZj6zSV+v9l4B+5eEUcV3egk3RWJu9DNtQOuHhtbKVQYlwXcYzHKAnrYZeaGqRqLmqQIpj
	cf196vhBz9M41VcKBWenfl4D49eVS27YxxmTfF7wfZtocIgJTrcitzgTO9DIVq4AKaVb+i4kIQg
	MfMc5IPVxdkmb+Tpg1xWDeFA==
X-Google-Smtp-Source: AGHT+IHf2Th1L2XYSlYRjMvRiaQwEPPv0rm4KoRAruPpObpOgoCaczpFuMinqPxSmwcgVKfFpOWD/w==
X-Received: by 2002:a05:6402:23c9:b0:634:c03f:c605 with SMTP id 4fb4d7f45d1cf-639d5c75dbfmr27308818a12.36.1760558282021;
        Wed, 15 Oct 2025 12:58:02 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b71443sm13887338a12.26.2025.10.15.12.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 12:58:01 -0700 (PDT)
Message-ID: <ca8189d0-a518-4716-8b28-e36571cbba5a@linaro.org>
Date: Wed, 15 Oct 2025 20:58:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: qcs8300: Add support for camss
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Vikram Sharma <quic_vikramsa@quicinc.com>, mchehab@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
 cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, quic_svankada@quicinc.com,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20251015130130.2790829-1-quic_vikramsa@quicinc.com>
 <20251015130130.2790829-3-quic_vikramsa@quicinc.com>
 <b4207e22-8d9c-4223-8b28-272d2650661f@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <b4207e22-8d9c-4223-8b28-272d2650661f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/10/2025 19:49, Vladimir Zapolskiy wrote:
>> +            power-domains = <&camcc CAM_CC_TITAN_TOP_GDSC>;
>> +            power-domain-names = "top";
> 
> 'power-domain-names' property is redundant, since there is just one 
> power domain.

Its a required property of the yaml.

---
bod

