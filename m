Return-Path: <linux-kernel+bounces-861670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA80BF34E8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B85E4E42AC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F0233342C;
	Mon, 20 Oct 2025 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WkeJBh/G"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6081C332EA3
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990352; cv=none; b=fossS5r9xXcyyuHCLrPpFcZLMeB4JK1WtAabO6NxOKP6IH2Tl3xdNG9GvYwNzr72bodJT55EV8hIjxjHMOTDfdcVhzC+OylvMDWnnndxZOQ1sozsBZFpXMhrkBY+MkJt1fFblf3yoROzXit4vHaiyH7ZR5A0d7vZ//SAUUpzqB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990352; c=relaxed/simple;
	bh=RGfpAN5rzMHTTLTFD3Loxuaxwb3861xuxa5WQkx+zXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fj6pVXIHMOXifpWayngl02kmNRWPL+ZcbvLKhNPQ5S3f1QeZg9IgT9NU7dTluEEJVLXkwW1V69PoalWGJygzgPbqlOLgBoLjDymaKbMLt8hHY6jU7iji2l+AnISCWs0Uu64KFpUtcI6xg1PJoHNil7/FUks9kub87zQGB9mU52g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WkeJBh/G; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-471b80b994bso28354125e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760990349; x=1761595149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RGfpAN5rzMHTTLTFD3Loxuaxwb3861xuxa5WQkx+zXw=;
        b=WkeJBh/GhWNSApkJsZAVMbPiFNLpdO876HgkWJdzb9VP2jbuW1zwgZglrrkN6KYALG
         BCtVRlA5lRrBgZg+Rtw0CxE8iy0/x/spNUHaOkXaueLrK4wBDNG0l0LRP6BiSHOl+W9Q
         1Zq5SzvKF6E9GI+zsojA72FKsiOjlLF77Me90JIkujGAZVkuxGB2MgVKdXtppKQJa34M
         LqprURPuLU3hhqGO3LXlQHYyLX1DvUZMOp8/A5FLRgunTmc816GkVlHXjm/jnTAUVsox
         2mAHrqOXwcyiaFc036goSvI/yg4benKqGINRMrrv2IxbM6xM5kkRudprrL/G5fKQycDq
         7jPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760990349; x=1761595149;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RGfpAN5rzMHTTLTFD3Loxuaxwb3861xuxa5WQkx+zXw=;
        b=ZVlVXJUFMLN/7GzrqzEpXujUQli/6FTG62Xvx4A3GOdfST7lrukj9Y3YL5iwVj8V1T
         WtP08JtduY9YU2slDJf8h28VpdspCVBftavJwwEZL7kDRqptKSfuz4Rlo2xezWEKbpZz
         PUg6z/TLbQJnIbf0oNZHZNsQPZG+PZeeTQs64iXWDCt+zfveAWw+C39chB2YxG3w4gnB
         Ui1LqoXKUIanPbBp3dgU7ro+IBfmHSBWyi/ROUb4KGNm8uPg9We1BkEEdWWZUgS+LdNE
         +1MNlXM5PDMN5fL5Z3RLSn3H8yjJRlyoI4yRxrmZLhSeGMRsMHgiHr7KkFwHzsly5fWk
         9HGA==
X-Gm-Message-State: AOJu0Yw2rsOxL2uRVEHQrxex04Co536g7sKBUyivMkYbRNmr/PT1Clws
	zwl6DroiOLpn+/KEO4nqqPLh865LOkrSX09/locA76o4Fp8olEtk+rvK4MVMfO9mxrU=
X-Gm-Gg: ASbGncthfs6Q9P1qaKOtu+NnSJjk013KC4jWspJo6TvL1rGzVKn3G4xjW7fZ00lgdGh
	ppiLGniHVPrZrlJrePqxHNbRK4rEfMYwg/0eJgM933wDnZsijfVPE+f68nQO9tEM2aeRUpPP637
	hmB5bQGjpyWc09YJGHAtyjRJmn3/A++4WGPLGZOewT4obamOD6IO1JOFffO31GWwDWAkQQhf8Vh
	c3FD8ojUh5pC3uR5hK8bmyUnL7ge6vg3DnTfPKCU3Y902lajPFdykrVABRlNvy//047sSuFIWJ9
	Crc9Vsg0wpO6Q0wt7DKGzWxPmNbTyGnNX4YtFu1QrtgAQpEqGBqFmOsrMXeZuZA2eFPIHr1kxLM
	zUoI7f5eeWjNa8k23v9RZq3oR0jKJJ5RB/lUpp71iqLneXgns0cO19aongKaJupx28flMGqnCcB
	M17vO64YCqV4Iay/Py9mT7Q1SeVmXBIEKz+NErxkBtU/Zl/byG66HPrQ==
X-Google-Smtp-Source: AGHT+IGvccbSI11XJaSMgNlpFHKrVHSLfRMXa/L8Zy3VVZh4FfZmD5f/hOBseLwrd7XiHIRl8wNufg==
X-Received: by 2002:a05:600c:5298:b0:46e:432f:32ab with SMTP id 5b1f17b1804b1-4711791d1e3mr108234665e9.33.1760990348602;
        Mon, 20 Oct 2025 12:59:08 -0700 (PDT)
Received: from [192.168.0.163] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c900asm247164875e9.16.2025.10.20.12.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:59:08 -0700 (PDT)
Message-ID: <c1fae486-ee56-41bf-b3e9-e2e2a9338d1f@linaro.org>
Date: Mon, 20 Oct 2025 20:59:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] media: qcom: camss: Add common TPG support
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20251017-camss_tpg-v5-0-cafe3ad42163@oss.qualcomm.com>
 <20251017-camss_tpg-v5-1-cafe3ad42163@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017-camss_tpg-v5-1-cafe3ad42163@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/10/2025 06:06, Wenmeng Liu wrote:
> + * Rreturn 0 on success

You might as well zap this too since you're v6ing.

---
bod

