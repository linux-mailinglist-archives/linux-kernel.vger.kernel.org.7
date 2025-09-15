Return-Path: <linux-kernel+bounces-817420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE45B581F8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE93162D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C39F27A123;
	Mon, 15 Sep 2025 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vSqXKx1V"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE6D24DCE9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953643; cv=none; b=UbLvosjNCAqey39R77gSPhq91WEgyO9YMO3HdF+Pr+8hcyMro5Q3cy+Tnuf04PNdhuuJoYlFE87NK7b7VcIa/wmYwU9uaxIe9ginpBWKivWq4D87+yOmwqoDezqEXWb24gAA4ngA9zCxPVkM8LzkjE5P622W7KpR9FrlShR3Mnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953643; c=relaxed/simple;
	bh=0VlPIbvVpTDmLyoSfoRRRH9s5pOp0mu5ypKCH+mS90U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuU8tuv49Rfhex5ZpwJMU2X5LRRX+NXI+BJqxRNAPuQRlfS8GmhRttC7KBKbNg2ymyENXFUezx9h2qX3PYwUquWWOH9iJHgUbRLwtJtmUIbwH83M4jz+oanGPoZAiTW+7UqhfGhgrmqaUP99SD2+0fqin6WcKavG3XzHGh37eZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vSqXKx1V; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-261682fdfceso16863465ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757953641; x=1758558441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Wq0zL/Wc0Htkj+BfsfKHKvDwUIKed8MK8zTT8591bA=;
        b=vSqXKx1VHSHz+0QBCpVWHdLGieKtqFWF7jTW2OAivUPCEH31tREfQLOZFDc3EBoDXR
         nl7NZmm8zGYaZEGRBUofCnLlvQ5KUAAyamJA78JYgKDHlR8QayopY9XgU5NTMRHjJUks
         AERDIP1ySdy4MzQTWyo2GhFDyoTYvvoSUrZR/dCTzB7iDGaFipYyY/JEoou1BGuMgbDA
         DgLah2pGuyjLrF2xB270C0U1aMMKmFy23W7p5PBzZyH64k9/xM02KolABQ4Gm5a7knxw
         7fd37nBwBVVnRG56uUJG9js4AbyndNur5RAfh5MlITcyCxXHnutsa9rBLAdhJP7223AL
         ulTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953641; x=1758558441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Wq0zL/Wc0Htkj+BfsfKHKvDwUIKed8MK8zTT8591bA=;
        b=cw+m7K3csS1XbzpzyCj8VwKF2KZcgRt8/pR4iKhjsGaNC7qL0GBuJF3XVlC4OB2WC0
         FRURLNRfyCIzu5qvI7huI1Pzo7RMK5WrKSXz4rQgk9CJ9oGYNcdF708n1XYyh+buU2wU
         dsB2Wu6X/ZOvJugV+rHiMK5txFbgSutU6rQ3IxlzJy3eDPUEh7LutFRP/1psafd35pti
         zbpG9n5ySjgfmod+vVRG576JoiZNSjuRBFp7hxjF5D2EK1ngRtjlxLS/Wg19FylKW/j5
         sFTmS+B43BWxSrvqoOaoiARvroCgSa/b7muoEpEvSpatgBA5w0VmkaGSWUWjeB8kElQi
         42Ag==
X-Forwarded-Encrypted: i=1; AJvYcCW7LmyJqnRGQBoC7gULq7cya9+9u+8VEBnPXvkkE3YwGEj2sMEBE0R0prmzLLkaMayBNlS9B3diNQAPWcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2YOfHh69peE7Em8kc798Ok7IjJLuJ79wkE4o8dpe4CvpSabML
	Njo7Nm9Ng3Yfq1s/HDYjhId2Jp8nhMAsB7icxRD56v0Fd+B21OcpuUaIa8FOweIsp4E=
X-Gm-Gg: ASbGncuko9CT39PNKf5oC/90+YEt42KxVwarIVLH1I8tL1qb+jiDwABSF0jmrNiTCyR
	H7tgESd4ggMVVbZccm1xMJDXUB0QA6LKf6WAuY1Uh0whIlAyTFJmN9nI+UNZVJgcw/707vj3mVR
	VBbggT1cUL61frbUM+tErhQK6yGYlmgckIhQT+3PWsFSyaFcYfC28LjOCsDpxlR2PTmpacu1hs8
	Ll9cNZnFIB1xgc38aKrejol4hpPjgjk0VgRZD7M/KkA9oIQ6qVVzqFDA0k+p1Zm0lTZCHcBsNsA
	YMjNqv2h6e+H6D+dWtZVbySghvqXa79z/dOX2ULqtM3Zz0y/T+bguJxVH6CeKLiOSZu+gpNwzY7
	DYecPbviBjt2xw7Z6P/dQ0xGtPR9CV4gFPvUES1NNvQOIOqC8M8UziB4pXh/Ath/xb1fvg3ZxWg
	wXCXabOWfIUJtWJ6A/mOMUokONgBtfHNDzwg==
X-Google-Smtp-Source: AGHT+IH31zRCUDSkqS9JLKhdPK0Ywp1tQqr2PiZwav0DNP7t0zDxlTNym5N+G+H44epmJz9G3i3bdg==
X-Received: by 2002:a17:903:41c1:b0:262:3e45:4c88 with SMTP id d9443c01a7336-2623e454f01mr114037935ad.18.1757953641028;
        Mon, 15 Sep 2025 09:27:21 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:67c:a85d:f066:9008])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267a1d2eccdsm22392055ad.97.2025.09.15.09.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:27:20 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:27:18 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>, Frank Li <frank.li@nxp.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] remoteproc: imx_proc: Simplify driver by removing
 the switch-case
Message-ID: <aMg-Zg6juddLZwfO@p14s>
References: <20250910-imx-rproc-cleanup-v2-0-10386685b8a9@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-imx-rproc-cleanup-v2-0-10386685b8a9@nxp.com>

On Wed, Sep 10, 2025 at 03:11:44PM +0800, Peng Fan wrote:
> This patchset serves as a preparing patchset for i.MX95 support.
> 
> The current code logic is complicated, with mix the usage of switch-case
> and if-else.
> 
> To simplify the code logic:
>  Introduce struct imx_rproc_plat_ops to wrap platform start,stop,detect_mode.
>  Each imx_rproc_dcfg data structure is assigned a ops pointer.
>  The common imx_rproc_{start,stop}() directly invokes the plat ops, no
>  need the switch-case.
>  mmio/smc/scu_api ops are included.
>  No functional changes.
> 
> Thanks to Daniel and Frank for the help.
> 
> Test on i.MX8MM for MMIO ops, i.MX8MP for SMC ops, i.MX8QM for SCU-API ops.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Changes in v2:
> - Simplify the if/else in patch 6 per Frank and Mathieu
> - Add R-b from Daniel and Frank.
> - Link to v1: https://lore.kernel.org/r/20250908-imx-rproc-cleanup-v1-0-e838cb14436c@nxp.com
> 
> ---
> Peng Fan (6):
>       remoteproc: imx_rproc: Introduce start/stop/detect_mode ops for imx_rproc_dcfg
>       remoteproc: imx_rproc: Move imx_rproc_dcfg closer to imx_rproc_of_match
>       remoteproc: imx_rproc: Simplify IMX_RPROC_MMIO switch case
>       remoteproc: imx_rproc: Simplify IMX_RPROC_SCU_API switch case
>       remoteproc: imx_rproc: Simplify IMX_RPROC_SMC switch case
>       remoteproc: imx_rproc: Clean up after ops introduction
> 
>  drivers/remoteproc/imx_rproc.c | 449 +++++++++++++++++++++++------------------
>  drivers/remoteproc/imx_rproc.h |   7 +
>  2 files changed, 265 insertions(+), 191 deletions(-)

I have applied this set.

Thanks,
Mathieu

> ---
> base-commit: 3e8e5822146bc396d2a7e5fbb7be13271665522a
> change-id: 20250908-imx-rproc-cleanup-6f3b546b9fdf
> 
> Best regards,
> -- 
> Peng Fan <peng.fan@nxp.com>
> 

