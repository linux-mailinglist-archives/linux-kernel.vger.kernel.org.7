Return-Path: <linux-kernel+bounces-764312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6E9B22179
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655E856174F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624782EACEF;
	Tue, 12 Aug 2025 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y4y4QsB5"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DAD2E973E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987508; cv=none; b=R3SeC7886QUIAUcastosahKi0XM7HlVE4o+KtMAfMF7XqTcpjFxphFA/rIuzFru46vloDPnFJyrO46i1YzBuZJUvnwEbASvN+M/uiWrO267JZeCnD6i9LZmgum9BMeRxKUitA7GKeqt6hRwE0+GkNcSzqnWWJT8GWnWX1ITHwaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987508; c=relaxed/simple;
	bh=slLKXhShwaoegY6TdX/J8DEGKFe1IVURbut227M7bEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqLGX6r7/HrMHCjwqeGGVFemKYbgXlOeVnMrC2/dm9Eg+tMi0q9fgKUm9iFkKMhFe4yVyEL0gm1Cfj74D8d+/rUcMyVqWFanzc4jph6Wr0bohyz1gYW5iMAqw6SJ4CK93XDAEItFotnK9IZRehyWdkjCS9IQT0zWf/TZaGoI1co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y4y4QsB5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b78294a233so4465235f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754987505; x=1755592305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=slLKXhShwaoegY6TdX/J8DEGKFe1IVURbut227M7bEM=;
        b=y4y4QsB5nrZI9y9Tj9GKcx6LxapUSF6mtGYNrMBTwD1u8iz+Yzvi3g5JlVRuTmzi82
         BAiw2KLQ0IoqeqWZIqtd8RLGWKPPC7hgSSEdCV55Sfc0BGKVj5gZ1NiWgR3ua3tABGNM
         LQjv/ghDKTIg+TR/+bM9ErFgffx39sZavCBKQNo8pt71eHef+zhxkHQQfiRlolbFI7Qy
         5mzBeVPnOGLc1Gpxc67ILI/1w5NxywcZfBsnhXec23aUJwGFifALzqIOm7jxamSZRiI2
         aV5dYblO6CZJwdk3yassX7D070d3dRnma6K9oJhj/VpCPiIv2CHiRXh1adBVIoqu/xxS
         YnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987505; x=1755592305;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slLKXhShwaoegY6TdX/J8DEGKFe1IVURbut227M7bEM=;
        b=ZDfdNx856nqI8pRUwvpsjpn82GsT/4T+aV98fhsBrKvl2Uc0mbavQ15m0iCV6sVYpM
         30yJ0KM+9YsgiJDfIOYIdmVUI9RhLct8w5r4bojRi4ZOHV6v6JritIYH8jLDBdu0IT7m
         z4u+hDzdYEbzx0rSfHp21GNMKS8x8CXOY8ItDvOd0lobLdfEYY+H/BSLzwlF05CJEKws
         +sSw373bnUfwrU2dqhj9IMS3Wy0qaIixnRwfWc0117v8WD0sQ9OXS5ZZyKeQ4EUDP2PV
         rKRIpGyQA8uzGGrDCiYBu8SBPeD4BdbRzv3HZ0xm77Z8IvrGnAsyFcNubLPHBoMrkiOp
         RzKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGyRtQANCAhFfMza2IQ6jcOfN9k/RPaiCAo9WuXYMVG0DIEd1e0XjPXlnbU/yELb+1fscIMwNdfizJBbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU66vbtMH4qCUiSQMxaJ/xDMjfdq5y0EERTGc6TP9jBGK28Nup
	DHEr/prKe3zW4skMPp830OdoCMV3+xZ9vm4gjmxCpTZre3zsNdfeBiCGfWTYuwUWTvU=
X-Gm-Gg: ASbGncsGgGWNFgCRAPMR/IDdtuLIL/oAj4NzCjzypG9h7zOwulqGFsLYwLYhUZWCuij
	jeAkedzVF37mu8o75eIPsfN+FTZ0DdfTRBLBHpaMXTs2rKxuzTr5zippLDmG9EiuF/RHce9TGXS
	+Zic+S49YTFJ7X0h4AEFffigwtijxKQk+UdZw2rmfudugxhGrDY4FubcxorssLLFUxpBbuZvdUA
	fmfAbzPhy1UosbpYXjFB/eUTaqHgfjQHQ1CZu4bF20Z14fvPG3H+Gmi3mKjkgN42XfgLmpvECHU
	voyBrKzzLTjoYPN7ID1haiZQLk/gVDs+sieFQeYczUta8AJAjBMrcIKmZTK2hmO2u//sMmFZ93A
	OCp2pktkXs13sALCUjB++1zTKrl6QSjAP2oNj+gqqMqqRJesNzmGeWlHCOcCLKDk=
X-Google-Smtp-Source: AGHT+IFMw+iTV+QMC0cuxjbQBkHB9KhyVa7XRqwJWlGrnD3KQrEZcA7ARWyEQ3rSA7aWGX8TuVLODg==
X-Received: by 2002:a05:6000:2910:b0:3b7:8f50:f469 with SMTP id ffacd0b85a97d-3b910fccbe2mr2098963f8f.1.1754987505100;
        Tue, 12 Aug 2025 01:31:45 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c469582sm42510081f8f.52.2025.08.12.01.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 01:31:44 -0700 (PDT)
Message-ID: <be74efeb-9da4-4d57-975e-211d390ccc1f@linaro.org>
Date: Tue, 12 Aug 2025 09:31:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: iris: MAINTAINERS: Document actual maintainership
 by Bryan O'Donoghue
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hans Verkuil <hverkuil@xs4all.nl>
References: <20250714151609.354267-2-krzysztof.kozlowski@linaro.org>
 <8772c48f-348b-8a68-2099-562a29b9dd8d@quicinc.com>
 <b83cc20b-44d2-4635-a540-7a9c0d36cdb5@linaro.org>
 <a4dfc82b-79df-3e3c-0964-a99db222c6e6@quicinc.com>
 <4f79424f-0005-4978-8c6d-6b726ee7e4ab@linaro.org>
 <c70fd6c6-1a65-41ee-b0e1-f6c792867009@linaro.org>
 <2b5ececb-fbf7-4901-8efb-03744f740836@linaro.org>
 <9c83e4d5-7192-4e02-baba-381bece513c2@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <9c83e4d5-7192-4e02-baba-381bece513c2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/08/2025 09:26, Krzysztof Kozlowski wrote:
>> I'll add that entry and leave the Iris/Venus entries as-is.
> Any progress on this? We agreed you will be sending that, but I think it
> did not happen, so maybe you want me to send it?

Ah I forgot to send this, its in my local tree.

One sec..

---
bod

