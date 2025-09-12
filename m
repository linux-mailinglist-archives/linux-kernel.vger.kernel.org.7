Return-Path: <linux-kernel+bounces-814203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 978D0B550B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F161C83224
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3E3314A94;
	Fri, 12 Sep 2025 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y7erqBjg"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F599313E16
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686490; cv=none; b=rTi6M0AOP7+f0I29VCOiIiWn23NtdaObjX+OP2DNnoSmKudHG6gZvTtTHSxPHY61BP8uFhGd2g1gqxlf3PFeMxZnQBJoeTp39JkaiyoBLB9qNchRcuJJ5Zj/RTBRzOkBONMAFrJCAsevDSUeAyXUs2FRzCRDI8tNsD2R2AZ/Fwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686490; c=relaxed/simple;
	bh=9sLEUiKxs4kaq/+VDmR5+jYAXaH2kN70zH8R7UU9LhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnF5GM5F78UlwQ4pdm+oAGE9+Ap0YqpoyHM9r6ryoF5kxsBBxuLQWYwiDRO21Du3bJLLGCNxSrPZEEkIlhOV1SkoTg5+Zhlb1b9PY5s/UUteAp1N3Di4PkPF/XnQYfQ+hlLTd9CxnzpsOEeaya0yotsPAKaEx42ZyZCCllCv8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y7erqBjg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445824dc27so16747745ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757686488; x=1758291288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KGHsIb+AKMqGJwrQY3RDFxGfsX+pej5gKpzkWT00FLc=;
        b=Y7erqBjgyfxCjtd1qGzlxnU5oJsSa4wkaXB9XUxMTJLWjRfd3XsLsZhJWdFhm6O0n1
         YzycUNRaPCpuwbeHVNxi7RzozIC9mhgXDUZB4cjhbVzQ1VZ4XjBlnqmRQx91dX0n7Kl3
         kNttUnPFXDNW+8Y0G6TSQ7onSaB9A/8AV8OImG45+WCJYh1otwWD0f6YeGczlUoshhCM
         zZloA1hCevk/mfZUnC+TJk+/pddDORt6afIc/n4gEyStmSzJF++BHY64d0oZwMR5xqmD
         49zoEu294Hu/WcUJM1RRgmEX4NhyNu1pyN9DAO3IL7nDwiaCsChLTKw8dVJCy1lZDNol
         g4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686488; x=1758291288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGHsIb+AKMqGJwrQY3RDFxGfsX+pej5gKpzkWT00FLc=;
        b=NplRceP45BqMnaajv8aQTx+8cWLsE+p0dkIRpZazcdPtrqj1EViogIgSWWAJloW/Vi
         RiQxkN9hsa260CUrZ9bsBeZRhxCg9Rv1D8XueRt2WV2Q8WmJpTpfnKRVyhjzC16CmM7n
         bS2kh5Cb28xvirdJPNezfbwOmtVyhu/HEm0og+8JsH5pjsk6j2P/tngEu4mhtjKAW5G1
         uiOU+2ZedqnipDHp3DB+gQnKha6qj5ENR1dMPxxEdRXyQYpOxpfmUbj4GmLY5TMntYJg
         3orlrxiTU4ivL+HGRAA/Lg9WXWknZeXzm4lNZj1+vK+jys5RMwniUNA6KxMT/oluJeHb
         vniw==
X-Forwarded-Encrypted: i=1; AJvYcCVnFiD2xg8HZdStsG4+DRX1uycedaGj1h8oEgS4nVSypWZAulpfEcsCSbTC7ik2KguTizEdFBmOLAcbmmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiQDFi9WBxANrrr1C0+QGBQU5kJ0DCf8oQ/zH6qj8l/V9A1TIL
	9AYbjYM/ikfCofpG0ZS96f11Bjs08jKdyF1pGavPEfk5yTFPolzPbdfWvM8QpsIxROw=
X-Gm-Gg: ASbGncv0ZurGogtk8EHVs4E6J/lGNap5UfWJTmtF2RYPfTOMOlpsOVor4s3ApQSX62o
	OrRiRY5Ik9SkFj55joDu5paXQk4c5I4pOUgClFJjOnK4AW2F6i7y0fwh4HY9ko6p0yR8KV+18oh
	R934BGZBCGm1/Sqk+d4GE3Yre7sHFjzsT8QsdiJr3cd6vXtOWgjn1kEBpbR/0xLV8L+6WPTNUkx
	N0KaeGndrhXCMdqes0Xg2MF8Jv7Y+PT5uGQodlueiwHF/3s6T11TEQRvtIAcLatZXV3cTW7x7yc
	2r6HRzoIlid6Ztfil7aADu8gZNBff5o3FBoXVrZkIemlX36MPxLMespI/oNNlCoUTeVNM+uv4yu
	FLDnWQM5AUuf7dQuTM3ZXR2hE2XElkEgEJRKckVV0Z3uHC4cPw6e2dlLocFyktwYPJsJmrfgQa9
	6z+vzJBXfET332Aa3oH1PthuoR3ni3dMKF+w==
X-Google-Smtp-Source: AGHT+IHHdJciNdadW46V/rsCGh0pPpDDjeLfRRykUe33Y24roFNgOG8c9J3Qxo6W5bSrO6GUGaOkXA==
X-Received: by 2002:a17:902:ce89:b0:25c:5747:4491 with SMTP id d9443c01a7336-25d26c4ab81mr39777925ad.46.1757686488456;
        Fri, 12 Sep 2025 07:14:48 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:650:9892:cdf9:70db])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b304f76sm49226035ad.130.2025.09.12.07.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:14:47 -0700 (PDT)
Date: Fri, 12 Sep 2025 08:14:45 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Frank Li <frank.li@nxp.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	"linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] remoteproc: imx_rproc: Clean up after ops
 introduction
Message-ID: <aMQq1SABdOMba_jB@p14s>
References: <20250910-imx-rproc-cleanup-v2-0-10386685b8a9@nxp.com>
 <20250910-imx-rproc-cleanup-v2-6-10386685b8a9@nxp.com>
 <aMGe/gwmFqjoFszg@lizhi-Precision-Tower-5810>
 <PAXPR04MB8459CABA152B6C1C122B35F28809A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250912061120.GA27864@nxa18884-linux.ap.freescale.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912061120.GA27864@nxa18884-linux.ap.freescale.net>

On Fri, Sep 12, 2025 at 02:11:20PM +0800, Peng Fan wrote:
> On Thu, Sep 11, 2025 at 01:13:59AM +0000, Peng Fan wrote:
> >Hi Frank,
> >> 
> >> Can you remove 'method' in data struct also?
> >
> >The method is used in other places and other purpose, imx_rproc_detach
> >imx_rproc_put_scu, imx_rproc_remove, it is also referred 
> >imx_dsp_rproc.c.
> >
> >Could we keep it for now?
> 
> The method could not be removed from the data structure, because it is also
> used in imx_dsp_rproc.c.
> 
> I have a few more patches to do further cleanup, but that would make
> the patchset a bit larger. I would like to see Mathieu's view.
> 
> Mathieu,
> 
> Do you expect me to add more patches in V3 to cleanup other parts or
> we could keep the patchset size as it is, with further cleanup in
> a standalone new patchset?
>

I think there is enough in this set.  I will look at it next week.
 
> Thanks,
> Peng.
> 
> 
> >
> >Thanks,
> >Peng.
> >
> >> 
> >> Frank
> >> > -	case IMX_RPROC_NONE:
> >> > +	/*
> >> > +	 * To i.MX{7,8} ULP, Linux is under control of RTOS, no need
> >> > +	 * dcfg->ops or dcfg->ops->detect_mode, it is state
> >> RPROC_DETACHED.
> >> > +	 */
> >> > +	if (!dcfg->ops || !dcfg->ops->detect_mode) {
> >> >  		priv->rproc->state = RPROC_DETACHED;
> >> >  		return 0;
> >> > -	default:
> >> > -		break;
> >> >  	}
> >> >
> >> > -	return 0;
> >> > +	return dcfg->ops->detect_mode(priv->rproc);
> >> >  }
> >> >
> >> >  static int imx_rproc_clk_enable(struct imx_rproc *priv)
> >> >
> >> > --
> >> > 2.37.1
> >> >

