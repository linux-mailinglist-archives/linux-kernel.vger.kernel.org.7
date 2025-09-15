Return-Path: <linux-kernel+bounces-816459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DF5B57410
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD3C2003A3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CDC2F5466;
	Mon, 15 Sep 2025 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eg1VOmR7"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B02F5461
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926969; cv=none; b=nRZg7sWbjkbetohCa4nCkVWLl2GTcGKSwmbfCJdGCPzxXjSpLcLj5l4Q60rPc0tI1+kErh/Fd7vpBb64tP93ZEG7dF1eUxZNV/K3OX9U7Gp5oLq/Pok5XRxHPHTQpJxybhKkNpDHENbo3FZUcFJEKnKl8aj4lbnl9yamiLBkZ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926969; c=relaxed/simple;
	bh=C0YkUmrHajMk+TIUliZWVchR3y+Q8yUcd/+iydBLkn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiQGZ6ZJy0dhCCU6n5b7LUmBn2dMmrNa9Q9JLhP3ciTAAGPDisQQLqY/TOm/WYQ7bW7SrTLYpIKV/JpE8Ioqnqj7A91zZ6MbBejN4vRvKJ6T7fXIiHjZX6VwMwkhKJVLLYa0c/c30XeBHBEhjDSrPnmK/4QhnzkOgvMqU6H5Jm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eg1VOmR7; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b04b55d5a2cso682860466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757926966; x=1758531766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ApShfXQF2Oi6G8dmAOghgnsvmVSLzQLwz5wXFZQiKw=;
        b=eg1VOmR7zShmn+hHiqoCSBy9ccujENIgSGAfLe204EOGU+XnJDTA3uYY8umymARXlN
         mJiY1n1EO+fP2t/Yv9+0vIPcSgNHdjRCF0a9bbhCFjuDH4rhR1sWlo30kRcfOH/R0OOI
         ICqhmxH2Vt+03zkTpaeq9H2WkOO2S4PO2l3Y0MrGiBlSLkqn74zgfRTD9/M6DEXBNfmT
         wEkZQ5AVpYlW77o1vaZxEo6SDDGHcAmb6wQ4JQ3BbUiWbFWqLJi7+KX48YYXrFQ8KKNL
         xEM3y9sv2DBW6OBq+2WGpC8ujzyJuGSMaN7LbOZ5S+PgKMdbuFfsqbIVQZS5XOptyuG3
         g7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757926966; x=1758531766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ApShfXQF2Oi6G8dmAOghgnsvmVSLzQLwz5wXFZQiKw=;
        b=WiG3sTCqCAuWVdtrUjF+N5Syqqm5lDA1OjLu/5sMpVcH5wZfotlcWfSgPiaDC7eW/J
         gyMe+9FK8spJSLg202grQUNCdb2WKdEAuHKZgknwajT/qD3QAxrBS9EqLzf+y6rYkvUB
         dFbB0UFgMHN7qWSR6TSkXMcMw7ZWl+EiCrliomOS56LOXMeXoCyZRxv39qc2Zfhfd0OB
         b7+bBol3JVHskeTZK4rGAe2SIPg1lCFjmZPwlxMoc+l830MO/u3vIDA6oD3BGTlKMJPA
         Ijow4K6q7TUtzxU7dL7RB2ZLM2Oq6yjGdLWofsNM6eMaHtg0gHUTp8xbzFc1YKeP70FL
         pIYg==
X-Forwarded-Encrypted: i=1; AJvYcCV7h6hShYcaub9UPv4rLpLRiNilr3Ku4WQjCdNxt/i4YwIPCjM5yssMcM/X28ETxOwwAmKBeSr8wnwLK1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRQX4QN+Mz+6ADhrwVOf36WAAFs92mqx8oTXdHbtge5ripW+9u
	KtWOYNXowPE3ZITP1xnJ0sd3f8wjZfWRbCebV2s+sR6JoMUN9FFUodR7fo4736pvIfw=
X-Gm-Gg: ASbGncsmL0feNr6L5zl1TEZpTXOB7W3EDsS2oLO38QaIRgT5tjCDPqrpxLFnCcCXzW/
	gv9stzXnCWBV5KIJv1DJh8IFToMSa4vjssGhbVS1MjrQ+OhSgwqbIrLaspmzjBku8D59srbqujn
	nbYc2upYAJMXQmf61FBNCznIRqxdpE52KOtrAfg1Alowwc2o2UJYY+0kw4w9mOKV5K1UfbDnzy4
	dtFJHfLqRJr+8BkTZBSPUl5PPglC0gb0aFaI9FGeKPSIC5HAPl3RESCoP8AxcYFku7m4Bo6WKBJ
	nQIvqtCubgcCg+Y41yN1e2TA7D8/4ft62NzvCVyFgAXSB+vvrsb6hubkdnK1Tofh1gciLm5p714
	FHgd2uT4/TM5xzmRKuR3tjDoIaFzpffNUFFLA6XXSkf4=
X-Google-Smtp-Source: AGHT+IFJqW4ATs8hpOqhKur7nNuySu2I9qWO2KqW58kjbzZTek7UpaV471VVvj9InZNl3XX07WRoUQ==
X-Received: by 2002:a17:907:86a0:b0:afc:a190:848a with SMTP id a640c23a62f3a-b07c3a78fb9mr1146716866b.60.1757926965242;
        Mon, 15 Sep 2025 02:02:45 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:ab20:75dc:ab3e:bbb9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07d2870da1sm574403366b.13.2025.09.15.02.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 02:02:44 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:02:34 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: fenglin.wu@oss.qualcomm.com
Cc: Sebastian Reichel <sre@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
	David Collins <david.collins@oss.qualcomm.com>,
	=?iso-8859-1?Q?Gy=F6rgy?= Kurucz <me@kuruczgy.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 5/8] power: supply: qcom_battmgr: update compats for
 SM8550 and X1E80100
Message-ID: <aMfWKobwM5bhJEAd@linaro.org>
References: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
 <20250915-qcom_battmgr_update-v4-5-6f6464a41afe@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-qcom_battmgr_update-v4-5-6f6464a41afe@oss.qualcomm.com>

On Mon, Sep 15, 2025 at 04:49:57PM +0800, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> 
> Add variant definitions for SM8550 and X1E80100 platforms. Add a compat
> for SM8550 and update match data for X1E80100 specifically so that they
> could be handled differently in supporting charge control functionality.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  drivers/power/supply/qcom_battmgr.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index 008e241e3eac3574a78459a2256e006e48c9f508..174d3f83ac2b070bb90c21a498686e91cc629ebe 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -19,8 +19,10 @@
>  #define BATTMGR_STRING_LEN	128
>  
>  enum qcom_battmgr_variant {
> -	QCOM_BATTMGR_SM8350,
>  	QCOM_BATTMGR_SC8280XP,
> +	QCOM_BATTMGR_SM8350,
> +	QCOM_BATTMGR_SM8550,
> +	QCOM_BATTMGR_X1E80100,
>  };
>  
>  #define BATTMGR_BAT_STATUS		0x1
> @@ -1333,7 +1335,8 @@ static void qcom_battmgr_pdr_notify(void *priv, int state)
>  static const struct of_device_id qcom_battmgr_of_variants[] = {
>  	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
>  	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
> -	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
> +	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8550 },
> +	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_X1E80100 },
>  	/* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
>  	{}
>  };

I think you need to squash this with "[PATCH 7/8] power: supply:
qcom_battmgr: Add charge control support", or move the modified checks
for

	if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
	    battmgr->variant == QCOM_BATTMGR_X1E80100) {

into this patch.

With this patch right now, I would expect that your series is not
bisectable: The wrong code paths are chosen if you only apply this patch
because e.g. X1E doesn't use the QCOM_BATTMGR_SC8280XP code anymore.

Thanks,
Stephan

