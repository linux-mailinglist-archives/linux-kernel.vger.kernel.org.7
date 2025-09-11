Return-Path: <linux-kernel+bounces-811684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9682DB52C87
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6EBA1651B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3771019C546;
	Thu, 11 Sep 2025 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hkqDh4DI"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD12E7187
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581358; cv=none; b=P1zRR1WBd62A3yxgVxTOZkcYw0tyCzUSSqoCZ9hTYTHeZ/r/sYBVvzQMoNiijIdor9U/Pa+v4wbrGMmXFeYYG9bkOtU8KJyb2HY1aFb734PjOgwXlANL/z4rnOZfSFyf6nyGlb93O21sSsiey59WOHVVu83eVnIWW0jKNqVWfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581358; c=relaxed/simple;
	bh=UzTJmRwSuBGTfGbVMCEkyvO+DHGhYaptU6WgQxWrQTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXXrS3v91+xH2vPYffxh14yXC0gwCT7d+a3ZPF+myu9Q13j15LjVi7QKX2wn2l//zom6FIOr+4OPnNQk5C5FYl8kW+U24zNfKurZck8LlmfcFV4lNb1V4r2Hx9NuJZAlNTjNK6BUxNp3g+IAcz8IweCLHweuz5MeY0o2LSZwVeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hkqDh4DI; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3dcce361897so343615f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757581355; x=1758186155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/zaq74E/O3TMzVibuqo9ZKl9wzf7cmcYOC6wFsi2v7Q=;
        b=hkqDh4DISaB7oAIHe4HglXgyLYqEFnawP4hhExdDMqktLmUn5k7fUjy8b0aVhaVPcW
         UYNRJjDTVBPn5lzwxe03Y/cEw17or3OwbQlAyaJOfyGl0Y2OpPLLMqlvqry647pQTNNW
         8jOYGy0e8d6b+J5HjOmcFAtWgyrhmKRhR4xipyolOfDOZ7+w3O+lN+TVTPjpT/d5oSrz
         w/YhXrWxFztXum5Ptgg5nrn01UzRIxs/7xPAiLkzmzoIprMpoP94+4Y4c+6nAcdYaLa+
         6EYhTGzjC3jZVOFdoCzwANKN1aV/WbGnniA15fH8eRAlPPQlu2xiKr6Sjp6Ahnhe4yjo
         Ncqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757581355; x=1758186155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zaq74E/O3TMzVibuqo9ZKl9wzf7cmcYOC6wFsi2v7Q=;
        b=Jisq7M6wbQzm68zLJ0x7mfKfogyLGVpEOxoaKwi1S3ZvbY/Q33tSqmiQJdef/SpWRZ
         1OX99wkwLpdLXChm0TXy5L0PUm5jwpgZrE2J7y40hJCLWJLkIxIy7YO5lQODiZ2GIgZS
         o6sltA31KF5Pf/6mav7xgOk8VkJ/AG6vP0pUCRThtPt/kAoi8FVQ6jJVsX0Ktn1D+Z1S
         fv2Bk8xXE+LQ6CmSVNSH8B20XebDEqfLyp0AJ8u1c516aOhFP59DA7cluGzcSuzLXmDR
         KIL+yfmNVfLQa13KqxBmFgmVB2INWwqdkA25BbNKxr6p2qcNwJErD8mZDFSDOfrKBy/o
         d2Og==
X-Forwarded-Encrypted: i=1; AJvYcCVGuWvtHeNra2CapOLyLgp+5cGXrhJP05nhwLPMB8AGHDgqzGoDocB4ibRfXID8wagoAbkfMmJFMcHzxW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsl1Fuh1D1bOldXCidXJlnxF7C54WaR5wrv3fjsVaewaFlUKuX
	dnxFEPnZmNtRSuv3zm1lYmGfAG0tAaxa/Wll29pZHfcg2LvrUvwZ+dQQvN+SWSE8FFc=
X-Gm-Gg: ASbGncvoMao05JPqSHyWWOOxjMi+UcthjNYbOJxl5PWi3U3YVl3lGbjcgo13fQztugv
	R066+toT2R1zIxJtgzB/d0bd64COC6114wBCvnCspoQTDijGoLNhmw6aYksm0CMHdlzEMJh2crY
	SdFVSEbGZIc8LRH9cL0Z9j8G8k7kwjyaZ8zrpFJctSviTmyfeMzAcczFrD9PFJsOQzlJx+YdoUe
	aH+qH6mphJPouAxQyluwLE2V8rji91V7DdmdE3C/trwhEp9IYDFNF3eunCB3PhDR+PA3tljMEJT
	AbHW9PtXQMrbyCDYwp9dHcZuG401+mM2Hn/n5NQ6gv1TmFfSm5lVXsRXr83SBD1gTicg39rcuW6
	orflSv9r37NBJu3bMr79aP122G1YdWgsWk1Al442dtaQ=
X-Google-Smtp-Source: AGHT+IEpmqZKqS9hAWz+1L1aJGWyXbmn5CbSirxedo3gzH/80b0RJpaQWoe7+bkeQmLZvMcrOVYvMA==
X-Received: by 2002:a05:6000:25ca:b0:3e7:5f26:f1e8 with SMTP id ffacd0b85a97d-3e75f26f670mr1923478f8f.5.1757581355207;
        Thu, 11 Sep 2025 02:02:35 -0700 (PDT)
Received: from linaro.org ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607e13f4sm1606771f8f.57.2025.09.11.02.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 02:02:34 -0700 (PDT)
Date: Thu, 11 Sep 2025 12:02:32 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: Add DP PHY compatible for Glymur
Message-ID: <i7ckqu325thggaw3qms2ofoklh6r5rhthdwkuko2uzbaqnryhg@qrjsc5yh3dnb>
References: <20250909-phy-qcom-edp-add-glymur-support-v2-0-02553381e47d@linaro.org>
 <20250909-phy-qcom-edp-add-glymur-support-v2-1-02553381e47d@linaro.org>
 <20250910-obedient-ambitious-oyster-5efa6e@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-obedient-ambitious-oyster-5efa6e@kuoka>

On 25-09-10 13:32:04, Krzysztof Kozlowski wrote:
> On Tue, Sep 09, 2025 at 01:07:26PM +0300, Abel Vesa wrote:
> > Document the compatible for the Glymur platform.
> 
> And it is not compatible with X1E? Say something useful in the commit
> msg, instead of what we see from the patch contents.
> 

It's definitely not compatible with X1E since there is a new version (v8
compared to v6).

Will update the commit message and mention the new version.

Thanks for reviewing.

