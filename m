Return-Path: <linux-kernel+bounces-810638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30113B51D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FFC1C22BC9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD46832F76C;
	Wed, 10 Sep 2025 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JKWNZEoJ"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E10B34167D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520613; cv=none; b=eJZhbAvQDiqs82wiwxU1/0hrn5Ud1u1j3cgEMrccvvHVebqVuBL857o1s9cI36ltLVudJwSVs1ea+FUUgDA0/ll31gNLzo3qGm1xd1bLMruzT3y/E9y93ziwI6/MuBPaD62NzAP1X48w4NQ7N6P3s+tXxIfaVHDcXPjTcvCkhcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520613; c=relaxed/simple;
	bh=4kjxrxyFEb4K37j83q9FN9IoA1DrIJqo7dm0VgzSVBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgtV4jzubxuC5jX3lUVPt4ggIBsPr6liZ9VpSwZ5HPD1hm6HvlIf6a1qfOLCOAOBl2V8ziTHAFECOfilhUnwtWDP/vkTyYeSvTIPdToVpofpHGHfXR6kjl6okERAnPgCqXaPg+7IUQlzryFROGGHx71UHBWVmjgHPLwDeLLx/Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JKWNZEoJ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3e2055ce973so3790527f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757520610; x=1758125410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I9LI6s40pwmOAvNzLobzMUKZOm00biMObXADSvvCng4=;
        b=JKWNZEoJVRH7QXsWl/h0PWNypOh9OR/gEJ87BtjpDQYJc35HWI8OohX8NQ3xD6/SiG
         eKtI7Rur8lOp+I6G+vwpEAHuLqvD1f1LxQmK3P7ubW9mQapm2X6UGPXQy5eoxZjT1A4w
         8e1doqmxvlIOio2UX3UIW3xi5CXqznAVU/lkMLOo1zGMzeCFpMP7yh0QFmSRDs2rd1dW
         X2qS01Ky7Et1PW7lgbbj4q698oJ9f3e7+1/CYnup/wVKmQph1OS0PLqvFyvLGKdqMPCz
         94ddkwmNcFJXnqiSXK3jsFnd7/krLQSFuXJ+wu9EuFCLKDoQlzHOpRAPA+YyU4sh3LHp
         iLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520610; x=1758125410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9LI6s40pwmOAvNzLobzMUKZOm00biMObXADSvvCng4=;
        b=qfBgRBCh3WL5SGLCVazdb1/R8oCI173lWNxRRLHZcgdVzOQpU4jEi9Wx7dusttCpEd
         Qe/UPRGiHJXRuOWDIcgOWG9SnHmRYqQp8vpTfCpX/sAVruDgG0cFeuQWgtEWmnejKj2R
         dh6Mw0gqVJOfNYTqAothIXjLtlYH1WEn/902VgFK6p9KMC6pXWij/gjzqwg1DGp8fmJY
         VsBFvatGhd+X4qVeRq7zTq0okGW1iRIKzgrVxpIRUphX1eZr5x7DMnuaPTr+RlPdKzB6
         +naHMZgMEyNS4SPP6t88U+SLQ15WhgEF07znDvkQYkCXYtMhc1lPaEYroGDrIEVd+R5O
         V8Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWnP2B3ocI5iAnNjeOqg+hd7cou4Fqz9e/TwxxDUMukXmS6CapRzBd+y3rEsr4XV47Y8ViqRgqx5QkXedc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNkcm9/cc7Uierj8v9OzK4zGFEVe+869xC8x/SLcZpjrNehq18
	AeK+FIke6GIbUXAKM2UXlFdfgTht2kxvLoLatjTIiSh0+73Voq3PaZ8HMg1sTerpkN4=
X-Gm-Gg: ASbGncvSUa7E/N++iLKnDzQWWRPfOO7cYR5Gv1HL03eePLeQIMFVgWU53PcNmFbm9ik
	HJmXrSLJqB5Jhlh9afbmrv1Pwc8yy+h7x4IuNXThCd7CAmjiUtOVGOK0F6tsqnnZRcsxvhgD3+9
	hmWTxW8nDKttkxRrwe48YO2tfBEBCZp4ibBt4JZJ9/tVJo//me0bKQH/zsUdEJtipS8ux4Cifha
	2J3Irzje3P3I8eI0mB+19ei11T67emyiwfUY0vIVd7chae04/sMpvIZXh2AmEonFtBzCu74plvH
	Ie+q6x/bthWNVFbI/Sat7ERquvaYmtCu/HCKlRf72vsIP1PQRj2rEcVdSeLFuPD8pfDwcxlx81i
	eg82yPDMQlaLtR/YwvtZW012x+PI=
X-Google-Smtp-Source: AGHT+IE9glpLlh0ZXr1YlFRw69nZiN7PdFZT9NC7CNgw6KEShDJ8T0VtMfBa/BEPa2F5bWBlMU4Tpw==
X-Received: by 2002:a5d:5d82:0:b0:3df:a0f4:abc1 with SMTP id ffacd0b85a97d-3e6438373acmr12643107f8f.29.1757520609607;
        Wed, 10 Sep 2025 09:10:09 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e75223885csm7320979f8f.36.2025.09.10.09.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 09:10:08 -0700 (PDT)
Date: Wed, 10 Sep 2025 19:10:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, arm-scmi@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] firmware: imx: sm-misc: Dump syslog info
Message-ID: <aMGi3S2j_FHid3Sb@stanley.mountain>
References: <20250910-sm-syslog-v1-0-5b36f8f21da6@nxp.com>
 <20250910-sm-syslog-v1-2-5b36f8f21da6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-sm-syslog-v1-2-5b36f8f21da6@nxp.com>

On Wed, Sep 10, 2025 at 10:28:18PM +0800, Peng Fan wrote:
>  static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
>  {
>  	const struct scmi_handle *handle = sdev->handle;
>  	struct device_node *np = sdev->dev.of_node;
> +	struct dentry *scmi_imx_dentry;
>  	u32 src_id, flags;
>  	int ret, i, num;
>  
> @@ -98,6 +134,12 @@ static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
>  		}
>  	}
>  
> +	scmi_imx_dentry = debugfs_create_dir("scmi_imx", NULL);
> +	if (!IS_ERR(scmi_imx_dentry))
> +		debugfs_create_file("syslog", 0444, scmi_imx_dentry, &sdev->dev, &syslog_fops);

You don't need the IS_ERR() check.  If debugfs_create_dir() fails then
just pass the error pointer to debugfs_create_file(), it's fine.

regards,
dan carpenter

> +
> +	devm_add_action_or_reset(&sdev->dev, scmi_imx_misc_put, scmi_imx_dentry);
> +
>  	return 0;
>  }
>  
> 
> -- 
> 2.37.1
> 

