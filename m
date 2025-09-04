Return-Path: <linux-kernel+bounces-800291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF159B435DB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 572327ACB8A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72672C2353;
	Thu,  4 Sep 2025 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PFwaZDlx"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A0A21D5B3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974949; cv=none; b=uHBwPDh+c4Vio7zO4qGhz3HOlPxnO0cQF+07KmIHDv4hR9rcDX+KFUqyYooKOeRzszuXH6vhoBYIlqj8r2slOkf9C0Zg3LTgMZqDDagz0+qHNors151mK01zwbsOt+bPOEK3VNHBwsOy8jcvW1QrWJ0oslbQ6LnBy/v80SVakms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974949; c=relaxed/simple;
	bh=h5RvIxe8l9bzN8R6dikvAkNskzPyZRDzMQGJ9HnLDwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9BV6dhEO1hGuJoFsgHq75rJh0/ddWEwhBK8cfiLm3T+kEPiN9RahDXZwPVE8+xi1Sj59uNsOlW0IiA5h5r458Dt+JkFrQhjm97KbQFoOO7CEzbw5DMjSZOnFJSlZsmgTycgy55YyPhtPMSZHhm0Y/sniq6pA1RLY7ZZWlJLG6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PFwaZDlx; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3d3f46e231fso695842f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 01:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756974946; x=1757579746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fvYi+R5i77yXA26UvQlFEfyxfCLO5Nh7bbNkyAiJE6Y=;
        b=PFwaZDlxI82RXm/WFSbYT61FqELc0WqAhsSHYkbXFHymbK0ayV+Y6xfqV95Ifjf+5H
         TRLlyVoBAT+AgUNgjPZZMN/W6Zyk2t6VbnvvA1UTlxji1WK5My4knJOnuh3C2qAHOATB
         PWdf6JLUOXkFVrm5SsT2nGw17PyKryicwZO7f2cWmUFtwuvmD5jW1wRoQVEy4oZw45LW
         vOcpD+soWduIkzjhcsAUOTZZuX7v082pTftoiuJ7elDTw0OM+wUCRqg1G7HafedOM4XE
         4Pe1TFx79EZ5J0W1eF2kGw3kypLGc+JV9iil5VTTF4dYdcvyT7ven5mFosiFspVVE7YR
         Sg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756974946; x=1757579746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvYi+R5i77yXA26UvQlFEfyxfCLO5Nh7bbNkyAiJE6Y=;
        b=eWlvaGFQFCx5heY2iFn7lMYGQRksoZW4Z/DVWfH9lo8WHzzjRUIxq8RDNsfMGN6VGc
         dA2WVABtXbcuTrvcPT5hRInlEceF6cVl94qd0idyFfmvZVZjr9uZ5FBu4P3Sg2S0y7Vu
         32MA1uxX1GBG7+5ENws+YXHeua1fqO4iqxgM3s+XQ3DTIFL1Kez+cL8R5auMKKTJFXIm
         n+sDxjuqNWVbMbRjmdShkL6Pnbv40eVR22ZadiFcdgvjE7hoDMCsAia3SqpEElTrHwg4
         sg9xk2fcYCzfJbXcvXwY3RFC46y7KT32AvS1urPzXHaD14RsdVfbpyy+zSYn3XaxCLS4
         4iaw==
X-Forwarded-Encrypted: i=1; AJvYcCV7c/3ZUhfEvlPlINighsCgmqq8KmQmozAbyn/Kn8szDAO9RDywfFFlrDbD9NAlcqi9RUSh8wcFEfm9VXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaRzONAHhoHOl/kDLyNjEUwTGgQskzoWYUPun6s+T+qCWnnirX
	ypc6y+wIHwRJEBOg98gyTki1qUXDIcQgSo1w7gm85fANu7D4NwJ4Jl+/6I5rqQChzig=
X-Gm-Gg: ASbGnctokpdim9y0rFop6G0ef7cFbV13l1QWmrwDGqnNjP5pX73kXD2GiuKrgnLbyAW
	isYEAurOsePBBmWLiIcARwyTu/wFIuxG60Nnbrv5WXzklBpj5NdOrzuW5lTeuZhEapMg21WLZGI
	bR8fj9bkqawtfPF3UwEPq/wNMEpb+GIdQFRlRYBwNXaA92pFpl1DvsYMkyjWKriOeLQhAGsf/x0
	FUXgVby4jKOWiW3x00tNqD6PQeCkIr3HYuBTVTEi5Zc9TZRdQwHJXPZm69GLzwGsUubMqKWqBe/
	n8Wm440mIaI+V3N2hzpCMJNUaNNbbf7fMGhe25hi8pIJyAFeP6mBKJN5E7Jq4Hy9zBuz2QxUcIB
	pLYx+IgUKlpcn5PzM6x/NAX/YiYtop7Js
X-Google-Smtp-Source: AGHT+IH6tluwSmCG7lH+rafRzjnl/FD5MXJunjJ8MX7ouc4VDFS8i7jTuo2LLXbEBzN3/cqZwlGBAA==
X-Received: by 2002:a5d:5887:0:b0:3db:f9f7:df86 with SMTP id ffacd0b85a97d-3dbf9f7e8d7mr4806530f8f.61.1756974945927;
        Thu, 04 Sep 2025 01:35:45 -0700 (PDT)
Received: from linaro.org ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e68c83asm297479605e9.20.2025.09.04.01.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 01:35:44 -0700 (PDT)
Date: Thu, 4 Sep 2025 11:35:42 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Johan Hovold <johan@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: qcom-edp: Add missing clock for
 X Elite
Message-ID: <nmennvrestyn6pf54wb7bwvblrtwdczqeokjdd7srj5eljyyfv@gqobw5rexdy6>
References: <20250903-phy-qcom-edp-add-missing-refclk-v2-0-d88c1b0cdc1b@linaro.org>
 <20250903-phy-qcom-edp-add-missing-refclk-v2-1-d88c1b0cdc1b@linaro.org>
 <04437373-c5a2-43e4-b591-921ce450f3d8@linaro.org>
 <49a1ed5b-2afd-46b5-b5b1-74dd82dae95b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49a1ed5b-2afd-46b5-b5b1-74dd82dae95b@linaro.org>

On 25-09-04 08:51:49, Krzysztof Kozlowski wrote:
> On 04/09/2025 08:50, Krzysztof Kozlowski wrote:
> >> +allOf:
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          enum:
> >> +            - qcom,x1e80100-dp-phy
> >> +    then:
> >> +      properties:
> >> +        clocks:
> >> +          minItems: 3
> > 
> > That's an ABI break, so you need to explain it and mention the impact.
> > Reason that there is one more clock, but everything was working fine, is
> > not usually enough.
> Heh, I already asked for that at v1 and nothing improved.

I missed that comment. Sorry about that.

Will address in v3.

Thanks for reviewing.

