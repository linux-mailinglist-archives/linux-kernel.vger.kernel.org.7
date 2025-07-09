Return-Path: <linux-kernel+bounces-723888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E58AAFEC0B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A234E1433
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF102E5437;
	Wed,  9 Jul 2025 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QRucI/3W"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442C12E3AFC
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071515; cv=none; b=EsMMnp9pEmSD/V9L/g/jOgwRA3YKEEwObJp1cSBHoPbPTjGgKYl/6XvD45BoTNNDZ5vfzTq+3TRVDSXOKtcC/6fIeOu4Vmfx2GBcpZGtpzGU2aKEdZZNtSNSxeyFoDNm0yJ+q7Rb7AFS1UQPmr87siTbaSCGCDfOV1WZClkag9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071515; c=relaxed/simple;
	bh=7BtyFzEqdQqk9noBz1kWPn+TluwkrsvSZ+NX6r1NPy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1TD/HI0hNwmlHDRY9DUf66i6T6R9iIdwoc3WQixQdDTvqz4zKFssETiEKiwJol8mgufPUsb6MSxSEoajjl+xn1JlM2jJw51pzQ+l1FAM1lHnz33R2wqhBwt95qsgcyyv2z+/Rq9vJNoQag5t6KHBr7FMl8g+q9N3A/NxFgOuUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QRucI/3W; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235ea292956so49778575ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752071511; x=1752676311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ob8aeY+0rAZIUvRDNkYhpVzGwYIQJmUrDC32TtGUBQ=;
        b=QRucI/3WBEtNj1PSIQIauasDHPn2O4fo8LLJjA+XPGhGt+ImNgcEbisP/qnnkr0Exj
         u+9buuKv5qJSvhF52m8zrjDddUFtQ6ZS8E+ocITf0m1FJNWJ5NirmtZOifjyn12zwQcj
         QLE5OG+K56uose3LsboeCIZsptZ4Yt7P6DLjcdnEGP1rB+FfCyLQ9E/O0s1IbXu0io42
         QazjadAeYA4ZOCx3ijUxAN9ejuDW4gArXMfQ7XneFXJQzGIvTR7R/l5PozeKNMLT3j93
         PMB1tryl2ylR+gNeooe38SmImDRQT9NOB+/hisLh9w8zlhy85maDJzLFPTz4L084Ee4Z
         fkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752071511; x=1752676311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ob8aeY+0rAZIUvRDNkYhpVzGwYIQJmUrDC32TtGUBQ=;
        b=d67CzclpucDpir/OYQh4hAvQmIDTt06ZHIZut97UGZEZqNUKgTgAQNScD6K9UIqEZ0
         GJ9mWY28qd7vah3jFvT+bxAqdApsNRjb3MVIt0rIg4oK0MUf8ws7vUpG3F5Rn3db4C17
         lQJB3mgRCiDOZTa4p7aJ3+C5+huzgC192LMp4U/w0RKisFDmyuyJwG2jn+e0RGEwRMm4
         HibMmS0/JpkBJWMBLt3aXyDWvT3vrEzAvgZZPVwkU0CLwhTBNUQizcpWiJOpYO/Mp1eT
         AfvQG1XXtg89tBWdMQtSLQtc/WUI6HCvhVRtJZyn8kO9z6nzjJwLL1AU4iwJXozY77yO
         z07A==
X-Forwarded-Encrypted: i=1; AJvYcCVyuZkNzZOC1OfFBBE/yTzdcWcRJdG28NS3acfbxfWzoUrQ5pz4kE3c1aZuPX2mJVWqTe1RdZnqFdmqNcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy63ViU0c0eOmf3LnNrL5iQUnik7qZC/rQ2W3uI+wGSPA21ebox
	UwLqA53QcgtBjdWL32tTZhz+7u2nMU7ivur8IDHSnfe7iu0Mcwb4oyQVSF//6Bj6J1Q=
X-Gm-Gg: ASbGnctGrLB+skyCU++qWOPNatpURpeNurNZhEajvI+niVWyZsk8D/W1T8fIiebCVRz
	qBFT+hTQ8+m0GdkoaCxEz2imw16W4nFI5ykujIZ+nagqOA8KOBheujlwkRIlCm939THI1OcN+eH
	A3+mFgXoffLT1GG4F4Wbo2QKqG/LeS8+sdeeBYsHTqYB8rGC6UqgqNItkgnSZb9XEAfV/IP1LdD
	wuky6/W2hIdxbPU0CmKgXonMl/d0T80ByXrY/x9QzLDDFqbQCJa8DaCXlJG2WdrWGRdag0GQSnA
	jZ4sV9IijdjB/tovGfbr4IfbPc4nsQag4pir4kHZwrRE1av+MrvEl7e5guaCF2UK
X-Google-Smtp-Source: AGHT+IEXpbvwTdHDHQUcQtVRwNjYawEjvuYkoQ5Xje633BngDr3uR9fCxc8nAve+MqnqlBJ1YgrlwQ==
X-Received: by 2002:a17:902:e80d:b0:234:adce:3ece with SMTP id d9443c01a7336-23ddb199277mr35277255ad.11.1752071511405;
        Wed, 09 Jul 2025 07:31:51 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:433:ec07:c2cb:e3e8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845bcf0fsm136242895ad.249.2025.07.09.07.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:31:50 -0700 (PDT)
Date: Wed, 9 Jul 2025 08:31:48 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3 3/5] remoteproc: imx_rproc: Add support for i.MX95
Message-ID: <aG59VPhYY5deFo_h@p14s>
References: <20250625-imx95-rproc-1-v3-0-699031f5926d@nxp.com>
 <20250625-imx95-rproc-1-v3-3-699031f5926d@nxp.com>
 <aG1J2_nK-LkLQVRj@p14s>
 <20250709074940.GA14535@nxa18884-linux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709074940.GA14535@nxa18884-linux>

On Wed, Jul 09, 2025 at 03:49:40PM +0800, Peng Fan wrote:
> Hi Mathieu,
> 
> On Tue, Jul 08, 2025 at 10:39:55AM -0600, Mathieu Poirier wrote:
> >On Wed, Jun 25, 2025 at 10:23:29AM +0800, Peng Fan (OSS) wrote:
> >> From: Peng Fan <peng.fan@nxp.com>
> >> 
> >> Add imx_rproc_cfg_imx95_m7 and address(TCM and DDR) mapping.
> >> Add i.MX95 of_device_id entry.
> >> 
> >> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >> ---
> >>  drivers/remoteproc/imx_rproc.c | 25 +++++++++++++++++++++++++
> >>  1 file changed, 25 insertions(+)
> >> 
> >> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> >> index b1a117ca5e5795554b67eb7092db2a25fc7de13b..c226f78c84ad180c69804116d6cfcab19db6aaa5 100644
> >> --- a/drivers/remoteproc/imx_rproc.c
> >> +++ b/drivers/remoteproc/imx_rproc.c
> >> @@ -73,6 +73,10 @@
> >>  
> >>  #define IMX_SC_IRQ_GROUP_REBOOTED	5
> >>  
> >> +/* Must align with System Manager Firmware */
> >> +#define IMX95_M7_CPUID			1
> >> +#define IMX95_M7_LMID			1
> >
> >Any reason those aren't set in the device tree?
> 
> Krzysztof rejected to introduce the IDs to devicetree.
> 
> From IRC:
> "To me this makes no sense in current explanayton - you have 8 cores, but only
> one can be put there, so what happens with the rest?
> And I don't think we care about something like remote and local ID - it is
> the same. CPUs have single number. So this looks like copy paste downstream
> and thus solve it internally first"
> 
> 
> In System Manager Firmware, CPUID is fixed and will not change.
> LMID is also fixed as of now, we not expect customer to change LMID.
> 
> So with "fsl,imx95-m7", we could know the CPUID and LMID for M7, so 
> it does not make sense to introduce new property saying "fsl,imx95-lmid"
> and "fsl,imx95-cpuid". This should be the main concern that DT maintainers
> reject to add properties for the IDs.
>

Ok
 
> Thanks,
> Peng
> 
> >
> >Thanks,
> >Mathieu
> >

