Return-Path: <linux-kernel+bounces-892069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D212C44488
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 18:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF923ABA75
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 17:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823433093CA;
	Sun,  9 Nov 2025 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="tlf32Vm4"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A573090D2
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762708975; cv=none; b=suq/Wcp+/dcCxc/rGZ4DFgONlvfc5fpoGqXinfjED1eHJwQ1zL0MJf+TYeE+n9ETColiV2oyxHAheI+jA8WJhUX971bbAO+iGfU3d/+SA7YWhSrHE8OeRKkQWiPXfAoiwPFpQxPEn/mU3M3Bgdf1aCaG9GwM0sJ0CZnN8kTFvlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762708975; c=relaxed/simple;
	bh=8xrRb4Ja7YDYCikqkpnM1+9xLkErGoSE0Ilyg3K603U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cJlyVXm5QLNN6k3Y7SD9cPc/2PXk3hxRuILiihKoXVu23fclMKT4Hg2SPqaCK5Ei4WInq8OVa/uGqoosXQREqvVUwvoPCVK/sfEzzKo6cGH47a9WC2MR6XChGYnG5npM2hIfhzZZWwPGJ1KQdnqcISWagMf/dq7JhCRxwpOK5uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=tlf32Vm4; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso3919469a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 09:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1762708972; x=1763313772; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7u5viM8iOHpulamZW8Yl5pjwnfS/F/QVQpeIUIajsE=;
        b=tlf32Vm4NVrasKbkE996+Mj6XQVE03iUa6BZr/4GVFSrrOzf3ZgZdS0WAMnZw++XHF
         wPAmk7eAJNPJSm8b9OfBtOjhyVHnYWFl+Q78i/d/WyVjXGOcMz8PNpar9PYBq6dP0+aa
         el5n5PPNIQpi4CSO92ADIdilnEVstRU2D/PH8dmGQYeVO/PVWP/yVAjg+U3kAlyB2wqR
         xHHRnazDTd7x3VviVzdyGH1a/mQw6NJ/xm6RJ70TGzKyYI+EdfBPb3G9VRzTLgfcVfLo
         7GKfazWZWyc/lEa0gNbGh6VeOLO/TB9YDYIo2I/UxD1zTGmnqCtIJrJHkJFF5pB2+Nll
         2/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762708972; x=1763313772;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a7u5viM8iOHpulamZW8Yl5pjwnfS/F/QVQpeIUIajsE=;
        b=A9QN5O8Z5JwKZHupBqgK3xabPSx+OOlZKNYA1jLoHtQ9JpnAsE6KzRLRMuZrh7CjhG
         eqIUFZJJbz+Yd+0rWZDELdvkd1gfq4vPP9K3AggMzw4g1MK4CppvSvqssd1Bp1ZRuEag
         //Wq7bias1QCE11E3CZzasRhZ1sFX9DhMk8QlH6JaNPx/4XIg6MFcpahliiLoVeEDYff
         Y0RzwPgt/3pP0NJ6QYH/HTq+MzQmhNxmUvo2brsBF2GLwLRo+p64X+fceJddd2cfZccy
         7ZTOhz26y21z8essf+0PNTrRjr8i1qmfSIthRYf83ySTTIorPPcbokJQdJuyM9fPde8n
         2/EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuQQDsF8b6GtW0DezLRvLTKBbjrmH9Qfi9uN8KKPA3cNnHP+nboPONgs7FNLB2vLgTp/ZfJgBFye8J/mU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/WcBOI0FvWA7fEkrzdRz4vFsRlcox/qZZ9ltuFQ4qxHB41pPK
	Tb826KsplRf7x3AFGD/S1C8fxMNuKHFMvE9hBNR2THhdaynbtuttpSXDn8xn0y4HaEc=
X-Gm-Gg: ASbGncvGPrzzd78mhNIE880JZf7iEa41+Hhf4o0kfM5wN0BY1j/w0Gk1kUJ5qOArryQ
	MyorfeV7SZVNpLLbqOAKijKnzf1HkD1jXlXsnyPp6UsFW9yDi6Ha3bAzMtXk95YBYw0w6vwn0AH
	ZZRRggOk152eqd8WrgWjU0X6m1JguqeycRmtMzHOXlGITI2s9ixe7ulTAwP4hw3j5iunR5VGrQ8
	YZKOkp+XZeVS8OB89aFGAu7dCvx7Z7UrfMntDEapn46Y/NwBswRIrNaRpPjXLSi3f2bfLFG9PBT
	33xe4I83AfeVBIbo1s6DC5OfKNaoAvJMHClARPdL2W2rg7C5qk657DMHtdWjF6vNw7oYldsbMyj
	4x0iCeDrkUCr/ukd9oT8DH7fthkQhUdZhh44eruVUEIXKjeoXewHeoePs1KdD8puL7/7cV+AYKZ
	nZCUnsjcPl1rPrfOloqoUJmmA5ySlRDOiU440xJHag9XQCzwbNJyIboawF6AugCIuUOKPSEmwFZ
	RqoDHI0XT8j4aUQw1cM351GS6QAYp821u4=
X-Google-Smtp-Source: AGHT+IHiNx88guNnogcxy/ePccl6T4u99WrAa4tO6dTyzZ7pWo9gTArz9LqZTlbTuW3AfvNrVuFznA==
X-Received: by 2002:a05:6402:3546:b0:640:f974:7629 with SMTP id 4fb4d7f45d1cf-6415dc205e6mr4941873a12.15.1762708971341;
        Sun, 09 Nov 2025 09:22:51 -0800 (PST)
Received: from localhost (2001-1c00-3b8a-ea00-c4de-d39d-05f4-c77a.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b8a:ea00:c4de:d39d:5f4:c77a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6415d91f486sm4786157a12.22.2025.11.09.09.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 09:22:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 09 Nov 2025 18:22:50 +0100
Message-Id: <DE4C6HV76V5M.1I1NJB2JCK1LN@fairphone.com>
Cc: "Joel Selvaraj" <foss@joelselvaraj.com>, <linux-media@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <phone-devel@vger.kernel.org>
Subject: Re: [PATCH RFC 8/8] media: qcom: camss: Remove D-PHY-only endpoint
 restriction
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: <david@ixit.cz>, "Robert Foss" <rfoss@kernel.org>, "Todor Tomov"
 <todor.too@gmail.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
 "Vladimir Zapolskiy" <vladimir.zapolskiy@linaro.org>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, "Luca Weiss" <luca.weiss@fairphone.com>,
 "Petr Hodina" <phodina@protonmail.com>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Dr. Git" <drgitx@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251109-qcom-cphy-v1-0-165f7e79b0e1@ixit.cz>
 <20251109-qcom-cphy-v1-8-165f7e79b0e1@ixit.cz>
In-Reply-To: <20251109-qcom-cphy-v1-8-165f7e79b0e1@ixit.cz>

On Sun Nov 9, 2025 at 10:39 AM CET, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
>
> C-PHY mode is now supported, so the endpoint bus-type restriction to
> D-PHY can be removed.
>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/media/platform/qcom/camss/camss.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/pl=
atform/qcom/camss/camss.c
> index 248aa6b21b5ad..1408e8a03f0bd 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -4044,15 +4044,6 @@ static int camss_of_parse_endpoint_node(struct dev=
ice *dev,
>  	if (ret)
>  		return ret;
> =20
> -	/*
> -	 * Most SoCs support both D-PHY and C-PHY standards, but currently only
> -	 * D-PHY is supported in the driver.
> -	 */
> -	if (vep.bus_type !=3D V4L2_MBUS_CSI2_DPHY) {

How about just adding && !=3D V4L2_MBUS_CSI2_CPHY to it? Good to check in
any case imo.

Regards
Luca

> -		dev_err(dev, "Unsupported bus type %d\n", vep.bus_type);
> -		return -EINVAL;
> -	}
> -
>  	csd->interface.csiphy_id =3D vep.base.port;
> =20
>  	mipi_csi2 =3D &vep.bus.mipi_csi2;


