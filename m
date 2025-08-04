Return-Path: <linux-kernel+bounces-755032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA00DB1A056
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E2B17563F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5A81E5B6F;
	Mon,  4 Aug 2025 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dlw3pFsq"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E855235061
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754306025; cv=none; b=jGB+GuPcJU63Mfvwts0eBcZY/MsAnv44PpnyVX7T0t7e8cRmG7GM2FMY0uqsC/uSug9vXvTlTwKtoVaGwtvVGohf4rFQdJtU7btuviBk1JYtu2aaMf7ZJYN37JLpvZ5aAby7FbVSlQaw1MnyjW7gQsj0HwM/IGpCNNjc4HLm00U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754306025; c=relaxed/simple;
	bh=/yT6SIbwMsDyXivBPq/u5jEb7k18emFAPJlUdi6+mro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7jgQDZB0FrZ9ioxukJBK9mSv1xtP44wLVY8lIz0CEcNehFdpEncHiX09C3fthIGDoCqUtK6wuA4do7Rwlj75P2BAAOSVldClyKbQOGIz0BZVZtDKE67mzXwoNuBylIkuL62nF+eq2V8pWk5CRu4T9d23GFakh54Uf4kxNHXbDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dlw3pFsq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76bc55f6612so3604917b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 04:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754306024; x=1754910824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WYxFvBBR753en9vuNva6YOR53xSyO7VCvwj1GDT38Q8=;
        b=dlw3pFsq+p9GpRztCVrhzKP0lJcpdn5txTF0zArhvSwBI1CV4XDYWXofEwTCLcZYg+
         fVtPrkSWcdS02TXPg+Uv7kkqnqWeWwIpHQ+xuc+WBxbwUW7PAtfFt85cbfSsutXrxzS9
         rpceV+yfasP5YpzxuiCBe8Sx7zS0/8FGZc7DpIZ8HfzCiV+ZsKrmQ/ppSQ1KOAeU3qGk
         j7J5hetgKsB/9jBVI2g5ohM22iSIUedveBQkoGcxtgYXRmdT4ABkyaZnr2Ej0g2MRES4
         4qVmNVuqDDTarQElVNS4NtkI/SJokDkeojnnQQeBQFElpH/w0U0Xaz6b0mvEckv/vSgu
         Jp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754306024; x=1754910824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYxFvBBR753en9vuNva6YOR53xSyO7VCvwj1GDT38Q8=;
        b=ocOugEauzW+bn96BzVVpXy0XB8QqToAWPq+jfHfd6CZECo6M6ktsOn0kKz39c+VfoD
         NsQJH7hscVB1WN+pPLFQa/NC+m5aBgX/CjswycjJFOyUfM144pjtNa3mNx1Nkw411213
         2JeuaUGPYEaRN1xRvEdSKvGFk57ItP04L+orxGT2rJyfR9fD15DEHJkbWASPyW/TdBdO
         fS1FZjjbuJuARvF1T1ofJnwryICQ3PmB46CsTvH8vMJBUngH8euHRErrT3jfkVErXA61
         2lg3ywF5Wh3DmM5uPHAwQsyVeeGpaAd9hoz8rFfcB8j4/+Gb7ZmkeyWPD+eq2N9RYKE4
         r6jA==
X-Forwarded-Encrypted: i=1; AJvYcCVn22DSZyoln8CbIclxYa7wZY6FbRLJUVM0yKDelw0O3t2BInbrEOg6UHv5KgqUoYRyqRuHe9S9OPr08n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuY04bmkH27FT0Gz+zCGwvhO+m47MXFwATt/5unZcZjYdOXwm9
	iJcbWSFE4RJ5f9LBOZYjMc+JS7YpnoF91WC1nTqXkpXvv+NYbvusjEwQNZbhBgxPAGE=
X-Gm-Gg: ASbGncuMnCO7hcxlD9R7Tl01NM2QYBgIaZSYIEd23C1z9j4lMg6jaTLA6ki4eYPMAGn
	7e7LrzooFIluO3ltlOeJk+Hd1lCiPxicM12C5Hl9f0ZOmQCcnf6u/A+E0SnLa5eD1MwxlLTWLpN
	WzFar3K8vpkcLre0wIP3nkDWwhCcqwmJ2uCyURVAr0e/0KylShJsvDacbJG4wDyehvpFVCcGsk+
	X7LDGvl8oSJ2T14TAsdkrXMASMJjAitfd2BaZNGy3czY5jjjukcq9DvhZv/TC3Gbx8zMRlYRaUj
	Wo/mkMEx4iCV0rbTaqsHMxe1Zo0hBxEa8FLYNE5Rb5fXcXxPK2Ju14xCLSG4Y0krTC7b2g2Ni0X
	UbFPbzsUjK76JxAWNc9NSk9w=
X-Google-Smtp-Source: AGHT+IE3KOgmXKzWVwIXatZUzP0SpT7zF9MWUThR1kMx49+PPbc0ii9e8sraQgCudSaaczTwkfvsEg==
X-Received: by 2002:a05:6a00:ae15:b0:76b:fdac:d884 with SMTP id d2e1a72fcca58-76bfdacdd96mr5449606b3a.3.1754306023713;
        Mon, 04 Aug 2025 04:13:43 -0700 (PDT)
Received: from localhost ([122.172.83.75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bfc270514sm3545933b3a.12.2025.08.04.04.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 04:13:43 -0700 (PDT)
Date: Mon, 4 Aug 2025 16:43:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] opp: Add bw_factor support to adjust bandwidth
 dynamically
Message-ID: <20250804111340.t62d4y2zg77rr3rp@vireshk-i7>
References: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
 <0dfe9025-de00-4ec2-b6ca-5ef8d9414301@oss.qualcomm.com>
 <20250801072845.ppxka4ry4dtn6j3m@vireshk-i7>
 <7bac637b-9483-4341-91c0-e31d5c2f0ea3@oss.qualcomm.com>
 <20250801085628.7gdqycsggnqxdr67@vireshk-i7>
 <7f1393ab-5ae2-428a-92f8-3c8a5df02058@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f1393ab-5ae2-428a-92f8-3c8a5df02058@oss.qualcomm.com>

On 01-08-25, 15:05, Krishna Chaitanya Chundru wrote:
> Currently we are fetching the OPP based on the frequency and setting
> that OPP using dev_pm_opp_set_opp().
> 
> As you are suggesting to use dev_pm_opp_set_prop_name() here.
> This what I understood
> 
> First set prop name using dev_pm_opp_set_prop_name then
> set opp dev_pm_opp_set_opp()
> 
> if you want to change above one we need to first clear using
> dev_pm_opp_put_prop_name() then again call dev_pm_opp_set_prop_name
> & dev_pm_opp_set_opp()

dev_pm_opp_set_prop_name() should be called only once at boot time and not
again later on. It is there to configure one of the named properties before the
OPP table initializes for a device. Basically it is there to select one of the
available properties for an OPP, like selecting a voltage applicable for an OPP
for a device.

-- 
viresh

