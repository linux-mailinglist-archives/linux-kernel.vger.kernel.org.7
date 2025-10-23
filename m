Return-Path: <linux-kernel+bounces-866926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3E3C010EC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237753A312B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5BF31353B;
	Thu, 23 Oct 2025 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TxiNeiuB"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E502F6192
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221852; cv=none; b=fX+8+fYfUcEQB7Sv9RKOv7jQ/BWluY+nUCNE3OYHoOuEUlkur3/jvMs46WdWXKVr5tHc2wUP2vdhPYG51Isl+WOXhkG/HBPQ4Odb+Wq/gvALElEhaTg1ErkLV/OFw0qNpteYb2ZPTvIHTmQu4FZbsI4oME5SBvebWD9Ntfpa9R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221852; c=relaxed/simple;
	bh=L9mKMLdO9ecZLnnTb3rf9vDnZa5Hpnlr0lpYglBohUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkN4slYAY8/n7oE40x4QmjOoTIZOTdncwniQigF4KhzFg95UnST2xx6mfGmU9vX8qXqELhzLzsM4jqqZY2VepO9npRrEr4EaJ+iCu5ub+7OlG4jOs4ms0KI8hphvmTKyfX+oDhAtxmLS4xwO2abAq6yFZUMmTTempYafcE3jy+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TxiNeiuB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47114a40161so7378705e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761221845; x=1761826645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xFaK6NZGo+5ymm+luUg7lb2XRBY37/W/zcfA+CV0TIg=;
        b=TxiNeiuBsMjIBd7XafBrQREloLoW1u8pXhvS6dJaJ29cZgxVi1nYTG0IneDhmkKf2X
         yxzTWw0mxyrdF8q9p8hWVZvsN6sdQFFst8033eGrrBnioq9bbunvizht+xfYmMv8yjI4
         LWQ/SYBnvNNVq8+mCiC4HdL/ogoyLTf3SHUtxbea5H6apLARN8FFNOGXWgwz5whst7DG
         D+q1IPoYpg9s7yGpPE8bGdavGqa9ut4l7CUjNNkx8Puptvu/+jRyJVOg3bePgVtjcwYG
         lJaZ2ZHuay66fL+7Tc8BssAZH3uEBmY2uguhjSEdQQJYXp7plMZXUXBwg7uYAYy8fBVE
         PZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761221845; x=1761826645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFaK6NZGo+5ymm+luUg7lb2XRBY37/W/zcfA+CV0TIg=;
        b=EQQL8S1vLAaJ0mPY1kpm8ga4NsrB8IAKJaDCcCxIUEVMQQhmey/IDu83EO51nNhTkg
         LkF5nMf/+g4ZmrxndooEx+C0pMcbCsIewF8x9FtCuOPq3Eb/nrSLSeD+uXbA/zh/WLwG
         UGEz8xfmKUhy2ggakxt1BwNzFXElGYJkI3Zi3Q9P/AG1w4G5yTvjOaA3vjt+fVqKHJqk
         3qk4B142v82Im/ceViEu+Rmgj29K0TGomXhegUJtR/X48HUjGgKnvDWjByRbJ01mKiFO
         35MZM/CO+6NTfOpQVjj0cykj5HvItzOKjB1hy2dcwUUUhfgl0Qwds+PHaktCRGfIzxru
         AVoA==
X-Forwarded-Encrypted: i=1; AJvYcCUQclF3OfvmoxeaF2w0hjLQ2V6cqK6jGvCS0uK9FtfDvTmgcvgFgVeIqgmJCWDa1E1ugNsuDwx60j2rYl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo6c4xlRu/GeTxCSc28Dpscak1z774+AAJqVQYUTI3XcDCA/jn
	YicrpImqcr/T922Inkt7FhhVpH8miXfYLoHruQSdLAiFDWvbiQYRAYbrr1jTPfbm3E4=
X-Gm-Gg: ASbGncsSLfkg2ZhDJQZwZE6UVfwlSH92UZSb12JrMZ99JXffvU67qYB6NAiRuXRu4h3
	ly8Ll9wjilmb7LxD6dpyjRIa9Fb/XYVXaW3UO+uwcGXmb7mNRJJ6QpxMkx8dxmkGtsoivKeezcF
	G2I5ncO6fQl4x2xPFdEM11iGg6sf0sa1bldGkG89F4yz354mjl2wR4A99lXuc59M40SDDcodbeL
	62Whceqsj1E3FQxvjlb06jH4dMsUEcqtflrCmeA5ZpaRJC0NxyN5keO0Kh3GRxtgDYU4/cfAkJr
	g4zSIJ+aF/O3hrzT7pbSVbqVNfFuu+PTyqM2B8H+d3MhLer3VPN4zk7dwGKcpOMy/NdmA+nDt3f
	sNH9Vcdp+Ysx8PDJC67EtzhaZqeMuqGjrJ3UYcKyNVlm6jFFuoFSGQdCbXe4aMHYFgCi/BS4W
X-Google-Smtp-Source: AGHT+IE4yJGL4XD1Y008GBekdf0k/4ZgBeS/2HKOoU8UbmPIZ1qtosiAH1bXdFg2PJCJM3E73unoRQ==
X-Received: by 2002:a05:600c:5009:b0:46e:50ce:a353 with SMTP id 5b1f17b1804b1-471178788f0mr170316305e9.14.1761221845468;
        Thu, 23 Oct 2025 05:17:25 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f685sm96429725e9.2.2025.10.23.05.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:17:24 -0700 (PDT)
Date: Thu, 23 Oct 2025 15:17:22 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com, 
	quic_pragalla@quicinc.com, quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com, 
	quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
Subject: Re: [PATCH V2 4/4] arm64: dts: qcom: sm8750-qrd: Add SDC2 node for
 sm8750 qrd board
Message-ID: <ekyi4yreec55m5huqnfm7vqo3kgqgquvcmw4budgzolx32mfiq@lodlzpic4bdr>
References: <20251023112924.1073811-1-sarthak.garg@oss.qualcomm.com>
 <20251023112924.1073811-5-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023112924.1073811-5-sarthak.garg@oss.qualcomm.com>

On 25-10-23 16:59:24, Sarthak Garg wrote:
> Enable SD Card host controller for sm8750 qrd board.
> 
> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
> ---

again, with the card detect gpio in here, looks good to me:

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

